Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8111463FAB5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiLAWkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiLAWj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:59 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02279C8D35
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:49 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id a14-20020a921a0e000000b00302a8ffa8e5so3442814ila.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JCZZFKz+rtA84jog9pUPc6RPdcOi4cvnKeQ+Ve2rNdM=;
        b=UbxOmLnZ5CeZ3Y0MzRmmlwdvmYKIjsuMUamx2oP79/4va+oEb4B7R/7p0VP4IJedAl
         wNdeQrEeO+e1TvaVrCYs97gBWk3YjMUkA9QydxXsFM8h8GtRG3wz4vMNRE8hU3LBFKho
         O1uAuWtD6bV0unZ9PiJ2X4yKWh7OCr8u/42oG9FIkkEe6CYf73MSnKBBOF2qWIlRXyFy
         eX9akud1cXHdCZ0pPnRNlNDMUO19ONHKR8oPFjTQbh3zOeT1QU3rAyzuBBWCWIBFZH8a
         H0vfJ2SVtfk7UXfof0q9UQjdkIUycTz+qTSUFZKT2J79d72Q0qxcPWB6fW6OoC7LJGZF
         W8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCZZFKz+rtA84jog9pUPc6RPdcOi4cvnKeQ+Ve2rNdM=;
        b=wT08jBpzJm3a8UVNv8Rp3lrOtWiYdPgEXmJ5xisD7PEbU+8SIf02TelrSM9SH+tvzg
         t3Iug0amBR1AZqF48F34q+yL4SA2jnUkJ9IXbFd/lb9zoond5pGiA9In2LGtikDhDs3Y
         L5ErO9Y905blW2cjz16VNPcO1RRY7noLCBHdpYWvkvS9yN1CEa8gbSd2T7oS4qebcrQY
         IJbHPSxI4I7PPLSR9pFJm7vvLXQVNN+mCwzGoE1Hg3lCADPKNz8M6e179JHO9qAsJzOp
         RDfus+qMfK1l9uD9ppk17nMOpGagZq4BgErObFeXa0lzzICJNfQVxKMtm7RGAihtlUZ3
         KDdg==
X-Gm-Message-State: ANoB5pm3T9FiDZ/JMJLGmoq/5LOrpe6lE5bTLPAbmeUvZOKMGaHcqlP4
        FQ+jz+cG5AKMJQJ7OA8ze7IbXD7mqC4=
X-Google-Smtp-Source: AA0mqf4onMOQm2YVYn/d1w1wl510kavaaPK8p37Ecv7cCmu65OICv4uoE20H2JpjHHVQ2QAb3GCEuqZENvg=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a5d:8492:0:b0:6df:bdc1:2421 with SMTP id
 t18-20020a5d8492000000b006dfbdc12421mr5478726iom.116.1669934389347; Thu, 01
 Dec 2022 14:39:49 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:22 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-7-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 6/8] mm: multi-gen LRU: per-node lru_gen_folio lists
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

For each node, memcgs are divided into two generations: the old and
the young. For each generation, memcgs are randomly sharded into
multiple bins to improve scalability. For each bin, an RCU hlist_nulls
is virtually divided into three segments: the head, the tail and the
default.

An onlining memcg is added to the tail of a random bin in the old
generation. The eviction starts at the head of a random bin in the
old generation. The per-node memcg generation counter, whose reminder
(mod 2) indexes the old generation, is incremented when all its bins
become empty.

There are four operations:
1. MEMCG_LRU_HEAD, which moves an memcg to the head of a random bin
   in its current generation (old or young) and updates its "seg" to
   "head";
2. MEMCG_LRU_TAIL, which moves an memcg to the tail of a random bin
   in its current generation (old or young) and updates its "seg" to
   "tail";
3. MEMCG_LRU_OLD, which moves an memcg to the head of a random bin in
   the old generation, updates its "gen" to "old" and resets its "seg"
   to "default";
4. MEMCG_LRU_YOUNG, which moves an memcg to the tail of a random bin
   in the young generation, updates its "gen" to "young" and resets
   its "seg" to "default".

The events that trigger the above operations are:
1. Exceeding the soft limit, which triggers MEMCG_LRU_HEAD;
2. The first attempt to reclaim an memcg below low, which triggers
   MEMCG_LRU_TAIL;
3. The first attempt to reclaim an memcg below reclaimable size
   threshold, which triggers MEMCG_LRU_TAIL;
4. The second attempt to reclaim an memcg below reclaimable size
   threshold, which triggers MEMCG_LRU_YOUNG;
5. Attempting to reclaim an memcg below min, which triggers
   MEMCG_LRU_YOUNG;
6. Finishing the aging on the eviction path, which triggers
   MEMCG_LRU_YOUNG;
7. Offlining an memcg, which triggers MEMCG_LRU_OLD.

Note that memcg LRU only applies to global reclaim. For memcg reclaim,
it still relies on mem_cgroup_iter().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/memcontrol.h |  10 +
 include/linux/mm_inline.h  |  17 ++
 include/linux/mmzone.h     | 113 ++++++++++-
 mm/memcontrol.c            |  16 ++
 mm/page_alloc.c            |   1 +
 mm/vmscan.c                | 373 +++++++++++++++++++++++++++++++++----
 6 files changed, 495 insertions(+), 35 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e1644a24009c..f9a44d32e763 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -790,6 +790,11 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 	percpu_ref_put(&objcg->refcnt);
 }
 
+static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
+{
+	return !memcg || css_tryget(&memcg->css);
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 	if (memcg)
@@ -1290,6 +1295,11 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 }
 
+static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
+{
+	return true;
+}
+
 static inline void mem_cgroup_put(struct mem_cgroup *memcg)
 {
 }
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index da38e3d962e2..c1fd3922dc5d 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -122,6 +122,18 @@ static inline bool lru_gen_in_fault(void)
 	return current->in_lru_fault;
 }
 
+#ifdef CONFIG_MEMCG
+static inline int lru_gen_memcg_seg(struct lruvec *lruvec)
+{
+	return READ_ONCE(lruvec->lrugen.seg);
+}
+#else
+static inline int lru_gen_memcg_seg(struct lruvec *lruvec)
+{
+	return 0;
+}
+#endif
+
 static inline int lru_gen_from_seq(unsigned long seq)
 {
 	return seq % MAX_NR_GENS;
@@ -297,6 +309,11 @@ static inline bool lru_gen_in_fault(void)
 	return false;
 }
 
+static inline int lru_gen_memcg_seg(struct lruvec *lruvec)
+{
+	return 0;
+}
+
 static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
 {
 	return false;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 02e432374471..87b3b5a2aac4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -7,6 +7,7 @@
 
 #include <linux/spinlock.h>
 #include <linux/list.h>
+#include <linux/list_nulls.h>
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/cache.h>
@@ -367,6 +368,15 @@ struct page_vma_mapped_walk;
 #define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
 #define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
 
+/* see the comment on MEMCG_NR_GENS */
+enum {
+	MEMCG_LRU_NOP,
+	MEMCG_LRU_HEAD,
+	MEMCG_LRU_TAIL,
+	MEMCG_LRU_OLD,
+	MEMCG_LRU_YOUNG,
+};
+
 #ifdef CONFIG_LRU_GEN
 
 enum {
@@ -426,6 +436,14 @@ struct lru_gen_folio {
 	atomic_long_t refaulted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	/* whether the multi-gen LRU is enabled */
 	bool enabled;
+#ifdef CONFIG_MEMCG
+	/* the memcg generation this lru_gen_folio belongs to */
+	u8 gen;
+	/* the list segment this lru_gen_folio belongs to */
+	u8 seg;
+	/* per-node lru_gen_folio list for global reclaim */
+	struct hlist_nulls_node list;
+#endif
 };
 
 enum {
@@ -479,12 +497,83 @@ void lru_gen_init_lruvec(struct lruvec *lruvec);
 void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 #ifdef CONFIG_MEMCG
+
+/*
+ * For each node, memcgs are divided into two generations: the old and the
+ * young. For each generation, memcgs are randomly sharded into multiple bins
+ * to improve scalability. For each bin, the hlist_nulls is virtually divided
+ * into three segments: the head, the tail and the default.
+ *
+ * An onlining memcg is added to the tail of a random bin in the old generation.
+ * The eviction starts at the head of a random bin in the old generation. The
+ * per-node memcg generation counter, whose reminder (mod MEMCG_NR_GENS) indexes
+ * the old generation, is incremented when all its bins become empty.
+ *
+ * There are four operations:
+ * 1. MEMCG_LRU_HEAD, which moves an memcg to the head of a random bin in its
+ *    current generation (old or young) and updates its "seg" to "head";
+ * 2. MEMCG_LRU_TAIL, which moves an memcg to the tail of a random bin in its
+ *    current generation (old or young) and updates its "seg" to "tail";
+ * 3. MEMCG_LRU_OLD, which moves an memcg to the head of a random bin in the old
+ *    generation, updates its "gen" to "old" and resets its "seg" to "default";
+ * 4. MEMCG_LRU_YOUNG, which moves an memcg to the tail of a random bin in the
+ *    young generation, updates its "gen" to "young" and resets its "seg" to
+ *    "default".
+ *
+ * The events that trigger the above operations are:
+ * 1. Exceeding the soft limit, which triggers MEMCG_LRU_HEAD;
+ * 2. The first attempt to reclaim an memcg below low, which triggers
+ *    MEMCG_LRU_TAIL;
+ * 3. The first attempt to reclaim an memcg below reclaimable size threshold,
+ *    which triggers MEMCG_LRU_TAIL;
+ * 4. The second attempt to reclaim an memcg below reclaimable size threshold,
+ *    which triggers MEMCG_LRU_YOUNG;
+ * 5. Attempting to reclaim an memcg below min, which triggers MEMCG_LRU_YOUNG;
+ * 6. Finishing the aging on the eviction path, which triggers MEMCG_LRU_YOUNG;
+ * 7. Offlining an memcg, which triggers MEMCG_LRU_OLD.
+ */
+#define MEMCG_NR_GENS	2
+#define MEMCG_NR_BINS	8
+
+struct lru_gen_memcg {
+	/* the per-node memcg generation counter */
+	unsigned long seq;
+	/* each memcg has one lru_gen_folio per node */
+	unsigned long nr_memcgs[MEMCG_NR_GENS];
+	/* per-node lru_gen_folio list for global reclaim */
+	struct hlist_nulls_head	fifo[MEMCG_NR_GENS][MEMCG_NR_BINS];
+	/* protects the above */
+	spinlock_t lock;
+};
+
+void lru_gen_init_pgdat(struct pglist_data *pgdat);
+
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
 void lru_gen_exit_memcg(struct mem_cgroup *memcg);
-#endif
+void lru_gen_online_memcg(struct mem_cgroup *memcg);
+void lru_gen_offline_memcg(struct mem_cgroup *memcg);
+void lru_gen_release_memcg(struct mem_cgroup *memcg);
+void lru_gen_rotate_memcg(struct lruvec *lruvec, int op);
+
+#else /* !CONFIG_MEMCG */
+
+#define MEMCG_NR_GENS	1
+
+struct lru_gen_memcg {
+};
+
+static inline void lru_gen_init_pgdat(struct pglist_data *pgdat)
+{
+}
+
+#endif /* CONFIG_MEMCG */
 
 #else /* !CONFIG_LRU_GEN */
 
+static inline void lru_gen_init_pgdat(struct pglist_data *pgdat)
+{
+}
+
 static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 }
@@ -494,6 +583,7 @@ static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 }
 
 #ifdef CONFIG_MEMCG
+
 static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
 }
@@ -501,7 +591,24 @@ static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
 static inline void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 {
 }
-#endif
+
+static inline void lru_gen_online_memcg(struct mem_cgroup *memcg)
+{
+}
+
+static inline void lru_gen_offline_memcg(struct mem_cgroup *memcg)
+{
+}
+
+static inline void lru_gen_release_memcg(struct mem_cgroup *memcg)
+{
+}
+
+static inline void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
+{
+}
+
+#endif /* CONFIG_MEMCG */
 
 #endif /* CONFIG_LRU_GEN */
 
@@ -1219,6 +1326,8 @@ typedef struct pglist_data {
 #ifdef CONFIG_LRU_GEN
 	/* kswap mm walk data */
 	struct lru_gen_mm_walk	mm_walk;
+	/* lru_gen_folio list */
+	struct lru_gen_memcg memcg_lru;
 #endif
 
 	CACHELINE_PADDING(_pad2_);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 23750cec0036..6b976829e9f7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -477,6 +477,16 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
+	if (lru_gen_enabled()) {
+		struct lruvec *lruvec = &memcg->nodeinfo[nid]->lruvec;
+
+		/* see the comment on MEMCG_NR_GENS */
+		if (soft_limit_excess(memcg) && lru_gen_memcg_seg(lruvec) != MEMCG_LRU_HEAD)
+			lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
+
+		return;
+	}
+
 	mctz = soft_limit_tree.rb_tree_per_node[nid];
 	if (!mctz)
 		return;
@@ -3526,6 +3536,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 	struct mem_cgroup_tree_per_node *mctz;
 	unsigned long excess;
 
+	if (lru_gen_enabled())
+		return 0;
+
 	if (order > 0)
 		return 0;
 
@@ -5371,6 +5384,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (unlikely(mem_cgroup_is_root(memcg)))
 		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
 				   2UL*HZ);
+	lru_gen_online_memcg(memcg);
 	return 0;
 offline_kmem:
 	memcg_offline_kmem(memcg);
@@ -5402,6 +5416,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg_offline_kmem(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
+	lru_gen_offline_memcg(memcg);
 
 	drain_all_stock(memcg);
 
@@ -5413,6 +5428,7 @@ static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	invalidate_reclaim_iterators(memcg);
+	lru_gen_release_memcg(memcg);
 }
 
 static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2d4c81224508..0aa134b8dae2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7914,6 +7914,7 @@ static void __init free_area_init_node(int nid)
 	pgdat_set_deferred_range(pgdat);
 
 	free_area_init_core(pgdat);
+	lru_gen_init_pgdat(pgdat);
 }
 
 static void __init free_area_init_memoryless_node(int nid)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0557adce75c5..44506eb96c9d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -55,6 +55,7 @@
 #include <linux/ctype.h>
 #include <linux/debugfs.h>
 #include <linux/khugepaged.h>
+#include <linux/rculist_nulls.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -135,11 +136,6 @@ struct scan_control {
 	/* Always discard instead of demoting to lower tier memory */
 	unsigned int no_demotion:1;
 
-#ifdef CONFIG_LRU_GEN
-	/* help kswapd make better choices among multiple memcgs */
-	unsigned long last_reclaimed;
-#endif
-
 	/* Allocation order */
 	s8 order;
 
@@ -3167,6 +3163,9 @@ DEFINE_STATIC_KEY_ARRAY_FALSE(lru_gen_caps, NR_LRU_GEN_CAPS);
 		for ((type) = 0; (type) < ANON_AND_FILE; (type)++)	\
 			for ((zone) = 0; (zone) < MAX_NR_ZONES; (zone)++)
 
+#define get_memcg_gen(seq)	((seq) % MEMCG_NR_GENS)
+#define get_memcg_bin(bin)	((bin) % MEMCG_NR_BINS)
+
 static struct lruvec *get_lruvec(struct mem_cgroup *memcg, int nid)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
@@ -4438,8 +4437,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 		if (sc->priority <= DEF_PRIORITY - 2)
 			wait_event_killable(lruvec->mm_state.wait,
 					    max_seq < READ_ONCE(lrugen->max_seq));
-
-		return max_seq < READ_ONCE(lrugen->max_seq);
+		return false;
 	}
 
 	VM_WARN_ON_ONCE(max_seq != READ_ONCE(lrugen->max_seq));
@@ -4512,8 +4510,6 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 
 	VM_WARN_ON_ONCE(!current_is_kswapd());
 
-	sc->last_reclaimed = sc->nr_reclaimed;
-
 	/* check the order to exclude compaction-induced reclaim */
 	if (!min_ttl || sc->order || sc->priority == DEF_PRIORITY)
 		return;
@@ -5102,8 +5098,7 @@ static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
  * 1. Defer try_to_inc_max_seq() to workqueues to reduce latency for memcg
  *    reclaim.
  */
-static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc,
-				    bool can_swap)
+static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool can_swap)
 {
 	unsigned long nr_to_scan;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
@@ -5120,10 +5115,8 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
 	if (sc->priority == DEF_PRIORITY)
 		return nr_to_scan;
 
-	try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false);
-
 	/* skip this lruvec as it's low on cold folios */
-	return 0;
+	return try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false) ? -1 : 0;
 }
 
 static unsigned long get_nr_to_reclaim(struct scan_control *sc)
@@ -5132,29 +5125,18 @@ static unsigned long get_nr_to_reclaim(struct scan_control *sc)
 	if (!global_reclaim(sc))
 		return -1;
 
-	/* discount the previous progress for kswapd */
-	if (current_is_kswapd())
-		return sc->nr_to_reclaim + sc->last_reclaimed;
-
 	return max(sc->nr_to_reclaim, compact_gap(sc->order));
 }
 
-static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
+static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
-	struct blk_plug plug;
+	long nr_to_scan;
 	unsigned long scanned = 0;
 	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
-	lru_add_drain();
-
-	blk_start_plug(&plug);
-
-	set_mm_walk(lruvec_pgdat(lruvec));
-
 	while (true) {
 		int delta;
 		int swappiness;
-		unsigned long nr_to_scan;
 
 		if (sc->may_swap)
 			swappiness = get_swappiness(lruvec, sc);
@@ -5164,7 +5146,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 			swappiness = 0;
 
 		nr_to_scan = get_nr_to_scan(lruvec, sc, swappiness);
-		if (!nr_to_scan)
+		if (nr_to_scan <= 0)
 			break;
 
 		delta = evict_folios(lruvec, sc, swappiness);
@@ -5181,10 +5163,251 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 		cond_resched();
 	}
 
+	/* whether try_to_inc_max_seq() was successful */
+	return nr_to_scan < 0;
+}
+
+static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
+{
+	bool success;
+	unsigned long scanned = sc->nr_scanned;
+	unsigned long reclaimed = sc->nr_reclaimed;
+	int seg = lru_gen_memcg_seg(lruvec);
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
+	/* see the comment on MEMCG_NR_GENS */
+	if (!lruvec_is_sizable(lruvec, sc))
+		return seg != MEMCG_LRU_TAIL ? MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
+
+	mem_cgroup_calculate_protection(NULL, memcg);
+
+	if (mem_cgroup_below_min(memcg))
+		return MEMCG_LRU_YOUNG;
+
+	if (mem_cgroup_below_low(memcg)) {
+		/* see the comment on MEMCG_NR_GENS */
+		if (seg != MEMCG_LRU_TAIL)
+			return MEMCG_LRU_TAIL;
+
+		memcg_memory_event(memcg, MEMCG_LOW);
+	}
+
+	success = try_to_shrink_lruvec(lruvec, sc);
+
+	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
+
+	if (!sc->proactive)
+		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
+			   sc->nr_reclaimed - reclaimed);
+
+	sc->nr_reclaimed += current->reclaim_state->reclaimed_slab;
+	current->reclaim_state->reclaimed_slab = 0;
+
+	return success ? MEMCG_LRU_YOUNG : 0;
+}
+
+#ifdef CONFIG_MEMCG
+
+static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	int gen;
+	int bin;
+	int first_bin;
+	struct lruvec *lruvec;
+	struct lru_gen_folio *lrugen;
+	const struct hlist_nulls_node *pos;
+	int op = 0;
+	struct mem_cgroup *memcg = NULL;
+	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
+
+	bin = first_bin = prandom_u32_max(MEMCG_NR_BINS);
+restart:
+	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
+
+	rcu_read_lock();
+
+	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
+		if (op)
+			lru_gen_rotate_memcg(lruvec, op);
+
+		mem_cgroup_put(memcg);
+
+		lruvec = container_of(lrugen, struct lruvec, lrugen);
+		memcg = lruvec_memcg(lruvec);
+
+		if (!mem_cgroup_tryget(memcg)) {
+			op = 0;
+			memcg = NULL;
+			continue;
+		}
+
+		rcu_read_unlock();
+
+		op = shrink_one(lruvec, sc);
+
+		if (sc->nr_reclaimed >= nr_to_reclaim)
+			goto success;
+
+		rcu_read_lock();
+	}
+
+	rcu_read_unlock();
+
+	/* restart if raced with lru_gen_rotate_memcg() */
+	if (gen != get_nulls_value(pos))
+		goto restart;
+
+	/* try the rest of the bins of the current generation */
+	bin = get_memcg_bin(bin + 1);
+	if (bin != first_bin)
+		goto restart;
+success:
+	if (op)
+		lru_gen_rotate_memcg(lruvec, op);
+
+	mem_cgroup_put(memcg);
+}
+
+static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
+{
+	struct blk_plug plug;
+
+	VM_WARN_ON_ONCE(global_reclaim(sc));
+
+	lru_add_drain();
+
+	blk_start_plug(&plug);
+
+	set_mm_walk(lruvec_pgdat(lruvec));
+
+	if (try_to_shrink_lruvec(lruvec, sc))
+		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
+
+	clear_mm_walk();
+
+	blk_finish_plug(&plug);
+}
+
+#else /* !CONFIG_MEMCG */
+
+static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	BUILD_BUG();
+}
+
+static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
+{
+	BUILD_BUG();
+}
+
+#endif
+
+static void set_initial_priority(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	int priority;
+	unsigned long reclaimable;
+	struct lruvec *lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
+
+	if (sc->priority != DEF_PRIORITY || sc->nr_to_reclaim < MIN_LRU_BATCH)
+		return;
+	/*
+	 * Determine the initial priority based on ((total / MEMCG_NR_GENS) >>
+	 * priority) * reclaimed_to_scanned_ratio = nr_to_reclaim, where the
+	 * estimated reclaimed_to_scanned_ratio = inactive / total.
+	 */
+	reclaimable = node_page_state(pgdat, NR_INACTIVE_FILE);
+	if (get_swappiness(lruvec, sc))
+		reclaimable += node_page_state(pgdat, NR_INACTIVE_ANON);
+
+	reclaimable /= MEMCG_NR_GENS;
+
+	/* round down reclaimable and round up sc->nr_to_reclaim */
+	priority = fls_long(reclaimable) - 1 - fls_long(sc->nr_to_reclaim - 1);
+
+	sc->priority = clamp(priority, 0, DEF_PRIORITY);
+}
+
+static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
+{
+	struct blk_plug plug;
+	unsigned long reclaimed = sc->nr_reclaimed;
+
+	VM_WARN_ON_ONCE(!global_reclaim(sc));
+
+	lru_add_drain();
+
+	blk_start_plug(&plug);
+
+	set_mm_walk(pgdat);
+
+	set_initial_priority(pgdat, sc);
+
+	if (current_is_kswapd())
+		sc->nr_reclaimed = 0;
+
+	if (mem_cgroup_disabled())
+		shrink_one(&pgdat->__lruvec, sc);
+	else
+		shrink_many(pgdat, sc);
+
+	if (current_is_kswapd())
+		sc->nr_reclaimed += reclaimed;
+
 	clear_mm_walk();
 
 	blk_finish_plug(&plug);
+
+	/* kswapd should never fail */
+	pgdat->kswapd_failures = 0;
+}
+
+#ifdef CONFIG_MEMCG
+void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
+{
+	int seg;
+	int old, new;
+	int bin = prandom_u32_max(MEMCG_NR_BINS);
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
+	spin_lock(&pgdat->memcg_lru.lock);
+
+	VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
+
+	seg = 0;
+	new = old = lruvec->lrugen.gen;
+
+	/* see the comment on MEMCG_NR_GENS */
+	if (op == MEMCG_LRU_HEAD)
+		seg = MEMCG_LRU_HEAD;
+	else if (op == MEMCG_LRU_TAIL)
+		seg = MEMCG_LRU_TAIL;
+	else if (op == MEMCG_LRU_OLD)
+		new = get_memcg_gen(pgdat->memcg_lru.seq);
+	else if (op == MEMCG_LRU_YOUNG)
+		new = get_memcg_gen(pgdat->memcg_lru.seq + 1);
+	else
+		VM_WARN_ON_ONCE(true);
+
+	hlist_nulls_del_rcu(&lruvec->lrugen.list);
+
+	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
+		hlist_nulls_add_head_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
+	else
+		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
+
+	pgdat->memcg_lru.nr_memcgs[old]--;
+	pgdat->memcg_lru.nr_memcgs[new]++;
+
+	lruvec->lrugen.gen = new;
+	WRITE_ONCE(lruvec->lrugen.seg, seg);
+
+	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
+		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
+
+	spin_unlock(&pgdat->memcg_lru.lock);
 }
+#endif
 
 /******************************************************************************
  *                          state change
@@ -5639,11 +5862,11 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 
 	if (!mem_cgroup_disabled()) {
 		rcu_read_lock();
+
 		memcg = mem_cgroup_from_id(memcg_id);
-#ifdef CONFIG_MEMCG
-		if (memcg && !css_tryget(&memcg->css))
+		if (!mem_cgroup_tryget(memcg))
 			memcg = NULL;
-#endif
+
 		rcu_read_unlock();
 
 		if (!memcg)
@@ -5791,6 +6014,19 @@ void lru_gen_init_lruvec(struct lruvec *lruvec)
 }
 
 #ifdef CONFIG_MEMCG
+
+void lru_gen_init_pgdat(struct pglist_data *pgdat)
+{
+	int i, j;
+
+	spin_lock_init(&pgdat->memcg_lru.lock);
+
+	for (i = 0; i < MEMCG_NR_GENS; i++) {
+		for (j = 0; j < MEMCG_NR_BINS; j++)
+			INIT_HLIST_NULLS_HEAD(&pgdat->memcg_lru.fifo[i][j], i);
+	}
+}
+
 void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
 	INIT_LIST_HEAD(&memcg->mm_list.fifo);
@@ -5814,7 +6050,69 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 		}
 	}
 }
-#endif
+
+void lru_gen_online_memcg(struct mem_cgroup *memcg)
+{
+	int gen;
+	int nid;
+	int bin = prandom_u32_max(MEMCG_NR_BINS);
+
+	for_each_node(nid) {
+		struct pglist_data *pgdat = NODE_DATA(nid);
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+
+		spin_lock(&pgdat->memcg_lru.lock);
+
+		VM_WARN_ON_ONCE(!hlist_nulls_unhashed(&lruvec->lrugen.list));
+
+		gen = get_memcg_gen(pgdat->memcg_lru.seq);
+
+		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
+		pgdat->memcg_lru.nr_memcgs[gen]++;
+
+		lruvec->lrugen.gen = gen;
+
+		spin_unlock(&pgdat->memcg_lru.lock);
+	}
+}
+
+void lru_gen_offline_memcg(struct mem_cgroup *memcg)
+{
+	int nid;
+
+	for_each_node(nid) {
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+
+		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_OLD);
+	}
+}
+
+void lru_gen_release_memcg(struct mem_cgroup *memcg)
+{
+	int gen;
+	int nid;
+
+	for_each_node(nid) {
+		struct pglist_data *pgdat = NODE_DATA(nid);
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+
+		spin_lock(&pgdat->memcg_lru.lock);
+
+		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
+
+		gen = lruvec->lrugen.gen;
+
+		hlist_nulls_del_rcu(&lruvec->lrugen.list);
+		pgdat->memcg_lru.nr_memcgs[gen]--;
+
+		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
+			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
+
+		spin_unlock(&pgdat->memcg_lru.lock);
+	}
+}
+
+#endif /* CONFIG_MEMCG */
 
 static int __init init_lru_gen(void)
 {
@@ -5841,6 +6139,10 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 {
 }
 
+static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
+{
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
@@ -5854,7 +6156,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-	if (lru_gen_enabled()) {
+	if (lru_gen_enabled() && !global_reclaim(sc)) {
 		lru_gen_shrink_lruvec(lruvec, sc);
 		return;
 	}
@@ -6097,6 +6399,11 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
+	if (lru_gen_enabled() && global_reclaim(sc)) {
+		lru_gen_shrink_node(pgdat, sc);
+		return;
+	}
+
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
 
 again:
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

