Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1085F36EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJCUT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJCUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:19:48 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5B72672;
        Mon,  3 Oct 2022 13:19:44 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 293KJSAf030466;
        Tue, 4 Oct 2022 05:19:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 293KJSAf030466
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1664828370;
        bh=en/eOlsz+VpPl2StotBX9dnQ8w056gBCRhQH40Az1YE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rNK4TK6mFMUpfOVnSbGdnEDqCJe21xvYHNN2jg0GbY0lSb0LpXoFOgcqmUKG5Ttbk
         nG7pXu++B6rmr7yEgBouLmfWFql2yL7o1V7LhDhu+GGQpvJk4Xe5ILOmPtG//2CsrP
         53WtomhLT1JZVd7caqxenPXbLeOhlgzI/7rchiJTpbWdMFL8oQfhbbOgSY+PVrbhye
         784GMAQdfq98gXN5G3hCjspsK1eY1W4XBPknYnwmtZ2xJmAcGTE70YnlbfTkkytLvB
         7x4HC6zWyc3TDx4MA1/cYXO2kbG6VdV1ERFN6oeaYCBgQmycUAiKrnZkh6ObVA9Rd6
         +7hHqhNhuhGpA==
X-Nifty-SrcIP: [209.85.167.52]
Received: by mail-lf1-f52.google.com with SMTP id s20so2541273lfi.11;
        Mon, 03 Oct 2022 13:19:29 -0700 (PDT)
X-Gm-Message-State: ACrzQf1tmo8hJzjV9CglSTD0Lx0ibtEFlKaEE6rXKKHRM9mkrQipzPb+
        JFuI5q55FoUxi++EfDV2j2f1zGM1eX7YB6gZycU=
X-Google-Smtp-Source: AMsMyM4nlxjJWmlovLd9PysPPVMnO+LKufcwwqls+KOJ7WdH9CE5GkWTDYwUMVBbHusWmMyhRMoCR5P6dxS2NfoDjvk=
X-Received: by 2002:a19:5f4b:0:b0:49f:a4b7:3f1c with SMTP id
 a11-20020a195f4b000000b0049fa4b73f1cmr7465846lfj.333.1664828367529; Mon, 03
 Oct 2022 13:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221002181107.51286-1-masahiroy@kernel.org> <20221002181107.51286-3-masahiroy@kernel.org>
 <YzsXa0GCGT6A0szV@dev-arch.thelio-3990X>
In-Reply-To: <YzsXa0GCGT6A0szV@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 4 Oct 2022 05:18:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASnp4DA9AADx4Nj9b_h6r5wfPFUaonfmOfaHaSizpyfgg@mail.gmail.com>
Message-ID: <CAK7LNASnp4DA9AADx4Nj9b_h6r5wfPFUaonfmOfaHaSizpyfgg@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig.debug: add toolchain checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 2:10 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Oct 03, 2022 at 03:11:06AM +0900, Masahiro Yamada wrote:
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT passes the -g option to the
> > command line. The actual DWARF version is up to the toolchain.
> >
> > The combination of GCC and GAS works fine, and Clang with the integrated
> > assembler is good too.
> >
> > The combination of Clang and GAS is a bit tricky, but at least, the
> > default -g flag worked until LLVM 14 was released because Clang <=13
> > defaults to DWARF v4.
> >
> > Clang 14 switched to DWARF v5 by default.
> >
> > Now, CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT has the same issue as
> > addressed by commit 98cd6f521f10 ("Kconfig: allow explicit opt in to
> > DWARF v5").
> >
> > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y for Clang >= 14 and
> > GAS < 2.35 produces a ton of errors like follows:
> >
> >   /tmp/main-c2741c.s: Assembler messages:
> >   /tmp/main-c2741c.s:109: Error: junk at end of line, first unrecognized character is `"'
> >   /tmp/main-c2741c.s:109: Error: file number less than one
> >
> > Add 'depends on' to check toolchains.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  lib/Kconfig.debug | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f4b2165f24db..cc90414d492e 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -253,6 +253,7 @@ config DEBUG_INFO_NONE
> >  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> >       bool "Rely on the toolchain's implicit default DWARF version"
> >       select DEBUG_INFO
> > +     depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> >       help
> >         The implicit default version of DWARF debug info produced by a
> >         toolchain changes over time.
> > --
> > 2.34.1
> >
> >
>
> Could we do something like this instead? Bikeshed the configuration
> names as much as you want but we are duplicating most of this
> conditional in a few different places so it would be good to consolidate
> those in my opinion. Even though the DWARF4 and DWARF5 conditions are
> the same, they might diverge so I think it makes sense to keep them
> separate.
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cc90414d492e..8e34a639cd40 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -231,6 +231,17 @@ config DEBUG_INFO
>           in the "Debug information" choice below, indicating that debug
>           information will be generated for build targets.
>
> +config CC_AND_AS_SUPPORT_DWARF4
> +       def_bool !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> +
> +config CC_AND_AS_SUPPORT_DWARF5
> +       def_bool !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> +
> +config CC_AND_AS_SUPPORT_DWARF_DEFAULT
> +       bool
> +       default y if CC_AND_AS_SUPPORT_DWARF5 && (CLANG_VERSION >= 140000 || GCC_VERSION >= 110000)
> +       default y if CC_AND_AS_SUPPORT_DWARF4 && (CLANG_VERSION < 140000 || GCC_VERSION < 110000)


No, this is an overkill.




In my patch, you can enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
for the combination of:
    CC_IS_CLANG=y
    CLANG_VERSION < 140000
    AS_IS_GNU=y
    AS_VERSION < 23502

But, your code disallows it.

You are requiring binutils 2.35.2 for Clang+GAS, but
it is not necessary.







>  choice
>         prompt "Debug information"
>         depends on DEBUG_KERNEL
> @@ -253,7 +264,7 @@ config DEBUG_INFO_NONE
>  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>         bool "Rely on the toolchain's implicit default DWARF version"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> +       depends on CC_AND_AS_SUPPORT_DWARF_DEFAULT
>         help
>           The implicit default version of DWARF debug info produced by a
>           toolchain changes over time.
> @@ -265,7 +276,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>  config DEBUG_INFO_DWARF4
>         bool "Generate DWARF Version 4 debuginfo"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> +       depends on CC_AND_AS_SUPPORT_DWARF4
>         help
>           Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
>           if using clang without clang's integrated assembler, and gdb 7.0+.
> @@ -277,7 +288,7 @@ config DEBUG_INFO_DWARF4
>  config DEBUG_INFO_DWARF5
>         bool "Generate DWARF Version 5 debuginfo"
>         select DEBUG_INFO
> -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> +       depends on CC_AND_AS_SUPPORT_DWARF5
>         help
>           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
>           5.0+ accepts the -gdwarf-5 flag but only had partial support for some



-- 
Best Regards
Masahiro Yamada
