Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02A462E555
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 20:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiKQTeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 14:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239207AbiKQTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 14:34:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE4917AA0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 11:34:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 586496223A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 19:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E0AC433D6;
        Thu, 17 Nov 2022 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668713671;
        bh=x/eDxY1pyJyhB8wMOY8IIA2cEfIhUVqCdUypXu/Eq0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sZc4fYa2IJfJaVKLxg01diomxKZ98t/zlYz6zP2qPq/HKPgs0XFbmDVKQqtC/Zqf5
         4q/mQdw4wbKUa8RKk2nFNTZ5CjxyZJUmDCe2YmZBV5/8UmBp35itvXmUyjV2fdD8xx
         Vj0M7+Gk6rYBjazUR6Dfjqms+i2Nzmdm3lBbhZYqYOZwfxHxzAgJWQBDL5Q+fbKP43
         bTt30ikHLmDvMdVB8KSNrQj2ISpeNkjnqgIcPq/v0M45oFgxNWU2AQyoOx/YDQWLkF
         fUGW4lWQKurQDjvZXjDOXMxWb3h9rPgKjX2LOlS5j/tyBT+6Ba8n67d40RTCukwfwO
         bc+Nyiqng1phw==
Date:   Thu, 17 Nov 2022 12:34:29 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sylvestre Ledru <sylvestre@debian.org>,
        Serge Guelton <sguelton@mozilla.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: [PATCH] ARM: Drop '-mthumb' from AFLAGS_ISA
Message-ID: <Y3aMxfhBw9YsWiKr@dev-arch.thelio-3990X>
References: <20221114225719.1657174-1-nathan@kernel.org>
 <CAKwvOdn67r3ZYb5XZkae3i5797GGV3=8=nLC7kT2d4On3OEm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn67r3ZYb5XZkae3i5797GGV3=8=nLC7kT2d4On3OEm5A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:15:09AM -0800, Nick Desaulniers wrote:
> On Mon, Nov 14, 2022 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > When building with CONFIG_THUMB2_KERNEL=y + a version of clang from
> > Debian, the following warning occurs frequently:
> 
> I also needed to explicitly set
> CROSS_COMPILE=arm-linux-gnueabihf-
> to reproduce.  Please add that detail to the commit message.  Thanks
> for helping spot that difference on IRC.

Ack.

> It sounds like tuxmake (which our CI is built on) and perhaps kernelCI
> are both setting that variable, which is no longer necessary when
> using LLVM=1 for ARCH=arm.

Right; I suspect that it is unlikely that either of those entities will
drop CROSS_COMPILE because they aim to work with multiple trees, which
may still require CROSS_COMPILE. Maybe in five years when 5.15 is the
oldest stable release that we support ;)

> Not CROSS_COMPILE=arm-linux-gnueabi- like the triple we use by default
> for ARCH=arm in scripts/Makefile.clang.  So this issue arises from:
> 1. using debian's clang, which is carrying an out of tree patch affecting this.
> 2. using `CROSS_COMPILE=arm-linux-gnueabihf-`.
> 
> The use of both of those in conjunction I'd like to think would be
> relatively unlikely, but it seems that we have both CI systems doing
> this (and the patch LGTM regardless of changing the CI).
> 
> >
> >   <built-in>:383:9: warning: '__thumb2__' macro redefined [-Wmacro-redefined]
> >   #define __thumb2__ 2
> >           ^
> >   <built-in>:353:9: note: previous definition is here
> >   #define __thumb2__ 1
> >           ^
> >   1 warning generated.
> >
> > Debian carries a downstream patch that changes the default CPU of the
> > arm-linux-gnueabihf target from 'arm1176jzf-s' (v6) to 'cortex-a7' (v7).
> > As a result, '-mthumb' defines both '__thumb__' and '__thumb2__'. The
> > define of '__thumb2__' via the command line was purposefully added to
> > catch a situation like this.
> 
> And we caught something!  It's almost like Ard has sight-beyond-sight
> or something when he made that suggestion. Coincidence? I think not...
> :P

Or perhaps a deep familiarity with the potential pitfalls of all this ;)

> > In a similar vein as commit 26b12e084bce ("ARM: 9264/1: only use
> > -mtp=cp15 for the compiler"), do not add '-mthumb' to AFLAGS_ISA, as it
> > is already passed to the assembler via '-Wa,-mthumb' and '__thumb2__' is
> > already defined for preprocessing.
> >
> > Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")
> > Link: htps://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/17354b030ac4252ff6c5e9d01f4eba28bd406b2d/debian/patches/930008-arm.diff
> 
> Would you mind using
> https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/snapshot/debian/patches/930008-arm.diff
> as the link instead? The link on this commit message is a diff against
> llvm-14, not ToT which is currently llvm-16; the context is quite
> different as the logic moved source files completely.  Though it does
> look like Sylvestre has not yet cut a 16 branch for debian's patches.

I would rather use an actual hash to reduce the risk of the link going
stale from either a branch rename or file rename/removal. I can use a
hash from the snapshot branch instead, if that would work for you?

> If not, at least re-add the missing `t` from the protocol in the URL
> (s/htps/https/).

Oh whoops, good catch!

> > Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> I verified this locally with LLVM built from source, comparing no out
> of tree patches vs just debian's 930008-arm.diff applied.
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the testing and review! I will send a v2 later today and
submit it to Russell's patch tracker on Monday so that it can be picked
up for -next.

> ---
> 
> If memory serves, this is perhaps the third time downstream debian
> patches to llvm have caused us initially-difficult-to-reproduce bugs.
> Sylvestre, going forward, would you mind please giving your diff's
> more descriptive file names, or making them actual commits with some
> context in the commit message?  Time and resource permitting,
> submitting them upstream, even if they're not accepted, but pointing
> to the upstream discussion (if any) from commit messages would provide
> us more context for these kind of things.  Maybe Serge could help you
> burn down those out of tree patches? ;)

At the very least, it is the second time; the first was
https://github.com/ClangBuiltLinux/linux/issues/1355.

> > ---
> >  arch/arm/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 357f0d9b8607..d1ebb746ff40 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -131,8 +131,9 @@ endif
> >  AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> >
> >  ifeq ($(CONFIG_THUMB2_KERNEL),y)
> > -CFLAGS_ISA     :=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
> > +CFLAGS_ISA     :=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
> >  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb -D__thumb2__=2
> > +CFLAGS_ISA     +=-mthumb
> >  else
> >  CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
> >  AFLAGS_ISA     :=$(CFLAGS_ISA)
> >
> > base-commit: 0c52591d22e99759da3793f19249bbf45ad742bd
> > --
> > 2.38.1
> >

Cheers,
Nathan
