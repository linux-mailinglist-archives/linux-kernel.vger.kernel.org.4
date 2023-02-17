Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7337269A4C0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjBQENK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjBQEMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:12:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74775B77C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:12:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p83-20020a25d856000000b0095d2ada3d26so4232041ybg.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhFwXntjEszX2NR0BL+FH//vn03ADgHeMtjzY93nmt4=;
        b=XNUXq0PTcl/8yQwac6rGM5O74+vQWyUh1AwA7ePVJdgeiAUlD4NgM/8W79T6ThAX5d
         8L+r3mqqpTd4bu5CNG4e4L2wx/8D5VXPDgeOyArsY1MkkauDIfO/A0RFt6d2vg5l2vmu
         hweIMbdWE0pJDts0aaAJhLSeQ2dvv4nx27ec6MfgxyUQn4go1b3A0P5I5YZe4zrvSmNQ
         QnjYpb9gyiRRAI7GOUcY7YneWU1+n/bWWipo6U9kb/M9PTR3QYPIaLf6KsnEUGCzyhdx
         EHGSfZ7eFdzHKHHjVuXrZx5KuVV/Ov5OwMCJJ/HnyOkrnjd7f6Knvbnn1fuBDRf5kRV+
         zuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XhFwXntjEszX2NR0BL+FH//vn03ADgHeMtjzY93nmt4=;
        b=7BvRBXB/6CrkOu9vRWX+1sb3r1g8wS+S6glpS9DkTbuNplHZ9CLTGXRhonoXn/+0G8
         rqZiTqwTbQe50Em9hr/y484a5OjhJBbL35z9v6SlbHeJz8MAnnPDZ6ov2Wbuh1n3/asn
         /c7AAbO6t4UFmwENxEWjcpfFuU6xL9XwhR96Sxbuu4G8ScLwBw2VzwuXwCNtT1k5Ml/h
         IcXv5drst3s5S2JHglqhNaX/sWCtBpoYKoD2ubMQLCraOUpJjyPGbIG+dgGXRblpCNCE
         Gy/xMn19C3dLACEp/yzEVz9WvqkdSAanpwdwteLKqk4VA0thN113vd2inJF7xB32kq4r
         5eFA==
X-Gm-Message-State: AO0yUKXbj0J8hMDyk5r5983LQc7jxaTrzA1E+4X/RIYT3+NuhbHHg3hY
        QFh4zpcslmrKwd0ysp654i/f5RLrf0c=
X-Google-Smtp-Source: AK7set9xe5nXschn8sCJ042xv+lkLsKlliPh3pvCt+D2t2Ej6DUaOZa2DrrSs5Y7E7xe7n5GA4zAjxW8lz0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:6fb3:61e:d31f:1ad3])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:308:b0:8dd:78cc:e52e with SMTP id
 b8-20020a056902030800b008dd78cce52emr65241ybs.13.1676607163481; Thu, 16 Feb
 2023 20:12:43 -0800 (PST)
Date:   Thu, 16 Feb 2023 21:12:30 -0700
In-Reply-To: <20230217041230.2417228-1-yuzhao@google.com>
Message-Id: <20230217041230.2417228-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20230217041230.2417228-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH mm-unstable v1 5/5] mm: multi-gen LRU: use mmu_notifier_test_clear_young()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-mm@google.com, Yu Zhao <yuzhao@google.com>
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

An existing selftest can quickly demonstrate the effectiveness of this
patch. On a generic workstation equipped with 128 CPUs and 256GB DRAM:

  $ sudo max_guest_memory_test -c 64 -m 250 -s 250

  MGLRU      run2
  ---------------
  Before    ~600s
  After      ~50s
  Off       ~250s

  kswapd (MGLRU before)
    100.00%  balance_pgdat
      100.00%  shrink_node
        100.00%  shrink_one
          99.97%  try_to_shrink_lruvec
            99.06%  evict_folios
              97.41%  shrink_folio_list
                31.33%  folio_referenced
                  31.06%  rmap_walk_file
                    30.89%  folio_referenced_one
                      20.83%  __mmu_notifier_clear_flush_young
                        20.54%  kvm_mmu_notifier_clear_flush_young
  =>                      19.34%  _raw_write_lock

  kswapd (MGLRU after)
    100.00%  balance_pgdat
      100.00%  shrink_node
        100.00%  shrink_one
          99.97%  try_to_shrink_lruvec
            99.51%  evict_folios
              71.70%  shrink_folio_list
                7.08%  folio_referenced
                  6.78%  rmap_walk_file
                    6.72%  folio_referenced_one
                      5.60%  lru_gen_look_around
  =>                    1.53%  __mmu_notifier_test_clear_young

  kswapd (MGLRU off)
    100.00%  balance_pgdat
      100.00%  shrink_node
        99.92%  shrink_lruvec
          69.95%  shrink_folio_list
            19.35%  folio_referenced
              18.37%  rmap_walk_file
                17.88%  folio_referenced_one
                  13.20%  __mmu_notifier_clear_flush_young
                    11.64%  kvm_mmu_notifier_clear_flush_young
  =>                  9.93%  _raw_write_lock
          26.23%  shrink_active_list
            25.50%  folio_referenced
              25.35%  rmap_walk_file
                25.28%  folio_referenced_one
                  23.87%  __mmu_notifier_clear_flush_young
                    23.69%  kvm_mmu_notifier_clear_flush_young
  =>                  18.98%  _raw_write_lock

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mmzone.h |   6 +-
 mm/rmap.c              |   8 +--
 mm/vmscan.c            | 127 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 121 insertions(+), 20 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9fb1b03b83b2..ce34b7ea8e4c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -379,6 +379,7 @@ enum {
 	LRU_GEN_CORE,
 	LRU_GEN_MM_WALK,
 	LRU_GEN_NONLEAF_YOUNG,
+	LRU_GEN_SPTE_WALK,
 	NR_LRU_GEN_CAPS
 };
 
@@ -485,7 +486,7 @@ struct lru_gen_mm_walk {
 };
 
 void lru_gen_init_lruvec(struct lruvec *lruvec);
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 #ifdef CONFIG_MEMCG
 
@@ -573,8 +574,9 @@ static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 }
 
-static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+static inline bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
+	return false;
 }
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/rmap.c b/mm/rmap.c
index 15ae24585fc4..eb0089f8f112 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -823,12 +823,10 @@ static bool folio_referenced_one(struct folio *folio,
 			return false; /* To break the loop */
 		}
 
-		if (pvmw.pte) {
-			if (lru_gen_enabled() && pte_young(*pvmw.pte)) {
-				lru_gen_look_around(&pvmw);
+		if (lru_gen_enabled() && pvmw.pte) {
+			if (lru_gen_look_around(&pvmw))
 				referenced++;
-			}
-
+		} else if (pvmw.pte) {
 			if (ptep_clear_flush_young_notify(vma, address,
 						pvmw.pte))
 				referenced++;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..d6d69f0baabf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -57,6 +57,8 @@
 #include <linux/khugepaged.h>
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
+#include <linux/mmu_notifier.h>
+#include <linux/kvm_host.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -3923,6 +3925,55 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 	return folio;
 }
 
+static bool test_spte_young(struct mm_struct *mm, unsigned long addr, unsigned long end,
+			    unsigned long *bitmap, unsigned long *last)
+{
+	if (!kvm_arch_has_test_clear_young() || !get_cap(LRU_GEN_SPTE_WALK))
+		return false;
+
+	if (*last > addr)
+		goto done;
+
+	*last = end - addr > MIN_LRU_BATCH * PAGE_SIZE ?
+		addr + MIN_LRU_BATCH * PAGE_SIZE - 1 : end - 1;
+	bitmap_zero(bitmap, MIN_LRU_BATCH);
+
+	mmu_notifier_test_clear_young(mm, addr, *last + 1, false, bitmap);
+done:
+	return test_bit((*last - addr) / PAGE_SIZE, bitmap);
+}
+
+static void clear_spte_young(struct mm_struct *mm, unsigned long addr,
+			     unsigned long *bitmap, unsigned long *last)
+{
+	int i;
+	unsigned long start, end = *last + 1;
+
+	if (addr + PAGE_SIZE != end)
+		return;
+
+	i = find_last_bit(bitmap, MIN_LRU_BATCH);
+	if (i == MIN_LRU_BATCH)
+		return;
+
+	start = end - (i + 1) * PAGE_SIZE;
+
+	i = find_first_bit(bitmap, MIN_LRU_BATCH);
+
+	end -= i * PAGE_SIZE;
+
+	mmu_notifier_test_clear_young(mm, start, end, false, bitmap);
+}
+
+static void skip_spte_young(struct mm_struct *mm, unsigned long addr,
+			    unsigned long *bitmap, unsigned long *last)
+{
+	if (*last > addr)
+		__clear_bit((*last - addr) / PAGE_SIZE, bitmap);
+
+	clear_spte_young(mm, addr, bitmap, last);
+}
+
 static bool suitable_to_scan(int total, int young)
 {
 	int n = clamp_t(int, cache_line_size() / sizeof(pte_t), 2, 8);
@@ -3938,6 +3989,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	pte_t *pte;
 	spinlock_t *ptl;
 	unsigned long addr;
+	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)];
+	unsigned long last = 0;
 	int total = 0;
 	int young = 0;
 	struct lru_gen_mm_walk *walk = args->private;
@@ -3956,6 +4009,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	pte = pte_offset_map(pmd, start & PMD_MASK);
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
+		bool success;
 		unsigned long pfn;
 		struct folio *folio;
 
@@ -3963,20 +4017,27 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		walk->mm_stats[MM_LEAF_TOTAL]++;
 
 		pfn = get_pte_pfn(pte[i], args->vma, addr);
-		if (pfn == -1)
+		if (pfn == -1) {
+			skip_spte_young(args->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
-		if (!pte_young(pte[i])) {
+		success = test_spte_young(args->vma->vm_mm, addr, end, bitmap, &last);
+		if (!success && !pte_young(pte[i])) {
+			skip_spte_young(args->vma->vm_mm, addr, bitmap, &last);
 			walk->mm_stats[MM_LEAF_OLD]++;
 			continue;
 		}
 
 		folio = get_pfn_folio(pfn, memcg, pgdat, walk->can_swap);
-		if (!folio)
+		if (!folio) {
+			skip_spte_young(args->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
-		if (!ptep_test_and_clear_young(args->vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
+		clear_spte_young(args->vma->vm_mm, addr, bitmap, &last);
+		if (pte_young(pte[i]))
+			ptep_test_and_clear_young(args->vma, addr, pte + i);
 
 		young++;
 		walk->mm_stats[MM_LEAF_YOUNG]++;
@@ -4581,6 +4642,24 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
  *                          rmap/PT walk feedback
  ******************************************************************************/
 
+static bool should_look_around(struct vm_area_struct *vma, unsigned long addr,
+			       pte_t *pte, int *young)
+{
+	unsigned long old = true;
+
+	*young = mmu_notifier_test_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE, true, &old);
+	if (!old)
+		*young = true;
+
+	if (pte_young(*pte)) {
+		ptep_test_and_clear_young(vma, addr, pte);
+		*young = true;
+		return true;
+	}
+
+	return !old && get_cap(LRU_GEN_SPTE_WALK);
+}
+
 /*
  * This function exploits spatial locality when shrink_folio_list() walks the
  * rmap. It scans the adjacent PTEs of a young PTE and promotes hot pages. If
@@ -4588,12 +4667,14 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
  * the PTE table to the Bloom filter. This forms a feedback loop between the
  * eviction and the aging.
  */
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
 	int i;
 	unsigned long start;
 	unsigned long end;
 	struct lru_gen_mm_walk *walk;
+	unsigned long bitmap[BITS_TO_LONGS(MIN_LRU_BATCH)];
+	unsigned long last = 0;
 	int young = 0;
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
@@ -4607,8 +4688,11 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	lockdep_assert_held(pvmw->ptl);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_lru(folio), folio);
 
+	if (!should_look_around(pvmw->vma, addr, pte, &young))
+		return young;
+
 	if (spin_is_contended(pvmw->ptl))
-		return;
+		return young;
 
 	/* avoid taking the LRU lock under the PTL when possible */
 	walk = current->reclaim_state ? current->reclaim_state->mm_walk : NULL;
@@ -4616,6 +4700,9 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	start = max(addr & PMD_MASK, pvmw->vma->vm_start);
 	end = min(addr | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
 
+	if (end - start == PAGE_SIZE)
+		return young;
+
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
 			end = start + MIN_LRU_BATCH * PAGE_SIZE;
@@ -4629,28 +4716,37 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 	/* folio_update_gen() requires stable folio_memcg() */
 	if (!mem_cgroup_trylock_pages(memcg))
-		return;
+		return young;
 
 	arch_enter_lazy_mmu_mode();
 
 	pte -= (addr - start) / PAGE_SIZE;
 
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
+		bool success;
 		unsigned long pfn;
 
 		pfn = get_pte_pfn(pte[i], pvmw->vma, addr);
-		if (pfn == -1)
+		if (pfn == -1) {
+			skip_spte_young(pvmw->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
-		if (!pte_young(pte[i]))
+		success = test_spte_young(pvmw->vma->vm_mm, addr, end, bitmap, &last);
+		if (!success && !pte_young(pte[i])) {
+			skip_spte_young(pvmw->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
 		folio = get_pfn_folio(pfn, memcg, pgdat, !walk || walk->can_swap);
-		if (!folio)
+		if (!folio) {
+			skip_spte_young(pvmw->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
-		if (!ptep_test_and_clear_young(pvmw->vma, addr, pte + i))
-			VM_WARN_ON_ONCE(true);
+		clear_spte_young(pvmw->vma->vm_mm, addr, bitmap, &last);
+		if (pte_young(pte[i]))
+			ptep_test_and_clear_young(pvmw->vma, addr, pte + i);
 
 		young++;
 
@@ -4680,6 +4776,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	/* feedback from rmap walkers to page table walkers */
 	if (suitable_to_scan(i, young))
 		update_bloom_filter(lruvec, max_seq, pvmw->pmd);
+
+	return young;
 }
 
 /******************************************************************************
@@ -5699,6 +5797,9 @@ static ssize_t show_enabled(struct kobject *kobj, struct kobj_attribute *attr, c
 	if (arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG))
 		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
 
+	if (kvm_arch_has_test_clear_young() && get_cap(LRU_GEN_SPTE_WALK))
+		caps |= BIT(LRU_GEN_SPTE_WALK);
+
 	return sysfs_emit(buf, "0x%04x\n", caps);
 }
 
-- 
2.39.2.637.g21b0678d19-goog

