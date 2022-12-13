Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAAB64B209
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbiLMJOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiLMJM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:12:59 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC215FF0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:11:23 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NWXlL3283zRptt;
        Tue, 13 Dec 2022 17:10:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 13 Dec 2022 17:11:21 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        SeongJae Park <sj@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <damon@lists.linux.dev>, <vishal.moola@gmail.com>,
        <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next 6/8] mm: damon: paddr: convert damon_pa_*() to use folios
Date:   Tue, 13 Dec 2022 17:27:33 +0800
Message-ID: <20221213092735.187924-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
References: <20221213092735.187924-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With damon_get_folio(), let's convert damon_ptep_mkold() and
damon_pmdp_mkold() to use folios.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/damon/paddr.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 6b36de1396a4..95d4686611a5 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -33,17 +33,15 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
 
 static void damon_pa_mkold(unsigned long paddr)
 {
-	struct folio *folio;
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct rmap_walk_control rwc = {
 		.rmap_one = __damon_pa_mkold,
 		.anon_lock = folio_lock_anon_vma_read,
 	};
 	bool need_lock;
 
-	if (!page)
+	if (!folio)
 		return;
-	folio = page_folio(page);
 
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		folio_set_idle(folio);
@@ -93,7 +91,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, 0);
 
 	result->accessed = false;
-	result->page_sz = PAGE_SIZE;
+	result->page_sz = PAGE_SIZE * folio_nr_pages(folio);
 	while (page_vma_mapped_walk(&pvmw)) {
 		addr = pvmw.address;
 		if (pvmw.pte) {
@@ -122,8 +120,7 @@ static bool __damon_pa_young(struct folio *folio, struct vm_area_struct *vma,
 
 static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 {
-	struct folio *folio;
-	struct page *page = damon_get_page(PHYS_PFN(paddr));
+	struct folio *folio = damon_get_folio(PHYS_PFN(paddr));
 	struct damon_pa_access_chk_result result = {
 		.page_sz = PAGE_SIZE,
 		.accessed = false,
@@ -135,9 +132,8 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	};
 	bool need_lock;
 
-	if (!page)
+	if (!folio)
 		return false;
-	folio = page_folio(page);
 
 	if (!folio_mapped(folio) || !folio_raw_mapping(folio)) {
 		if (folio_test_idle(folio))
@@ -205,28 +201,28 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 static unsigned long damon_pa_pageout(struct damon_region *r)
 {
 	unsigned long addr, applied;
-	LIST_HEAD(page_list);
+	LIST_HEAD(folio_list);
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
-		struct page *page = damon_get_page(PHYS_PFN(addr));
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!page)
+		if (!folio)
 			continue;
 
-		ClearPageReferenced(page);
-		test_and_clear_page_young(page);
-		if (isolate_lru_page(page)) {
-			put_page(page);
+		folio_clear_referenced(folio);
+		folio_test_clear_young(folio);
+		if (folio_isolate_lru(folio)) {
+			folio_put(folio);
 			continue;
 		}
-		if (PageUnevictable(page)) {
-			putback_lru_page(page);
+		if (folio_test_unevictable(folio)) {
+			folio_putback_lru(folio);
 		} else {
-			list_add(&page->lru, &page_list);
-			put_page(page);
+			list_add(&folio->lru, &folio_list);
+			folio_put(folio);
 		}
 	}
-	applied = reclaim_pages(&page_list);
+	applied = reclaim_pages(&folio_list);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
@@ -237,12 +233,10 @@ static inline unsigned long damon_pa_mark_accessed_or_deactivate(
 	unsigned long addr, applied = 0;
 
 	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
-		struct page *page = damon_get_page(PHYS_PFN(addr));
-		struct folio *folio;
+		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
 
-		if (!page)
+		if (!folio)
 			continue;
-		folio = page_folio(page);
 
 		if (mark_accessed)
 			folio_mark_accessed(folio);
-- 
2.35.3

