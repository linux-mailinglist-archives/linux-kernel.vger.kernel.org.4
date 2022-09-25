Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065105E90A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 03:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIYBXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 21:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiIYBXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 21:23:38 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C77260D
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:23:36 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 28P1NF4v024435
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 10:23:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 28P1NF4v024435
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664068995;
        bh=wcy17lhVeaFvvhqspD1VtBx9l8ybKL1EsOARSQKPsAA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ezESg2phz67myHt1bc99AS5anJgOYB5MXNC1EYM6fSMxeVvKu9pKfMZcrNDMg2fb8
         t9p8vSHWo+dG3ocoS5j44CtV7z5Oeg+Uw2a7Q78E/z2e2e+jNXrRj42sloa7poXeem
         6y6e6xurOs3X2bxkkn00l/CnsE8c6UHYjVuqG42VHmjmMUhZ2JApyQ3Mq6hlxdB4O0
         Q2ff+MQ7mU51AoxFZjMXdk4z+o7TRKZ8rbctWk1uRK8LfbqPYqm76nXy+DI24jbJ79
         GprtVL7gCcx5mheDZfBCaQ2ZhyjpGlVO1P+gsHMYtNfU+1hS2jp9BoDOHIafwSdAdf
         FkgCcIiyPQmRA==
X-Nifty-SrcIP: [209.85.167.180]
Received: by mail-oi1-f180.google.com with SMTP id s125so4388514oie.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 18:23:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf1Uyf5cSiD50kGJGKcDncybqz2hle2LtNlPOhy4uwbU1qon2fCo
        WBMdhUO/YpSgjUMc4KB9DDSsCUUa5y06xDXrSK0=
X-Google-Smtp-Source: AMsMyM78F9oRvL/JaZHExdRddIxrTZMIBVAq1fKW09ZWD2NQwNhABlAWFfCsQTOhhxVykQSMpBJaowS/3AsoKQXv62g=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr11934584oib.194.1664068994564; Sat, 24
 Sep 2022 18:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com> <CAK7LNARk74U8AWzOVHP1pPVy2PNSMsNiyPL8bmFcYs6DkheorA@mail.gmail.com>
 <CAK7LNAQRV_Z+0V9gB0=KWKpQE=sH-Y4QVhgSjxc==412U=_LBw@mail.gmail.com>
In-Reply-To: <CAK7LNAQRV_Z+0V9gB0=KWKpQE=sH-Y4QVhgSjxc==412U=_LBw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 25 Sep 2022 10:22:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqGJCKRmL=vhH1_Ms--7QYTT8YTFxExejDs0_bQD4Ptg@mail.gmail.com>
Message-ID: <CAK7LNATqGJCKRmL=vhH1_Ms--7QYTT8YTFxExejDs0_bQD4Ptg@mail.gmail.com>
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2022 at 11:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, Sep 24, 2022 at 4:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Tue, Sep 20, 2022 at 2:08 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > cc-ifversion is GCC specific. Replace it with compiler specific
> > > variants. Update the users of cc-ifversion to use these new macros.
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/350
> > > Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
> > > Suggested-by: Bill Wendling <morbo@google.com>
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > > Changes v3 -> v4:
> > > * Split into its own patch again from series, as per Masahiro.
> > > * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
> > >   clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.
> >
> >
> > Applied to linux-kbuild.
> > Thanks.
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>
>
>
>
>
> I noticed a small flaw now.
>
>
>
> $ make mrproper; make
> /bin/sh: 1: [: -ge: unexpected operator
> ***
> *** Configuration file ".config" not found!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> Makefile:711: include/config/auto.conf.cmd: No such file or directory
> make: *** [Makefile:720: .config] Error 1
>
>
>
>
>
>
>
>
> This fails anyway, but it shows annoying
>
>    /bin/sh: 1: [: -ge: unexpected operator
>
>
>
> It is emit by this line:
>
>   KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
>
>
>
>
> When $(CONFIG_GCC_VERSION) is empty, it becomes invalid shell code:
>
>      [ -ge $(1) ] && echo y
>
>
>
>
>
> Now I just recalled why I wrote the original code like this:
>
>
>   cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ]  ...
>
>
>
>
> --
> Best Regards
> Masahiro Yamada







I squashed the following code diff.
Please let me know if there is a problem.









diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 9d18fb91890e..20d353dcabfb 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -63,11 +63,11 @@ cc-disable-warning = $(call try-run,\

 # gcc-min-version
 # Usage: cflags-$(call gcc-min-version, 70100) += -foo
-gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
+gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)

 # clang-min-version
 # Usage: cflags-$(call clang-min-version, 110000) += -foo
-clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] && echo y)
+clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)

 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)






-- 
Best Regards
Masahiro Yamada
