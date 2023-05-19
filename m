Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760C470975D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjESMk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjESMkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:20 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9210B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96aadfb19d7so609388666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684500010; x=1687092010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXkGmoOKMV9wp5TM6FJc6/QwLR/CY7AZ1q5R5QORiXk=;
        b=j8nprdhTRVRZX+b+MiJ39vvsPB8y0GGrbPhI6lsexF0dvkO4amR6WItiuegG9BfiRU
         MN8A49KVx8o86hTYpRXpcGjnSKD25lzyyj/NH4c3kzpIu8FH29Fwu9YXWODBkI/cR2tZ
         tOWDqP3eVUjsGYrXv9d6xlJKrPpVGZlF4AoFmjHQ8nIIaKIWelJHj4SHtHzvkTfTetw7
         uwZhgOO/hTAb8A1ZkSqmIj2ZGQM1X+5/b7c6kdyR6bMbj9hfiKlwreo9cF2y7+qx1WJD
         81n9YGKCYvomlnft2jGfo59NweehDvgmGgPIPXd9/QQdknjD+xJPIaq182eUfreAbQ8C
         sHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500010; x=1687092010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXkGmoOKMV9wp5TM6FJc6/QwLR/CY7AZ1q5R5QORiXk=;
        b=In2WT3SDP5czJ79X2HZ9erqWzWO0Rgzt/elfAUd3Xw46z4k4wd84Mejk943Jz9vvlN
         Ys7J19xRlgq12XM4PaVwADkmWJ1yv6pGbjvLH7uQpbf8YYNoViraImzRC8L8odawNGGL
         gP5G7C8clYd3OI5kE+/gHX7BOhtJSgtH+8s9XeAI4NWhZXesBpumWkhxyZ63rtjApiea
         oX2yxGMMFdLolKkwIYAhsSO7proa6xJ5rInyX7buphCLHOwJdFKUsXr5q2iVLsvIIvQ+
         OMA2wcPOiRz9xqXERyKFTjs4JEhTKg1FYOC7p4Z6rCWkLYcMt0joXffhPS2cNBmZl+d0
         7hpQ==
X-Gm-Message-State: AC+VfDyU805csIlv7V2mk40ubc/ORD92XuALkqOiDzoy/ILTAMXA4+Kf
        OrkplGy6dDZN5RR7a9GDCNpTLw==
X-Google-Smtp-Source: ACHHUZ5OI99u6ZjRHk2L81FZPXX2dcOxJ0p3S0XoqUDF0BmNWfVXDxnHp4ONjafiSuyLZ1d4i1Us2w==
X-Received: by 2002:a17:906:ee88:b0:94a:5819:5a2b with SMTP id wt8-20020a170906ee8800b0094a58195a2bmr1567192ejb.33.1684500010022;
        Fri, 19 May 2023 05:40:10 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id u20-20020a170906125400b009571293d6acsm2236343eja.59.2023.05.19.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:40:09 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/5] mm: compaction: refactor __compaction_suitable()
Date:   Fri, 19 May 2023 14:39:57 +0200
Message-Id: <20230519123959.77335-4-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230519123959.77335-1-hannes@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
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

__compaction_suitable() is supposed to check for available migration
targets. However, it also checks whether the operation was requested
via /proc/sys/vm/compact_memory, and whether the original allocation
request can already succeed. These don't apply to all callsites.

Move the checks out to the callers, so that later patches can deal
with them one by one. No functional change intended.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h |  4 +-
 mm/compaction.c            | 78 ++++++++++++++++++++++++--------------
 mm/vmscan.c                | 35 ++++++++++-------
 3 files changed, 73 insertions(+), 44 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 1f0328a2ba48..9f7cf3e1bf89 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -90,7 +90,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
-		unsigned int alloc_flags, int highest_zoneidx);
+					       int highest_zoneidx);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -108,7 +108,7 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline enum compact_result compaction_suitable(struct zone *zone, int order,
-					int alloc_flags, int highest_zoneidx)
+						      int highest_zoneidx)
 {
 	return COMPACT_SKIPPED;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index c9a4b6dffcf2..8f61cfa87c49 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2206,24 +2206,10 @@ static enum compact_result compact_finished(struct compact_control *cc)
 }
 
 static enum compact_result __compaction_suitable(struct zone *zone, int order,
-					unsigned int alloc_flags,
 					int highest_zoneidx,
 					unsigned long wmark_target)
 {
 	unsigned long watermark;
-
-	if (is_via_compact_memory(order))
-		return COMPACT_CONTINUE;
-
-	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
-	/*
-	 * If watermarks for high-order allocation are already met, there
-	 * should be no need for compaction at all.
-	 */
-	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
-								alloc_flags))
-		return COMPACT_SUCCESS;
-
 	/*
 	 * Watermarks for order-0 must be met for compaction to be able to
 	 * isolate free pages for migration targets. This means that the
@@ -2256,13 +2242,12 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
  *   COMPACT_CONTINUE - If compaction should run now
  */
 enum compact_result compaction_suitable(struct zone *zone, int order,
-					unsigned int alloc_flags,
 					int highest_zoneidx)
 {
 	enum compact_result ret;
 	int fragindex;
 
-	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
+	ret = __compaction_suitable(zone, order, highest_zoneidx,
 				    zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
@@ -2306,7 +2291,16 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
-		enum compact_result compact_result;
+		unsigned long watermark;
+
+		if (is_via_compact_memory(order))
+			return true;
+
+		/* Allocation can already succeed, nothing to do */
+		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+		if (zone_watermark_ok(zone, order, watermark,
+				      ac->highest_zoneidx, alloc_flags))
+			continue;
 
 		/*
 		 * Do not consider all the reclaimable memory because we do not
@@ -2316,9 +2310,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		 */
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
-		compact_result = __compaction_suitable(zone, order, alloc_flags,
-				ac->highest_zoneidx, available);
-		if (compact_result == COMPACT_CONTINUE)
+		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
+					  available) == COMPACT_CONTINUE)
 			return true;
 	}
 
@@ -2348,11 +2341,23 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	INIT_LIST_HEAD(&cc->migratepages);
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
-	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
-							cc->highest_zoneidx);
-	/* Compaction is likely to fail */
-	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
-		return ret;
+
+	if (!is_via_compact_memory(cc->order)) {
+		unsigned long watermark;
+
+		/* Allocation can already succeed, nothing to do */
+		watermark = wmark_pages(cc->zone,
+					cc->alloc_flags & ALLOC_WMARK_MASK);
+		if (zone_watermark_ok(cc->zone, cc->order, watermark,
+				      cc->highest_zoneidx, cc->alloc_flags))
+			return COMPACT_SUCCESS;
+
+		ret = compaction_suitable(cc->zone, cc->order,
+					  cc->highest_zoneidx);
+		/* Compaction is likely to fail */
+		if (ret == COMPACT_SKIPPED)
+			return ret;
+	}
 
 	/*
 	 * Clear pageblock skip if there were failures recently and compaction
@@ -2845,7 +2850,16 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		if (compaction_suitable(zone, pgdat->kcompactd_max_order, 0,
+		if (is_via_compact_memory(pgdat->kcompactd_max_order))
+			return true;
+
+		/* Allocation can already succeed, check other zones */
+		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
+				      min_wmark_pages(zone),
+				      highest_zoneidx, 0))
+			continue;
+
+		if (compaction_suitable(zone, pgdat->kcompactd_max_order,
 					highest_zoneidx) == COMPACT_CONTINUE)
 			return true;
 	}
@@ -2883,10 +2897,18 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		if (compaction_suitable(zone, cc.order, 0, zoneid) !=
-							COMPACT_CONTINUE)
+		if (is_via_compact_memory(cc.order))
+			goto compact;
+
+		/* Allocation can already succeed, nothing to do */
+		if (zone_watermark_ok(zone, cc.order,
+				      min_wmark_pages(zone), zoneid, 0))
 			continue;
 
+		if (compaction_suitable(zone, cc.order,
+					zoneid) != COMPACT_CONTINUE)
+			continue;
+compact:
 		if (kthread_should_stop())
 			return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d257916f39e5..c9c0f3e081f5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6397,14 +6397,17 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 		if (!managed_zone(zone))
 			continue;
 
-		switch (compaction_suitable(zone, sc->order, 0, sc->reclaim_idx)) {
-		case COMPACT_SUCCESS:
-		case COMPACT_CONTINUE:
+		if (sc->order == -1) /* is_via_compact_memory() */
+			return false;
+
+		/* Allocation can already succeed, nothing to do */
+		if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
+				      sc->reclaim_idx, 0))
+			return false;
+
+		if (compaction_suitable(zone, sc->order,
+					sc->reclaim_idx) == COMPACT_CONTINUE)
 			return false;
-		default:
-			/* check next zone */
-			;
-		}
 	}
 
 	/*
@@ -6592,16 +6595,20 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
-	enum compact_result suitable;
 
-	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
-	if (suitable == COMPACT_SUCCESS)
-		/* Allocation should succeed already. Don't reclaim. */
+	if (sc->order == -1) /* is_via_compact_memory() */
+		goto suitable;
+
+	/* Allocation can already succeed, nothing to do */
+	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
+			      sc->reclaim_idx, 0))
 		return true;
-	if (suitable == COMPACT_SKIPPED)
-		/* Compaction cannot yet proceed. Do reclaim. */
-		return false;
 
+	/* Compaction cannot yet proceed. Do reclaim. */
+	if (compaction_suitable(zone, sc->order,
+				sc->reclaim_idx) == COMPACT_SKIPPED)
+		return false;
+suitable:
 	/*
 	 * Compaction is already possible, but it takes time to run and there
 	 * are potentially other callers using the pages just freed. So proceed
-- 
2.40.0

