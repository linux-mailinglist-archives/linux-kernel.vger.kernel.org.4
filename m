Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35A060706D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJUGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiJUGtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:49:05 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4E22441B6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:48:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so4740994ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kposaFjP9tGNDU6RsynvghOa2L/fSYBTgCuOyld6rlE=;
        b=LnjNyBgv89M9/oEG9Xx7uru9y51OlYugEl04t0/ZZ5MSoBchWjWEt9gZkaYdLP5lEH
         5oQsXnuJ7z2/SmxxPkeF0k+AhBnpcT1MRse6xGb6wlTSE9/la7lH7DmpxtdqlMdq9ILU
         yVkhdNVO3OBcJcUzw9i0hG3VTGliRMFQZ1GF/EE/mNz8ZN4mqbRPKs6YsP64dKBVUSfl
         cHVrVWewKTB3sOOj4Sg/67VXiJl6xwsTJ2THZRyYnyH7+GR1j4J7WSwuhfRuZWiUzN1W
         y878eBOysiLtIB8vWd/lhax539bwSCzO6CNzlChFbsUaqLxjy+ehojNi87SS0IOeK9pb
         KROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kposaFjP9tGNDU6RsynvghOa2L/fSYBTgCuOyld6rlE=;
        b=PP1EONvyd5fSw9g2sIgB315CSHAZdrpW68I2CZT2axY1TPWVDk1MfI3Q2O1GfjCecI
         k2BdOZDmVt3iuGtLFr2DFO5lIGSCO6pHfTFWE5keUO/LSc4mUTKLnXb0Lzyvf9nNWMRN
         geXdBnoaaSwsMBVXeX8wMsGmurmvoSjaSMUf8GSVa6y0faGiJ1EocdoSLex68zsUQE+9
         GxrrYEKMc22gwvODrHOkBLlKtU/YSbtXu3ItXx6MkMaJ14mFENc0z40Syu1R8ZzCxQUN
         K5SjXFoyLbmX8obeV7ZAjcgbkUEi0Bpz6gYdnHStjAwcJeva+p0Pda/dpHLfdclBzMT0
         iLkw==
X-Gm-Message-State: ACrzQf1IzKAdfk7X+CyDrJxkVKCuT+X9KP7kBPStVt9Fwuj12KK2COMf
        iE04/pdlfYy/wrbMgiDeuiQftAl/t9m+QEGS9o6a1w==
X-Google-Smtp-Source: AMsMyM6egeTwhOqIpP5aQx+pcgRvs00YsV3VveAcrvT62m0d5QLjEF4YN+zj/Jrpizw03RcGsS60K+omayKWqKa9OHY=
X-Received: by 2002:a17:907:96a6:b0:78d:b6f6:3886 with SMTP id
 hd38-20020a17090796a600b0078db6f63886mr14721537ejc.106.1666334929136; Thu, 20
 Oct 2022 23:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221020075846.305576-1-apatel@ventanamicro.com> <20221020075846.305576-2-apatel@ventanamicro.com>
In-Reply-To: <20221020075846.305576-2-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 21 Oct 2022 12:18:37 +0530
Message-ID: <CAAhSdy3csF4ubVHxd=HuwL77Ox1huTUrQZK=HL7HhSsZBLcbQw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 1:29 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
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
>
> Fixes: 8f7e001e0325 ("RISC-V: Clean up the Zicbom block size probing")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

I have queued this patch for Linux-6.1-rcX since it fixes
compile error for KVM RISC-V.

Regards,
Anup

> ---
>  arch/riscv/include/asm/cacheflush.h |  8 ------
>  arch/riscv/mm/cacheflush.c          | 38 ++++++++++++++++++++++++++
>  arch/riscv/mm/dma-noncoherent.c     | 41 -----------------------------
>  3 files changed, 38 insertions(+), 49 deletions(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 8a5c246b0a21..f6fbe7042f1c 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -42,16 +42,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local);
>
>  #endif /* CONFIG_SMP */
>
> -/*
> - * The T-Head CMO errata internally probe the CBOM block size, but otherwise
> - * don't depend on Zicbom.
> - */
>  extern unsigned int riscv_cbom_block_size;
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
>  void riscv_init_cbom_blocksize(void);
> -#else
> -static inline void riscv_init_cbom_blocksize(void) { }
> -#endif
>
>  #ifdef CONFIG_RISCV_DMA_NONCOHERENT
>  void riscv_noncoherent_supported(void);
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index 6cb7d96ad9c7..57b40a350420 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2017 SiFive
>   */
>
> +#include <linux/of.h>
>  #include <asm/cacheflush.h>
>
>  #ifdef CONFIG_SMP
> @@ -86,3 +87,40 @@ void flush_icache_pte(pte_t pte)
>                 flush_icache_all();
>  }
>  #endif /* CONFIG_MMU */
> +
> +unsigned int riscv_cbom_block_size;
> +EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
> +
> +void riscv_init_cbom_blocksize(void)
> +{
> +       struct device_node *node;
> +       unsigned long cbom_hartid;
> +       u32 val, probed_block_size;
> +       int ret;
> +
> +       probed_block_size = 0;
> +       for_each_of_cpu_node(node) {
> +               unsigned long hartid;
> +
> +               ret = riscv_of_processor_hartid(node, &hartid);
> +               if (ret)
> +                       continue;
> +
> +               /* set block-size for cbom extension if available */
> +               ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> +               if (ret)
> +                       continue;
> +
> +               if (!probed_block_size) {
> +                       probed_block_size = val;
> +                       cbom_hartid = hartid;
> +               } else {
> +                       if (probed_block_size != val)
> +                               pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
> +                                       cbom_hartid, hartid);
> +               }
> +       }
> +
> +       if (probed_block_size)
> +               riscv_cbom_block_size = probed_block_size;
> +}
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
>         dev->dma_coherent = coherent;
>  }
>
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
> -void riscv_init_cbom_blocksize(void)
> -{
> -       struct device_node *node;
> -       unsigned long cbom_hartid;
> -       u32 val, probed_block_size;
> -       int ret;
> -
> -       probed_block_size = 0;
> -       for_each_of_cpu_node(node) {
> -               unsigned long hartid;
> -
> -               ret = riscv_of_processor_hartid(node, &hartid);
> -               if (ret)
> -                       continue;
> -
> -               /* set block-size for cbom extension if available */
> -               ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> -               if (ret)
> -                       continue;
> -
> -               if (!probed_block_size) {
> -                       probed_block_size = val;
> -                       cbom_hartid = hartid;
> -               } else {
> -                       if (probed_block_size != val)
> -                               pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
> -                                       cbom_hartid, hartid);
> -               }
> -       }
> -
> -       if (probed_block_size)
> -               riscv_cbom_block_size = probed_block_size;
> -}
> -#endif
> -
>  void riscv_noncoherent_supported(void)
>  {
>         WARN(!riscv_cbom_block_size,
> --
> 2.34.1
>
