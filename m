Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA673717A43
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjEaIh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjEaIh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:37:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5448110B;
        Wed, 31 May 2023 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TDaAg9ayPczBLdVOQhCC86gGj4A3yza0sCFAa26ThPM=; b=Tf+Hpo/TUBlUmnX0PTmosmx8ao
        qSmUBGTsh4glmoj9JUzPlLUUu3QhmCi1NxlNY71kgGmS4HUm0FzS3RnUJu7kDkBXZqNquUJHSi3A7
        UtIkjey3Jp28x/s4IopPqss9aorPdERyx26OKGBUUfThkxA4yP0GNwMZpvaEhA8v09W4vsp3sA2MU
        iY4BJ8s/+cqeKHRF6Yh/e1Pg9jUvNbeqMxmYRiybNn8DPOjLHsggHr+woeqo5WTWzC9OuhPdUFPek
        NTHeiE9sTUgqeGqXiiKWHzhwo2HPvttZcm9TpoVKcWwpCp74l5vAfFfU5IJEXe/KAKJesZwDq3AHM
        /VdgU56Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46312)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q4HL2-0004Ap-67; Wed, 31 May 2023 09:37:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q4HL0-0000WI-Ax; Wed, 31 May 2023 09:37:46 +0100
Date:   Wed, 31 May 2023 09:37:46 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: dsa: slave: Advertise correct EEE capabilities at
 slave PHY setup
Message-ID: <ZHcHWqdWsZSkV6C1@shell.armlinux.org.uk>
References: <20230530122621.2142192-1-lukma@denx.de>
 <ZHXzTBOtlPKqNfLw@shell.armlinux.org.uk>
 <20230530160743.2c93a388@wsk>
 <ZHYGv7zcJd/Ad4hH@shell.armlinux.org.uk>
 <35546c34-17a6-4295-b263-3f2a97d53b94@lunn.ch>
 <ZHYLNGkG26QP/QAS@shell.armlinux.org.uk>
 <20230531101640.131fe934@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531101640.131fe934@wsk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 10:16:40AM +0200, Lukasz Majewski wrote:
> Hi Russell,
> 
> > On Tue, May 30, 2023 at 04:26:49PM +0200, Andrew Lunn wrote:
> > > > So, I'm wondering what's actually going on here... can you give
> > > > any more details about the hardware setup?  
> > > 
> > > And what switch it actually is. I've not looked in too much detail,
> > > but i think different switch families have different EEE
> > > capabilities. But in general, as Russell pointed out, there is no
> > > MAC support for EEE in the mv88e6xxx driver.  
> > 
> > ... except for the built-in PHYs,
> 
> This is my case.
> 
> > which if they successfully negotiate
> > EEE, that status is communicated back to the MAC in that one sees
> > MV88E6352_PORT_STS_EEE
> 
> I cannot find this register in my documentation.

$ grep MV88E6352_PORT_STS_EEE drivers/net/dsa/mv88e6xxx/port.h

It's a register bit, not a register.

> > set, which results in the MAC being able to
> > signal LPI to the PHY... and I've stuck a 'scope on the PHY media-side
> > signals in the past and have seen that activity does stop without
> > there needing to be any help from the driver for this.
> > 
> > At least reading the information I have for the 88E6352, there is no
> > configuration of LPI timers, nor any seperate LPI enable. If EEE is
> > enabled at the MAC, then LPI will be signalled according to whatever
> > Marvell decided would be appropriate.
> 
> And this knowledge is not disclosed to public.
> 
> > 
> > For an external PHY that the PPU is not polling, the only way that
> > we'd have EEE functional is if we forced EEE in port control register
> > 1 on switches that support those bits. In other words setting both the
> > EEE and FORCE_EEE bits...
> > 
> 
> Are those bits available in c45 standard? Or are they SoC (IC) specific?

I'm talking about bits in the switch port control register, not in
the PHY. Again, grepping the above file will tell you which bits
and their location.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
