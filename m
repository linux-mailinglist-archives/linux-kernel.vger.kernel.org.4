Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690756E6CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjDRTPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjDRTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57943901F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:39 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a15so7395704qvn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845219; x=1684437219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFgZ3D8VKBLVvaJCzeMlC8+6IsY+n+UHK2kcdHMAd6Y=;
        b=PrIghyUCPpn833RcxLlSVfU5Tk3SpnQwff6jbo/QPuj/XkyPt6wBzL/Dp9O4CsPEIx
         vlbtgOz19a8Bj5Q9Tvz3XxufWwoP1pyylG1i+Eubg/l0s5lNHABn8jx+RIo3qNp8yvJd
         xxmWan9BQx+LKGsE5QvB32mS3Fey4Ysn5JLrhFNxDsTGokonj/n7lqrpIjGCmJsUuM9+
         Ab+1ebZi1/6VKaIDC4ffD88G61bRq54CAS9nhM+89W7ACAiv40xaJvzX03Xeni/fkhUD
         S0GccLFy6IRYr+8AC7mboIhQozDrEx6WmyjvaCp6CXY+ejn1Dw19uqM1MKn105sfCPkW
         reiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845219; x=1684437219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFgZ3D8VKBLVvaJCzeMlC8+6IsY+n+UHK2kcdHMAd6Y=;
        b=OuUavGefsaiFhLyWlIYNSLTAl9uFprt6G2RYY8RnW5eb7AhAV+++Fkm/25G0g/iQvt
         Jk6eCkJgZU5ZHxTNsXgeFrNwdsVtU/wwKiTIoPDSgcyJF9Dw2uJ+uSqVgs8ExOw+yen+
         0eHFcwmIR/8sucBfSEXrHjOM12MA6v/kCNYrxCZ4xMpFEukpYFS8KlaTPRIUPszA2dEh
         nyYLmfOvYjUHb1dd/qlYtYIjV6GIH6a9QITElkh+n6GGB+3kdmxn4T+HLD8POiM946Nr
         Zq0QSWOsimWV4IUc7fEWxSjLU79qVhBYi4I7bd99PW3+EzQMzIA0tJuPOUODlRuLoSTb
         KS4w==
X-Gm-Message-State: AAQBX9f1HjDK7B0WJ4VoOBO/CSbzqC/XNjLyrvZMkTO14NpIjpKl0EEI
        MCxSHT2oscECldtSF3bBGexxTQ==
X-Google-Smtp-Source: AKy350YOTexSjADk98sBY4JcGk1SQDwC9c/+fGeG6k+kXfYRIwBupTZdOSOM2/pP7fHju0r9Wjpp2g==
X-Received: by 2002:a05:6214:20e2:b0:56a:b623:9b09 with SMTP id 2-20020a05621420e200b0056ab6239b09mr22229605qvk.14.1681845218901;
        Tue, 18 Apr 2023 12:13:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id z9-20020a0ce609000000b005dd8b9345c7sm3914040qvm.95.2023.04.18.12.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:38 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 17/26] mm: compaction: refactor __compaction_suitable()
Date:   Tue, 18 Apr 2023 15:13:04 -0400
Message-Id: <20230418191313.268131-18-hannes@cmpxchg.org>
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

__compaction_suitable() is supposed to check for available migration
targets. However, it also checks whether the operation was requested
via /proc/sys/vm/compact_memory, and whether the original allocation
request can already succeed. These don't apply to all callsites.

Move the checks out to the callers, so that later patches can deal
with them one by one. No functional change intended.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h |  4 +-
 mm/compaction.c            | 80 ++++++++++++++++++++++++--------------
 mm/vmscan.c                | 35 ++++++++++-------
 3 files changed, 74 insertions(+), 45 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 7635e220215a..9e1b2c56df62 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -98,7 +98,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		struct capture_control *capc);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
 extern enum compact_result compaction_suitable(struct zone *zone, int order,
-		unsigned int alloc_flags, int highest_zoneidx);
+					       int highest_zoneidx);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
 				bool alloc_success);
@@ -116,7 +116,7 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 }
 
 static inline enum compact_result compaction_suitable(struct zone *zone, int order,
-					int alloc_flags, int highest_zoneidx)
+						      int highest_zoneidx)
 {
 	return COMPACT_SKIPPED;
 }
diff --git a/mm/compaction.c b/mm/compaction.c
index f637b4ed7f3c..d4b7d5b36600 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2173,24 +2173,10 @@ static enum compact_result compact_finished(struct compact_control *cc)
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
@@ -2223,7 +2209,6 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
  *   COMPACT_CONTINUE - If compaction should run now
  */
 enum compact_result compaction_suitable(struct zone *zone, int order,
-					unsigned int alloc_flags,
 					int highest_zoneidx)
 {
 	unsigned long free_pages;
@@ -2234,8 +2219,7 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 	free_pages = zone_page_state(zone, NR_FREE_MOVABLE);
 	free_pages += zone_page_state(zone, NR_FREE_CMA_PAGES);
 
-	ret = __compaction_suitable(zone, order, alloc_flags,
-				    highest_zoneidx, free_pages);
+	ret = __compaction_suitable(zone, order, highest_zoneidx, free_pages);
 
 	/*
 	 * fragmentation index determines if allocation failures are due to
@@ -2279,6 +2263,16 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
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
 
 		available = zone_page_state_snapshot(zone, NR_FREE_MOVABLE);
 		available += zone_page_state_snapshot(zone, NR_FREE_CMA_PAGES);
@@ -2290,8 +2284,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		 */
 		available += zone_reclaimable_pages(zone) / order;
 
-		if (__compaction_suitable(zone, order, alloc_flags,
-					  ac->highest_zoneidx,
+		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
 					  available) == COMPACT_CONTINUE)
 			return true;
 	}
@@ -2322,14 +2315,26 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 	INIT_LIST_HEAD(&cc->migratepages);
 
 	cc->migratetype = gfp_migratetype(cc->gfp_mask);
-	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
-							cc->highest_zoneidx);
-	/* Compaction is likely to fail */
-	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
-		return ret;
 
-	/* huh, compaction_suitable is returning something unexpected */
-	VM_BUG_ON(ret != COMPACT_CONTINUE);
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
+
+		/* huh, compaction_suitable is returning something unexpected */
+		VM_BUG_ON(ret != COMPACT_CONTINUE);
+	}
 
 	/*
 	 * Clear pageblock skip if there were failures recently and compaction
@@ -2803,7 +2808,16 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
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
@@ -2841,10 +2855,18 @@ static void kcompactd_do_work(pg_data_t *pgdat)
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
index 9ecf29f4dab8..a0ebdbf3efcf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6076,14 +6076,17 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
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
@@ -6271,16 +6274,20 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
 	unsigned long free_pages;
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
2.39.2

