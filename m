Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1797653B36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiLVEUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbiLVETw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:52 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F8248C0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:51 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so473075ilv.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=beHmgSLzXbJpunP6/l/NxN2gRkL01SNlutgba3N1Qk4=;
        b=KVc8L16VLUlCC+NuT6JsPGih4l/R7AmDZj1lk/UOA7MArp9oW8qRRRAEE/CHL9JFRE
         k6OsWrqWjs+QpUdCZOasfSH0W/8vTYtZg4cIuIuZakFH3G4roLVmeOi6mhpvzf9Rr5Pm
         sG5fevrhs8sxV9/VRvNIlM/H7Jgms4DgL73qCf1rTYOzPm5XuvhBd0DzLtCuuYYtxdBA
         J1jv7wKED+6OqtgdXvWWjtKi1MH+Ffly5IDAHlnvtXC9SvYAIXhRiM6OkvNDWfvhZlSl
         5hLGMSmwhFx6HT88lIBYT9dimMWP19Q8HexyCSyXhoj/OTlnPqL1UW4y0l5Xa0C+5wwP
         8Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=beHmgSLzXbJpunP6/l/NxN2gRkL01SNlutgba3N1Qk4=;
        b=m4Oa7pgMgcY4/8YZoBa4UTe1duh4tAYPT5qOIUBuuPKOnZskUkddipHxyzwPQXqUpR
         rQ/IW9yQMI263pNMkfxefqMTkWTjwWCj7kJ1EBmaeU8vVIE8XjptMpFySdHRG5DXo/VI
         3XILfw8Ywao5pUoo19PURnPkeU6hzFO8q/cMu3clv7uHNxsWWWOk9BZdKaPtadf+s/vk
         Kzq+d0YFundJu7UlF2soOwddHre4IcWEb6AkFTGZvibMpKijO+RRYtOhb/vViXDIklBU
         imQ+/CUmnJGS77y0vtLDVqy97vexISOkQTwNBGfwrBoLbhrE41ayRII0WJMF6zHPOzLj
         ChKQ==
X-Gm-Message-State: AFqh2kpGxtXoFuGzfdVM+n4ThopudpvmVo1DQCuMv0/73xb0n9djS9FS
        It2+rTZA7ZF2pe0cNzxaKs9hH+dnV+Y=
X-Google-Smtp-Source: AMrXdXvUCUZtzccxqK7kgdP2DV3G+AxrfRMA4CYtUSyCFpt/vaQ9J1+I6DbC09S/08Y40JAtOCDqp8u0BPU=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a05:6602:88a:b0:6df:5f05:40b6 with SMTP id
 f10-20020a056602088a00b006df5f0540b6mr286712ioz.74.1671682790897; Wed, 21 Dec
 2022 20:19:50 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:19:05 -0700
In-Reply-To: <20221222041905.2431096-1-yuzhao@google.com>
Message-Id: <20221222041905.2431096-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20221222041905.2431096-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 7/8] mm: multi-gen LRU: clarify scan_control flags
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
---
 mm/vmscan.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f22c8876473e..a9b318e1bdc2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3210,6 +3210,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
+	if (!sc->may_swap)
+		return 0;
+
 	if (!can_demote(pgdat->node_id, sc) &&
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
@@ -4236,7 +4239,7 @@ static void walk_mm(struct lruvec *lruvec, struct mm_struct *mm, struct lru_gen_
 	} while (err == -EAGAIN);
 }
 
-static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat)
+static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat, bool force_alloc)
 {
 	struct lru_gen_mm_walk *walk = current->reclaim_state->mm_walk;
 
@@ -4244,7 +4247,7 @@ static struct lru_gen_mm_walk *set_mm_walk(struct pglist_data *pgdat)
 		VM_WARN_ON_ONCE(walk);
 
 		walk = &pgdat->mm_walk;
-	} else if (!pgdat && !walk) {
+	} else if (!walk && force_alloc) {
 		VM_WARN_ON_ONCE(current_is_kswapd());
 
 		walk = kzalloc(sizeof(*walk), __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
@@ -4430,7 +4433,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 		goto done;
 	}
 
-	walk = set_mm_walk(NULL);
+	walk = set_mm_walk(NULL, true);
 	if (!walk) {
 		success = iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
@@ -4499,8 +4502,6 @@ static bool lruvec_is_reclaimable(struct lruvec *lruvec, struct scan_control *sc
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
 
-	VM_WARN_ON_ONCE(sc->memcg_low_reclaim);
-
 	/* see the comment on lru_gen_folio */
 	gen = lru_gen_from_seq(min_seq[LRU_GEN_FILE]);
 	birth = READ_ONCE(lruvec->lrugen.timestamps[gen]);
@@ -4756,12 +4757,8 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
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
@@ -4858,9 +4855,8 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
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
@@ -5120,9 +5116,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
 
-	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg) ||
-	    (mem_cgroup_below_low(sc->target_mem_cgroup, memcg) &&
-	     !sc->memcg_low_reclaim))
+	if (mem_cgroup_below_min(sc->target_mem_cgroup, memcg))
 		return 0;
 
 	if (!should_run_aging(lruvec, max_seq, sc, can_swap, &nr_to_scan))
@@ -5150,17 +5144,14 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
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
@@ -5291,12 +5282,13 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	struct blk_plug plug;
 
 	VM_WARN_ON_ONCE(global_reclaim(sc));
+	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
 	lru_add_drain();
 
 	blk_start_plug(&plug);
 
-	set_mm_walk(lruvec_pgdat(lruvec));
+	set_mm_walk(NULL, sc->proactive);
 
 	if (try_to_shrink_lruvec(lruvec, sc))
 		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
@@ -5352,11 +5344,19 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 
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
 
@@ -5374,7 +5374,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
-
+done:
 	/* kswapd should never fail */
 	pgdat->kswapd_failures = 0;
 }
@@ -5943,7 +5943,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
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

