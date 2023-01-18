Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69671670EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjARAmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjARAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74333C29A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h136-20020a25d08e000000b007e1b1a30d5dso7780060ybg.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k/ufnMQ/vF5URPKOGCCuWIRDYgI0KQr2ysXo3/nfRQk=;
        b=fSs2he8n2faro7dY9Elmop9HsLJqfMwYDfYr/miLYNI4PMEVnZCHxMV9LeX1o28DHo
         druvi7t5lwq7TVy6LbjSlaK36xSy2FdhpVvUKH7cr1YqJa2U5OLRYk0yZMxfTbU/O238
         KywizYneXgXglvAeXtoZH1/zMNpwjLL3QhAllYpUsY8Ossg7zWGSScEG+sBr3EE7g7rS
         T5xuds/YhvvKdhYw87C4Db14nwI1VlUA8k2pDi5288e10Jbwq7s2xcbQwHHJTExytD1y
         J0K4AFQLft1n+HUS5iU8fA93FO1zmSwguj1FbRWnJA1v9lI9C2sB+6CB6qG/VR8nyeSv
         JlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/ufnMQ/vF5URPKOGCCuWIRDYgI0KQr2ysXo3/nfRQk=;
        b=OmiXjC92EE6/G9JIxQLv9yKJppjscxd6/QBTRYohACYfuPPcbkSqxSqOCHRj5jQ7R2
         sIzl/WTP3odiv4Fcs5gAnMI9PuAaeJXkSv1miMqJA5CbhemSDoxF95DCXUsetubF383A
         Js3Dy6AtWgveZYJ3yzUs1sAAGmeT+CSjSRocdSAtX/F1nv7O2/uWir/jKiHbcT3nsp0f
         KEG4LX2Pcbrj6hIq2lMXKT7mjLO6pG/KvKTavdQg37P889ToJvusAx9gRWLtmE2MDc1e
         nJxy3JnkGG/Ho3iGAM5WioJ5PVpLHMQ4iot91679tWT/DG6koJjR10VpT89tZ0GuVA3/
         ZbUg==
X-Gm-Message-State: AFqh2kopLa8MIvkulsveyaT+b1IBXb1b6Y9WtKQu5prYp3xgoae1HL0S
        DsO+udE5I7K4De39CRPLs2Hn7J0IpSdZMA==
X-Google-Smtp-Source: AMrXdXuJtnhQvY/9kTYmOAcKA/VDrfSt/OUgE6mb5+T93wJOOFT8sNsVoTj7b8EQKR1Z6wuC/cnTOAJHyskjug==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a0d:eb82:0:b0:3b2:ce3b:eae1 with SMTP id
 u124-20020a0deb82000000b003b2ce3beae1mr650144ywe.4.1674001125945; Tue, 17 Jan
 2023 16:18:45 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:24 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-5-talumbau@google.com>
Subject: [PATCH mm-unstable v1 4/7] mm: multi-gen LRU: section for memcg LRU
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
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

Move memcg LRU code into a dedicated section. Improve the design
doc to outline its architecture.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 Documentation/mm/multigen_lru.rst |  33 +++-
 include/linux/mm_inline.h         |  17 --
 include/linux/mmzone.h            |  13 +-
 mm/memcontrol.c                   |   8 +-
 mm/vmscan.c                       | 250 +++++++++++++++++-------------
 5 files changed, 178 insertions(+), 143 deletions(-)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index 770b5d539856..5f1f6ecbb79b 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -186,9 +186,40 @@ is false positive, the cost is an additional scan of a range of PTEs,
 which may yield hot pages anyway. Parameters of the filter itself can
 control the false positive rate in the limit.
 
+Memcg LRU
+---------
+An memcg LRU is a per-node LRU of memcgs. It is also an LRU of LRUs,
+since each node and memcg combination has an LRU of folios (see
+``mem_cgroup_lruvec()``). Its goal is to improve the scalability of
+global reclaim, which is critical to system-wide memory overcommit in
+data centers. Note that memcg LRU only applies to global reclaim.
+
+The basic structure of an memcg LRU can be understood by an analogy to
+the active/inactive LRU (of folios):
+
+1. It has the young and the old (generations), i.e., the counterparts
+   to the active and the inactive;
+2. The increment of ``max_seq`` triggers promotion, i.e., the
+   counterpart to activation;
+3. Other events trigger similar operations, e.g., offlining an memcg
+   triggers demotion, i.e., the counterpart to deactivation.
+
+In terms of global reclaim, it has two distinct features:
+
+1. Sharding, which allows each thread to start at a random memcg (in
+   the old generation) and improves parallelism;
+2. Eventual fairness, which allows direct reclaim to bail out at will
+   and reduces latency without affecting fairness over some time.
+
+In terms of traversing memcgs during global reclaim, it improves the
+best-case complexity from O(n) to O(1) and does not affect the
+worst-case complexity O(n). Therefore, on average, it has a sublinear
+complexity.
+
 Summary
 -------
-The multi-gen LRU can be disassembled into the following parts:
+The multi-gen LRU (of folios) can be disassembled into the following
+parts:
 
 * Generations
 * Rmap walks
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 26dcbda07e92..de1e622dd366 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -122,18 +122,6 @@ static inline bool lru_gen_in_fault(void)
 	return current->in_lru_fault;
 }
 
-#ifdef CONFIG_MEMCG
-static inline int lru_gen_memcg_seg(struct lruvec *lruvec)
-{
-	return READ_ONCE(lruvec->lrugen.seg);
-}
-#else
-static inline int lru_gen_memcg_seg(struct lruvec *lruvec)
-{
-	return 0;
-}
-#endif
-
 static inline int lru_gen_from_seq(unsigned long seq)
 {
 	return seq % MAX_NR_GENS;
@@ -309,11 +297,6 @@ static inline bool lru_gen_in_fault(void)
 	return false;
 }
 
-static inline int lru_gen_memcg_seg(struct lruvec *lruvec)
-{
-	return 0;
-}
-
 static inline bool lru_gen_add_folio(struct lruvec *lruvec, struct folio *folio, bool reclaiming)
 {
 	return false;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae7d4e92c12d..c54964979ccf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -368,15 +368,6 @@ struct page_vma_mapped_walk;
 #define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
 #define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
 
-/* see the comment on MEMCG_NR_GENS */
-enum {
-	MEMCG_LRU_NOP,
-	MEMCG_LRU_HEAD,
-	MEMCG_LRU_TAIL,
-	MEMCG_LRU_OLD,
-	MEMCG_LRU_YOUNG,
-};
-
 #ifdef CONFIG_LRU_GEN
 
 enum {
@@ -557,7 +548,7 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg);
 void lru_gen_online_memcg(struct mem_cgroup *memcg);
 void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
-void lru_gen_rotate_memcg(struct lruvec *lruvec, int op);
+void lru_gen_soft_reclaim(struct lruvec *lruvec);
 
 #else /* !CONFIG_MEMCG */
 
@@ -608,7 +599,7 @@ static inline void lru_gen_release_memcg(struct mem_cgroup *memcg)
 {
 }
 
-static inline void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
+static inline void lru_gen_soft_reclaim(struct lruvec *lruvec)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 893427aded01..17335459d8dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -476,12 +476,8 @@ static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
 	struct mem_cgroup_tree_per_node *mctz;
 
 	if (lru_gen_enabled()) {
-		struct lruvec *lruvec = &memcg->nodeinfo[nid]->lruvec;
-
-		/* see the comment on MEMCG_NR_GENS */
-		if (soft_limit_excess(memcg) && lru_gen_memcg_seg(lruvec) != MEMCG_LRU_HEAD)
-			lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
-
+		if (soft_limit_excess(memcg))
+			lru_gen_soft_reclaim(&memcg->nodeinfo[nid]->lruvec);
 		return;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1be9120349f8..796d4ca65e97 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4705,6 +4705,148 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	mem_cgroup_unlock_pages();
 }
 
+/******************************************************************************
+ *                          memcg LRU
+ ******************************************************************************/
+
+/* see the comment on MEMCG_NR_GENS */
+enum {
+	MEMCG_LRU_NOP,
+	MEMCG_LRU_HEAD,
+	MEMCG_LRU_TAIL,
+	MEMCG_LRU_OLD,
+	MEMCG_LRU_YOUNG,
+};
+
+#ifdef CONFIG_MEMCG
+
+static int lru_gen_memcg_seg(struct lruvec *lruvec)
+{
+	return READ_ONCE(lruvec->lrugen.seg);
+}
+
+static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
+{
+	int seg;
+	int old, new;
+	int bin = get_random_u32_below(MEMCG_NR_BINS);
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
+}
+
+void lru_gen_online_memcg(struct mem_cgroup *memcg)
+{
+	int gen;
+	int nid;
+	int bin = get_random_u32_below(MEMCG_NR_BINS);
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
+void lru_gen_soft_reclaim(struct lruvec *lruvec)
+{
+	/* see the comment on MEMCG_NR_GENS */
+	if (lru_gen_memcg_seg(lruvec) != MEMCG_LRU_HEAD)
+		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
+}
+
+#else /* !CONFIG_MEMCG */
+
+static int lru_gen_memcg_seg(struct lruvec *lruvec)
+{
+	return 0;
+}
+
+#endif
+
 /******************************************************************************
  *                          the eviction
  ******************************************************************************/
@@ -5397,53 +5539,6 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	pgdat->kswapd_failures = 0;
 }
 
-#ifdef CONFIG_MEMCG
-void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
-{
-	int seg;
-	int old, new;
-	int bin = get_random_u32_below(MEMCG_NR_BINS);
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-
-	spin_lock(&pgdat->memcg_lru.lock);
-
-	VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
-
-	seg = 0;
-	new = old = lruvec->lrugen.gen;
-
-	/* see the comment on MEMCG_NR_GENS */
-	if (op == MEMCG_LRU_HEAD)
-		seg = MEMCG_LRU_HEAD;
-	else if (op == MEMCG_LRU_TAIL)
-		seg = MEMCG_LRU_TAIL;
-	else if (op == MEMCG_LRU_OLD)
-		new = get_memcg_gen(pgdat->memcg_lru.seq);
-	else if (op == MEMCG_LRU_YOUNG)
-		new = get_memcg_gen(pgdat->memcg_lru.seq + 1);
-	else
-		VM_WARN_ON_ONCE(true);
-
-	hlist_nulls_del_rcu(&lruvec->lrugen.list);
-
-	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
-		hlist_nulls_add_head_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
-	else
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
-
-	pgdat->memcg_lru.nr_memcgs[old]--;
-	pgdat->memcg_lru.nr_memcgs[new]++;
-
-	lruvec->lrugen.gen = new;
-	WRITE_ONCE(lruvec->lrugen.seg, seg);
-
-	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
-		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-
-	spin_unlock(&pgdat->memcg_lru.lock);
-}
-#endif
-
 /******************************************************************************
  *                          state change
  ******************************************************************************/
@@ -6086,67 +6181,6 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 	}
 }
 
-void lru_gen_online_memcg(struct mem_cgroup *memcg)
-{
-	int gen;
-	int nid;
-	int bin = get_random_u32_below(MEMCG_NR_BINS);
-
-	for_each_node(nid) {
-		struct pglist_data *pgdat = NODE_DATA(nid);
-		struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-		spin_lock(&pgdat->memcg_lru.lock);
-
-		VM_WARN_ON_ONCE(!hlist_nulls_unhashed(&lruvec->lrugen.list));
-
-		gen = get_memcg_gen(pgdat->memcg_lru.seq);
-
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
-		pgdat->memcg_lru.nr_memcgs[gen]++;
-
-		lruvec->lrugen.gen = gen;
-
-		spin_unlock(&pgdat->memcg_lru.lock);
-	}
-}
-
-void lru_gen_offline_memcg(struct mem_cgroup *memcg)
-{
-	int nid;
-
-	for_each_node(nid) {
-		struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_OLD);
-	}
-}
-
-void lru_gen_release_memcg(struct mem_cgroup *memcg)
-{
-	int gen;
-	int nid;
-
-	for_each_node(nid) {
-		struct pglist_data *pgdat = NODE_DATA(nid);
-		struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-		spin_lock(&pgdat->memcg_lru.lock);
-
-		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
-
-		gen = lruvec->lrugen.gen;
-
-		hlist_nulls_del_rcu(&lruvec->lrugen.list);
-		pgdat->memcg_lru.nr_memcgs[gen]--;
-
-		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
-			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-
-		spin_unlock(&pgdat->memcg_lru.lock);
-	}
-}
-
 #endif /* CONFIG_MEMCG */
 
 static int __init init_lru_gen(void)
-- 
2.39.0.314.g84b9a713c41-goog

