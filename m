Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E59723784
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbjFFGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbjFFGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A85510DA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:20:47 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb0dM5ppgzLqV2;
        Tue,  6 Jun 2023 14:17:43 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 14:20:44 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>
CC:     <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/3] mm/hugetlb: Use a folio in hugetlb_wp()
Date:   Tue, 6 Jun 2023 14:20:12 +0800
Message-ID: <20230606062013.2947002-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230606062013.2947002-1-zhangpeng362@huawei.com>
References: <20230606062013.2947002-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangPeng <zhangpeng362@huawei.com>

We can replace nine implict calls to compound_head() with one by using
old_folio. The page we get back is always a head page, so we just
convert old_page to old_folio.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 mm/hugetlb.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d6f6d19958a5..e58f8001fd92 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5540,7 +5540,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	const bool unshare = flags & FAULT_FLAG_UNSHARE;
 	pte_t pte = huge_ptep_get(ptep);
 	struct hstate *h = hstate_vma(vma);
-	struct page *old_page;
+	struct folio *old_folio;
 	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
@@ -5571,7 +5571,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 	}
 
-	old_page = pte_page(pte);
+	old_folio = page_folio(pte_page(pte));
 
 	delayacct_wpcopy_start();
 
@@ -5580,17 +5580,17 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * If no-one else is actually using this page, we're the exclusive
 	 * owner and can reuse this page.
 	 */
-	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
-		if (!PageAnonExclusive(old_page))
-			page_move_anon_rmap(old_page, vma);
+	if (folio_mapcount(old_folio) == 1 && folio_test_anon(old_folio)) {
+		if (!PageAnonExclusive(&old_folio->page))
+			page_move_anon_rmap(&old_folio->page, vma);
 		if (likely(!unshare))
 			set_huge_ptep_writable(vma, haddr, ptep);
 
 		delayacct_wpcopy_end();
 		return 0;
 	}
-	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
-		       old_page);
+	VM_BUG_ON_PAGE(folio_test_anon(old_folio) &&
+		       PageAnonExclusive(&old_folio->page), &old_folio->page);
 
 	/*
 	 * If the process that created a MAP_PRIVATE mapping is about to
@@ -5602,10 +5602,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * of the full address range.
 	 */
 	if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
-			page_folio(old_page) != pagecache_folio)
+			old_folio != pagecache_folio)
 		outside_reserve = 1;
 
-	get_page(old_page);
+	folio_get(old_folio);
 
 	/*
 	 * Drop page table lock as buddy allocator may be called. It will
@@ -5627,7 +5627,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			pgoff_t idx;
 			u32 hash;
 
-			put_page(old_page);
+			folio_put(old_folio);
 			/*
 			 * Drop hugetlb_fault_mutex and vma_lock before
 			 * unmapping.  unmapping needs to hold vma_lock
@@ -5642,7 +5642,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 
-			unmap_ref_private(mm, vma, old_page, haddr);
+			unmap_ref_private(mm, vma, &old_folio->page, haddr);
 
 			mutex_lock(&hugetlb_fault_mutex_table[hash]);
 			hugetlb_vma_lock_read(vma);
@@ -5672,7 +5672,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	if (copy_user_large_folio(new_folio, page_folio(old_page), address, vma)) {
+	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
 		ret = VM_FAULT_HWPOISON_LARGE;
 		goto out_release_all;
 	}
@@ -5694,14 +5694,14 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Break COW or unshare */
 		huge_ptep_clear_flush(vma, haddr, ptep);
 		mmu_notifier_invalidate_range(mm, range.start, range.end);
-		page_remove_rmap(old_page, vma, true);
+		page_remove_rmap(&old_folio->page, vma, true);
 		hugepage_add_new_anon_rmap(new_folio, vma, haddr);
 		if (huge_pte_uffd_wp(pte))
 			newpte = huge_pte_mkuffd_wp(newpte);
 		set_huge_pte_at(mm, haddr, ptep, newpte);
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
-		new_folio = page_folio(old_page);
+		new_folio = old_folio;
 	}
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
@@ -5710,11 +5710,11 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * No restore in case of successful pagetable update (Break COW or
 	 * unshare)
 	 */
-	if (new_folio != page_folio(old_page))
+	if (new_folio != old_folio)
 		restore_reserve_on_error(h, vma, haddr, new_folio);
 	folio_put(new_folio);
 out_release_old:
-	put_page(old_page);
+	folio_put(old_folio);
 
 	spin_lock(ptl); /* Caller expects lock to be held */
 
-- 
2.25.1

