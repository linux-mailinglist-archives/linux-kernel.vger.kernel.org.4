Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F42A6355AF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbiKWJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbiKWJWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:22:00 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB810B437
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:42 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id pa16-20020a17090b265000b0020a71040b4cso8659540pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aeM6HrPa45A9LrLgfXlJ7cGalj3225I7akGQB6U5iS8=;
        b=VtKptZQ3mFwcqrOi51ztxB+DNgvHVrFNViBXIaddfpS5U7tazXMXjhQi+D0Kb5BOYB
         kWAX/pxmE4/9q3DRcQTU6r5l/tPiAevFUilKdbrsysVT3IDE0PmkaN5ndghki6ufiH4P
         N1WA3y4o1ra1Xwt6XDHrQJx8JwWvpvj4ygpSBlCYlACuCqEt2bkTACMt/BaZpCjLomq0
         T7rBx6TAjHgH302COt8/S0+/TBk9ZGp+uqj6IW5nN0j9hKQPSLdmZwQT79Gs+kwyrL0G
         UVfodtsTsXP5K4JI6FPWiS0q3sTEIxzK9lwT2qMViOzun5UhzjHa5z8rp0lumY6eouqQ
         h2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeM6HrPa45A9LrLgfXlJ7cGalj3225I7akGQB6U5iS8=;
        b=S36qMjix343SenFhg7+n9W+7Gb94cRRj+JzG3E2c901W/kCoVLpPmxMGFYOrLxGLkN
         GuYe9lRwBjAKx68p5m0reGiRoiHh3kki7MiBeHK8N5e6+zb8JnQIHpNuh9y71Lo4YX0P
         d3gLkSdZ6Q50erXhza3dmq5fFs3SidiIrrYhdhLo9TUI9VqbogzYKFSvFbbiXnEoAArD
         psWd+7YOzHvZ3el3i/YfgjHE7V1EbU0vF2WqAQa0GCvt8/Rw3pLe6m/X5D1ETh6X2/Vi
         MzRzVk35MYdUpcoNJqkH7bCiXVGrieEngSN8Cv1LIcHVLcZ+xkMUxA5hNaf4iXfZ/YNI
         DgaA==
X-Gm-Message-State: ANoB5pnelt6fT4IKwX4sPlbk13MhkFAbHBntT7wi8TkAtQRoC5iiPu0b
        5vl5U19VdW4f0atoUfc7a0IpXnx/Heqrw5y4
X-Google-Smtp-Source: AA0mqf7fGcAgpowKlMMo+r73S5L06hv/b6o0wgKy1fa3xGSp5eKRBsQn/AzZFtFKxD7Bs7qipf2cPe0Zcmk2hL46
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a62:4e81:0:b0:56c:12c0:a89b with SMTP
 id c123-20020a624e81000000b0056c12c0a89bmr28895540pfb.40.1669195301704; Wed,
 23 Nov 2022 01:21:41 -0800 (PST)
Date:   Wed, 23 Nov 2022 09:21:30 +0000
In-Reply-To: <20221123092132.2521764-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123092132.2521764-2-yosryahmed@google.com>
Subject: [PATCH v2 1/3] mm: memcg: fix stale protection of reclaim target memcg
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
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

During reclaim, mem_cgroup_calculate_protection() is used to determine
the effective protection (emin and elow) values of a memcg. The
protection of the reclaim target is ignored, but we cannot set their
effective protection to 0 due to a limitation of the current
implementation (see comment in mem_cgroup_protection()). Instead,
we leave their effective protection values unchaged, and later ignore it
in mem_cgroup_protection().

However, mem_cgroup_protection() is called later in
shrink_lruvec()->get_scan_count(), which is after the
mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
result, the stale effective protection values of the target memcg may
lead us to skip reclaiming from the target memcg entirely, before
calling shrink_lruvec(). This can be even worse with recursive
protection, where the stale target memcg protection can be higher than
its standalone protection. See two examples below (a similar version of
example (a) is added to test_memcontrol in a later patch).

(a) A simple example with proactive reclaim is as follows. Consider the
following hierarchy:
ROOT
 |
 A
 |
 B (memory.min = 10M)

Consider the following scenario:
- B has memory.current = 10M.
- The system undergoes global reclaim (or memcg reclaim in A).
- In shrink_node_memcgs():
  - mem_cgroup_calculate_protection() calculates the effective min (emin)
    of B as 10M.
  - mem_cgroup_below_min() returns true for B, we do not reclaim from B.
- Now if we want to reclaim 5M from B using proactive reclaim
  (memory.reclaim), we should be able to, as the protection of the
  target memcg should be ignored.
- In shrink_node_memcgs():
  - mem_cgroup_calculate_protection() immediately returns for B without
    doing anything, as B is the target memcg, relying on
    mem_cgroup_protection() to ignore B's stale effective min (still 10M).
  - mem_cgroup_below_min() reads the stale effective min for B and we
    skip it instead of ignoring its protection as intended, as we never
    reach mem_cgroup_protection().

(b) An more complex example with recursive protection is as follows.
Consider the following hierarchy with memory_recursiveprot:
ROOT
 |
 A (memory.min = 50M)
 |
 B (memory.min = 10M, memory.high = 40M)

Consider the following scenario:
- B has memory.current = 35M.
- The system undergoes global reclaim (target memcg is NULL).
- B will have an effective min of 50M (all of A's unclaimed protection).
- B will not be reclaimed from.
- Now allocate 10M more memory in B, pushing it above it's high limit.
- The system undergoes memcg reclaim from B (target memcg is B).
- Like example (a), we do nothing in mem_cgroup_calculate_protection(),
  then call mem_cgroup_below_min(), which will read the stale effective
  min for B (50M) and skip it. In this case, it's even worse because we
  are not just considering B's standalone protection (10M), but we are
  reading a much higher stale protection (50M) which will cause us to not
  reclaim from B at all.

This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
e{low,min} state mutations from protection checks") which made
mem_cgroup_calculate_protection() only change the state without
returning any value. Before that commit, we used to return
MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
mem_cgroup_below_{min/low}() checks. After that commit we do not return
anything and we end up checking the min & low effective protections for
the target memcg, which are stale.

Update mem_cgroup_supports_protection() to also check if we are
reclaiming from the target, and rename it to mem_cgroup_unprotected()
(now returns true if we should not protect the memcg, much simpler logic).

Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h | 31 +++++++++++++++++++++----------
 mm/vmscan.c                | 11 ++++++-----
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1644a24009c..d3c8203cab6c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -615,28 +615,32 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 				     struct mem_cgroup *memcg);
 
-static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
+					  struct mem_cgroup *memcg)
 {
 	/*
 	 * The root memcg doesn't account charges, and doesn't support
-	 * protection.
+	 * protection. The target memcg's protection is ignored, see
+	 * mem_cgroup_calculate_protection() and mem_cgroup_protection()
 	 */
-	return !mem_cgroup_disabled() && !mem_cgroup_is_root(memcg);
-
+	return mem_cgroup_disabled() || mem_cgroup_is_root(memcg) ||
+		memcg == target;
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
-	if (!mem_cgroup_supports_protection(memcg))
+	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
 
-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
-	if (!mem_cgroup_supports_protection(memcg))
+	if (mem_cgroup_unprotected(target, memcg))
 		return false;
 
 	return READ_ONCE(memcg->memory.emin) >=
@@ -1209,12 +1213,19 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
+					  struct mem_cgroup *memcg)
+{
+	return true;
+}
+static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
 	return false;
 }
 
-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
 	return false;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 04d8b88e5216..79ef0fe67518 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4486,7 +4486,7 @@ static bool age_lruvec(struct lruvec *lruvec, struct scan_control *sc, unsigned
 
 	mem_cgroup_calculate_protection(NULL, memcg);
 
-	if (mem_cgroup_below_min(memcg))
+	if (mem_cgroup_below_min(NULL, memcg))
 		return false;
 
 	need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, swappiness, &nr_to_scan);
@@ -5047,8 +5047,9 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
 	DEFINE_MAX_SEQ(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	if (mem_cgroup_below_min(memcg) ||
-	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
+	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
+	    (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
+	     !sc->memcg_low_reclaim))
 		return 0;
 
 	*need_aging = should_run_aging(lruvec, max_seq, min_seq, sc, can_swap, &nr_to_scan);
@@ -6048,13 +6049,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
-		if (mem_cgroup_below_min(memcg)) {
+		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			/*
 			 * Hard protection.
 			 * If there is no reclaimable memory, OOM.
 			 */
 			continue;
-		} else if (mem_cgroup_below_low(memcg)) {
+		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
 			/*
 			 * Soft protection.
 			 * Respect the protection only as long as
-- 
2.38.1.584.g0f3c55d4c2-goog

