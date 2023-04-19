Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467E66E81D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDSTYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDSTYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440B855B8;
        Wed, 19 Apr 2023 12:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D50896400C;
        Wed, 19 Apr 2023 19:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9815C433EF;
        Wed, 19 Apr 2023 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681932288;
        bh=4QErbcQVxsef7nC4K+1UU0x1X8M2fq6cPeGxV75cTN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SuHK5USY9RbVcHGs8P/Jm9pllERWr8UIcJKmp8Kk2DJX/Q7kyX/SRByuIIY77WwCd
         x/QPz/ElO0Rutepw0fBcjIFc3aTKQ1UkkoVXjb5hJ5Na4Ak7KiNjshYERzYVe0823Y
         viy4gkMNx+D/rZatBzW9A/912qVQZ7uNkeYbWRa10mrKedXcMlcQob5cbFHYWcxWNE
         m7uD+m/Ys93+eXQ8P/db+GzXiQcm0ThOPi+t67u95UIEj7zS18UYZ2RUrkfVBMLMlk
         sYdvwih2q2C3PLM0EwFERvoAXXZ6fMvG5Av7H8suKWR7Mdy5PmMwD9YA6rASwFN1WD
         KIQk1pOHwMKTA==
Date:   Wed, 19 Apr 2023 12:24:46 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: clang: do not use CROSS_COMPILE for target triple
Message-ID: <20230419192446.GA1993276@dev-arch.thelio-3990X>
References: <20230401170117.1580840-1-masahiroy@kernel.org>
 <20230403144758.GA3460665@dev-arch.thelio-3990X>
 <CAK7LNAQsgB-SC2t+9ZpDwJbME+BVt+Gur1ydTnHfBfMAfn_y0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQsgB-SC2t+9ZpDwJbME+BVt+Gur1ydTnHfBfMAfn_y0w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 10:02:12PM +0900, Masahiro Yamada wrote:
> On Mon, Apr 3, 2023 at 11:48 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > On Sun, Apr 02, 2023 at 02:01:17AM +0900, Masahiro Yamada wrote:
> > > The target triple is overridden by the user-supplied CROSS_COMPILE,
> > > but I do not see a good reason to support it. Users can use a new
> > > architecture without adding CLANG_TARGET_FLAGS_*, but that would be
> > > a rare case.
> > >
> > > Use the hard-coded and deterministic target triple all the time.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > I know of one bug where the value of '--target' matters:
> >
> > https://github.com/ClangBuiltLinux/linux/issues/1244
> 
> 
> I did not look into it closely, but if we say

Heh, neither did I when I wrote the initial response to this patch,
because that issue turns out to be entirely irrelevant for this patch :)

> "
> Using either CROSS_COMPILE=powerpc64-linux-gnu- or
> CROSS_COMPILE=powerpc-linux-gnu- fixes it.
> Using KCFLAGS=-v reveals that powerpc64le-linux-gnu-as is not getting
> the endianness information.
> ", why didn't we fix it like the following?

It is because this already technically happens under the hood with
clang. '--target=powerpc64le-linux-gnu -mbig-endian' is functionally
equivalent to '--target=powerpc64-linux-gnu'. The issue is that
'--target=powerpc64-linux-gnu' and '--target=powerpc-linux-gnu' were not
passing along '-mbig-endian' to the assembler, so
powerpc64le-linux-gnu-ld was expecting big endian object files due to
'-EB' in LDFLAGS but was getting little endian object files, since the
assembler's triple was little endian by default.

We could work around this in the kernel by explicitly passing
'-Wa,-mlittle-endian' for these older versions of clang but I do not
think it is worth it, especially since it will just get removed once we
no longer support clang-11, which is our next uprev.

TL;DR: Patch should be fine, issue is tangential.

>  diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
>  index 70b354fa1cb4..8dda7dc69c93 100644
>  --- a/scripts/Makefile.clang
>  +++ b/scripts/Makefile.clang
>  @@ -6,7 +6,7 @@ CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
>   CLANG_TARGET_FLAGS_hexagon     := hexagon-linux-musl
>   CLANG_TARGET_FLAGS_m68k                := m68k-linux-gnu
>   CLANG_TARGET_FLAGS_mips                := mipsel-linux-gnu
>  -CLANG_TARGET_FLAGS_powerpc     := powerpc64le-linux-gnu
>  +CLANG_TARGET_FLAGS_powerpc     := powerpc64-linux-gnu
>   CLANG_TARGET_FLAGS_riscv       := riscv64-linux-gnu
>   CLANG_TARGET_FLAGS_s390                := s390x-linux-gnu
>   CLANG_TARGET_FLAGS_x86         := x86_64-linux-gnu
> 
> 
> 
> We do not need to test all possible target triples.
> 
> 
> We can just use the one that is known to work.
> Anyway, I will apply this patch. Thanks.
> 
> 
> >
> > This was fixed in LLVM 12.0.0. We are not testing this in our CI though,
> > so we would not get bit by this (we could bump the minimum supported
> > version of LLVM to 12.0.0 for this, we have talked recently about doing
> > it for other reasons).
> >
> > I guess I cannot really think of a good reason not to do this aside from
> > that; the target triple should only affect code generation, rather than
> > tool selection (i.e., this does not take away the ability to use a
> > custom set of binutils with clang).
> >
> > However, Nick is currently OOO and I would like his opinion voiced
> > before we commit to this. Consider this a tentative:
> >
> > Acked-by: Nathan Chancellor <nathan@kernel.org>
> >
> > > ---
> > >
> > >  scripts/Makefile.clang | 8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> > > index 70b354fa1cb4..9076cc939e87 100644
> > > --- a/scripts/Makefile.clang
> > > +++ b/scripts/Makefile.clang
> > > @@ -13,15 +13,11 @@ CLANG_TARGET_FLAGS_x86            := x86_64-linux-gnu
> > >  CLANG_TARGET_FLAGS_um                := $(CLANG_TARGET_FLAGS_$(SUBARCH))
> > >  CLANG_TARGET_FLAGS           := $(CLANG_TARGET_FLAGS_$(SRCARCH))
> > >
> > > -ifeq ($(CROSS_COMPILE),)
> > >  ifeq ($(CLANG_TARGET_FLAGS),)
> > > -$(error Specify CROSS_COMPILE or add '--target=' option to scripts/Makefile.clang)
> > > +$(error add '--target=' option to scripts/Makefile.clang)
> > >  else
> > >  CLANG_FLAGS  += --target=$(CLANG_TARGET_FLAGS)
> > > -endif # CLANG_TARGET_FLAGS
> > > -else
> > > -CLANG_FLAGS  += --target=$(notdir $(CROSS_COMPILE:%-=%))
> > > -endif # CROSS_COMPILE
> > > +endif
> > >
> > >  ifeq ($(LLVM_IAS),0)
> > >  CLANG_FLAGS  += -fno-integrated-as
> > > --
> > > 2.37.2
> > >
> 
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
