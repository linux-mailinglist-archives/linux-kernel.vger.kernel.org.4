Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F6F652A57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbiLUANd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiLUAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:12:50 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3661EC56
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-45e2e1d6d2fso11542357b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzZZ7Pl3axic12Be6+Sv18aJSfohVNrr9lclEYQlfdA=;
        b=BCLok8Tn1XTfQ1A8R6b7C5Ad/joLM/zJ52a9in4TvZQxFue8D9E+7yIFrIer98Eqj4
         IT7c2Y7QptfbqvSrriBtpoLImc2rymZxl/aSRPL6iprTxYnoZ8GkLd6dpko1fT3qYpl3
         j5aIasFOsO6exHTJNjrCfB/WGow8hUzKcSXoqt+CqvmuLFzcGhf9io/+i2C6Ss/e2mQV
         laXDGRPFMp9s74HpTyKqXCKzcyFji0RrSIXbOT0lve1VJZR/j3f6ef/UFnLZwT02BvE1
         YIHTiq2hbzPBFT/mmXk6dbtrE2QduGkU5U0EBz06MoDqQSe1Flej1GG8CgMufMWwSm9d
         /umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzZZ7Pl3axic12Be6+Sv18aJSfohVNrr9lclEYQlfdA=;
        b=HRQpnSJ32ZsK5JXbnS4BTt4fSNQvA5It+vycF3WXox6EN52oqv3ZEBoegxPkwC4mmn
         jJmfnQeMQbQZBJaAed6QCm47KMN/aCqOtTwRBnofWsN0LhbM2xh5BgL/NQEgVYJK7aBq
         /6dOY6NuZ1J7J40LTN/hE9hwanvxqDI2qhnNEyZz1BjXuBl7vSOXG8S+ZuH+d7oRpYC0
         YQ3/uPlVaNj6/WquJY/18qGO2YzLiwBoIZ9ESNdJ3ijtD3bUepZ12Mm7Ma7QaSJwdGzu
         IXPW9tQmnST/doG+0nNP60TWvUarEZ/8pfTsas3argfY7j0mTKx4wyTerIzapw3qwKgV
         7OLw==
X-Gm-Message-State: ANoB5plkFUNSEzCWB5Q8BDKQ7p0iW0lcKD0zW9BsoeWsPjYb4sLVTuYR
        YM6ATquCMM+B0yJlklVEAv3aasyJgd8=
X-Google-Smtp-Source: AA0mqf6rnjM1gkiEH2cSoCaqtQ9HV2F4qXN/ljYPU8+/Y/VmAHrOUkrolCEScMqy2/MGCZCUbXIT85hA/c0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a81:f90d:0:b0:404:7030:e1c0 with SMTP id
 x13-20020a81f90d000000b004047030e1c0mr6939777ywm.53.1671581565140; Tue, 20
 Dec 2022 16:12:45 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:12:07 -0700
In-Reply-To: <20221221001207.1376119-1-yuzhao@google.com>
Message-Id: <20221221001207.1376119-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20221221001207.1376119-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 7/8] mm: multi-gen LRU: clarify scan_control flags
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

Among the flags in scan_control:
1. sc->may_swap, which indicates swap constraint due to memsw.max, is
   supported as usual.
2. sc->proactive, which indicates reclaim by memory.reclaim, may not
   opportunistically skip the aging path, since it is considered less
   latency sensitive.
3. !(sc->gfp_mask & __GFP_IO), which indicates IO constraint, lowers
   swappiness to prioritize file LRU, since clean file folios are more
   likely to exist.
4. sc->may_writepage and sc->may_unmap, which indicates opportunistic
   reclaim, are rejected, since unmapped clean folios are already
   prioritized. Scanning for more of them is likely futile and can
   cause high reclaim latency when there is a large number of memcgs.

The rest are handled by the existing code.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Change-Id: Ic3b1a13ad1f88853427962b37669aa99942c9fb5
---
 mm/vmscan.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index fd837a13617c..308c3c16d81d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3209,6 +3209,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
+	if (!sc->may_swap)
+		return 0;
+
 	if (!can_demote(pgdat->node_id, sc) &&
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
@@ -4238,7 +4241,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	} while (err == -EAGAIN);
 }
 
-static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat)
+static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat, bool force_alloc)
 {
 	struct lru_gen_mm_walk *walk = current->reclaim_state->mm_walk;
 
@@ -4246,7 +4249,7 @@ static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat)
 		VM_WARN_ON_ONCE(walk);
 
 		walk = &pgdat->mm_walk;
-	} else if (!pgdat && !walk) {
+	} else if (!walk && force_alloc) {
 		VM_WARN_ON_ONCE(current_is_kswapd());
 
 		walk = kzalloc(sizeof(*walk), __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
@@ -4432,7 +4435,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 		goto done;
 	}
 
-	walk = set_mm_walk(NULL);
+	walk = set_mm_walk(NULL, true);
 	if (!walk) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
@@ -4501,8 +4504,6 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	VM_WARN_ON_ONCE(sc->memcg_low_reclaim);
-
 	/* see the comment on lru_gen_folio */
 	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
 	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
@@ -4758,12 +4759,8 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
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
@@ -4860,9 +4857,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
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
@@ -5122,9 +5118,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
 
-	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
-	    (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
-	     !sc->memcg_low_reclaim))
+	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
 		return 0;
 
 	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
@@ -5152,17 +5146,14 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
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
@@ -5293,12 +5284,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	struct blk_plug plug;
 
 	VM_WARN_ON_ONCE(global_reclaim(sc));
+	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
 	lru_add_drain();
 
 	blk_start_plug(&plug);
 
-	set_mm_walk(lruvec_pgdat(lruvec));
+	set_mm_walk(NULL, sc->proactive);
 
 	if (try_to_shrink_lruvec(lruvec, sc))
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
@@ -5354,11 +5346,19 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 
 	VM_WARN_ON_ONCE(!global_reclaim(sc));
 
+	/*
+	 * Unmapped clean folios are already prioritized. Scanning for more of
+	 * them is likely futile and can cause high reclaim latency when there
+	 * is a large number of memcgs.
+	 */
+	if (!sc->may_writepage || !sc->may_unmap)
+		goto done;
+
 	lru_add_drain();
 
 	blk_start_plug(&plug);
 
-	set_mm_walk(pgdat);
+	set_mm_walk(pgdat, sc->proactive);
 
 	set_initial_priority(pgdat, sc);
 
@@ -5376,7 +5376,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-
+done:
 	/* kswapd should never fail */
 	pgdat->kswapd_failures = 0;
 }
@@ -5945,7 +5945,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	flags = memalloc_noreclaim_save();
 	blk_start_plug(&plug);
-	if (!set_mm_walk(NULL)) {
+	if (!set_mm_walk(NULL, true)) {
 		err = -ENOMEM;
 		goto done;
 	}
-- 
2.39.0.314.g84b9a713c41-goog

