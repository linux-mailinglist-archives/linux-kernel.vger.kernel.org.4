Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40BA653B32
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiLVEUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbiLVETt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504F7233B0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:45 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z17-20020a25e311000000b00719e04e59e1so689077ybd.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BDLLEQAWPiuWvu6uAw7SlKRBGnG2Q5GXtGAMB+TrPE8=;
        b=YYDj3c5fM6hkrbkgsT5AQ5QuP7PmzqKTtUZOCkQp6tMZe2KtlQXDXuSeID5qZPLv5w
         uekCpC4/7VqRHl3u7ovnnOyeEqj/EsywNvGk0SU8TWCKdL5T+UUJ8v4uRxtZmS6vPnl7
         Wzj8lALjPQjik55Xsborgrd9EdV5KGHkidFuPRxek7BFO5jMvsBbkzoNYwVZleOoZih8
         UbO7SNB2W/YpVQufPScszqS4sLh/XpytF5xvF1sxeegGQeYmCWYdyiAVgWPTJHcniUSO
         tcG3i3xlYkukeP0JsAW7kB7ooTJnC5WmKclKn5JT2ujNOCPHbdsDPc8vVma69pRmczRk
         1nkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDLLEQAWPiuWvu6uAw7SlKRBGnG2Q5GXtGAMB+TrPE8=;
        b=Mp4DVX1Cv0o3iPYIMwGf2JeA9ockLqcWiGL0ydhu4B/79UfDO8mkY7vpQn7mDXF8Gx
         REcylFz8mjhLeMz6cDVGEDKCRGqBUvJsGbO1UNgPOwbw2mcIVHsbm3wBX0HVnn8+/t1s
         joaAhevtuMtXV2as/Rfh01Z2EWabXUYLt70qpjCVqkZ/EAeWJAwvIC7ISaiZR8xMp2EV
         SqTUt6onMu8buUxP7e7eeXiETQjV2SxaVHpFJKa3U4PugqAcssD9vph+pgpp3oUb6nK6
         5s1+x7xQpD+LuRcVpjZyHkBE4RF+tfuHH+YYqkcszsfCun2M7dKWQkh5Vbp4BTlDfpBM
         MKjA==
X-Gm-Message-State: AFqh2kqJr//+INtPKcmjq96P9cMm2S3DLHcDBD5+9pcvk7C6Gb3yJ4d9
        RhJIGcfxio9H+QlwKyEIB+Xpitg3+Lo=
X-Google-Smtp-Source: AMrXdXs9f5JEJZRSlLA1c9vebSH3Lts9X7RAt6HHv3GXYgSIKO08I/5btJz8yV9BWIG6W3F5rzxEG2SadvM=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a25:dcc7:0:b0:6fa:5ab4:12b5 with SMTP id
 y190-20020a25dcc7000000b006fa5ab412b5mr381185ybe.620.1671682784642; Wed, 21
 Dec 2022 20:19:44 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:19:01 -0700
In-Reply-To: <20221222041905.2431096-1-yuzhao@google.com>
Message-Id: <20221222041905.2431096-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20221222041905.2431096-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 3/8] mm: multi-gen LRU: remove eviction
 fairness safeguard
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
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
index d94d9fcabf36..49d7c103906a 100644
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
@@ -5006,8 +5016,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	return scanned;
 }
 
-static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
-			bool *need_swapping)
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
 {
 	int type;
 	int scanned;
@@ -5096,9 +5105,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		goto retry;
 	}
 
-	if (need_swapping && type == LRU_GEN_ANON)
-		*need_swapping = true;
-
 	return scanned;
 }
 
@@ -5138,67 +5144,26 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
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
 
@@ -5222,7 +5187,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		if (!nr_to_scan)
 			goto done;
 
-		delta = evict_folios(lruvec, sc, swappiness, &need_swapping);
+		delta = evict_folios(lruvec, sc, swappiness);
 		if (!delta)
 			goto done;
 
@@ -5230,7 +5195,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (should_abort_scan(lruvec, max_seq, sc, need_swapping))
+		if (sc->nr_reclaimed >= nr_to_reclaim)
 			break;
 
 		cond_resched();
@@ -5677,7 +5642,7 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 		if (sc->nr_reclaimed >= nr_to_reclaim)
 			return 0;
 
-		if (!evict_folios(lruvec, sc, swappiness, NULL))
+		if (!evict_folios(lruvec, sc, swappiness))
 			return 0;
 
 		cond_resched();
-- 
2.39.0.314.g84b9a713c41-goog

