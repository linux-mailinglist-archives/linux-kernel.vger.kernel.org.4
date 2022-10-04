Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACF5F48CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJDRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJDRnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:43:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184A066A65;
        Tue,  4 Oct 2022 10:43:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC44BCE105F;
        Tue,  4 Oct 2022 17:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B43C433D6;
        Tue,  4 Oct 2022 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664905382;
        bh=qFiToPKk2o4dHCSK1eA4+ehkbWfnkHDJylCe2Xsnuvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRHekYh/YbdvhifLPhvyZXHx2xGGwxuw6Q1+X/h5RiwAcp4Lx+ToUXhlGGw8cyeNJ
         GF9NYdWNWiOO8c9lNkxw5IvBQc/Kuj/V96i8iRAY5/JzDCOnShuRQoRgROnysAR5A2
         Ax2p1aOvcPDd7nzKbrZayv1b9SbnVcV++tkdlZ5UJxM7mj4F6FCfTpoUeBHnZgOb/i
         o8XEP3PxzYGBD/8AyHQzTH4zbRFHLGDHL2PXiO90dtToW8yWj8h6HE2qjIn2axZWQy
         /23Q9daA5W0xF+faWWRzxiKtdNfB5JDapXBP47H2lFMnx9xsa9aQ19HJCtmcnqHckY
         +LNLchAsuOoiw==
Date:   Tue, 4 Oct 2022 18:42:56 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
Message-ID: <YzxwoELNBctbhjJb@spud>
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 11:32:22PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On the AX45MP core, cache coherency is a specification option so it may
> not be supported. In this case DMA will fail. As a workaround, firstly we
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
> ops. Currently the OpenSBI code implements support for "Memory,
> Non-cacheable, Non-bufferable" option with SBI_EXT_ANDES_SET_PMA.
> 
> More info about PMA (section 10.3):
> http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> 
> This feature is based on the work posted [0] by Vincent Chen
> <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> 
> [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/riscv/include/asm/cacheflush.h    |   8 +
>  arch/riscv/include/asm/errata_list.h   |   2 +
>  arch/riscv/include/asm/sbi.h           |   1 +
>  arch/riscv/mm/dma-noncoherent.c        |  20 ++

Stupid question maybe, but I assume you mixed the driver addition and
the changes to arch/riscv for the sake of easily creating the RFC?

>  drivers/soc/renesas/Makefile           |   4 +
>  drivers/soc/renesas/rzf/Makefile       |   3 +
>  drivers/soc/renesas/rzf/ax45mp_cache.c | 365 +++++++++++++++++++++++++
>  drivers/soc/renesas/rzf/rzf_sbi.h      |  27 ++
>  8 files changed, 430 insertions(+)
>  create mode 100644 drivers/soc/renesas/rzf/Makefile
>  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
>  create mode 100644 drivers/soc/renesas/rzf/rzf_sbi.h
> 

I won't make any comments on the ALTERNATIVES usage & leave that to the
likes of Heiko rather than make a fool of myself! But to my untrained
eye, having to use #defines looks like you've strayed pretty far from
the light.. My understanding was that the whole point was to avoid
having any ifdef-ery!

> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 2a0ef738695e..10a7c855d125 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -37,6 +37,7 @@ enum sbi_ext_id {
> 
>         /* Vendor extensions must lie within this range */
>         SBI_EXT_VENDOR_START = 0x09000000,
> +       SBI_EXT_ANDES = 0x0900031E,
>         SBI_EXT_VENDOR_END = 0x09FFFFFF,
>  };

Hmm, does this belong there? It certainly makes the comment look a
little odd! /If/ it goes into this file, I think it should be in a
separate section "heading" - but could it not be put into rzf_sbi.h?

> diff --git a/drivers/soc/renesas/rzf/ax45mp_cache.c b/drivers/soc/renesas/rzf/ax45mp_cache.c
> new file mode 100644
> index 000000000000..6eca32aef33e
> --- /dev/null
> +++ b/drivers/soc/renesas/rzf/ax45mp_cache.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PMA setup and non-coherent cache functions for AX45MP
> + *

Given your comment in the commit message, should this also be carrying a
copyright from Andestech?

> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <linux/cacheinfo.h>
> +#include <linux/of_address.h>
> +

> +static void __iomem *l2c_base;
> +
> +/* -----------------------------------------------------------------------------

I'll (mostly) keep my nose out of style for soc/renesas, but this /* ---
style looks unusual!

> + * PMA setup
> + */

> +static long sbi_set_pma(void *arg)
> +static void ax45mp_configure_pma_regions(struct device_node *np, int count)
> +static void cpu_dcache_inval_range(unsigned long start,
> +void rzfive_cpu_dma_inval_range(void *vaddr, size_t size)

There's a real mix of function name prefixes in here, sbi_ aside is
there a reason you didn't just stick to ax45mp_foo()? Apologies if
I missed something that should've been obvious

> +static void cpu_dcache_wb_range(unsigned long start,
> +				unsigned long end,
> +				int line_size)
> +{
> +	bool ucctl_ok = false;
> +	unsigned long pa;
> +	int mhartid = 0;
> +#ifdef CONFIG_SMP
> +	mhartid = smp_processor_id();
> +#endif

Won't this produce complaints from your if you compile with CONFIG_SMP
set?

> +
> +	ucctl_ok = cpu_cache_controlable();
> +
> +	while (end > start) {
> +		if (ucctl_ok) {
> +			csr_write(CCTL_REG_UCCTLBEGINADDR_NUM, start);
> +			csr_write(CCTL_REG_UCCTLCOMMAND_NUM, CCTL_L1D_VA_WB);
> +		}
> +
> +		if (l2c_base && (cpu_l2c_ctl_status() & L2_CACHE_CTL_CEN_MASK)) {
> +			pa = virt_to_phys((void *)start);
> +			writel(pa, (void *)(l2c_base + L2C_REG_CN_ACC_OFFSET(mhartid)));
> +			writel(CCTL_L2_PA_WB, (void *)(l2c_base + L2C_REG_CN_CMD_OFFSET(mhartid)));
> +			while ((cpu_l2c_get_cctl_status() &
> +				CCTL_L2_STATUS_CN_MASK(mhartid)) != CCTL_L2_STATUS_IDLE)
> +				;
> +		}
> +
> +		start += line_size;
> +	}
> +}

Thanks,
Conor.
