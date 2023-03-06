Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420766ABF77
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjCFM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCFM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:28:45 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10268B76F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OOwsDntjIKex0UXX4PvsSe30lt6AMd9spZxoObCB/2U=; b=W/gV7hRiVVAZOkrkZ+JBYTwlqV
        L0ukXGRZgvUkMcgPZA+riCZRd9lJ6YGicMOh8tXDfXekPrqVXcms6DMSxo3+gXY7N4SjjGZop8S6i
        +KaCTGWumCYqZtY+Rav29q4ay3QNFluqhxph0uo1QgQzACgPmEx2eG2ZOTlIIKE9wLnMvjPKeZi0q
        8hv/nP/FpgFEJB+G76TDBW59I1bCpOYc82iJuxgh9zCa/DfMpOCX9Zvc7gakKWbmiwbPH41VkNKfE
        /78Gva979C3hUhBycz8a3QTBpEQPkXurD1vI/RnFPr9strTF6UdDa5WsBg1yVKntnch/dBIfhLpbj
        RLajglVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43970)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pZ9xF-0005hl-Ly; Mon, 06 Mar 2023 12:28:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pZ9xE-0000UL-7W; Mon, 06 Mar 2023 12:28:36 +0000
Date:   Mon, 6 Mar 2023 12:28:36 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jungseung Lee <js07.lee@samsung.com>
Cc:     linus.walleij@linaro.org, amit.kachhap@arm.com, ardb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, js07.lee@gmail.com
Subject: Re: [PATCH 2/2] arm/mm : Report actual image regions in /proc/iomem
Message-ID: <ZAXcdDBiQ9JVo4pY@shell.armlinux.org.uk>
References: <1678081915-12599-1-git-send-email-js07.lee@samsung.com>
 <CGME20230306061057epcas1p17def087649be56b75c7830385ff2fb2f@epcas1p1.samsung.com>
 <1678081915-12599-2-git-send-email-js07.lee@samsung.com>
 <ZAXKHDb4QY1awyRA@shell.armlinux.org.uk>
 <076401d95025$305fb150$911f13f0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076401d95025$305fb150$911f13f0$@samsung.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 09:14:23PM +0900, Jungseung Lee wrote:
> Hi, Russell
> 
> > -----Original Message-----
> > From: Russell King (Oracle) <linux@armlinux.org.uk>
> > Sent: Monday, March 6, 2023 8:10 PM
> > To: Jungseung Lee <js07.lee@samsung.com>
> > Cc: linus.walleij@linaro.org; amit.kachhap@arm.com; ardb@kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > keescook@chromium.org; js07.lee@gmail.com
> > Subject: Re: [PATCH 2/2] arm/mm : Report actual image regions in
> > /proc/iomem
> > 
> > On Mon, Mar 06, 2023 at 02:51:55PM +0900, Jungseung Lee wrote:
> > >  The resource reservations in /proc/iomem made for the kernel image
> > > did  not reflect the gaps between text, rodata, and data.
> > >  Add the "rodata" resource and update the start/end calculations.
> > >
> > >  Before :
> > > 04000000-2f7fffff : System RAM
> > >   04100000-04cfffff : Kernel code
> > >   04e00000-05369a27 : Kernel data
> > >
> > >  After :
> > > 04000000-2f7fffff : System RAM
> > >   04100000-049fffff : Kernel code
> > >   04a00000-04cb2fff : Kernel rodata
> > >   04e00000-05369a27 : Kernel data
> > 
> > NAK. This is API, and programs do read and parse this file. It is
> > important that this file reports these parameters in a similar way to
> > other architectures. Other architectures do not split up the
> > individual regions.
> > 
> 
> Sounds like an important point, but I failed to find which programs use it
> as an API. Could you tell me which program uses it as an API?
> 
> In fact, x86 architecture also split up the individual regions in this way.
> In addition, most architectures separate the "Kernel bss" area, but arm does
> not.

Take a look at kexec-tools - that certainly does parse /proc/iomem
looking for entries such as "Kernel code" and "Kernel data".

It's fine for an architecture to decide to do something else if it
started to do it early on, but not when something has been established
for decades.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
