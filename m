Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA65763FAAE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLAWjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiLAWjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:43 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3DC82E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:42 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j6-20020a05690212c600b006fc7f6e6955so2360856ybu.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oH9JeQGaNGGHkuIZZHdf9cs3YAnSP1jBnMbSTvH4Xu8=;
        b=LA2DUDHiBc/zGzdpbHz3fR7TpBuWLu0tDpwMzDx05c1rOPOfYc4jBdJYRw/TauLXGh
         Lk5iAEgXtO2shh9reDNWP4Mxf5lF2lQ3dT4PpqiviZ/oHJhGd2BgwkhKd4hD8QgjTRBF
         Yc4O3BnKUXLPRZBem3ev1rOA2DJN9OLOC6qyOcP8czyp71nf5Yq8DES/hP5Mpbf/IsCm
         sM0dmYkSDklz9GXgvLxmSxx9f79bTV396VtjGVjwhXSoQx0lrwRKEYuZ2LBFZPhmASPi
         XBaJ5VBd8wdU0dmxhd5slcb2TFgkl/xZ7LYKkJG0EsviVWUhBjmOMi/g1304f2fFBoM4
         r9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oH9JeQGaNGGHkuIZZHdf9cs3YAnSP1jBnMbSTvH4Xu8=;
        b=fDhYtkZSRqfikJ9u/9GEXjmMvnDaRHVWvibOXQ96QhQbhukBW58GIzQ5TtiGeiMA/D
         tQZkBoeThRPapgdvz86Edh3mjVGjQDHENmBxWE5Fp6x0StUgSebBpV8057GI6Axa8G3V
         YS45ERNE1k3Uc084UWqJoYkk24Hlu4UumYmdZB4FW9SlQQUhMhlXq4faP2ojTk4ZN+3L
         gOaA7UoOtfXDgUyWB15m7t+CElDpuO9lS/TSGR3CwWPHhHvxUQnzJ0/ppNsPa7OeB+el
         oiC+N7/8GrOHIL1grrsLHAHtC3Qhogct5jxeK5Q94HzRJOPCwz/40R0wCeBnH21GrKUC
         1w6g==
X-Gm-Message-State: ANoB5pmpegfqE/GL4W2dmhw8HiAD8ZVHGLTkFjJsZbWQNk7uu2GqEWcM
        Cw+sLWNy589F2s5gjm8trilxs6+Uujg=
X-Google-Smtp-Source: AA0mqf4Ct34RtDuJ1bfnD9jfZlROZxvu1fiB0f922pkx7EJaRkowBwyRWMIeD4dhue1oO3k5Kf+Dba8hnwU=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a81:f53:0:b0:367:27b7:af89 with SMTP id
 80-20020a810f53000000b0036727b7af89mr66232818ywp.292.1669934381982; Thu, 01
 Dec 2022 14:39:41 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:17 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 1/8] mm: multi-gen LRU: rename lru_gen_struct
 to lru_gen_folio
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

The new name lru_gen_folio will be more distinct from the coming
lru_gen_memcg.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h |  4 ++--
 include/linux/mmzone.h    |  6 +++---
 mm/vmscan.c               | 34 +++++++++++++++++-----------------
 mm/workingset.c           |  4 ++--
 4 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index e8ed225d8f7c..f63968bd7de5 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -178,7 +178,7 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
 	int zone = folio_zonenum(folio);
 	int delta = folio_nr_pages(folio);
 	enum lru_list lru = type * LRU_INACTIVE_FILE;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE(old_gen != -1 && old_gen >= MAX_NR_GENS);
 	VM_WARN_ON_ONCE(new_gen != -1 && new_gen >= MAX_NR_GENS);
@@ -224,7 +224,7 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	int gen = folio_lru_gen(folio);
 	int type = folio_is_file_lru(folio);
 	int zone = folio_zonenum(folio);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen != -1, folio);
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5f74891556f3..bd3e4689f72d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -404,7 +404,7 @@ enum {
  * The number of pages in each generation is eventually consistent and therefore
  * can be transiently negative when reset_batch_size() is pending.
  */
-struct lru_gen_struct {
+struct lru_gen_folio {
 	/* the aging increments the youngest generation number */
 	unsigned long max_seq;
 	/* the eviction increments the oldest generation numbers */
@@ -461,7 +461,7 @@ struct lru_gen_mm_state {
 struct lru_gen_mm_walk {
 	/* the lruvec under reclaim */
 	struct lruvec *lruvec;
-	/* unstable max_seq from lru_gen_struct */
+	/* unstable max_seq from lru_gen_folio */
 	unsigned long max_seq;
 	/* the next address within an mm to scan */
 	unsigned long next_addr;
@@ -524,7 +524,7 @@ struct lruvec {
 	unsigned long			flags;
 #ifdef CONFIG_LRU_GEN
 	/* evictable pages divided into generations */
-	struct lru_gen_struct		lrugen;
+	struct lru_gen_folio		lrugen;
 	/* to concurrently iterate lru_gen_mm_list */
 	struct lru_gen_mm_state		mm_state;
 #endif
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9356a3ee639c..fcb4ac351f93 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3197,7 +3197,7 @@ static int get_nr_gens(struct lruvec *lruvec, int type)
 
 static bool __maybe_unused seq_is_valid(struct lruvec *lruvec)
 {
-	/* see the comment on lru_gen_struct */
+	/* see the comment on lru_gen_folio */
 	return get_nr_gens(lruvec, LRU_GEN_FILE) >= MIN_NR_GENS &&
 	       get_nr_gens(lruvec, LRU_GEN_FILE) <= get_nr_gens(lruvec, LRU_GEN_ANON) &&
 	       get_nr_gens(lruvec, LRU_GEN_ANON) <= MAX_NR_GENS;
@@ -3594,7 +3594,7 @@ struct ctrl_pos {
 static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 			  struct ctrl_pos *pos)
 {
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 	pos->refaulted = lrugen->avg_refaulted[type][tier] +
@@ -3609,7 +3609,7 @@ static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover)
 {
 	int hist, tier;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	bool clear = carryover ? NR_HIST_GENS == 1 : NR_HIST_GENS > 1;
 	unsigned long seq = carryover ? lrugen->min_seq[type] : lrugen->max_seq + 1;
 
@@ -3686,7 +3686,7 @@ static int folio_update_gen(struct folio *folio, int gen)
 static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
 {
 	int type = folio_is_file_lru(folio);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
@@ -3731,7 +3731,7 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 static void reset_batch_size(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
 {
 	int gen, type, zone;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	walk->batched = 0;
 
@@ -4248,7 +4248,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 {
 	int zone;
 	int remaining = MAX_LRU_BATCH;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
 	if (type == LRU_GEN_ANON && !can_swap)
@@ -4284,7 +4284,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 {
 	int gen, type, zone;
 	bool success = false;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	DEFINE_MIN_SEQ(lruvec);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -4305,7 +4305,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 		;
 	}
 
-	/* see the comment on lru_gen_struct */
+	/* see the comment on lru_gen_folio */
 	if (can_swap) {
 		min_seq[LRU_GEN_ANON] = min(min_seq[LRU_GEN_ANON], min_seq[LRU_GEN_FILE]);
 		min_seq[LRU_GEN_FILE] = max(min_seq[LRU_GEN_ANON], lrugen->min_seq[LRU_GEN_FILE]);
@@ -4327,7 +4327,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 {
 	int prev, next;
 	int type, zone;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	spin_lock_irq(&lruvec->lru_lock);
 
@@ -4385,7 +4385,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	bool success;
 	struct lru_gen_mm_walk *walk;
 	struct mm_struct *mm = NULL;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE(max_seq > READ_ONCE(lrugen->max_seq));
 
@@ -4450,7 +4450,7 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
 	unsigned long old = 0;
 	unsigned long young = 0;
 	unsigned long total = 0;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	for (type = !can_swap; type < ANON_AND_FILE; type++) {
@@ -4735,7 +4735,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
@@ -4835,7 +4835,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	int scanned = 0;
 	int isolated = 0;
 	int remaining = MAX_LRU_BATCH;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	VM_WARN_ON_ONCE(!list_empty(list));
@@ -5235,7 +5235,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
 static bool __maybe_unused state_is_valid(struct lruvec *lruvec)
 {
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	if (lrugen->enabled) {
 		enum lru_list lru;
@@ -5514,7 +5514,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 	int i;
 	int type, tier;
 	int hist = lru_hist_from_seq(seq);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
 		seq_printf(m, "            %10d", tier);
@@ -5564,7 +5564,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	unsigned long seq;
 	bool full = !debugfs_real_fops(m->file)->write;
 	struct lruvec *lruvec = v;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int nid = lruvec_pgdat(lruvec)->node_id;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
@@ -5818,7 +5818,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 	int i;
 	int gen, type, zone;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	lrugen->max_seq = MIN_NR_GENS + 1;
 	lrugen->enabled = lru_gen_enabled();
diff --git a/mm/workingset.c b/mm/workingset.c
index 1a86645b7b3c..fd666584515c 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -223,7 +223,7 @@ static void *lru_gen_eviction(struct folio *folio)
 	unsigned long token;
 	unsigned long min_seq;
 	struct lruvec *lruvec;
-	struct lru_gen_struct *lrugen;
+	struct lru_gen_folio *lrugen;
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
@@ -252,7 +252,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	unsigned long token;
 	unsigned long min_seq;
 	struct lruvec *lruvec;
-	struct lru_gen_struct *lrugen;
+	struct lru_gen_folio *lrugen;
 	struct mem_cgroup *memcg;
 	struct pglist_data *pgdat;
 	int type = folio_is_file_lru(folio);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

