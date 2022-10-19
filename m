Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA546045D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbiJSMuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiJSMtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:49:13 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE15E657
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:31:54 -0700 (PDT)
Received: from p508fdae2.dip0.t-ipconnect.de ([80.143.218.226] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ol8Dj-0005cC-Eg; Wed, 19 Oct 2022 14:30:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
Date:   Wed, 19 Oct 2022 14:30:50 +0200
Message-ID: <5869751.lOV4Wx5bFT@phil>
In-Reply-To: <20221019121622.179024-2-apatel@ventanamicro.com>
References: <20221019121622.179024-1-apatel@ventanamicro.com> <20221019121622.179024-2-apatel@ventanamicro.com>
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

Hi Anup,

Am Mittwoch, 19. Oktober 2022, 14:16:19 CEST schrieb Anup Patel:
> From: Andrew Jones <ajones@ventanamicro.com>
> 
> riscv_cbom_block_size and riscv_init_cbom_blocksize() should always
> be available and riscv_init_cbom_blocksize() should always be
> invoked, even when compiling without RISCV_ISA_ZICBOM enabled. This
> is because disabling RISCV_ISA_ZICBOM means "don't use zicbom
> instructions in the kernel" not "pretend there isn't zicbom, even
> when there is". When zicbom is available, whether the kernel enables
> its use with RISCV_ISA_ZICBOM or not, KVM will offer it to guests.
> Ensure we can build KVM and that the block size is initialized even
> when compiling without RISCV_ISA_ZICBOM.

either I'm way very low on coffee or something is strange here :-) .

I can fully grasp the need to init the cbom blocksize for guests, even when
the main kernel isn't using it, but below in the patch itself it is still:

+#ifdef CONFIG_RISCV_ISA_ZICBOM
+void riscv_init_cbom_blocksize(void)
+{
[...]

so the init_cbom_blocksize function is still inside a RISCV_ISA_ZICBOM
ifdef?


Heiko


> 
> Fixes: 8f7e001e0325 ("RISC-V: Clean up the Zicbom block size probing")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  arch/riscv/mm/cacheflush.c      | 41 +++++++++++++++++++++++++++++++++
>  arch/riscv/mm/dma-noncoherent.c | 41 ---------------------------------
>  2 files changed, 41 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 6cb7d96ad9c7..f318b2553612 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2017 SiFive
>   */
>  
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <asm/cacheflush.h>
>  
>  #ifdef CONFIG_SMP
> @@ -86,3 +88,42 @@ void flush_icache_pte(pte_t pte)
>  		flush_icache_all();
>  }
>  #endif /* CONFIG_MMU */
> +
> +unsigned int riscv_cbom_block_size;
> +EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
> +
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +void riscv_init_cbom_blocksize(void)
> +{
> +	struct device_node *node;
> +	unsigned long cbom_hartid;
> +	u32 val, probed_block_size;
> +	int ret;
> +
> +	probed_block_size = 0;
> +	for_each_of_cpu_node(node) {
> +		unsigned long hartid;
> +
> +		ret = riscv_of_processor_hartid(node, &hartid);
> +		if (ret)
> +			continue;
> +
> +		/* set block-size for cbom extension if available */
> +		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> +		if (ret)
> +			continue;
> +
> +		if (!probed_block_size) {
> +			probed_block_size = val;
> +			cbom_hartid = hartid;
> +		} else {
> +			if (probed_block_size != val)
> +				pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
> +					cbom_hartid, hartid);
> +		}
> +	}
> +
> +	if (probed_block_size)
> +		riscv_cbom_block_size = probed_block_size;
> +}
> +#endif
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index b0add983530a..d919efab6eba 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -8,13 +8,8 @@
>  #include <linux/dma-direct.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/mm.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <asm/cacheflush.h>
>  
> -unsigned int riscv_cbom_block_size;
> -EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
> -
>  static bool noncoherent_supported;
>  
>  void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> @@ -77,42 +72,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  	dev->dma_coherent = coherent;
>  }
>  
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
> -void riscv_init_cbom_blocksize(void)
> -{
> -	struct device_node *node;
> -	unsigned long cbom_hartid;
> -	u32 val, probed_block_size;
> -	int ret;
> -
> -	probed_block_size = 0;
> -	for_each_of_cpu_node(node) {
> -		unsigned long hartid;
> -
> -		ret = riscv_of_processor_hartid(node, &hartid);
> -		if (ret)
> -			continue;
> -
> -		/* set block-size for cbom extension if available */
> -		ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> -		if (ret)
> -			continue;
> -
> -		if (!probed_block_size) {
> -			probed_block_size = val;
> -			cbom_hartid = hartid;
> -		} else {
> -			if (probed_block_size != val)
> -				pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
> -					cbom_hartid, hartid);
> -		}
> -	}
> -
> -	if (probed_block_size)
> -		riscv_cbom_block_size = probed_block_size;
> -}
> -#endif
> -
>  void riscv_noncoherent_supported(void)
>  {
>  	WARN(!riscv_cbom_block_size,
> 




