Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF065F6D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJFRx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJFRxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 13:53:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D434F7CABC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 10:53:51 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ogV3x-0001hI-UG; Thu, 06 Oct 2022 19:53:37 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] riscv: fix detection of toolchain Zicbom support
Date:   Thu, 06 Oct 2022 19:53:36 +0200
Message-ID: <14737143.tv2OnDr8pf@diego>
In-Reply-To: <20221006173520.1785507-2-conor@kernel.org>
References: <20221006173520.1785507-1-conor@kernel.org> <20221006173520.1785507-2-conor@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Am Donnerstag, 6. Oktober 2022, 19:35:20 CEST schrieb Conor Dooley:
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

I did needed to look quite closely at the cc-option-voodoo, but it really
seems to work out as expected :-)

I can't say much to the specific L(L)D_VERSION values but the change itself
looks good, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

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
> 




