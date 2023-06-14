Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E85713092
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbjEZXp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238148AbjEZXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:45:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26250E70
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:45:11 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56561689700so30245467b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685144697; x=1687736697;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/RAbaZ7nXlJx1O5X4p6tDmC38Mqs0IR+WFkcAEID/ew=;
        b=Mb/TwMrvjKVwx825EpuGBZelUYT9y1q5MsHWLZEtcnYl8b+S/FmG3PWbpa3sjl3UbU
         EMKVg4Z0PKkBIeb7T3roSS0cZqaFmagaFcdMijquvBPxR+8cgeB8lhD+sxDLIAW92iZI
         96AhG517DtCX6M6wF+UEXQXmnvh+bt6+TMXBvO0EA6fZL0y2SwCLgjF2MAZnONkhWo1g
         K/7v7mGu5qj4MRpb1kQzn2rxfgDVCTzMnRuNoX97x4mDqSBErwlSjFlQrZ/jaGBbYaIg
         V4TtJk4J+bx9E13IjCR46uiaNAT2c4P7QhpLAYBCKMArI7L7xnoEXLbituEB7FbRo2Qm
         2ytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685144697; x=1687736697;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/RAbaZ7nXlJx1O5X4p6tDmC38Mqs0IR+WFkcAEID/ew=;
        b=ZShLFnS94IR4eONY6Mv8EsFPHX3BTTLpaA2dVTWCMWvU6YcC6xVSenPr2zBax5susX
         d1sSVJ+XmVOom5+Y3eezub3Wor2TzqIlFt+fuiaOKSnUTLqaVIV8107ka6Q5o80GWzGJ
         lacp67uZuvbvNKkw9dFUaJ23b4N1qRPxgTYvon1ZBhOLlP6JnGOICZlDIy/nD6SuNPzc
         9IAs/TAWKddpqOxRReUDMpiCmYgq4MMgIZDMgwmYTX4Avgm3BoeAcnycMKze+MLLnqAW
         81osYsW9xJWTWvadfvkUAYgZzw6J98+Q1bb0JqD+D7daHUyg/rVrsq/BvbiU7too2P26
         ZdaA==
X-Gm-Message-State: AC+VfDy5/uT/l/+nxfsKdsjEFzIFZOdaI1WhcTu7YxA8pxzf/vzxfp76
        wxrAK5DMQp95wzf05wN22DEaifx7S5g=
X-Google-Smtp-Source: ACHHUZ5acKzCjiqXNcqUiyX95r/zGZ1H0IqWVk5xr51BxFwYKtaOrUj82KqB/feXRTG2Ot17Gvh9/gGxmKY=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:910f:8a15:592b:2087])
 (user=yuzhao job=sendgmr) by 2002:a81:c542:0:b0:561:1d3b:af3f with SMTP id
 o2-20020a81c542000000b005611d3baf3fmr2060709ywj.8.1685144697389; Fri, 26 May
 2023 16:44:57 -0700 (PDT)
Date:   Fri, 26 May 2023 17:44:35 -0600
In-Reply-To: <20230526234435.662652-1-yuzhao@google.com>
Message-Id: <20230526234435.662652-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20230526234435.662652-1-yuzhao@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH mm-unstable v2 10/10] mm: multi-gen LRU: use mmu_notifier_test_clear_young()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Anup Patel <anup@brainfault.org>,
        Ben Gardon <bgardon@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Gavin Shan <gshan@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Larabel <michael@michaellarabel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paul Mackerras <paulus@ozlabs.org>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Huth <thuth@redhat.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-trace-kernel@vger.kernel.org, x86@kernel.org,
        linux-mm@google.com, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mmu_notifier_test_clear_young() to handle KVM PTEs in batches
when the fast path is supported. This reduces the contention on
kvm->mmu_lock when the host is under heavy memory pressure.

An existing selftest can quickly demonstrate the effectiveness of
this patch. On a generic workstation equipped with 128 CPUs and 256GB
DRAM:

  $ sudo max_guest_memory_test -c 64 -m 250 -s 250

  MGLRU         run2
  ------------------
  Before [1]    ~64s
  After         ~51s

  kswapd (MGLRU before)
    100.00%  balance_pgdat
      100.00%  shrink_node
        100.00%  shrink_one
          99.99%  try_to_shrink_lruvec
            99.71%  evict_folios
              97.29%  shrink_folio_list
  ==>>          13.05%  folio_referenced
                  12.83%  rmap_walk_file
                    12.31%  folio_referenced_one
                      7.90%  __mmu_notifier_clear_young
                        7.72%  kvm_mmu_notifier_clear_young
                          7.34%  _raw_write_lock

  kswapd (MGLRU after)
    100.00%  balance_pgdat
      100.00%  shrink_node
        100.00%  shrink_one
          99.99%  try_to_shrink_lruvec
            99.59%  evict_folios
              80.37%  shrink_folio_list
  ==>>          3.74%  folio_referenced
                  3.59%  rmap_walk_file
                    3.19%  folio_referenced_one
                      2.53%  lru_gen_look_around
                        1.06%  __mmu_notifier_test_clear_young

[1] "mm: rmap: Don't flush TLB after checking PTE young for page
    reference" was included so that the comparison is apples to
    apples.
    https://lore.kernel.org/r/20220706112041.3831-1-21cnbao@gmail.com/

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 Documentation/admin-guide/mm/multigen_lru.rst |   6 +-
 include/linux/mmzone.h                        |   6 +-
 mm/rmap.c                                     |   8 +-
 mm/vmscan.c                                   | 139 ++++++++++++++++--
 4 files changed, 138 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
index 33e068830497..0ae2a6d4d94c 100644
--- a/Documentation/admin-guide/mm/multigen_lru.rst
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -48,6 +48,10 @@ Values Components
        verified on x86 varieties other than Intel and AMD. If it is
        disabled, the multi-gen LRU will suffer a negligible
        performance degradation.
+0x0008 Clearing the accessed bit in KVM page table entries in large
+       batches, when KVM MMU sets it (e.g., on x86_64). This can
+       improve the performance of guests when the host is under memory
+       pressure.
 [yYnN] Apply to all the components above.
 ====== ===============================================================
 
@@ -56,7 +60,7 @@ E.g.,
 
     echo y >/sys/kernel/mm/lru_gen/enabled
     cat /sys/kernel/mm/lru_gen/enabled
-    0x0007
+    0x000f
     echo 5 >/sys/kernel/mm/lru_gen/enabled
     cat /sys/kernel/mm/lru_gen/enabled
     0x0005
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5a7ada0413da..1b148f39fabc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -369,6 +369,7 @@ enum {
 	LRU_GEN_CORE,
 	LRU_GEN_MM_WALK,
 	LRU_GEN_NONLEAF_YOUNG,
+	LRU_GEN_KVM_MMU_WALK,
 	NR_LRU_GEN_CAPS
 };
 
@@ -471,7 +472,7 @@ struct lru_gen_mm_walk {
 };
 
 void lru_gen_init_lruvec(struct lruvec *lruvec);
-void lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
+bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 #ifdef CONFIG_MEMCG
 
@@ -559,8 +560,9 @@ static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 }
 
-static inline void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
+static inline bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 {
+	return false;
 }
 
 #ifdef CONFIG_MEMCG
diff --git a/mm/rmap.c b/mm/rmap.c
index ae127f60a4fb..3a2c4e6a0887 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -825,12 +825,10 @@ static bool folio_referenced_one(struct folio *folio,
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
index ef687f9be13c..3f734588b600 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -58,6 +58,7 @@
 #include <linux/rculist_nulls.h>
 #include <linux/random.h>
 #include <linux/srcu.h>
+#include <linux/mmu_notifier.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -3244,6 +3245,20 @@ static bool should_clear_pmd_young(void)
 	return arch_has_hw_nonleaf_pmd_young() && get_cap(LRU_GEN_NONLEAF_YOUNG);
 }
 
+#if IS_ENABLED(CONFIG_KVM)
+#include <linux/kvm_host.h>
+
+static bool should_walk_kvm_mmu(void)
+{
+	return kvm_arch_has_test_clear_young() && get_cap(LRU_GEN_KVM_MMU_WALK);
+}
+#else
+static bool should_walk_kvm_mmu(void)
+{
+	return false;
+}
+#endif
+
 /******************************************************************************
  *                          shorthand helpers
  ******************************************************************************/
@@ -3982,6 +3997,55 @@ static struct folio *get_pfn_folio(unsigned long pfn, struct mem_cgroup *memcg,
 	return folio;
 }
 
+static bool test_spte_young(struct mm_struct *mm, unsigned long addr, unsigned long end,
+			    unsigned long *bitmap, unsigned long *last)
+{
+	if (!should_walk_kvm_mmu())
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
+	mmu_notifier_test_clear_young(mm, start, end, true, bitmap);
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
@@ -3997,6 +4061,8 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	pte_t *pte;
 	spinlock_t *ptl;
 	unsigned long addr;
+	DECLARE_BITMAP(bitmap, MIN_LRU_BATCH);
+	unsigned long last = 0;
 	int total = 0;
 	int young = 0;
 	struct lru_gen_mm_walk *walk = args->private;
@@ -4015,6 +4081,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 	pte = pte_offset_map(pmd, start & PMD_MASK);
 restart:
 	for (i = pte_index(start), addr = start; addr != end; i++, addr += PAGE_SIZE) {
+		bool ret;
 		unsigned long pfn;
 		struct folio *folio;
 
@@ -4022,20 +4089,27 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		walk->mm_stats[MM_LEAF_TOTAL]++;
 
 		pfn = get_pte_pfn(pte[i], args->vma, addr);
-		if (pfn == -1)
+		if (pfn == -1) {
+			skip_spte_young(args->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
-		if (!pte_young(pte[i])) {
+		ret = test_spte_young(args->vma->vm_mm, addr, end, bitmap, &last);
+		if (!ret && !pte_young(pte[i])) {
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
@@ -4629,6 +4703,23 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
  *                          rmap/PT walk feedback
  ******************************************************************************/
 
+static bool should_look_around(struct vm_area_struct *vma, unsigned long addr,
+			       pte_t *pte, int *young)
+{
+	int ret = mmu_notifier_clear_young(vma->vm_mm, addr, addr + PAGE_SIZE);
+
+	if (pte_young(*pte)) {
+		ptep_test_and_clear_young(vma, addr, pte);
+		*young = true;
+		return true;
+	}
+
+	if (ret)
+		*young = true;
+
+	return ret & MMU_NOTIFIER_RANGE_LOCKLESS;
+}
+
 /*
  * This function exploits spatial locality when shrink_folio_list() walks the
  * rmap. It scans the adjacent PTEs of a young PTE and promotes hot pages. If
@@ -4636,12 +4727,14 @@ static void lru_gen_age_node(struct pglist_data *pgdat, struct scan_control *sc)
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
+	DECLARE_BITMAP(bitmap, MIN_LRU_BATCH);
+	unsigned long last = 0;
 	int young = 0;
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
@@ -4655,8 +4748,11 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
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
@@ -4664,6 +4760,9 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	start = max(addr & PMD_MASK, pvmw->vma->vm_start);
 	end = min(addr | ~PMD_MASK, pvmw->vma->vm_end - 1) + 1;
 
+	if (end - start == PAGE_SIZE)
+		return young;
+
 	if (end - start > MIN_LRU_BATCH * PAGE_SIZE) {
 		if (addr - start < MIN_LRU_BATCH * PAGE_SIZE / 2)
 			end = start + MIN_LRU_BATCH * PAGE_SIZE;
@@ -4677,28 +4776,37 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 
 	/* folio_update_gen() requires stable folio_memcg() */
 	if (!mem_cgroup_trylock_pages(memcg))
-		return;
+		return young;
 
 	arch_enter_lazy_mmu_mode();
 
 	pte -= (addr - start) / PAGE_SIZE;
 
 	for (i = 0, addr = start; addr != end; i++, addr += PAGE_SIZE) {
+		bool ret;
 		unsigned long pfn;
 
 		pfn = get_pte_pfn(pte[i], pvmw->vma, addr);
-		if (pfn == -1)
+		if (pfn == -1) {
+			skip_spte_young(pvmw->vma->vm_mm, addr, bitmap, &last);
 			continue;
+		}
 
-		if (!pte_young(pte[i]))
+		ret = test_spte_young(pvmw->vma->vm_mm, addr, end, bitmap, &last);
+		if (!ret && !pte_young(pte[i])) {
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
 
@@ -4728,6 +4836,8 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	/* feedback from rmap walkers to page table walkers */
 	if (suitable_to_scan(i, young))
 		update_bloom_filter(lruvec, max_seq, pvmw->pmd);
+
+	return young;
 }
 
 /******************************************************************************
@@ -5745,6 +5855,9 @@ static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, c
 	if (should_clear_pmd_young())
 		caps |= BIT(LRU_GEN_NONLEAF_YOUNG);
 
+	if (should_walk_kvm_mmu())
+		caps |= BIT(LRU_GEN_KVM_MMU_WALK);
+
 	return sysfs_emit(buf, "0x%04x\n", caps);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

