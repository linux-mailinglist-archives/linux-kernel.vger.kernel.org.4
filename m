Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04B55FE34D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiJMUaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJMUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:30:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2492676749
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4987D6194E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13913C433B5;
        Thu, 13 Oct 2022 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665693018;
        bh=lRRbu7uh7zAcSH3K4UNajCKQmWE1dCae6+ehx4kVmx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUhNOnfLldx8mlLatFevToiwEI3dA+5lYysgVkSQtKG2rG4cBRxD11C3UI/hCAPQf
         61r6RLiGyHMaWTiJJDg2DQ32bLJNLfptpl9dUKyW5SQo+XY7Z9DJjC6m9l5H2AY3K9
         y3O0epUKlKDxOc2HFwnfzwDrzEu1RgX7sV5xaeyVDyYyU6mvsNNL0PZG+coz67zEr9
         dzUv0Fkcq3EdM+UXC7SZh7qYZmJEwhOlpKvJ8051tsSUksn/FfFxYeJisWKQUlUqlK
         z9vz7VY6ZgG+/pLR5G7qE6lA7bo7R4fmKaAj8GCGZVlZumt3wRORwpniYeUswbcMES
         RskO5lsfhMNoQ==
Date:   Thu, 13 Oct 2022 13:30:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] riscv: fix detection of toolchain Zihintpause support
Message-ID: <Y0h1WK0Tmk0UXjmd@dev-arch.thelio-3990X>
References: <20221006173520.1785507-1-conor@kernel.org>
 <20221006173520.1785507-3-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006173520.1785507-3-conor@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 06:35:21PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> It is not sufficient to check if a toolchain supports a particular
> extension without checking if the linker supports that extension
> too. For example, Clang 15 supports Zihintpause but GNU bintutils
> 2.35.2 does not, leading build errors like so:
> 
> riscv64-linux-gnu-ld: -march=rv64i2p0_m2p0_a2p0_c2p0_zihintpause2p0: Invalid or unknown z ISA extension: 'zihintpause'
> 
> Add a TOOLCHAIN_HAS_ZIHINTPAUSE which checks if each of the compiler,
> assembler and linker support the extension. Replace the ifdef in the
> vdso with one depending on this new symbol.
> 
> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Palmer:
> The VDSO change will conflict with Samuel's one, resolution should be
> trivial.. I only made that change as you warned me about checking for
> the __riscv_foo stuff if I made the march string depend on the Kconfig
> entry rather than on the Makefile's cc-option check.

The versions look correct to me. I see the LLVM zihintpause commit [1]
in llvmorg-15.0.0 and I see the binutils zihintpause commit [2] in
binutils-2_36.

[1]: https://github.com/llvm/llvm-project/commit/005fd8aa702edbc532763038365575da96e5787d
[2]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=aa881ecde48c7a0224b92e2cfa43b37ee9ec9fa2

Similar comment as patch 1, I think we can just drop the cc-option
checks. Regardless:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/riscv/Kconfig                      | 7 +++++++
>  arch/riscv/Makefile                     | 3 +--
>  arch/riscv/include/asm/vdso/processor.h | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6da36553158b..d7c53896e24f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -425,6 +425,13 @@ config RISCV_ISA_ZICBOM
>  
>  	   If you don't know what to do here, say Y.
>  
> +config TOOLCHAIN_HAS_ZIHINTPAUSE
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zihintpause)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zihintpause)
> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23600
> +
>  config FPU
>  	bool "FPU support"
>  	default y
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 3607d38edb4f..6651517f3962 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -60,8 +60,7 @@ riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICBOM) := $(riscv-march-y)_zicbom
>  
>  # Check if the toolchain supports Zihintpause extension
> -toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> -riscv-march-$(toolchain-supports-zihintpause) := $(riscv-march-y)_zihintpause
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
>  
>  KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
>  KBUILD_AFLAGS += -march=$(riscv-march-y)
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 1e4f8b4aef79..fa70cfe507aa 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -21,7 +21,7 @@ static inline void cpu_relax(void)
>  		 * Reduce instruction retirement.
>  		 * This assumes the PC changes.
>  		 */
> -#ifdef __riscv_zihintpause
> +#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
>  		__asm__ __volatile__ ("pause");
>  #else
>  		/* Encoding of the pause instruction */
> -- 
> 2.37.3
> 
> 
