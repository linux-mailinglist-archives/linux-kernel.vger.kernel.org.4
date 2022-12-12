Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B6864A595
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbiLLRJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiLLRJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:09:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D996373;
        Mon, 12 Dec 2022 09:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9024DB80DD1;
        Mon, 12 Dec 2022 17:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 405F3C433D2;
        Mon, 12 Dec 2022 17:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670864942;
        bh=1uKfvnIvXPkzGzWXkQgGgIJ5yMv67egrw2dgfVsZ474=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmppyl/5WEObf5KqFxBOjavCQzX8Zu9SN7lAK0FSXhGAEkrD5dWHIgbd5y5/z17nN
         gK7ghVxaw+lm07Zo1aPMOEJzBXzzr4XBeNJJeT+YjoGmSvYr5w0PcwKiejiMP3BttZ
         7ftYlYnueTG2NrR23roHuBwql6+122FWR1/bqIVL+WYta0E71tO0pxTNGFMMtO1kYu
         CkRRm4gzssxZUxyO+sfdsGz4awMdh56uGwh94jvj4a2TW9ZOL/zPMKBRw1gw5J9wZX
         P1SCViCnibdb0w5Y/qlyrc5nAMNUQ2FdgNiALTq5hUsZiIpLznXkGQ/8fT/bEqDYKs
         1fZfa413i0yIw==
Date:   Mon, 12 Dec 2022 10:08:59 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        llvm@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH] kbuild: add test-{ge,gt,le,lt} macros
Message-ID: <Y5dgK2D4TP35PkKg@dev-arch.thelio-3990X>
References: <20221211024647.2614394-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221211024647.2614394-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 11:46:47AM +0900, Masahiro Yamada wrote:
> GNU Make 4.4 introduced $(intcmp ...), which is useful to compare two
> integers without forking a new process.
> 
> Add test-{ge,gt,le,lt} macros, which work more efficiently with GNU
> Make >= 4.4. For older Make versions, they fall back to the 'test'
> shell command.
> 
> The first two parameters to $(intcmp ...) must not be empty. To avoid
> the syntax error, I appended '0' to them. Fortunately, '00' is treated
> as '0'. This is needed because CONFIG options may expand to an empty
> string when the kernel configuration is not included.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
> Changes in v3:
>   - Use $(intcmp ...) instead of playing with $(sort ...)
> 
>  Makefile                  |  2 +-
>  arch/riscv/Makefile       |  2 +-
>  arch/x86/Makefile         |  2 +-
>  scripts/Kbuild.include    | 16 ++++++++++++++++
>  scripts/Makefile.compiler |  4 ++--
>  5 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index fbd9ff4a61e7..8801cac4d3d5 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -993,7 +993,7 @@ KBUILD_LDFLAGS += -mllvm -import-instr-limit=5
>  # Check for frame size exceeding threshold during prolog/epilog insertion
>  # when using lld < 13.0.0.
>  ifneq ($(CONFIG_FRAME_WARN),0)
> -ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
> +ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
>  KBUILD_LDFLAGS	+= -plugin-opt=-warn-stack-size=$(CONFIG_FRAME_WARN)
>  endif
>  endif
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0d13b597cb55..faf2c2177094 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -37,7 +37,7 @@ else
>  endif
>  
>  ifeq ($(CONFIG_LD_IS_LLD),y)
> -ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 150000; echo $$?),0)
> +ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 150000),y)
>  	KBUILD_CFLAGS += -mno-relax
>  	KBUILD_AFLAGS += -mno-relax
>  ifndef CONFIG_AS_IS_LLVM
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 415a5d138de4..e72c7a49cd59 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -211,7 +211,7 @@ endif
>  KBUILD_LDFLAGS += -m elf_$(UTS_MACHINE)
>  
>  ifdef CONFIG_LTO_CLANG
> -ifeq ($(shell test $(CONFIG_LLD_VERSION) -lt 130000; echo $$?),0)
> +ifeq ($(call test-lt, $(CONFIG_LLD_VERSION), 130000),y)
>  KBUILD_LDFLAGS	+= -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
>  endif
>  endif
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index cbe28744637b..5019bc1e38e4 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -11,6 +11,22 @@ space   := $(empty) $(empty)
>  space_escape := _-_SPACE_-_
>  pound := \#
>  
> +###
> +# Comparison macros.
> +# Usage: $(call test-lt, $(CONFIG_LLD_VERSION), 150000)
> +#
> +# Use $(intcmp ...) if supported. (Make >= 4.4)
> +# Otherwise, fall back to the 'test' shell command.
> +ifeq ($(intcmp 1,0,,,y),y)
> +test-le = $(intcmp $(strip $1)0, $(strip $2)0,y,y,)
> +test-lt = $(intcmp $(strip $1)0, $(strip $2)0,y,,)
> +else
> +test-le = $(shell test $(strip $1)0 -le $(strip $2)0 && echo y)
> +test-lt = $(shell test $(strip $1)0 -lt $(strip $2)0 && echo y)
> +endif
> +test-ge = $(call test-le, $2, $1)
> +test-gt = $(call test-lt, $2, $1)
> +
>  ###
>  # Name of target with a '.' as filename prefix. foo/bar.o => foo/.bar.o
>  dot-target = $(dir $@).$(notdir $@)
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 20d353dcabfb..3d8adfd34af1 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -63,11 +63,11 @@ cc-disable-warning = $(call try-run,\
>  
>  # gcc-min-version
>  # Usage: cflags-$(call gcc-min-version, 70100) += -foo
> -gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
> +gcc-min-version = $(call test-ge, $(CONFIG_GCC_VERSION), $1)
>  
>  # clang-min-version
>  # Usage: cflags-$(call clang-min-version, 110000) += -foo
> -clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION)0 -ge $(1)0 ] && echo y)
> +clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
>  
>  # ld-option
>  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
> -- 
> 2.34.1
> 
