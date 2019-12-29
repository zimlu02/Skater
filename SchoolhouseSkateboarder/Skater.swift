//
//  Skater.swift
//  SchoolhouseSkateboarder
//
//  Created by david kopp on 14/12/19.
//  Copyright © 2019 david kopp. All rights reserved.
//

import SpriteKit

class Skater: SKSpriteNode {
    
    var velocity = CGPoint.zero
    var minimumY: CGFloat = 0.0
    var jumpSpeed: CGFloat = 30.0 // modified
    var isOnGround = true
    
    // setup physics body based on skater's texture
    func setupPhysicsBody() {
        if let skaterTexture = texture {
            physicsBody = SKPhysicsBody(texture: skaterTexture, size: size)
            physicsBody?.isDynamic = true
            physicsBody?.density = 7.0 // density - how heavy something is for its size
            physicsBody?.allowsRotation = false
            physicsBody?.angularDamping = 1.0 // how much this physics body resists rotating
            
            physicsBody?.categoryBitMask = PhysicsCategory.skater
            physicsBody?.collisionBitMask = PhysicsCategory.brick
            physicsBody?.contactTestBitMask = PhysicsCategory.brick | PhysicsCategory.gem
        }
    }
    
    func createSparks() {
        
        // find the sparks emitter file in the projects bundle
        let bundle = Bundle.main
        
        if let sparksPath = bundle.path(forResource: "sparks", ofType: "sks") {
            
            // create a sparks emmiter node
        let sparksNode = NSKeyedUnarchiver.unarchiveObject (withFile: sparksPath) as! SKEmitterNode
            sparksNode.position = CGPoint(x: 0.0, y: -50.0)
            addChild(sparksNode)
            
        // run an action to wait half a second and then remove the emitter
            let waitAction = SKAction.wait(forDuration: 0.5)
            let removeAction = SKAction.removeFromParent()
            let waitThenRemove = SKAction.sequence([waitAction, removeAction])
            
            sparksNode.run(waitThenRemove)
        }
    }
}
