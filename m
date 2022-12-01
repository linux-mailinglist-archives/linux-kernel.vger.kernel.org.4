Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39863FAB0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiLAWj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiLAWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749BC82F5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e15-20020a5b0ccf000000b006ed1704b40cso3189964ybr.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1CAWLF/Pr37Q+tUzT+ZYK1OUBV6p0czcCCYFvheAt8=;
        b=ZZB8O77vizkwbL+BtNrQny9vAyzGkEzi6VNYlAJ8o3lRHt9ct0ErfZZsrVGL3AcXQ1
         g6b3y+/raQL/iqTo2KKKu4ie98C0Ave3f8NrVN4wj/zrtMmGBYSvl4T6CxGDB7tYzaQr
         Mq6iEjuAJj1LYaWFXS1ohNm+DICTB3/SMAmq6gEM6dCOOmmlvoh7c2ITyousM2yV6+/7
         P+ER0w42T/CXOrOJHoQD91ZeM7pLhdUBj5LaNFQ+gfq1SEj9ZiGnCzeY+9hfLaeDKMPw
         aN+UMB3gHzXUEbX2Sk1x5SS7+I0WdPDFmnbV5uPjCh5o+bqRBhMmtBtIQkXnnW5Ve/GZ
         4e4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1CAWLF/Pr37Q+tUzT+ZYK1OUBV6p0czcCCYFvheAt8=;
        b=2ZL8t+8nLV64QPGQBMtjqkf2B/h+RYDZ1mEqH0pJywVKhh2PS1Fy7kmMunPsHCfeBZ
         4cFz5E0rtMiKVP/MZkklmAq4J21xLlsdfrVmzwktNsYFT7MiPsT0qMC+Dm8B3v2/e0ew
         O691ngAPrOVV/lSGDnobTc9lOm8e/rI0V1p0aVuK0yTNs9eOU3K3APXgIVoCbXbyxe5Q
         vXku0fw46o+7uB58tlYNtE/h1p6o+iRdWmhdoEncqluXZhyp0GFRlZrKC98b7MMh5KBi
         ZzbuDUqyTDi+m5dTU4pz5XXacBPzHr7W0jRPtRn74Pq6EGFiUSSfnu6TM4ziBPR/oQRp
         9pTg==
X-Gm-Message-State: ANoB5pkVLAUMrXcoMtyuIxL4uflfD1AGx+SUPbNKEmN/Lku14MdrXPRw
        PmAwxCZyQAObT/r0I1KNCP2Evb8qgSg=
X-Google-Smtp-Source: AA0mqf59sgS0ZhfbHLTxSsJYv8pDkOxnnBfFny9mVriiFvV1ECl7PNXEtC23rhvo7tBw7R7x1gSSmc1Y5OE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a81:5f83:0:b0:367:a786:8318 with SMTP id
 t125-20020a815f83000000b00367a7868318mr47352781ywb.367.1669934384612; Thu, 01
 Dec 2022 14:39:44 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:19 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 3/8] mm: multi-gen LRU: remove eviction
 fairness safeguard
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recall that the eviction consumes the oldest generation: first it
bucket-sorts folios whose gen counters were updated by the aging and
reclaims the rest; then it increments lrugen->min_seq.

The current eviction fairness safeguard for global reclaim has a
dilemma: when there are multiple eligible memcgs, should it continue
or stop upon meeting the reclaim goal? If it continues, it overshoots
and increases direct reclaim latency; if it stops, it loses fairness
between memcgs it has taken memory away from and those it has yet to.

With memcg LRU, the eviction, while ensuring eventual fairness, will
stop upon meeting its goal. Therefore the current eviction fairness
safeguard for global reclaim will not be needed.

Note that memcg LRU only applies to global reclaim. For memcg reclaim,
the eviction will continue, even if it is overshooting. This becomes
unconditional due to code simplification.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 81 +++++++++++++++--------------------------------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index ebab1ec3d400..d714a777c88b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -449,6 +449,11 @@ static bool cgroup_reclaim(struct scan_control *sc)
 	return sc->target_mem_cgroup;
 }
 
+static bool global_reclaim(struct scan_control *sc)
+{
+	return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
+}
+
 /**
  * writeback_throttling_sane - is the usual dirty throttling mechanism available?
  * @sc: scan_control in question
@@ -499,6 +504,11 @@ static bool cgroup_reclaim(struct scan_control *sc)
 	return false;
 }
 
+static bool global_reclaim(struct scan_control *sc)
+{
+	return true;
+}
+
 static bool writeback_throttling_sane(struct scan_control *sc)
 {
 	return true;
@@ -4991,8 +5001,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	return scanned;
 }
 
-static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
-			bool *need_swapping)
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
 {
 	int type;
 	int scanned;
@@ -5081,9 +5090,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		goto retry;
 	}
 
-	if (need_swapping && type == LRU_GEN_ANON)
-		*need_swapping = true;
-
 	return scanned;
 }
 
@@ -5122,67 +5128,26 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
 	return min_seq[!can_swap] + MIN_NR_GENS <= max_seq ? nr_to_scan : 0;
 }
 
-static bool should_abort_scan(struct lruvec *lruvec, unsigned long seq,
-			      struct scan_control *sc, bool need_swapping)
+static unsigned long get_nr_to_reclaim(struct scan_control *sc)
 {
-	int i;
-	DEFINE_MAX_SEQ(lruvec);
+	/* don't abort memcg reclaim to ensure fairness */
+	if (!global_reclaim(sc))
+		return -1;
 
-	if (!current_is_kswapd()) {
-		/* age each memcg at most once to ensure fairness */
-		if (max_seq - seq > 1)
-			return true;
+	/* discount the previous progress for kswapd */
+	if (current_is_kswapd())
+		return sc->nr_to_reclaim + sc->last_reclaimed;
 
-		/* over-swapping can increase allocation latency */
-		if (sc->nr_reclaimed >= sc->nr_to_reclaim && need_swapping)
-			return true;
-
-		/* give this thread a chance to exit and free its memory */
-		if (fatal_signal_pending(current)) {
-			sc->nr_reclaimed += MIN_LRU_BATCH;
-			return true;
-		}
-
-		if (cgroup_reclaim(sc))
-			return false;
-	} else if (sc->nr_reclaimed - sc->last_reclaimed < sc->nr_to_reclaim)
-		return false;
-
-	/* keep scanning at low priorities to ensure fairness */
-	if (sc->priority > DEF_PRIORITY - 2)
-		return false;
-
-	/*
-	 * A minimum amount of work was done under global memory pressure. For
-	 * kswapd, it may be overshooting. For direct reclaim, the allocation
-	 * may succeed if all suitable zones are somewhat safe. In either case,
-	 * it's better to stop now, and restart later if necessary.
-	 */
-	for (i = 0; i <= sc->reclaim_idx; i++) {
-		unsigned long wmark;
-		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
-
-		if (!managed_zone(zone))
-			continue;
-
-		wmark = current_is_kswapd() ? high_wmark_pages(zone) : low_wmark_pages(zone);
-		if (wmark > zone_page_state(zone, NR_FREE_PAGES))
-			return false;
-	}
-
-	sc->nr_reclaimed += MIN_LRU_BATCH;
-
-	return true;
+	return max(sc->nr_to_reclaim, compact_gap(sc->order));
 }
 
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
 	bool need_aging = false;
-	bool need_swapping = false;
 	unsigned long scanned = 0;
 	unsigned long reclaimed = sc->nr_reclaimed;
-	DEFINE_MAX_SEQ(lruvec);
+	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
 	lru_add_drain();
 
@@ -5206,7 +5171,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		if (!nr_to_scan)
 			goto done;
 
-		delta = evict_folios(lruvec, sc, swappiness, &need_swapping);
+		delta = evict_folios(lruvec, sc, swappiness);
 		if (!delta)
 			goto done;
 
@@ -5214,7 +5179,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (should_abort_scan(lruvec, max_seq, sc, need_swapping))
+		if (sc->nr_reclaimed >= nr_to_reclaim)
 			break;
 
 		cond_resched();
@@ -5661,7 +5626,7 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 		if (sc->nr_reclaimed >= nr_to_reclaim)
 			return 0;
 
-		if (!evict_folios(lruvec, sc, swappiness, NULL))
+		if (!evict_folios(lruvec, sc, swappiness))
 			return 0;
 
 		cond_resched();
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

