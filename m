Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B405E8D50
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiIXO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiIXO3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 10:29:38 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879515FBC
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:29:35 -0700 (PDT)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 28OETF8Q016655
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 23:29:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 28OETF8Q016655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664029756;
        bh=WN5SfVJRQHxQx5Ik0fOFCLRbmFwj2uxRFSBKG7Z/Rzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VZo0vTzCf24dRdtmm0jZzwU4gNcp9x/69MQPbP1sJCOw/6I/fyH25PSJphc8FSRzd
         ZT2WGyPMDPhddAUwJYdL1OO13zEfBTt0AJOGOLXjVupiMMGPKG/3DYgIuVFvlZyZY9
         r20OmYjwyzBwdTU1CeixMut6r19kHgVfeGKHr0WBX0eAdRKhw/S8/9VmGF5KpOr8bY
         VyzJzb+QFM5cFyZ5Pv4iMf7mH6w8nYuWbtsm1k3geSLQLUpPGDAA44zRaj7l00PLf/
         AzE0bh3OVrYYdZoSqsDma1IeNXWZ3pV9GU2pbb2iMPIRd+Piddit+n4dnLLDmH0BrI
         m9ishjlgum9zA==
X-Nifty-SrcIP: [209.85.161.54]
Received: by mail-oo1-f54.google.com with SMTP id t4-20020a4aa3c4000000b00475624f2369so467915ool.3
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 07:29:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf0oczJNZWJgpnbSRfV4jS84jaWLPYBPPcFO5cPzSPG+ImyudwXY
        HwQuosuyeR3r+0Yi1tIUhglgOQDfmYnfGjg/ZN4=
X-Google-Smtp-Source: AMsMyM6KFBSh96Q9GRcRytcg/VzsIS3c2e+G514oSoFzPGXc17TWuaO1TCBtHpxAP+/qarm347cvjiTENqpPBCt+iAE=
X-Received: by 2002:a05:6820:1992:b0:475:c2c0:3f92 with SMTP id
 bp18-20020a056820199200b00475c2c03f92mr5517770oob.96.1664029754974; Sat, 24
 Sep 2022 07:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com> <CAK7LNARk74U8AWzOVHP1pPVy2PNSMsNiyPL8bmFcYs6DkheorA@mail.gmail.com>
In-Reply-To: <CAK7LNARk74U8AWzOVHP1pPVy2PNSMsNiyPL8bmFcYs6DkheorA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 24 Sep 2022 23:28:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQRV_Z+0V9gB0=KWKpQE=sH-Y4QVhgSjxc==412U=_LBw@mail.gmail.com>
Message-ID: <CAK7LNAQRV_Z+0V9gB0=KWKpQE=sH-Y4QVhgSjxc==412U=_LBw@mail.gmail.com>
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

On Sat, Sep 24, 2022 at 4:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 2:08 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > cc-ifversion is GCC specific. Replace it with compiler specific
> > variants. Update the users of cc-ifversion to use these new macros.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/350
> > Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
> > Suggested-by: Bill Wendling <morbo@google.com>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes v3 -> v4:
> > * Split into its own patch again from series, as per Masahiro.
> > * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
> >   clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.
>
>
> Applied to linux-kbuild.
> Thanks.
>
>
>
> --
> Best Regards
> Masahiro Yamada






I noticed a small flaw now.



$ make mrproper; make
/bin/sh: 1: [: -ge: unexpected operator
***
*** Configuration file ".config" not found!
***
*** Please run some configurator (e.g. "make oldconfig" or
*** "make menuconfig" or "make xconfig").
***
Makefile:711: include/config/auto.conf.cmd: No such file or directory
make: *** [Makefile:720: .config] Error 1








This fails anyway, but it shows annoying

   /bin/sh: 1: [: -ge: unexpected operator



It is emit by this line:

  KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than




When $(CONFIG_GCC_VERSION) is empty, it becomes invalid shell code:

     [ -ge $(1) ] && echo y





Now I just recalled why I wrote the original code like this:


  cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ]  ...




-- 
Best Regards
Masahiro Yamada
