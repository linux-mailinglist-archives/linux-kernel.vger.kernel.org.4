Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BBC653B30
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbiLVEUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiLVETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF40240BD
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g9-20020a25bdc9000000b0073727a20239so694802ybk.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4TcA/s/8t2bWWYZiBbVtrtPPkaRo7qGxumdUIvl0ek=;
        b=bG75aKyCcpU6cfyYWl1zzl+PIHqX6D0BG6nxb9rq9djraywRphLGdqUWMK51qHsbkf
         RveqneQH3WAqaehOnRBvR2w5bCgf5mzxRado8Oh6VSctqdjsCEFrOOexrzSXs2qvgtFT
         kHnNKxLUvsQhwuzNWinlPQpfNWtkzLBG6zMQD9e1a1HYzJ0FaudoTt5fpMoXJZweb2/r
         +HNQI//INOZLvHI9743lEW9/m2zl5FHTzKUCdO9JVLWtJs8dJsrQNHLKGZEIIalz/7Jy
         MOQf4F4jjkErPcUB6fC56tXt6SzPyyxDgfg/2YBhz/zsqeAgAFPSOYgvaHX5Pd0F4KjU
         bLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N4TcA/s/8t2bWWYZiBbVtrtPPkaRo7qGxumdUIvl0ek=;
        b=5Orl9l20Y7wUl+3gdnhGtgGN66jLfEyrwcxDP89fralQFeV22ZJP8OUonLGHaDBQ7T
         Jz2SbVzw874a11jcmDY5PG+rD+uT/IQFCYwCdOIEh3A9mVxAmYZaUIzQnBNfNb2uslGm
         YxGRJS76mXwA4uwna69llIFTQMBGILgIHB6m4se9CyiXMih6Qg5Idd6uGcsL4T5Nb4nG
         n2fJaWbaY8CAOgrz6BYZitPCMUnkQ3GEUrCnaNftOrnEBo1Yfvk58HskHtgP/izkZO0K
         J642YE2dL+mMptbGE9hxUb8OgyTSsP/BMNG0KMTIblDOyFPMLf8z/fsZ1pa4kkupFVNx
         sIFA==
X-Gm-Message-State: AFqh2kq5PZP9JwD+dChaiSFouPvP0aEvQHf+jr32xs54H7ORKlAINic2
        KRyaw8RrrOUc+Cx9mNJlAos7+//kZXQ=
X-Google-Smtp-Source: AMrXdXvFsC2yaW02qCDMqrDqFDN0SJMRekr525L1lxoDa69bWaQeswqLxQLsHlKx5usxhH753zJinh3PyRI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a0d:db8d:0:b0:329:88ec:ba20 with SMTP id
 d135-20020a0ddb8d000000b0032988ecba20mr499754ywe.492.1671682781586; Wed, 21
 Dec 2022 20:19:41 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:18:59 -0700
In-Reply-To: <20221222041905.2431096-1-yuzhao@google.com>
Message-Id: <20221222041905.2431096-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20221222041905.2431096-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 1/8] mm: multi-gen LRU: rename lru_gen_struct
 to lru_gen_folio
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
index cd28a100d9e4..1686fcc4ed01 100644
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
index e83d2a74e942..42507b36698e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3215,7 +3215,7 @@ static int get_nr_gens(struct lruvec *lruvec, int type)
 
 static bool __maybe_unused seq_is_valid(struct lruvec *lruvec)
 {
-	/* see the comment on lru_gen_struct */
+	/* see the comment on lru_gen_folio */
 	return get_nr_gens(lruvec, LRU_GEN_FILE) >= MIN_NR_GENS &&
 	       get_nr_gens(lruvec, LRU_GEN_FILE) <= get_nr_gens(lruvec, LRU_GEN_ANON) &&
 	       get_nr_gens(lruvec, LRU_GEN_ANON) <= MAX_NR_GENS;
@@ -3612,7 +3612,7 @@ struct ctrl_pos {
 static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 			  struct ctrl_pos *pos)
 {
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 	pos->refaulted = lrugen->avg_refaulted[type][tier] +
@@ -3627,7 +3627,7 @@ static void read_ctrl_pos(struct lruvec *lruvec, int type, int tier, int gain,
 static void reset_ctrl_pos(struct lruvec *lruvec, int type, bool carryover)
 {
 	int hist, tier;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	bool clear = carryover ? NR_HIST_GENS == 1 : NR_HIST_GENS > 1;
 	unsigned long seq = carryover ? lrugen->min_seq[type] : lrugen->max_seq + 1;
 
@@ -3704,7 +3704,7 @@ static int folio_update_gen(struct folio *folio, int gen)
 static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
 {
 	int type = folio_is_file_lru(folio);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
 
@@ -3749,7 +3749,7 @@ static void update_batch_size(struct lru_gen_mm_walk *walk, struct folio *folio,
 static void reset_batch_size(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
 {
 	int gen, type, zone;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	walk->batched = 0;
 
@@ -4263,7 +4263,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 {
 	int zone;
 	int remaining = MAX_LRU_BATCH;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int new_gen, old_gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
 	if (type == LRU_GEN_ANON && !can_swap)
@@ -4299,7 +4299,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 {
 	int gen, type, zone;
 	bool success = false;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	DEFINE_MIN_SEQ(lruvec);
 
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -4320,7 +4320,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 		;
 	}
 
-	/* see the comment on lru_gen_struct */
+	/* see the comment on lru_gen_folio */
 	if (can_swap) {
 		min_seq[LRU_GEN_ANON] = min(min_seq[LRU_GEN_ANON], min_seq[LRU_GEN_FILE]);
 		min_seq[LRU_GEN_FILE] = max(min_seq[LRU_GEN_ANON], lrugen->min_seq[LRU_GEN_FILE]);
@@ -4342,7 +4342,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_scan)
 {
 	int prev, next;
 	int type, zone;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	spin_lock_irq(&lruvec->lru_lock);
 
@@ -4400,7 +4400,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	bool success;
 	struct lru_gen_mm_walk *walk;
 	struct mm_struct *mm = NULL;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE(max_seq > READ_ONCE(lrugen->max_seq));
 
@@ -4465,7 +4465,7 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq, unsig
 	unsigned long old = 0;
 	unsigned long young = 0;
 	unsigned long total = 0;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	for (type = !can_swap; type < ANON_AND_FILE; type++) {
@@ -4750,7 +4750,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 	int delta = folio_nr_pages(folio);
 	int refs = folio_lru_refs(folio);
 	int tier = lru_tier_from_refs(refs);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	VM_WARN_ON_ONCE_FOLIO(gen >= MAX_NR_GENS, folio);
 
@@ -4850,7 +4850,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	int scanned = 0;
 	int isolated = 0;
 	int remaining = MAX_LRU_BATCH;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
 	VM_WARN_ON_ONCE(!list_empty(list));
@@ -5251,7 +5251,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
 static bool __maybe_unused state_is_valid(struct lruvec *lruvec)
 {
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	if (lrugen->enabled) {
 		enum lru_list lru;
@@ -5530,7 +5530,7 @@ static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruvec,
 	int i;
 	int type, tier;
 	int hist = lru_hist_from_seq(seq);
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 
 	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
 		seq_printf(m, "            %10d", tier);
@@ -5580,7 +5580,7 @@ static int lru_gen_seq_show(struct seq_file *m, void *v)
 	unsigned long seq;
 	bool full = !debugfs_real_fops(m->file)->write;
 	struct lruvec *lruvec = v;
-	struct lru_gen_struct *lrugen = &lruvec->lrugen;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
 	int nid = lruvec_pgdat(lruvec)->node_id;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	DEFINE_MAX_SEQ(lruvec);
@@ -5834,7 +5834,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
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
2.39.0.314.g84b9a713c41-goog

