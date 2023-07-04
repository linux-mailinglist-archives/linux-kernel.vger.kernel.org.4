Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDC74729A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGDNUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjGDNUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:20:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27B8C10C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 06:20:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C2FC14;
        Tue,  4 Jul 2023 06:20:46 -0700 (PDT)
Received: from [10.1.35.40] (C02Z41KALVDN.cambridge.arm.com [10.1.35.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49D233F663;
        Tue,  4 Jul 2023 06:20:02 -0700 (PDT)
Message-ID: <eea2b36d-9c6d-64ca-4e21-57cfd5a93d57@arm.com>
Date:   Tue, 4 Jul 2023 14:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
 <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufa_xFJvFFvmw1Tkdc9cXaZ1GPA1dVSauH+J9zGX-sO1UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 20:50, Yu Zhao wrote:
> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> arch_wants_pte_order() can be overridden by the arch to return the
>> preferred folio order for pte-mapped memory. This is useful as some
>> architectures (e.g. arm64) can coalesce TLB entries when the physical
>> memory is suitably contiguous.
>>
>> The first user for this hint will be FLEXIBLE_THP, which aims to
>> allocate large folios for anonymous memory to reduce page faults and
>> other per-page operation costs.
>>
>> Here we add the default implementation of the function, used when the
>> architecture does not define it, which returns the order corresponding
>> to 64K.
> 
> I don't really mind a non-zero default value. But people would ask why
> non-zero and why 64KB. Probably you could argue this is the large size
> all known archs support if they have TLB coalescing. For x86, AMD CPUs
> would want to override this. I'll leave it to Fengwei to decide
> whether Intel wants a different default value.>
> Also I don't like the vma parameter because it makes
> arch_wants_pte_order() a mix of hw preference and vma policy. From my
> POV, the function should be only about the former; the latter should
> be decided by arch-independent MM code. However, I can live with it if
> ARM MM people think this is really what you want. ATM, I'm skeptical
> they do.

Here's the big picture for what I'm tryng to achieve:

 - In the common case, I'd like all programs to get a performance bump by
automatically and transparently using large anon folios - so no explicit
requirement on the process to opt-in.

 - On arm64, in the above case, I'd like the preferred folio size to be 64K;
from the (admittedly limitted) testing I've done that's about where the
performance knee is and it doesn't appear to increase the memory wastage very
much. It also has the benefits that for 4K base pages this is the contpte size
(order-4) so I can take full benefit of contpte mappings transparently to the
process. And for 16K this is the HPA size (order-2).

 - On arm64 when the process has marked the VMA for THP (or when
transparent_hugepage=always) but the VMA does not meet the requirements for a
PMD-sized mapping (or we failed to allocate, ...) then I'd like to map using
contpte. For 4K base pages this is 64K (order-4), for 16K this is 2M (order-7)
and for 64K this is 2M (order-5). The 64K base page case is very important since
the PMD size for that base page is 512MB which is almost impossible to allocate
in practice.

So one approach would be to define arch_wants_pte_order() as always returning
the contpte size (remove the vma parameter). Then max_anon_folio_order() in
memory.c could so this:


#define MAX_ANON_FOLIO_ORDER_NOTHP	ilog2(SZ_64K >> PAGE_SHIFT);

static inline int max_anon_folio_order(struct vm_area_struct *vma)
{
	int order = arch_wants_pte_order();

	// Fix up default case which returns 0 because PAGE_ALLOC_COSTLY_ORDER
	// can't be used directly in pgtable.h
	order = order ? order : PAGE_ALLOC_COSTLY_ORDER;

	if (hugepage_vma_check(vma, vma->vm_flags, false, true, true))
		return order;
	else
		return min(order, MAX_ANON_FOLIO_ORDER_NOTHP);
}


This moves the SW policy into memory.c and gives you PAGE_ALLOC_COSTLY_ORDER (or
whatever default we decide on) as the default for arches with no override, and
also meets all my goals above.

> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> After another CPU vendor, e.g., Fengwei, and an ARM MM person, e.g.,
> Will give the green light:
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> 
>> ---
>>  include/linux/pgtable.h | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index a661a17173fa..f7e38598f20b 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -13,6 +13,7 @@
>>  #include <linux/errno.h>
>>  #include <asm-generic/pgtable_uffd.h>
>>  #include <linux/page_table_check.h>
>> +#include <linux/sizes.h>
>>
>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>>         defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
>>  }
>>  #endif
>>
>> +#ifndef arch_wants_pte_order
>> +/*
>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
> 
> The warning is helpful.
> 
>> + * to be at least order-2.
>> + */
>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
>> +{
>> +       return ilog2(SZ_64K >> PAGE_SHIFT);
>> +}
>> +#endif
>> +
>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>                                        unsigned long address,

