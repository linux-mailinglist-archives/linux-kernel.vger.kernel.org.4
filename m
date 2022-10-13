Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BC15FE32E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJMUWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJMUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDDA1578A9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71458618E6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22051C433D6;
        Thu, 13 Oct 2022 20:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665692569;
        bh=xNxmxjigV/Sc/aVH0TtEXg1U6cyj9psSQw4r6YBOjn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUI5984v2CsO+ux/dH0P9R5SX8GbBvdXvVbWtTvB2qK+arCAGYVE3cnQaLugMTNhh
         w29llMwAcl5KsK8+r32+0KRpELaBUVuoBMeO/7GxBRB5DS2+Lqhy0fvNyZi71+pOTk
         D7wV+WclWjHxcO5s+kijfrMKK1swcKMIGd6cBBho/mkJ5EZj0KcSW9YbAB6KcDbYcS
         efJ0p0QOKYMPJV7GDul6xZHYJZqTCg1inwm+V0rr3LZjHaBAZYCUma7zGEq5AYqKi6
         v8xX4rZGRGBsHvjSqRqq5tsipx2P3kWPTGuoEjJoKxwod1h30AGc2DOutcWkLNdzDe
         8aff7G8aAqung==
Date:   Thu, 13 Oct 2022 13:22:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] riscv: fix detection of toolchain Zicbom support
Message-ID: <Y0hzl75d11uWC+f3@dev-arch.thelio-3990X>
References: <20221006173520.1785507-1-conor@kernel.org>
 <20221006173520.1785507-2-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006173520.1785507-2-conor@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 06:35:20PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> It is not sufficient to check if a toolchain supports a particular
> extension without checking if the linker supports that extension too.
> For example, Clang 15 supports Zicbom but GNU bintutils 2.35.2 does
> not, leading build errors like so:
> 
> riscv64-linux-gnu-ld: -march=rv64i2p0_m2p0_a2p0_c2p0_zicbom1p0_zihintpause2p0: Invalid or unknown z ISA extension: 'zicbom'
> 
> Convert CC_HAS_ZICBOM to TOOLCHAIN_HAS_ZICBOM & check if the linker
> also supports Zicbom.
> 
> Reported-by: Kevin Hilman <khilman@baylibre.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1714
> Link: https://storage.kernelci.org/next/master/next-20220920/riscv/defconfig+CONFIG_EFI=n/clang-16/logs/kernel.log
> Fixes: 1631ba1259d6 ("riscv: Add support for non-coherent devices using zicbom extension")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

The versions look correct to me. I see the LLVM zicbom commit [1] in
llvmorg-15.0.0 and I see the binutils zicbom commit [2] in
binutils-2_39.

FWIW, if we are adding explicit tool versions to the Kconfig, could you
not also drop the cc-option checks? Typically, cc-option is only used
when dynamically checking for a feature, in lieu of statically checking
a version. No strong opinion though.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

[1]: https://github.com/llvm/llvm-project/commit/4f40ca53cefb725aca6564585d0ec4836a79e21a
[2]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=41d6ac5da655a2e78109848f2db47e53552fd61a

> ---
>  arch/riscv/Kconfig  | 10 ++++++----
>  arch/riscv/Makefile |  3 +--
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d557cc50295d..6da36553158b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -401,14 +401,16 @@ config RISCV_ISA_SVPBMT
>  
>  	   If you don't know what to do here, say Y.
>  
> -config CC_HAS_ZICBOM
> +config TOOLCHAIN_HAS_ZICBOM
>  	bool
> -	default y if 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicbom)
> -	default y if 32BIT && $(cc-option,-mabi=ilp32 -march=rv32ima_zicbom)
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zicbom)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zicbom)
> +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
>  
>  config RISCV_ISA_ZICBOM
>  	bool "Zicbom extension support for non-coherent DMA operation"
> -	depends on CC_HAS_ZICBOM
> +	depends on TOOLCHAIN_HAS_ZICBOM
>  	depends on !XIP_KERNEL && MMU
>  	select RISCV_DMA_NONCOHERENT
>  	select RISCV_ALTERNATIVE
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 3fa8ef336822..3607d38edb4f 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -57,8 +57,7 @@ toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zi
>  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
>  
>  # Check if the toolchain supports Zicbom extension
> -toolchain-supports-zicbom := $(call cc-option-yn, -march=$(riscv-march-y)_zicbom)
> -riscv-march-$(toolchain-supports-zicbom) := $(riscv-march-y)_zicbom
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICBOM) := $(riscv-march-y)_zicbom
>  
>  # Check if the toolchain supports Zihintpause extension
>  toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> -- 
> 2.37.3
> 
> 
