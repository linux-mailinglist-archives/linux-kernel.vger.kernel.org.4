Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04022670E53
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjARADs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjARADO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:03:14 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60353BD145
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:16:39 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g68so22107027pgc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QYlhvxpn1g/r4dWO5+sPLebA9xNT77jNrSyttGo3dyo=;
        b=j08AWUcIVyI2/yHykLABxKp1sDwWbEofJttmSP3/rw60yRelBsKPqIfY4+/bYgIPxC
         5ynfexqfZiEffFJ5WzTJVnRQaaB9wvKnBE5HA/5VvZr/Q4C+NxxVPvRz2Aj4LUyMbqyp
         ROiePmzKnmm49Em7xPM/47hH6vWeqFb6aFEv7chKTg6fQBxGvD3ClP9cLVVXmStFUSsy
         jjqS8CGg4yibtu21orMKGYOrPW9DdQSLtICy8MB0nRyvGhzCcSvZYeuNO3gjVaV26wEE
         B3mJrW9472YkkUVzWdPV9GJ4KUM/N03MP0Y/F53hIMCLwIC7cQOYuCY7YftWDQYCzQ5I
         Okfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYlhvxpn1g/r4dWO5+sPLebA9xNT77jNrSyttGo3dyo=;
        b=Sy8E6ntsYRFe3KJO9fMnASiLGE7jqnZQBLWlxeQU5+ImJtHBruJsP4KzbbgmatmQnB
         jvB0OoB11HhG/8yDoyJbyU8QAF53eqGv85Y4xzOvg/RI5XY//y79NxfLHU4hc/LKbu6p
         uSzX9Z/a4HRAvZH1RmnzQ+ze/Iw7Sx9saGn/QesI7sYPSxf2nU0Mbwpw65XFJ3ltTKrp
         i5qoS442W89wQe+1VDTJoN9Ub9GFphSj7BSTVAIRdU5FmSbJsPY3Oc4Zx0eo2NOM5J1k
         aGyDwBP5NvzimnJTcnzimiOUiwzWhGiMvaFzV8jL0pEVSPYQsAxZqej/xeJlsGsX0u+I
         cVaA==
X-Gm-Message-State: AFqh2kqJ42Wx6F9mhw/J7j7wNke+SzcbjDRVPUpozOaptjJc+KxXHNuH
        jSFaTtPlvBIOM9827DkwvFs=
X-Google-Smtp-Source: AMrXdXt9femFWM5vCqmpojysBu31yevt6KdvWuuzJnuY+tl/Bw5Cphuw+uWzvw5j8aS/tOWf6OxAbQ==
X-Received: by 2002:a05:6a00:24d4:b0:57e:866d:c095 with SMTP id d20-20020a056a0024d400b0057e866dc095mr6948251pfv.25.1673997398358;
        Tue, 17 Jan 2023 15:16:38 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:27ce:97b5:ee13:dbfe])
        by smtp.gmail.com with ESMTPSA id c24-20020aa79538000000b0057447bb0ddcsm5180965pfp.49.2023.01.17.15.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 15:16:37 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, SeongJae Park <sj@kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 1/3] mm: return the number of pages successfully paged out
Date:   Tue, 17 Jan 2023 15:16:30 -0800
Message-Id: <20230117231632.2734737-1-minchan@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reclaim_pages MADV_PAGEOUT uses needs to return the number of
pages paged-out successfully, not only the number of reclaimed pages
in the operation because those pages paged-out successfully will be
reclaimed easily at the memory pressure due to asynchronous writeback
rotation(i.e., PG_reclaim with folio_rotate_reclaimable).

This patch renames the reclaim_pages with paging_out(with hope that
it's clear from operation point of view) and then adds a additional
stat in reclaim_stat to represent the number of paged-out but kept
in the memory for rotation on writeback completion.

With that stat, madvise_pageout can know how many pages were paged-out
successfully as well as reclaimed. The return value will be used for
statistics in next patch.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/swap.h   |  2 +-
 include/linux/vmstat.h |  1 +
 mm/damon/paddr.c       |  2 +-
 mm/madvise.c           |  4 ++--
 mm/vmscan.c            | 31 ++++++++++++++++++++++---------
 5 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..0ada46b595cd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -435,7 +435,7 @@ extern unsigned long shrink_all_memory(unsigned long nr_pages);
 extern int vm_swappiness;
 long remove_mapping(struct address_space *mapping, struct folio *folio);
 
-extern unsigned long reclaim_pages(struct list_head *page_list);
+extern unsigned int paging_out(struct list_head *page_list);
 #ifdef CONFIG_NUMA
 extern int node_reclaim_mode;
 extern int sysctl_min_unmapped_ratio;
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 19cf5b6892ce..cda903a8fa6e 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -28,6 +28,7 @@ struct reclaim_stat {
 	unsigned nr_writeback;
 	unsigned nr_immediate;
 	unsigned nr_pageout;
+	unsigned nr_pageout_keep;
 	unsigned nr_activate[ANON_AND_FILE];
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index e1a4315c4be6..be2a731d3459 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -226,7 +226,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r)
 			put_page(page);
 		}
 	}
-	applied = reclaim_pages(&page_list);
+	applied = paging_out(&page_list);
 	cond_resched();
 	return applied * PAGE_SIZE;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index c7105ec6d08c..a4a03054ab6b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -400,7 +400,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
-			reclaim_pages(&page_list);
+			paging_out(&page_list);
 		return 0;
 	}
 
@@ -491,7 +491,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	arch_leave_lazy_mmu_mode();
 	pte_unmap_unlock(orig_pte, ptl);
 	if (pageout)
-		reclaim_pages(&page_list);
+		paging_out(&page_list);
 	cond_resched();
 
 	return 0;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..579a7ebbe24a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1933,6 +1933,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				goto activate_locked;
 			case PAGE_SUCCESS:
 				stat->nr_pageout += nr_pages;
+				stat->nr_pageout_keep += nr_pages;
 
 				if (folio_test_writeback(folio))
 					goto keep;
@@ -1948,6 +1949,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 				if (folio_test_dirty(folio) ||
 				    folio_test_writeback(folio))
 					goto keep_locked;
+
+				stat->nr_pageout_keep -= nr_pages;
 				mapping = folio_mapping(folio);
 				fallthrough;
 			case PAGE_CLEAN:
@@ -2646,9 +2649,9 @@ static void shrink_active_list(unsigned long nr_to_scan,
 }
 
 static unsigned int reclaim_folio_list(struct list_head *folio_list,
-				      struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      struct reclaim_stat *stat)
 {
-	struct reclaim_stat dummy_stat;
 	unsigned int nr_reclaimed;
 	struct folio *folio;
 	struct scan_control sc = {
@@ -2659,7 +2662,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &dummy_stat, false);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, stat, false);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2669,15 +2672,23 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 	return nr_reclaimed;
 }
 
-unsigned long reclaim_pages(struct list_head *folio_list)
+/*
+ * paging_out - reclaim clean pages and write dirty pages into storage
+ * @folio_list: pages for paging out
+ *
+ * paging_out() writes dirty pages to backing storage and/or reclaim
+ * clean pages from memory. Returns the number of written/reclaimed pages.
+ */
+unsigned int paging_out(struct list_head *folio_list)
 {
 	int nid;
-	unsigned int nr_reclaimed = 0;
+	unsigned int nr_pageout = 0;
 	LIST_HEAD(node_folio_list);
 	unsigned int noreclaim_flag;
+	struct reclaim_stat stat;
 
 	if (list_empty(folio_list))
-		return nr_reclaimed;
+		return nr_pageout;
 
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -2691,15 +2702,17 @@ unsigned long reclaim_pages(struct list_head *folio_list)
 			continue;
 		}
 
-		nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+		nr_pageout += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), &stat);
+		nr_pageout += stat.nr_pageout_keep;
 		nid = folio_nid(lru_to_folio(folio_list));
 	} while (!list_empty(folio_list));
 
-	nr_reclaimed += reclaim_folio_list(&node_folio_list, NODE_DATA(nid));
+	nr_pageout += reclaim_folio_list(&node_folio_list, NODE_DATA(nid), &stat);
+	nr_pageout += stat.nr_pageout_keep;
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
-	return nr_reclaimed;
+	return nr_pageout;
 }
 
 static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
-- 
2.39.0.314.g84b9a713c41-goog

