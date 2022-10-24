Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E00C60B63A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiJXSvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiJXSui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259C2475D2;
        Mon, 24 Oct 2022 10:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0581614F8;
        Mon, 24 Oct 2022 17:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2489C433C1;
        Mon, 24 Oct 2022 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666632597;
        bh=7X3pyy5etiy2bIvntMxqiIcujpkGZ6SQvQR3em+OEfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcCpwZdkYFgbPQhi85iPPo1eyIBNpT/qYtnO8dl6duQouAJvMDFnaV6Sg+sAWAKor
         iwZUIVeLPcMvTVA22drsQzHuwAMQ21quscVSoiAmispWDZbxotN7F5hbajv9TWVuoB
         f3UrspGND75jdVosfeKHsLS6KedH4juXr+t80Xv8RMLY+owXOIiyFkJbojkeDJwnx6
         cUQTTXeJuKCUfoEKE7lfOn29DHjihFlUqVq0VWcpJmbZcnUPbsfyQ7/tJovhEgs49z
         zw1MRAFY38576I9Ko7E/Al/qYG0Z5BfYjKr5eUIUI3aJQbww/D6Du4PR05UXlr92EM
         U3LzfDEShaVXQ==
Date:   Mon, 24 Oct 2022 10:29:55 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        keescook@chromium.org, andrew.cooper3@citrix.com, hpa@zytor.com,
        peterz@infradead.org
Subject: Re: [PATCH 1/1] kbuild: upgrade the orphan section warning to an
 error if CONFIG_WERROR is set
Message-ID: <Y1bLk47I4pyEmJVi@dev-arch.thelio-3990X>
References: <20221022030519.9505-1-xin3.li@intel.com>
 <20221022030519.9505-2-xin3.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022030519.9505-2-xin3.li@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 08:05:19PM -0700, Xin Li wrote:
> Andrew Cooper suggested upgrading the orphan section warning to a hard link
> error. However Nathan Chancellor said outright turning the warning into an
> error with no escape hatch might be too aggressive, as we have had these
> warnings triggered by new compiler generated sections, and suggested turning
> orphan sections into an error only if CONFIG_WERROR is set. Kees Cook echoed
> and emphasized that the mandate from Linus is that we should avoid breaking
> builds. It wrecks bisection, it causes problems across compiler versions, etc.
> 
> Thus upgrade the orphan section warning to a hard link error only if
> CONFIG_WERROR is set.
> 
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Xin Li <xin3.li@intel.com>

Thanks for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

We could deduplicate the '$(if $(CONFIG_WERROR),error,warn)' logic if we
hoisted it into Kconfig by having something like

    config LD_ORPHAN_WARN_LEVEL
        string
        depends on LD_ORPHAN_WARN
        default "error" if WERROR
        default "warn"

in init/Kconfig then using it everywhere like

    --orphan-handling=$(CONFIG_LD_ORPHAN_WARN_LEVEL)

but I will let others decide if they would prefer that over the
direction we went here.

Cheers,
Nathan

> ---
>  Makefile                          | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 +-
>  arch/arm64/kernel/vdso/Makefile   | 2 +-
>  arch/arm64/kernel/vdso32/Makefile | 2 +-
>  arch/x86/boot/compressed/Makefile | 2 +-
>  init/Kconfig                      | 9 ++++++---
>  6 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index f41ec8c8426b..b6716a64519f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1118,7 +1118,7 @@ endif
>  # We never want expected sections to be placed heuristically by the
>  # linker. All sections should be explicitly named in the linker script.
>  ifdef CONFIG_LD_ORPHAN_WARN
> -LDFLAGS_vmlinux += --orphan-handling=warn
> +LDFLAGS_vmlinux += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
>  endif
>  
>  # Align the bit size of userspace programs with the kernel
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 41bcbb460fac..c97db8b14c4f 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -123,7 +123,7 @@ LDFLAGS_vmlinux += --no-undefined
>  LDFLAGS_vmlinux += -X
>  # Report orphan sections
>  ifdef CONFIG_LD_ORPHAN_WARN
> -LDFLAGS_vmlinux += --orphan-handling=warn
> +LDFLAGS_vmlinux += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
>  endif
>  # Next argument is a linker script
>  LDFLAGS_vmlinux += -T
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 619e2dc7ee14..c8fcc06b5037 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -27,7 +27,7 @@ ldflags-y := -shared -soname=linux-vdso.so.1 --hash-style=sysv	\
>  	     -Bsymbolic --build-id=sha1 -n $(btildflags-y)
>  
>  ifdef CONFIG_LD_ORPHAN_WARN
> -  ldflags-y += --orphan-handling=warn
> +  ldflags-y += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
>  endif
>  
>  ldflags-y += -T
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 36c8f66cad25..fa157366e814 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -104,7 +104,7 @@ VDSO_AFLAGS += -D__ASSEMBLY__
>  VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
>  VDSO_LDFLAGS += -z max-page-size=4096 -z common-page-size=4096
>  VDSO_LDFLAGS += -shared --hash-style=sysv --build-id=sha1
> -VDSO_LDFLAGS += --orphan-handling=warn
> +VDSO_LDFLAGS += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
>  
>  
>  # Borrow vdsomunge.c from the arm vDSO
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 3a261abb6d15..a1a8bec61c10 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -68,7 +68,7 @@ KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
>  # address by the bootloader.
>  LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
>  ifdef CONFIG_LD_ORPHAN_WARN
> -LDFLAGS_vmlinux += --orphan-handling=warn
> +LDFLAGS_vmlinux += --orphan-handling=$(if $(CONFIG_WERROR),error,warn)
>  endif
>  LDFLAGS_vmlinux += -z noexecstack
>  ifeq ($(CONFIG_LD_IS_BFD),y)
> diff --git a/init/Kconfig b/init/Kconfig
> index abf65098f1b6..8f4b838ece47 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -159,10 +159,12 @@ config WERROR
>  	help
>  	  A kernel build should not cause any compiler warnings, and this
>  	  enables the '-Werror' (for C) and '-Dwarnings' (for Rust) flags
> -	  to enforce that rule by default.
> +	  to enforce that rule by default. Certain warnings from other tools
> +	  such as the linker may be upgraded to errors with this option as
> +	  well.
>  
> -	  However, if you have a new (or very old) compiler with odd and
> -	  unusual warnings, or you have some architecture with problems,
> +	  However, if you have a new (or very old) compiler or linker with odd
> +	  and unusual warnings, or you have some architecture with problems,
>  	  you may need to disable this config option in order to
>  	  successfully build the kernel.
>  
> @@ -1454,6 +1456,7 @@ config LD_ORPHAN_WARN
>  	def_bool y
>  	depends on ARCH_WANT_LD_ORPHAN_WARN
>  	depends on $(ld-option,--orphan-handling=warn)
> +	depends on $(ld-option,--orphan-handling=error)
>  
>  config SYSCTL
>  	bool
> -- 
> 2.34.1
> 
> 
