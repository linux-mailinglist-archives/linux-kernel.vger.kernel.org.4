Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67169E2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjBUO5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjBUO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:57:51 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95F52B2BB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YZVoitn0OFerkZtEiNKLmfmcZma5QZExWfyuh2Zh4dU=; b=o1yCex2N6LhDp7LJNRbO1V6Ym+
        mDXJPQOhxIzXe8yEgo6HyxydRsqxzar/1cK72N5sAn0YBgt4oBz6V5zOXYzkoD4eXl3iF9FWHBxGx
        VU/3COTFMnIGExQJ72zXYxZmWGBj5Kkqsj6XKQWuR88C2000S1TEJVtRjSVGS2P1zGUvn6IP3k1Ri
        hWLpGJet4BuwVQ7JzYCP0PFBjJ+gm0hJaYOPs/KAvnZ5p2k5PX7q0MvGRBcLXfuSzX9LFC2svwJFO
        6ZXkHeF0QfUa9Parh0zHIoQb7WpCHrmO4GoXrOHmd/vjofp5dmvW8rLssa7guLAYoTD6AzIRarSyR
        SfPa5X7g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47190)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pUU5R-0005zE-2g; Tue, 21 Feb 2023 14:57:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pUU5Q-0002JJ-5Q; Tue, 21 Feb 2023 14:57:44 +0000
Date:   Tue, 21 Feb 2023 14:57:44 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: phylib locking (was: Re: [REGRESSION] Re: [patch V3 09/33]
 genirq/msi: Add range checking) to msi_insert_desc()
Message-ID: <Y/Tb6E3BaC7qSAMa@shell.armlinux.org.uk>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
 <86fsb0xkaa.wl-maz@kernel.org>
 <Y/PHN+0nETV3o1pQ@shell.armlinux.org.uk>
 <Y/PNcLACXSN2X/F/@lunn.ch>
 <Y/PU/9zTLxIJyWkz@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/PU/9zTLxIJyWkz@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 08:15:59PM +0000, Russell King (Oracle) wrote:
> [dropped most on the Cc as this has probably deviated off topic for
> them... and changed the subject]
> 
> On Mon, Feb 20, 2023 at 08:43:44PM +0100, Andrew Lunn wrote:
> > On Mon, Feb 20, 2023 at 07:17:11PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Feb 20, 2023 at 06:29:33PM +0000, Marc Zyngier wrote:
> > > > Lockdep also reports[1] a possible circular locking dependency between
> > > > phy_attach_direct() and rtnetlink_rcv_msg(), which looks interesting.
> > > > 
> > > > [1] https://paste.debian.net/1271454/
> > > 
> > > Adding Andrew, but really this should be in a separate thread, since
> > > this has nothing to do with MSI.
> > > 
> > > It looks like the open path takes the RTNL lock followed by the phydev
> > > lock, whereas the PHY probe path takes the phydev lock, and then if
> > > there's a SFP attached to the PHY, we end up taking the RTNL lock.
> > > That's going to be utterly horrid to try and solve, and isn't going
> > > to be quick to fix.
> > 
> > What are we actually trying to protect in phy_probe() when we take the
> > lock and call phydev->drv->probe(phydev) ?
> > 
> > The main purpose of the lock is to protect members of phydev, such as
> > link, speed, duplex, which can be inconsistent when the lock is not
> > held. But the PHY is not attached to a MAC yet, so a MAC cannot be
> > using it, and those members of phydev are not valid yet anyway.
> > 
> > The lock also prevents parallel operation on the device by phylib, but
> > i cannot think of how that could happen at this early stage in the
> > life of the PHY.
> > 
> > So maybe we can move the mutex_lock() after the call to
> > phydev->drv->probe()?
> 
> That's what I've been thinking too - I dug back in the history, and
> it was a spin_lock_bh(), and before that it was a spin_lock().
> 
> The patch that converted it to a spin_lock_bh() is a brilliant
> example of a poor commit message "Lock debugging finds a problem"
> but doesn't say _what_ the problem was! Going back further still, the
> spin_lock() was there from the very beginnings of PHYLIB. So the
> reasoning for having a lock here has been lost in the depths of time.
> 
> The lock certainly doesn't prevent any interaction with
> phy_attach_direct(), so it seems to be utterly pointless to take
> the lock in the probe() function.
> 
> So yes, I agree, we can move the lock - and I wonder whether we
> could just get rid of it completely in phy_probe().

Thinking about this more, I think taking phydev->lock in both
phy_probe() and phy_remove() are both entirely pointless, so I think
we should remove both and be done with this. As I note above, it does
nothing to stop a race between phy_attach_direct() and phy_probe() or
even phy_remove(). So, I think this is entirely sensible:

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 71becceb8764..b46a074b27e4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3098,8 +3098,6 @@ static int phy_probe(struct device *dev)
 	if (phydrv->flags & PHY_IS_INTERNAL)
 		phydev->is_internal = true;
 
-	mutex_lock(&phydev->lock);
-
 	/* Deassert the reset signal */
 	phy_device_reset(phydev, 0);
 
@@ -3173,8 +3171,6 @@ static int phy_probe(struct device *dev)
 	if (err)
 		phy_device_reset(phydev, 1);
 
-	mutex_unlock(&phydev->lock);
-
 	return err;
 }
 
@@ -3184,9 +3180,7 @@ static int phy_remove(struct device *dev)
 
 	cancel_delayed_work_sync(&phydev->state_queue);
 
-	mutex_lock(&phydev->lock);
 	phydev->state = PHY_DOWN;
-	mutex_unlock(&phydev->lock);
 
 	sfp_bus_del_upstream(phydev->sfp_bus);
 	phydev->sfp_bus = NULL;

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
