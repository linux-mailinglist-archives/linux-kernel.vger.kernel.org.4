Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBD0604960
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiJSOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJSOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:36:24 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE252CC89
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:20:41 -0700 (PDT)
Received: from p508fdae2.dip0.t-ipconnect.de ([80.143.218.226] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ol9ux-0006Hx-9G; Wed, 19 Oct 2022 16:19:35 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: Re: [PATCH v4 2/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for systems with Svpbmt
Date:   Wed, 19 Oct 2022 16:19:34 +0200
Message-ID: <13122510.uLZWGnKmhe@phil>
In-Reply-To: <20221019131128.237026-3-apatel@ventanamicro.com>
References: <20221019131128.237026-1-apatel@ventanamicro.com> <20221019131128.237026-3-apatel@ventanamicro.com>
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

Am Mittwoch, 19. Oktober 2022, 15:11:26 CEST schrieb Anup Patel:
> Currently, all flavors of ioremap_xyz() function maps to the generic
> ioremap() which means any ioremap_xyz() call will always map the
> target memory as IO using _PAGE_IOREMAP page attributes. This breaks
> ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
> remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
> page attributes.
> 
> To address above (just like other architectures), we implement RISC-V
> specific ioremap_cache() and ioremap_wc() which maps memory using page
> attributes as defined by the Svpbmt specification.
> 
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Wasn't there discussion around those functions in general in v2?

In any case, the patch doesn't break anything on qemu and d1, so

Tested-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  arch/riscv/include/asm/io.h      | 10 ++++++++++
>  arch/riscv/include/asm/pgtable.h |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 92080a227937..92a31e543388 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -133,6 +133,16 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
>  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
>  #endif
>  
> +#ifdef CONFIG_MMU
> +#define ioremap_wc(addr, size)		\
> +	ioremap_prot((addr), (size), _PAGE_IOREMAP_WC)
> +#endif
> +
>  #include <asm-generic/io.h>
>  
> +#ifdef CONFIG_MMU
> +#define ioremap_cache(addr, size)	\
> +	ioremap_prot((addr), (size), _PAGE_KERNEL)
> +#endif
> +
>  #endif /* _ASM_RISCV_IO_H */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..346b7c1a3eeb 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -182,6 +182,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
>  #define PAGE_TABLE		__pgprot(_PAGE_TABLE)
>  
>  #define _PAGE_IOREMAP	((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
> +#define _PAGE_IOREMAP_WC	((_PAGE_KERNEL & ~_PAGE_MTMASK) | \
> +				 _PAGE_NOCACHE)
>  #define PAGE_KERNEL_IO		__pgprot(_PAGE_IOREMAP)
>  
>  extern pgd_t swapper_pg_dir[];
> 




