Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEA9660FF1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 16:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjAGPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 10:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjAGPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 10:22:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FB164C1;
        Sat,  7 Jan 2023 07:22:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9D97B819A5;
        Sat,  7 Jan 2023 15:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BE3C433D2;
        Sat,  7 Jan 2023 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673104965;
        bh=UakUyERlTyZBT8h8wzrzHPSFjoJiTVN0dE25GLCjihE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Srsk7Gy2AglmbzwpETlP6uwNk/Z6/qlNaDkyYUqP372XMV3PDIG9SMrZ0gtPDHdW6
         UPhzDQByMrrJkAQHSEar3YjCXlY1X7888Vg6wsytumTFMQeQH6IjJSKUkyvW/isI+G
         O2j55ALgwecA6AxeEst16a354k9CA6DzzmnCYbM8VpyoES2wTQ9fNl3mMWxt1O3ATr
         toWmJolNvFN/EBemUYtIs8yt/urABPro6IrzbOvdubocRidLvw1h0w/PELSPL5hbey
         Q4uKeSJ5t53n4/7NOwqqdm6yGcL59k22nmqctjcmZMRLVWy9mjvTG1nBVkWc9Vsclb
         xDFNusQihIUCg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-14ffd3c5b15so4498351fac.3;
        Sat, 07 Jan 2023 07:22:45 -0800 (PST)
X-Gm-Message-State: AFqh2kpsHGao38v9winGcNBCO1zkhj3vzZqSVNVPiIsJJFUeARNynFK6
        rUIw5OclbwLWykLloq0S18WaYCdGrAKHPdrbuJM=
X-Google-Smtp-Source: AMrXdXtl2xLUsg4F2xCoDjfsPVhBqYP6xVGsvlk1dhpHyyIubFEkP5wVXn2iyfBa/CpewGOKlVHeIJtV5nW72vaBc4I=
X-Received: by 2002:a05:6870:cc89:b0:150:39e2:c688 with SMTP id
 ot9-20020a056870cc8900b0015039e2c688mr2679007oab.287.1673104964711; Sat, 07
 Jan 2023 07:22:44 -0800 (PST)
MIME-Version: 1.0
References: <Y7i8+EjwdnhHtlrr@dev-arch.thelio-3990X> <CAK7LNASkC3j5=cy7efMC=pFjgXMucBOVNrMCTMCUkJSLj8i=Dg@mail.gmail.com>
In-Reply-To: <CAK7LNASkC3j5=cy7efMC=pFjgXMucBOVNrMCTMCUkJSLj8i=Dg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 8 Jan 2023 00:22:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpdAywWZCLC0a78SbDA1TSMMgZU4HK5akWivM=Z5y+iA@mail.gmail.com>
Message-ID: <CAK7LNARpdAywWZCLC0a78SbDA1TSMMgZU4HK5akWivM=Z5y+iA@mail.gmail.com>
Subject: Re: nm vmlinux error in arch/arm reappears after upgrade to make 4.4
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 7, 2023 at 4:19 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Jan 7, 2023 at 9:29 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi Masahiro,
> >
> > My distribution recently updated their version of make to 4.4 from 4.3,
> > after which I notice the following error from nm when building ARCH=arm
> > kernels, which I thought that this was supposed to be resolved with
> > commit 3ec8a5b33dea ("kbuild: do not export LDFLAGS_vmlinux") but the
> > tree clearly has this and it is not visible while just running clean (I
> > have to build zImage to see it):
>
>
> Presumably, this is a different issue than 3ec8a5b33dea
>


My bad.

3ec8a5b33dea unexported LDFLAGS_vmlinux


However,

5d4aeffbf709 exported LDFLAGS_vmlinux again.



> >
> >   $ git show -s --format='%h ("%s")'
> >   512dee0c00ad ("Merge tag 'x86-urgent-2023-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> >
> >   $ make --version | head -1
> >   GNU Make 4.4
> >
> >   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage
> >   arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux': No such file
> >
> > vs.
> >
> >   $ make --version | head -1
> >   GNU Make 4.3
> >
> >   $ make -skj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build defconfig zImage
> >
> > I bisected make to see what change causes this and I landed on
> > commit 98da874c ("[SV 10593] Export variables to $(shell ...)
> > commands") [1], which certainly seems like a reasonable commit to
> > blame but I am not sure how exactly it factors in here.
> >
> > If you need any more information on reproducing this, I am happy to
> > provide it (CROSS_COMPILE is just the toolchains from kernel.org).
> >
> > [1]: https://git.savannah.gnu.org/cgit/make.git/commit/?id=98da874c43035a490cdca81331724f233a3d0c9a
> >
> > Cheers,
> > Nathan
>
>
>
> Confirmed, but I still do not understand what
> is triggering this.


I figured out the reason.

I will send a patch later.








>
> These are my findings:
>
>  - O= option is needed to reproduce it.
>
>  - allnoconfig still produces it.
>
>  - I do not see it in the incremental builds.
>    I see it again in the full build after "git clean -fdx".
>
>
>
> If I slightly cleaned the code like follows,
> this issue disappeared.
> ($(obj)/../../../../vmlinux is the same as vmlinux)
>
>
>
>
> diff --git a/arch/arm/boot/compressed/Makefile
> b/arch/arm/boot/compressed/Makefile
> index 2ef651a78fa2..726ecabcef09 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -107,7 +107,7 @@ ccflags-remove-$(CONFIG_FUNCTION_TRACER) += -pg
>  asflags-y := -DZIMAGE
>
>  # Supply kernel BSS size to the decompressor via a linker symbol.
> -KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
> +KBSS_SZ = $(shell echo $$(($$($(NM) vmlinux | \
>                 sed -n -e 's/^\([^ ]*\) [ABD] __bss_start$$/-0x\1/p' \
>                        -e 's/^\([^ ]*\) [ABD] __bss_stop$$/+0x\1/p') )) )
>  LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
>
>
>
>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada



-- 
Best Regards
Masahiro Yamada
