Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B32270F1EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbjEXJNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEXJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:13:53 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9353593
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:13:50 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTP id 34O9DADV076637;
        Wed, 24 May 2023 17:13:10 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from bj03382pcu.spreadtrum.com (10.0.73.76) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 24 May 2023 17:13:10 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: [PATCH] mm: deduct the number of pages reclaimed by madvise from workingset
Date:   Wed, 24 May 2023 17:12:54 +0800
Message-ID: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.76]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 34O9DADV076637
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

The pages reclaimed by madvise_pageout are made of inactive and dropped from LRU
forcefully, which lead to the coming up refault pages possess a large refault
distance than it should be. These could affect the accuracy of thrashing when
madvise_pageout is used as a common way of memory reclaiming as ANDROID does now.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/swap.h | 2 +-
 mm/madvise.c         | 4 ++--
 mm/vmscan.c          | 8 +++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2787b84..0312142 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -428,7 +428,7 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
 extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
 
-extern unsigned long reclaim_pages(struct list_head *page_list);
+extern unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *page_list);
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
diff --git a/mm/madvise.c b/mm/madvise.c
index b6ea204..61c8d7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -420,7 +420,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&page_list);
+			reclaim_pages(mm, &page_list);
 		return 0;
 	}
 
@@ -516,7 +516,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
-		reclaim_pages(&page_list);
+		reclaim_pages(mm, &page_list);
 	cond_resched();
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 20facec..048c10b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2741,12 +2741,14 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *folio_list)
 {
 	int nid;
 	unsigned int nr_reclaimed = 0;
 	LIST_HEAD(node_folio_list);
 	unsigned int noreclaim_flag;
+	struct lruvec *lruvec;
+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
 
 	if (list_empty(folio_list))
 		return nr_reclaimed;
@@ -2764,10 +2766,14 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 		}
 
 		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		lruvec = &memcg->nodeinfo[nid]->lruvec;
+		workingset_age_nonresident(lruvec, -nr_reclaimed);
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
 	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	lruvec = &memcg->nodeinfo[nid]->lruvec;
+	workingset_age_nonresident(lruvec, -nr_reclaimed);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-- 
1.9.1

