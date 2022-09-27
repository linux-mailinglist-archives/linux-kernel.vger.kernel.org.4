Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B73F5EC486
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiI0NdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiI0Nci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:32:38 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A2A39BA2;
        Tue, 27 Sep 2022 06:30:07 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id s18so5976982qtx.6;
        Tue, 27 Sep 2022 06:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZtuVD0X//vYfCK/DYYCjliZGbp8QJ4zZ1gO3gcAwl1Y=;
        b=TEniIpZEFFRm8Q8a3RvSX4inX7y5caMgLzJeMKPYyvXyCXmds0jsYcxxeSK2V0aPrB
         sp5H/hp5oZ5bQ5wB7qGUUBiuiH18z1saGhzp7Yrq83UkDRPx5d5lPHUGBwLwL3ueC+9e
         koKCzkOWR5hxmPgEpd4sfgz7cungSvPpVQmPO16tdjUN0Kko1525W3zyZWH6o8VgZpU7
         Ayd9VCmiGignw06DhRQ+Xabsbg1PCGVyhXtiSTLHQ92Co2OOkfQGKP25X5TJdexewAL+
         Xc68GaRWm8t6tB0bWUwQlCiqtzPJZmyoR07VRZ+MyCzVpyZMk9gFYo1Ik638UiMWKroL
         GhwQ==
X-Gm-Message-State: ACrzQf3chvOCdGM72NMEbEcn5oI3fgYPp+np5Ab6xwfzvq9HrEKI0uY9
        ENvhxIQSBhCLtY5YBjgXFX03B0enoF5Okg==
X-Google-Smtp-Source: AMsMyM5BmUi8HZb9/b1alwE1BojcGX5dnm7cl3ZZ4KT2u8RE/hqFJ+yjNWCBg82AQnAIt5BXWIyKVA==
X-Received: by 2002:a05:622a:8b:b0:35d:430d:e53d with SMTP id o11-20020a05622a008b00b0035d430de53dmr7202157qtw.391.1664285405777;
        Tue, 27 Sep 2022 06:30:05 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u6-20020a05620a0c4600b006ce0733caebsm998735qki.14.2022.09.27.06.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 06:30:05 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-345528ceb87so100131467b3.11;
        Tue, 27 Sep 2022 06:30:04 -0700 (PDT)
X-Received: by 2002:a81:1691:0:b0:345:17df:4fc6 with SMTP id
 139-20020a811691000000b0034517df4fc6mr24619807yww.502.1664285404554; Tue, 27
 Sep 2022 06:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220818145616.3156379-1-arnd@kernel.org> <20220818145616.3156379-6-arnd@kernel.org>
 <CAMuHMdU3bKa5rU6Tx6LVYOnzSmQZJ5o=5hj=aYqwaOPVPUX-5w@mail.gmail.com>
In-Reply-To: <CAMuHMdU3bKa5rU6Tx6LVYOnzSmQZJ5o=5hj=aYqwaOPVPUX-5w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 15:29:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-mKkHf7inwnuG3e_asjzisMqDiVSK0iuxequgTqjU5A@mail.gmail.com>
Message-ID: <CAMuHMdV-mKkHf7inwnuG3e_asjzisMqDiVSK0iuxequgTqjU5A@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: make ARCH_MULTIPLATFORM user-visible
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd et al,

On Tue, Sep 27, 2022 at 2:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Aug 18, 2022 at 4:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Some options like CONFIG_DEBUG_UNCOMPRESS and CONFIG_CMDLINE_FORCE are
> > fundamentally incompatible with portable kernels but are currently allowed
> > in all configurations. Other options like XIP_KERNEL are essentially
> > useless after the completion of the multiplatform conversion.
> >
> > Repurpose the existing CONFIG_ARCH_MULTIPLATFORM option to decide
> > whether the resulting kernel image is meant to be portable or not,
> > and using this to guard all of the known incompatible options.
> >
> > This is similar to how the RISC-V kernel handles the CONFIG_NONPORTABLE
> > option (with the opposite polarity).
> >
> > A few references to CONFIG_ARCH_MULTIPLATFORM were left behind by
> > earlier clanups and have to be removed now up.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for your patch, which is now commit 84fc863606239d8b ("ARM: make
> ARCH_MULTIPLATFORM user-visible") in soc/for-next.
>
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -320,7 +320,19 @@ config ARCH_MMAP_RND_BITS_MAX
> >         default 16
> >
> >  config ARCH_MULTIPLATFORM
> > -       def_bool MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> > +       bool "Require kernel to be portable to multiple machines" if EXPERT
> > +       depends on MMU && !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
> > +       default y
> > +       help
> > +         In general, all Arm machines can be supported in a single
> > +         kernel image, covering either Armv4/v5 or Armv6/v7.
> > +
> > +         However, some configuration options require hardcoding machine
> > +         specific physical addresses or enable errata workarounds that may
> > +         break other machines.
> > +
> > +         Selecting N here allows using those options, including
> > +         DEBUG_UNCOMPRESS, XIP_KERNEL and ZBOOT_ROM. If unsure, say Y.
> >
> >  menu "Platform selection"
> >         depends on MMU
> > @@ -1609,6 +1621,7 @@ config CMDLINE_EXTEND
> >
> >  config CMDLINE_FORCE
> >         bool "Always use the default kernel command string"
> > +       depends on !ARCH_MULTIPLATFORM
>
> This change broke half of the boards in my collective.
> Dropping this dependency again fixes the issue for me.
>
> On older platforms that boot an image with an appended DTB, or where
> the boot loader has no support for updating chosen/bootargs, I rely on
> CMDLINE_FORCE.
>
> Note that the CMDLINE choice depends on CONFIG_ATAGS=y, although
> my systems do not use ATAGS at all.  Arm64, loongarch, microblaze,
> nios2, powerpc, and riscv do not have such a limitation, so perhaps
> that should be lifted on arm, too?

"[PATCH] ARM: Drop CMDLINE_* dependency on ATAGS"
https://lore.kernel.org/r/09f0619e8038654d01588d9ad3a023485b2bd77f.1664285209.git.geert+renesas@glider.be

> I do see the rationale behind this change, and agree that a fixed
> command line can make the kernel unbootable on other platforms.
> However, a common command line is not guaranteed to cause that.
> E.g. all Renesas boards use the same chosen/bootargs in upstream DTS,
> which works fine if your DHCP server hands out proper nfsroot
> parameters (note that mine, running on OpenWRT, doesn't, hence my use
> of CMDLINE_FORCE ;-).

"[PATCH] ARM: Drop CMDLINE_FORCE dependency on !ARCH_MULTIPLATFORM"
https://lore.kernel.org/r/c557b149780faa2299700585afc9d270ede7f78b.1664285062.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
