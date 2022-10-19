Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0425A604595
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiJSMmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiJSMmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:42:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37F632042
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:24:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id 13so39426170ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QMeiIZiyblteVRq78CiV17LjNnwkts3YE/C63wZ/Nwc=;
        b=BOfrgwQgEzrrFhKlFXE5x9tOZKfxASj6ILDrcwagHhpNJzX2kSs2Pfwaq05XnINQrP
         l9Dcw6XLRGkIV/RuE9xQwi3EOMuw+8BlM+Ttw8VcjZ1tO542VMZUeok+gYu6K2Oxcoyv
         JCS7h9hBMXUcEQpLUiz14l5B1rJUeimFAXFYKlVtg6KB/j5ZC3t1NvKNhYliUgE/09kP
         FvO3ZTD6PyMJqSljuEY6tvCuYO8TVwCyijjZjXl1Zj1l3BP5xzgYzNvZ72LIeSl75qJE
         gAVd+M+YBGvhGKF3dsq+fGiSHDVzzhN+pJS4OGO8eaYTaC3lfevZaCl2XTNxkVAAcOI0
         oi8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMeiIZiyblteVRq78CiV17LjNnwkts3YE/C63wZ/Nwc=;
        b=TmxgkYbhKNwXElN70OJlSplqrrwwXL57eglCSfBkz0kiRlAa48gueun0MYJ7iUAe+f
         Ep+MvBXeWR1jmsRaK5GmO4pALoYEdEOwp5X8EFquYurF6YlqISRNFfxmmyaZj+tghJIx
         6zkYijmNEqr+m19DONZbkizPJ0t70cPT5MJc+fZHPcJCC5ZTTXf1qqJCg/Aja9zdxjvA
         ZtkujCHqr4wKrocFdUzK640QYYLomJqo4GtMomsy3vqom/2kPjWY0wp5bdNzmHszalYR
         LhEMCQcSJbu6IBvXhUU8cUR7/Se2Z6MG1GgUMBog10vDbpyg/u69mB1CtRFEcDyRDskr
         zyGQ==
X-Gm-Message-State: ACrzQf0x/aBXUMGn8T5r5CFuKKaz8r8DX328JIqH71S7ITq1vK+Dyq5L
        iVHpT1s7j+WPs9+4IC/5EkKxQr+anxWmP2VqXgm7Ng==
X-Google-Smtp-Source: AMsMyM549WtB2Hp0Bg2is6s2aYzKVD5TFE9cKOvyf0h+dgbaICCawPeNl7yp77ABZoj2vRJfgHQWT34GvNzmBoECr2U=
X-Received: by 2002:a17:906:ee81:b0:77e:829a:76e9 with SMTP id
 wt1-20020a170906ee8100b0077e829a76e9mr6852093ejb.207.1666182176287; Wed, 19
 Oct 2022 05:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221019121622.179024-1-apatel@ventanamicro.com> <20221019121622.179024-2-apatel@ventanamicro.com>
In-Reply-To: <20221019121622.179024-2-apatel@ventanamicro.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 19 Oct 2022 17:52:42 +0530
Message-ID: <CAAhSdy1bjD15c-xnhHv6K9Zsy_fvmNU6w=TyM1hS41MYtJkmTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>,
        Anup Patel <apatel@ventanamicro.com>,
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

Hi Palmer,

On Wed, Oct 19, 2022 at 5:46 PM Anup Patel <apatel@ventanamicro.com> wrote:
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

Currently, the KVM RISC-V compilation is broken for toolchains not
having Zicbom support.

I plan to take this patch through the KVM RISC-V tree and I will be
sending a PR by the end of this week. Let me know if you want this
patch to go through the RISC-V tree.

Regards,
Anup

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
>                 flush_icache_all();
>  }
>  #endif /* CONFIG_MMU */
> +
> +unsigned int riscv_cbom_block_size;
> +EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
> +
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
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
