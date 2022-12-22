Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF367653B31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiLVEUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiLVETs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:48 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64D42409A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:43 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id i21-20020a056e021d1500b003041b04e3ebso493357ila.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKQYzYQslmsEvTKoQjl1Dy8mF9dw9swe45tpdyd96Iw=;
        b=hiWrjVIMR/8TnqO43W7ej+Q9H4D1PFrQLabYHgT2Fiz6OmgEI02DldL0TyORs8wy8n
         gzQMTWHm8bPRJjvpDLuxOYEX45gDXAal7JLlT/n18L6hVsg3dngAiFDK3Tn+rpAmxV6C
         +qEslUlp9HbFzqL4mgVM5b5RkhpgXYnyZ+ORq6Ita7eNOYYtIOGIzMuXESbtK6od4r1A
         jWAL37uhaZUkjPoemHffstsks18inpeSIQG+tf76sgmOk7/nZKU+GpNLKMjITNkpPHgq
         53hXe1Fl0FagiNNwuieSMmO4uKwVQ6ZUaFgxxLKWXGELNgQBxX2r4plz2LGpanIqTl28
         9HRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKQYzYQslmsEvTKoQjl1Dy8mF9dw9swe45tpdyd96Iw=;
        b=PRlp8cVIIu/KvRYLxUgPtydbE/mrlQcPDwL3236t48AAYx0SSbF3WnozHhBp97D/7U
         HSYFjtok1CoOaSyrmTcpWMHZCVsPij6WUu3OouLGv2QZZ8UM0rjxa6dZEa5br+mFYo9B
         QPrn9g5DrlHipqVOw7lJX0gXBRYc19cMJoO2TUgP6WBdTas8xJ846WdKGnEVqk1mgcYx
         BdO8j399T/ZRIxDktRXXl24fEL7k7EHm3amUZ+KPobv6Cqt5yy9qKGDE6OxSn+DRphJu
         JViuW+3nQW4RKg78nX2HHrcpGlcMvZcl6Iqc7+2T9AjNOIw5FWe8mtasBKUXXm8RqX4c
         V8kA==
X-Gm-Message-State: AFqh2kplAMfinwAPe16zTPgaWHCOBH3xJABqwcCi0jUWlDQYzD9n+6sK
        HyrWwTAN27iAkMHXO9O02cElIBavfxY=
X-Google-Smtp-Source: AMrXdXulwki9nSBxGR/8kwCpRV7uTwszRsuNMgerK7fVzStawG8GMbadC6mUNc3+9DnL5KUi28j6NQ4IuKE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a02:881a:0:b0:38a:141d:6564 with SMTP id
 r26-20020a02881a000000b0038a141d6564mr112099jai.140.1671682783226; Wed, 21
 Dec 2022 20:19:43 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:19:00 -0700
In-Reply-To: <20221222041905.2431096-1-yuzhao@google.com>
Message-Id: <20221222041905.2431096-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20221222041905.2431096-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 2/8] mm: multi-gen LRU: rename lrugen->lists[]
 to lrugen->folios[]
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

lru_gen_folio will be chained into per-node lists by the coming
lrugen->list.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 Documentation/mm/multigen_lru.rst |  8 ++++----
 include/linux/mm_inline.h         |  4 ++--
 include/linux/mmzone.h            |  8 ++++----
 mm/vmscan.c                       | 20 ++++++++++----------
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index d7062c6a8946..d8f721f98868 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -89,15 +89,15 @@ variables are monotonically increasing.
 
 Generation numbers are truncated into ``order_base_2(MAX_NR_GENS+1)``
 bits in order to fit into the gen counter in ``folio->flags``. Each
-truncated generation number is an index to ``lrugen->lists[]``. The
+truncated generation number is an index to ``lrugen->folios[]``. The
 sliding window technique is used to track at least ``MIN_NR_GENS`` and
 at most ``MAX_NR_GENS`` generations. The gen counter stores a value
 within ``[1, MAX_NR_GENS]`` while a page is on one of
-``lrugen->lists[]``; otherwise it stores zero.
+``lrugen->folios[]``; otherwise it stores zero.
 
 Each generation is divided into multiple tiers. A page accessed ``N``
 times through file descriptors is in tier ``order_base_2(N)``. Unlike
-generations, tiers do not have dedicated ``lrugen->lists[]``. In
+generations, tiers do not have dedicated ``lrugen->folios[]``. In
 contrast to moving across generations, which requires the LRU lock,
 moving across tiers only involves atomic operations on
 ``folio->flags`` and therefore has a negligible cost. A feedback loop
@@ -127,7 +127,7 @@ page mapped by this PTE to ``(max_seq%MAX_NR_GENS)+1``.
 Eviction
 --------
 The eviction consumes old generations. Given an ``lruvec``, it
-increments ``min_seq`` when ``lrugen->lists[]`` indexed by
+increments ``min_seq`` when ``lrugen->folios[]`` indexed by
 ``min_seq%MAX_NR_GENS`` becomes empty. To select a type and a tier to
 evict from, it first compares ``min_seq[]`` to select the older type.
 If both types are equally old, it selects the one whose first tier has
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f63968bd7de5..da38e3d962e2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -256,9 +256,9 @@ static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio,
 	lru_gen_update_size(lruvec, folio, -1, gen);
 	/* for folio_rotate_reclaimable() */
 	if (reclaiming)
-		list_add_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_add_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 	else
-		list_add(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_add(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 	return true;
 }
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1686fcc4ed01..6c96ee823dbd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -312,7 +312,7 @@ enum lruvec_flags {
  * They form a sliding window of a variable size [MIN_NR_GENS, MAX_NR_GENS]. An
  * offset within MAX_NR_GENS, i.e., gen, indexes the LRU list of the
  * corresponding generation. The gen counter in folio->flags stores gen+1 while
- * a page is on one of lrugen->lists[]. Otherwise it stores 0.
+ * a page is on one of lrugen->folios[]. Otherwise it stores 0.
  *
  * A page is added to the youngest generation on faulting. The aging needs to
  * check the accessed bit at least twice before handing this page over to the
@@ -324,8 +324,8 @@ enum lruvec_flags {
  * rest of generations, if they exist, are considered inactive. See
  * lru_gen_is_active().
  *
- * PG_active is always cleared while a page is on one of lrugen->lists[] so that
- * the aging needs not to worry about it. And it's set again when a page
+ * PG_active is always cleared while a page is on one of lrugen->folios[] so
+ * that the aging needs not to worry about it. And it's set again when a page
  * considered active is isolated for non-reclaiming purposes, e.g., migration.
  * See lru_gen_add_folio() and lru_gen_del_folio().
  *
@@ -412,7 +412,7 @@ struct lru_gen_folio {
 	/* the birth time of each generation in jiffies */
 	unsigned long timestamps[MAX_NR_GENS];
 	/* the multi-gen LRU lists, lazily sorted on eviction */
-	struct list_head lists[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
+	struct list_head folios[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the multi-gen LRU sizes, eventually consistent */
 	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];
 	/* the exponential moving average of refaulted */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 42507b36698e..d94d9fcabf36 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4271,7 +4271,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 
 	/* prevent cold/hot inversion if force_scan is true */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-		struct list_head *head = &lrugen->lists[old_gen][type][zone];
+		struct list_head *head = &lrugen->folios[old_gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
@@ -4282,7 +4282,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
 			new_gen = folio_inc_gen(lruvec, folio, false);
-			list_move_tail(&folio->lru, &lrugen->lists[new_gen][type][zone]);
+			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
 			if (!--remaining)
 				return false;
@@ -4310,7 +4310,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 			gen = lru_gen_from_seq(min_seq[type]);
 
 			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-				if (!list_empty(&lrugen->lists[gen][type][zone]))
+				if (!list_empty(&lrugen->folios[gen][type][zone]))
 					goto next;
 			}
 
@@ -4775,7 +4775,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 
 	/* promoted */
 	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
-		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
 
@@ -4784,7 +4784,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4796,7 +4796,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
 		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
 
@@ -4863,7 +4863,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
-		struct list_head *head = &lrugen->lists[gen][type][zone];
+		struct list_head *head = &lrugen->folios[gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
@@ -5264,7 +5264,7 @@ static bool __maybe_unused state_is_valid(struct lruvec *lruvec)
 		int gen, type, zone;
 
 		for_each_gen_type_zone(gen, type, zone) {
-			if (!list_empty(&lrugen->lists[gen][type][zone]))
+			if (!list_empty(&lrugen->folios[gen][type][zone]))
 				return false;
 		}
 	}
@@ -5309,7 +5309,7 @@ static bool drain_evictable(struct lruvec *lruvec)
 	int remaining = MAX_LRU_BATCH;
 
 	for_each_gen_type_zone(gen, type, zone) {
-		struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
+		struct list_head *head = &lruvec->lrugen.folios[gen][type][zone];
 
 		while (!list_empty(head)) {
 			bool success;
@@ -5843,7 +5843,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 		lrugen->timestamps[i] = jiffies;
 
 	for_each_gen_type_zone(gen, type, zone)
-		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
+		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
 
 	lruvec->mm_state.seq = MIN_NR_GENS;
 	init_waitqueue_head(&lruvec->mm_state.wait);
-- 
2.39.0.314.g84b9a713c41-goog

