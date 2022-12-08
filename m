Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD16475FE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLHTKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiLHTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:10:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CF862CD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M5qgR9z9/aXhE8FCQ+Y9Qm2E2s4Im7J0TM9pUn+fh4w=; b=vjcmJ050Ll5ZcSccJLh3sQNpBu
        kujr75KWtMx7xLA1Ruef/jXzEoR3apHSfRRzK+q64Ou3LbibVCXuppmZ/3jQXSy8xF+BbFCBOWPR1
        TZM0S8nZ/ZeroPDe0tpa0mUL6XFubqqSMcgem5lwBaslBqtXOqWS2JRhMX9jLsmCk65gswAjM0+d9
        E7EqojeUqFhgtFFEH+5Y3cZIFOnd9Yl7RpkHJ3rtKSxNjdV6K4p+8m5hCyADq8BJj86L57Sb3lN4u
        hoj0f+rxEljSm2ZW54zzQbaATJJoVsioFTbkAPPT3SxB3B0/GbUvBZYku3PysCxIRk+cWaS+5yl6f
        Vtm4ipzg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35634)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p3MHu-00028F-6h; Thu, 08 Dec 2022 19:10:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p3MHp-0001v9-Ni; Thu, 08 Dec 2022 19:10:25 +0000
Date:   Thu, 8 Dec 2022 19:10:25 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
 <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk>
 <Y5IulKoRctcrWBzl@probook>
 <m2wn71emze.fsf@sopl295-1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m2wn71emze.fsf@sopl295-1.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 07:46:26PM +0100, Robert Jarzmik wrote:
> 
> Jonathan Neuschäfer <j.neuschaefer@gmx.net> writes:
> 
> > Without further code changes this wouldn't be sufficient, because the
> > pinctrl driver also touches the GPIO direction registers at offset
> > 0x0c-0x14.
> 
> Historically, this problem was adressed by a "hack" if I remember correctly,
> as the
> registers do overlap (on pxa27x at least, but I think on pxa25x as well) :
> - GAFR (alternate functions) and GPDR (input or output) are  "pinctrl"
> - GPSR, GPCR, GPLR are "gpio" registers
> - the memory map (physical) at 0x40e0 0000 is as Jonathan wrote :
>  - 3 u32 GPLR (gpio)
>  - 3 u32 GPDR (pinctrl)
>  - 3 u32 GPSR (gpio)
>  - 3 u32 GPCR (gpio)
> 
> The "hack" was that one driver was mapping the area _without_ claiming it
> (this
> is part from memory, I didn't check in the code today). The gpio was
> probably
> the claiming one, while the pinctrl was the "only using one".
> 
> As of today, I should have a look what was changed, but I'm pretty sure in
> all
> pxa2xx architecture there is an overlap, as for these ancient platforms the
> pinctrl wasn't yet separated from the gpio IC.
> 
> The only was out so far I can see from my head would be to declare multiple
> very small IO ranges :
> - pinctrl pxa25x : 0x40e0 000c (12 bytes), 0x40e0 0054 (32 bytes)
> - pinctrl pxa25x : 0x40e0 000c (12 bytes), 0x40e0 0054 (32 bytes),  0x40e0
> 010c (4 bytes)
> - gpio : from 0x40e0 0000 to 0x40e0 0070 included, without the  pinctrl ones
> 
> As a general guide, in gpio-pxa.c, you have the table in [1]. Think GPDR and
> GAFR as
> pinctrl, and all the other ones as gpio. Ah and yes, the GAFR ones are
> missing in this
> table.
> 
> One last think : in a pre device-tree world, when we didn't had yet the pxa
> pinctrl
> driver, the gpio driver was directly playing with the GPDR registers, fun
> old times.

From a quick look, I think this commit is to blame:

542c25b7a209 drivers: gpio: pxa: use devm_platform_ioremap_resource()

Someone "helpfully" making this change:

-       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-       if (!res)
-               return -EINVAL;
-       gpio_reg_base = devm_ioremap(&pdev->dev, res->start,
-                                    resource_size(res));
+
+       gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);

which introduces request_mem_region() to the PXA GPIO driver, resulting
in this resource clash.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
