Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A56460FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiLGS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:28:03 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540A54343
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XAqZYbN/y12h28N9Di+NOYD0uzPdv1lmdVBD1XOA8Eo=; b=ej3zlIxboykYelDWedHivgskS1
        RT4tMkrmINoeJdfnI8cshnY7PllX+tO3f5VgxAsdJdwx1+5qfcQfW6eNUk0FBaqMgGj1KXO999YC9
        aOxF1f4FIPdh0BMvkNgD10NVnVrddEAxvpO1RusdutGRqFr2Q/3q2Oa3I+S1a5Iw72MvV7QWHasUS
        2vf/0hkopKwHLSV4PWxnowsMndFldPYw3+h2DFGTvhe1aPfz1NwSarF1dI+7NFZ0Wh0aIZnf26s9D
        W4u/zS/28QdIw7ko9JDxdlh9FstvgkiC8RmwMwWlMRcovBuYXTsW0s7r88MLTBCL5fZ5mTShqEpxC
        kygqdgVg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35620)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p2z99-0000tA-4x; Wed, 07 Dec 2022 18:27:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p2z96-0000wE-3A; Wed, 07 Dec 2022 18:27:52 +0000
Date:   Wed, 7 Dec 2022 18:27:52 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
 <Y5DDCmXnamC6Zikx@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5DDCmXnamC6Zikx@probook>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 05:44:58PM +0100, Jonathan Neuschäfer wrote:
> On Wed, Dec 07, 2022 at 03:41:11PM +0000, Russell King (Oracle) wrote:
> > On Wed, Dec 07, 2022 at 04:28:07PM +0100, Andrew Lunn wrote:
> [...]
> > > How are the registers arranged?
> > 
> > As documented in drivers/gpio/gpio-pxa.c - it'll be easier for you to
> > look there rather than for me to explain it - but suffice it to say
> > that the pinctrl registers are amongst the GPIO registers.
> > 
> > > Is 0x40e00000-0x40e0ffff simply too
> > > large, and making it smaller would fix the issue? Or are the registers
> > > interleaved?
> > 
> > They're interleaved. Looking at the .dtsi file for PXA25x, it seems
> > that the pinctrl claims just the addresses that it needs, but the GPIO
> > controller has no reg property in the .dtsi, so I'm not sure what fills
> > that information in.
> 
> The GPIO reg property is in pxa2xx.dtsi.

Looks to me like pxa25x should override the reg property with a smaller
range (0x54) and  pxa27x probably should have used a second set of
entries in reg the subsequent group of 3 gpio blocks at offset 0x100.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
