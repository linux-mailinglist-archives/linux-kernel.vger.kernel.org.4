Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7FB73F680
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF0IJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjF0IJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:09:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACF931FC7;
        Tue, 27 Jun 2023 01:09:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7400B2F4;
        Tue, 27 Jun 2023 01:10:21 -0700 (PDT)
Received: from [10.57.76.16] (unknown [10.57.76.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780303F663;
        Tue, 27 Jun 2023 01:09:33 -0700 (PDT)
Message-ID: <b16636b3-b493-39c5-c605-c5701fcbed1f@arm.com>
Date:   Tue, 27 Jun 2023 09:09:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 04/10] mm: Implement folio_add_new_anon_rmap_range()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-5-ryan.roberts@arm.com>
 <CAOUHufZ0ZzHoJXwbzNyZOv74L=XYdZzcxA8SXxLX0MXdykuWRA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufZ0ZzHoJXwbzNyZOv74L=XYdZzcxA8SXxLX0MXdykuWRA@mail.gmail.com>
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

On 27/06/2023 08:08, Yu Zhao wrote:
> On Mon, Jun 26, 2023 at 11:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Like folio_add_new_anon_rmap() but batch-rmaps a range of pages
>> belonging to a folio, for effciency savings. All pages are accounted as
>> small pages.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/rmap.h |  2 ++
>>  mm/rmap.c            | 43 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index a3825ce81102..15433a3d0cbf 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -196,6 +196,8 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>>                 unsigned long address);
>>  void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>                 unsigned long address);
>> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *page,
>> +               int nr, struct vm_area_struct *vma, unsigned long address);
> 
> We should update folio_add_new_anon_rmap() to support large() &&
> !folio_test_pmd_mappable() folios instead.
> 
> I double checked all places currently using folio_add_new_anon_rmap(),
> and as expected, none actually allocates large() &&
> !folio_test_pmd_mappable() and maps it one by one, which makes the
> cases simpler, i.e.,
>   if (!large())
>     // the existing basepage case
>   else if (!folio_test_pmd_mappable())
>     // our new case
>   else
>     // the existing THP case

I don't have a strong opinion either way. Happy to go with this suggestion. But
the reason I did it as a new function was because I was following the pattern in
[1] which adds a new folio_add_file_rmap_range() function.

[1] https://lore.kernel.org/linux-mm/20230315051444.3229621-35-willy@infradead.org/


> 
>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>                 bool compound);
>>  void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 1d8369549424..4050bcea7ae7 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1305,6 +1305,49 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>         __page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>>  }
>>
>> +/**
>> + * folio_add_new_anon_rmap_range - Add mapping to a set of pages within a new
>> + * anonymous potentially large folio.
>> + * @folio:      The folio containing the pages to be mapped
>> + * @page:       First page in the folio to be mapped
>> + * @nr:         Number of pages to be mapped
>> + * @vma:        the vm area in which the mapping is added
>> + * @address:    the user virtual address of the first page to be mapped
>> + *
>> + * Like folio_add_new_anon_rmap() but batch-maps a range of pages within a folio
>> + * using non-THP accounting. Like folio_add_new_anon_rmap(), the inc-and-test is
>> + * bypassed and the folio does not have to be locked. All pages in the folio are
>> + * individually accounted.
>> + *
>> + * As the folio is new, it's assumed to be mapped exclusively by a single
>> + * process.
>> + */
>> +void folio_add_new_anon_rmap_range(struct folio *folio, struct page *page,
>> +               int nr, struct vm_area_struct *vma, unsigned long address)
>> +{
>> +       int i;
>> +
>> +       VM_BUG_ON_VMA(address < vma->vm_start ||
>> +                     address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> 
> BTW, VM_BUG_ON* shouldn't be used in new code:
> Documentation/process/coding-style.rst

Thanks, sorry about that. Was copy-pasting from folio_add_new_anon_rmap().

