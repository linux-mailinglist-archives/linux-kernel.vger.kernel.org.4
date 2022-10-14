Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A85FF52D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJNVVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJNVVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:21:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDE24943
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:21:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2722CB82276
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8D3C433C1;
        Fri, 14 Oct 2022 21:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665782464;
        bh=W830SBSAHyVTFgK+oBOpumaz6zT/ESPPX+briRUidUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fim6nGXadK0daKWDcTjB7DuqqVbheHWqI2TI75c7Me6Bb8S3vzMN3U0upV68UhufP
         1i7dZ5O2wpChIqZQ8dIRaqGak5vjcw//6u3ymWrLr5ASvqHi1OP9fhCGw1IXIRiGuB
         Jj/Pbgff2MKLGb9XsIkR+e/T/z8JaWIgnDbnE44NcbbyJNjMnKikDazX9GyZyienZm
         OcwMSL3Jfb0MAwa7tLS6E0Cd2uPt6gSOPs3C/FQxDuGaHrsRmiwL3hsQPeTr36nSph
         B5VbR3/aRiTs+aFh+VkfhAA4ZxcQpaZk66qpJro2r0Z9yEm5bSAZ/8Jq5tbBrgKWnG
         98SFTw/7J2ndg==
Date:   Fri, 14 Oct 2022 14:21:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 4/4] ARM: pass -march= only to compiler
Message-ID: <Y0nSvqpFMXsNzpaA@dev-arch.thelio-3990X>
References: <20221014201354.3190007-1-ndesaulniers@google.com>
 <20221014201354.3190007-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014201354.3190007-5-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:13:54PM -0700, Nick Desaulniers wrote:
> When both -march= and -Wa,-march= are specified for assembler or
> assembler-with-cpp sources, GCC and Clang will prefer the -Wa,-march=
> value but Clang will warn that -march= is unused.
> 
> warning: argument unused during compilation: '-march=armv6k'
> [-Wunused-command-line-argument]
> 
> This is the top group of warnings we observe when using clang to
> assemble the kernel via `ARCH=arm make LLVM=1`.
> 
> Split the arch-y make variable into two, so that -march= flags only get
> passed to the compiler, not the assembler. -D flags are added to
> KBUILD_CPPFLAGS which is used for both C and assembler-with-cpp sources.
> 
> Clang is trying to warn that it doesn't support different values for
> -march= and -Wa,-march= (like GCC does, but the kernel doesn't need this)
> though the value of the preprocessor define __thumb2__ is based on
> -march=. Make sure to re-set __thumb2__ via -D flag for assembler
> sources now that we're no longer passing -march= to the assembler. Set
> it to a different value than the preprocessor would for -march= in case
> -march= gets accidentally re-added to KBUILD_AFLAGS in the future.
> Thanks to Ard and Nathan for this suggestion.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1315
> Link: https://github.com/ClangBuiltLinux/linux/issues/1587
> Link: https://github.com/llvm/llvm-project/issues/55656
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

This passed through my build matrix on top of commit dca45efbe3c8
("Merge tag 'sound-fix-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound") and I saw no
additional warnings/errors:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v3 -> v4:
> * Add -D__thumb2__=2 to KBUILD_AFLAGS as per in-person discussion with
>   Ard and Nathan, and their SB tags.
> * Reword commit message.
> 
>  arch/arm/Makefile | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index ee888070b2ff..b58998749ead 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -60,21 +60,34 @@ endif
>  KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
>  
>  # This selects which instruction set is used.
> +arch-$(CONFIG_CPU_32v7M)	:=-march=armv7-m
> +arch-$(CONFIG_CPU_32v7)		:=-march=armv7-a
> +arch-$(CONFIG_CPU_32v6)		:=-march=armv6
> +# Only override the compiler option if ARMv6. The ARMv6K extensions are
> +# always available in ARMv7
> +ifeq ($(CONFIG_CPU_32v6),y)
> +arch-$(CONFIG_CPU_32v6K)	:=-march=armv6k
> +endif
> +arch-$(CONFIG_CPU_32v5)		:=-march=armv5te
> +arch-$(CONFIG_CPU_32v4T)	:=-march=armv4t
> +arch-$(CONFIG_CPU_32v4)		:=-march=armv4
> +arch-$(CONFIG_CPU_32v3)		:=-march=armv3m
> +
>  # Note that GCC does not numerically define an architecture version
>  # macro, but instead defines a whole series of macros which makes
>  # testing for a specific architecture or later rather impossible.
> -arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
> -arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
> -arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 -march=armv6
> -# Only override the compiler opt:ion if ARMv6. The ARMv6K extensions are
> +cpp-$(CONFIG_CPU_32v7M)		:=-D__LINUX_ARM_ARCH__=7
> +cpp-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7
> +cpp-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6
> +# Only override the compiler option if ARMv6. The ARMv6K extensions are
>  # always available in ARMv7
>  ifeq ($(CONFIG_CPU_32v6),y)
> -arch-$(CONFIG_CPU_32v6K)	:=-D__LINUX_ARM_ARCH__=6 -march=armv6k
> +cpp-$(CONFIG_CPU_32v6K)		:=-D__LINUX_ARM_ARCH__=6
>  endif
> -arch-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5 -march=armv5te
> -arch-$(CONFIG_CPU_32v4T)	:=-D__LINUX_ARM_ARCH__=4 -march=armv4t
> -arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
> -arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3m
> +cpp-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5
> +cpp-$(CONFIG_CPU_32v4T)		:=-D__LINUX_ARM_ARCH__=4
> +cpp-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4
> +cpp-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3
>  
>  # This selects how we optimise for the processor.
>  tune-$(CONFIG_CPU_ARM7TDMI)	:=-mtune=arm7tdmi
> @@ -119,15 +132,16 @@ AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
>  
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>  CFLAGS_ISA	:=-mthumb -Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
> -AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
> +AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb -D__thumb2__=2
>  else
>  CFLAGS_ISA	:=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
>  AFLAGS_ISA	:=$(CFLAGS_ISA)
>  endif
>  
>  # Need -Uarm for gcc < 3.x
> +KBUILD_CPPFLAGS	+=$(cpp-y)
>  KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
> -KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> +KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) -Wa,$(arch-y) $(tune-y) -include asm/unified.h -msoft-float
>  
>  CHECKFLAGS	+= -D__arm__
>  
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
