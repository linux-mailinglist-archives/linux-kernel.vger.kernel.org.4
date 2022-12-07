Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BE46451DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLGCRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLGCRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:17:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9789582
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:17:38 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRgrw3SjtzJqHf;
        Wed,  7 Dec 2022 10:16:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 10:17:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] mm: huge_memory: Convert madvise_free_huge_pmd to use a folio
Date:   Wed, 7 Dec 2022 10:34:30 +0800
Message-ID: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using folios instead of pages removes several calls to compound_head(),

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/huge_memory.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index abe6cfd92ffa..6e76c770529b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1603,7 +1603,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 {
 	spinlock_t *ptl;
 	pmd_t orig_pmd;
-	struct page *page;
+	struct folio *folio;
 	struct mm_struct *mm = tlb->mm;
 	bool ret = false;
 
@@ -1623,15 +1623,15 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		goto out;
 	}
 
-	page = pmd_page(orig_pmd);
+	folio = pfn_folio(pmd_pfn(orig_pmd));
 	/*
-	 * If other processes are mapping this page, we couldn't discard
-	 * the page unless they all do MADV_FREE so let's skip the page.
+	 * If other processes are mapping this folio, we couldn't discard
+	 * the folio unless they all do MADV_FREE so let's skip the folio.
 	 */
-	if (total_mapcount(page) != 1)
+	if (folio_mapcount(folio) != 1)
 		goto out;
 
-	if (!trylock_page(page))
+	if (!folio_trylock(folio))
 		goto out;
 
 	/*
@@ -1639,17 +1639,17 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	 * will deactivate only them.
 	 */
 	if (next - addr != HPAGE_PMD_SIZE) {
-		get_page(page);
+		folio_get(folio);
 		spin_unlock(ptl);
-		split_huge_page(page);
-		unlock_page(page);
-		put_page(page);
+		split_folio(folio);
+		folio_unlock(folio);
+		folio_put(folio);
 		goto out_unlocked;
 	}
 
-	if (PageDirty(page))
-		ClearPageDirty(page);
-	unlock_page(page);
+	if (folio_test_dirty(folio))
+		folio_clear_dirty(folio);
+	folio_unlock(folio);
 
 	if (pmd_young(orig_pmd) || pmd_dirty(orig_pmd)) {
 		pmdp_invalidate(vma, addr, pmd);
@@ -1660,7 +1660,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	}
 
-	mark_page_lazyfree(page);
+	mark_page_lazyfree(&folio->page);
 	ret = true;
 out:
 	spin_unlock(ptl);
-- 
2.35.3

