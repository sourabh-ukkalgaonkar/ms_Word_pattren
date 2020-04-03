# frozen_string_literal: true

input = [
  { id: 1, title: 'heading1', heading_level: 0 },
  { id: 2, title: 'heading2', heading_level: 2 },
  { id: 3, title: 'heading3', heading_level: 1 },
  { id: 4, title: 'heading4', heading_level: 1 }
]

class MsWordPattern
  def initialize(records)
    @records = records
    @main_heading = 0
    @heading_levels = []
  end

  def convert
    @records.each do |record|
      if @heading_levels[record[:heading_level]].nil?
        @heading_levels[record[:heading_level]] = 1
        (0..record[:heading_level]).each do |i|
          @heading_levels[i] = 1 if @heading_levels[i].nil?
        end
      else
        @heading_levels[record[:heading_level]] += 1
      end

      puts "#{index(record[:heading_level])} #{record[:title]}"
    end
  end

  def index(level)
    str = ''
    (0..level).each do |i|
      value = @heading_levels[i].nil? ? 1 : @heading_levels[i]
      str += value.to_s + '.'
    end
    (0..(level - 1)).each { |_i| str = "\t" + str }
    str
  end
end

mwp = MsWordPattern.new(input)
mwp.convert
