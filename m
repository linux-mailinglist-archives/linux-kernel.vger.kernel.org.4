Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0213C60BD14
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiJXWG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiJXWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:06:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997597D65
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C7DB6157D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A8BC433C1;
        Mon, 24 Oct 2022 19:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666641132;
        bh=lkkW65uC8FLtw8ZPu4UMr+BKPlIpPDImnPKWcWAQVgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OR7Wn4rSm/wnwJ1ZqtdnojYijuJs7jTNBg1kVq0NL4mto3/afBuYkva7gu66tDiX/
         B8bGkSQulksZOEzv/o+/9aRN4Gto0pSGQtDUPD2T6vmk9oEUN68Qhq9qBJbQHrn0y5
         rmbacobbp4UMXAeNlEY3ZiXi/jhDpVrhhBqK6Nig0gxnEO61qhaojqjC4iDplVe2B7
         oGFxJsEH/QBxpLSxkvc6fskMtaPhdVanvgVMjHZq6BHaqGoXCvl2ZGRX3eYZXvaadd
         bQMtAneBMV+a8Kq9HtKdx3DFulcwPX3GMojv7cPlJxB1WmLo+lN0wzELkCGizRmKSa
         q0+E/DLvfxDWQ==
Date:   Mon, 24 Oct 2022 20:52:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH v5 3/4] RISC-V: Implement arch specific PMEM APIs
Message-ID: <Y1bs50GXeUoTcv2V@spud>
References: <20221020075846.305576-1-apatel@ventanamicro.com>
 <20221020075846.305576-4-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020075846.305576-4-apatel@ventanamicro.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:28:45PM +0530, Anup Patel wrote:
> The NVDIMM PMEM driver expects arch specific APIs for cache maintenance
> and if arch does not provide these APIs then NVDIMM PMEM driver will
> always use MEMREMAP_WT to map persistent memory which in-turn maps as
> UC memory type defined by the RISC-V Svpbmt specification.
> 
> Now that the Svpbmt and Zicbom support is available in RISC-V kernel,
> we implement PMEM APIs using ALT_CMO_OP() macros so that the NVDIMM
> PMEM driver can use MEMREMAP_WB to map persistent memory.
> 
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/Kconfig     |  1 +
>  arch/riscv/mm/Makefile |  1 +
>  arch/riscv/mm/pmem.c   | 21 +++++++++++++++++++++
>  3 files changed, 23 insertions(+)
>  create mode 100644 arch/riscv/mm/pmem.c
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6b48a3ae9843..025e2a1b1c60 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -25,6 +25,7 @@ config RISCV
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_PMEM_API
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP if MMU
>  	select ARCH_HAS_SET_MEMORY if MMU
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index d76aabf4b94d..3b368e547f83 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -31,3 +31,4 @@ endif
>  
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
>  obj-$(CONFIG_RISCV_DMA_NONCOHERENT) += dma-noncoherent.o
> +obj-$(CONFIG_ARCH_HAS_PMEM_API) += pmem.o

Hey Anup,
Might be a silly question - ARCH_HAS_PMEM_API is unconditionally enabled
right? It should therefore be okay to make this an obj-y?
Thanks
Conor.

> diff --git a/arch/riscv/mm/pmem.c b/arch/riscv/mm/pmem.c
> new file mode 100644
> index 000000000000..089df92ae876
> --- /dev/null
> +++ b/arch/riscv/mm/pmem.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/libnvdimm.h>
> +
> +#include <asm/cacheflush.h>
> +
> +void arch_wb_cache_pmem(void *addr, size_t size)
> +{
> +	ALT_CMO_OP(clean, addr, size, riscv_cbom_block_size);
> +}
> +EXPORT_SYMBOL_GPL(arch_wb_cache_pmem);
> +
> +void arch_invalidate_pmem(void *addr, size_t size)
> +{
> +	ALT_CMO_OP(inval, addr, size, riscv_cbom_block_size);
> +}
> +EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
> -- 
> 2.34.1
> 
