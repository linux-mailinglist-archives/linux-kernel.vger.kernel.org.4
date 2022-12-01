Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124D963FAB2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiLAWkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLAWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C49C8D14
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:46 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a5-20020a25af05000000b006e450a5e507so3216811ybh.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrU5wWNyp037AuwQOyxOk5gGg4D4Otqw3lyJ0b3KgV0=;
        b=Fdzn6r94xdaJ3DYryMEzAO2wZaCb3ia0dUUTL355o0LS86kDT6edU1HKYUg7PNhqZy
         I9m0jJg2PTx+tewcDGBo7oRNCI7tqcVMEry+t9RkrR65vT7UXdxMEGv16i8uUcZ3qRbU
         tZMX/qVM/KuBDNuQCgHMqf/xq3opU4yvZkoGNxUjqZo7z8U8Vco7lsoU2skM1iK7H91e
         DItAuQUBv5669YJUp4mpAJCFlAFZnPDIpBR0uEXZD/OINx4kdF8uJoptDFDiIri/UPab
         mP1Dh6M+1e2nBxcZmUZZThmM2P6sxACHQWRMMzm6rEQE1vnpQ1heHtIw/MvgBNx4W8K6
         rU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hrU5wWNyp037AuwQOyxOk5gGg4D4Otqw3lyJ0b3KgV0=;
        b=k3/4k+lX8hy8bGpDVFjJKsCR5CqFiQhA3ZFdaYUHwp8TgZ7ZM08rBLw5CYFxofXjIe
         yJmGBLuCRz8DJBl5WL0+/e9UPNMTA27VcVn4GnnsE1iyim8r2EgIN6YUIG6EUCUMcUnS
         kwdt/qsbXswwBWTr76DfI85jATt6QT2pE+Jrjuon+GfL+Jr9jY4m6+rWDWujA7e6jNzB
         IHDT7FKVuybNutQSCyaIk/CByMcRd/kw63nDyXXxehaGmiWXDOVLHvOG/Gpkh+ncjrU3
         JJdZLmAoqIICxCMppcemT2/JrbuIvJxGxC5Of53vvIdFb3z49Qv143UxqbEkaT0s0JzP
         +4gA==
X-Gm-Message-State: ANoB5pnxw2X/Y0UZalEHqtOSRntP2d1cWBP086QB4WaC4BTMwTCef6DX
        IPvVHpwuD3BZ8yy9YuStb4A2AYlf4ws=
X-Google-Smtp-Source: AA0mqf4N5mdmhx7yGoZLCT/j5w4kIAAXDnjMlRXuMQDJ3xosebIYlBF5Zlqewc9W8Y7fMlPj7ciT4XCqXlg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a25:2141:0:b0:6fa:c7e7:a572 with SMTP id
 h62-20020a252141000000b006fac7e7a572mr8377083ybh.456.1669934386046; Thu, 01
 Dec 2022 14:39:46 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:20 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 4/8] mm: multi-gen LRU: remove aging fairness safeguard
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
---
 mm/vmscan.c | 150 +++++++++++++++++++++++++---------------------------
 1 file changed, 71 insertions(+), 79 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index d714a777c88b..67967a4b18a9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -137,7 +137,6 @@ struct scan_control {
 
 #ifdef CONFIG_LRU_GEN
 	/* help kswapd make better choices among multiple memcgs */
-	unsigned int memcgs_need_aging:1;
 	unsigned long last_reclaimed;
 #endif
 
@@ -4453,7 +4452,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	return true;
 }
 
-static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsigned long *min_seq,
+static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
 			     struct scan_control *sc, bool can_swap, unsigned long *nr_to_scan)
 {
 	int gen, type, zone;
@@ -4462,6 +4461,13 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
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
@@ -4490,8 +4496,6 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
 	 * stalls when the number of generations reaches MIN_NR_GENS. Hence, the
 	 * ideal number of generations is MIN_NR_GENS+1.
 	 */
-	if (min_seq[!can_swap] + MIN_NR_GENS > max_seq)
-		return true;
 	if (min_seq[!can_swap] + MIN_NR_GENS < max_seq)
 		return false;
 
@@ -4510,40 +4514,54 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
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
 
-	if (mem_cgroup_below_min(memcg))
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
+	return !mem_cgroup_below_min(memcg);
 }
 
 /* to protect the working set of the last N jiffies */
@@ -4552,46 +4570,32 @@ static unsigned long lru_gen_min_ttl __read_mostly;
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
@@ -5099,33 +5103,27 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
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
 
 	if (mem_cgroup_below_min(memcg) ||
 	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
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
@@ -5144,9 +5142,7 @@ static unsigned long get_nr_to_reclaim(struct scan_control *sc)
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
-	bool need_aging = false;
 	unsigned long scanned = 0;
-	unsigned long reclaimed = sc->nr_reclaimed;
 	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
 	lru_add_drain();
@@ -5167,13 +5163,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
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
@@ -5185,10 +5181,6 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		cond_resched();
 	}
 
-	/* see the comment in lru_gen_age_node() */
-	if (sc->nr_reclaimed - reclaimed >= MIN_LRU_BATCH && !need_aging)
-		sc->memcgs_need_aging = false;
-done:
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

