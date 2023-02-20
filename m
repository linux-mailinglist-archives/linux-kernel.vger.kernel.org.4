Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931769D491
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjBTUQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjBTUQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:16:07 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA71F5DB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 12:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WVm9xJ6cZuscXUE34Q9jyFDu61rGWObE0H3nHei7WeI=; b=eM3VdKSM+atMAIbwASJJI1DdgY
        3vs8/W2noojXQv1nkt8lkOK2qJrlB8+z+XgGaGoytrICtNPNXkq8uP+EbqQyAc881bNZRgwPtRnG2
        IFYP5/3XK95ddeHPA50//+cFxtRiZhMk3uJsdSGq5rBdE7H7gW1xXq3o6pxGdXRMM0IdlkX1VGVgE
        hrZLsts8EY79CBeDFdbyEk69qT2GKytFdLRGMA7QqdyKFRzsCpaD1zKg8AINEk+K+7YhW6avNwmGA
        QGa67oGidrCL0WUEZCiUEg/o6aXIUDDeUyVGjb5YcDXy8xDSeTTjgi/HIExdLqmvWjFvSGe2cDIkf
        NuXuARdw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43882)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pUCZs-0004yT-6s; Mon, 20 Feb 2023 20:16:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pUCZr-0001Wj-G3; Mon, 20 Feb 2023 20:15:59 +0000
Date:   Mon, 20 Feb 2023 20:15:59 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: phylib locking (was: Re: [REGRESSION] Re: [patch V3 09/33]
 genirq/msi: Add range checking) to msi_insert_desc()
Message-ID: <Y/PU/9zTLxIJyWkz@shell.armlinux.org.uk>
References: <20221124230505.073418677@linutronix.de>
 <20221124232325.798556374@linutronix.de>
 <Y/Opu6ETe3ZzZ/8E@shell.armlinux.org.uk>
 <86fsb0xkaa.wl-maz@kernel.org>
 <Y/PHN+0nETV3o1pQ@shell.armlinux.org.uk>
 <Y/PNcLACXSN2X/F/@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/PNcLACXSN2X/F/@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropped most on the Cc as this has probably deviated off topic for
them... and changed the subject]

On Mon, Feb 20, 2023 at 08:43:44PM +0100, Andrew Lunn wrote:
> On Mon, Feb 20, 2023 at 07:17:11PM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 20, 2023 at 06:29:33PM +0000, Marc Zyngier wrote:
> > > Lockdep also reports[1] a possible circular locking dependency between
> > > phy_attach_direct() and rtnetlink_rcv_msg(), which looks interesting.
> > > 
> > > [1] https://paste.debian.net/1271454/
> > 
> > Adding Andrew, but really this should be in a separate thread, since
> > this has nothing to do with MSI.
> > 
> > It looks like the open path takes the RTNL lock followed by the phydev
> > lock, whereas the PHY probe path takes the phydev lock, and then if
> > there's a SFP attached to the PHY, we end up taking the RTNL lock.
> > That's going to be utterly horrid to try and solve, and isn't going
> > to be quick to fix.
> 
> What are we actually trying to protect in phy_probe() when we take the
> lock and call phydev->drv->probe(phydev) ?
> 
> The main purpose of the lock is to protect members of phydev, such as
> link, speed, duplex, which can be inconsistent when the lock is not
> held. But the PHY is not attached to a MAC yet, so a MAC cannot be
> using it, and those members of phydev are not valid yet anyway.
> 
> The lock also prevents parallel operation on the device by phylib, but
> i cannot think of how that could happen at this early stage in the
> life of the PHY.
> 
> So maybe we can move the mutex_lock() after the call to
> phydev->drv->probe()?

That's what I've been thinking too - I dug back in the history, and
it was a spin_lock_bh(), and before that it was a spin_lock().

The patch that converted it to a spin_lock_bh() is a brilliant
example of a poor commit message "Lock debugging finds a problem"
but doesn't say _what_ the problem was! Going back further still, the
spin_lock() was there from the very beginnings of PHYLIB. So the
reasoning for having a lock here has been lost in the depths of time.

The lock certainly doesn't prevent any interaction with
phy_attach_direct(), so it seems to be utterly pointless to take
the lock in the probe() function.

So yes, I agree, we can move the lock - and I wonder whether we
could just get rid of it completely in phy_probe().

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
