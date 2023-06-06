Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC6723783
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjFFGVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjFFGVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:21:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C710DE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:20:48 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qb0dN4mG3zLqVB;
        Tue,  6 Jun 2023 14:17:44 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 14:20:45 +0800
From:   Peng Zhang <zhangpeng362@huawei.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>
CC:     <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>, ZhangPeng <zhangpeng362@huawei.com>
Subject: [PATCH v2 3/3] mm/hugetlb: Use a folio in hugetlb_fault()
Date:   Tue, 6 Jun 2023 14:20:13 +0800
Message-ID: <20230606062013.2947002-4-zhangpeng362@huawei.com>
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

We can replace seven implicit calls to compound_head() with one by using
folio.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 mm/hugetlb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e58f8001fd92..e34329e25abe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6062,7 +6062,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	vm_fault_t ret;
 	u32 hash;
 	pgoff_t idx;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	struct folio *pagecache_folio = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
@@ -6181,14 +6181,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * pagecache_folio, so here we need take the former one
 	 * when page != pagecache_folio or !pagecache_folio.
 	 */
-	page = pte_page(entry);
-	if (page_folio(page) != pagecache_folio)
-		if (!trylock_page(page)) {
+	folio = page_folio(pte_page(entry));
+	if (folio != pagecache_folio)
+		if (!folio_trylock(folio)) {
 			need_wait_lock = 1;
 			goto out_ptl;
 		}
 
-	get_page(page);
+	folio_get(folio);
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(entry)) {
@@ -6204,9 +6204,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 						flags & FAULT_FLAG_WRITE))
 		update_mmu_cache(vma, haddr, ptep);
 out_put_page:
-	if (page_folio(page) != pagecache_folio)
-		unlock_page(page);
-	put_page(page);
+	if (folio != pagecache_folio)
+		folio_unlock(folio);
+	folio_put(folio);
 out_ptl:
 	spin_unlock(ptl);
 
@@ -6225,7 +6225,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * here without taking refcount.
 	 */
 	if (need_wait_lock)
-		wait_on_page_locked(page);
+		folio_wait_locked(folio);
 	return ret;
 }
 
-- 
2.25.1

