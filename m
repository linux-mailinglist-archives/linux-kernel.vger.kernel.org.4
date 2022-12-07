Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12966645DC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiLGPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:41:20 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C46721252
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ai9AyaYCOP+1mwEvT2GphqrR/8UUpCv7twpnp2ghV2Y=; b=XFnLUGerdTFheh129qR9NxuuEE
        wE6qV8cHZ/Xe8fWU6RCnXrx2owtf4Pv3lQ3g3b6gwVp1mdGe0Vo2a4BwKigQg1O3Xy9rT4S8YxWhj
        TBwt2OJFMefQ5Y3q9dlJojxrbircOIWKn7yD897QcPH0k6PMbqb1rjmAXKttaQtJTUgs71jJ6yDG4
        PyGxnWT0kOonCAzoFe5yX6gNnBFUMb+KXLz8T7oCcqPnTKAfwbGyRbm8402RZ9vE8P/09PvIFw7DN
        79gB74o+AD0ZZIVOVwbLBGQ44x8hd9QblrDJBSoiLyMefOHiqf5kh7G4gN6t+qIhPd0xyPWiAmD/2
        5X48Z14g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35618)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p2wXp-0000m5-1X; Wed, 07 Dec 2022 15:41:13 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p2wXn-0000qu-B2; Wed, 07 Dec 2022 15:41:11 +0000
Date:   Wed, 7 Dec 2022 15:41:11 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5CxBzy47Gjn/V5a@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:28:07PM +0100, Andrew Lunn wrote:
> On Wed, Dec 07, 2022 at 12:25:53PM +0100, Jonathan Neuschäfer wrote:
> > Hello,
> > 
> > I am currently trying to bring up Linux 6.1-rcX on a PXA255 board, using a
> > devicetree. One problem I encountered is that the PXA GPIO driver fails to
> > probe because it uses the same MMIO register range as the pinctrl driver:
> > 
> > [    0.666169] pxa25x-pinctrl 40e00054.pinctrl: initialized pxa2xx pinctrl driver
> > [    0.694407] pxa-gpio 40e00000.gpio: can't request region for resource [mem 0x40e00000-0x40e0ffff]
> > [    0.695050] pxa-gpio: probe of 40e00000.gpio failed with error -16
> > 
> > Before I try to fix this myself: Is GPIO on PXA25x currently expected to
> > work and when has it last been seen working?
> > 
> > What would be a good way to fix this?
> 
> How are the registers arranged?

As documented in drivers/gpio/gpio-pxa.c - it'll be easier for you to
look there rather than for me to explain it - but suffice it to say
that the pinctrl registers are amongst the GPIO registers.

> Is 0x40e00000-0x40e0ffff simply too
> large, and making it smaller would fix the issue? Or are the registers
> interleaved?

They're interleaved. Looking at the .dtsi file for PXA25x, it seems
that the pinctrl claims just the addresses that it needs, but the GPIO
controller has no reg property in the .dtsi, so I'm not sure what fills
that information in.

DT could describe the region for PXA25x, which is just:

	0x40e00000 - 0x40e00054

Later PXA have more banks, so would require additional resources to be
listed.

However, first, we need to know what provides the iomem resource for
this:

                gpio: gpio@40e00000 {
                        compatible = "intel,pxa25x-gpio";
                        gpio-ranges = <&pinctrl 0 0 84>;
                        clocks = <&clks CLK_NONE>;
                };

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
