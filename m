Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDA63FAB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLAWkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiLAWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:59 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54348C8D23
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:51 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso2932097ioc.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kTMKVAj/Oh+vccsqCU2tEXECJUHGvjIuMZ7UFyAuXSQ=;
        b=p9A73kQcbZz1ANqWmvhw5+NM5qEJ/CxqmfOTbuM8N99+6VxSq84fgNdEKrkYUMhfip
         lmJ7n3tpZ/xBYecN/+afu94713QEcl98y0zYIkI4uliyG5z+zey1R4whwOYxlaXZq1ev
         iXqr4q76FmCk7Chco4K5Nn4pJdjDfFvZ+UnZhEhg27dtTFS2knF97a5Hh+tcQGlcrzWF
         5HehezoW0WwBj7eOEravZk8MgPyxJBkCkjfIjaTF+84Y5474JSAdj4pTUu8WGkXVUkFf
         3EQGxJowwQ69hNwTBwTFA2iadFF/UC+K3j+HtEI1P1tXd7RZVe7zRac6DENBVYtgl1OX
         DZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTMKVAj/Oh+vccsqCU2tEXECJUHGvjIuMZ7UFyAuXSQ=;
        b=oiikvXC6vv6JVsnC2/X26fTC/OZXz5Hm/CYlxNr4+4fPZPDnVZTeL20WfLyyqPzBxg
         sC7VyyNwaRkLwecnX5SGO7+/K+kB1yD27UzAaxsDMhgazjNh0u845FmqsY1FVC0gqxtQ
         ztsvWg6uwqLAAbB1SpnDeqWYlJzVU8NRL6hXF+WR4FAO3sIJxOUu95f4hTyzfAtULhla
         VDS9Isia3KGx6qa9omshNErW9386ciwZKCMfNFkif5TI8oAa0+pDbok0E9MXfialHrJu
         +99C7fcqXJVuSzT9em/ElCf0cU7f4HoR3OwIZ0fKchDg+qpVa9Ra0OoxbdY0xjkXu4Di
         Olcw==
X-Gm-Message-State: ANoB5pmF/53swns2EeBw9Rrs3GPrcU6OzjPIk8zXTTj7jHTdXVorGjId
        QIF7zziZZTtCaR8baPBIv/siUEuJ/GQ=
X-Google-Smtp-Source: AA0mqf5yFEPKGDamnbBfxGCbfkrztfXH9jamspDONGWjmXUOhNGY8g9PMUCJHu2QNdhDtVVz63AUcswnFg4=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a6b:6310:0:b0:6cf:713a:9526 with SMTP id
 p16-20020a6b6310000000b006cf713a9526mr23534665iog.111.1669934390720; Thu, 01
 Dec 2022 14:39:50 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:23 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 7/8] mm: multi-gen LRU: clarify scan_control flags
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

Among the flags in scan_control:
1. sc->may_swap, which indicates swap constraint due to memsw.max, is
   supported as usual.
2. sc->proactive, which indicates reclaim by memory.reclaim, may not
   opportunistically skip the aging path, since it is considered less
   latency sensitive.
3. !(sc->gfp_mask & __GFP_IO), which indicates IO constraint,
   prioritizes file LRU, since clean file folios are more likely to
   exist.
4. sc->may_writepage and sc->may_unmap, which indicates opportunistic
   reclaim, are rejected, since unmapped clean folios are already
   prioritized. Scanning for more of them is likely futile and can
   cause high reclaim latency when there is a large number of memcgs.

The rest are handled by the existing code.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 53 +++++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 44506eb96c9d..39724e7ae837 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3191,6 +3191,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
+	if (!sc->may_swap)
+		return 0;
+
 	if (!can_demote(pgdat->node_id, sc) &&
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
@@ -4220,7 +4223,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	} while (err == -EAGAIN);
 }
 
-static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat)
+static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat, bool force_alloc)
 {
 	struct lru_gen_mm_walk *walk = current->reclaim_state->mm_walk;
 
@@ -4228,7 +4231,7 @@ static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat)
 		VM_WARN_ON_ONCE(walk);
 
 		walk = &pgdat->mm_walk;
-	} else if (!pgdat && !walk) {
+	} else if (!walk && force_alloc) {
 		VM_WARN_ON_ONCE(current_is_kswapd());
 
 		walk = kzalloc(sizeof(*walk), __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
@@ -4414,7 +4417,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 		goto done;
 	}
 
-	walk = set_mm_walk(NULL);
+	walk = set_mm_walk(NULL, true);
 	if (!walk) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
@@ -4483,8 +4486,6 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	VM_WARN_ON_ONCE(sc->memcg_low_reclaim);
-
 	/* see the comment on lru_gen_folio */
 	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
 	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
@@ -4740,12 +4741,8 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 {
 	bool success;
 
-	/* unmapping inhibited */
-	if (!sc->may_unmap && folio_mapped(folio))
-		return false;
-
 	/* swapping inhibited */
-	if (!(sc->may_writepage && (sc->gfp_mask & __GFP_IO)) &&
+	if (!(sc->gfp_mask & __GFP_IO) &&
 	    (folio_test_dirty(folio) ||
 	     (folio_test_anon(folio) && !folio_test_swapcache(folio))))
 		return false;
@@ -4842,9 +4839,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	__count_vm_events(PGSCAN_ANON + type, isolated);
 
 	/*
-	 * There might not be eligible pages due to reclaim_idx, may_unmap and
-	 * may_writepage. Check the remaining to prevent livelock if it's not
-	 * making progress.
+	 * There might not be eligible folios due to reclaim_idx. Check the
+	 * remaining to prevent livelock if it's not making progress.
 	 */
 	return isolated || !remaining ? scanned : 0;
 }
@@ -5104,8 +5100,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
 
-	if (mem_cgroup_below_min(memcg) ||
-	    (mem_cgroup_below_low(memcg) && !sc->memcg_low_reclaim))
+	if (mem_cgroup_below_min(memcg))
 		return 0;
 
 	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
@@ -5133,17 +5128,14 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	long nr_to_scan;
 	unsigned long scanned = 0;
 	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
+	int swappiness = get_swappiness(lruvec, sc);
+
+	/* clean file folios are more likely to exist */
+	if (swappiness && !(sc->gfp_mask & __GFP_IO))
+		swappiness = 1;
 
 	while (true) {
 		int delta;
-		int swappiness;
-
-		if (sc->may_swap)
-			swappiness = get_swappiness(lruvec, sc);
-		else if (!cgroup_reclaim(sc) && get_swappiness(lruvec, sc))
-			swappiness = 1;
-		else
-			swappiness = 0;
 
 		nr_to_scan = get_nr_to_scan(lruvec, sc, swappiness);
 		if (nr_to_scan <= 0)
@@ -5274,12 +5266,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	struct blk_plug plug;
 
 	VM_WARN_ON_ONCE(global_reclaim(sc));
+	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
 	lru_add_drain();
 
 	blk_start_plug(&plug);
 
-	set_mm_walk(lruvec_pgdat(lruvec));
+	set_mm_walk(NULL, sc->proactive);
 
 	if (try_to_shrink_lruvec(lruvec, sc))
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
@@ -5335,11 +5328,19 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 
 	VM_WARN_ON_ONCE(!global_reclaim(sc));
 
+	/*
+	 * Unmapped clean folios are already prioritized. Scanning for more of
+	 * them is likely futile and can cause high reclaim latency when there
+	 * is a large number of memcgs.
+	 */
+	if (!sc->may_writepage || !sc->may_unmap)
+		return;
+
 	lru_add_drain();
 
 	blk_start_plug(&plug);
 
-	set_mm_walk(pgdat);
+	set_mm_walk(pgdat, sc->proactive);
 
 	set_initial_priority(pgdat, sc);
 
@@ -5926,7 +5927,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	flags = memalloc_noreclaim_save();
 	blk_start_plug(&plug);
-	if (!set_mm_walk(NULL)) {
+	if (!set_mm_walk(NULL, true)) {
 		err = -ENOMEM;
 		goto done;
 	}
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

