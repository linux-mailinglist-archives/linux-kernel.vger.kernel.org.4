Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5BF5F4D63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiJEB3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEB3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:29:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56B56EF20;
        Tue,  4 Oct 2022 18:29:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AC75B81A02;
        Wed,  5 Oct 2022 01:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3378C433D6;
        Wed,  5 Oct 2022 01:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664933342;
        bh=8trIp9wN5tAEIa0W5hOK3v6H9+s5j6V0K5yTF3nySjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FhB7Dm+VtbLtBxTZOsBYcPwae65GS0EMmgaJg4YnCutUKbbMnjt5l3sLhP7+/4yaH
         8vabPsRXlTzocfhTT1IwjeGnMIPdjiI2ZOSY/eE5ELaApukT7oI94X5jWSz/GOjWvs
         93T5S64X7IUsZ2j6Mgp2tCk0xi9y+a6zC1qq8E8zOLCr9DDz0cYWS96TUGfdASzfoh
         eYeUKmUy9oEobZH4KsxhHYN8CzMZLV8TlXXcbFXv5PqnEnj1oy/VcmE1dg0FR9oLV2
         RG4zL5W3H0OZ7zUSCJc7/2YuYjrHz8UgG6SQ2ar3gTZHQmTwbYfF0Ils7oA9/0b6GN
         qZCpXK3HVDiwg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-131dda37dddso17479537fac.0;
        Tue, 04 Oct 2022 18:29:01 -0700 (PDT)
X-Gm-Message-State: ACrzQf3Q5qT76Qrjobf4Vb5oWXpBHGsJ5IatSwhuaOwjZdwG1NdPrYtz
        u10sco6EuIde49z8UGAG/Daox04mKWl62DC7YnU=
X-Google-Smtp-Source: AMsMyM4DJ/6Pgnn4C6rFeymY0O3y0QxuQEsxypcN8Efuz5uN/dXtukdrwvPN7qJStE2NNUEls5ZNPxoPJhfOuSUWS5I=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr1440474oao.112.1664933341013; Tue, 04
 Oct 2022 18:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 5 Oct 2022 09:28:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com>
Message-ID: <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 6:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
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
Seems Svpbmt's PMA, IO, and NC wouldn't fit your requirements, could
give a map list of the types of Svpbmt? And give out what you needed,
but Svpbmt can't.

Here is the Linux dma type to Svpbmt map:
PMA -> Normal
IO -> ioremap, pgprot_noncached
NC -> pgprot_writecombine

How about AX45MP?

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
>  drivers/soc/renesas/Makefile           |   4 +
>  drivers/soc/renesas/rzf/Makefile       |   3 +
>  drivers/soc/renesas/rzf/ax45mp_cache.c | 365 +++++++++++++++++++++++++
>  drivers/soc/renesas/rzf/rzf_sbi.h      |  27 ++
>  8 files changed, 430 insertions(+)
>  create mode 100644 drivers/soc/renesas/rzf/Makefile
>  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
>  create mode 100644 drivers/soc/renesas/rzf/rzf_sbi.h
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 273ece6b622f..a7c03321afa0 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -63,6 +63,14 @@ void riscv_noncoherent_supported(void);
>  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
>  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
>
> +#ifdef CONFIG_ARCH_R9A07G043
> +void rzfive_cpu_dma_inval_range(void *vaddr, size_t end);
> +void rzfive_cpu_dma_wb_range(void *vaddr, size_t end);
> +
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize)     \
> +                  _op(_start, _size);
> +#endif
> +
>  #include <asm-generic/cacheflush.h>
>
>  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 19a771085781..d9cbf60c3b65 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(                                             \
>  #define ALT_THEAD_PMA(_val)
>  #endif
>
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>  /*
>   * dcache.ipa rs1 (invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(                                         \
>         : "a0")
>
>  #endif /* __ASSEMBLY__ */
> +#endif
>
>  #endif
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
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index e3f9bdf47c5f..576601f180ea 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -22,13 +22,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>
>         switch (dir) {
>         case DMA_TO_DEVICE:
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +#elif CONFIG_ARCH_R9A07G043
> +               ALT_CMO_OP(rzfive_cpu_dma_wb_range, vaddr, size, 0x0);
> +#endif
>                 break;
>         case DMA_FROM_DEVICE:
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +#elif CONFIG_ARCH_R9A07G043
> +               ALT_CMO_OP(rzfive_cpu_dma_inval_range, vaddr, size, 0x0);
> +#endif
>                 break;
>         case DMA_BIDIRECTIONAL:
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +#elif CONFIG_ARCH_R9A07G043
> +               ALT_CMO_OP(rzfive_cpu_dma_wb_range, vaddr, size, 0x0);
> +#endif
>                 break;
>         default:
>                 break;
> @@ -45,7 +57,11 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>                 break;
>         case DMA_FROM_DEVICE:
>         case DMA_BIDIRECTIONAL:
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>                 ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +#elif CONFIG_ARCH_R9A07G043
> +               ALT_CMO_OP(rzfive_cpu_dma_inval_range, vaddr, size, 0x0);
> +#endif
>                 break;
>         default:
>                 break;
> @@ -54,14 +70,17 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
>
>  void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>         void *flush_addr = page_address(page);
>
>         ALT_CMO_OP(flush, flush_addr, size, riscv_cbom_block_size);
> +#endif
>  }
>
>  void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>                 const struct iommu_ops *iommu, bool coherent)
>  {
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>         WARN_TAINT(!coherent && riscv_cbom_block_size > ARCH_DMA_MINALIGN,
>                    TAINT_CPU_OUT_OF_SPEC,
>                    "%s %s: ARCH_DMA_MINALIGN smaller than riscv,cbom-block-size (%d < %d)",
> @@ -73,6 +92,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>                    dev_driver_string(dev), dev_name(dev));
>
>         dev->dma_coherent = coherent;
> +#endif
>  }
>
>  #ifdef CONFIG_RISCV_ISA_ZICBOM
> diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
> index 535868c9c7e4..a20cc7ad5b12 100644
> --- a/drivers/soc/renesas/Makefile
> +++ b/drivers/soc/renesas/Makefile
> @@ -31,6 +31,10 @@ ifdef CONFIG_SMP
>  obj-$(CONFIG_ARCH_R9A06G032)   += r9a06g032-smp.o
>  endif
>
> +ifdef CONFIG_RISCV
> +obj-y += rzf/
> +endif
> +
>  # Family
>  obj-$(CONFIG_RST_RCAR)         += rcar-rst.o
>  obj-$(CONFIG_SYSC_RCAR)                += rcar-sysc.o
> diff --git a/drivers/soc/renesas/rzf/Makefile b/drivers/soc/renesas/rzf/Makefile
> new file mode 100644
> index 000000000000..e397ba2c733f
> --- /dev/null
> +++ b/drivers/soc/renesas/rzf/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_ARCH_R9A07G043) += ax45mp_cache.o
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
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <linux/cacheinfo.h>
> +#include <linux/of_address.h>
> +
> +#include <asm/sbi.h>
> +
> +#include "rzf_sbi.h"
> +
> +/* D-cache operation */
> +#define CCTL_L1D_VA_INVAL              0
> +#define CCTL_L1D_VA_WB                 1
> +
> +/* L2 cache */
> +#define L2_CACHE_CTL_CEN_MASK          1
> +
> +/* L2 cache registers */
> +#define L2C_REG_CTL_OFFSET             0x8
> +#define L2C_REG_C0_CMD_OFFSET          0x40
> +#define L2C_REG_C0_ACC_OFFSET          0x48
> +#define L2C_REG_STATUS_OFFSET          0x80
> +
> +/* L2 CCTL status */
> +#define CCTL_L2_STATUS_IDLE            0
> +
> +/* L2 CCTL status cores mask */
> +#define CCTL_L2_STATUS_C0_MASK         0xf
> +
> +/* L2 cache operation */
> +#define CCTL_L2_PA_INVAL               0x8
> +#define CCTL_L2_PA_WB                  0x9
> +
> +#define L2C_HPM_PER_CORE_OFFSET                0x8
> +#define L2C_REG_PER_CORE_OFFSET                0x10
> +#define CCTL_L2_STATUS_PER_CORE_OFFSET 4
> +
> +#define L2C_REG_CN_CMD_OFFSET(n)       \
> +       (L2C_REG_C0_CMD_OFFSET + ((n) * L2C_REG_PER_CORE_OFFSET))
> +#define L2C_REG_CN_ACC_OFFSET(n)       \
> +       (L2C_REG_C0_ACC_OFFSET + ((n) * L2C_REG_PER_CORE_OFFSET))
> +#define CCTL_L2_STATUS_CN_MASK(n)      \
> +       (CCTL_L2_STATUS_C0_MASK << ((n) * CCTL_L2_STATUS_PER_CORE_OFFSET))
> +
> +#define MICM_CFG_ISZ_OFFSET            6
> +#define MICM_CFG_ISZ_MASK              (0x7  << MICM_CFG_ISZ_OFFSET)
> +
> +#define MDCM_CFG_DSZ_OFFSET            6
> +#define MDCM_CFG_DSZ_MASK              (0x7  << MDCM_CFG_DSZ_OFFSET)
> +
> +#define CCTL_REG_UCCTLBEGINADDR_NUM    0x80b
> +#define CCTL_REG_UCCTLCOMMAND_NUM      0x80c
> +
> +#define MCACHE_CTL_CCTL_SUEN_OFFSET    8
> +#define MMSC_CFG_CCTLCSR_OFFSET                16
> +#define MISA_20_OFFSET                 20
> +
> +#define MCACHE_CTL_CCTL_SUEN_MASK      (0x1 << MCACHE_CTL_CCTL_SUEN_OFFSET)
> +#define MMSC_CFG_CCTLCSR_MASK          (0x1 << MMSC_CFG_CCTLCSR_OFFSET)
> +#define MISA_20_MASK                   (0x1 << MISA_20_OFFSET)
> +
> +#define MAX_CACHE_LINE_SIZE    256
> +
> +#define ANDES_AX45MP_MAX_PMA_REGIONS   16
> +
> +struct pma_arg_t {
> +       phys_addr_t offset;
> +       unsigned long vaddr;
> +       size_t size;
> +       size_t entry_id;
> +};
> +
> +struct ax45mp_cache_info {
> +       bool init_done;
> +       int dcache_line_size;
> +};
> +
> +static DEFINE_PER_CPU(struct ax45mp_cache_info, cpu_cache_info) = {
> +       .init_done = 0,
> +       .dcache_line_size = SZ_64,
> +};
> +
> +static void __iomem *l2c_base;
> +
> +/* -----------------------------------------------------------------------------
> + * PMA setup
> + */
> +static long sbi_set_pma(void *arg)
> +{
> +       phys_addr_t offset = ((struct pma_arg_t *)arg)->offset;
> +       unsigned long vaddr = ((struct pma_arg_t *)arg)->vaddr;
> +       size_t entry_id = ((struct pma_arg_t *)arg)->entry_id;
> +       size_t size = ((struct pma_arg_t *)arg)->size;
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_SET_PMA, offset, vaddr, size, entry_id, 0, 0);
> +
> +       return ret.value;
> +}
> +
> +static unsigned long cpu_nocache_area_set(unsigned long start,
> +                                         unsigned long size,
> +                                         unsigned long entry_id)
> +{
> +       struct pma_arg_t pma_arg;
> +       unsigned long ret = 0;
> +
> +       pma_arg.offset = start;
> +       pma_arg.size = size;
> +       pma_arg.vaddr = start + size;
> +       pma_arg.entry_id = entry_id;
> +       ret = sbi_set_pma(&pma_arg);
> +
> +       return ret;
> +}
> +
> +static void ax45mp_configure_pma_regions(struct device_node *np, int count)
> +{
> +       u64 start, size;
> +       unsigned int i;
> +
> +       for (i = 0 ; i < count ; i++) {
> +               of_property_read_u64_index(np, "pma-regions", (i << 1), &start);
> +               of_property_read_u64_index(np, "pma-regions", (i << 1) + 1, &size);
> +               cpu_nocache_area_set(start, size, i);
> +       }
> +}
> +
> +/* -----------------------------------------------------------------------------
> + * L2 Cache operations
> + */
> +static uint32_t cpu_get_mcache_ctl_status(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MCACHE_CTL_STATUS, 0, 0, 0, 0, 0, 0);
> +       return ret.value;
> +}
> +
> +static uint32_t cpu_get_micm_cfg_status(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MICM_CTL_STATUS, 0, 0, 0, 0, 0, 0);
> +       return ret.value;
> +}
> +
> +static uint32_t cpu_get_mdcm_cfg_status(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MDCM_CTL_STATUS, 0, 0, 0, 0, 0, 0);
> +       return ret.value;
> +}
> +
> +static uint32_t cpu_get_mmsc_cfg_status(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MMSC_CTL_STATUS, 0, 0, 0, 0, 0, 0);
> +       return ret.value;
> +}
> +
> +static uint32_t cpu_get_misa_cfg_status(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, SBI_EXT_ANDES_GET_MISA_CTL_STATUS, 0, 0, 0, 0, 0, 0);
> +       return ret.value;
> +}
> +
> +static void fill_cpu_cache_info(struct ax45mp_cache_info *cpu_ci)
> +{
> +       struct cpu_cacheinfo *this_cpu_ci =
> +                       get_cpu_cacheinfo(smp_processor_id());
> +       struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> +       unsigned int i;
> +
> +       for (i = 0; i < this_cpu_ci->num_leaves ; i++, this_leaf++) {
> +               if (this_leaf->type == CACHE_TYPE_DATA)
> +                       cpu_ci->dcache_line_size = this_leaf->coherency_line_size;
> +       }
> +
> +       cpu_ci->init_done = true;
> +}
> +
> +static inline int get_cache_line_size(void)
> +{
> +       struct ax45mp_cache_info *cpu_ci =
> +                       &per_cpu(cpu_cache_info, smp_processor_id());
> +
> +       if (unlikely(!cpu_ci->init_done))
> +               fill_cpu_cache_info(cpu_ci);
> +       return cpu_ci->dcache_line_size;
> +}
> +
> +static uint32_t cpu_l2c_get_cctl_status(void)
> +{
> +       return readl((void *)(l2c_base + L2C_REG_STATUS_OFFSET));
> +}
> +
> +static uint32_t cpu_l2c_ctl_status(void)
> +{
> +       return readl((void *)(l2c_base + L2C_REG_CTL_OFFSET));
> +}
> +
> +static bool cpu_cache_controlable(void)
> +{
> +       return (((cpu_get_micm_cfg_status() & MICM_CFG_ISZ_MASK) ||
> +                (cpu_get_mdcm_cfg_status() & MDCM_CFG_DSZ_MASK)) &&
> +               (cpu_get_misa_cfg_status() & MISA_20_MASK) &&
> +               (cpu_get_mmsc_cfg_status() & MMSC_CFG_CCTLCSR_MASK) &&
> +               (cpu_get_mcache_ctl_status() & MCACHE_CTL_CCTL_SUEN_MASK));
> +}
> +
> +static void cpu_dcache_wb_range(unsigned long start,
> +                               unsigned long end,
> +                               int line_size)
> +{
> +       bool ucctl_ok = false;
> +       unsigned long pa;
> +       int mhartid = 0;
> +#ifdef CONFIG_SMP
> +       mhartid = smp_processor_id();
> +#endif
> +
> +       ucctl_ok = cpu_cache_controlable();
> +
> +       while (end > start) {
> +               if (ucctl_ok) {
> +                       csr_write(CCTL_REG_UCCTLBEGINADDR_NUM, start);
> +                       csr_write(CCTL_REG_UCCTLCOMMAND_NUM, CCTL_L1D_VA_WB);
> +               }
> +
> +               if (l2c_base && (cpu_l2c_ctl_status() & L2_CACHE_CTL_CEN_MASK)) {
> +                       pa = virt_to_phys((void *)start);
> +                       writel(pa, (void *)(l2c_base + L2C_REG_CN_ACC_OFFSET(mhartid)));
> +                       writel(CCTL_L2_PA_WB, (void *)(l2c_base + L2C_REG_CN_CMD_OFFSET(mhartid)));
> +                       while ((cpu_l2c_get_cctl_status() &
> +                               CCTL_L2_STATUS_CN_MASK(mhartid)) != CCTL_L2_STATUS_IDLE)
> +                               ;
> +               }
> +
> +               start += line_size;
> +       }
> +}
> +
> +static void cpu_dcache_inval_range(unsigned long start,
> +                                  unsigned long end,
> +                                  int line_size)
> +{
> +       bool ucctl_ok = false;
> +       unsigned long pa;
> +       int mhartid = 0;
> +#ifdef CONFIG_SMP
> +       mhartid = smp_processor_id();
> +#endif
> +
> +       ucctl_ok = cpu_cache_controlable();
> +
> +       while (end > start) {
> +               if (ucctl_ok) {
> +                       csr_write(CCTL_REG_UCCTLBEGINADDR_NUM, start);
> +                       csr_write(CCTL_REG_UCCTLCOMMAND_NUM, CCTL_L1D_VA_INVAL);
> +               }
> +
> +               if (l2c_base && (cpu_l2c_ctl_status() & L2_CACHE_CTL_CEN_MASK)) {
> +                       pa = virt_to_phys((void *)start);
> +                       writel(pa, (void *)(l2c_base + L2C_REG_CN_ACC_OFFSET(mhartid)));
> +                       writel(CCTL_L2_PA_INVAL,
> +                              (void *)(l2c_base + L2C_REG_CN_CMD_OFFSET(mhartid)));
> +                       while ((cpu_l2c_get_cctl_status() &
> +                               CCTL_L2_STATUS_CN_MASK(mhartid)) != CCTL_L2_STATUS_IDLE)
> +                               ;
> +               }
> +
> +               start += line_size;
> +       }
> +}
> +
> +void rzfive_cpu_dma_inval_range(void *vaddr, size_t size)
> +{
> +       unsigned long line_size = get_cache_line_size();
> +       char cache_buf[2][MAX_CACHE_LINE_SIZE] = { 0 };
> +       unsigned long start = (unsigned long)vaddr;
> +       unsigned long end = start + size;
> +       unsigned long old_start = start;
> +       unsigned long old_end = end;
> +       unsigned long flags;
> +
> +       if (unlikely(start == end))
> +               return;
> +
> +       start = start & (~(line_size - 1));
> +       end = ((end + line_size - 1) & (~(line_size - 1)));
> +
> +       local_irq_save(flags);
> +       if (unlikely(start != old_start))
> +               memcpy(&cache_buf[0][0], (void *)start, line_size);
> +
> +       if (unlikely(end != old_end))
> +               memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), line_size);
> +
> +       cpu_dcache_inval_range(start, end, line_size);
> +
> +       if (unlikely(start != old_start))
> +               memcpy((void *)start, &cache_buf[0][0], (old_start & (line_size - 1)));
> +
> +       if (unlikely(end != old_end))
> +               memcpy((void *)(old_end + 1),
> +                      &cache_buf[1][(old_end & (line_size - 1)) + 1],
> +                      end - old_end - 1);
> +
> +       local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(rzfive_cpu_dma_inval_range);
> +
> +void rzfive_cpu_dma_wb_range(void *vaddr, size_t size)
> +{
> +       unsigned long line_size = get_cache_line_size();
> +       unsigned long start = (unsigned long)vaddr;
> +       unsigned long end = start + size;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       start = start & (~(line_size - 1));
> +       cpu_dcache_wb_range(start, end, line_size);
> +       local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(rzfive_cpu_dma_wb_range);
> +
> +static const struct of_device_id ax45mp_cache_ids[] = {
> +       { .compatible = "andestech,ax45mp-cache" },
> +       { /* sentinel */ }
> +};
> +
> +static int __init ax45mp_cache_init(void)
> +{
> +       struct device_node *np;
> +       int count;
> +
> +       np = of_find_matching_node(NULL, ax45mp_cache_ids);
> +       if (!np)
> +               return -ENODEV;
> +
> +       l2c_base = of_iomap(np, 0);
> +       if (!l2c_base)
> +               return -ENOMEM;
> +
> +       count = of_property_count_elems_of_size(np, "pma-regions",
> +                                               sizeof(u32) * 4);
> +       if (count > ANDES_AX45MP_MAX_PMA_REGIONS) {
> +               iounmap(l2c_base);
> +               return -EINVAL;
> +       }
> +
> +       ax45mp_configure_pma_regions(np, count);
> +
> +       return 0;
> +}
> +arch_initcall(ax45mp_cache_init);
> diff --git a/drivers/soc/renesas/rzf/rzf_sbi.h b/drivers/soc/renesas/rzf/rzf_sbi.h
> new file mode 100644
> index 000000000000..854fee667276
> --- /dev/null
> +++ b/drivers/soc/renesas/rzf/rzf_sbi.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ARCH_R9A07G043_SBI_H
> +#define __ARCH_R9A07G043_SBI_H
> +
> +enum sbi_ext_andes_fid {
> +       SBI_EXT_ANDES_GET_MCACHE_CTL_STATUS = 0,
> +       SBI_EXT_ANDES_GET_MMISC_CTL_STATUS,
> +       SBI_EXT_ANDES_SET_MCACHE_CTL,
> +       SBI_EXT_ANDES_SET_MMISC_CTL,
> +       SBI_EXT_ANDES_ICACHE_OP,
> +       SBI_EXT_ANDES_DCACHE_OP,
> +       SBI_EXT_ANDES_L1CACHE_I_PREFETCH,
> +       SBI_EXT_ANDES_L1CACHE_D_PREFETCH,
> +       SBI_EXT_ANDES_NON_BLOCKING_LOAD_STORE,
> +       SBI_EXT_ANDES_WRITE_AROUND,
> +       SBI_EXT_ANDES_SET_PMA,
> +       SBI_EXT_ANDES_FREE_PMA,
> +       SBI_EXT_ANDES_PROBE_PMA,
> +       SBI_EXT_ANDES_DCACHE_WBINVAL_ALL,
> +       SBI_EXT_ANDES_GET_MICM_CTL_STATUS,
> +       SBI_EXT_ANDES_GET_MDCM_CTL_STATUS,
> +       SBI_EXT_ANDES_GET_MMSC_CTL_STATUS,
> +       SBI_EXT_ANDES_GET_MISA_CTL_STATUS,
> +};
> +
> +#endif
> --
> 2.25.1
>


-- 
Best Regards
 Guo Ren
