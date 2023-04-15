Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297DD6E2FF2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 11:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjDOJJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDOJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:09:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A747D84
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 02:08:58 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pz6t04rShzJrRL;
        Sat, 15 Apr 2023 17:08:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 15 Apr 2023 17:08:55 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm: rename reclaim_pages() to reclaim_folios()
Date:   Sat, 15 Apr 2023 17:27:16 +0800
Message-ID: <20230415092716.61970-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As commit a83f0551f496 ("mm/vmscan: convert reclaim_pages() to use
a folio") changes the arg from page_list to folio_list, but not
the defination, let's correct it and rename it to reclaim_folios too.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/swap.h | 2 +-
 mm/damon/paddr.c     | 2 +-
 mm/madvise.c         | 4 ++--
 mm/shmem.c           | 4 ++--
 mm/vmscan.c          | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7f7d5b9ddf7e..8c8c6ceaa462 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -442,7 +442,7 @@ extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
 
-extern unsigned long reclaim_pages(struct list_head *page_list);
+unsigned long reclaim_folios(struct list_head *folio_list);
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dd9c33fbe805..840d25ad9e59 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -255,7 +255,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 			list_add(&folio->lru, &folio_list);
 		folio_put(folio);
 	}
-	applied = reclaim_pages(&folio_list);
+	applied = reclaim_folios(&folio_list);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..bfc683de85ef 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -417,7 +417,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&folio_list);
+			reclaim_folios(&folio_list);
 		return 0;
 	}
 
@@ -513,7 +513,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
-		reclaim_pages(&folio_list);
+		reclaim_folios(&folio_list);
 	cond_resched();
 
 	return 0;
diff --git a/mm/shmem.c b/mm/shmem.c
index 16378b281a5d..bdb2948a149f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2381,7 +2381,7 @@ static void shmem_isolate_pages_range(struct address_space *mapping, loff_t star
 		folio_put(folio);
 
 		/*
-		 * Prepare the folios to be passed to reclaim_pages().
+		 * Prepare the folios to be passed to reclaim_folios().
 		 * VM can't reclaim a folio unless young bit is
 		 * cleared in its flags.
 		 */
@@ -2406,7 +2406,7 @@ static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
 
 	lru_add_drain();
 	shmem_isolate_pages_range(mapping, start, end, &folio_list);
-	reclaim_pages(&folio_list);
+	reclaim_folios(&folio_list);
 
 	return 0;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2cd21e1d5849..b218c8a6244f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2786,7 +2786,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+unsigned long reclaim_folios(struct list_head *folio_list)
 {
 	int nid;
 	unsigned int nr_reclaimed = 0;
-- 
2.35.3

