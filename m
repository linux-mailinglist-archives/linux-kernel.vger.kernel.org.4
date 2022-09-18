Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC185BBC72
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiIRIDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiIRIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9696126558
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q84-20020a25d957000000b006aeb2dba911so19909804ybg.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=VTkel1/4Mitnf1KW4kk0RfHlJBdg+hVIQ/C5RNBSbJQ=;
        b=WfUWszXAgz6T4HxRC5FlQ3jcDnRjVKyIYQAJjW72pDuiRuUTxvot3uLciVN478b+1r
         5uCeTNwBdimO57mzvtnnvDMUhJWsXQGjLVwhN/n3kbNfbU10NPahT9U5U4wnn/6/+Xnm
         ISsiXtkNy1no+wneQ3RhKu3RNpNbnzPFIHLYqDgw+jV+W1oEarnynAkcWs525LBcCsOG
         q6t+X5huYl3mHMF//uUSK5OOA9VMQAsbWhDVzz0pbAS+lMRkq35WdckEJAGgkBX5fjsj
         +PCrgEGqfCGVAfuE+CrYsFN/lUeD7UmGsOyFFjl1hO9gvwZK/wZ6/+1I03G5goCcnAoq
         67PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=VTkel1/4Mitnf1KW4kk0RfHlJBdg+hVIQ/C5RNBSbJQ=;
        b=r/F7jS/BUGEAXntYRuQJcK6DoSfxvlVFBtBObs8mJzIoA/pY/Pe4Um8wXN0G3xZHGB
         U5eaZdLDRs/X8linTn49nPvTp24g6wbJpAzaHc+xVlCq/PJimzIPyA82qTb4Un5ZURh1
         qeW5By1ZcN2oBIecTEmpq9BRwGr6GyPAKcHR9/FTEQTQ2f4ogyxFIEG85ObMAF6xRnH3
         0JtDD8+7i3Ml5mV+kXXw9pnggvxZipIAziYpwW1Lt+ZRmtVCFcYrDKbYUmb9HxrMxxHA
         zU3bps+CNWxYProkj5YHJT+Q8FLgeh+w/xU6pKSQu4sC2J6JxPNVXeE4CqOLcB/AKreu
         BbKA==
X-Gm-Message-State: ACrzQf37090b1CnF9O2LDz0YaNLMM8H08boBVZ3vx+EIaZ4bYwsIsJlX
        rNIrQAifhZaaKI1a+24ueybcU19hS7E=
X-Google-Smtp-Source: AMsMyM7pWjuKMsBrC+v67IGzm8cdwDcrIRPyh4nM+JlpGDtvru6odEdCborSTbDUe+ScMKNEmjQ9EuW73+k=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a25:8d05:0:b0:68e:c838:c24a with SMTP id
 n5-20020a258d05000000b0068ec838c24amr10032647ybl.45.1663488079114; Sun, 18
 Sep 2022 01:01:19 -0700 (PDT)
Date:   Sun, 18 Sep 2022 02:00:09 -0600
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
Message-Id: <20220918080010.2920238-13-yuzhao@google.com>
Mime-Version: 1.0
References: <20220918080010.2920238-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 12/14] mm: multi-gen LRU: debugfs interface
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Yu Zhao <yuzhao@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add /sys/kernel/debug/lru_gen for working set estimation and proactive
reclaim. These techniques are commonly used to optimize job scheduling
(bin packing) in data centers [1][2].

Compared with the page table-based approach and the PFN-based
approach, this lruvec-based approach has the following advantages:
1. It offers better choices because it is aware of memcgs, NUMA nodes,
   shared mappings and unmapped page cache.
2. It is more scalable because it is O(nr_hot_pages), whereas the
   PFN-based approach is O(nr_total_pages).

Add /sys/kernel/debug/lru_gen_full for debugging.

[1] https://dl.acm.org/doi/10.1145/3297858.3304053
[2] https://dl.acm.org/doi/10.1145/3503222.3507731

Signed-off-by: Yu Zhao <yuzhao@google.com>
Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 include/linux/nodemask.h |   1 +
 mm/vmscan.c              | 411 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 402 insertions(+), 10 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 4b71a96190a8..3a0eec9f2faa 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -493,6 +493,7 @@ static inline int num_node_state(enum node_states state=
)
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
+#define next_memory_node(nid)	(MAX_NUMNODES)
 #define nr_node_ids		1U
 #define nr_online_nodes		1U
=20
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9ef2ec3d3c0c..7657d54c9c42 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -52,6 +52,7 @@
 #include <linux/pagewalk.h>
 #include <linux/shmem_fs.h>
 #include <linux/ctype.h>
+#include <linux/debugfs.h>
=20
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -4197,12 +4198,40 @@ static void clear_mm_walk(void)
 		kfree(walk);
 }
=20
-static void inc_min_seq(struct lruvec *lruvec, int type)
+static bool inc_min_seq(struct lruvec *lruvec, int type, bool can_swap)
 {
+	int zone;
+	int remaining =3D MAX_LRU_BATCH;
 	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
=20
+	if (type =3D=3D LRU_GEN_ANON && !can_swap)
+		goto done;
+
+	/* prevent cold/hot inversion if force_scan is true */
+	for (zone =3D 0; zone < MAX_NR_ZONES; zone++) {
+		struct list_head *head =3D &lrugen->lists[old_gen][type][zone];
+
+		while (!list_empty(head)) {
+			struct folio *folio =3D lru_to_folio(head);
+
+			VM_WARN_ON_ONCE_FOLIO(folio_test_unevictable(folio), folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_active(folio), folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_is_file_lru(folio) !=3D type, folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_zonenum(folio) !=3D zone, folio);
+
+			new_gen =3D folio_inc_gen(lruvec, folio, false);
+			list_move_tail(&folio->lru, &lrugen->lists[new_gen][type][zone]);
+
+			if (!--remaining)
+				return false;
+		}
+	}
+done:
 	reset_ctrl_pos(lruvec, type, true);
 	WRITE_ONCE(lrugen->min_seq[type], lrugen->min_seq[type] + 1);
+
+	return true;
 }
=20
 static bool try_to_inc_min_seq(struct lruvec *lruvec, bool can_swap)
@@ -4248,7 +4277,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec,=
 bool can_swap)
 	return success;
 }
=20
-static void inc_max_seq(struct lruvec *lruvec, bool can_swap)
+static void inc_max_seq(struct lruvec *lruvec, bool can_swap, bool force_s=
can)
 {
 	int prev, next;
 	int type, zone;
@@ -4262,9 +4291,13 @@ static void inc_max_seq(struct lruvec *lruvec, bool =
can_swap)
 		if (get_nr_gens(lruvec, type) !=3D MAX_NR_GENS)
 			continue;
=20
-		VM_WARN_ON_ONCE(type =3D=3D LRU_GEN_FILE || can_swap);
+		VM_WARN_ON_ONCE(!force_scan && (type =3D=3D LRU_GEN_FILE || can_swap));
=20
-		inc_min_seq(lruvec, type);
+		while (!inc_min_seq(lruvec, type, can_swap)) {
+			spin_unlock_irq(&lruvec->lru_lock);
+			cond_resched();
+			spin_lock_irq(&lruvec->lru_lock);
+		}
 	}
=20
 	/*
@@ -4301,7 +4334,7 @@ static void inc_max_seq(struct lruvec *lruvec, bool c=
an_swap)
 }
=20
 static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_se=
q,
-			       struct scan_control *sc, bool can_swap)
+			       struct scan_control *sc, bool can_swap, bool force_scan)
 {
 	bool success;
 	struct lru_gen_mm_walk *walk;
@@ -4322,7 +4355,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec,=
 unsigned long max_seq,
 	 * handful of PTEs. Spreading the work out over a period of time usually
 	 * is less efficient, but it avoids bursty page faults.
 	 */
-	if (!(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))) {
+	if (!force_scan && !(arch_has_hw_pte_young() && get_cap(LRU_GEN_MM_WALK))=
) {
 		success =3D iterate_mm_list_nowalk(lruvec, max_seq);
 		goto done;
 	}
@@ -4336,7 +4369,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec,=
 unsigned long max_seq,
 	walk->lruvec =3D lruvec;
 	walk->max_seq =3D max_seq;
 	walk->can_swap =3D can_swap;
-	walk->force_scan =3D false;
+	walk->force_scan =3D force_scan;
=20
 	do {
 		success =3D iterate_mm_list(lruvec, walk, &mm);
@@ -4356,7 +4389,7 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec,=
 unsigned long max_seq,
=20
 	VM_WARN_ON_ONCE(max_seq !=3D READ_ONCE(lrugen->max_seq));
=20
-	inc_max_seq(lruvec, can_swap);
+	inc_max_seq(lruvec, can_swap, force_scan);
 	/* either this sees any waiters or they will see updated max_seq */
 	if (wq_has_sleeper(&lruvec->mm_state.wait))
 		wake_up_all(&lruvec->mm_state.wait);
@@ -4454,7 +4487,7 @@ static bool age_lruvec(struct lruvec *lruvec, struct =
scan_control *sc, unsigned
 	}
=20
 	if (need_aging)
-		try_to_inc_max_seq(lruvec, max_seq, sc, swappiness);
+		try_to_inc_max_seq(lruvec, max_seq, sc, swappiness, false);
=20
 	return true;
 }
@@ -5013,7 +5046,7 @@ static unsigned long get_nr_to_scan(struct lruvec *lr=
uvec, struct scan_control *
 	if (current_is_kswapd())
 		return 0;
=20
-	if (try_to_inc_max_seq(lruvec, max_seq, sc, can_swap))
+	if (try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false))
 		return nr_to_scan;
 done:
 	return min_seq[!can_swap] + MIN_NR_GENS <=3D max_seq ? nr_to_scan : 0;
@@ -5352,6 +5385,361 @@ static struct attribute_group lru_gen_attr_group =
=3D {
 	.attrs =3D lru_gen_attrs,
 };
=20
+/*************************************************************************=
*****
+ *                          debugfs interface
+ *************************************************************************=
*****/
+
+static void *lru_gen_seq_start(struct seq_file *m, loff_t *pos)
+{
+	struct mem_cgroup *memcg;
+	loff_t nr_to_skip =3D *pos;
+
+	m->private =3D kvmalloc(PATH_MAX, GFP_KERNEL);
+	if (!m->private)
+		return ERR_PTR(-ENOMEM);
+
+	memcg =3D mem_cgroup_iter(NULL, NULL, NULL);
+	do {
+		int nid;
+
+		for_each_node_state(nid, N_MEMORY) {
+			if (!nr_to_skip--)
+				return get_lruvec(memcg, nid);
+		}
+	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
+
+	return NULL;
+}
+
+static void lru_gen_seq_stop(struct seq_file *m, void *v)
+{
+	if (!IS_ERR_OR_NULL(v))
+		mem_cgroup_iter_break(NULL, lruvec_memcg(v));
+
+	kvfree(m->private);
+	m->private =3D NULL;
+}
+
+static void *lru_gen_seq_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	int nid =3D lruvec_pgdat(v)->node_id;
+	struct mem_cgroup *memcg =3D lruvec_memcg(v);
+
+	++*pos;
+
+	nid =3D next_memory_node(nid);
+	if (nid =3D=3D MAX_NUMNODES) {
+		memcg =3D mem_cgroup_iter(NULL, memcg, NULL);
+		if (!memcg)
+			return NULL;
+
+		nid =3D first_memory_node;
+	}
+
+	return get_lruvec(memcg, nid);
+}
+
+static void lru_gen_seq_show_full(struct seq_file *m, struct lruvec *lruve=
c,
+				  unsigned long max_seq, unsigned long *min_seq,
+				  unsigned long seq)
+{
+	int i;
+	int type, tier;
+	int hist =3D lru_hist_from_seq(seq);
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+
+	for (tier =3D 0; tier < MAX_NR_TIERS; tier++) {
+		seq_printf(m, "            %10d", tier);
+		for (type =3D 0; type < ANON_AND_FILE; type++) {
+			const char *s =3D "   ";
+			unsigned long n[3] =3D {};
+
+			if (seq =3D=3D max_seq) {
+				s =3D "RT ";
+				n[0] =3D READ_ONCE(lrugen->avg_refaulted[type][tier]);
+				n[1] =3D READ_ONCE(lrugen->avg_total[type][tier]);
+			} else if (seq =3D=3D min_seq[type] || NR_HIST_GENS > 1) {
+				s =3D "rep";
+				n[0] =3D atomic_long_read(&lrugen->refaulted[hist][type][tier]);
+				n[1] =3D atomic_long_read(&lrugen->evicted[hist][type][tier]);
+				if (tier)
+					n[2] =3D READ_ONCE(lrugen->protected[hist][type][tier - 1]);
+			}
+
+			for (i =3D 0; i < 3; i++)
+				seq_printf(m, " %10lu%c", n[i], s[i]);
+		}
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "                      ");
+	for (i =3D 0; i < NR_MM_STATS; i++) {
+		const char *s =3D "      ";
+		unsigned long n =3D 0;
+
+		if (seq =3D=3D max_seq && NR_HIST_GENS =3D=3D 1) {
+			s =3D "LOYNFA";
+			n =3D READ_ONCE(lruvec->mm_state.stats[hist][i]);
+		} else if (seq !=3D max_seq && NR_HIST_GENS > 1) {
+			s =3D "loynfa";
+			n =3D READ_ONCE(lruvec->mm_state.stats[hist][i]);
+		}
+
+		seq_printf(m, " %10lu%c", n, s[i]);
+	}
+	seq_putc(m, '\n');
+}
+
+static int lru_gen_seq_show(struct seq_file *m, void *v)
+{
+	unsigned long seq;
+	bool full =3D !debugfs_real_fops(m->file)->write;
+	struct lruvec *lruvec =3D v;
+	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
+	int nid =3D lruvec_pgdat(lruvec)->node_id;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	if (nid =3D=3D first_memory_node) {
+		const char *path =3D memcg ? m->private : "";
+
+#ifdef CONFIG_MEMCG
+		if (memcg)
+			cgroup_path(memcg->css.cgroup, m->private, PATH_MAX);
+#endif
+		seq_printf(m, "memcg %5hu %s\n", mem_cgroup_id(memcg), path);
+	}
+
+	seq_printf(m, " node %5d\n", nid);
+
+	if (!full)
+		seq =3D min_seq[LRU_GEN_ANON];
+	else if (max_seq >=3D MAX_NR_GENS)
+		seq =3D max_seq - MAX_NR_GENS + 1;
+	else
+		seq =3D 0;
+
+	for (; seq <=3D max_seq; seq++) {
+		int type, zone;
+		int gen =3D lru_gen_from_seq(seq);
+		unsigned long birth =3D READ_ONCE(lruvec->lrugen.timestamps[gen]);
+
+		seq_printf(m, " %10lu %10u", seq, jiffies_to_msecs(jiffies - birth));
+
+		for (type =3D 0; type < ANON_AND_FILE; type++) {
+			unsigned long size =3D 0;
+			char mark =3D full && seq < min_seq[type] ? 'x' : ' ';
+
+			for (zone =3D 0; zone < MAX_NR_ZONES; zone++)
+				size +=3D max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+
+			seq_printf(m, " %10lu%c", size, mark);
+		}
+
+		seq_putc(m, '\n');
+
+		if (full)
+			lru_gen_seq_show_full(m, lruvec, max_seq, min_seq, seq);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations lru_gen_seq_ops =3D {
+	.start =3D lru_gen_seq_start,
+	.stop =3D lru_gen_seq_stop,
+	.next =3D lru_gen_seq_next,
+	.show =3D lru_gen_seq_show,
+};
+
+static int run_aging(struct lruvec *lruvec, unsigned long seq, struct scan=
_control *sc,
+		     bool can_swap, bool force_scan)
+{
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	if (seq < max_seq)
+		return 0;
+
+	if (seq > max_seq)
+		return -EINVAL;
+
+	if (!force_scan && min_seq[!can_swap] + MAX_NR_GENS - 1 <=3D max_seq)
+		return -ERANGE;
+
+	try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, force_scan);
+
+	return 0;
+}
+
+static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct s=
can_control *sc,
+			int swappiness, unsigned long nr_to_reclaim)
+{
+	DEFINE_MAX_SEQ(lruvec);
+
+	if (seq + MIN_NR_GENS > max_seq)
+		return -EINVAL;
+
+	sc->nr_reclaimed =3D 0;
+
+	while (!signal_pending(current)) {
+		DEFINE_MIN_SEQ(lruvec);
+
+		if (seq < min_seq[!swappiness])
+			return 0;
+
+		if (sc->nr_reclaimed >=3D nr_to_reclaim)
+			return 0;
+
+		if (!evict_folios(lruvec, sc, swappiness, NULL))
+			return 0;
+
+		cond_resched();
+	}
+
+	return -EINTR;
+}
+
+static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
+		   struct scan_control *sc, int swappiness, unsigned long opt)
+{
+	struct lruvec *lruvec;
+	int err =3D -EINVAL;
+	struct mem_cgroup *memcg =3D NULL;
+
+	if (nid < 0 || nid >=3D MAX_NUMNODES || !node_state(nid, N_MEMORY))
+		return -EINVAL;
+
+	if (!mem_cgroup_disabled()) {
+		rcu_read_lock();
+		memcg =3D mem_cgroup_from_id(memcg_id);
+#ifdef CONFIG_MEMCG
+		if (memcg && !css_tryget(&memcg->css))
+			memcg =3D NULL;
+#endif
+		rcu_read_unlock();
+
+		if (!memcg)
+			return -EINVAL;
+	}
+
+	if (memcg_id !=3D mem_cgroup_id(memcg))
+		goto done;
+
+	lruvec =3D get_lruvec(memcg, nid);
+
+	if (swappiness < 0)
+		swappiness =3D get_swappiness(lruvec, sc);
+	else if (swappiness > 200)
+		goto done;
+
+	switch (cmd) {
+	case '+':
+		err =3D run_aging(lruvec, seq, sc, swappiness, opt);
+		break;
+	case '-':
+		err =3D run_eviction(lruvec, seq, sc, swappiness, opt);
+		break;
+	}
+done:
+	mem_cgroup_put(memcg);
+
+	return err;
+}
+
+static ssize_t lru_gen_seq_write(struct file *file, const char __user *src=
,
+				 size_t len, loff_t *pos)
+{
+	void *buf;
+	char *cur, *next;
+	unsigned int flags;
+	struct blk_plug plug;
+	int err =3D -EINVAL;
+	struct scan_control sc =3D {
+		.may_writepage =3D true,
+		.may_unmap =3D true,
+		.may_swap =3D true,
+		.reclaim_idx =3D MAX_NR_ZONES - 1,
+		.gfp_mask =3D GFP_KERNEL,
+	};
+
+	buf =3D kvmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, src, len)) {
+		kvfree(buf);
+		return -EFAULT;
+	}
+
+	set_task_reclaim_state(current, &sc.reclaim_state);
+	flags =3D memalloc_noreclaim_save();
+	blk_start_plug(&plug);
+	if (!set_mm_walk(NULL)) {
+		err =3D -ENOMEM;
+		goto done;
+	}
+
+	next =3D buf;
+	next[len] =3D '\0';
+
+	while ((cur =3D strsep(&next, ",;\n"))) {
+		int n;
+		int end;
+		char cmd;
+		unsigned int memcg_id;
+		unsigned int nid;
+		unsigned long seq;
+		unsigned int swappiness =3D -1;
+		unsigned long opt =3D -1;
+
+		cur =3D skip_spaces(cur);
+		if (!*cur)
+			continue;
+
+		n =3D sscanf(cur, "%c %u %u %lu %n %u %n %lu %n", &cmd, &memcg_id, &nid,
+			   &seq, &end, &swappiness, &end, &opt, &end);
+		if (n < 4 || cur[end]) {
+			err =3D -EINVAL;
+			break;
+		}
+
+		err =3D run_cmd(cmd, memcg_id, nid, seq, &sc, swappiness, opt);
+		if (err)
+			break;
+	}
+done:
+	clear_mm_walk();
+	blk_finish_plug(&plug);
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+
+	kvfree(buf);
+
+	return err ? : len;
+}
+
+static int lru_gen_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &lru_gen_seq_ops);
+}
+
+static const struct file_operations lru_gen_rw_fops =3D {
+	.open =3D lru_gen_seq_open,
+	.read =3D seq_read,
+	.write =3D lru_gen_seq_write,
+	.llseek =3D seq_lseek,
+	.release =3D seq_release,
+};
+
+static const struct file_operations lru_gen_ro_fops =3D {
+	.open =3D lru_gen_seq_open,
+	.read =3D seq_read,
+	.llseek =3D seq_lseek,
+	.release =3D seq_release,
+};
+
 /*************************************************************************=
*****
  *                          initialization
  *************************************************************************=
*****/
@@ -5409,6 +5797,9 @@ static int __init init_lru_gen(void)
 	if (sysfs_create_group(mm_kobj, &lru_gen_attr_group))
 		pr_err("lru_gen: failed to create sysfs group\n");
=20
+	debugfs_create_file("lru_gen", 0644, NULL, NULL, &lru_gen_rw_fops);
+	debugfs_create_file("lru_gen_full", 0444, NULL, NULL, &lru_gen_ro_fops);
+
 	return 0;
 };
 late_initcall(init_lru_gen);
--=20
2.37.3.968.ga6b4b080e4-goog

