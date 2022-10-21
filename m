Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6441606D64
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJUCFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJUCFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:05:03 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431DB83065;
        Thu, 20 Oct 2022 19:05:01 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13af2d12469so1813491fac.13;
        Thu, 20 Oct 2022 19:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtW26tNJi2plHYwK2h9n3QRnfHabzcCc19G/v2p4e10=;
        b=GU11aH5t8T9MVt5luk6ywyCdLEv3OUgoIoCxFivFSQE0UiiFjVguhFgtmVOux1agH7
         qtF+hr7sLqYzqvDMyp0EGsi5nY2Sciyjxz3bvMxe/+tjix2jujOeZ5GzZ8B6bpxA68fJ
         fxLIWBr6exkR2CXD+YPfRFzbRFM5+IZIiDh3vRglpLx84Nn44k2prPA8NAkrpwg2TnHO
         uKutZfVLNQ4kHwdrbD1yBWcqtKVKkZaecuGpOxWoKAJArFhAwaCsIYlOXNG6NeuaTaVq
         +47qObqP7EzAghIeEAcEiCSJH1sz+0F7twzs1yI35P1sisX0eZYmuOGm3P+ksIAvk/zd
         QF+g==
X-Gm-Message-State: ACrzQf1waFqNx3a+s9pVDS+iQiFbKzgxEctFxZzvbRcnhI7G/3uYzicK
        KemHtMBLxy9rNY01biWPGg==
X-Google-Smtp-Source: AMsMyM5LTuz/GmwOzCctHS9o8ZK1b/pNNGI4hDlv65UEoxwYHaOF+90LSP0uzUBQQtEaDH2FZicxEA==
X-Received: by 2002:a05:6870:eca0:b0:133:34b:ebdf with SMTP id eo32-20020a056870eca000b00133034bebdfmr10680784oab.14.1666317900416;
        Thu, 20 Oct 2022 19:05:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e1-20020a9d63c1000000b006618bbede10sm565732otl.53.2022.10.20.19.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:04:59 -0700 (PDT)
Received: (nullmailer pid 2171392 invoked by uid 1000);
        Fri, 21 Oct 2022 02:05:00 -0000
Date:   Thu, 20 Oct 2022 21:05:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
Message-ID: <20221021020500.GA2157489-robh@kernel.org>
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 11:02:42PM +0100, Prabhakar wrote:
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
> ---
>  arch/riscv/include/asm/cacheflush.h    |   8 +
>  arch/riscv/include/asm/errata_list.h   |   2 +
>  arch/riscv/mm/dma-noncoherent.c        |  20 ++
>  drivers/soc/renesas/Kconfig            |   5 +
>  drivers/soc/renesas/Makefile           |   4 +
>  drivers/soc/renesas/rzf/Kconfig        |   6 +
>  drivers/soc/renesas/rzf/Makefile       |   3 +
>  drivers/soc/renesas/rzf/ax45mp_cache.c | 431 +++++++++++++++++++++++++

How many cache drivers do we have around now? I've seen a few bindings 
go by. I'm guessing it is time to stop putting the drivers in the
drivers/soc/ dumping ground.
 
>  drivers/soc/renesas/rzf/ax45mp_sbi.h   |  29 ++
>  9 files changed, 508 insertions(+)
>  create mode 100644 drivers/soc/renesas/rzf/Kconfig
>  create mode 100644 drivers/soc/renesas/rzf/Makefile
>  create mode 100644 drivers/soc/renesas/rzf/ax45mp_cache.c
>  create mode 100644 drivers/soc/renesas/rzf/ax45mp_sbi.h
> 
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 8a5c246b0a21..40aa790be9a3 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -65,6 +65,14 @@ static inline void riscv_noncoherent_supported(void) {}
>  #define SYS_RISCV_FLUSH_ICACHE_LOCAL 1UL
>  #define SYS_RISCV_FLUSH_ICACHE_ALL   (SYS_RISCV_FLUSH_ICACHE_LOCAL)
>  
> +#ifdef CONFIG_AX45MP_L2_CACHE
> +void ax45mp_cpu_dma_inval_range(void *vaddr, size_t end);
> +void ax45mp_cpu_dma_wb_range(void *vaddr, size_t end);
> +
> +#define ALT_CMO_OP(_op, _start, _size, _cachesize)	\
> +		   _op(_start, _size)
> +#endif
> +
>  #include <asm-generic/cacheflush.h>
>  
>  #endif /* _ASM_RISCV_CACHEFLUSH_H */
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 19a771085781..d9cbf60c3b65 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(						\
>  #define ALT_THEAD_PMA(_val)
>  #endif
>  
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>  /*
>   * dcache.ipa rs1 (invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(						\
>  	: "a0")
>  
>  #endif /* __ASSEMBLY__ */
> +#endif
>  
>  #endif
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index b0add983530a..5270acca6766 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  
>  	switch (dir) {
>  	case DMA_TO_DEVICE:
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>  		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +#elif CONFIG_AX45MP_L2_CACHE
> +		ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, 0x0);
> +#endif

How do you support more than one platform in a build?

Rob
