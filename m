Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB458637EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKXS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXS3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:29:54 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41AB7F5B4;
        Thu, 24 Nov 2022 10:29:51 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oyGye-0007Ir-Oo; Thu, 24 Nov 2022 19:29:36 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 5/7] riscv: mm: dma-noncoherent: Pass direction and operation to ALT_CMO_OP()
Date:   Thu, 24 Nov 2022 19:29:35 +0100
Message-ID: <3689906.Lt9SDvczpP@diego>
In-Reply-To: <20221124172207.153718-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221124172207.153718-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Am Donnerstag, 24. November 2022, 18:22:05 CET schrieb Prabhakar:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Pass direction and operation to ALT_CMO_OP() macro.
> 
> This is in preparation for adding errata for the Andes CPU core.

can you provide more explanation why that is necessary please?
I guess you want to use different cache operations for some cases?


Thanks
Heiko

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/include/asm/cacheflush.h  |  4 ++++
>  arch/riscv/include/asm/errata_list.h |  8 ++++++--
>  arch/riscv/mm/dma-noncoherent.c      | 15 ++++++++++-----
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index f6fbe7042f1c..4a04d1be7c67 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -8,6 +8,10 @@
>  
>  #include <linux/mm.h>
>  
> +#define NON_COHERENT_SYNC_DMA_FOR_DEVICE	0
> +#define NON_COHERENT_SYNC_DMA_FOR_CPU		1
> +#define NON_COHERENT_DMA_PREP			2
> +
>  static inline void local_flush_icache_all(void)
>  {
>  	asm volatile ("fence.i" ::: "memory");
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 2ba7e6e74540..48e899a8e7a9 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -124,7 +124,7 @@ asm volatile(ALTERNATIVE(						\
>  #define THEAD_flush_A0	".long 0x0275000b"
>  #define THEAD_SYNC_S	".long 0x0190000b"
>  
> -#define ALT_CMO_OP(_op, _start, _size, _cachesize)			\
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize, _dir, _ops)		\
>  asm volatile(ALTERNATIVE_2(						\
>  	__nops(6),							\
>  	"mv a0, %1\n\t"							\
> @@ -146,7 +146,11 @@ asm volatile(ALTERNATIVE_2(						\
>  			ERRATA_THEAD_CMO, CONFIG_ERRATA_THEAD_CMO)	\
>  	: : "r"(_cachesize),						\
>  	    "r"((unsigned long)(_start) & ~((_cachesize) - 1UL)),	\
> -	    "r"((unsigned long)(_start) + (_size))			\
> +	    "r"((unsigned long)(_start) + (_size)),			\
> +	    "r"((unsigned long)(_start)),				\
> +	    "r"((unsigned long)(_size)),				\
> +	    "r"((unsigned long)(_dir)),					\
> +	    "r"((unsigned long)(_ops))					\
>  	: "a0")
>  
>  #define THEAD_C9XX_RV_IRQ_PMU			17
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index d919efab6eba..e2b82034f504 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -19,13 +19,16 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  
>  	switch (dir) {
>  	case DMA_TO_DEVICE:
> -		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
>  		break;
>  	case DMA_FROM_DEVICE:
> -		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
>  		break;
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_DEVICE);
>  		break;
>  	default:
>  		break;
> @@ -42,7 +45,8 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>  		break;
>  	case DMA_FROM_DEVICE:
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size,
> +			   dir, NON_COHERENT_SYNC_DMA_FOR_CPU);
>  		break;
>  	default:
>  		break;
> @@ -53,7 +57,8 @@ void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
>  	void *flush_addr = page_address(page);
>  
> -	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
> +	ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size,
> +		   0, NON_COHERENT_DMA_PREP);
>  }
>  
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> 




