Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2137707ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjERLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjERLHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:07:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15F3BB8
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 04:07:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B791D75;
        Thu, 18 May 2023 04:08:26 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427773F793;
        Thu, 18 May 2023 04:07:40 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Subject: [PATCH v2 2/5] mm: damon must atomically clear young on ptes and pmds
Date:   Thu, 18 May 2023 12:07:24 +0100
Message-Id: <20230518110727.2106156-3-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518110727.2106156-1-ryan.roberts@arm.com>
References: <20230518110727.2106156-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is racy to non-atomically read a pte, then clear the young bit, then
write it back as this could discard dirty information. Further, it is
bad practice to directly set a pte entry within a table. Instead
clearing young must go through the arch-provided helper,
ptep_test_and_clear_young() to ensure it is modified atomically and to
give the arch code visibility and allow it to check (and potentially
modify) the operation.

Fixes: 46c3a0accdc4 ("mm/damon/vaddr: separate commonly usable functions")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
---
 mm/damon/ops-common.c | 16 ++++++----------
 mm/damon/ops-common.h |  4 ++--
 mm/damon/paddr.c      |  4 ++--
 mm/damon/vaddr.c      |  4 ++--
 4 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index cc63cf953636..acc264b97903 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -37,7 +37,7 @@ struct folio *damon_get_folio(unsigned long pfn)
 	return folio;
 }
 
-void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr)
 {
 	bool referenced = false;
 	struct folio *folio = damon_get_folio(pte_pfn(*pte));
@@ -45,13 +45,11 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 	if (!folio)
 		return;
 
-	if (pte_young(*pte)) {
+	if (ptep_test_and_clear_young(vma, addr, pte))
 		referenced = true;
-		*pte = pte_mkold(*pte);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
+	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
@@ -62,7 +60,7 @@ void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr)
 	folio_put(folio);
 }
 
-void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	bool referenced = false;
@@ -71,13 +69,11 @@ void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr)
 	if (!folio)
 		return;
 
-	if (pmd_young(*pmd)) {
+	if (pmdp_test_and_clear_young(vma, addr, pmd))
 		referenced = true;
-		*pmd = pmd_mkold(*pmd);
-	}
 
 #ifdef CONFIG_MMU_NOTIFIER
-	if (mmu_notifier_clear_young(mm, addr, addr + HPAGE_PMD_SIZE))
+	if (mmu_notifier_clear_young(vma->vm_mm, addr, addr + HPAGE_PMD_SIZE))
 		referenced = true;
 #endif /* CONFIG_MMU_NOTIFIER */
 
diff --git a/mm/damon/ops-common.h b/mm/damon/ops-common.h
index 14f4bc69f29b..18d837d11bce 100644
--- a/mm/damon/ops-common.h
+++ b/mm/damon/ops-common.h
@@ -9,8 +9,8 @@
 
 struct folio *damon_get_folio(unsigned long pfn);
 
-void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
-void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
+void damon_ptep_mkold(pte_t *pte, struct vm_area_struct *vma, unsigned long addr);
+void damon_pmdp_mkold(pmd_t *pmd, struct vm_area_struct *vma, unsigned long addr);
 
 int damon_cold_score(struct damon_ctx *c, struct damon_region *r,
 			struct damos *s);
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 467b99166b43..5b3a3463d078 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -24,9 +24,9 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte)
-			damon_ptep_mkold(pvmw.pte, vma->vm_mm, addr);
+			damon_ptep_mkold(pvmw.pte, vma, addr);
 		else
-			damon_pmdp_mkold(pvmw.pmd, vma->vm_mm, addr);
+			damon_pmdp_mkold(pvmw.pmd, vma, addr);
 	}
 	return true;
 }
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 1fec16d7263e..37994fb6120c 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -311,7 +311,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 		}
 
 		if (pmd_trans_huge(*pmd)) {
-			damon_pmdp_mkold(pmd, walk->mm, addr);
+			damon_pmdp_mkold(pmd, walk->vma, addr);
 			spin_unlock(ptl);
 			return 0;
 		}
@@ -323,7 +323,7 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
 	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
 	if (!pte_present(*pte))
 		goto out;
-	damon_ptep_mkold(pte, walk->mm, addr);
+	damon_ptep_mkold(pte, walk->vma, addr);
 out:
 	pte_unmap_unlock(pte, ptl);
 	return 0;
-- 
2.25.1

