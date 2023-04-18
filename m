Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E36E6CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjDRTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjDRTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:08 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17036C176
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:48 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id fy11so5948237qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845227; x=1684437227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcOWVPTnlhnbqqS83iZRHWvw9Z/GKVYeqba03KhzlhU=;
        b=a/1OWmR/tUcWE2Qqj1o11ZW4UdowGBE3dveFmCmMXs2fzxld+GikzPbYsZnkzQUhO1
         rszkmym7seH29zcw8ulr+qDK26L0PsIcj2vrordWVhv4mNV7cpWqWuY5SQHsZw8z7mao
         4Z/ONsQuuhKfFYEQ6RM3cdDgMfZH06DbmKmGbAFpl8E2Vd0qVeQ9k1m0bs22PIP//Pjj
         y/MIXkHHsDsENio2rDHGldHoYX51Hv15DAGeCwg3O+QTHInV8nsPqRyC21NUdBPxr8kG
         g6o0GlmUWbBX6RAAFG5tpS7kEnZq+h52JP5HlzaOA46WT6u1sWU3NzgkrM0ulNQCm7Q9
         Iynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845227; x=1684437227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcOWVPTnlhnbqqS83iZRHWvw9Z/GKVYeqba03KhzlhU=;
        b=UjoE2wWrnWZq4a7jkz8ULEPiX0vR3qNP/3ky9Qiq7vh1dR5K/MCKJyCbTs96B0QBm8
         2TnDyxHcTRfjxRCxslSkBxJiLwlDtQJLhtyEzlU1QSO+aKtIY/E7dROEPiUi2XZmdaEj
         bie5aLyPcz0Q2927nF5Ihb+rpEI2W/pi56cDYZEcWW+1Vg0/5UVGir4IYPmtv66brP5z
         aYBw/EetyVKrsN5PGWjfVQyn67eC5EwfdlXCHAuV6wPCZ4npszmde4LUnv6PtQtgEHLD
         g88vrDZ4s3lfjT8JjYvQrcnAW7WUsRts8ugP0DBAKg/jM59DjEGBpzyk6YCnmPz3ITke
         uiAg==
X-Gm-Message-State: AAQBX9flRljcvfxVZeBBj4YHCysIddOBLj5nY0PjrfCBm/a+ttTlY1fi
        cqFpCFzPd293GfIcCwNCmny5Cg==
X-Google-Smtp-Source: AKy350aQbCigm5jEeHDFUL4OtIuD38+nxMH8T2pdMpNgffiiQpVWw2yOWVdgL1WnHxicR6IJsCf4vw==
X-Received: by 2002:a05:622a:1996:b0:3e6:71d6:5d5d with SMTP id u22-20020a05622a199600b003e671d65d5dmr1822298qtc.1.1681845227071;
        Tue, 18 Apr 2023 12:13:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id g18-20020ac85812000000b003ef189ffa82sm2022876qtg.90.2023.04.18.12.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:46 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 24/26] mm: page_alloc: kill watermark boosting
Date:   Tue, 18 Apr 2023 15:13:11 -0400
Message-Id: <20230418191313.268131-25-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Watermark boosting is meant to increase the chances of pageblock
production when fallbacks are observed. Since reclaim/compaction now
produce neutral pageblocks per default, this is no longer needed.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/sysctl/vm.rst |  21 -----
 include/linux/mm.h                      |   1 -
 include/linux/mmzone.h                  |  12 +--
 kernel/sysctl.c                         |   8 --
 mm/page_alloc.c                         |  67 --------------
 mm/vmscan.c                             | 111 +-----------------------
 mm/vmstat.c                             |   2 -
 7 files changed, 7 insertions(+), 215 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 988f6a4c8084..498655c322bc 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -72,7 +72,6 @@ files can be found in mm/swap.c.
 - unprivileged_userfaultfd
 - user_reserve_kbytes
 - vfs_cache_pressure
-- watermark_boost_factor
 - watermark_scale_factor
 - zone_reclaim_mode
 
@@ -968,26 +967,6 @@ directory and inode objects. With vfs_cache_pressure=1000, it will look for
 ten times more freeable objects than there are.
 
 
-watermark_boost_factor
-======================
-
-This factor controls the level of reclaim when memory is being fragmented.
-It defines the percentage of the high watermark of a zone that will be
-reclaimed if pages of different mobility are being mixed within pageblocks.
-The intent is that compaction has less work to do in the future and to
-increase the success rate of future high-order allocations such as SLUB
-allocations, THP and hugetlbfs pages.
-
-To make it sensible with respect to the watermark_scale_factor
-parameter, the unit is in fractions of 10,000. The default value of
-15,000 means that up to 150% of the high watermark will be reclaimed in the
-event of a pageblock being mixed due to fragmentation. The level of reclaim
-is determined by the number of fragmentation events that occurred in the
-recent past. If this value is smaller than a pageblock then a pageblocks
-worth of pages will be reclaimed (e.g.  2MB on 64-bit x86). A boost factor
-of 0 will disable the feature.
-
-
 watermark_scale_factor
 ======================
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f13f20258ce9..e7c2631848ed 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2746,7 +2746,6 @@ extern void setup_per_cpu_pageset(void);
 
 /* page_alloc.c */
 extern int min_free_kbytes;
-extern int watermark_boost_factor;
 extern int watermark_scale_factor;
 extern bool arch_has_descending_max_zone_pfns(void);
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index c705f2f7c829..1363ff6caff3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -567,10 +567,10 @@ enum zone_watermarks {
 #define NR_LOWORDER_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1))
 #define NR_PCP_LISTS (NR_LOWORDER_PCP_LISTS + NR_PCP_THP)
 
-#define min_wmark_pages(z) (z->_watermark[WMARK_MIN] + z->watermark_boost)
-#define low_wmark_pages(z) (z->_watermark[WMARK_LOW] + z->watermark_boost)
-#define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
-#define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
+#define min_wmark_pages(z) (z->_watermark[WMARK_MIN])
+#define low_wmark_pages(z) (z->_watermark[WMARK_LOW])
+#define high_wmark_pages(z) (z->_watermark[WMARK_HIGH])
+#define wmark_pages(z, i) (z->_watermark[i])
 
 /* Fields and list protected by pagesets local_lock in page_alloc.c */
 struct per_cpu_pages {
@@ -709,7 +709,6 @@ struct zone {
 
 	/* zone watermarks, access with *_wmark_pages(zone) macros */
 	unsigned long _watermark[NR_WMARK];
-	unsigned long watermark_boost;
 
 	/*
 	 * We don't know if the memory that we're going to allocate will be
@@ -884,9 +883,6 @@ enum pgdat_flags {
 };
 
 enum zone_flags {
-	ZONE_BOOSTED_WATERMARK,		/* zone recently boosted watermarks.
-					 * Cleared when kswapd is woken.
-					 */
 	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
 };
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 137d4abe3eda..68bcd3a7c9c6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2229,14 +2229,6 @@ static struct ctl_table vm_table[] = {
 		.proc_handler	= min_free_kbytes_sysctl_handler,
 		.extra1		= SYSCTL_ZERO,
 	},
-	{
-		.procname	= "watermark_boost_factor",
-		.data		= &watermark_boost_factor,
-		.maxlen		= sizeof(watermark_boost_factor),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-	},
 	{
 		.procname	= "watermark_scale_factor",
 		.data		= &watermark_scale_factor,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e8ae04feb1bd..f835a5548164 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -401,7 +401,6 @@ compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
 
 int min_free_kbytes = 1024;
 int user_min_free_kbytes = -1;
-int watermark_boost_factor __read_mostly = 15000;
 int watermark_scale_factor = 10;
 
 static unsigned long nr_kernel_pages __initdata;
@@ -2742,43 +2741,6 @@ static bool can_steal_fallback(unsigned int order, int start_mt,
 	return false;
 }
 
-static inline bool boost_watermark(struct zone *zone)
-{
-	unsigned long max_boost;
-
-	if (!watermark_boost_factor)
-		return false;
-	/*
-	 * Don't bother in zones that are unlikely to produce results.
-	 * On small machines, including kdump capture kernels running
-	 * in a small area, boosting the watermark can cause an out of
-	 * memory situation immediately.
-	 */
-	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
-		return false;
-
-	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
-			watermark_boost_factor, 10000);
-
-	/*
-	 * high watermark may be uninitialised if fragmentation occurs
-	 * very early in boot so do not boost. We do not fall
-	 * through and boost by pageblock_nr_pages as failing
-	 * allocations that early means that reclaim is not going
-	 * to help and it may even be impossible to reclaim the
-	 * boosted watermark resulting in a hang.
-	 */
-	if (!max_boost)
-		return false;
-
-	max_boost = max(pageblock_nr_pages, max_boost);
-
-	zone->watermark_boost = min(zone->watermark_boost + pageblock_nr_pages,
-		max_boost);
-
-	return true;
-}
-
 /*
  * This function implements actual steal behaviour. If order is large enough,
  * we can steal whole pageblock. If not, we first move freepages in this
@@ -2802,14 +2764,6 @@ static void steal_suitable_fallback(struct zone *zone, struct page *page,
 		goto single_page;
 	}
 
-	/*
-	 * Boost watermarks to increase reclaim pressure to reduce the
-	 * likelihood of future fallbacks. Wake kswapd now as the node
-	 * may be balanced overall and kswapd will not wake naturally.
-	 */
-	if (boost_watermark(zone) && (alloc_flags & ALLOC_KSWAPD))
-		set_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
-
 	/* We are not allowed to try stealing from the whole block */
 	if (!whole_block)
 		goto single_page;
@@ -3738,12 +3692,6 @@ struct page *rmqueue(struct zone *preferred_zone,
 							migratetype);
 
 out:
-	/* Separate test+clear to avoid unnecessary atomics */
-	if (unlikely(test_bit(ZONE_BOOSTED_WATERMARK, &zone->flags))) {
-		clear_bit(ZONE_BOOSTED_WATERMARK, &zone->flags);
-		wakeup_kswapd(zone, 0, 0, zone_idx(zone));
-	}
-
 	VM_BUG_ON_PAGE(page && bad_range(zone, page), page);
 	return page;
 }
@@ -3976,18 +3924,6 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
 					free_pages))
 		return true;
-	/*
-	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
-	 * when checking the min watermark. The min watermark is the
-	 * point where boosting is ignored so that kswapd is woken up
-	 * when below the low watermark.
-	 */
-	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
-		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
-		mark = z->_watermark[WMARK_MIN];
-		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
-					alloc_flags, free_pages);
-	}
 
 	return false;
 }
@@ -6137,7 +6073,6 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 			" free_movable:%lukB"
 			" free_reclaimable:%lukB"
 			" free_free:%lukB"
-			" boost:%lukB"
 			" min:%lukB"
 			" low:%lukB"
 			" high:%lukB"
@@ -6161,7 +6096,6 @@ void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_i
 			K(zone_page_state(zone, NR_FREE_MOVABLE)),
 			K(zone_page_state(zone, NR_FREE_RECLAIMABLE)),
 			K(zone_page_state(zone, NR_FREE_FREE)),
-			K(zone->watermark_boost),
 			K(min_wmark_pages(zone)),
 			K(low_wmark_pages(zone)),
 			K(high_wmark_pages(zone)),
@@ -8701,7 +8635,6 @@ static void __setup_per_zone_wmarks(void)
 		if (IS_ENABLED(CONFIG_COMPACTION))
 			tmp = ALIGN(tmp, 1 << pageblock_order);
 
-		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = low_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_PROMO] = high_wmark_pages(zone) + tmp;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7374cd6fe91..5586be6997cd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6827,30 +6827,6 @@ static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 	} while (memcg);
 }
 
-static bool pgdat_watermark_boosted(pg_data_t *pgdat, int highest_zoneidx)
-{
-	int i;
-	struct zone *zone;
-
-	/*
-	 * Check for watermark boosts top-down as the higher zones
-	 * are more likely to be boosted. Both watermarks and boosts
-	 * should not be checked at the same time as reclaim would
-	 * start prematurely when there is no boosting and a lower
-	 * zone is balanced.
-	 */
-	for (i = highest_zoneidx; i >= 0; i--) {
-		zone = pgdat->node_zones + i;
-		if (!managed_zone(zone))
-			continue;
-
-		if (zone->watermark_boost)
-			return true;
-	}
-
-	return false;
-}
-
 /*
  * Returns true if there is an eligible zone balanced for the request order
  * and highest_zoneidx
@@ -7025,14 +7001,13 @@ static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	unsigned long nr_soft_reclaimed;
 	unsigned long nr_soft_scanned;
 	unsigned long pflags;
-	unsigned long nr_boost_reclaim;
-	unsigned long zone_boosts[MAX_NR_ZONES] = { 0, };
-	bool boosted;
 	struct zone *zone;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.may_swap = 1,
+		.may_writepage = !laptop_mode,
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
@@ -7041,29 +7016,11 @@ static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 
 	count_vm_event(PAGEOUTRUN);
 
-	/*
-	 * Account for the reclaim boost. Note that the zone boost is left in
-	 * place so that parallel allocations that are near the watermark will
-	 * stall or direct reclaim until kswapd is finished.
-	 */
-	nr_boost_reclaim = 0;
-	for (i = 0; i <= highest_zoneidx; i++) {
-		zone = pgdat->node_zones + i;
-		if (!managed_zone(zone))
-			continue;
-
-		nr_boost_reclaim += zone->watermark_boost;
-		zone_boosts[i] = zone->watermark_boost;
-	}
-	boosted = nr_boost_reclaim;
-
-restart:
 	set_reclaim_active(pgdat, highest_zoneidx);
 	sc.priority = DEF_PRIORITY;
 	do {
 		unsigned long nr_reclaimed = sc.nr_reclaimed;
 		bool raise_priority = true;
-		bool balanced;
 		bool ret;
 
 		sc.reclaim_idx = highest_zoneidx;
@@ -7089,40 +7046,9 @@ static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 			}
 		}
 
-		/*
-		 * If the pgdat is imbalanced then ignore boosting and preserve
-		 * the watermarks for a later time and restart. Note that the
-		 * zone watermarks will be still reset at the end of balancing
-		 * on the grounds that the normal reclaim should be enough to
-		 * re-evaluate if boosting is required when kswapd next wakes.
-		 */
-		balanced = pgdat_balanced(pgdat, sc.order, highest_zoneidx);
-		if (!balanced && nr_boost_reclaim) {
-			nr_boost_reclaim = 0;
-			goto restart;
-		}
-
-		/*
-		 * If boosting is not active then only reclaim if there are no
-		 * eligible zones. Note that sc.reclaim_idx is not used as
-		 * buffer_heads_over_limit may have adjusted it.
-		 */
-		if (!nr_boost_reclaim && balanced)
+		if (pgdat_balanced(pgdat, sc.order, highest_zoneidx))
 			goto out;
 
-		/* Limit the priority of boosting to avoid reclaim writeback */
-		if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
-			raise_priority = false;
-
-		/*
-		 * Do not writeback or swap pages for boosted reclaim. The
-		 * intent is to relieve pressure not issue sub-optimal IO
-		 * from reclaim context. If no pages are reclaimed, the
-		 * reclaim will be aborted.
-		 */
-		sc.may_writepage = !laptop_mode && !nr_boost_reclaim;
-		sc.may_swap = !nr_boost_reclaim;
-
 		/*
 		 * Do some background aging, to give pages a chance to be
 		 * referenced before reclaiming. All pages are rotated
@@ -7173,15 +7099,6 @@ static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 		 * progress in reclaiming pages
 		 */
 		nr_reclaimed = sc.nr_reclaimed - nr_reclaimed;
-		nr_boost_reclaim -= min(nr_boost_reclaim, nr_reclaimed);
-
-		/*
-		 * If reclaim made no progress for a boost, stop reclaim as
-		 * IO cannot be queued and it could be an infinite loop in
-		 * extreme circumstances.
-		 */
-		if (nr_boost_reclaim && !nr_reclaimed)
-			break;
 
 		if (raise_priority || !nr_reclaimed)
 			sc.priority--;
@@ -7193,28 +7110,6 @@ static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 out:
 	clear_reclaim_active(pgdat, highest_zoneidx);
 
-	/* If reclaim was boosted, account for the reclaim done in this pass */
-	if (boosted) {
-		unsigned long flags;
-
-		for (i = 0; i <= highest_zoneidx; i++) {
-			if (!zone_boosts[i])
-				continue;
-
-			/* Increments are under the zone lock */
-			zone = pgdat->node_zones + i;
-			spin_lock_irqsave(&zone->lock, flags);
-			zone->watermark_boost -= min(zone->watermark_boost, zone_boosts[i]);
-			spin_unlock_irqrestore(&zone->lock, flags);
-		}
-
-		/*
-		 * As there is now likely space, wakeup kcompact to defragment
-		 * pageblocks.
-		 */
-		wakeup_kcompactd(pgdat, pageblock_order, highest_zoneidx);
-	}
-
 	snapshot_refaults(NULL, pgdat);
 	__fs_reclaim_release(_THIS_IP_);
 	psi_memstall_leave(&pflags);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index a2f7b41564df..80ee26588242 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1682,7 +1682,6 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	}
 	seq_printf(m,
 		   "\n  pages free     %lu"
-		   "\n        boost    %lu"
 		   "\n        min      %lu"
 		   "\n        low      %lu"
 		   "\n        high     %lu"
@@ -1691,7 +1690,6 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   "\n        managed  %lu"
 		   "\n        cma      %lu",
 		   zone_page_state(zone, NR_FREE_PAGES),
-		   zone->watermark_boost,
 		   min_wmark_pages(zone),
 		   low_wmark_pages(zone),
 		   high_wmark_pages(zone),
-- 
2.39.2

