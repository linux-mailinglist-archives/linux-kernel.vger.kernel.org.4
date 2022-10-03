Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DE85F3728
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJCUc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJCUcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:32:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FDA367BB;
        Mon,  3 Oct 2022 13:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50AECB815E0;
        Mon,  3 Oct 2022 20:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD526C433C1;
        Mon,  3 Oct 2022 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664829140;
        bh=8097KvnB831d5ZPSPTQ+6cWMWPRMudOKNi61uuYy4oQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lO6ULvauyvudSS8PzstswshNiAcPClYQxzQVryCAGQm+UYdWGHeifunU+bBoCQpIm
         uKfscS0AGmJQjEJ+QMMMwsSCDt9MsCUBCuwtzdEizvjnFavBJytjhJL/M9rPiF0T8z
         SXJa7q37YQm9EqVeYZ3YPdHg0OskT2Vj3yadUzVYAgnrWPT2v90l70RfCHCgfD+hPZ
         jyIhkyQXHPW0zqKDTxcHzguP7x5xiQMNiQIBaYHwsdfhRb8nAc3i18GEOGSYHEGDHp
         0RZtKyPY8+AFPls+G9PPOuVjAOe6MYFSNc3Vh4JAOHer74RCR/hSeqoXQdOKEUKPOD
         uWjQWbR5/XhyQ==
Date:   Mon, 3 Oct 2022 13:32:18 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] Kconfig.debug: add toolchain checks for
 DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
Message-ID: <YztG0rb+cgf0IfPo@dev-arch.thelio-3990X>
References: <20221002181107.51286-1-masahiroy@kernel.org>
 <20221002181107.51286-3-masahiroy@kernel.org>
 <YzsXa0GCGT6A0szV@dev-arch.thelio-3990X>
 <CAK7LNASnp4DA9AADx4Nj9b_h6r5wfPFUaonfmOfaHaSizpyfgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASnp4DA9AADx4Nj9b_h6r5wfPFUaonfmOfaHaSizpyfgg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 05:18:49AM +0900, Masahiro Yamada wrote:
> On Tue, Oct 4, 2022 at 2:10 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Mon, Oct 03, 2022 at 03:11:06AM +0900, Masahiro Yamada wrote:
> > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT passes the -g option to the
> > > command line. The actual DWARF version is up to the toolchain.
> > >
> > > The combination of GCC and GAS works fine, and Clang with the integrated
> > > assembler is good too.
> > >
> > > The combination of Clang and GAS is a bit tricky, but at least, the
> > > default -g flag worked until LLVM 14 was released because Clang <=13
> > > defaults to DWARF v4.
> > >
> > > Clang 14 switched to DWARF v5 by default.
> > >
> > > Now, CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT has the same issue as
> > > addressed by commit 98cd6f521f10 ("Kconfig: allow explicit opt in to
> > > DWARF v5").
> > >
> > > CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y for Clang >= 14 and
> > > GAS < 2.35 produces a ton of errors like follows:
> > >
> > >   /tmp/main-c2741c.s: Assembler messages:
> > >   /tmp/main-c2741c.s:109: Error: junk at end of line, first unrecognized character is `"'
> > >   /tmp/main-c2741c.s:109: Error: file number less than one
> > >
> > > Add 'depends on' to check toolchains.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  lib/Kconfig.debug | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > index f4b2165f24db..cc90414d492e 100644
> > > --- a/lib/Kconfig.debug
> > > +++ b/lib/Kconfig.debug
> > > @@ -253,6 +253,7 @@ config DEBUG_INFO_NONE
> > >  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> > >       bool "Rely on the toolchain's implicit default DWARF version"
> > >       select DEBUG_INFO
> > > +     depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> > >       help
> > >         The implicit default version of DWARF debug info produced by a
> > >         toolchain changes over time.
> > > --
> > > 2.34.1
> > >
> > >
> >
> > Could we do something like this instead? Bikeshed the configuration
> > names as much as you want but we are duplicating most of this
> > conditional in a few different places so it would be good to consolidate
> > those in my opinion. Even though the DWARF4 and DWARF5 conditions are
> > the same, they might diverge so I think it makes sense to keep them
> > separate.
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index cc90414d492e..8e34a639cd40 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -231,6 +231,17 @@ config DEBUG_INFO
> >           in the "Debug information" choice below, indicating that debug
> >           information will be generated for build targets.
> >
> > +config CC_AND_AS_SUPPORT_DWARF4
> > +       def_bool !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> > +
> > +config CC_AND_AS_SUPPORT_DWARF5
> > +       def_bool !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> > +
> > +config CC_AND_AS_SUPPORT_DWARF_DEFAULT
> > +       bool
> > +       default y if CC_AND_AS_SUPPORT_DWARF5 && (CLANG_VERSION >= 140000 || GCC_VERSION >= 110000)
> > +       default y if CC_AND_AS_SUPPORT_DWARF4 && (CLANG_VERSION < 140000 || GCC_VERSION < 110000)
> 
> 
> No, this is an overkill.
> 
> In my patch, you can enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> for the combination of:
>     CC_IS_CLANG=y
>     CLANG_VERSION < 140000
>     AS_IS_GNU=y
>     AS_VERSION < 23502
> 
> But, your code disallows it.
> 
> You are requiring binutils 2.35.2 for Clang+GAS, but
> it is not necessary.

Ah, I figured that part was necessary because of the condition added to
CONFIG_DEBUG_INFO_DWARF4 by commit 32ef9e5054ec ("Makefile.debug:
re-enable debug info for .S files") but I see now that was because of
some binutils behavior that you pointed out on Nick's v2 of that change,
which I failed to pay attention to because I had already reviewed the
change and did not read subsequent reviews/revisions as I should have,
so my apologies.

https://lore.kernel.org/CAK7LNATWDH01=ZKLnsxc0vcib1zGDbEq8jLQwhWP7HkkmSb_Mw@mail.gmail.com/

Regardless, I still think the duplication in these conditions is
unfortunate and I would like to see it cleaned up in some way but I
don't have a strong opinion on the matter. To the original change:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Once these are applied to linux-kbuild, I will send a v2 of my RISC-V
fix.

> >  choice
> >         prompt "Debug information"
> >         depends on DEBUG_KERNEL
> > @@ -253,7 +264,7 @@ config DEBUG_INFO_NONE
> >  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> >         bool "Rely on the toolchain's implicit default DWARF version"
> >         select DEBUG_INFO
> > -       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
> > +       depends on CC_AND_AS_SUPPORT_DWARF_DEFAULT
> >         help
> >           The implicit default version of DWARF debug info produced by a
> >           toolchain changes over time.
> > @@ -265,7 +276,7 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
> >  config DEBUG_INFO_DWARF4
> >         bool "Generate DWARF Version 4 debuginfo"
> >         select DEBUG_INFO
> > -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> > +       depends on CC_AND_AS_SUPPORT_DWARF4
> >         help
> >           Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
> >           if using clang without clang's integrated assembler, and gdb 7.0+.
> > @@ -277,7 +288,7 @@ config DEBUG_INFO_DWARF4
> >  config DEBUG_INFO_DWARF5
> >         bool "Generate DWARF Version 5 debuginfo"
> >         select DEBUG_INFO
> > -       depends on !CC_IS_CLANG || AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)
> > +       depends on CC_AND_AS_SUPPORT_DWARF5
> >         help
> >           Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> >           5.0+ accepts the -gdwarf-5 flag but only had partial support for some
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
