Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591F36478CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 23:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiLHW3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 17:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLHW33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 17:29:29 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A911C43B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9/E3aQ6joQfFe6Nebd8CYybcGRYfIRW8KVJYv3/3Gyc=; b=rEApFDX1rVON7J2NUJkAbzb3uv
        N1T4+26Rs2yikGWYDTdkYy9IJNn/RnNku768T6beKpbdsFDxyUjjR01jRlI4amoAXwHFVdgZhoKqp
        DHrXa1fW3DL2nWvLaIurZa3qIdMJ8QFD+Tz92EClgq/rvawoduZLFxUth8hfOKCVOVxRre2ZopdyD
        YGcCJRU5ijf6q19s2CGKJuUqCBa1gN3uKSW1f2zH3wl9uQwDslJaoKqvoDgDl1NUu0rOSTahcoK3b
        hDpEI5eWR8rV5IAVMpNgRaT8tHO76F0a5a+V/o6U6gh26nbB3exj8rAMIbAxQTvayBCEwUYMBYSJH
        V2sJS3pA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35636)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1p3PON-0002Jp-7N; Thu, 08 Dec 2022 22:29:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1p3POK-00022E-LB; Thu, 08 Dec 2022 22:29:20 +0000
Date:   Thu, 8 Dec 2022 22:29:20 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org
Subject: Re: PXA25x: GPIO driver fails probe due to resource conflict with
 pinctrl driver
Message-ID: <Y5JlQLe+3la2XPZw@shell.armlinux.org.uk>
References: <Y5B4QeNMNboJ42n4@probook>
 <Y5CxBzy47Gjn/V5a@lunn.ch>
 <Y5C0F/o4JS5MwkkJ@shell.armlinux.org.uk>
 <Y5DDCmXnamC6Zikx@probook>
 <Y5DbKNI3e+tFA++1@shell.armlinux.org.uk>
 <Y5IulKoRctcrWBzl@probook>
 <m2wn71emze.fsf@sopl295-1.home>
 <Y5I2oQexHNdlIbsQ@shell.armlinux.org.uk>
 <m2pmcteilg.fsf@sopl295-1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2pmcteilg.fsf@sopl295-1.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 09:19:12PM +0100, Robert Jarzmik wrote:
> 
> "Russell King (Oracle)" <linux@armlinux.org.uk> writes:
> > From a quick look, I think this commit is to blame:
> > 
> > 542c25b7a209 drivers: gpio: pxa: use devm_platform_ioremap_resource()
> > 
> > Someone "helpfully" making this change:
> > 
> > -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -       if (!res)
> > -               return -EINVAL;
> > -       gpio_reg_base = devm_ioremap(&pdev->dev, res->start,
> > -                                    resource_size(res));
> > +
> > +       gpio_reg_base = devm_platform_ioremap_resource(pdev, 0);
> > 
> > which introduces request_mem_region() to the PXA GPIO driver, resulting
> > in this resource clash.
> You're right.
> 
> Now, as for Jonathan, there are 2 options :
> - first one : revert the patch Russell pointed out
> - second one : a lot of work, detailed below :
> 
> Given that Arnd is removing legacy platformdata code, that will only leave
> the
> device-tree one, which works only with the pinctrl driver enabled.
> That gives the opportunity to drop the use of GPDR from the gpio-pxa driver,
> and now we can map with separate iomem ressources pinctrl-pxa and gpio-pxa.

Does the GPIO driver talk to the pinctrl driver to switch GPIOs between
input and output mode? If it does, that's fine. If not, that can cause
regressions, as GPIOs may need to be switched between input and output
mode at runtime (e.g. for I2C gpio-based bitbang).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
