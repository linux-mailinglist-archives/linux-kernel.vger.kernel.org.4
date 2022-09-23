Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B385E7750
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIWJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiIWJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:36:01 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32216109539
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:35:57 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obf61-0005SF-PN; Fri, 23 Sep 2022 11:35:45 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: Re: [PATCH 2/2] riscv: Move cast inside kernel_mapping_[pv]a_to_[vp]a
Date:   Fri, 23 Sep 2022 11:35:44 +0200
Message-ID: <3482469.aeNJFYEL58@phil>
In-Reply-To: <20220922054743.30159-2-samuel@sholland.org>
References: <20220922054743.30159-1-samuel@sholland.org> <20220922054743.30159-2-samuel@sholland.org>
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

Am Donnerstag, 22. September 2022, 07:47:42 CEST schrieb Samuel Holland:
> Before commit 44c922572952 ("RISC-V: enable XIP"), these macros cast
> their argument to unsigned long. That commit moved the cast after an
> assignment to an unsigned long variable, rendering it ineffectual.
> Move the cast back, so we can remove the cast at each call site.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

makes the code a lot nicer to read

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> 
>  arch/riscv/errata/thead/errata.c |  4 ++--
>  arch/riscv/include/asm/page.h    | 18 +++++++++---------
>  arch/riscv/mm/init.c             | 16 ++++++++--------
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 83174f13783e..38c2c6b0f6b8 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -76,8 +76,8 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
>  		if (cpu_req_errata & tmp) {
>  			/* On vm-alternatives, the mmu isn't running yet */
>  			if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> -				memcpy((void *)kernel_mapping_va_to_pa((unsigned long)alt->old_ptr),
> -				       (void *)kernel_mapping_va_to_pa((unsigned long)alt->alt_ptr),
> +				memcpy((void *)kernel_mapping_va_to_pa(alt->old_ptr),
> +				       (void *)kernel_mapping_va_to_pa(alt->alt_ptr),
>  				       alt->alt_len);
>  			else
>  				patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index ac70b0fd9a9a..9f432c1b5289 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -123,20 +123,20 @@ extern phys_addr_t phys_ram_base;
>  	((x) >= PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE_OFFSET + KERN_VIRT_SIZE))
>  
>  #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + kernel_map.va_pa_offset))
> -#define kernel_mapping_pa_to_va(y)	({						\
> -	unsigned long _y = y;								\
> -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?					\
> -		(void *)((unsigned long)(_y) + kernel_map.va_kernel_xip_pa_offset) :		\
> -		(void *)((unsigned long)(_y) + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
> +#define kernel_mapping_pa_to_va(y)	({					\
> +	unsigned long _y = (unsigned long)(y);					\
> +	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?			\
> +		(void *)(_y + kernel_map.va_kernel_xip_pa_offset) :		\
> +		(void *)(_y + kernel_map.va_kernel_pa_offset + XIP_OFFSET);	\
>  	})
>  #define __pa_to_va_nodebug(x)		linear_mapping_pa_to_va(x)
>  
>  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - kernel_map.va_pa_offset)
>  #define kernel_mapping_va_to_pa(y) ({						\
> -	unsigned long _y = y;							\
> -	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ?	\
> -		((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) :		\
> -		((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - XIP_OFFSET);	\
> +	unsigned long _y = (unsigned long)(y);					\
> +	(IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP_OFFSET) ? \
> +		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
> +		(_y - kernel_map.va_kernel_pa_offset - XIP_OFFSET);		\
>  	})
>  
>  #define __va_to_pa_nodebug(x)	({						\
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index b56a0a75533f..7d59516ce6b3 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -927,15 +927,15 @@ static void __init pt_ops_set_early(void)
>   */
>  static void __init pt_ops_set_fixmap(void)
>  {
> -	pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
> -	pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
> +	pt_ops.alloc_pte = kernel_mapping_pa_to_va(alloc_pte_fixmap);
> +	pt_ops.get_pte_virt = kernel_mapping_pa_to_va(get_pte_virt_fixmap);
>  #ifndef __PAGETABLE_PMD_FOLDED
> -	pt_ops.alloc_pmd = kernel_mapping_pa_to_va((uintptr_t)alloc_pmd_fixmap);
> -	pt_ops.get_pmd_virt = kernel_mapping_pa_to_va((uintptr_t)get_pmd_virt_fixmap);
> -	pt_ops.alloc_pud = kernel_mapping_pa_to_va((uintptr_t)alloc_pud_fixmap);
> -	pt_ops.get_pud_virt = kernel_mapping_pa_to_va((uintptr_t)get_pud_virt_fixmap);
> -	pt_ops.alloc_p4d = kernel_mapping_pa_to_va((uintptr_t)alloc_p4d_fixmap);
> -	pt_ops.get_p4d_virt = kernel_mapping_pa_to_va((uintptr_t)get_p4d_virt_fixmap);
> +	pt_ops.alloc_pmd = kernel_mapping_pa_to_va(alloc_pmd_fixmap);
> +	pt_ops.get_pmd_virt = kernel_mapping_pa_to_va(get_pmd_virt_fixmap);
> +	pt_ops.alloc_pud = kernel_mapping_pa_to_va(alloc_pud_fixmap);
> +	pt_ops.get_pud_virt = kernel_mapping_pa_to_va(get_pud_virt_fixmap);
> +	pt_ops.alloc_p4d = kernel_mapping_pa_to_va(alloc_p4d_fixmap);
> +	pt_ops.get_p4d_virt = kernel_mapping_pa_to_va(get_p4d_virt_fixmap);
>  #endif
>  }
>  
> 




