Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16955682268
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjAaC5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAaC5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:57:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5EC5B443
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 18:57:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64D682F4;
        Mon, 30 Jan 2023 18:58:16 -0800 (PST)
Received: from [10.162.43.7] (unknown [10.162.43.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47F5B3F64C;
        Mon, 30 Jan 2023 18:57:32 -0800 (PST)
Message-ID: <9d9f6686-073c-10d3-96a7-9765eef07103@arm.com>
Date:   Tue, 31 Jan 2023 08:27:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, will@kernel.org,
        catalin.marinas@arm.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <Y9PqPb5C/H65T3uW@FVFF77S0Q05N>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y9PqPb5C/H65T3uW@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/23 20:44, Mark Rutland wrote:
> Hi Annshuman,
> 
> On Mon, Jan 09, 2023 at 10:58:16AM +0530, Anshuman Khandual wrote:
>> Changing pfn on a user page table mapped entry, without first going through
>> break-before-make (BBM) procedure is unsafe. This just updates set_pte_at()
>> to intercept such changes, via an updated pgattr_change_is_safe(). This new
>> check happens via __check_racy_pte_update(), which has now been renamed as
>> __check_safe_pte_update().
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> This applies on v6.2-rc3. This patch had some test time on an internal CI
>> system without any issues being reported.
> 
> Can you elaborate on this a little bit? It's not entirely clear what that
> internal CI system has tested. It would be helpful if you could indicate:

Please find the details here, as learned from internal CI folks,

> 
> * What sort of testing has been done by the CI system? e.g. is this just
>   booting, running LTP, something else?

Tested on both host and guest, with CONFIG_DEBUG_VM enabled

- Booting
- LTP

> 
> * Has this tried a bunch of configurations and/or machines?

Tested on the following platforms

- LTP test on JUNO	(defconfig)
- LTP test on SOFTIRON 	(debugrun config)
- Kselftests arm64 KVM	(BASEAEM with defconfig)

> 
> * If any targetted stress tests have been used? e.g. stress-ng's memory system
>   tests?

I did run stress-ng memory system tests.

> 
> I'm assuming that's hitting LTP on a few machines/configs, which'd be
> reasonable. It'd just be nice to confirm exactly what has been tested.
> 
> I've added this to my lcoal syzkaller instance's test branch, and I'll shout if
> that hits anything over the weekend.
> 
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20221116031001.292236-1-anshuman.khandual@arm.com/
> 
> Did you mean to list some cahnges here?

Actually there was no change between V1 and V2, other than just rebasing.

> 
>>
>>  arch/arm64/include/asm/pgtable.h | 8 ++++++--
>>  arch/arm64/mm/mmu.c              | 8 +++++++-
>>  2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index b4bbeed80fb6..832c9c8fb58f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -275,6 +275,7 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>>  }
>>  
>>  extern void __sync_icache_dcache(pte_t pteval);
>> +bool pgattr_change_is_safe(u64 old, u64 new);
>>  
>>  /*
>>   * PTE bits configuration in the presence of hardware Dirty Bit Management
>> @@ -292,7 +293,7 @@ extern void __sync_icache_dcache(pte_t pteval);
>>   *   PTE_DIRTY || (PTE_WRITE && !PTE_RDONLY)
>>   */
>>  
>> -static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>> +static inline void __check_safe_pte_update(struct mm_struct *mm, pte_t *ptep,
>>  					   pte_t pte)
>>  {
>>  	pte_t old_pte;
>> @@ -318,6 +319,9 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>>  	VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
>>  		     "%s: racy dirty state clearing: 0x%016llx -> 0x%016llx",
>>  		     __func__, pte_val(old_pte), pte_val(pte));
>> +	VM_WARN_ONCE(!pgattr_change_is_safe(pte_val(old_pte), pte_val(pte)),
>> +		     "%s: unsafe attribute change: 0x%016llx -> 0x%016llx",
>> +		     __func__, pte_val(old_pte), pte_val(pte));
>>  }
>>  
>>  static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>> @@ -346,7 +350,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>>  			mte_sync_tags(old_pte, pte);
>>  	}
>>  
>> -	__check_racy_pte_update(mm, ptep, pte);
>> +	__check_safe_pte_update(mm, ptep, pte);
>>  
>>  	set_pte(ptep, pte);
>>  }
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 14c87e8d69d8..a1d16b35c4f6 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -133,7 +133,7 @@ static phys_addr_t __init early_pgtable_alloc(int shift)
>>  	return phys;
>>  }
>>  
>> -static bool pgattr_change_is_safe(u64 old, u64 new)
>> +bool pgattr_change_is_safe(u64 old, u64 new)
>>  {
>>  	/*
>>  	 * The following mapping attributes may be updated in live
>> @@ -145,6 +145,12 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
>>  	if (old == 0 || new == 0)
>>  		return true;
> 
> These checks above should really use pte_valid(); we were just being lazy when
> this was originally written since for the init_*() cases the memory should be
> zero initially.
> 
> So could you make that:
> 
> 	if (!pte_valid(__pte(old)) || !pte_valid(__pte(new)))
> 		return true;
> 
>> +	/* If old and new ptes are valid, pfn should not change */
>> +	if (pte_valid(__pte(old)) && pte_valid(__pte(new))) {
>> +		if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
>> +			return false;
>> +	}
> 
> With the above change, it's clear that both must be valid to get this far, and
> this check can be reduced to:
> 
> 
> 	/* A live entry's pfn should not change */
> 	if (pte_pfn(__pte(old)) != pte_pfn(__pte(new)))
> 		return false;
> 
> With those changes:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Sent out the V3 as suggested.

https://lore.kernel.org/all/20230130121457.1607675-1-anshuman.khandual@arm.com/
