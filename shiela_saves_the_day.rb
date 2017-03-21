
require "gosu"

class Sprite
	def initialize window
		@window = window
		@width = @height = 160
		@idle = Gosu::Image.load_tiles @window, 
										"shiela_idle.png",
										@width, @height, true
		@move = Gosu::Image.load_tiles @window,
										"shiela_walks.png",
										@width, @height, true
		@x = @window.width/2 - @width/2
		@y = @window.height/2 - @height/2
		@direction = :right
		@frame = 0
		@moving = false
	end

	def update
		@frame += 1
		@moving = false
		if @window.button_down? Gosu::KbLeft
			@direction = :left
			@moving = true
			@x += -5
		end
		if @window.button_down? Gosu::KbRight
			@direction = :right
			@moving = true
			@x += 5
		end
	end

	def draw
		f = @frame % @idle.size

		if @moving == true
			image = @move[f]
		else
			image = @idle[f]
		end

		if @direction == :right
			image.draw @x + @width, @y, 1, -1, 1
		else
			image.draw @x, @y, 1, 1, 1
		end 
	end


end

class SpriteGame < Gosu::Window
def initialize width = 800, height=600, full=false
	super
	self.caption = "Sprite Demonstration"
	@sprite = Sprite.new self
	end

	def button_down id
		close if id == Gosu::KbEscape
	end

	def update
		@sprite.update
	end

	def draw
		@sprite.draw
	end

end

SpriteGame.new.show

