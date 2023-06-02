Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A96871F838
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjFBByd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 21:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjFBBy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 21:54:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A686FC0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 18:54:27 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QXQwn1HnpztQb9;
        Fri,  2 Jun 2023 09:52:09 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 2 Jun 2023 09:54:24 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>
CC:     <muchun.song@linux.dev>, <sidhartha.kumar@oracle.com>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH 2/2] mm/hugetlb: Use a folio in hugetlb_wp()
Date:   Fri, 2 Jun 2023 09:54:08 +0800
Message-ID: <20230602015408.376149-3-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230602015408.376149-1-zhangpeng362@huawei.com>
References: <20230602015408.376149-1-zhangpeng362@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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
old_folio. However, we still need to keep old_page because we need to
know which page in the folio we are copying.

Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/hugetlb.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0b774dd3d57b..f0ab6e8adf6f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5543,6 +5543,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	pte_t pte = huge_ptep_get(ptep);
 	struct hstate *h = hstate_vma(vma);
 	struct page *old_page;
+	struct folio *old_folio;
 	struct folio *new_folio;
 	int outside_reserve = 0;
 	vm_fault_t ret = 0;
@@ -5574,6 +5575,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	old_page = pte_page(pte);
+	old_folio = page_folio(old_page);
 
 	delayacct_wpcopy_start();
 
@@ -5582,7 +5584,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * If no-one else is actually using this page, we're the exclusive
 	 * owner and can reuse this page.
 	 */
-	if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
+	if (page_mapcount(old_page) == 1 && folio_test_anon(old_folio)) {
 		if (!PageAnonExclusive(old_page))
 			page_move_anon_rmap(old_page, vma);
 		if (likely(!unshare))
@@ -5591,8 +5593,8 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		delayacct_wpcopy_end();
 		return 0;
 	}
-	VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
-		       old_page);
+	VM_BUG_ON_PAGE(folio_test_anon(old_folio) &&
+		       PageAnonExclusive(old_page), old_page);
 
 	/*
 	 * If the process that created a MAP_PRIVATE mapping is about to
@@ -5604,10 +5606,10 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -5629,7 +5631,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 			pgoff_t idx;
 			u32 hash;
 
-			put_page(old_page);
+			folio_put(old_folio);
 			/*
 			 * Drop hugetlb_fault_mutex and vma_lock before
 			 * unmapping.  unmapping needs to hold vma_lock
@@ -5674,7 +5676,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_release_all;
 	}
 
-	if (copy_user_large_folio(new_folio, page_folio(old_page), address, vma)) {
+	if (copy_user_large_folio(new_folio, old_folio, address, vma)) {
 		ret = VM_FAULT_HWPOISON_LARGE;
 		goto out_release_all;
 	}
@@ -5703,7 +5705,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
 		set_huge_pte_at(mm, haddr, ptep, newpte);
 		folio_set_hugetlb_migratable(new_folio);
 		/* Make the old page be freed below */
-		new_folio = page_folio(old_page);
+		new_folio = old_folio;
 	}
 	spin_unlock(ptl);
 	mmu_notifier_invalidate_range_end(&range);
@@ -5712,11 +5714,11 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
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

