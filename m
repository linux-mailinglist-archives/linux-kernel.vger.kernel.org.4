Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CAC73F5AF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjF0H3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjF0H3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:29:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40761F5;
        Tue, 27 Jun 2023 00:29:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0B162F4;
        Tue, 27 Jun 2023 00:22:11 -0700 (PDT)
Received: from [10.57.76.16] (unknown [10.57.76.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E843F663;
        Tue, 27 Jun 2023 00:21:24 -0700 (PDT)
Message-ID: <2ff8ccf6-bf36-48b2-7dc2-e6c0d962f8b7@arm.com>
Date:   Tue, 27 Jun 2023 08:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v1 01/10] mm: Expose clear_huge_page() unconditionally
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
 <20230626171430.3167004-2-ryan.roberts@arm.com>
 <CAOUHufacvArJh7NjL_3LT-e3s1X+bazkvbgvEU+KPKGKEoW+dw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufacvArJh7NjL_3LT-e3s1X+bazkvbgvEU+KPKGKEoW+dw@mail.gmail.com>
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

On 27/06/2023 02:55, Yu Zhao wrote:
> On Mon, Jun 26, 2023 at 11:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> In preparation for extending vma_alloc_zeroed_movable_folio() to
>> allocate a arbitrary order folio, expose clear_huge_page()
>> unconditionally, so that it can be used to zero the allocated folio in
>> the generic implementation of vma_alloc_zeroed_movable_folio().
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/mm.h | 3 ++-
>>  mm/memory.c        | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 7f1741bd870a..7e3bf45e6491 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3684,10 +3684,11 @@ enum mf_action_page_type {
>>   */
>>  extern const struct attribute_group memory_failure_attr_group;
>>
>> -#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
>>  extern void clear_huge_page(struct page *page,
>>                             unsigned long addr_hint,
>>                             unsigned int pages_per_huge_page);
>> +
>> +#if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
> 
> We might not want to depend on THP eventually. Right now, we still
> have to, unless splitting is optional, which seems to contradict
> 06/10. (deferred_split_folio()  is a nop without THP.)

Yes, I agree - for large anon folios to work, we depend on THP. But I don't
think that helps us here.

In the next patch, I give vma_alloc_zeroed_movable_folio() an extra `order`
parameter. So the generic/default version of the function now needs a way to
clear a compound page.

I guess I could do something like:

 static inline
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
				   unsigned long vaddr, gfp_t gfp, int order)
 {
 	struct folio *folio;

	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE | gfp,
					order, vma, vaddr, false);
 	if (folio) {
#ifdef CONFIG_LARGE_FOLIO
		clear_huge_page(&folio->page, vaddr, 1U << order);
#else
		BUG_ON(order != 0);
		clear_user_highpage(&folio->page, vaddr);
#endif
	}

 	return folio;
 }

But that's pretty messy and there's no reason why other users might come along
that pass order != 0 and will be surprised by the BUG_ON.
