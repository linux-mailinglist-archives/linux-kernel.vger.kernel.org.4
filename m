Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B197484B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjGENNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGENNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:13:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD2D01700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:13:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95C3F16A3;
        Wed,  5 Jul 2023 06:14:18 -0700 (PDT)
Received: from [10.57.76.116] (unknown [10.57.76.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 205843F73F;
        Wed,  5 Jul 2023 06:13:33 -0700 (PDT)
Message-ID: <7aa05d5e-c4ea-cef1-f20e-ead77be1a027@arm.com>
Date:   Wed, 5 Jul 2023 14:13:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 11/14] arm64/mm: Wire up PTE_CONT for user mappings
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230622144210.2623299-1-ryan.roberts@arm.com>
 <20230622144210.2623299-12-ryan.roberts@arm.com> <ZKLmbRpEEKosj9/Q@arm.com>
 <f59228dd-2186-c882-3774-c9778918cd31@arm.com>
In-Reply-To: <f59228dd-2186-c882-3774-c9778918cd31@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 12:09, Ryan Roberts wrote:
> On 03/07/2023 16:17, Catalin Marinas wrote:
>> Hi Ryan,
>>

...

>>> +
>>> +int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>> +					unsigned long addr, pte_t *ptep,
>>> +					pte_t entry, int dirty)
>>> +{
>>> +	pte_t orig_pte;
>>> +	int i;
>>> +
>>> +	/*
>>> +	 * Gather the access/dirty bits for the contiguous range. If nothing has
>>> +	 * changed, its a noop.
>>> +	 */
>>> +	orig_pte = ptep_get(ptep);
>>> +	if (pte_val(orig_pte) == pte_val(entry))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * We can fix up access/dirty bits without having to unfold/fold the
>>> +	 * contig range. But if the write bit is changing, we need to go through
>>> +	 * the full unfold/fold cycle.
>>> +	 */
>>> +	if (pte_write(orig_pte) == pte_write(entry)) {
>>
>> Depending on the architecture version, pte_write() either checks a
>> software only bit or it checks the DBM one.
>>
>>> +		/*
>>> +		 * No need to flush here; This is always "more permissive" so we
>>> +		 * can only be _adding_ the access or dirty bit. And since the
>>> +		 * tlb can't cache an entry without the AF set and the dirty bit
>>> +		 * is a SW bit, there can be no confusion. For HW access
>>> +		 * management, we technically only need to update the flag on a
>>> +		 * single pte in the range. But for SW access management, we
>>> +		 * need to update all the ptes to prevent extra faults.
>>> +		 */
>>
>> On pre-DBM hardware, a PTE_RDONLY entry (writable from the kernel
>> perspective but clean) may be cached in the TLB and we do need flushing.
> 
> I don't follow; The Arm ARM says:
> 
>   IPNQBP When an Access flag fault is generated, the translation table entry
>          causing the fault is not cached in a TLB.
> 
> So the entry can only be in the TLB if AF is already 1. And given the dirty bit
> is SW, it shouldn't affect the TLB state. And this function promises to only
> change the bits so they are more permissive (so AF=0 -> AF=1, D=0 -> D=1).
> 
> So I'm not sure what case you are describing here?

Ahh sorry, I get your point now - on pre-DBM hardware, the HW sees a read-only
PTE when the kernel considers it clean and this can be in the TLB. Then when
making it dirty (from kernel's perspective), we are removing the read-only
protection from the HW perspective, so we need to flush the TLB entry.

> 
>>
>>> +		ptep = contpte_align_down(ptep);
>>> +		addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>>> +
>>> +		for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
>>> +			__ptep_set_access_flags(vma, addr, ptep, entry, 0);

Fixed by adding this after iterating though the ptes, intent it to avoid the
per-page tlb flash and instead flush the whole range at the end:

		if (dirty)
			__flush_tlb_range(vma, start_addr, addr,
							PAGE_SIZE, true, 3);

>>> +	} else {
>>> +		/*
>>> +		 * No need to flush in __ptep_set_access_flags() because we just
>>> +		 * flushed the whole range in __contpte_try_unfold().
>>> +		 */
>>> +		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
>>> +		__ptep_set_access_flags(vma, addr, ptep, entry, 0);

I also think this is wrong; we must pass `dirty` as the last parameter so that
__ptep_set_access_flags will flush if neccessary. My comment about having just
done the flush is incorrect - we have just done a flush, but the ptes are still
valid with their old value so the HW could pull this into the TLB before we
modify the value.

>>> +		contpte_try_fold(vma->vm_mm, addr, ptep, entry);
>>> +	}
>>> +
>>> +	return 1;
>>> +}
>>
> 
> Thanks,
> Ryan
> 

