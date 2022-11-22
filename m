Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5B9634452
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbiKVTIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbiKVTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:08:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8546F15808
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 11:08:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B5D91FB;
        Tue, 22 Nov 2022 11:08:38 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9865B3F73B;
        Tue, 22 Nov 2022 11:08:30 -0800 (PST)
Message-ID: <fd8d8fef-99a7-9bc3-48b5-674bca365fee@arm.com>
Date:   Tue, 22 Nov 2022 19:08:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
Content-Language: en-GB
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20221118053102.500216-1-anshuman.khandual@arm.com>
 <Y3pS5fdZ3MdLZ00t@dev-arch.thelio-3990X>
 <fd67eca3-59f4-4455-e3db-ba853c3f949b@arm.com>
 <Y3tuxzl54BvG406t@FVFF77S0Q05N.cambridge.arm.com>
 <5b69ff03-1694-bae6-3312-a63273be4073@arm.com>
 <05b6ea24-1135-bcaf-a24e-c0bcbf14101e@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <05b6ea24-1135-bcaf-a24e-c0bcbf14101e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-22 03:13, Anshuman Khandual wrote:
> 
> 
> On 11/21/22 19:26, Robin Murphy wrote:
>> On 2022-11-21 12:27, Mark Rutland wrote:
>>> On Mon, Nov 21, 2022 at 11:00:42AM +0530, Anshuman Khandual wrote:
>>>> Hello Nathan,
>>>>
>>>> Thanks for the report.
>>>>
>>>> On 11/20/22 21:46, Nathan Chancellor wrote:
>>>>> Hi Anshuman,
>>>
>>>>> I just bisected a boot failure in our QEMU-based continuous integration
>>>>> setup to this change as commit 9ed2b4616d4e ("arm64/mm: Drop redundant
>>>>> BUG_ON(!pgtable_alloc)") in the arm64 tree. There is no output so the
>>>>> panic clearly happens early at boot. If I move back to the previous
>>>>> commit and add a WARN_ON() like so:
>>>>>
>>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>>> index d386033a074c..9280a92ff920 100644
>>>>> --- a/arch/arm64/mm/mmu.c
>>>>> +++ b/arch/arm64/mm/mmu.c
>>>>> @@ -383,6 +383,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>>>>>        phys &= PAGE_MASK;
>>>>>        addr = virt & PAGE_MASK;
>>>>>        end = PAGE_ALIGN(virt + size);
>>>>> +    WARN_ON(!pgtable_alloc);
>>>>>          do {
>>>>>            next = pgd_addr_end(addr, end);
>>>>>
>>>>> I do see some stacktraces. I have attached the boot log from QEMU.
>>>>>
>>>>> If there is any additional information I can provide or patches I can
>>>>> test, I am more than happy to do so.
>>>>
>>>> There are couple of instances, where __create_pgd_mapping() function gets called
>>>> without a valid pgtable alloc function (NULL is passed on instead), as it is not
>>>> expected to allocate page table pages, during the mapping process. The following
>>>> change after this patch should solve the reported problem.
>>>>
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index 9ea8e9039992..a00563122fcb 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -42,6 +42,7 @@
>>>>    #define NO_BLOCK_MAPPINGS      BIT(0)
>>>>    #define NO_CONT_MAPPINGS       BIT(1)
>>>>    #define NO_EXEC_MAPPINGS       BIT(2)  /* assumes FEAT_HPDS is not used */
>>>> +#define NO_ALLOC_MAPPINGS      BIT(3)  /* does not allocate page table pages */
>>>>      int idmap_t0sz __ro_after_init;
>>>>    @@ -380,7 +381,7 @@ static void __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
>>>>           phys &= PAGE_MASK;
>>>>           addr = virt & PAGE_MASK;
>>>>           end = PAGE_ALIGN(virt + size);
>>>> -       BUG_ON(!pgtable_alloc);
>>>> +       BUG_ON(!(flags & NO_ALLOC_MAPPINGS) && !pgtable_alloc);
>>>>             do {
>>>>                   next = pgd_addr_end(addr, end);
>>>> @@ -453,7 +454,7 @@ static void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>>>>                   return;
>>>>           }
>>>>           __create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
>>>> -                            NO_CONT_MAPPINGS);
>>>> +                            NO_CONT_MAPPINGS | NO_ALLOC_MAPPINGS);
>>>>    }
>>>>      void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
>>>> @@ -481,7 +482,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>>>>           }
>>>>             __create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
>>>> -                            NO_CONT_MAPPINGS);
>>>> +                            NO_CONT_MAPPINGS | NO_ALLOC_MAPPINGS);
>>>>             /* flush the TLBs after updating live kernel mappings */
>>>>           flush_tlb_kernel_range(virt, virt + size);
>>>
>>> This is now more complicated than what we had originally, and it doesn't catch
>>> the case where the caller sets NO_ALLOC_MAPPINGS but the callee ends up needing
>>> to perform an allocation, which the old code would have caught.
>>
>> Well, it's still "caught" as such - all that BUG_ON(!pgtable_alloc) does in these cases is encode the source location in the backtrace, vs. having to decode it (if necessary) from the LR in a backtrace from immediately dereferencing pgtable_alloc(). If that happens before the user has a console up then the difference is moot anyway.
> 
> Agreed, also the fact that certain callers are sure about no page table page allocation
> would be required (hence they just pass "NULL" for pgtable_alloc function), needs to be
> notified appropriately when page page table creation stumbles upon a pxd_none().
> 
> if (pxd_none(pmd)) {
> 	BUG_ON(flags & NO_ALLOC_MAPPINGS);
> }
> 
> Although there are might be an argument that all erstwhile BUG_ON(!pgtable_alloc) has
> replacements with BUG_ON(flags & NO_ALLOC_MAPPINGS), but there is a subtle difference.
> It captures the fact (in a rather structured manner), that caller made a choice with
> NO_ALLOC_MAPPINGS but called __create_pgd_mapping() on a page table, where intermediate
> page table page alloc would still be required. IMHO adding that explicit structure here
> via the new flag NO_ALLOC_MAPPINGS makes sense.

Hmm, I dunno, it seems clear enough to me that the callers which do not 
intend to allocate indicate that by passing a NULL allocator callback. 
Personally I don't see the benefit in adding code to make all those 
callers redundantly encode their intent twice over just so that we can 
also add code to catch them out and crash if they don't. Weren't you 
trying to clean up redundancy?

As I say I think any BUG_ON() has very limited value as documentation 
where the only way to proceed is by dereferencing NULL in an 
identifiable manner anyway, but that's largely a matter of taste and I 
know others might disagree.

Thanks,
Robin.
