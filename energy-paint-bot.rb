# Function to read directions from a file
def read_directions(filename)
    directions = []
    begin
        File.open(filename, 'r') do |file|
            file.each_line do |line|
                directions << line.strip
            end
        end
    rescue Errno::ENOENT
        puts "File Not Found!"
        exit(1)
    rescue => exception
        puts "Error while accessing the file :: #{exception.message}"
        exit(1)
    end
    directions
end

# Function to calculate painted spaces
def calculate_painted_spaces(directions)
    position = [0, 0]
    key_hash = {"up" => [-1, 0], "down" => [1, 0], "left" => [0, -1], "right" => [0, 1]}
    painted_spaces = []

    directions.each do |direction|
        step = key_hash[direction]

        # Error handling on Invalid direction key
        if step.nil?
            puts "Invalid direction!"
            exit(1)
        end

        position = [position[0] + step[0], position[1] + step[1]]
        painted_spaces << position
    end
    [position, painted_spaces.uniq.size]
end

# Main part of the program
filename = ARGV[0]
directions = read_directions(filename)

if directions.empty?
    puts "No directions found in the file. Exiting."
    exit(0)
else
    final_position, painted_spaces_count = calculate_painted_spaces(directions)
    puts "The final position of the robot :: #{final_position}"
    puts "The number of painted spaces is :: #{painted_spaces_count}"
end
  