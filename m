Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305FF7473AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjGDOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGDOIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:08:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48E71119
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 07:08:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE3514BF;
        Tue,  4 Jul 2023 07:08:54 -0700 (PDT)
Received: from [10.1.35.40] (C02Z41KALVDN.cambridge.arm.com [10.1.35.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 538FC3F73F;
        Tue,  4 Jul 2023 07:08:10 -0700 (PDT)
Message-ID: <22b23340-5fad-01be-6bac-fa30a3724b27@arm.com>
Date:   Tue, 4 Jul 2023 15:08:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
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
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <CAOUHufaK82K8Sa35T7z3=gkm4GB0cWD3aqeZF6mYx82v7cOTeA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufaK82K8Sa35T7z3=gkm4GB0cWD3aqeZF6mYx82v7cOTeA@mail.gmail.com>
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

On 04/07/2023 02:35, Yu Zhao wrote:
> On Mon, Jul 3, 2023 at 7:53 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>> allocated in large folios of a specified order. All pages of the large
>> folio are pte-mapped during the same page fault, significantly reducing
>> the number of page faults. The number of per-page operations (e.g. ref
>> counting, rmap management lru list management) are also significantly
>> reduced since those ops now become per-folio.
>>
>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>> defaults to disabled for now; there is a long list of todos to make
>> FLEXIBLE_THP robust with existing features (e.g. compaction, mlock, some
>> madvise ops, etc). These items will be tackled in subsequent patches.
>>
>> When enabled, the preferred folio order is as returned by
>> arch_wants_pte_order(), which may be overridden by the arch as it sees
>> fit. Some architectures (e.g. arm64) can coalsece TLB entries if a
> 
> coalesce

ACK

> 
>> contiguous set of ptes map physically contigious, naturally aligned
> 
> contiguous

ACK

> 
>> memory, so this mechanism allows the architecture to optimize as
>> required.
>>
>> If the preferred order can't be used (e.g. because the folio would
>> breach the bounds of the vma, or because ptes in the region are already
>> mapped) then we fall back to a suitable lower order.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/Kconfig  |  10 ++++
>>  mm/memory.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 165 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 7672a22647b4..1c06b2c0a24e 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -822,6 +822,16 @@ config READ_ONLY_THP_FOR_FS
>>           support of file THPs will be developed in the next few release
>>           cycles.
>>
>> +config FLEXIBLE_THP
>> +       bool "Flexible order THP"
>> +       depends on TRANSPARENT_HUGEPAGE
>> +       default n
> 
> The default value is already N.

Is there a coding standard for this? Personally I prefer to make it explicit.

> 
>> +       help
>> +         Use large (bigger than order-0) folios to back anonymous memory where
>> +         possible, even if the order of the folio is smaller than the PMD
>> +         order. This reduces the number of page faults, as well as other
>> +         per-page overheads to improve performance for many workloads.
>> +
>>  endif # TRANSPARENT_HUGEPAGE
>>
>>  #
>> diff --git a/mm/memory.c b/mm/memory.c
>> index fb30f7523550..abe2ea94f3f5 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3001,6 +3001,116 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>>         return 0;
>>  }
>>
>> +#ifdef CONFIG_FLEXIBLE_THP
>> +/*
>> + * Allocates, zeros and returns a folio of the requested order for use as
>> + * anonymous memory.
>> + */
>> +static struct folio *alloc_anon_folio(struct vm_area_struct *vma,
>> +                                     unsigned long addr, int order)
>> +{
>> +       gfp_t gfp;
>> +       struct folio *folio;
>> +
>> +       if (order == 0)
>> +               return vma_alloc_zeroed_movable_folio(vma, addr);
>> +
>> +       gfp = vma_thp_gfp_mask(vma);
>> +       folio = vma_alloc_folio(gfp, order, vma, addr, true);
>> +       if (folio)
>> +               clear_huge_page(&folio->page, addr, folio_nr_pages(folio));
>> +
>> +       return folio;
>> +}
>> +
>> +/*
>> + * Preferred folio order to allocate for anonymous memory.
>> + */
>> +#define max_anon_folio_order(vma)      arch_wants_pte_order(vma)
>> +#else
>> +#define alloc_anon_folio(vma, addr, order) \
>> +                               vma_alloc_zeroed_movable_folio(vma, addr)
>> +#define max_anon_folio_order(vma)      0
>> +#endif
>> +
>> +/*
>> + * Returns index of first pte that is not none, or nr if all are none.
>> + */
>> +static inline int check_ptes_none(pte_t *pte, int nr)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < nr; i++) {
>> +               if (!pte_none(ptep_get(pte++)))
>> +                       return i;
>> +       }
>> +
>> +       return nr;
>> +}
>> +
>> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int order)
>> +{
>> +       /*
>> +        * The aim here is to determine what size of folio we should allocate
>> +        * for this fault. Factors include:
>> +        * - Order must not be higher than `order` upon entry
>> +        * - Folio must be naturally aligned within VA space
>> +        * - Folio must be fully contained inside one pmd entry
>> +        * - Folio must not breach boundaries of vma
>> +        * - Folio must not overlap any non-none ptes
>> +        *
>> +        * Additionally, we do not allow order-1 since this breaks assumptions
>> +        * elsewhere in the mm; THP pages must be at least order-2 (since they
>> +        * store state up to the 3rd struct page subpage), and these pages must
>> +        * be THP in order to correctly use pre-existing THP infrastructure such
>> +        * as folio_split().
>> +        *
>> +        * Note that the caller may or may not choose to lock the pte. If
>> +        * unlocked, the result is racy and the user must re-check any overlap
>> +        * with non-none ptes under the lock.
>> +        */
>> +
>> +       struct vm_area_struct *vma = vmf->vma;
>> +       int nr;
>> +       unsigned long addr;
>> +       pte_t *pte;
>> +       pte_t *first_set = NULL;
>> +       int ret;
>> +
>> +       order = min(order, PMD_SHIFT - PAGE_SHIFT);
>> +
>> +       for (; order > 1; order--) {
> 
> I'm not sure how we can justify this policy. As an initial step, it'd
> be a lot easier to sell if we only considered the order of
> arch_wants_pte_order() and the order 0.

My justification is in the cover letter; I see performance regression (vs the
unpatched kernel) when using the policy you suggest. This policy performs much
better in my tests. (I'll reply directly to your follow up questions in the
cover letter shortly).

What are your technical concerns about this approach? It is pretty light weight
(I only touch each PTE once, regardless of the number of loops). If we have
strong technical reasons for reverting to the less performant approach then fair
enough, but I'd like to hear the rational first.

> 
>> +               nr = 1 << order;
>> +               addr = ALIGN_DOWN(vmf->address, nr << PAGE_SHIFT);
>> +               pte = vmf->pte - ((vmf->address - addr) >> PAGE_SHIFT);
>> +
>> +               /* Check vma bounds. */
>> +               if (addr < vma->vm_start ||
>> +                   addr + (nr << PAGE_SHIFT) > vma->vm_end)
>> +                       continue;
>> +
>> +               /* Ptes covered by order already known to be none. */
>> +               if (pte + nr <= first_set)
>> +                       break;
>> +
>> +               /* Already found set pte in range covered by order. */
>> +               if (pte <= first_set)
>> +                       continue;
>> +
>> +               /* Need to check if all the ptes are none. */
>> +               ret = check_ptes_none(pte, nr);
>> +               if (ret == nr)
>> +                       break;
>> +
>> +               first_set = pte + ret;
>> +       }
>> +
>> +       if (order == 1)
>> +               order = 0;
>> +
>> +       return order;
>> +}
> 
> Everything above can be simplified into two helpers:
> vmf_pte_range_changed() and alloc_anon_folio() (or whatever names you
> prefer). Details below.
> 
>>  /*
>>   * Handle write page faults for pages that can be reused in the current vma
>>   *
>> @@ -3073,7 +3183,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>>                 goto oom;
>>
>>         if (is_zero_pfn(pte_pfn(vmf->orig_pte))) {
>> -               new_folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>> +               new_folio = alloc_anon_folio(vma, vmf->address, 0);
> 
> This seems unnecessary for now. Later on, we could fill in an aligned
> area with multiple write-protected zero pages during a read fault and
> then replace them with a large folio here.

I don't have a strong opinion. I thought that it would be neater to use the same
API everywhere, but happy to revert.

> 
>>                 if (!new_folio)
>>                         goto oom;
>>         } else {
>> @@ -4040,6 +4150,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>         struct folio *folio;
>>         vm_fault_t ret = 0;
>>         pte_t entry;
>> +       int order;
>> +       int pgcount;
>> +       unsigned long addr;
>>
>>         /* File mapping without ->vm_ops ? */
>>         if (vma->vm_flags & VM_SHARED)
>> @@ -4081,24 +4194,51 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>                         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>                         return handle_userfault(vmf, VM_UFFD_MISSING);
>>                 }
>> -               goto setpte;
>> +               if (uffd_wp)
>> +                       entry = pte_mkuffd_wp(entry);
>> +               set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>> +
>> +               /* No need to invalidate - it was non-present before */
>> +               update_mmu_cache(vma, vmf->address, vmf->pte);
>> +               goto unlock;
>> +       }
> 
> Nor really needed IMO. Details below.
> 
> ===
> 
>> +       /*
>> +        * If allocating a large folio, determine the biggest suitable order for
>> +        * the VMA (e.g. it must not exceed the VMA's bounds, it must not
>> +        * overlap with any populated PTEs, etc). We are not under the ptl here
>> +        * so we will need to re-check that we are not overlapping any populated
>> +        * PTEs once we have the lock.
>> +        */
>> +       order = uffd_wp ? 0 : max_anon_folio_order(vma);
>> +       if (order > 0) {
>> +               vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
>> +               order = calc_anon_folio_order_alloc(vmf, order);
>> +               pte_unmap(vmf->pte);
>>         }
> 
> ===
> 
> The section above together with the section below should be wrapped in a helper.
> 
>> -       /* Allocate our own private page. */
>> +       /* Allocate our own private folio. */
>>         if (unlikely(anon_vma_prepare(vma)))
>>                 goto oom;
> 
> ===
> 
>> -       folio = vma_alloc_zeroed_movable_folio(vma, vmf->address);
>> +       folio = alloc_anon_folio(vma, vmf->address, order);
>> +       if (!folio && order > 0) {
>> +               order = 0;
>> +               folio = alloc_anon_folio(vma, vmf->address, order);
>> +       }
> 
> ===
> 
> One helper returns a folio of order arch_wants_pte_order(), or order 0
> if it fails to allocate that order, e.g.,
> 
> folio = alloc_anon_folio(vmf);
> 
> And if vmf_orig_pte_uffd_wp(vmf) is true, the helper allocates order 0
> regardless of arch_wants_pte_order(). Upon success, it can update
> vmf->address, since if we run into a race with another PF, we exit the
> fault handler and retry anyway.
> 
>>         if (!folio)
>>                 goto oom;
>>
>> +       pgcount = 1 << order;
>> +       addr = ALIGN_DOWN(vmf->address, pgcount << PAGE_SHIFT);
> 
> As shown above, the helper already updates vmf->address. And mm/ never
> used pgcount before -- the convention is nr_pages = folio_nr_pages().

ACK

> 
>>         if (mem_cgroup_charge(folio, vma->vm_mm, GFP_KERNEL))
>>                 goto oom_free_page;
>>         folio_throttle_swaprate(folio, GFP_KERNEL);
>>
>>         /*
>>          * The memory barrier inside __folio_mark_uptodate makes sure that
>> -        * preceding stores to the page contents become visible before
>> -        * the set_pte_at() write.
>> +        * preceding stores to the folio contents become visible before
>> +        * the set_ptes() write.
> 
> We don't have set_ptes() yet.

Indeed, that's why I listed the set_ptes() patch set as a hard dependency ;-)

> 
>>          */
>>         __folio_mark_uptodate(folio);
>>
>> @@ -4107,11 +4247,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>         if (vma->vm_flags & VM_WRITE)
>>                 entry = pte_mkwrite(pte_mkdirty(entry));
>>
>> -       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>> -                       &vmf->ptl);
>> +       vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
>>         if (vmf_pte_changed(vmf)) {
>>                 update_mmu_tlb(vma, vmf->address, vmf->pte);
>>                 goto release;
>> +       } else if (order > 0 && check_ptes_none(vmf->pte, pgcount) != pgcount) {
>> +               goto release;
>>         }
> 
> Need new helper:
> 
>   if (vmf_pte_range_changed(vmf, nr_pages)) {
>     for (i = 0; i < nr_pages; i++)
>       update_mmu_tlb(vma, vmf->address + PAGE_SIZE * i, vmf->pte + i);
>     goto release;
>   }
> 
> (It should be fine to call update_mmu_tlb() even if it's not really necessary.)
> 
>>         ret = check_stable_address_space(vma->vm_mm);
>> @@ -4125,16 +4266,17 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>>                 return handle_userfault(vmf, VM_UFFD_MISSING);
>>         }
>>
>> -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>> -       folio_add_new_anon_rmap(folio, vma, vmf->address);
>> +       folio_ref_add(folio, pgcount - 1);
>> +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, pgcount);
>> +       folio_add_new_anon_rmap(folio, vma, addr);
>>         folio_add_lru_vma(folio, vma);
>> -setpte:
>> +
>>         if (uffd_wp)
>>                 entry = pte_mkuffd_wp(entry);
>> -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, entry);
>> +       set_ptes(vma->vm_mm, addr, vmf->pte, entry, pgcount);
> 
> We would have to do it one by one for now.
> 
>>         /* No need to invalidate - it was non-present before */
>> -       update_mmu_cache(vma, vmf->address, vmf->pte);
>> +       update_mmu_cache_range(vma, addr, vmf->pte, pgcount);
> 
> Ditto.
> 
> How about this (by moving mk_pte()  and its friends here):
> ...
>         folio_add_lru_vma(folio, vma);
> 
>         for (i = 0; i < nr_pages; i++) {
>                 entry = mk_pte(folio_page(folio, i), vma->vm_page_prot);
>                 entry = pte_sw_mkyoung(entry);
>                 if (vma->vm_flags & VM_WRITE)
>                         entry = pte_mkwrite(pte_mkdirty(entry));
> setpte:
>                 if (uffd_wp)
>                         entry = pte_mkuffd_wp(entry);
>                 set_pte_at(vma->vm_mm, vmf->address + PAGE_SIZE * i,
> vmf->pte + i, entry);
> 
>                 /* No need to invalidate - it was non-present before */
>                 update_mmu_cache(vma, vmf->address + PAGE_SIZE * i,
> vmf->pte + i);
>         }
> 
>>  unlock:
>>         pte_unmap_unlock(vmf->pte, vmf->ptl);
>>         return ret;
> 
> Attaching a small patch in case anything above is not clear. Please
> take a look. Thanks.

OK, I'll take a look and rework for v3.


