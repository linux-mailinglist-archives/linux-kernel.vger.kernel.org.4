Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E917205A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjFBPMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbjFBPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:12:37 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074C1BB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 08:12:14 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f85598697dso9035011cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 08:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685718726; x=1688310726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UJ/sY4fCIhElXrp/OIrwXZV72hsbkETwrAjou/86ODY=;
        b=AdJoDQlF5Iksk/PUOHjnHUEqDumTdxB+6H38sFxxCD/sPBo4WfvnCg6gWAI+JJLDLu
         8Fzc8Dh2W8S1TGk+hV7yqccfJMZKBbjjWIYTYOBnRMDUsMeEEAq7RjKzgVOTEs5Fl67j
         rO6k/p8QT9i6kOTeOyQpmx+qMyHHBdTssdLxPChlLvoS7APEdtBBtbDvG88mI79jpO+9
         djVwPH5Vk/r95ZpZH1dKr4XaqD/Zh2teuk4Ul5DpAzfxmvc3AIOzhlUBu0zg2OL6MXtW
         XagS16TXQj9YuVR5C+yJw8avrbFffRVSV1dg0YL5vgGeoft8hi2UHkRoVpWMtxWEb2OE
         tHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685718726; x=1688310726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJ/sY4fCIhElXrp/OIrwXZV72hsbkETwrAjou/86ODY=;
        b=i/+jpOcY4zPy3Tn+8VVrRoSgb64RUvrbJFehtH/JC3MjBg+GKAgS78bG7NvC+HxRBp
         cPo5WdbZYqASNLsO/Y35S0hKcQsIodWh01YdZVe4XcrxrfvbQPoyE8nbDqkb7MrMV37n
         87J9T37dUhsIAWGOgFEOh1bICGJG8JFz4KPBa21+EVeH70NzbJxwFNIdACPiOuAONJ1T
         nkQAuf9oDc6CbtLm288e6vAvarxfF3zbNqeILikIwVcolF7sp2kkwrAYWoEN1UzXUI9Z
         9aOmvhE6SYnHHmILngqmkkcV1CXRrcfeo8tsLtpwFmPbhHCKzhxQHXWe/H3xzJk7a/BU
         ylwA==
X-Gm-Message-State: AC+VfDzMBhZnGHK/XNGHHGrA7CfdbiPW0nLl8QRU9O6IFrMnvKVj7QMj
        AI8Ice4BPZVzL0xb6gttzUuJsQ==
X-Google-Smtp-Source: ACHHUZ5wAOrk5rjCrY0Dlm7rbBBgwnU5R/Uyki7/cLYa2PdV1jZwGY75NujMF8tPmrf9pYd5FOk6eQ==
X-Received: by 2002:a05:622a:1a23:b0:3f8:494c:556e with SMTP id f35-20020a05622a1a2300b003f8494c556emr6082704qtb.29.1685718726024;
        Fri, 02 Jun 2023 08:12:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ec58])
        by smtp.gmail.com with ESMTPSA id h22-20020ac846d6000000b003ef2db16e72sm849414qto.94.2023.06.02.08.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 08:12:05 -0700 (PDT)
Date:   Fri, 2 Jun 2023 11:12:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/5] mm: compaction: have compaction_suitable() return bool
Message-ID: <20230602151204.GD161817@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519123959.77335-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it only returns COMPACT_CONTINUE or COMPACT_SKIPPED now, a bool
return value simplifies the callsites.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/compaction.h |  6 ++--
 mm/compaction.c            | 64 ++++++++++++++++++--------------------
 mm/vmscan.c                |  6 ++--
 3 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index 9f7cf3e1bf89..57b16e69c19a 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -89,7 +89,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
 		const struct alloc_context *ac, enum compact_priority prio,
 		struct page **page);
 extern void reset_isolation_suitable(pg_data_t *pgdat);
-extern enum compact_result compaction_suitable(struct zone *zone, int order,
+extern bool compaction_suitable(struct zone *zone, int order,
 					       int highest_zoneidx);
 
 extern void compaction_defer_reset(struct zone *zone, int order,
@@ -107,10 +107,10 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
 {
 }
 
-static inline enum compact_result compaction_suitable(struct zone *zone, int order,
+static inline bool compaction_suitable(struct zone *zone, int order,
 						      int highest_zoneidx)
 {
-	return COMPACT_SKIPPED;
+	return false;
 }
 
 static inline void kcompactd_run(int nid)
diff --git a/mm/compaction.c b/mm/compaction.c
index fdee5f1ac5a1..d354d8af157c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2205,9 +2205,9 @@ static enum compact_result compact_finished(struct compact_control *cc)
 	return ret;
 }
 
-static enum compact_result __compaction_suitable(struct zone *zone, int order,
-					int highest_zoneidx,
-					unsigned long wmark_target)
+static bool __compaction_suitable(struct zone *zone, int order,
+				  int highest_zoneidx,
+				  unsigned long wmark_target)
 {
 	unsigned long watermark;
 	/*
@@ -2227,27 +2227,20 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
 	watermark = (order > PAGE_ALLOC_COSTLY_ORDER) ?
 				low_wmark_pages(zone) : min_wmark_pages(zone);
 	watermark += compact_gap(order);
-	if (!__zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
-						ALLOC_CMA, wmark_target))
-		return COMPACT_SKIPPED;
-
-	return COMPACT_CONTINUE;
+	return __zone_watermark_ok(zone, 0, watermark, highest_zoneidx,
+				   ALLOC_CMA, wmark_target);
 }
 
 /*
  * compaction_suitable: Is this suitable to run compaction on this zone now?
- * Returns
- *   COMPACT_SKIPPED  - If there are too few free pages for compaction
- *   COMPACT_CONTINUE - If compaction should run now
  */
-enum compact_result compaction_suitable(struct zone *zone, int order,
-					int highest_zoneidx)
+bool compaction_suitable(struct zone *zone, int order, int highest_zoneidx)
 {
-	enum compact_result ret;
-	int fragindex;
+	enum compact_result compact_result;
+	bool suitable;
 
-	ret = __compaction_suitable(zone, order, highest_zoneidx,
-				    zone_page_state(zone, NR_FREE_PAGES));
+	suitable = __compaction_suitable(zone, order, highest_zoneidx,
+					 zone_page_state(zone, NR_FREE_PAGES));
 	/*
 	 * fragmentation index determines if allocation failures are due to
 	 * low memory or external fragmentation
@@ -2264,17 +2257,24 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 	 * excessive compaction for costly orders, but it should not be at the
 	 * expense of system stability.
 	 */
-	if (ret == COMPACT_CONTINUE && (order > PAGE_ALLOC_COSTLY_ORDER)) {
-		fragindex = fragmentation_index(zone, order);
-		if (fragindex >= 0 && fragindex <= sysctl_extfrag_threshold)
-			ret = COMPACT_NOT_SUITABLE_ZONE;
+	if (suitable) {
+		compact_result = COMPACT_CONTINUE;
+		if (order > PAGE_ALLOC_COSTLY_ORDER) {
+			int fragindex = fragmentation_index(zone, order);
+
+			if (fragindex >= 0 &&
+			    fragindex <= sysctl_extfrag_threshold) {
+				suitable = false;
+				compact_result = COMPACT_NOT_SUITABLE_ZONE;
+			}
+		}
+	} else {
+		compact_result = COMPACT_SKIPPED;
 	}
 
-	trace_mm_compaction_suitable(zone, order, ret);
-	if (ret == COMPACT_NOT_SUITABLE_ZONE)
-		ret = COMPACT_SKIPPED;
+	trace_mm_compaction_suitable(zone, order, compact_result);
 
-	return ret;
+	return suitable;
 }
 
 bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
@@ -2300,7 +2300,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		available = zone_reclaimable_pages(zone) / order;
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
-					  available) == COMPACT_CONTINUE)
+					  available))
 			return true;
 	}
 
@@ -2341,11 +2341,10 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 				      cc->highest_zoneidx, cc->alloc_flags))
 			return COMPACT_SUCCESS;
 
-		ret = compaction_suitable(cc->zone, cc->order,
-					  cc->highest_zoneidx);
 		/* Compaction is likely to fail */
-		if (ret == COMPACT_SKIPPED)
-			return ret;
+		if (!compaction_suitable(cc->zone, cc->order,
+					 cc->highest_zoneidx))
+			return COMPACT_SKIPPED;
 	}
 
 	/*
@@ -2846,7 +2845,7 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 			continue;
 
 		if (compaction_suitable(zone, pgdat->kcompactd_max_order,
-					highest_zoneidx) == COMPACT_CONTINUE)
+					highest_zoneidx))
 			return true;
 	}
 
@@ -2888,8 +2887,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 				      min_wmark_pages(zone), zoneid, 0))
 			continue;
 
-		if (compaction_suitable(zone, cc.order,
-					zoneid) != COMPACT_CONTINUE)
+		if (!compaction_suitable(zone, cc.order, zoneid))
 			continue;
 
 		if (kthread_should_stop())
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c0cfa9b86b48..e9a8ca124982 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6402,8 +6402,7 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 				      sc->reclaim_idx, 0))
 			return false;
 
-		if (compaction_suitable(zone, sc->order,
-					sc->reclaim_idx) == COMPACT_CONTINUE)
+		if (compaction_suitable(zone, sc->order, sc->reclaim_idx))
 			return false;
 	}
 
@@ -6599,8 +6598,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 		return true;
 
 	/* Compaction cannot yet proceed. Do reclaim. */
-	if (compaction_suitable(zone, sc->order,
-				sc->reclaim_idx) == COMPACT_SKIPPED)
+	if (!compaction_suitable(zone, sc->order, sc->reclaim_idx))
 		return false;
 
 	/*
-- 
2.40.1

