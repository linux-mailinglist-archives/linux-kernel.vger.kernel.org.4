Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1F60AF4A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJXPlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiJXPkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:40:46 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEF8A98C9;
        Mon, 24 Oct 2022 07:30:35 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so6130122qkk.7;
        Mon, 24 Oct 2022 07:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9qF1Rvllj4BtsCBG7Cn5V9JrHYVjBhx5pA0E/JzBw8=;
        b=6I++0yMEesxQapQUpU3sa07Zt/7H5Czlp0oV7mlbwmSGQlQFca3NvARyR4hgv7hyyN
         92ljU+t+sJIUZ4nlnWH1yczht278tP0n1kbLaARonczswxyLvTE+lMSEnROuMPW4SyMD
         UhjScwVzgrD2X8hjdPuf/BwjPUobSL8ZWWyoHH/nWEJVutxqY6qwPjbS7fOeswnmS8ch
         CqzGsdIXTJNno5pldyfv3cjxq+AATMb6uChCxAHNR9P+GRXVjNODGOLNMpbADQ1P1YVX
         4ou4XNwq/JhCMmnNpvX2jt861DQzZFsBs39yrp8Cz5/AHeFNmv5yy+HVCU6aOk7JdtS8
         EJLQ==
X-Gm-Message-State: ACrzQf2lS+8wRFdVecYMGr1GCy+2qAi/HyfuApUZfy3nmBkN0sumiiJT
        5hT4TFW6SBMufKl4gc4FqSVq2LyW7Z4Pkw==
X-Google-Smtp-Source: AMsMyM62iGCgHsC36yJglrj9B70GnN5CTYkZTCH8cwt/KuSLmF9rDiZGyKyXmiNiyldlHD5SZhmWKA==
X-Received: by 2002:a05:620a:294b:b0:6ee:cfd2:1cfe with SMTP id n11-20020a05620a294b00b006eecfd21cfemr21568030qkp.363.1666621369755;
        Mon, 24 Oct 2022 07:22:49 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id d13-20020a05620a240d00b006bc192d277csm67130qkn.10.2022.10.24.07.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:22:49 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id f205so11228627yba.2;
        Mon, 24 Oct 2022 07:22:48 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr27332087ybb.604.1666621368623; Mon, 24
 Oct 2022 07:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Oct 2022 16:22:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXSk7RJa4JQNCV6hU9ZMeC3oSEj=MJhTtKauxaWpiGREw@mail.gmail.com>
Message-ID: <CAMuHMdXSk7RJa4JQNCV6hU9ZMeC3oSEj=MJhTtKauxaWpiGREw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

(fixed Palmer's address)

On Thu, Oct 20, 2022 at 12:02 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
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
> ops.
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

Thanks for your patch!

> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -340,9 +340,14 @@ if RISCV
>  config ARCH_R9A07G043
>         bool "RISC-V Platform support for RZ/Five"
>         select ARCH_RZG2L
> +       select AX45MP_L2_CACHE
> +       select DMA_GLOBAL_POOL
> +       select RISCV_DMA_NONCOHERENT
>         help
>           This enables support for the Renesas RZ/Five SoC.
>
> +source "drivers/soc/renesas/rzf/Kconfig"

s/rzf/rzfive/? (or "rz5"? "rzv"?)

> +
>  endif # RISCV
>
>  config RST_RCAR
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

obj-$(CONFIG_RISCV)

> --- /dev/null
> +++ b/drivers/soc/renesas/rzf/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config AX45MP_L2_CACHE
> +       bool "AX45MP L2 Cache controller"

Andes Technology ...

> +       help
> +         Support for the L2 cache controller on AX45MP platforms.

... Andes Technology ...

> --- /dev/null
> +++ b/drivers/soc/renesas/rzf/ax45mp_cache.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PMA setup and non-coherent cache functions for AX45MP
> + *
> + * Copyright (C) 2022 Renesas Electronics Corp.
> + */
> +
> +#include <linux/cacheflush.h>
> +#include <linux/cacheinfo.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/sbi.h>
> +
> +#include "ax45mp_sbi.h"
> +
> +/* L2 cache registers */
> +#define AX45MP_L2C_REG_CTL_OFFSET              0x8
> +#define AX45MP_L2C_IPREPETCH_OFF               3
> +#define AX45MP_L2C_DPREPETCH_OFF               5
> +#define AX45MP_L2C_IPREPETCH_MSK               (3 << AX45MP_L2C_IPREPETCH_OFF)
> +#define AX45MP_L2C_DPREPETCH_MSK               (3 << AX45MP_L2C_DPREPETCH_OFF)

#define AX45MP_L2C_IPREPETCH    GENMASK(4, 3)
etc., and then you can use the FIELD_PREP() macros.

> +#define AX45MP_L2C_TRAMOCTL_OFF                        8
> +#define AX45MP_L2C_TRAMICTL_OFF                        10
> +#define AX45MP_L2C_TRAMOCTL_MSK                        (3 << AX45MP_L2C_TRAMOCTL_OFF)
> +#define AX45MP_L2C_TRAMICTL_MSK                        BIT(AX45MP_L2C_TRAMICTL_OFF)
> +#define AX45MP_L2C_DRAMOCTL_OFF                        11
> +#define AX45MP_L2C_DRAMICTL_OFF                        13
> +#define AX45MP_L2C_DRAMOCTL_MSK                        (3 << AX45MP_L2C_DRAMOCTL_OFF)
> +#define AX45MP_L2C_DRAMICTL_MSK                        BIT(AX45MP_L2C_DRAMICTL_OFF)

> +
> +#define AX45MP_MAX_CACHE_LINE_SIZE             256
> +
> +#define AX45MP_MAX_PMA_REGIONS                 16
> +
> +struct ax45mp_priv {
> +       void __iomem *l2c_base;
> +       unsigned int ax45mp_cache_line_size;
> +       bool l2cache_enabled;
> +       bool ucctl_ok;
> +};
> +
> +static struct ax45mp_priv *ax45mp_priv;
> +static DEFINE_STATIC_KEY_FALSE(ax45mp_l2c_configured);
> +
> +/* PMA setup */
> +static long ax45mp_sbi_set_pma(unsigned long start,
> +                              unsigned long size,
> +                              unsigned long flags,
> +                              unsigned int entry_id)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_ANDES, AX45MP_SBI_EXT_SET_PMA,
> +                       start, start + size, size, entry_id,
> +                       flags, 0);

Fits on two lines.

> +
> +       return ret.value;
> +}
> +
> +static int ax45mp_configure_pma_regions(struct device_node *np)
> +{
> +       const char *propname = "andestech,pma-regions";
> +       u64 start, size, flags;
> +       unsigned int entry_id;
> +       unsigned int i;
> +       int count;
> +       int ret;
> +
> +       count = of_property_count_elems_of_size(np, propname,
> +                                               sizeof(u32) * 6);

Fits on a single line.

> +static inline uint32_t ax45mp_cpu_l2c_get_cctl_status(void)
> +{
> +       return readl((void *)(ax45mp_priv->l2c_base + AX45MP_L2C_REG_STATUS_OFFSET));

Why the cast to "(void *)"?

> +}
> +
> +static inline uint32_t ax45mp_cpu_l2c_ctl_status(void)
> +{
> +       return readl((void *)(ax45mp_priv->l2c_base + AX45MP_L2C_REG_CTL_OFFSET));

Likewise.

> +}

> +static void ax45mp_cpu_dcache_wb_range(unsigned long start,
> +                                      unsigned long end,
> +                                      int line_size)
> +{
> +       void __iomem *base = ax45mp_priv->l2c_base;
> +       unsigned long pa;
> +       int mhartid = 0;
> +#ifdef CONFIG_SMP
> +       mhartid = smp_processor_id();
> +#endif
> +
> +       while (end > start) {
> +               if (ax45mp_priv->ucctl_ok) {
> +                       csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
> +                       csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_WB);
> +               }
> +
> +               if (ax45mp_priv->l2cache_enabled) {
> +                       pa = virt_to_phys((void *)start);

Looks like start and end should be "void *" instead of " unsigned long",
as they are virtual addresses. See also below...

> +                       writel(pa, (void *)(base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid)));
> +                       writel(AX45MP_CCTL_L2_PA_WB,
> +                              (void *)(base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid)));

Why the casts to "(void *)"?

> +                       while ((ax45mp_cpu_l2c_get_cctl_status() &
> +                               AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
> +                               AX45MP_CCTL_L2_STATUS_IDLE)
> +                               ;
> +               }
> +
> +               start += line_size;
> +       }
> +}
> +
> +static void ax45mp_cpu_dcache_inval_range(unsigned long start,
> +                                         unsigned long end,
> +                                         int line_size)
> +{
> +       void __iomem *base = ax45mp_priv->l2c_base;
> +       unsigned long pa;
> +       int mhartid = 0;
> +#ifdef CONFIG_SMP
> +       mhartid = smp_processor_id();
> +#endif
> +
> +       while (end > start) {
> +               if (ax45mp_priv->ucctl_ok) {
> +                       csr_write(AX45MP_CCTL_REG_UCCTLBEGINADDR_NUM, start);
> +                       csr_write(AX45MP_CCTL_REG_UCCTLCOMMAND_NUM, AX45MP_CCTL_L1D_VA_INVAL);
> +               }
> +
> +               if (ax45mp_priv->l2cache_enabled) {
> +                       pa = virt_to_phys((void *)start);

Looks like start and end should be "void *" instead of " unsigned long",
as they are virtual addresses. See also below...

> +                       writel(pa, (void *)(base + AX45MP_L2C_REG_CN_ACC_OFFSET(mhartid)));
> +                       writel(AX45MP_CCTL_L2_PA_INVAL,
> +                              (void *)(base + AX45MP_L2C_REG_CN_CMD_OFFSET(mhartid)));
> +                       while ((ax45mp_cpu_l2c_get_cctl_status() &
> +                               AX45MP_CCTL_L2_STATUS_CN_MASK(mhartid)) !=
> +                               AX45MP_CCTL_L2_STATUS_IDLE)
> +                               ;
> +               }
> +
> +               start += line_size;
> +       }
> +}
> +
> +void ax45mp_cpu_dma_inval_range(void *vaddr, size_t size)
> +{
> +       char cache_buf[2][AX45MP_MAX_CACHE_LINE_SIZE] = { 0 };

AX45MP_MAX_CACHE_LINE_SIZE = 256, so 512 bytes of data on the stack,
auto-initialized by memset().

Please remove the { 0 }, ...

> +       unsigned long start = (unsigned long)vaddr;
> +       unsigned long end = start + size;
> +       unsigned long old_start = start;
> +       unsigned long old_end = end;
> +       unsigned long line_size;
> +       unsigned long flags;
> +
> +       if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
> +               return;
> +
> +       if (unlikely(start == end))
> +               return;
> +
> +       line_size = ax45mp_priv->ax45mp_cache_line_size;

... and call memset() here, so the buffer is not initialized when unused.
Perhaps use two buffers, so you can easily memset() only the part that is
used?

> +
> +       start = start & (~(line_size - 1));
> +       end = ((end + line_size - 1) & (~(line_size - 1)));

These are the only calculations that need to use "unsigned long"
instead of "void *", but you can use PTR_ALIGN_DOWN() and PTR_ALIGN()
to avoid explicit casts.

> +
> +       local_irq_save(flags);
> +       if (unlikely(start != old_start))
> +               memcpy(&cache_buf[0][0], (void *)start, line_size);
> +
> +       if (unlikely(end != old_end))
> +               memcpy(&cache_buf[1][0], (void *)(old_end & (~(line_size - 1))), line_size);

PTR_ALIGN_DOWN()

> +
> +       ax45mp_cpu_dcache_inval_range(start, end, line_size);
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
> +EXPORT_SYMBOL(ax45mp_cpu_dma_inval_range);
> +
> +void ax45mp_cpu_dma_wb_range(void *vaddr, size_t size)
> +{
> +       unsigned long start = (unsigned long)vaddr;
> +       unsigned long end = start + size;
> +       unsigned long line_size;
> +       unsigned long flags;
> +
> +       if (static_branch_unlikely(&ax45mp_l2c_configured) && !ax45mp_priv)
> +               return;
> +
> +       line_size = ax45mp_priv->ax45mp_cache_line_size;
> +       local_irq_save(flags);
> +       start = start & (~(line_size - 1));

PTR_ALIGN_DOWN() etc...

> +       ax45mp_cpu_dcache_wb_range(start, end, line_size);
> +       local_irq_restore(flags);
> +}
> +EXPORT_SYMBOL(ax45mp_cpu_dma_wb_range);
> +
> +static int ax45mp_configure_l2_cache(struct device_node *np)
> +{
> +       u8 ram_ctl[2];
> +       u32 cache_ctl;
> +       u32 prefetch;
> +       int ret;
> +
> +       cache_ctl = ax45mp_cpu_l2c_ctl_status();
> +
> +       /* Instruction and data fetch prefetch depth */
> +       ret = of_property_read_u32(np, "andestech,inst-prefetch", &prefetch);
> +       if (!ret) {
> +               cache_ctl &= ~AX45MP_L2C_IPREPETCH_MSK;
> +               cache_ctl |= (prefetch << AX45MP_L2C_IPREPETCH_OFF);

FIELD_PREP(), also below

> +       }
> +
> +       ret = of_property_read_u32(np, "andestech,data-prefetch", &prefetch);
> +       if (!ret) {
> +               cache_ctl &= ~AX45MP_L2C_DPREPETCH_MSK;
> +               cache_ctl |= (prefetch << AX45MP_L2C_DPREPETCH_OFF);

prefect / 2

> +       }
> +
> +       /* tag RAM and data RAM setup and output cycle */
> +       ret = of_property_read_u8_array(np, "andestech,tag-ram-ctl", ram_ctl, 2);
> +       if (!ret) {
> +               cache_ctl &= ~(AX45MP_L2C_TRAMOCTL_MSK | AX45MP_L2C_TRAMICTL_MSK);
> +               cache_ctl |= ram_ctl[0] << AX45MP_L2C_TRAMOCTL_OFF;
> +               cache_ctl |= ram_ctl[1] << AX45MP_L2C_TRAMICTL_OFF;
> +       }
> +
> +       ret = of_property_read_u8_array(np, "andestech,data-ram-ctl", ram_ctl, 2);
> +       if (!ret) {
> +               cache_ctl &= ~(AX45MP_L2C_DRAMOCTL_MSK | AX45MP_L2C_DRAMICTL_MSK);
> +               cache_ctl |= ram_ctl[0] << AX45MP_L2C_DRAMOCTL_OFF;
> +               cache_ctl |= ram_ctl[1] << AX45MP_L2C_DRAMICTL_OFF;
> +       }
> +
> +       writel(cache_ctl, ax45mp_priv->l2c_base + AX45MP_L2C_REG_CTL_OFFSET);
> +
> +       ret = of_property_read_u32(np, "cache-line-size", &ax45mp_priv->ax45mp_cache_line_size);

According to the bindings, this must be 64?

> +       if (ret) {
> +               pr_err("Failed to get cache-line-size defaulting to 64 bytes\n");
> +               ax45mp_priv->ax45mp_cache_line_size = SZ_64;
> +       }
> +
> +       ax45mp_priv->ucctl_ok = ax45mp_cpu_cache_controlable();
> +       ax45mp_priv->l2cache_enabled = ax45mp_cpu_l2c_ctl_status() & AX45MP_L2_CACHE_CTL_CEN_MASK;
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
