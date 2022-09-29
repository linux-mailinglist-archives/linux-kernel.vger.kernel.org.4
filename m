Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB55EF00F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiI2ILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiI2IKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:10:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD4B10E5C2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:10:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 70so625289pjo.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=PqlfwPujJPa5ILhcAEpjB2XsXFIbNicns4sglvBu2Nc=;
        b=iik4pyUMcQXH0byUTH3UfkwH8RlaHqsQ5U3b4sybeBIPhtwbxsNQKtG+/BNrmOuF3o
         um+XOEMBDn94QCGDcbNSZumApjt4JYx4n0BQguGBfEgr1Y0EtIhHLtjSomCCAK5PuIAR
         cjAzyj5ceFJ9ImesfbZWOSzfQdfn8lWZHL7SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=PqlfwPujJPa5ILhcAEpjB2XsXFIbNicns4sglvBu2Nc=;
        b=6Ti2xe1fWWFM0XMwzYGaprTKneEwzUR2OtPi6bbh/tdRDFy+elPpEeGO684EyxyO3O
         FlfsLjtmmqsvjsq20lb3RNjr2uKIeJC/Trwd/SB7EGr9A+FQdX2yhGVPKp33/eDuaXnB
         Nj4YR6nIPznKJPoe/XEK9TTL/c24/w34IGP15rSGM2daVOeG6GaRkmyb2YwbZCmwbGpx
         VEpmJ9MN2SDeDGiHeahg5KlikphVx18G6rwJtRQIu/Erwg9YTnefFCpOzkJAaBQP0qnn
         4p0OjjgrjwKwKu7rSGRyOai2c8pDGWAHy1mBqJztdYQh9uBbEA4J10FF5VO1jy0HGGNp
         mAPw==
X-Gm-Message-State: ACrzQf2NQo+vPTRuM2WmR82LAFdrfsCSf3tyKGwPEQtXG/aBh16RR3f2
        2sywW/R3eTAk4KFq+QksKllTrw==
X-Google-Smtp-Source: AMsMyM6T5dB82wt7higNMwUVZBo8eq9IUm01DA0UgbxCIMi2sMaKyAvr86TcSZkBJXezzwNJaXIvRQ==
X-Received: by 2002:a17:902:e88c:b0:176:a427:be6a with SMTP id w12-20020a170902e88c00b00176a427be6amr2233325plg.150.1664439039213;
        Thu, 29 Sep 2022 01:10:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a764200b0020087d7e778sm2815639pjl.37.2022.09.29.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:10:38 -0700 (PDT)
Date:   Thu, 29 Sep 2022 01:10:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Nick Hawkins <nick.hawkins@hpe.com>,
        John Crispin <john@phrozen.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, anand.gore@broadcom.com
Subject: Re: [PATCH] ARM: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Message-ID: <202209290110.024DC2FE@keescook>
References: <20220928174739.802806-1-f.fainelli@gmail.com>
 <202209281100.5311EE081B@keescook>
 <729030b4-c341-966f-05ed-3754122cb4f7@gmail.com>
 <986bea84-7cc3-9c40-733c-0c766f7a9ebc@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986bea84-7cc3-9c40-733c-0c766f7a9ebc@broadcom.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 05:33:14PM -0700, William Zhang wrote:
> 
> 
> On 09/28/2022 04:06 PM, Florian Fainelli wrote:
> > On 9/28/22 11:01, Kees Cook wrote:
> > > On Wed, Sep 28, 2022 at 10:47:39AM -0700, Florian Fainelli wrote:
> > > > From: Seung-Woo Kim <sw0312.kim@samsung.com>
> > > > 
> > > > To enable UBSAN on ARM, this patch enables ARCH_HAS_UBSAN_SANITIZE_ALL
> > > > from arm confiuration. Basic kernel bootup test is passed on arm with
> > > > CONFIG_UBSAN_SANITIZE_ALL enabled.
> > > > 
> > > > Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> > > > [florian: rebased against v6.0-rc7]
> > > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > 
> > > Ah-ha, thanks for testing this. What devices did you check this on? I
> > > know boot-up on arm32 can be very device-specific.
> > 
> > This was tested on an ARCH_BRCMSTB system which is using an ARMv8 CPU
> > booted in AArch32 mode, so virtually equivalent to armv7l. A raspberry
> > Pi 4B is also happily booting with it.
> > 
> > > 
> > > Which UBSAN configs did you try?
> > 
> > All CONFIG_UBSAN_* work with the exception of CONFIG_UBSAN_ALIGNMENT on
> > my ARCH_BRCMSTB system, however it works fine on the Raspberry Pi 4B.
> > Florian
> 
> I also tested on a BCM63138 board (ARM A9) under ARCH_BCMBCA using the
> multi_v7_defconfig with all the UBSAN configs enabled except UBSAN_ALIGNMENT
> and board boots up fine. Turning on UBSAN_ALIGNMENT results in flood of
> false positive misaligned-access warnings. This is fine as ARM supports
> unaligned access.
> 
> It did catch an out-of-band bug in mach-sunxi smp code.  I will submit a
> separate patch to fix that bug.

Yay! :) Move coverage is great. :)

> 
> Tested-by: William Zhang <william.zhang@broadcom.com>

Thanks!

-- 
Kees Cook
