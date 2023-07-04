Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01F1746FBF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDLUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGDLUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:20:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 634EF10FD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:19:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBCF22F4;
        Tue,  4 Jul 2023 04:20:35 -0700 (PDT)
Received: from [10.1.35.40] (C02Z41KALVDN.cambridge.arm.com [10.1.35.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4C63F73F;
        Tue,  4 Jul 2023 04:19:51 -0700 (PDT)
Message-ID: <753fe3a7-e077-09d0-8233-fa834c11d280@arm.com>
Date:   Tue, 4 Jul 2023 12:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/5] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>
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
 <20230703135330.1865927-2-ryan.roberts@arm.com>
 <CAOUHufYtW+6Svaq7pcyBiModTSKn1VU-LKxB_Xwnja=f83X2YA@mail.gmail.com>
 <9e2fe34e-7615-119c-43b3-31d0b8be3af0@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <9e2fe34e-7615-119c-43b3-31d0b8be3af0@intel.com>
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

On 04/07/2023 03:13, Yin, Fengwei wrote:
> 
> 
> On 7/4/2023 3:05 AM, Yu Zhao wrote:
>> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> In preparation for FLEXIBLE_THP support, improve
>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>>> passed to it. In this case, all contained pages are accounted using the
>>> "small" pages scheme.
>>
>> Nit: In this case, all *subpages*  are accounted using the *order-0
>> folio* (or base page) scheme.
> Matthew suggested not to use subpage with folio. Using page with folio:
> https://lore.kernel.org/linux-mm/Y9qiS%2FIxZOMx62t6@casper.infradead.org/

OK, I'll change this to "In this case, all contained pages are accounted using
the *order-0 folio* (or base page) scheme."

> 
>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>> Reviewed-by: Yu Zhao <yuzhao@google.com>

Thanks!

>>
>>>  mm/rmap.c | 26 +++++++++++++++++++-------
>>>  1 file changed, 19 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 1d8369549424..82ef5ba363d1 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1278,31 +1278,43 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>>   * This means the inc-and-test can be bypassed.
>>>   * The folio does not have to be locked.
>>>   *
>>> - * If the folio is large, it is accounted as a THP.  As the folio
>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>>   * is new, it's assumed to be mapped exclusively by a single process.
>>>   */
>>>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>                 unsigned long address)
>>>  {
>>> -       int nr;
>>> +       int nr = folio_nr_pages(folio);
>>> +       int i;
>>> +       struct page *page;
>>>
>>> -       VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>>> +       VM_BUG_ON_VMA(address < vma->vm_start ||
>>> +                       address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>>         __folio_set_swapbacked(folio);
>>>
>>> -       if (likely(!folio_test_pmd_mappable(folio))) {
>>> +       if (!folio_test_large(folio)) {
>>>                 /* increment count (starts at -1) */
>>>                 atomic_set(&folio->_mapcount, 0);
>>> -               nr = 1;
>>> +               __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>> +       } else if (!folio_test_pmd_mappable(folio)) {
>>> +               /* increment count (starts at 0) */
>>> +               atomic_set(&folio->_nr_pages_mapped, nr);
>>> +
>>> +               page = &folio->page;
>>> +               for (i = 0; i < nr; i++, page++, address += PAGE_SIZE) {
>>> +                       /* increment count (starts at -1) */
>>> +                       atomic_set(&page->_mapcount, 0);
>>> +                       __page_set_anon_rmap(folio, page, vma, address, 1);
>>> +               }
>>
>> Nit: use folio_page(), e.g.,

Yep, will change for v3.

>>
>>   } else if (!folio_test_pmd_mappable(folio)) {
>>     int i;
>>
>>     for (i = 0; i < nr; i++) {
>>       struct page *page = folio_page(folio, i);
>>
>>       /* increment count (starts at -1) */
>>       atomic_set(&page->_mapcount, 0);
>>       __page_set_anon_rmap(folio, page, vma, address + PAGE_SIZE * i, 1);
>>     }
>>     /* increment count (starts at 0) */
>>     atomic_set(&folio->_nr_pages_mapped, nr);
>>   } else {
>>
>>>         } else {
>>>                 /* increment count (starts at -1) */
>>>                 atomic_set(&folio->_entire_mapcount, 0);
>>>                 atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
>>> -               nr = folio_nr_pages(folio);
>>>                 __lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
>>> +               __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>>         }
>>>
>>>         __lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
>>> -       __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>>  }

