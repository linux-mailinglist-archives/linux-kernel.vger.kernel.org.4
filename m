Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A0363FAAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiLAWju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiLAWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:45 -0500
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B2CBEC4A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:44 -0800 (PST)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-143c7a3da8aso1466329fac.23
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyO1Qwr5iuXNBK0f2JVvdJeRjkJhAMj/J0Y4E4uaOig=;
        b=dNnQaZ36J15h95JyHC5fHEfZ8ZxYNYeuOkea2FRUNH4ofc8ybEbvu0C+3jNROGAGjx
         ET/I4m66SPGpMXGXIoSfEOSD3BiQ0aW9yQx3hPapXImnfgpkzH83BAzalL0L/Wz6ieU/
         JnM7STf2jp0IlZjVSYadK5ma8tjpczwUZ2zurBu1S/CU4/NKDV7rynyv+cFS1pMvRhsX
         RKky6KUKGnCTPbHlc1nfg0BmJeou/YVeDmFF7Xm9xMjgqSJ86MBsBW4MWNiLz2SO7e14
         0vFzSim6libhGY7NPuc9s79tay49PyduByF7zRaryAO1gph0O3RcqDPJNVW+1Q+GqHXU
         bcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyO1Qwr5iuXNBK0f2JVvdJeRjkJhAMj/J0Y4E4uaOig=;
        b=F7JM2Rg6pWvEHuNvIk40mGynp5bV1W6L7YtBwEOdtonMehLbCPa66TDW9acioFYe92
         XVROBO1UILHvDeGxhOkn9Ft7MO6wxxuS/zSIHoXSR1KTxwm1pjTSr40uRuKPMK/BkhYl
         eE5s+5HbYo9oRXGAGayE352Zm+bsada7LSTdl3kfSWqtOzNasas2CloZpKPelLp5wsxj
         AQuCGW1B1pA1DwPPl5vQR9/9g9XmoXONo5dRRG+/tBX5owJwOW4KkIdFHS7dc/49sD4T
         RAxY/owNvPZQhQDD/bS5NaT1K+E9ZViQcMgnw/yplhNsLfBKQXZ5KPb2SRLVUsss+eI6
         APvQ==
X-Gm-Message-State: ANoB5pl3yW1xxW44o9n9ESmj76qV9Q/H7LLwMJfwNHxSRnlKFHlxsY2Y
        A0mLNGWWktXU9ygrEpHEbwM6V1XuFOE=
X-Google-Smtp-Source: AA0mqf79Do6KgRzfvlvo4ZPtaeuS0kkLhMuc256zE7w4YcoHXYCXaETiWgiz0x9lev3tiDw2SBXW5omV2+c=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a05:6870:7996:b0:143:6f82:e1f7 with SMTP id
 he22-20020a056870799600b001436f82e1f7mr18313733oab.175.1669934383415; Thu, 01
 Dec 2022 14:39:43 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:18 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 2/8] mm: multi-gen LRU: rename lrugen->lists[]
 to lrugen->folios[]
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
index bd3e4689f72d..02e432374471 100644
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
index fcb4ac351f93..ebab1ec3d400 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4256,7 +4256,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 
 	/* prevent cold/hot inversion if force_scan is true */
 	for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-		struct list_head *head = &lrugen->lists[old_gen][type][zone];
+		struct list_head *head = &lrugen->folios[old_gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
@@ -4267,7 +4267,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) != zone, folio);
 
 			new_gen = folio_inc_gen(lruvec, folio, false);
-			list_move_tail(&folio->lru, &lrugen->lists[new_gen][type][zone]);
+			list_move_tail(&folio->lru, &lrugen->folios[new_gen][type][zone]);
 
 			if (!--remaining)
 				return false;
@@ -4295,7 +4295,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
 			gen = lru_gen_from_seq(min_seq[type]);
 
 			for (zone = 0; zone < MAX_NR_ZONES; zone++) {
-				if (!list_empty(&lrugen->lists[gen][type][zone]))
+				if (!list_empty(&lrugen->folios[gen][type][zone]))
 					goto next;
 			}
 
@@ -4760,7 +4760,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 
 	/* promoted */
 	if (gen != lru_gen_from_seq(lrugen->min_seq[type])) {
-		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
 
@@ -4769,7 +4769,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 		int hist = lru_hist_from_seq(lrugen->min_seq[type]);
 
 		gen = folio_inc_gen(lruvec, folio, false);
-		list_move_tail(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 
 		WRITE_ONCE(lrugen->protected[hist][type][tier - 1],
 			   lrugen->protected[hist][type][tier - 1] + delta);
@@ -4781,7 +4781,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
 		gen = folio_inc_gen(lruvec, folio, true);
-		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
 	}
 
@@ -4848,7 +4848,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
-		struct list_head *head = &lrugen->lists[gen][type][zone];
+		struct list_head *head = &lrugen->folios[gen][type][zone];
 
 		while (!list_empty(head)) {
 			struct folio *folio = lru_to_folio(head);
@@ -5248,7 +5248,7 @@ static bool __maybe_unused state_is_valid(struct lruvec *lruvec)
 		int gen, type, zone;
 
 		for_each_gen_type_zone(gen, type, zone) {
-			if (!list_empty(&lrugen->lists[gen][type][zone]))
+			if (!list_empty(&lrugen->folios[gen][type][zone]))
 				return false;
 		}
 	}
@@ -5293,7 +5293,7 @@ static bool drain_evictable(struct lruvec *lruvec)
 	int remaining = MAX_LRU_BATCH;
 
 	for_each_gen_type_zone(gen, type, zone) {
-		struct list_head *head = &lruvec->lrugen.lists[gen][type][zone];
+		struct list_head *head = &lruvec->lrugen.folios[gen][type][zone];
 
 		while (!list_empty(head)) {
 			bool success;
@@ -5827,7 +5827,7 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 		lrugen->timestamps[i] = jiffies;
 
 	for_each_gen_type_zone(gen, type, zone)
-		INIT_LIST_HEAD(&lrugen->lists[gen][type][zone]);
+		INIT_LIST_HEAD(&lrugen->folios[gen][type][zone]);
 
 	lruvec->mm_state.seq = MIN_NR_GENS;
 	init_waitqueue_head(&lruvec->mm_state.wait);
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

