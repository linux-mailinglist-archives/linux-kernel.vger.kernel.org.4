Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD94608DC1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 16:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJVOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 10:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJVOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 10:51:46 -0400
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5582565F1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zK3GK745Rpekd0W3RMt4rPJA0uSmGOJkehdAfC4Sz4o=; b=kbSUpYYVx5Er7Y4ja6jOBUNuis
        UDYrfrLiM/JaU5yEfa1SgddD98KIhlH3oj5pPfe6gwz+Rf/zTcv0vImd7ArwOHRw47clBM/Ijvhv+
        PQlwv89fSn1NUWER5gEHdTFLU0Z3JJhJxassuJZd6IuuazfKPPXteOhtR32x62hiiN9ISkn+TOLxD
        WmCxppr5R6OvjRXLryiBcym+ASw0JoKftM6tHZM6eywnDXnwAsE5/hYZTcXYeEwRV5j1BbN4yuuMh
        8HGdtg+3ZrbORGfL8L1OmPjyyUfS0YdQScNR/nq84HTv05Dszp00O4UST9+ctc6BtWYqhZ35lUTmh
        aTNfl+DQ==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1omFqG-004Bfl-Kz; Sat, 22 Oct 2022 15:51:16 +0100
Date:   Sat, 22 Oct 2022 15:51:16 +0100
From:   Jonathan McDowell <noodles@earth.li>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] ARM: mach-qcom: fix support for ipq806x
Message-ID: <Y1QDZMoCeYAfeO6j@earth.li>
References: <20221021181016.14740-1-ansuelsmth@gmail.com>
 <CACRpkdbfvr1pkVb3XhBZLnmn7vy3XyzavwVjW_VmFKTdh3LABQ@mail.gmail.com>
 <63531543.050a0220.b6bf5.284d@mx.google.com>
 <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbOQq9hUT=d1QBDMmgLaJ1wZ=hd44ciMnjFVgpLCnK8Wg@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 04:21:28PM +0200, Linus Walleij wrote:
> On Fri, Oct 21, 2022 at 11:55 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> > On Fri, Oct 21, 2022 at 11:44:56PM +0200, Linus Walleij wrote:
> 
> > > Is it not possible to use Geert's linux,usable-memory-range in
> > > the chosen node to make the kernel stay off the memory?
> > > (See examples by grep usable-memory in the kernel.)
> > >
> > just to confirm this is one of the example you are suggesting?
> >
> > chosen {
> >                 bootargs = "console=ttyS0,115200 earlycon";
> >                 stdout-path = "serial0:115200n8";
> >                 linux,usable-memory-range = <0x80200000 0x1fe00000>;
> >         };
> 
> Yep that thing!
> 
> > Main problem here is that uboot in some case doesn't support dt and pass
> > wrong ATAGS (with the memory not reserved) and AUTO_ZRELADDR calculate
> > the wrong addr I assume?
> 
> You do have a DTB right, just that it is attached, and then the kernel
> uses the ATAGs to augment the memory?
> 
> In that case what about disabling ARM_ATAG_DTB_COMPAT
> and adding the actual valid memory to the top-level DTS
> file? Just like that:
> 
>       memory {
>                 device_type = "memory";
>                 reg = <0x42000000 0xnnnnnnnn>;
>         };

The RB3011 (arch/arm/boot/dts/qcom-ipq8064-rb3011.dts) does this and has
been working fine with AUTO_ZRELADDR (and no ATAGS support enabled) - I
have a recollection it didn't used to, but it's certainly worked since
the 5.15 timeframe.

J.

-- 
Generally, all generalizations are false..
This .sig brought to you by the letter M and the number 44
Product of the Republic of HuggieTag
