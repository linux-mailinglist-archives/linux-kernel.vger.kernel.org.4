Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CFE62B2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiKPFuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKPFuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:50:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CF202315D;
        Tue, 15 Nov 2022 21:50:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8080813D5;
        Tue, 15 Nov 2022 21:50:07 -0800 (PST)
Received: from [10.162.40.17] (unknown [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B2933F73B;
        Tue, 15 Nov 2022 21:49:57 -0800 (PST)
Message-ID: <cc98f0f8-6f45-41e5-d5d4-ab42b26f6943@arm.com>
Date:   Wed, 16 Nov 2022 11:19:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2 2/2] arm64: errata: Workaround possible Cortex-A715
 [ESR|FAR]_ELx corruption
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
References: <20221113012645.190301-1-anshuman.khandual@arm.com>
 <20221113012645.190301-3-anshuman.khandual@arm.com>
 <20221115133854.GC524@willie-the-truck>
 <20221115134226.GD524@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221115134226.GD524@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 19:12, Will Deacon wrote:
> On Tue, Nov 15, 2022 at 01:38:54PM +0000, Will Deacon wrote:
>> On Sun, Nov 13, 2022 at 06:56:45AM +0530, Anshuman Khandual wrote:
>>> If a Cortex-A715 cpu sees a page mapping permissions change from executable
>>> to non-executable, it may corrupt the ESR_ELx and FAR_ELx registers, on the
>>> next instruction abort caused by permission fault.
>>>
>>> Only user-space does executable to non-executable permission transition via
>>> mprotect() system call which calls ptep_modify_prot_start() and ptep_modify
>>> _prot_commit() helpers, while changing the page mapping. The platform code
>>> can override these helpers via __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION.
>>>
>>> Work around the problem via doing a break-before-make TLB invalidation, for
>>> all executable user space mappings, that go through mprotect() system call.
>>> This overrides ptep_modify_prot_start() and ptep_modify_prot_commit(), via
>>> defining HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION on the platform thus giving
>>> an opportunity to intercept user space exec mappings, and do the necessary
>>> TLB invalidation. Similar interceptions are also implemented for HugeTLB.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>  Documentation/arm64/silicon-errata.rst |  2 ++
>>>  arch/arm64/Kconfig                     | 16 ++++++++++++++++
>>>  arch/arm64/include/asm/hugetlb.h       |  9 +++++++++
>>>  arch/arm64/include/asm/pgtable.h       |  9 +++++++++
>>>  arch/arm64/kernel/cpu_errata.c         |  7 +++++++
>>>  arch/arm64/mm/hugetlbpage.c            | 21 +++++++++++++++++++++
>>>  arch/arm64/mm/mmu.c                    | 21 +++++++++++++++++++++
>>>  arch/arm64/tools/cpucaps               |  1 +
>>>  8 files changed, 86 insertions(+)
>>
>> [...]
>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 9a7c38965154..c1fb0ce1473c 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1702,3 +1702,24 @@ static int __init prevent_bootmem_remove_init(void)
>>>  }
>>>  early_initcall(prevent_bootmem_remove_init);
>>>  #endif
>>> +
>>> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
>>> +{
>>> +	if (IS_ENABLED(CONFIG_ARM64_WORKAROUND_2645198)) {
>>> +		pte_t pte = READ_ONCE(*ptep);
>>> +		/*
>>> +		 * Break-before-make (BBM) is required for all user space mappings
>>> +		 * when the permission changes from executable to non-executable
>>> +		 * in cases where cpu is affected with errata #2645198.
>>> +		 */
>>> +		if (pte_user_exec(pte) && cpus_have_const_cap(ARM64_WORKAROUND_2645198))
>>> +			return ptep_clear_flush(vma, addr, ptep);
>>> +	}
>>> +	return ptep_get_and_clear(vma->vm_mm, addr, ptep);
>>> +}
>>> +
>>> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep,
>>> +			     pte_t old_pte, pte_t pte)
>>> +{
>>> +	__set_pte_at(vma->vm_mm, addr, ptep, pte);
>>> +}
>>
>> So these are really similar to the generic copies and, in looking at
>> change_pte_range(), it appears that we already invalidate the TLB, it just
>> happens _after_ writing the new version.
>>
>> So with your change, I think we end up invalidating twice. Can we instead
>> change the generic code to invalidate the TLB before writing the new entry?
> 
> Bah, scratch that, the invalidations are all batched, aren't they?

Right.

> 
> It just seems silly that we have to add all this code just to do a TLB
> invalidation.

Right, but only when affected by this errata. Otherwise it is just same as the
existing generic definitions.
