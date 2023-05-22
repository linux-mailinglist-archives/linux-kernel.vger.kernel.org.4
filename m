Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5097F70BEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjEVMwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 08:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEVMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 08:52:36 -0400
Received: from out-1.mta0.migadu.com (out-1.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D6A9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 05:52:34 -0700 (PDT)
Message-ID: <a56c92c9-44a0-97f4-1a3d-e1679471f19c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684759952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHbNOydWK5gCXaBShYnOGzZDvMMinxhe2BOs3NoEFIo=;
        b=jdLuNuP5mENiSr3tB5gH4N2rOp1VCiL2/WVXk+6KbOWyiP5/ntDqfGzra7Zox7masm7H2M
        UTdRTXiF0RldfXzzzvkTcdrYnk7FtA2kGCVkdspa4bMsE5A4pisXWPKPQNPDMkSQxPglOu
        12NrK0OtbA93QI0xKNMlcebV2ujY+L0=
Date:   Mon, 22 May 2023 20:52:19 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 29/31] mm/memory: handle_pte_fault() use
 pte_offset_map_nolock()
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
 <5f10e87-c413-eb92-fc6-541e52c1f6be@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <5f10e87-c413-eb92-fc6-541e52c1f6be@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/22 13:26, Hugh Dickins wrote:
> handle_pte_fault() use pte_offset_map_nolock() to get the vmf.ptl which
> corresponds to vmf.pte, instead of pte_lockptr() being used later, when
> there's a chance that the pmd entry might have changed, perhaps to none,
> or to a huge pmd, with no split ptlock in its struct page.
> 
> Remove its pmd_devmap_trans_unstable() call: pte_offset_map_nolock()
> will handle that case by failing.  Update the "morph" comment above,
> looking forward to when shmem or file collapse to THP may not take
> mmap_lock for write (or not at all).
> 
> do_numa_page() use the vmf->ptl from handle_pte_fault() at first, but
> refresh it when refreshing vmf->pte.
> 
> do_swap_page()'s pte_unmap_same() (the thing that takes ptl to verify a
> two-part PAE orig_pte) use the vmf->ptl from handle_pte_fault() too; but
> do_swap_page() is also used by anon THP's __collapse_huge_page_swapin(),
> so adjust that to set vmf->ptl by pte_offset_map_nolock().
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>   mm/khugepaged.c |  6 ++++--
>   mm/memory.c     | 38 +++++++++++++-------------------------
>   2 files changed, 17 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 49cfa7cdfe93..c11db2e78e95 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1005,6 +1005,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
>   	int result;
>   	pte_t *pte = NULL;
> +	spinlock_t *ptl;
>   
>   	for (address = haddr; address < end; address += PAGE_SIZE) {
>   		struct vm_fault vmf = {
> @@ -1016,7 +1017,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   		};
>   
>   		if (!pte++) {
> -			pte = pte_offset_map(pmd, address);
> +			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
>   			if (!pte) {
>   				mmap_read_unlock(mm);
>   				result = SCAN_PMD_NULL;
> @@ -1024,11 +1025,12 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
>   			}
>   		}
>   
> -		vmf.orig_pte = *pte;
> +		vmf.orig_pte = ptep_get_lockless(pte);
>   		if (!is_swap_pte(vmf.orig_pte))
>   			continue;
>   
>   		vmf.pte = pte;
> +		vmf.ptl = ptl;
>   		ret = do_swap_page(&vmf);
>   		/* Which unmaps pte (after perhaps re-checking the entry) */
>   		pte = NULL;
> diff --git a/mm/memory.c b/mm/memory.c
> index c7b920291a72..4ec46eecefd3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2786,10 +2786,9 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
>   	int same = 1;
>   #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
>   	if (sizeof(pte_t) > sizeof(unsigned long)) {
> -		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
> -		spin_lock(ptl);
> +		spin_lock(vmf->ptl);
>   		same = pte_same(*vmf->pte, vmf->orig_pte);
> -		spin_unlock(ptl);
> +		spin_unlock(vmf->ptl);
>   	}
>   #endif
>   	pte_unmap(vmf->pte);
> @@ -4696,7 +4695,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   	 * validation through pte_unmap_same(). It's of NUMA type but
>   	 * the pfn may be screwed if the read is non atomic.
>   	 */
> -	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
>   	spin_lock(vmf->ptl);
>   	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
>   		pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -4767,8 +4765,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>   		flags |= TNF_MIGRATED;
>   	} else {
>   		flags |= TNF_MIGRATE_FAIL;
> -		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> -		spin_lock(vmf->ptl);
> +		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> +					       vmf->address, &vmf->ptl);
> +		if (unlikely(!vmf->pte))
> +			goto out;
>   		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
>   			pte_unmap_unlock(vmf->pte, vmf->ptl);
>   			goto out;
> @@ -4897,27 +4897,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   		vmf->pte = NULL;
>   		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
>   	} else {
> -		/*
> -		 * If a huge pmd materialized under us just retry later.  Use
> -		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
> -		 * of pmd_trans_huge() to ensure the pmd didn't become
> -		 * pmd_trans_huge under us and then back to pmd_none, as a
> -		 * result of MADV_DONTNEED running immediately after a huge pmd
> -		 * fault in a different thread of this mm, in turn leading to a
> -		 * misleading pmd_trans_huge() retval. All we have to ensure is
> -		 * that it is a regular pmd that we can walk with
> -		 * pte_offset_map() and we can do that through an atomic read
> -		 * in C, which is what pmd_trans_unstable() provides.
> -		 */
> -		if (pmd_devmap_trans_unstable(vmf->pmd))
> -			return 0;
>   		/*
>   		 * A regular pmd is established and it can't morph into a huge
> -		 * pmd from under us anymore at this point because we hold the
> -		 * mmap_lock read mode and khugepaged takes it in write mode.
> -		 * So now it's safe to run pte_offset_map().
> +		 * pmd by anon khugepaged, since that takes mmap_lock in write
> +		 * mode; but shmem or file collapse to THP could still morph
> +		 * it into a huge pmd: just retry later if so.
>   		 */
> -		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> +		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
> +						 vmf->address, &vmf->ptl);
> +		if (unlikely(!vmf->pte))
> +			return 0;

Just jump to the retry label below?

diff --git a/mm/memory.c b/mm/memory.c
index 63632a5eafc1..2e712fe6f4be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4897,7 +4897,8 @@ static vm_fault_t handle_pte_fault(struct vm_fault 
*vmf)
  {
         pte_t entry;

-       if (unlikely(pmd_none(*vmf->pmd))) {
+retry:
+       if (unlikely(pmd_none(READ_ONCE(*vmf->pmd)))) {
                 /*
                  * Leave __pte_alloc() until later: because 
vm_ops->fault may
                  * want to allocate huge page, and if we expose page table

>   		vmf->orig_pte = ptep_get_lockless(vmf->pte);
>   		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
>   
> @@ -4936,7 +4925,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>   	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
>   		return do_numa_page(vmf);
>   
> -	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>   	spin_lock(vmf->ptl);
>   	entry = vmf->orig_pte;
>   	if (unlikely(!pte_same(*vmf->pte, entry))) {

-- 
Thanks,
Qi
