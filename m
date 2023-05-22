Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479CE70B81A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjEVIy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjEVIyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:54:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCAE2138
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:54:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FDDC11FB;
        Mon, 22 May 2023 01:54:45 -0700 (PDT)
Received: from [10.57.73.5] (unknown [10.57.73.5])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62E3C3F6C4;
        Mon, 22 May 2023 01:53:58 -0700 (PDT)
Message-ID: <1a6468c3-0395-173d-7a0a-96dcd4f7616c@arm.com>
Date:   Mon, 22 May 2023 09:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and
 pmds
To:     SeongJae Park <sj@kernel.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
References: <20230519195435.90394-1-sj@kernel.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230519195435.90394-1-sj@kernel.org>
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

On 19/05/2023 20:54, SeongJae Park wrote:
> On Fri, 19 May 2023 10:02:48 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:
> 
>> On 19/05/2023 00:19, Yu Zhao wrote:
>>> On Thu, May 18, 2023 at 5:07 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> It is racy to non-atomically read a pte, then clear the young bit, then
>>>> write it back as this could discard dirty information. Further, it is
>>>> bad practice to directly set a pte entry within a table. Instead
>>>> clearing young must go through the arch-provided helper,
>>>> ptep_test_and_clear_young() to ensure it is modified atomically and to
>>>> give the arch code visibility and allow it to check (and potentially
>>>> modify) the operation.
>>>>
>>>> Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
>>>
>>> This should be a separate patch, since it's independent from what the
>>> series tries to do.
>>>
>>> And that patch should cc stable, since it fixes user data corruption.
>>
>> Fair point. The first 3 patches are fixes for issues I found during the
>> conversion. So if you're ok with it, I'll split into 2 series; the first 3
>> patches in the first, and the conversion to ptep_deref() (or ptep_get(), as per
>> your comments in the other thread) in the second. I guess the whole first series
>> should go to stable.
>>
>> Let me know if you disagree.
>>
>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  mm/damon/ops-common.c | 16 ++++++----------
>>>>  mm/damon/ops-common.h |  4 ++--
>>>>  mm/damon/paddr.c      |  4 ++--
>>>>  mm/damon/vaddr.c      |  4 ++--
>>>>  4 files changed, 12 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
>>>> index cc63cf953636..acc264b97903 100644
>>>> --- a/mm/damon/ops-common.c
>>>> +++ b/mm/damon/ops-common.c
>>>> @@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned long pfn)
>>>>         return folio;
>>>>  }
>>>>
>>>> -void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
>>>> +void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
>>>>  {
>>>>         bool referenced = false;
>>>>         struct folio *folio = damon_get_folio(pte_pfn(*pte));
>>>> @@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
>>>>         if (!folio)
>>>>                 return;
>>>>
>>>> -       if (pte_young(*pte)) {
>>>> +       if (ptep_test_and_clear_young(vma, addr, pte))
>>>>                 referenced = true;
>>>> -               *pte = pte_mkold(*pte);
>>>> -       }
>>>>
>>>>  #ifdef CONFIG_MMU_NOTIFIER
>>>> -       if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
>>>> +       if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
>>>>                 referenced = true;
>>>>  #endif /* CONFIG_MMU_NOTIFIER */
>>>
>>> Use ptep_clear_young_notify(). Similar below.
>>
>> This looks sensible but I'd like clarification from SeongJae: Are you happy for
>> me to do this refactoring as part of the patch?
> 
> Yes, I would be happy for that :)  Nevertheless, because that's a refactoring
> rather than a fix, I'd be happier if you could do that with a separate patch.

Great - I'll do it like this for v3.

> 
> 
> Thanks,
> SJ
> 
>>
>> Thanks,
>> Ryan
>>

