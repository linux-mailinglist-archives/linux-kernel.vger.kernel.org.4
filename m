Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164F56380AB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 22:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKXVbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 16:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 16:31:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C0CC052E;
        Thu, 24 Nov 2022 13:31:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C667B82905;
        Thu, 24 Nov 2022 21:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA9FC433C1;
        Thu, 24 Nov 2022 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669325509;
        bh=EGJ/9q/hvg0YSx1v+4FG/3OZ0G7IUlVUm45FUQr5mGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXqImf9xmDxTYpEbhrJY5d1ZfJ8AT6+QxxQntmATAWF5BWGJ3UHewG3gjExIRNCnU
         +SRKm5sbfi1UhghuQfeHz9b4sqT1cUb8QfIKDedgvHp0C+xDh5Eb9fE+gNAZCJ8jrz
         DrzTOgv3wssTgY/a6Lc96f17lifGPZTf1cu12n24l094m7RRTOjK9KNKYqPnKz3IVL
         +9JG/7Kz7c2ZIY83fWoKllOCyOmo035wS+x4oLbwXxkG/5lVnBq21WxeVq/dz6B845
         o4HECIU7LN+7FW7mr+yaU/XDHDP6EGaNb80VaVoD2I+aexucGgSzqN2U4hXvqbq50/
         VZdGLbctok3yA==
Date:   Thu, 24 Nov 2022 21:31:42 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five
 SoC
Message-ID: <Y3/ivrvx4A+OImtW@spud>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 05:22:07PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On the AX45MP core, cache coherency is a specification option so it may

How about:
"Cache coherency is an option feature of the AX45MP core, so it may not
be supported."

I keep finding that sentence kinda hard..

> In this case DMA will fail.
"The AX45MP predates the standard extensions for cache management, so an
alternate approach is required to support non-coherent DMA for SoCs
where this feature is not available, such as the Renesas RZ/Five."

(you've gotta explain somewhere why this is in drivers/soc/renesas lol)

> As a workaround, firstly we

How about:
" Since the cache management instructions cannot be used, we instead
allocate..."

> allocate a global dma coherent pool from which DMA allocations are taken
> and marked as non-cacheable + bufferable using the PMA region as specified
> in the device tree. Synchronization callbacks are implemented to
> synchronize when doing DMA transactions.
> 
> The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> block that allows dynamic adjustment of memory attributes in the runtime.
> It contains a configurable amount of PMA entries implemented as CSR
> registers to control the attributes of memory locations in interest.
> 
> Below are the memory attributes supported:
> * Device, Non-bufferable
> * Device, bufferable
> * Memory, Non-cacheable, Non-bufferable
> * Memory, Non-cacheable, Bufferable
> * Memory, Write-back, No-allocate
> * Memory, Write-back, Read-allocate
> * Memory, Write-back, Write-allocate
> * Memory, Write-back, Read and Write-allocate
> 
> This patch adds support to configure the memory attributes of the memory
> regions as passed from the l2 cache node and exposes the cache management
> ops.
> 
> More info about PMA (section 10.3):
> Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf

But yeah, this is basically the sort of stuff that'd be nice to have in
the previous patch!

> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v3 -> v4
> * Made use of runtime patching instead of compile time
> * Now just exposing single function ax45mp_no_iocp_cmo() for CMO handling
> * Added a check to make sure cache line size is always 64 bytes
> * Renamed folder rzf -> rzfive
> * Improved Kconfig description
> * Dropped L2 cache configuration
> * Dropped unnecessary casts
> * Fixed comments pointed by Geert, apart from use of PTR_ALIGN_XYZ() macros.
> ---
>  arch/riscv/include/asm/cacheflush.h       |   8 +
>  arch/riscv/include/asm/errata_list.h      |  32 +-
>  drivers/soc/renesas/Kconfig               |   7 +
>  drivers/soc/renesas/Makefile              |   2 +
>  drivers/soc/renesas/rzfive/Kconfig        |   6 +
>  drivers/soc/renesas/rzfive/Makefile       |   3 +
>  drivers/soc/renesas/rzfive/ax45mp_cache.c | 415 ++++++++++++++++++++++
>  drivers/soc/renesas/rzfive/ax45mp_sbi.h   |  29 ++
>  8 files changed, 496 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/soc/renesas/rzfive/Kconfig
>  create mode 100644 drivers/soc/renesas/rzfive/Makefile
>  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_cache.c
>  create mode 100644 drivers/soc/renesas/rzfive/ax45mp_sbi.h

> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 660498252ec5..e7810256c60d 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -340,9 +340,16 @@ if RISCV
>  config ARCH_R9A07G043
>  	bool "RISC-V Platform support for RZ/Five"
>  	select ARCH_RZG2L
> +	select AX45MP_L2_CACHE
> +	select DMA_GLOBAL_POOL
> +	select ERRATA_ANDES
> +	select ERRATA_ANDES_CMO
> +	select RISCV_DMA_NONCOHERENT

Is this not redundant due to the select by ERRATA_ANDES_CMO?

>  	help
>  	  This enables support for the Renesas RZ/Five SoC.
>  
> +source "drivers/soc/renesas/rzfive/Kconfig"
> +
>  endif # RISCV
>  
>  config RST_RCAR

> diff --git a/drivers/soc/renesas/rzfive/Makefile b/drivers/soc/renesas/rzfive/Makefile
> new file mode 100644
> index 000000000000..2012e7fb978d
> --- /dev/null
> +++ b/drivers/soc/renesas/rzfive/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_AX45MP_L2_CACHE) += ax45mp_cache.o
> diff --git a/drivers/soc/renesas/rzfive/ax45mp_cache.c b/drivers/soc/renesas/rzfive/ax45mp_cache.c
> new file mode 100644
> index 000000000000..4e0d0545d3af

Mainly just whizzing through the driver itself..

> +static int ax45mp_configure_pma_regions(struct device_node *np)
> +{
> +	const char *propname = "andestech,pma-regions";
> +	u32 start, size, flags;
> +	unsigned int entry_id;
> +	unsigned int i;
> +	int count;
> +	int ret;
> +
> +	count = of_property_count_elems_of_size(np, propname, sizeof(u32) * 3);
> +	if (count < 0)
> +		return count;
> +
> +	if (count > AX45MP_MAX_PMA_REGIONS)
> +		return -EINVAL;
> +
> +	for (i = 0, entry_id = 0 ; entry_id < count ; i += 3, entry_id++) {
> +		of_property_read_u32_index(np, propname, i, &start);
> +		of_property_read_u32_index(np, propname, i + 1, &size);
> +		of_property_read_u32_index(np, propname, i + 2, &flags);
> +		ret = ax45mp_sbi_set_pma(start, size, flags, entry_id);
> +		if (!ret)
> +			pr_err("Failed to setup PMA region 0x%x - 0x%x flags: 0x%x",
> +			       start, start + size, flags);

I have to ask - is it okay to just continue here if a RMA region setup
fails?

> +	}
> +
> +	return 0;
> +}
> +

> +static bool ax45mp_cpu_cache_controlable(void)
> +{
> +	return (((ax45mp_cpu_get_micm_cfg_status() & AX45MP_MICM_CFG_ISZ_MASK) ||
> +		 (ax45mp_cpu_get_mdcm_cfg_status() & AX45MP_MDCM_CFG_DSZ_MASK)) &&
> +		(ax45mp_cpu_get_misa_cfg_status() & AX45MP_MISA_20_MASK) &&
> +		(ax45mp_cpu_get_mmsc_cfg_status() & AX45MP_MMSC_CFG_CCTLCSR_MASK) &&
> +		(ax45mp_cpu_get_mcache_ctl_status() & AX45MP_MCACHE_CTL_CCTL_SUEN_MASK));

That's a bit of a mouthful lol!


> +static void ax45mp_cpu_dma_inval_range(void *vaddr, size_t size)

Not mine to look after so /shrug but this looks like the sort of thing
that could do with a comment or two explaining the invalidation process.

> +{
> +	char cache_buf[2][AX45MP_MAX_CACHE_LINE_SIZE];
> +	unsigned long start = (unsigned long)vaddr;
> +	unsigned long end = start + size;
> +	unsigned long old_start = start;
> +	unsigned long old_end = end;
> +	unsigned long line_size;
> +	unsigned long flags;
> +
> +	if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
> +		return;
> +
> +	if (unlikely(start == end))
> +		return;
> +
> +	line_size = ax45mp_priv->ax45mp_cache_line_size;
> +
> +	memset(&cache_buf, 0x0, sizeof(cache_buf));
> +	start = start & (~(line_size - 1));
> +	end = ((end + line_size - 1) & (~(line_size - 1)));
> +
> +	local_irq_save(flags);
> +	if (unlikely(start != old_start))
> +		memcpy(&cache_buf[0][0], (void *)start, line_size);
> +
> +	if (unlikely(end != old_end))
> +		memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), line_size);
> +
> +	ax45mp_cpu_dcache_inval_range(vaddr, (void *)end, line_size);
> +
> +	if (unlikely(start != old_start))
> +		memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 1)));
> +
> +	if (unlikely(end != old_end))
> +		memcpy((void *)(old_end + 1),
> +		       &cache_buf[1][(old_end & (line_size - 1)) + 1],
> +		       end - old_end - 1);
> +
> +	local_irq_restore(flags);
> +}

> +static int ax45mp_configure_l2_cache(struct device_node *np)
> +{
> +	int ret;
> +
> +	ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv->ax45mp_cache_line_size);
> +	if (ret) {
> +		pr_err("Failed to get cache-line-size defaulting to 64 bytes\n");
                                                     ^
Looks like you need a comma here...

> +		ax45mp_priv->ax45mp_cache_line_size = SZ_64;
> +	}
> +
> +	if (ax45mp_priv->ax45mp_cache_line_size != SZ_64) {
> +		pr_err("Expected cache-line-size to 64 bytes (found:%u). Defaulting to 64 bytes\n",
                                                   ^
...and a "be" here.

Would you also benefit from a pr_fmt here since you have no device? Or
else you could save the dev to your ax45mp_priv and avail of dev_err
here?

> +		       ax45mp_priv->ax45mp_cache_line_size);
> +		ax45mp_priv->ax45mp_cache_line_size = SZ_64;
> +	}
> +
> +	ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();
                                                 ^
That function name is a typo, should be called ax45mp_cpu_cache_cache_controllable().

> +	ax45mp_priv->l2cache_enabled = ax45mp_cpu_l2c_ctl_status() & AX45MP_L2_CACHE_CTL_CEN_MASK;
> +
> +	return 0;
> +}
> +
> +static int ax45mp_l2c_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	int ret;
> +
> +	ax45mp_priv = devm_kzalloc(&pdev->dev, sizeof(*ax45mp_priv), GFP_KERNEL);
> +	if (!ax45mp_priv)
> +		return -ENOMEM;
> +
> +	ax45mp_priv->l2c_base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
> +	if (!ax45mp_priv->l2c_base) {
> +		ret = -ENOMEM;
> +		goto l2c_err;
> +	}
> +
> +	ret = ax45mp_configure_l2_cache(np);
> +	if (ret)
> +		goto l2c_err;
> +
> +	ret = ax45mp_configure_pma_regions(np);
> +	if (ret)
> +		goto l2c_err;
> +
> +	static_branch_disable(&ax45mp_l2c_configured);
> +
> +	return 0;
> +
> +l2c_err:
> +	devm_kfree(&pdev->dev, ax45mp_priv);
> +	ax45mp_priv = NULL;
> +	return ret;
> +}

> diff --git a/drivers/soc/renesas/rzfive/ax45mp_sbi.h b/drivers/soc/renesas/rzfive/ax45mp_sbi.h
> new file mode 100644
> index 000000000000..1604874954d0
> --- /dev/null
> +++ b/drivers/soc/renesas/rzfive/ax45mp_sbi.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __AX45MP_SBI_H
> +#define __AX45MP_SBI_H
> +
> +#define SBI_EXT_ANDES		0x0900031E
> +
> +enum ax45mp_sbi_ext_fid {
> +	AX45MP_SBI_EXT_GET_MCACHE_CTL_STATUS = 0,

Is that zero not implied?

> +	AX45MP_SBI_EXT_GET_MMISC_CTL_STATUS,
> +	AX45MP_SBI_EXT_SET_MCACHE_CTL,
> +	AX45MP_SBI_EXT_SET_MMISC_CTL,
> +	AX45MP_SBI_EXT_ICACHE_OP,
> +	AX45MP_SBI_EXT_DCACHE_OP,
> +	AX45MP_SBI_EXT_L1CACHE_I_PREFETCH,
> +	AX45MP_SBI_EXT_L1CACHE_D_PREFETCH,
> +	AX45MP_SBI_EXT_NON_BLOCKING_LOAD_STORE,
> +	AX45MP_SBI_EXT_WRITE_AROUND,
> +	AX45MP_SBI_EXT_SET_PMA,
> +	AX45MP_SBI_EXT_FREE_PMA,
> +	AX45MP_SBI_EXT_PROBE_PMA,
> +	AX45MP_SBI_EXT_DCACHE_WBINVAL_ALL,
> +	AX45MP_SBI_EXT_GET_MICM_CTL_STATUS,
> +	AX45MP_SBI_EXT_GET_MDCM_CTL_STATUS,
> +	AX45MP_SBI_EXT_GET_MMSC_CTL_STATUS,
> +	AX45MP_SBI_EXT_GET_MISA_CTL_STATUS,
> +};
> +
> +#endif
> -- 
> 2.25.1
> 
