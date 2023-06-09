Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC73728D40
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbjFIBpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbjFIBpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:45:11 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1E41A2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:45:10 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565cdb77b01so10989137b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 18:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686275110; x=1688867110;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2+W0bna42qnZ43tvOf68yFS9Jt1uoq2b6WWLaZ+Rg=;
        b=5nDVvDFDj0TDSwA6VyREm/b7XZyfd9szkT+LB84tX5XiJW9/M17p2pjZw/Ek5jNCOs
         40hFeMoNWqiJJMeNTMe2RktTogEBFqE0QPIaTtgF826N1Ako6QEnbFjFhp7dOZXF3sOJ
         aEBqtDp9A7OZ2dPSncNi3eN5NLAJGJkMJEjCptn2bKCi4uA/IGUtLDX3g50JH0sMPf9e
         MNUa9uUW/hKz7iJbU0zOzLOl/zU2VZeyofD7W99CMLPHI1iKGrA1iMdnkGcmDXd/BToo
         s3p4xYMOEA3jz65+/qIv9llP2GR7KuS7BRga3o0mZ9pxZSvUAyZQGkK0RDUXGGqfUJro
         ylKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686275110; x=1688867110;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2+W0bna42qnZ43tvOf68yFS9Jt1uoq2b6WWLaZ+Rg=;
        b=GiXVHYqjHv9w6CXCVqMQlgryVH3OafFX1mIR/VTLvbLO5SZs0SbTfwVITmyVG39785
         Ije2xQrB7A7gdOPXuuliRSvAsYEOnYOddAMg2GuDG/dVNLoySqIcoW4Si/foCBfaLw/C
         cIY5t2eYAVFsu+4EMtjZ6x5mFsd2DdnEDW2RO0vzBY0N/mcfsHn8GTXJ/2TJffI2zpsT
         kpDostdPkN4aJKDudY61x9PNtpE2KPjfDXixBSH4fBE+XJ9nYD5MaD5HYD4sTyWxtKBj
         z8MahmTxHa2acgEKLgJzk5NDPSV+2jCI+wees6atCjUCoMnTQVHl5GUhWBEVcTy2UX5E
         597Q==
X-Gm-Message-State: AC+VfDwkwPJYdj1yTOS0+8PA+JcAsXwsGi6+PK21Pg+mWeHSq57Xi+RS
        1hVBx8xWJZfmRQJAEaC2p9NYxA==
X-Google-Smtp-Source: ACHHUZ6uvLIOAAtIvmaYvvIxcZjU5faumO4qT6eMLe7uSTWFP55mTra/k3W0VJ0vPQcKSj3TeQZVPw==
X-Received: by 2002:a81:8884:0:b0:569:74f3:fd07 with SMTP id y126-20020a818884000000b0056974f3fd07mr12140ywf.0.1686275109703;
        Thu, 08 Jun 2023 18:45:09 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d63-20020a816842000000b0055a7ff0a5cdsm303405ywc.27.2023.06.08.18.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:45:08 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:45:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 29/32] mm/memory: handle_pte_fault() use
 pte_offset_map_nolock()
In-Reply-To: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
Message-ID: <c1107654-3929-60ac-223e-6877cbb86065@google.com>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle_pte_fault() use pte_offset_map_nolock() to get the vmf.ptl which
corresponds to vmf.pte, instead of pte_lockptr() being used later, when
there's a chance that the pmd entry might have changed, perhaps to none,
or to a huge pmd, with no split ptlock in its struct page.

Remove its pmd_devmap_trans_unstable() call: pte_offset_map_nolock()
will handle that case by failing.  Update the "morph" comment above,
looking forward to when shmem or file collapse to THP may not take
mmap_lock for write (or not at all).

do_numa_page() use the vmf->ptl from handle_pte_fault() at first, but
refresh it when refreshing vmf->pte.

do_swap_page()'s pte_unmap_same() (the thing that takes ptl to verify a
two-part PAE orig_pte) use the vmf->ptl from handle_pte_fault() too; but
do_swap_page() is also used by anon THP's __collapse_huge_page_swapin(),
so adjust that to set vmf->ptl by pte_offset_map_nolock().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/khugepaged.c |  6 ++++--
 mm/memory.c     | 38 +++++++++++++-------------------------
 2 files changed, 17 insertions(+), 27 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 49cfa7cdfe93..c11db2e78e95 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1005,6 +1005,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 	unsigned long address, end = haddr + (HPAGE_PMD_NR * PAGE_SIZE);
 	int result;
 	pte_t *pte = NULL;
+	spinlock_t *ptl;
 
 	for (address = haddr; address < end; address += PAGE_SIZE) {
 		struct vm_fault vmf = {
@@ -1016,7 +1017,7 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 		};
 
 		if (!pte++) {
-			pte = pte_offset_map(pmd, address);
+			pte = pte_offset_map_nolock(mm, pmd, address, &ptl);
 			if (!pte) {
 				mmap_read_unlock(mm);
 				result = SCAN_PMD_NULL;
@@ -1024,11 +1025,12 @@ static int __collapse_huge_page_swapin(struct mm_struct *mm,
 			}
 		}
 
-		vmf.orig_pte = *pte;
+		vmf.orig_pte = ptep_get_lockless(pte);
 		if (!is_swap_pte(vmf.orig_pte))
 			continue;
 
 		vmf.pte = pte;
+		vmf.ptl = ptl;
 		ret = do_swap_page(&vmf);
 		/* Which unmaps pte (after perhaps re-checking the entry) */
 		pte = NULL;
diff --git a/mm/memory.c b/mm/memory.c
index c7b920291a72..4ec46eecefd3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2786,10 +2786,9 @@ static inline int pte_unmap_same(struct vm_fault *vmf)
 	int same = 1;
 #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
 	if (sizeof(pte_t) > sizeof(unsigned long)) {
-		spinlock_t *ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
-		spin_lock(ptl);
+		spin_lock(vmf->ptl);
 		same = pte_same(*vmf->pte, vmf->orig_pte);
-		spin_unlock(ptl);
+		spin_unlock(vmf->ptl);
 	}
 #endif
 	pte_unmap(vmf->pte);
@@ -4696,7 +4695,6 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * validation through pte_unmap_same(). It's of NUMA type but
 	 * the pfn may be screwed if the read is non atomic.
 	 */
-	vmf->ptl = pte_lockptr(vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
 	if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
@@ -4767,8 +4765,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 		flags |= TNF_MIGRATED;
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
-		spin_lock(vmf->ptl);
+		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+					       vmf->address, &vmf->ptl);
+		if (unlikely(!vmf->pte))
+			goto out;
 		if (unlikely(!pte_same(*vmf->pte, vmf->orig_pte))) {
 			pte_unmap_unlock(vmf->pte, vmf->ptl);
 			goto out;
@@ -4897,27 +4897,16 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 		vmf->pte = NULL;
 		vmf->flags &= ~FAULT_FLAG_ORIG_PTE_VALID;
 	} else {
-		/*
-		 * If a huge pmd materialized under us just retry later.  Use
-		 * pmd_trans_unstable() via pmd_devmap_trans_unstable() instead
-		 * of pmd_trans_huge() to ensure the pmd didn't become
-		 * pmd_trans_huge under us and then back to pmd_none, as a
-		 * result of MADV_DONTNEED running immediately after a huge pmd
-		 * fault in a different thread of this mm, in turn leading to a
-		 * misleading pmd_trans_huge() retval. All we have to ensure is
-		 * that it is a regular pmd that we can walk with
-		 * pte_offset_map() and we can do that through an atomic read
-		 * in C, which is what pmd_trans_unstable() provides.
-		 */
-		if (pmd_devmap_trans_unstable(vmf->pmd))
-			return 0;
 		/*
 		 * A regular pmd is established and it can't morph into a huge
-		 * pmd from under us anymore at this point because we hold the
-		 * mmap_lock read mode and khugepaged takes it in write mode.
-		 * So now it's safe to run pte_offset_map().
+		 * pmd by anon khugepaged, since that takes mmap_lock in write
+		 * mode; but shmem or file collapse to THP could still morph
+		 * it into a huge pmd: just retry later if so.
 		 */
-		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
+		vmf->pte = pte_offset_map_nolock(vmf->vma->vm_mm, vmf->pmd,
+						 vmf->address, &vmf->ptl);
+		if (unlikely(!vmf->pte))
+			return 0;
 		vmf->orig_pte = ptep_get_lockless(vmf->pte);
 		vmf->flags |= FAULT_FLAG_ORIG_PTE_VALID;
 
@@ -4936,7 +4925,6 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
-	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
 	if (unlikely(!pte_same(*vmf->pte, entry))) {
-- 
2.35.3

