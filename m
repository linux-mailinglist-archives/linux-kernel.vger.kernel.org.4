Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00C36F0535
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243743AbjD0LyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbjD0LyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:54:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3D194
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:54:06 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:73f6:2283:f432:3936] (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 39EE266032B2;
        Thu, 27 Apr 2023 12:54:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682596444;
        bh=j0QYDp6weoRHl94DG/abJ5MIE+9RrKbIHWwFqclcQC0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WnBu7RaywkO2jB4Nl3Qj21vNHdZiEaCuHw2AoDdOG9U3DcVY+lB2iGU0HRO4QVPHg
         u30BEUg8hOFnQ9+IvRD0XTSc2kqcDDbR3ITI8DFVK9AgQdQS2drmYYNSBty2X4TS62
         IAvMhtz2bCPp+GaUEBrqYlHgwSUbozmiimRg/hDf5F0lMXH2objz4og94qfr2dzZhA
         bVJzoGzgz2YWrUNmJJPAPowwlDE0EE3dZqkkMn6uSjzOGYLfEEJ86KU1cNXYhfVtHO
         LYAhEFqJFR6qM9JMrOLZICris5YASdLa0RUl0ksLle2R81sK47ya+yJK9BBNVv4DaD
         xI9Y3q5haRiDg==
Message-ID: <597ef55f-e7c1-ab60-b4aa-0071ff4b5e0e@collabora.com>
Date:   Thu, 27 Apr 2023 17:23:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4] Makefile.compiler: replace cc-ifversion with
 compiler-specific macros
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        regressions@lists.linux.dev
References: <CAK7LNAT_cMLGLBz7ugaLpJD3QmZmY8FK56x9nihvWeYhJpi2ag@mail.gmail.com>
 <20220919170828.3718437-1-ndesaulniers@google.com>
Content-Language: en-US
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20220919170828.3718437-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On 19/09/22 22:38, Nick Desaulniers wrote:
> cc-ifversion is GCC specific. Replace it with compiler specific
> variants. Update the users of cc-ifversion to use these new macros.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/350
> Link: https://lore.kernel.org/llvm/CAGG=3QWSAUakO42kubrCap8fp-gm1ERJJAYXTnP1iHk_wrH=BQ@mail.gmail.com/
> Suggested-by: Bill Wendling <morbo@google.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

KernelCI found this patch causes a regression in the
baseline.logintest on qemu_arm-virt-gicv3-uefi [1],
see the bisection report for more details [2].

Let me know if you have any questions.


[1] https://linux.kernelci.org/test/case/id/644596a0beca2ead032e8669/
[2] https://groups.io/g/kernelci-results/message/40804


Thanks,
Shreeya Patel

#regzbot introduced: 88b61e3bff93

> ---
> Changes v3 -> v4:
> * Split into its own patch again from series, as per Masahiro.
> * Rebase on top of b0839b281c427e844143dba3893e25c83cdd6c17 and update
>    clang -Wformat logic in scripts/Makefile.extrawarn, as per Masahiro.
>
>   Documentation/kbuild/makefiles.rst          | 29 ++++++++++++---------
>   Makefile                                    |  6 ++---
>   drivers/gpu/drm/amd/display/dc/dml/Makefile |  2 +-
>   scripts/Makefile.compiler                   | 10 ++++---
>   scripts/Makefile.extrawarn                  |  4 +--
>   5 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
> index 11a296e52d68..ee7e3ea1fbe1 100644
> --- a/Documentation/kbuild/makefiles.rst
> +++ b/Documentation/kbuild/makefiles.rst
> @@ -682,22 +682,27 @@ more details, with real examples.
>   	In the above example, -Wno-unused-but-set-variable will be added to
>   	KBUILD_CFLAGS only if gcc really accepts it.
>   
> -    cc-ifversion
> -	cc-ifversion tests the version of $(CC) and equals the fourth parameter
> -	if version expression is true, or the fifth (if given) if the version
> -	expression is false.
> +    gcc-min-version
> +	gcc-min-version tests if the value of $(CONFIG_GCC_VERSION) is greater than
> +	or equal to the provided value and evaluates to y if so.
>   
>   	Example::
>   
> -		#fs/reiserfs/Makefile
> -		ccflags-y := $(call cc-ifversion, -lt, 0402, -O1)
> +		cflags-$(call gcc-min-version, 70100) := -foo
>   
> -	In this example, ccflags-y will be assigned the value -O1 if the
> -	$(CC) version is less than 4.2.
> -	cc-ifversion takes all the shell operators:
> -	-eq, -ne, -lt, -le, -gt, and -ge
> -	The third parameter may be a text as in this example, but it may also
> -	be an expanded variable or a macro.
> +	In this example, cflags-y will be assigned the value -foo if $(CC) is gcc and
> +	$(CONFIG_GCC_VERSION) is >= 7.1.
> +
> +    clang-min-version
> +	clang-min-version tests if the value of $(CONFIG_CLANG_VERSION) is greater
> +	than or equal to the provided value and evaluates to y if so.
> +
> +	Example::
> +
> +		cflags-$(call clang-min-version, 110000) := -foo
> +
> +	In this example, cflags-y will be assigned the value -foo if $(CC) is clang
> +	and $(CONFIG_CLANG_VERSION) is >= 11.0.0.
>   
>       cc-cross-prefix
>   	cc-cross-prefix is used to check if there exists a $(CC) in path with
> diff --git a/Makefile b/Makefile
> index 298f69060f10..411c8480b37e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -790,7 +790,6 @@ KBUILD_CFLAGS += $(stackp-flags-y)
>   
>   KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
>   KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
> -KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>   
>   ifdef CONFIG_CC_IS_CLANG
>   KBUILD_CPPFLAGS += -Qunused-arguments
> @@ -972,7 +971,6 @@ ifdef CONFIG_CC_IS_GCC
>   KBUILD_CFLAGS += -Wno-maybe-uninitialized
>   endif
>   
> -ifdef CONFIG_CC_IS_GCC
>   # The allocators already balk at large sizes, so silence the compiler
>   # warnings for bounds checks involving those possible values. While
>   # -Wno-alloc-size-larger-than would normally be used here, earlier versions
> @@ -984,8 +982,8 @@ ifdef CONFIG_CC_IS_GCC
>   # ignored, continuing to default to PTRDIFF_MAX. So, left with no other
>   # choice, we must perform a versioned check to disable this warning.
>   # https://lore.kernel.org/lkml/20210824115859.187f272f@canb.auug.org.au
> -KBUILD_CFLAGS += $(call cc-ifversion, -ge, 0901, -Wno-alloc-size-larger-than)
> -endif
> +KBUILD_CFLAGS-$(call gcc-min-version, 90100) += -Wno-alloc-size-larger-than
> +KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
>   
>   # disable invalid "can't wrap" optimizations for signed / pointers
>   KBUILD_CFLAGS	+= -fno-strict-overflow
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index cb81ed2fbd53..d70838edba80 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -34,7 +34,7 @@ dml_ccflags := -mhard-float -maltivec
>   endif
>   
>   ifdef CONFIG_CC_IS_GCC
> -ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +ifneq ($(call gcc-min-version, 70100),y)
>   IS_OLD_GCC = 1
>   endif
>   endif
> diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> index 94d0d40cddb3..9d18fb91890e 100644
> --- a/scripts/Makefile.compiler
> +++ b/scripts/Makefile.compiler
> @@ -61,9 +61,13 @@ cc-option-yn = $(call try-run,\
>   cc-disable-warning = $(call try-run,\
>   	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
>   
> -# cc-ifversion
> -# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
> -cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
> +# gcc-min-version
> +# Usage: cflags-$(call gcc-min-version, 70100) += -foo
> +gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION) -ge $(1) ] && echo y)
> +
> +# clang-min-version
> +# Usage: cflags-$(call clang-min-version, 110000) += -foo
> +clang-min-version = $(shell [ $(CONFIG_CLANG_VERSION) -ge $(1) ] && echo y)
>   
>   # ld-option
>   # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index 6ae482158bc4..5769c1939d40 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -48,7 +48,7 @@ else
>   ifdef CONFIG_CC_IS_CLANG
>   KBUILD_CFLAGS += -Wno-initializer-overrides
>   # Clang before clang-16 would warn on default argument promotions.
> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -lt 160000 ] && echo y),y)
> +ifneq ($(call clang-min-version, 160000),y)
>   # Disable -Wformat
>   KBUILD_CFLAGS += -Wno-format
>   # Then re-enable flags that were part of the -Wformat group that aren't
> @@ -56,7 +56,7 @@ KBUILD_CFLAGS += -Wno-format
>   KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
>   KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
>   # Requires clang-12+.
> -ifeq ($(shell [ $(CONFIG_CLANG_VERSION) -ge 120000 ] && echo y),y)
> +ifeq ($(call clang-min-version, 120000),y)
>   KBUILD_CFLAGS += -Wformat-insufficient-args
>   endif
>   endif
