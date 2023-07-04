Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CB074717D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDMgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 08:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGDMgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 08:36:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BFCAE7B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 05:36:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1738F2F4;
        Tue,  4 Jul 2023 05:37:18 -0700 (PDT)
Received: from [10.1.35.40] (C02Z41KALVDN.cambridge.arm.com [10.1.35.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC6E3F762;
        Tue,  4 Jul 2023 05:36:33 -0700 (PDT)
Message-ID: <6d389825-1fc0-5c16-7858-2290fd632682@arm.com>
Date:   Tue, 4 Jul 2023 13:36:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/5] mm: Default implementation of
 arch_wants_pte_order()
To:     Yu Zhao <yuzhao@google.com>, "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-4-ryan.roberts@arm.com>
 <ac6802f6-01a2-6b39-38c7-2fe3cea75dde@intel.com>
 <CAOUHufbmv0pZ1h9AxBj-SD7OqRZYudHMtXzQxcwD4ky-sFd8kg@mail.gmail.com>
 <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufbpCU_Z7g1QPJ0+HzE9sdNpSh=Mzi0EByLPu5TE4S_UcQ@mail.gmail.com>
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

On 04/07/2023 04:59, Yu Zhao wrote:
> On Mon, Jul 3, 2023 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
>>
>> On Mon, Jul 3, 2023 at 8:23 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>>
>>>
>>>
>>> On 7/3/2023 9:53 PM, Ryan Roberts wrote:
>>>> arch_wants_pte_order() can be overridden by the arch to return the
>>>> preferred folio order for pte-mapped memory. This is useful as some
>>>> architectures (e.g. arm64) can coalesce TLB entries when the physical
>>>> memory is suitably contiguous.
>>>>
>>>> The first user for this hint will be FLEXIBLE_THP, which aims to
>>>> allocate large folios for anonymous memory to reduce page faults and
>>>> other per-page operation costs.
>>>>
>>>> Here we add the default implementation of the function, used when the
>>>> architecture does not define it, which returns the order corresponding
>>>> to 64K.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  include/linux/pgtable.h | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>> index a661a17173fa..f7e38598f20b 100644
>>>> --- a/include/linux/pgtable.h
>>>> +++ b/include/linux/pgtable.h
>>>> @@ -13,6 +13,7 @@
>>>>  #include <linux/errno.h>
>>>>  #include <asm-generic/pgtable_uffd.h>
>>>>  #include <linux/page_table_check.h>
>>>> +#include <linux/sizes.h>
>>>>
>>>>  #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>>>>       defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
>>>> @@ -336,6 +337,18 @@ static inline bool arch_has_hw_pte_young(void)
>>>>  }
>>>>  #endif
>>>>
>>>> +#ifndef arch_wants_pte_order
>>>> +/*
>>>> + * Returns preferred folio order for pte-mapped memory. Must be in range [0,
>>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires large folios
>>>> + * to be at least order-2.
>>>> + */
>>>> +static inline int arch_wants_pte_order(struct vm_area_struct *vma)
>>>> +{
>>>> +     return ilog2(SZ_64K >> PAGE_SHIFT);
>>> Default value which is not related with any silicon may be: PAGE_ALLOC_COSTLY_ORDER?
>>>
>>> Also, current pcp list support cache page with order 0...PAGE_ALLOC_COSTLY_ORDER, 9.
>>> If the pcp could cover the page, the pressure to zone lock will be reduced by pcp.
>>
>> The value of PAGE_ALLOC_COSTLY_ORDER is reasonable but again it's a
>> s/w policy not a h/w preference. Besides, I don't think we can include
>> mmzone.h in pgtable.h.
> 
> I think we can make a compromise:
> 1. change the default implementation of arch_has_hw_pte_young() to return 0, and
> 2. in memory.c, we can try PAGE_ALLOC_COSTLY_ORDER for archs that
> don't override arch_has_hw_pte_young(), or if its return value is too
> large to fit.
> This should also take care of the regression, right?

I think you are suggesting that we use 0 as a sentinel which we then translate
to PAGE_ALLOC_COSTLY_ORDER? I already have a max_anon_folio_order() function in
memory.c (actually it is currently a macro defined as arch_wants_pte_order()).

So it would become (I'll talk about the vma concern separately in the thread
where you raised it):

static inline int max_anon_folio_order(struct vm_area_struct *vma)
{
	int order = arch_wants_pte_order(vma);

	return order ? order : PAGE_ALLOC_COSTLY_ORDER;
}

Correct?

I don't see how it fixes the regression (assume you're talking about
Speedometer) though? On arm64 arch_wants_pte_order() will still be returning
order-4.

