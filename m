Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36C652A55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiLUANO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiLUAMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:12:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A78201A5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:41 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 195-20020a2505cc000000b0071163981d18so15962962ybf.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W215O6nVZQSEsqpHqtb/vUKPzkuQ3oMopgbAZLI2Y6k=;
        b=eG/fUD4zGkFUZK+ZF+HvzoNHr/U2E6OCu8wDseqLAQ7XetG2/d97LSGE+vjDKJW/8T
         55c6gGFY7rbXkizJhVfunHV+jAKiBzVpXbBFN3tFXqv08tKo4j5tbJdoIFIVw8yuZZEd
         ze4WDTwcwXETWVT8Z2vGRdjfiisp9rSc1HLiCfPkE6vpTXTeOalRHGAvgdBLPNLdEZx2
         jkxOB+JW7wkH/evopjYD7Zl4/gzUQ+yv9/VY+Ad2IDAebHIFWEaxMQI2vQiJqEidlS4M
         B0fpb9bK118a9RvoRkIDcjCWKNmiMIf1PgLrjubYfLSYbJNQvRTJ++80oy6hzbiOWW49
         rdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W215O6nVZQSEsqpHqtb/vUKPzkuQ3oMopgbAZLI2Y6k=;
        b=1JU8p5Vi2Fp6ZQ79fv05/X1WspVZxf65gnXpPWkMGeFsalbjUy1UX87f0o0Lp0MTxz
         tjvuemn6wfpJ2XP9DxA+lAGuyqOLyI4evbd5PQPObY7CTB7DmykMV64nsr62YSH4hLAE
         Bon9i6DSha/CW4xtToE6Z/kHAZw1KMG6UvmxV6VhO2/JxBqzDHJP4f2n6FkrYxSbfA21
         V346cOmLZyYg9yRGd5LokO4glm+qKkD2ko6jjP1T1Khxed7AesQmtriYU0ihQhmiwJw3
         lipWrchuKICV9qX+Vs1yJj10oHOzql/+n3N44oUu8YelWnBAiTCGpQlIyutifCbC4SY3
         VZ/Q==
X-Gm-Message-State: AFqh2koUI9g2cFGCx/rb7g0IkeNowJ6yJvOiohPecaWTZAuAuF6A59d7
        73tn341AiZTmfs5W57yes/KOCdHs5aA=
X-Google-Smtp-Source: AMrXdXv0COwLPwkTS0Vl7hKGmMXAA1gr18YJ0e5zARRIGHI8mnjrVM8t0QekFFd4Y0N7jJ2180yJ1mZynA4=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a25:9d8c:0:b0:733:4d8d:f01a with SMTP id
 v12-20020a259d8c000000b007334d8df01amr3223932ybp.399.1671581561148; Tue, 20
 Dec 2022 16:12:41 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:12:04 -0700
In-Reply-To: <20221221001207.1376119-1-yuzhao@google.com>
Message-Id: <20221221001207.1376119-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20221221001207.1376119-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 4/8] mm: multi-gen LRU: remove aging fairness safeguard
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

Recall that the aging produces the youngest generation: first it scans
for accessed folios and updates their gen counters; then it increments
lrugen->max_seq.

The current aging fairness safeguard for kswapd uses two passes to
ensure the fairness to multiple eligible memcgs. On the first pass,
which is shared with the eviction, it checks whether all eligible
memcgs are low on cold folios. If so, it requires a second pass, on
which it ages all those memcgs at the same time.

With memcg LRU, the aging, while ensuring eventual fairness, will run
when necessary. Therefore the current aging fairness safeguard for
kswapd will not be needed.

Note that memcg LRU only applies to global reclaim. For memcg reclaim,
the aging can be unfair to different memcgs, i.e., their
lrugen->max_seq can be incremented at different paces.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Change-Id: I66c70bd31d5276c710ad9209f0a74b1c24a0eda9
---
 mm/vmscan.c | 150 +++++++++++++++++++++++++---------------------------
 1 file changed, 71 insertions(+), 79 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9655b3b3a95e..a2f71400b8be 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -137,7 +137,6 @@ struct scan_control {
 
 #ifdef CONFIG_LRU_GEN
 	/* help kswapd make better choices among multiple memcgs */
-	unsigned int memcgs_need_aging:1;
 	unsigned long last_reclaimed;
 #endif
 
@@ -4471,7 +4470,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	return true;
 }
 
-static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsigned long *min_seq,
+static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
 			     struct scan_control *sc, bool can_swap, unsigned long *nr_to_scan)
 {
 	int gen, type, zone;
@@ -4480,6 +4479,13 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
 	unsigned long total = 0;
 	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	/* whether this lruvec is completely out of cold folios */
+	if (min_seq[!can_swap] + MIN_NR_GENS > max_seq) {
+		*nr_to_scan = 0;
+		return true;
+	}
 
 	for (type = !can_swap; type < ANON_AND_FILE; type++) {
 		unsigned long seq;
@@ -4508,8 +4514,6 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
 	 * stalls when the number of generations reaches MIN_NR_GENS. Hence, the
 	 * ideal number of generations is MIN_NR_GENS+1.
 	 */
-	if (min_seq[!can_swap] + MIN_NR_GENS > max_seq)
-		return true;
 	if (min_seq[!can_swap] + MIN_NR_GENS < max_seq)
 		return false;
 
@@ -4528,40 +4532,54 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
 	return false;
 }
 
-static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, unsigned long min_ttl)
+static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
-	bool need_aging;
-	unsigned long nr_to_scan;
-	int swappiness = get_swappiness(lruvec, sc);
+	int gen, type, zone;
+	unsigned long total = 0;
+	bool can_swap = get_swappiness(lruvec, sc);
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
+	for (type = !can_swap; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+
+		for (seq = min_seq[type]; seq <= max_seq; seq++) {
+			gen = lru_gen_from_seq(seq);
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++)
+				total += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+		}
+	}
+
+	/* whether the size is big enough to be helpful */
+	return mem_cgroup_online(memcg) ? (total >> sc->priority) : total;
+}
+
+static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc,
+				  unsigned long min_ttl)
+{
+	int gen;
+	unsigned long birth;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
 	VM_WARN_ON_ONCE(sc->memcg_low_reclaim);
 
+	/* see the comment on lru_gen_folio */
+	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
+	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+	if (time_is_after_jiffies(birth + min_ttl))
+		return false;
+
+	if (!lruvec_is_sizable(lruvec, sc))
+		return false;
+
 	mem_cgroup_calculate_protection(NULL, memcg);
 
-	if (mem_cgroup_below_min(NULL, memcg))
-		return false;
-
-	need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, swappiness, &nr_to_scan);
-
-	if (min_ttl) {
-		int gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
-		unsigned long birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
-
-		if (time_is_after_jiffies(birth + min_ttl))
-			return false;
-
-		/* the size is likely too small to be helpful */
-		if (!nr_to_scan && sc->priority != DEF_PRIORITY)
-			return false;
-	}
-
-	if (need_aging)
-		try_to_inc_max_seq(lruvec, max_seq, sc, swappiness, false);
-
-	return true;
+	return !mem_cgroup_below_min(NULL, memcg);
 }
 
 /* to protect the working set of the last N jiffies */
@@ -4570,46 +4588,32 @@ static unsigned long lru_gen_min_ttl __read_mostly;
 static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *memcg;
-	bool success = false;
 	unsigned long min_ttl = READ_ONCE(lru_gen_min_ttl);
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
 	sc->last_reclaimed = sc->nr_reclaimed;
 
-	/*
-	 * To reduce the chance of going into the aging path, which can be
-	 * costly, optimistically skip it if the flag below was cleared in the
-	 * eviction path. This improves the overall performance when multiple
-	 * memcgs are available.
-	 */
-	if (!sc->memcgs_need_aging) {
-		sc->memcgs_need_aging = true;
-		return;
-	}
-
-	set_mm_walk(pgdat);
-
-	memcg = mem_cgroup_iter(NULL, NULL, NULL);
-	do {
-		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
-
-		if (age_lruvec(lruvec, sc, min_ttl))
-			success = true;
-
-		cond_resched();
-	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
-
-	clear_mm_walk();
-
 	/* check the order to exclude compaction-induced reclaim */
-	if (success || !min_ttl || sc->order)
+	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
 
+	memcg = mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+		if (lruvec_is_reclaimable(lruvec, sc, min_ttl)) {
+			mem_cgroup_iter_break(NULL, memcg);
+			return;
+		}
+
+		cond_resched();
+	} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)));
+
 	/*
 	 * The main goal is to OOM kill if every generation from all memcgs is
 	 * younger than min_ttl. However, another possibility is all memcgs are
-	 * either below min or empty.
+	 * either too small or below min.
 	 */
 	if (mutex_trylock(&oom_lock)) {
 		struct oom_control oc = {
@@ -5117,34 +5121,28 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
  *    reclaim.
  */
 static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc,
-				    bool can_swap, bool *need_aging)
+				    bool can_swap)
 {
 	unsigned long nr_to_scan;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
-	DEFINE_MIN_SEQ(lruvec);
 
 	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
 	    (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
 	     !sc->memcg_low_reclaim))
 		return 0;
 
-	*need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, &nr_to_scan);
-	if (!*need_aging)
+	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
 		return nr_to_scan;
 
 	/* skip the aging path at the default priority */
 	if (sc->priority == DEF_PRIORITY)
-		goto done;
-
-	/* leave the work to lru_gen_age_node() */
-	if (current_is_kswapd())
-		return 0;
-
-	if (try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false))
 		return nr_to_scan;
-done:
-	return min_seq[!can_swap] + MIN_NR_GENS <= max_seq ? nr_to_scan : 0;
+
+	try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false);
+
+	/* skip this lruvec as it's low on cold folios */
+	return 0;
 }
 
 static unsigned long get_nr_to_reclaim(struct scan_control *sc)
@@ -5163,9 +5161,7 @@ static unsigned long get_nr_to_reclaim(struct scan_control *sc)
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
-	bool need_aging = false;
 	unsigned long scanned = 0;
-	unsigned long reclaimed = sc->nr_reclaimed;
 	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
 	lru_add_drain();
@@ -5186,13 +5182,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		else
 			swappiness = 0;
 
-		nr_to_scan = get_nr_to_scan(lruvec, sc, swappiness, &need_aging);
+		nr_to_scan = get_nr_to_scan(lruvec, sc, swappiness);
 		if (!nr_to_scan)
-			goto done;
+			break;
 
 		delta = evict_folios(lruvec, sc, swappiness);
 		if (!delta)
-			goto done;
+			break;
 
 		scanned += delta;
 		if (scanned >= nr_to_scan)
@@ -5204,10 +5200,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		cond_resched();
 	}
 
-	/* see the comment in lru_gen_age_node() */
-	if (sc->nr_reclaimed - reclaimed >= MIN_LRU_BATCH && !need_aging)
-		sc->memcgs_need_aging = false;
-done:
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-- 
2.39.0.314.g84b9a713c41-goog

