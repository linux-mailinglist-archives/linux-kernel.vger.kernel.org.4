Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E18643BA3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbiLFDFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbiLFDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:05:51 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654D62253F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 19:05:48 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NR4tW1WtNzqSsN;
        Tue,  6 Dec 2022 11:01:07 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 11:05:14 +0800
Subject: Re: [PATCH v4 12/17] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, <linux-mm@kvack.org>
References: <20220428083441.37290-1-david@redhat.com>
 <20220428083441.37290-13-david@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <90dd6a93-4500-e0de-2bf0-bf522c311b0c@huawei.com>
Date:   Tue, 6 Dec 2022 11:05:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220428083441.37290-13-david@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/28 16:34, David Hildenbrand wrote:
> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
> exclusive, and use that information to make GUP pins reliable and stay
> consistent with the page mapped into the page table even if the
> page table entry gets write-protected.
> 
> With that information at hand, we can extend our COW logic to always
> reuse anonymous pages that are exclusive. For anonymous pages that
> might be shared, the existing logic applies.
> 
> As already documented, PG_anon_exclusive is usually only expressive in
> combination with a page table entry. Especially PTE vs. PMD-mapped
> anonymous pages require more thought, some examples: due to mremap() we
> can easily have a single compound page PTE-mapped into multiple page tables
> exclusively in a single process -- multiple page table locks apply.
> Further, due to MADV_WIPEONFORK we might not necessarily write-protect
> all PTEs, and only some subpages might be pinned. Long story short: once
> PTE-mapped, we have to track information about exclusivity per sub-page,
> but until then, we can just track it for the compound page in the head
> page and not having to update a whole bunch of subpages all of the time
> for a simple PMD mapping of a THP.
> 
> For simplicity, this commit mostly talks about "anonymous pages", while
> it's for THP actually "the part of an anonymous folio referenced via
> a page table entry".
> 
> To not spill PG_anon_exclusive code all over the mm code-base, we let
> the anon rmap code to handle all PG_anon_exclusive logic it can easily
> handle.
> 
> If a writable, present page table entry points at an anonymous (sub)page,
> that (sub)page must be PG_anon_exclusive. If GUP wants to take a reliably
> pin (FOLL_PIN) on an anonymous page references via a present
> page table entry, it must only pin if PG_anon_exclusive is set for the
> mapped (sub)page.
> 
> This commit doesn't adjust GUP, so this is only implicitly handled for
> FOLL_WRITE, follow-up commits will teach GUP to also respect it for
> FOLL_PIN without FOLL_WRITE, to make all GUP pins of anonymous pages
> fully reliable.
> 
> Whenever an anonymous page is to be shared (fork(), KSM), or when
> temporarily unmapping an anonymous page (swap, migration), the relevant
> PG_anon_exclusive bit has to be cleared to mark the anonymous page
> possibly shared. Clearing will fail if there are GUP pins on the page:
> * For fork(), this means having to copy the page and not being able to
>   share it. fork() protects against concurrent GUP using the PT lock and
>   the src_mm->write_protect_seq.
> * For KSM, this means sharing will fail. For swap this means, unmapping
>   will fail, For migration this means, migration will fail early. All
>   three cases protect against concurrent GUP using the PT lock and a
>   proper clear/invalidate+flush of the relevant page table entry.
> 
> This fixes memory corruptions reported for FOLL_PIN | FOLL_WRITE, when a
> pinned page gets mapped R/O and the successive write fault ends up
> replacing the page instead of reusing it. It improves the situation for
> O_DIRECT/vmsplice/... that still use FOLL_GET instead of FOLL_PIN,
> if fork() is *not* involved, however swapout and fork() are still
> problematic. Properly using FOLL_PIN instead of FOLL_GET for these
> GUP users will fix the issue for them.
> 

Hi David, sorry for the late respond and a possible inconsequential question. :)

<snip>

> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7a71ed679853..5add8bbd47cd 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4772,7 +4772,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  				    is_hugetlb_entry_hwpoisoned(entry))) {
>  			swp_entry_t swp_entry = pte_to_swp_entry(entry);
>  
> -			if (is_writable_migration_entry(swp_entry) && cow) {
> +			if (!is_readable_migration_entry(swp_entry) && cow) {
>  				/*
>  				 * COW mappings require pages in both
>  				 * parent and child to be set to read.
> @@ -5172,6 +5172,8 @@ static vm_fault_t hugetlb_cow(struct mm_struct *mm, struct vm_area_struct *vma,
>  		set_huge_ptep_writable(vma, haddr, ptep);
>  		return 0;
>  	}
> +	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
> +		       old_page);
>  
>  	/*
>  	 * If the process that created a MAP_PRIVATE mapping is about to
> @@ -6169,12 +6171,17 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
>  		}
>  		if (unlikely(is_hugetlb_entry_migration(pte))) {
>  			swp_entry_t entry = pte_to_swp_entry(pte);
> +			struct page *page = pfn_swap_entry_to_page(entry);
>  
> -			if (is_writable_migration_entry(entry)) {
> +			if (!is_readable_migration_entry(entry)) {

In hugetlb_change_protection(), is_writable_migration_entry() is changed to !is_readable_migration_entry(),
but

>  				pte_t newpte;
>  
> -				entry = make_readable_migration_entry(
> -							swp_offset(entry));
> +				if (PageAnon(page))
> +					entry = make_readable_exclusive_migration_entry(
> +								swp_offset(entry));
> +				else
> +					entry = make_readable_migration_entry(
> +								swp_offset(entry));
>  				newpte = swp_entry_to_pte(entry);
>  				set_huge_swap_pte_at(mm, address, ptep,
>  						     newpte, huge_page_size(h));

<snip>

> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index b69ce7a7b2b7..56060acdabd3 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -152,6 +152,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			pages++;
>  		} else if (is_swap_pte(oldpte)) {
>  			swp_entry_t entry = pte_to_swp_entry(oldpte);
> +			struct page *page = pfn_swap_entry_to_page(entry);
>  			pte_t newpte;
>  
>  			if (is_writable_migration_entry(entry)) {

In change_pte_range(), is_writable_migration_entry() is not changed to !is_readable_migration_entry().
Is this done intentionally? Could you tell me why there's such a difference? I'm confused. It's very
kind of you if you can answer my puzzle.

Thanks!
Miaohe Lin

> @@ -159,8 +160,11 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  				 * A protection check is difficult so
>  				 * just be safe and disable write
>  				 */
> -				entry = make_readable_migration_entry(
> -							swp_offset(entry));
> +				if (PageAnon(page))
> +					entry = make_readable_exclusive_migration_entry(
> +							     swp_offset(entry));
> +				else
> +					entry = make_readable_migration_entry(swp_offset(entry));
>  				newpte = swp_entry_to_pte(entry);
>  				if (pte_swp_soft_dirty(oldpte))
>  					newpte = pte_swp_mksoft_dirty(newpte);
