Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2258A70B48A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjEVF0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjEVF0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:26:46 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBCFA8
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:26:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso8190201276.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684733204; x=1687325204;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2+W0bna42qnZ43tvOf68yFS9Jt1uoq2b6WWLaZ+Rg=;
        b=pmFZ8eUZ5rWyUxNcjOAbP+PUX2zOF/4/kxaRJz4z7PKZCL9sh91Sp1fz2BDSpLA8va
         PshjIXySjEbJBMm+E5T0DV3GV1KfmGHUHW7NoxKfPJtzpKWDj4nZyySG6hAbDZeMssbe
         CpZvDb9v4tBFY4XeT7TABIe79HTh891UxQUA304GYCwmuhQf0Ddrievqmcn4LZJQZqo+
         AyQ3f5iFkop7qEDUFMOD3A4f3L3NVlS89hjrz223HyzYGxeKrVNBksEbzG6kBQ75cK67
         0udH2XswWGkcnuzDyqRllpE286zOHOwA3ju/MkmzjXbIYSmo/1Xbs4kh16I1DKzJVpox
         VJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684733204; x=1687325204;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6V2+W0bna42qnZ43tvOf68yFS9Jt1uoq2b6WWLaZ+Rg=;
        b=SLjp1DXd5GogZ6IBSNoErJXShZSId/X3GPp9UjFnmyXFjdir+LmVLz6Pb+e/pjUdVt
         Zf+KZCFbhWxngbMpdIQQaS0TyjLQB2iCJSTfHO0N5LGiDzV7Y9tZqcG8p6iC8OA81A31
         g/0eyNnotTtQcXB7WaWXSG/513oyHwtb8BJFsM9ztCOFFtCr62YBQn76zXcNVFGTQfql
         5Q3caVFG7FXMP/22J+NrNM6aQSEBO8yGlzX4WhgTCaE2m8mi5o0qN6di9BzpzV1CbcNN
         1XxaQSCBoXJhPb1OpuLYHU29CT7WujF23+0cRZXLIqSU0WqrcE1DA3SELJMgA1e11NMS
         gV2A==
X-Gm-Message-State: AC+VfDx5vVYshF3OyGDoNE1+ZcS3h5yKbeW6veR2Fjca1YyLtlHqQLwL
        MRz2dv+zSkai+hy9qqtlUKLJQw==
X-Google-Smtp-Source: ACHHUZ6vQMBkQllrmMVkhqi7UHm68ru97kbfrpxbzO+74u3FaXGIYp1Xs+So1aiUfDsa50JYfZkYNw==
X-Received: by 2002:a81:9383:0:b0:55a:7c7:c756 with SMTP id k125-20020a819383000000b0055a07c7c756mr11286138ywg.31.1684733204133;
        Sun, 21 May 2023 22:26:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d206-20020a814fd7000000b0054605c23114sm1832452ywb.66.2023.05.21.22.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 22:26:43 -0700 (PDT)
Date:   Sun, 21 May 2023 22:26:40 -0700 (PDT)
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
Subject: [PATCH 29/31] mm/memory: handle_pte_fault() use
 pte_offset_map_nolock()
In-Reply-To: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
Message-ID: <5f10e87-c413-eb92-fc6-541e52c1f6be@google.com>
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
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

