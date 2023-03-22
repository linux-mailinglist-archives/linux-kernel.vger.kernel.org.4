Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113486C50E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCVQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjCVQgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2206C60ABF;
        Wed, 22 Mar 2023 09:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB1F4621D1;
        Wed, 22 Mar 2023 16:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8474FC433EF;
        Wed, 22 Mar 2023 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679503000;
        bh=JtpcCBVdb1GEST8Z6EfeHFkUnh2oyShLs1D02L46UQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SaUpxaISsWjOvBWJ/PPWNYvcn0RFA8yaR1kIClK/mOxQ5uLIPk6RIoWaGeVvVefH3
         R6SeG4ALqfHZBo3r7xKSAkNdp75V86ue7yemobPGked6puYhKmvmpjpU4/n5h7+Z72
         IJWgirTDYBwd1a9ZL6TlRL0RhQz10h0Tve4PKSs2OdzhWUeuBkr072BFP528tVbc61
         IatGkYTXKcuj9b+0ZTmSKf0CNg91dT18Ce3RQ6koWEsEEC1La0PdHPZBL5dtxHRtyV
         2wZX6A5aPDthSN4rY/gIyW/2AGehpD/86Byts2+VDBlPrn3/7bXhmt2SU5CFlMD4tA
         qUYKAUd10kxFA==
Date:   Wed, 22 Mar 2023 09:36:37 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-toolchains@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: Linux 6.3-rc3
Message-ID: <20230322163637.GA918620@dev-arch.thelio-3990X>
References: <CAHk-=wiPd8R8-zSqTOtJ9KYeZLBByHug7ny3rgP-ZqzpP_KELg@mail.gmail.com>
 <20230320180501.GA598084@dev-arch.thelio-3990X>
 <CAHk-=wgSqpdkeJBb92M37JNTdRQJRnRUApraHKE8uGHTqQuu2Q@mail.gmail.com>
 <20230320185337.GA615556@dev-arch.thelio-3990X>
 <87pm91uf9c.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pm91uf9c.fsf@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:44:47PM +0200, Kalle Valo wrote:
> Nathan Chancellor <nathan@kernel.org> writes:
> 
> > On Mon, Mar 20, 2023 at 11:26:17AM -0700, Linus Torvalds wrote:
> >> On Mon, Mar 20, 2023 at 11:05 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >> >
> >> > On the clang front, I am still seeing the following warning turned error
> >> > for arm64 allmodconfig at least:
> >> >
> >> >   drivers/gpu/host1x/dev.c:520:6: error: variable 'syncpt_irq' is uninitialized when used here [-Werror,-Wuninitialized]
> >> >           if (syncpt_irq < 0)
> >> >               ^~~~~~~~~~
> >> 
> >> Hmm. I do my arm64 allmodconfig builds with gcc, and I'm surprised
> >> that gcc doesn't warn about this.
> >
> > Perhaps these would make doing allmodconfig builds with clang more
> > frequently less painful for you?
> >
> > https://lore.kernel.org/llvm/20230319235619.GA18547@dev-arch.thelio-3990X/
> 
> Thank you, at least for me this is really helpful.

Really glad to hear! I hope this helps make testing and verifying
changes with clang and LLVM easier for developers and maintainers.

> I tried now clang for the first time but seeing a strange problem.
> 
> I prefer to define the compiler in GNUmakefile so it's easy to change
> compilers and I don't need to remember the exact command line. So I have
> this in the top level GNUmakefile (all the rest commented out):
> 
> LLVM=/opt/clang/llvm-16.0.0/bin/
> 
> If I run 'make oldconfig' it seems to use clang but after I run just
> 'make' it seems to switch back to the host GCC compiler and ask for GCC
> specific config questions again. Workaround for this seems to be adding
> 'export LLVM' to GNUmakefile, after that also 'make' uses clang as
> expected.

Interesting... I just tested with a basic GNUmakefile and everything
seems to work fine without an export. At the same time, the export
should not hurt anything, so as long as it works, that is what matters.

    $ gcc --version
    fish: Unknown command: gcc


    $ fd -t x . $CBL_TC_LLVM_STORE/16.0.0/bin -x basename
    clang-16
    llvm-nm
    llvm-objdump
    llvm-objcopy
    llvm-symbolizer
    llvm-strings
    llvm-readobj
    llvm-dwarfdump
    lld
    llvm-ar


    $ cat GNUmakefile
    LLVM := $(CBL_TC_LLVM_STORE)/16.0.0/bin/

    include Makefile


    $ make -sj(nproc) defconfig


    $ head -13 .config
    #
    # Automatically generated file; DO NOT EDIT.
    # Linux/x86 6.3.0-rc3 Kernel Configuration
    #
    CONFIG_CC_VERSION_TEXT="ClangBuiltLinux clang version 16.0.0"
    CONFIG_GCC_VERSION=0
    CONFIG_CC_IS_CLANG=y
    CONFIG_CLANG_VERSION=160000
    CONFIG_AS_IS_LLVM=y
    CONFIG_AS_VERSION=160000
    CONFIG_LD_VERSION=0
    CONFIG_LD_IS_LLD=y
    CONFIG_LLD_VERSION=160000


    $ make -sj(nproc) init/main.o


    $ $CBL_TC_LLVM_STORE/16.0.0/bin/llvm-readelf -p .comment init/main.o
    String dump of section '.comment':
    [     1] ClangBuiltLinux clang version 16.0.0


I added an informational print and I always saw the correct value:

diff --git a/Makefile b/Makefile
index a2c310df2145..070394c4cb8c 100644
--- a/Makefile
+++ b/Makefile
@@ -431,6 +431,7 @@ HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
 HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
 ifneq ($(LLVM),)
+$(info LLVM: $(LLVM))
 ifneq ($(filter %/,$(LLVM)),)
 LLVM_PREFIX := $(LLVM)
 else ifneq ($(filter -%,$(LLVM)),)

If you have any further issues, please do not hesitate to reach out!

Cheers,
Nathan
