Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA56E5EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjDRKXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 06:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDRKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 06:23:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0A947A91
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 03:22:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3410C168F;
        Tue, 18 Apr 2023 03:23:12 -0700 (PDT)
Received: from [10.1.27.157] (C02CF1NRLVDN.cambridge.arm.com [10.1.27.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 560503F587;
        Tue, 18 Apr 2023 03:22:27 -0700 (PDT)
Message-ID: <73a89872-092e-4794-3956-71afe653dae0@arm.com>
Date:   Tue, 18 Apr 2023 11:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH v3 35/60] arm64: mm: Use 48-bit virtual addressing for the
 permanent ID map
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
 <20230307140522.2311461-36-ardb@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230307140522.2311461-36-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 14:04, Ard Biesheuvel wrote:
> Even though we support loading kernels anywhere in 48-bit addressable
> physical memory, we create the ID maps based on the number of levels
> that we happened to configure for the kernel VA and user VA spaces.
> 
> The reason for this is that the PGD/PUD/PMD based classification of
> translation levels, along with the associated folding when the number of
> levels is less than 5, does not permit creating a page table hierarchy
> of a set number of levels. This means that, for instance, on 39-bit VA
> kernels we need to configure an additional level above PGD level on the
> fly, and 36-bit VA kernels still only support 47-bit virtual addressing
> with this trick applied.
> 
> Now that we have a separate helper to populate page table hierarchies
> that does not define the levels in terms of PUDS/PMDS/etc at all, let's
> reuse it to create the permanent ID map with a fixed VA size of 48 bits.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/kernel-pgtable.h |  2 ++
>  arch/arm64/kernel/head.S                |  5 +++
>  arch/arm64/kvm/mmu.c                    | 15 +++------
>  arch/arm64/mm/mmu.c                     | 32 +++++++++++---------
>  arch/arm64/mm/proc.S                    |  9 ++----
>  5 files changed, 31 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 50b5c145358a5d8e..2a2c80ffe59e5307 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -35,6 +35,8 @@
>  #define SWAPPER_PGTABLE_LEVELS	(CONFIG_PGTABLE_LEVELS)
>  #endif
>  
> +#define IDMAP_LEVELS		ARM64_HW_PGTABLE_LEVELS(48)
> +#define IDMAP_ROOT_LEVEL	(4 - IDMAP_LEVELS)
>  
>  /*
>   * If KASLR is enabled, then an offset K is added to the kernel address
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index e45fd99e8ab4272a..fc6a4076d826b728 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -727,6 +727,11 @@ SYM_FUNC_START_LOCAL(__no_granule_support)
>  SYM_FUNC_END(__no_granule_support)
>  
>  SYM_FUNC_START_LOCAL(__primary_switch)
> +	mrs		x1, tcr_el1
> +	mov		x2, #64 - VA_BITS
> +	tcr_set_t0sz	x1, x2
> +	msr		tcr_el1, x1
> +
>  	adrp	x1, reserved_pg_dir
>  	adrp	x2, init_idmap_pg_dir
>  	bl	__enable_mmu
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 7113587222ffe8e1..d64be7b5f6692e8b 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1687,16 +1687,9 @@ int __init kvm_mmu_init(u32 *hyp_va_bits)
>  	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>  
>  	/*
> -	 * The ID map may be configured to use an extended virtual address
> -	 * range. This is only the case if system RAM is out of range for the
> -	 * currently configured page size and VA_BITS_MIN, in which case we will
> -	 * also need the extended virtual range for the HYP ID map, or we won't
> -	 * be able to enable the EL2 MMU.
> -	 *
> -	 * However, in some cases the ID map may be configured for fewer than
> -	 * the number of VA bits used by the regular kernel stage 1. This
> -	 * happens when VA_BITS=52 and the kernel image is placed in PA space
> -	 * below 48 bits.
> +	 * The ID map is always configured for 48 bits of translation, which
> +	 * may be fewer than the number of VA bits used by the regular kernel
> +	 * stage 1, when VA_BITS=52.
>  	 *
>  	 * At EL2, there is only one TTBR register, and we can't switch between
>  	 * translation tables *and* update TCR_EL2.T0SZ at the same time. Bottom
> @@ -1707,7 +1700,7 @@ int __init kvm_mmu_init(u32 *hyp_va_bits)
>  	 * 1 VA bits to assure that the hypervisor can both ID map its code page
>  	 * and map any kernel memory.
>  	 */
> -	idmap_bits = 64 - ((idmap_t0sz & TCR_T0SZ_MASK) >> TCR_T0SZ_OFFSET);
> +	idmap_bits = 48;
>  	kernel_bits = vabits_actual;
>  	*hyp_va_bits = max(idmap_bits, kernel_bits);

This effectively means that the hypervisor always uses at least 48 VA bits.
Previously, I think it would have been 39 for (e.g.) Android builds? Does this
have any performance implications for pKVM?

>  
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 81e1420d2cc13246..a59433ae4f5f8d02 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -762,22 +762,21 @@ static void __init map_kernel(pgd_t *pgdp)
>  	kasan_copy_shadow(pgdp);
>  }
>  
> +void __pi_map_range(u64 *pgd, u64 start, u64 end, u64 pa, pgprot_t prot,
> +		    int level, pte_t *tbl, bool may_use_cont, u64 va_offset);
> +
> +static u8 idmap_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init,
> +	  kpti_ptes[IDMAP_LEVELS - 1][PAGE_SIZE] __aligned(PAGE_SIZE) __ro_after_init;

I see this new storage introduced, but I don't see you removing the storage for
the old method (I have a vague memory of it being defined in the linker script)?

> +
>  static void __init create_idmap(void)
>  {
>  	u64 start = __pa_symbol(__idmap_text_start);
> -	u64 size = __pa_symbol(__idmap_text_end) - start;
> -	pgd_t *pgd = idmap_pg_dir;
> -	u64 pgd_phys;
> -
> -	/* check if we need an additional level of translation */
> -	if (VA_BITS < 48 && idmap_t0sz < (64 - VA_BITS_MIN)) {
> -		pgd_phys = early_pgtable_alloc(PAGE_SHIFT);
> -		set_pgd(&idmap_pg_dir[start >> VA_BITS],
> -			__pgd(pgd_phys | P4D_TYPE_TABLE));
> -		pgd = __va(pgd_phys);
> -	}
> -	__create_pgd_mapping(pgd, start, start, size, PAGE_KERNEL_ROX,
> -			     early_pgtable_alloc, 0);
> +	u64 end   = __pa_symbol(__idmap_text_end);
> +	u64 ptep  = __pa_symbol(idmap_ptes);
> +
> +	__pi_map_range(&ptep, start, end, start, PAGE_KERNEL_ROX,
> +		       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
> +		       __phys_to_virt(ptep) - ptep);
>  
>  	if (IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)) {
>  		extern u32 __idmap_kpti_flag;
> @@ -787,8 +786,10 @@ static void __init create_idmap(void)
>  		 * The KPTI G-to-nG conversion code needs a read-write mapping
>  		 * of its synchronization flag in the ID map.
>  		 */
> -		__create_pgd_mapping(pgd, pa, pa, sizeof(u32), PAGE_KERNEL,
> -				     early_pgtable_alloc, 0);
> +		ptep = __pa_symbol(kpti_ptes);
> +		__pi_map_range(&ptep, pa, pa + sizeof(u32), pa, PAGE_KERNEL,
> +			       IDMAP_ROOT_LEVEL, (pte_t *)idmap_pg_dir, false,
> +			       __phys_to_virt(ptep) - ptep);
>  	}
>  }
>  
> @@ -813,6 +814,7 @@ void __init paging_init(void)
>  	memblock_allow_resize();
>  
>  	create_idmap();
> +	idmap_t0sz = TCR_T0SZ(48);
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 82e88f4521737c0e..c7129b21bfd5191f 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -422,9 +422,9 @@ SYM_FUNC_START(__cpu_setup)
>  	mair	.req	x17
>  	tcr	.req	x16
>  	mov_q	mair, MAIR_EL1_SET
> -	mov_q	tcr, TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
> -			TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> -			TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS
> +	mov_q	tcr, TCR_T0SZ(48) | TCR_T1SZ(VA_BITS) | TCR_CACHE_FLAGS | \
> +		     TCR_SMP_FLAGS | TCR_TG_FLAGS | TCR_KASLR_FLAGS | TCR_ASID16 | \
> +		     TCR_TBI0 | TCR_A1 | TCR_KASAN_SW_FLAGS | TCR_MTE_FLAGS

You're hardcoding 48 in 3 places in this patch. I wonder if an IDMAP_VA_BITS
macro might help here?

>  
>  	tcr_clear_errata_bits tcr, x9, x5
>  
> @@ -432,10 +432,7 @@ SYM_FUNC_START(__cpu_setup)
>  	sub		x9, xzr, x0
>  	add		x9, x9, #64
>  	tcr_set_t1sz	tcr, x9
> -#else
> -	idmap_get_t0sz	x9
>  #endif
> -	tcr_set_t0sz	tcr, x9
>  
>  	/*
>  	 * Set the IPS bits in TCR_EL1.

