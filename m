Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629A6652A54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiLUANJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiLUAMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:12:46 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8322035F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r7-20020a25c107000000b006ff55ac0ee7so15830836ybf.15
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y306PH8Q0yp+xWizSY/ux8ywn6bxHcRrOk54D5HB2aU=;
        b=GlPiUBTF+eOAUqdbrju+L1+Kh2wEO8CK+cMwhM7K6Y1IUVWqKXq6Srl0dPkE6NZEHM
         NvnzPFwFsuQL7HH8D4QeVAltwJBOXQAXNpJV2tlNz2kzmGWq9+RWxmJgjzKJ7BDlJTx8
         BqlrCKIq6REydAxMtmiIG1Wk7yRm/0MIuq/sGKpU/qThTOiFIb8txt0eAaelMAUKVpmt
         xnWEPSQG7j+mL+CH22sZaicYWYgO9eV7VsqFV55qrg9aMH2v/OL9Z3KNrB4iBvpBGcTS
         1auKzt2mFvRdMGB4k6qPXceTvJwVKzP3vKVe4g+/uaB/gSrnSFHF0RKsFAdGd7PY39hz
         SECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y306PH8Q0yp+xWizSY/ux8ywn6bxHcRrOk54D5HB2aU=;
        b=yLXe85sFcWQ+lTY69chNbFJy9oQRAZz8Zp0htpwf36wt1wjf2xpBAWaWWHvTNbOAXw
         Sk0KIYadyDhz9dSygAj+7NgDkdjhAYREaZgzOVna14/RfliR/oZLCM/AFgKrQGNiciyF
         L6H33oC4VBKJMg4vSKjIoRm4eghwTXjuGeJd+ewGiX5c0QTCvDoe5mtSJ4wIyJ6lhqOl
         M8sXkjr9b7paroDrJB0soPIxVw5tvHOEVBa1FsKmK/iy1UYeUefADUCIo82quF0CuZwE
         9FBYKcFusbzqpcdx4Lnfkh/6RvQiOebRV2RN5sSfWu6a25Oq0c7NbBHYiV25NhQ7fCva
         4Avw==
X-Gm-Message-State: ANoB5pkSk8IgB7NbLezUw+foAV4UokKmJf9wL22DSgDeSCXT8I98IC79
        vldZGW3NxTC9cT5dI/tVr96RGMqVAHg=
X-Google-Smtp-Source: AA0mqf4kmUm3Oml4SQcszfQyWi0BIkPzgCXt6tJS052cJtMI6HpR2ijMRjA//FRRHQ1i3YBOkd6DUZjJlrY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a05:690c:903:b0:3b7:e501:90cf with SMTP id
 cb3-20020a05690c090300b003b7e50190cfmr5497843ywb.501.1671581559741; Tue, 20
 Dec 2022 16:12:39 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:12:03 -0700
In-Reply-To: <20221221001207.1376119-1-yuzhao@google.com>
Message-Id: <20221221001207.1376119-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20221221001207.1376119-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 3/8] mm: multi-gen LRU: remove eviction
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
Change-Id: Ieb2a658c8d441ec11348d2985c7c4d6b72106f6a
---
 mm/vmscan.c | 81 +++++++++++++++--------------------------------------
 1 file changed, 23 insertions(+), 58 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 94477894b226..9655b3b3a95e 100644
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
@@ -5009,8 +5019,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	return scanned;
 }
 
-static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
-			bool *need_swapping)
+static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
 {
 	int type;
 	int scanned;
@@ -5099,9 +5108,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 		goto retry;
 	}
 
-	if (need_swapping && type == LRU_GEN_ANON)
-		*need_swapping = true;
-
 	return scanned;
 }
 
@@ -5141,67 +5147,26 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
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
 
@@ -5225,7 +5190,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		if (!nr_to_scan)
 			goto done;
 
-		delta = evict_folios(lruvec, sc, swappiness, &need_swapping);
+		delta = evict_folios(lruvec, sc, swappiness);
 		if (!delta)
 			goto done;
 
@@ -5233,7 +5198,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (should_abort_scan(lruvec, max_seq, sc, need_swapping))
+		if (sc->nr_reclaimed >= nr_to_reclaim)
 			break;
 
 		cond_resched();
@@ -5680,7 +5645,7 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 		if (sc->nr_reclaimed >= nr_to_reclaim)
 			return 0;
 
-		if (!evict_folios(lruvec, sc, swappiness, NULL))
+		if (!evict_folios(lruvec, sc, swappiness))
 			return 0;
 
 		cond_resched();
-- 
2.39.0.314.g84b9a713c41-goog

