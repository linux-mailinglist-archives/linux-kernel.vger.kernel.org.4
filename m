Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B99F5BBC68
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 10:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiIRICN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 04:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIRIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 04:01:20 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374FC2612C
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:12 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id d18-20020a056e020c1200b002eaea8e6081so17199043ile.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date;
        bh=hzWz5yIqdxPBtG3n8u72gXGclcsUftJL+vFh2EMoP40=;
        b=cUQ8jip/+lf8TiNdTgIAaNy8W/94KlZ+vOwYF0UHjccBjP4lvRuOOOl3G2qL/HaO+J
         vv8mKZIodQQfoWfQDXp4+wfk7LTHMzNPSwXfDO56trDFIJf8Sl67y1SC+cmyCdFxTtv4
         NFWjpn92bvdUwbwlcaLAJ+GT4h//PoWlgrAv8s+GVvAeh0aoVRE+LOmHww7rPB5CXMqx
         oCouvoV1ud1rTIlAluYZpah3fB0na2Tuw9a8oF2Um1nXfTT70X7kaWEjx3H6nUeDbjQF
         I33PLZm9p+iPRMfj5fC7l+hH2NQBgdU+xf4scQZv5P4Ej/B9VTXX7uIQs86VdfsB+STX
         Kjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date;
        bh=hzWz5yIqdxPBtG3n8u72gXGclcsUftJL+vFh2EMoP40=;
        b=GTJAqi+CQr5IvMyWL+/K3hfrFvtobwO6wK2KC7NAdjpbR2jve1D2wN9efn+HFtBFZD
         4oS0xyqAcpTgpYS7KAHSYqsm2ad2evY9S8z60/ESkTXA0z+17PZVYD/NWRdbxwndoZHU
         a9WRKd++AU9Pukh1zWUMu49IiflS/tUHr9y6oI+cY7ep3Z2XILOAkb+hFLPHWQL8LMDz
         ycB2b0SbEpcN2lAJ9lzlBeiaZ8Fp46eHpSxvlC396fnGZ4Eg11Rqk87xFl+6ZCLBJe3j
         jRdY/N1LKwHTlKuw0UmUUOobQuXIAmETtAA0nFa7H8mUvP4mepoPn7o0vOEFC1O1w86a
         2T3g==
X-Gm-Message-State: ACrzQf2MCIpo/Cwed/WcdDzzmO6L6VI6HBUpiW3z01+uAfBt30kU1x09
        ObUURdo9nKOAuMRtQFIMHSiTb38T1gw=
X-Google-Smtp-Source: AA6agR7hZGudiqlCB95xVmNZxYvw49p1vp8/HprHBojKDaaD/N+AnQOJW5mazU6t7f4eiWzdkFCBFN7fW5E=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:c05a:2e99:29cd:d157])
 (user=yuzhao job=sendgmr) by 2002:a05:6638:40a3:b0:35a:3f2d:a21c with SMTP id
 m35-20020a05663840a300b0035a3f2da21cmr5795164jam.221.1663488071607; Sun, 18
 Sep 2022 01:01:11 -0700 (PDT)
Date:   Sun, 18 Sep 2022 02:00:04 -0600
In-Reply-To: <20220918080010.2920238-1-yuzhao@google.com>
Message-Id: <20220918080010.2920238-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20220918080010.2920238-1-yuzhao@google.com>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
Subject: [PATCH mm-unstable v15 07/14] mm: multi-gen LRU: exploit locality in rmap
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
        Barry Song <baohua@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Searching the rmap for PTEs mapping each page on an LRU list (to test
and clear the accessed bit) can be expensive because pages from
different VMAs (PA space) are not cache friendly to the rmap (VA
space). For workloads mostly using mapped pages, searching the rmap
can incur the highest CPU cost in the reclaim path.

This patch exploits spatial locality to reduce the trips into the
rmap. When shrink_page_list() walks the rmap and finds a young PTE, a
new function lru_gen_look_around() scans at most BITS_PER_LONG-1
adjacent PTEs. On finding another young PTE, it clears the accessed
bit and updates the gen counter of the page mapped by this PTE to
(max_seq%MAX_NR_GENS)+1.

Server benchmark results:
  Single workload:
    fio (buffered I/O): no change

  Single workload:
    memcached (anon): +[3, 5]%
                Ops/sec      KB/sec
      patch1-6: 1106168.46   43025.04
      patch1-7: 1147696.57   44640.29

  Configurations:
    no change

Client benchmark results:
  kswapd profiles:
    patch1-6
      39.03%  lzo1x_1_do_compress (real work)
      18.47%  page_vma_mapped_walk (overhead)
       6.74%  _raw_spin_unlock_irq
       3.97%  do_raw_spin_lock
       2.49%  ptep_clear_flush
       2.48%  anon_vma_interval_tree_iter_first
       1.92%  folio_referenced_one
       1.88%  __zram_bvec_write
       1.48%  memmove
       1.31%  vma_interval_tree_iter_next

    patch1-7
      48.16%  lzo1x_1_do_compress (real work)
       8.20%  page_vma_mapped_walk (overhead)
       7.06%  _raw_spin_unlock_irq
       2.92%  ptep_clear_flush
       2.53%  __zram_bvec_write
       2.11%  do_raw_spin_lock
       2.02%  memmove
       1.93%  lru_gen_look_around
       1.56%  free_unref_page_list
       1.40%  memset

  Configurations:
    no change

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Barry Song <baohua@kernel.org>
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
 include/linux/memcontrol.h |  31 +++++++
 include/linux/mm.h         |   5 +
 include/linux/mmzone.h     |   6 ++
 mm/internal.h              |   1 +
 mm/memcontrol.c            |   1 +
 mm/rmap.c                  |   6 ++
 mm/swap.c                  |   4 +-
 mm/vmscan.c                | 184 +++++++++++++++++++++++++++++++++++++
 8 files changed, 236 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a2461f9a8738..9b8ab121d948 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -445,6 +445,7 @@ static inline struct obj_cgroup *__folio_objcg(struct f=
olio *folio)
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ * - mem_cgroup_trylock_pages()
  *
  * For a kmem folio a caller should hold an rcu read lock to protect memcg
  * associated with a kmem folio from being released.
@@ -506,6 +507,7 @@ static inline struct mem_cgroup *folio_memcg_rcu(struct=
 folio *folio)
  * - LRU isolation
  * - lock_page_memcg()
  * - exclusive reference
+ * - mem_cgroup_trylock_pages()
  *
  * For a kmem page a caller should hold an rcu read lock to protect memcg
  * associated with a kmem page from being released.
@@ -960,6 +962,23 @@ void unlock_page_memcg(struct page *page);
=20
 void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
=20
+/* try to stablize folio_memcg() for all the pages in a memcg */
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	rcu_read_lock();
+
+	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
+		return true;
+
+	rcu_read_unlock();
+	return false;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
 				   int idx, int val)
@@ -1434,6 +1453,18 @@ static inline void folio_memcg_unlock(struct folio *=
folio)
 {
 }
=20
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	/* to match folio_memcg_rcu() */
+	rcu_read_lock();
+	return true;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
 static inline void mem_cgroup_handle_over_high(void)
 {
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8a5ad9d050bf..7cc9ffc19e7f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1490,6 +1490,11 @@ static inline unsigned long folio_pfn(struct folio *=
folio)
 	return page_to_pfn(&folio->page);
 }
=20
+static inline struct folio *pfn_folio(unsigned long pfn)
+{
+	return page_folio(pfn_to_page(pfn));
+}
+
 static inline atomic_t *folio_pincount_ptr(struct folio *folio)
 {
 	return &folio_page(folio, 1)->compound_pincount;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7e343420bfb1..9ef5aa37c60c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -375,6 +375,7 @@ enum lruvec_flags {
 #ifndef __GENERATING_BOUNDS_H
=20
 struct lruvec;
+struct page_vma_mapped_walk;
=20
 #define LRU_GEN_MASK		((BIT(LRU_GEN_WIDTH) - 1) << LRU_GEN_PGOFF)
 #define LRU_REFS_MASK		((BIT(LRU_REFS_WIDTH) - 1) << LRU_REFS_PGOFF)
@@ -430,6 +431,7 @@ struct lru_gen_struct {
 };
=20
 void lru_gen_init_lruvec(struct lruvec *lruvec);
+void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
=20
 #ifdef CONFIG_MEMCG
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
@@ -442,6 +444,10 @@ static inline void lru_gen_init_lruvec(struct lruvec *=
lruvec)
 {
 }
=20
+static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+{
+}
+
 #ifdef CONFIG_MEMCG
 static inline void lru_gen_init_memcg(struct mem_cgroup *memcg)
 {
diff --git a/mm/internal.h b/mm/internal.h
index 4df67b6b8cce..0082d5fdddac 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
 void deactivate_file_folio(struct folio *folio);
+void folio_activate(struct folio *folio);
=20
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
 		unsigned long floor, unsigned long ceiling);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 937141d48221..4ea49113b0dd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2789,6 +2789,7 @@ static void commit_charge(struct folio *folio, struct=
 mem_cgroup *memcg)
 	 * - LRU isolation
 	 * - lock_page_memcg()
 	 * - exclusive reference
+	 * - mem_cgroup_trylock_pages()
 	 */
 	folio->memcg_data =3D (unsigned long)memcg;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 131def40e4f0..2ff17b9aabd9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -825,6 +825,12 @@ static bool folio_referenced_one(struct folio *folio,
 		}
=20
 		if (pvmw.pte) {
+			if (lru_gen_enabled() && pte_young(*pvmw.pte) &&
+			    !(vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))) {
+				lru_gen_look_around(&pvmw);
+				referenced++;
+			}
+
 			if (ptep_clear_flush_young_notify(vma, address,
 						pvmw.pte)) {
 				/*
diff --git a/mm/swap.c b/mm/swap.c
index f74fd51fa9e1..0a3871a70952 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -366,7 +366,7 @@ static void folio_activate_drain(int cpu)
 		folio_batch_move_lru(fbatch, folio_activate_fn);
 }
=20
-static void folio_activate(struct folio *folio)
+void folio_activate(struct folio *folio)
 {
 	if (folio_test_lru(folio) && !folio_test_active(folio) &&
 	    !folio_test_unevictable(folio)) {
@@ -385,7 +385,7 @@ static inline void folio_activate_drain(int cpu)
 {
 }
=20
-static void folio_activate(struct folio *folio)
+void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
=20
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d1e60feea8ab..33a1bdfc04bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1635,6 +1635,11 @@ static unsigned int shrink_page_list(struct list_hea=
d *page_list,
 		if (!sc->may_unmap && folio_mapped(folio))
 			goto keep_locked;
=20
+		/* folio_update_gen() tried to promote this page? */
+		if (lru_gen_enabled() && !ignore_references &&
+		    folio_mapped(folio) && folio_test_referenced(folio))
+			goto keep_locked;
+
 		/*
 		 * The number of dirty pages determines if a node is marked
 		 * reclaim_congested. kswapd will stall and start writing
@@ -3219,6 +3224,29 @@ static bool positive_ctrl_err(struct ctrl_pos *sp, s=
truct ctrl_pos *pv)
  *                          the aging
  *************************************************************************=
*****/
=20
+/* promote pages accessed through page tables */
+static int folio_update_gen(struct folio *folio, int gen)
+{
+	unsigned long new_flags, old_flags =3D READ_ONCE(folio->flags);
+
+	VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
+	VM_WARN_ON_ONCE(!rcu_read_lock_held());
+
+	do {
+		/* lru_gen_del_folio() has isolated this page? */
+		if (!(old_flags & LRU_GEN_MASK)) {
+			/* for shrink_page_list() */
+			new_flags =3D old_flags | BIT(PG_referenced);
+			continue;
+		}
+
+		new_flags =3D old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK | LRU_REFS_FLAG=
S);
+		new_flags |=3D (gen + 1UL) << LRU_GEN_PGOFF;
+	} while (!try_cmpxchg(&folio->flags, &old_flags, new_flags));
+
+	return ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+}
+
 /* protect pages accessed multiple times through file descriptors */
 static int folio_inc_gen(struct lruvec *lruvec, struct folio *folio, bool =
reclaiming)
 {
@@ -3230,6 +3258,11 @@ static int folio_inc_gen(struct lruvec *lruvec, stru=
ct folio *folio, bool reclai
 	VM_WARN_ON_ONCE_FOLIO(!(old_flags & LRU_GEN_MASK), folio);
=20
 	do {
+		new_gen =3D ((old_flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
+		/* folio_update_gen() has promoted this page? */
+		if (new_gen >=3D 0 && new_gen !=3D old_gen)
+			return new_gen;
+
 		new_gen =3D (old_gen + 1) % MAX_NR_GENS;
=20
 		new_flags =3D old_flags & ~(LRU_GEN_MASK | LRU_REFS_MASK | LRU_REFS_FLAG=
S);
@@ -3244,6 +3277,43 @@ static int folio_inc_gen(struct lruvec *lruvec, stru=
ct folio *folio, bool reclai
 	return new_gen;
 }
=20
+static unsigned long get_pte_pfn(pte_t pte, struct vm_area_struct *vma, un=
signed long addr)
+{
+	unsigned long pfn =3D pte_pfn(pte);
+
+	VM_WARN_ON_ONCE(addr < vma->vm_start || addr >=3D vma->vm_end);
+
+	if (!pte_present(pte) || is_zero_pfn(pfn))
+		return -1;
+
+	if (WARN_ON_ONCE(pte_devmap(pte) || pte_special(pte)))
+		return -1;
+
+	if (WARN_ON_ONCE(!pfn_valid(pfn)))
+		return -1;
+
+	return pfn;
+}
+
+static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *m=
emcg,
+				   struct pglist_data *pgdat)
+{
+	struct folio *folio;
+
+	/* try to avoid unnecessary memory loads */
+	if (pfn < pgdat->node_start_pfn || pfn >=3D pgdat_end_pfn(pgdat))
+		return NULL;
+
+	folio =3D pfn_folio(pfn);
+	if (folio_nid(folio) !=3D pgdat->node_id)
+		return NULL;
+
+	if (folio_memcg_rcu(folio) !=3D memcg)
+		return NULL;
+
+	return folio;
+}
+
 static void inc_min_seq(struct lruvec *lruvec, int type)
 {
 	struct lru_gen_struct *lrugen =3D &lruvec->lrugen;
@@ -3443,6 +3513,114 @@ static void lru_gen_age_node(struct pglist_data *pg=
dat, struct scan_control *sc)
 	} while ((memcg =3D mem_cgroup_iter(NULL, memcg, NULL)));
 }
=20
+/*
+ * This function exploits spatial locality when shrink_page_list() walks t=
he
+ * rmap. It scans the adjacent PTEs of a young PTE and promotes hot pages.
+ */
+void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+{
+	int i;
+	pte_t *pte;
+	unsigned long start;
+	unsigned long end;
+	unsigned long addr;
+	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)] =3D {};
+	struct folio *folio =3D pfn_folio(pvmw->pfn);
+	struct mem_cgroup *memcg =3D folio_memcg(folio);
+	struct pglist_data *pgdat =3D folio_pgdat(folio);
+	struct lruvec *lruvec =3D mem_cgroup_lruvec(memcg, pgdat);
+	DEFINE_MAX_SEQ(lruvec);
+	int old_gen, new_gen =3D lru_gen_from_seq(max_seq);
+
+	lockdep_assert_held(pvmw->ptl);
+	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
+
+	if (spin_is_contended(pvmw->ptl))
+		return;
+
+	start =3D max(pvmw->address & PMD_MASK, pvmw->vma->vm_start);
+	end =3D min(pvmw->address | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
+
+	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
+		if (pvmw->address - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
+			end =3D start + MIN_LRU_BATCH * PAGE_SIZE;
+		else if (end - pvmw->address < MIN_LRU_BATCH * PAGE_SIZE / 2)
+			start =3D end - MIN_LRU_BATCH * PAGE_SIZE;
+		else {
+			start =3D pvmw->address - MIN_LRU_BATCH * PAGE_SIZE / 2;
+			end =3D pvmw->address + MIN_LRU_BATCH * PAGE_SIZE / 2;
+		}
+	}
+
+	pte =3D pvmw->pte - (pvmw->address - start) / PAGE_SIZE;
+
+	rcu_read_lock();
+	arch_enter_lazy_mmu_mode();
+
+	for (i =3D 0, addr =3D start; addr !=3D end; i++, addr +=3D PAGE_SIZE) {
+		unsigned long pfn;
+
+		pfn =3D get_pte_pfn(pte[i], pvmw->vma, addr);
+		if (pfn =3D=3D -1)
+			continue;
+
+		if (!pte_young(pte[i]))
+			continue;
+
+		folio =3D get_pfn_folio(pfn, memcg, pgdat);
+		if (!folio)
+			continue;
+
+		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
+			VM_WARN_ON_ONCE(true);
+
+		if (pte_dirty(pte[i]) && !folio_test_dirty(folio) &&
+		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
+		      !folio_test_swapcache(folio)))
+			folio_mark_dirty(folio);
+
+		old_gen =3D folio_lru_gen(folio);
+		if (old_gen < 0)
+			folio_set_referenced(folio);
+		else if (old_gen !=3D new_gen)
+			__set_bit(i, bitmap);
+	}
+
+	arch_leave_lazy_mmu_mode();
+	rcu_read_unlock();
+
+	if (bitmap_weight(bitmap, MIN_LRU_BATCH) < PAGEVEC_SIZE) {
+		for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
+			folio =3D pfn_folio(pte_pfn(pte[i]));
+			folio_activate(folio);
+		}
+		return;
+	}
+
+	/* folio_update_gen() requires stable folio_memcg() */
+	if (!mem_cgroup_trylock_pages(memcg))
+		return;
+
+	spin_lock_irq(&lruvec->lru_lock);
+	new_gen =3D lru_gen_from_seq(lruvec->lrugen.max_seq);
+
+	for_each_set_bit(i, bitmap, MIN_LRU_BATCH) {
+		folio =3D pfn_folio(pte_pfn(pte[i]));
+		if (folio_memcg_rcu(folio) !=3D memcg)
+			continue;
+
+		old_gen =3D folio_update_gen(folio, new_gen);
+		if (old_gen < 0 || old_gen =3D=3D new_gen)
+			continue;
+
+		lru_gen_update_size(lruvec, folio, old_gen, new_gen);
+	}
+
+	spin_unlock_irq(&lruvec->lru_lock);
+
+	mem_cgroup_unlock_pages();
+}
+
 /*************************************************************************=
*****
  *                          the eviction
  *************************************************************************=
*****/
@@ -3479,6 +3657,12 @@ static bool sort_folio(struct lruvec *lruvec, struct=
 folio *folio, int tier_idx)
 		return true;
 	}
=20
+	/* promoted */
+	if (gen !=3D lru_gen_from_seq(lrugen->min_seq[type])) {
+		list_move(&folio->lru, &lrugen->lists[gen][type][zone]);
+		return true;
+	}
+
 	/* protected */
 	if (tier > tier_idx) {
 		int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
--=20
2.37.3.968.ga6b4b080e4-goog

