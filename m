Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B67C634B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiKVX1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiKVX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:27:29 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC5312A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:27:25 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f90-20020a17090a706300b0021891e06ac9so5325184pjk.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b1fbKiUHSCNwPD8ziga3iKV48CqpH2MMrAKLftLto7I=;
        b=TNJuE9QixngDemTVcV8LxdV9Fc52J6wh30nypLm9Byy5taJTMboNJGYein5Jm0EtNn
         bZkVlSNr8Zoc/0Y8aysen+Hb44BiQfCFs57jmoz7AoImdPJVZaU57hBhATNiJwWjjZCb
         zLuWiMmnBoAGSzyGxKyfTTVDj5Ev8jaGAHmMDCC6y4VWb6Peu7wqTZyltIOqdqhlEhhX
         omZilehQqyOoRnxENDx4qlUNiShSJGIKeGGE9hzzR4G+3DrjCUZ5hrC0Rb+e7Km2+tOo
         I+k1EzjkpWSGWD9FF2lTfhkqkP1WJKWKqaZdPFzVhHlw21kfiu4XwH0RpPc6VBV83bGd
         SLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1fbKiUHSCNwPD8ziga3iKV48CqpH2MMrAKLftLto7I=;
        b=AusGHCCO6Q7Ls2GCh7oNbaol/sYcBm9ICyO6TYFjzq0QJHtv7dAZz9JvLuv7ri9glF
         sWjsyodWpa1WmhWvnqOkfNbYEpTk3g3VX8E6BQqhIm+tVIJgq22sJ2xjuSe+VSWmeEDM
         FTBeLxUmdeexnT7SNl6zhKuULuis86woWkASjYlhcHTtZgSXnvMNGE2i9RY9rePy+C07
         xD96PU8myoQiAk2hFx6w8gc8x1TXWcjSVG833TsMj7GwNNfpjnuPvTGPhZfzPGXnM8t1
         JoNkt4yKmLLGqbPlhKCvxsu9Eb/jLT2UAj8FQ+kG0tSurVAPqIOQ76CbnIJCT5dejpU9
         0rJw==
X-Gm-Message-State: ANoB5pmieO4ZTQ7yus/H2l7eDsAkEUagqa97roHCBBbXliWAnHnYkIaH
        JCu+cgccMlN8xpj0BB6HgiJJ60YekDd2wheV
X-Google-Smtp-Source: AA0mqf6FQtZ/FC14BI/LmA3GHrODClsyJxiEHgSkSaK+rKUrqXT72zONjUrwb1XbcUGgh/e7cT/maB0aslhmNMbM
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:e550:b0:184:dc59:cc9f with SMTP
 id n16-20020a170902e55000b00184dc59cc9fmr8913296plf.89.1669159644696; Tue, 22
 Nov 2022 15:27:24 -0800 (PST)
Date:   Tue, 22 Nov 2022 23:27:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122232721.2306102-1-yosryahmed@google.com>
Subject: [PATCH] mm: memcg: fix stale protection of reclaim target memcg
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
its standalone protection.

An example where this can happen is as follows. Consider the following
hierarchy with memory_recursiveprot:
ROOT
 |
 A (memory.min = 50M)
 |
 B (memory.min = 10M, memory.high = 40M)

Consider the following scenarion:
- B has memory.current = 35M.
- The system undergoes global reclaim (target memcg is NULL).
- B will have an effective min of 50M (all of A's unclaimed protection).
- B will not be reclaimed from.
- Now allocate 10M more memory in B, pushing it above it's high limit.
- The system undergoes memcg reclaim from B (target memcg is B)
- In shrink_node_memcgs(), we call mem_cgroup_calculate_protection(),
  which immediately returns for B without doing anything, as B is the
  target memcg, relying on mem_cgroup_protection() to ignore B's stale
  effective min (still 50M).
- Directly after mem_cgroup_calculate_protection(), we will call
  mem_cgroup_below_min(), which will read the stale effective min for B
  and skip it (instead of ignoring its protection as intended). In this
  case, it's really bad because we are not just considering B's
  standalone protection (10M), but we are reading a much higher stale
  protection (50M) which will cause us to not reclaim from B at all.

This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
e{low,min} state mutations from protection checks") which made
mem_cgroup_calculate_protection() only change the state without
returning any value. Before that commit, we used to return
MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
mem_cgroup_below_{min/low}() checks. After that commit we do not return
anything and we end up checking the min & low effective protections for
the target memcg, which are stale.

Add mem_cgroup_ignore_protection() that checks if we are reclaiming from
the target memcg, and call it in mem_cgroup_below_{min/low}() to ignore
the stale protection of the target memcg.

Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
 mm/vmscan.c                | 11 ++++++-----
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1644a24009c..22c9c9f9c6b1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -625,18 +625,32 @@ static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
 
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_ignore_protection(struct mem_cgroup *target,
+						struct mem_cgroup *memcg)
 {
-	if (!mem_cgroup_supports_protection(memcg))
+	/*
+	 * The target memcg's protection is ignored, see
+	 * mem_cgroup_calculate_protection() and mem_cgroup_protection()
+	 */
+	return target == memcg;
+}
+
+static inline bool mem_cgroup_below_low(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
+{
+	if (!mem_cgroup_supports_protection(memcg) ||
+	    mem_cgroup_ignore_protection(target, memcg))
 		return false;
 
 	return READ_ONCE(memcg->memory.elow) >=
 		page_counter_read(&memcg->memory);
 }
 
-static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_below_min(struct mem_cgroup *target,
+					struct mem_cgroup *memcg)
 {
-	if (!mem_cgroup_supports_protection(memcg))
+	if (!mem_cgroup_supports_protection(memcg) ||
+	    mem_cgroup_ignore_protection(target, memcg))
 		return false;
 
 	return READ_ONCE(memcg->memory.emin) >=
@@ -1209,12 +1223,19 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
-static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
+static inline bool mem_cgroup_ignore_protection(struct mem_cgroup *target,
+						struct mem_cgroup *memcg)
+{
+	return false;
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

