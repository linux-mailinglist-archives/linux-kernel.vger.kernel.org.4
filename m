Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD719679005
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjAXFmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAXFl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:41:57 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A8E7305FE
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:41:56 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98F56C14;
        Mon, 23 Jan 2023 21:42:37 -0800 (PST)
Received: from [10.162.41.52] (unknown [10.162.41.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F733F71E;
        Mon, 23 Jan 2023 21:41:52 -0800 (PST)
Message-ID: <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
Date:   Tue, 24 Jan 2023 11:11:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230109052816.405335-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/23 10:58, Anshuman Khandual wrote:
> Changing pfn on a user page table mapped entry, without first going through
> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
> to intercept such changes, via an updated pgattr_change_is_safe(). This new
> check happens via __check_racy_pte_update(), which has now been renamed as
> __check_safe_pte_update().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.2-rc3. This patch had some test time on an internal CI
> system without any issues being reported.

Gentle ping, any updates on this patch ? Still any concerns ?

> 
> Changes in V1:
> 
> https://lore.kernel.org/all/20221116031001.292236-1-anshuman.khandual@arm.com/
> 
>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>  arch/arm64/mm/mmu.c              | 8 +++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index b4bbeed80fb6..832c9c8fb58f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -275,6 +275,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>  }
>  
>  extern void __sync_icache_dcache(pte_t pteval);
> +bool pgattr_change_is_safe(u64 old, u64 new);
>  
>  /*
>   * PTE bits configuration in the presence of hardware Dirty Bit Management
> @@ -292,7 +293,7 @@ extern void __sync_icache_dcache(pte_t pteval);
>   *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
>   */
>  
> -static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
> +static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
>  					   pte_t pte)
>  {
>  	pte_t old_pte;
> @@ -318,6 +319,9 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>  	VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
>  		     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
>  		     __func__, pte_val(old_pte), pte_val(pte));
> +	VM_WARN_ONCE(!pgattr_change_is_safe(pte_val(old_pte), pte_val(pte)),
> +		     "%s: unsafe attribute change: 0x%016llx -> 0x%016llx",
> +		     __func__, pte_val(old_pte), pte_val(pte));
>  }
>  
>  static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> @@ -346,7 +350,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			mte_sync_tags(old_pte, pte);
>  	}
>  
> -	__check_racy_pte_update(mm, ptep, pte);
> +	__check_safe_pte_update(mm, ptep, pte);
>  
>  	set_pte(ptep, pte);
>  }
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 14c87e8d69d8..a1d16b35c4f6 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -133,7 +133,7 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
>  	return phys;
>  }
>  
> -static bool pgattr_change_is_safe(u64 old, u64 new)
> +bool pgattr_change_is_safe(u64 old, u64 new)
>  {
>  	/*
>  	 * The following mapping attributes may be updated in live
> @@ -145,6 +145,12 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>  	if (old == 0 || new == 0)
>  		return true;
>  
> +	/* If old and new ptes are valid, pfn should not change */
> +	if (pte_valid(__pte(old)) && pte_valid(__pte(new))) {
> +		if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
> +			return false;
> +	}
> +
>  	/* live contiguous mappings may not be manipulated at all */
>  	if ((old | new) & PTE_CONT)
>  		return false;
