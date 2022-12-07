Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B5C6451E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiLGCRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLGCRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:17:46 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80D69FF2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:17:38 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRgrt6V4YzRpRj;
        Wed,  7 Dec 2022 10:16:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 10:17:36 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/2] mm: swap: Convert mark_page_lazyfree() to mark_folio_lazyfree()
Date:   Wed, 7 Dec 2022 10:34:31 +0800
Message-ID: <20221207023431.151008-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
References: <20221207023431.151008-1-wangkefeng.wang@huawei.com>
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

mark_page_lazyfree() and the callers are converted to use folio,
this rename and make it to take in a folio argument instead of
calling page_folio().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/swap.h |  2 +-
 mm/huge_memory.c     |  2 +-
 mm/madvise.c         |  2 +-
 mm/swap.c            | 12 +++++-------
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2787b84eaf12..ae4e8f0d9951 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -402,7 +402,7 @@ extern void lru_add_drain_cpu(int cpu);
 extern void lru_add_drain_cpu_zone(struct zone *zone);
 extern void lru_add_drain_all(void);
 extern void deactivate_page(struct page *page);
-extern void mark_page_lazyfree(struct page *page);
+extern void mark_folio_lazyfree(struct folio *folio);
 extern void swap_setup(void);
 
 extern void lru_cache_add_inactive_or_unevictable(struct page *page,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6e76c770529b..91e149a11f2d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1660,7 +1660,7 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 	}
 
-	mark_page_lazyfree(&folio->page);
+	mark_folio_lazyfree(folio);
 	ret = true;
 out:
 	spin_unlock(ptl);
diff --git a/mm/madvise.c b/mm/madvise.c
index 09bb97f118ac..7ae1743b67c1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -727,7 +727,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			set_pte_at(mm, addr, pte, ptent);
 			tlb_remove_tlb_entry(tlb, pte, addr);
 		}
-		mark_page_lazyfree(&folio->page);
+		mark_folio_lazyfree(folio);
 	}
 out:
 	if (nr_swap) {
diff --git a/mm/swap.c b/mm/swap.c
index 70e2063ef43a..a6046cd5f3a2 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -757,16 +757,14 @@ void deactivate_page(struct page *page)
 }
 
 /**
- * mark_page_lazyfree - make an anon page lazyfree
- * @page: page to deactivate
+ * mark_folio_lazyfree - make an anon folio lazyfree
+ * @folio: folio to deactivate
  *
- * mark_page_lazyfree() moves @page to the inactive file list.
- * This is done to accelerate the reclaim of @page.
+ * mark_folio_lazyfree() moves @folio to the inactive file list.
+ * This is done to accelerate the reclaim of @folio.
  */
-void mark_page_lazyfree(struct page *page)
+void mark_folio_lazyfree(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
-
 	if (folio_test_lru(folio) && folio_test_anon(folio) &&
 	    folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
 	    !folio_test_unevictable(folio)) {
-- 
2.35.3

