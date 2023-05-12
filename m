Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DDF6FFD94
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbjEKX7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjEKX7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:59:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7F07A80
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:28 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24e1e19f63fso5250704a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683849568; x=1686441568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GvrXFTsUIEbl8XYlDYISM/+RLHQD32m4dCKsvb8PQPc=;
        b=Bgfqg9A7IvL9ARt7BoCja1L/qtbaDZTHexIhm2XU4kyEXtiZrmM/qjOaiJo1djtL+x
         iWtMq0zESMhpeAemlghV6H/RzMJJ/QMMwu9u3d4sDck/rXf331fruD55vhY4ZraZOvRG
         1c+/2/S1zj4uDEUUgPrQa5aQkOAADp5Out+rlzxkhcGXbPSLcqlrQAwDFQo7bfdWFLIN
         9RJS8/8DD3ZbfQs3wZr/lBkit+cYaLxqzvDgbgNVU+DnnJgzzmOhTTN91m5R9iqWt5Ws
         QPMt4zD/Gkd1asEzGcy+DuFI6BJ8UUjJvF2OGgtDMMH6dhi4RR7imEEXnsd9wcyUNeB1
         Ob8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849568; x=1686441568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvrXFTsUIEbl8XYlDYISM/+RLHQD32m4dCKsvb8PQPc=;
        b=DYzID/rWS3xhwD+66TuLr+RvOW5VU0Ip1LXQGyiEkdED+KLdbidRq+R5FdgpQBVOXi
         0WnUaW3pc0RLSxYMM7FpdPkQ6chrd5C/6LyVIOWFs4b+FNkY2C0P0AEuKQjl9rXFL+BF
         iBh6EQwTuSKB5f2ejmSeiItya6XjabK9phFyX4SpZTTisbZfqam8LbKw+NTIiu9sZiVi
         HSIuki/mBIpGVos2lrLDakHmG3P293hlKrxM/wBDysGayuyjwjAt/QzplssFq43wepAb
         UvnyNKkhQ2TEbS+pBIrCZCdV/snBv+FWRTuP0forfRY7Pa8KhZhrS7PSEZmij0L3igmC
         Sk+g==
X-Gm-Message-State: AC+VfDz71k9RdtVgEZ8PD2DKCpvblIVb/YhCWd3jo2M77/KrIdghXQns
        9Z0B2LkIrDUlfSLRGHIJ/r7WFHy50uA=
X-Google-Smtp-Source: ACHHUZ7iEL0gAfW/R21XnajEPgAghcG8a3/K79ZiJ4E5JKmumY7TbhUBcpMq3bvKEbl/g9Vs3fPHod7VUMo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c088:b0:24d:f3f5:4d2f with SMTP id
 o8-20020a17090ac08800b0024df3f54d2fmr6888039pjs.3.1683849567896; Thu, 11 May
 2023 16:59:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:59:13 -0700
In-Reply-To: <20230511235917.639770-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511235917.639770-6-seanjc@google.com>
Subject: [PATCH 5/9] KVM: x86/mmu: Convert "runtime" WARN_ON() assertions to WARN_ON_ONCE()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
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

Convert all "runtime" assertions, i.e. assertions that can be triggered
while running vCPUs, from WARN_ON() to WARN_ON_ONCE().  Every WARN in the
MMU that is tied to running vCPUs, i.e. not contained to loading and
initializing KVM, is likely to fire _a lot_ when it does trigger.  E.g. if
KVM ends up with a bug that causes a root to be invalidated before the
page fault handler is invoked, pretty much _every_ page fault VM-Exit
triggers the WARN.

If a WARN is triggered frequently, the resulting spam usually causes a lot
of damage of its own, e.g. consumes resources to log the WARN and pollutes
the kernel log, often to the point where other useful information can be
lost.  In many case, the damage caused by the spam is actually worse than
the bug itself, e.g. KVM can almost always recover from an unexpectedly
invalid root.

On the flip side, warning every time is rarely helpful for debug and
triage, i.e. a single splat is usually sufficient to point a debugger in
the right direction, and automated testing, e.g. syzkaller, typically runs
with warn_on_panic=1, i.e. will never get past the first WARN anyways.

Lastly, when an assertions fails multiple times, the stack traces in KVM
are almost always identical, i.e. the full splat only needs to be captured
once.  And _if_ there is value in captruing information about the failed
assert, a ratelimited printk() is sufficient and less likely to rack up a
large amount of collateral damage.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 48 ++++++++++++++++-----------------
 arch/x86/kvm/mmu/mmu_internal.h |  2 +-
 arch/x86/kvm/mmu/page_track.c   | 16 +++++------
 arch/x86/kvm/mmu/paging_tmpl.h  |  4 +--
 arch/x86/kvm/mmu/spte.c         |  4 +--
 arch/x86/kvm/mmu/tdp_iter.c     |  4 +--
 arch/x86/kvm/mmu/tdp_mmu.c      | 20 +++++++-------
 7 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 240272b10ceb..4731d2bf5af6 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -482,7 +482,7 @@ static u64 __get_spte_lockless(u64 *sptep)
  */
 static void mmu_spte_set(u64 *sptep, u64 new_spte)
 {
-	WARN_ON(is_shadow_present_pte(*sptep));
+	WARN_ON_ONCE(is_shadow_present_pte(*sptep));
 	__set_spte(sptep, new_spte);
 }
 
@@ -494,7 +494,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 {
 	u64 old_spte = *sptep;
 
-	WARN_ON(!is_shadow_present_pte(new_spte));
+	WARN_ON_ONCE(!is_shadow_present_pte(new_spte));
 	check_spte_writable_invariants(new_spte);
 
 	if (!is_shadow_present_pte(old_spte)) {
@@ -507,7 +507,7 @@ static u64 mmu_spte_update_no_track(u64 *sptep, u64 new_spte)
 	else
 		old_spte = __update_clear_spte_slow(sptep, new_spte);
 
-	WARN_ON(spte_to_pfn(old_spte) != spte_to_pfn(new_spte));
+	WARN_ON_ONCE(spte_to_pfn(old_spte) != spte_to_pfn(new_spte));
 
 	return old_spte;
 }
@@ -589,7 +589,7 @@ static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 	 * by a refcounted page, the refcount is elevated.
 	 */
 	page = kvm_pfn_to_refcounted_page(pfn);
-	WARN_ON(page && !page_count(page));
+	WARN_ON_ONCE(page && !page_count(page));
 
 	if (is_accessed_spte(old_spte))
 		kvm_set_pfn_accessed(pfn);
@@ -804,7 +804,7 @@ static void update_gfn_disallow_lpage_count(const struct kvm_memory_slot *slot,
 	for (i = PG_LEVEL_2M; i <= KVM_MAX_HUGEPAGE_LEVEL; ++i) {
 		linfo = lpage_info_slot(gfn, slot, i);
 		linfo->disallow_lpage += count;
-		WARN_ON(linfo->disallow_lpage < 0);
+		WARN_ON_ONCE(linfo->disallow_lpage < 0);
 	}
 }
 
@@ -1199,7 +1199,7 @@ static void drop_large_spte(struct kvm *kvm, u64 *sptep, bool flush)
 	struct kvm_mmu_page *sp;
 
 	sp = sptep_to_sp(sptep);
-	WARN_ON(sp->role.level == PG_LEVEL_4K);
+	WARN_ON_ONCE(sp->role.level == PG_LEVEL_4K);
 
 	drop_spte(kvm, sptep);
 
@@ -1458,7 +1458,7 @@ static bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	u64 new_spte;
 	kvm_pfn_t new_pfn;
 
-	WARN_ON(pte_huge(pte));
+	WARN_ON_ONCE(pte_huge(pte));
 	new_pfn = pte_pfn(pte);
 
 restart:
@@ -1816,7 +1816,7 @@ static int mmu_pages_add(struct kvm_mmu_pages *pvec, struct kvm_mmu_page *sp,
 static inline void clear_unsync_child_bit(struct kvm_mmu_page *sp, int idx)
 {
 	--sp->unsync_children;
-	WARN_ON((int)sp->unsync_children < 0);
+	WARN_ON_ONCE((int)sp->unsync_children < 0);
 	__clear_bit(idx, sp->unsync_child_bitmap);
 }
 
@@ -1874,7 +1874,7 @@ static int mmu_unsync_walk(struct kvm_mmu_page *sp,
 
 static void kvm_unlink_unsync_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
-	WARN_ON(!sp->unsync);
+	WARN_ON_ONCE(!sp->unsync);
 	trace_kvm_mmu_sync_page(sp);
 	sp->unsync = 0;
 	--kvm->stat.mmu_unsync;
@@ -2049,11 +2049,11 @@ static int mmu_pages_first(struct kvm_mmu_pages *pvec,
 	if (pvec->nr == 0)
 		return 0;
 
-	WARN_ON(pvec->page[0].idx != INVALID_INDEX);
+	WARN_ON_ONCE(pvec->page[0].idx != INVALID_INDEX);
 
 	sp = pvec->page[0].sp;
 	level = sp->role.level;
-	WARN_ON(level == PG_LEVEL_4K);
+	WARN_ON_ONCE(level == PG_LEVEL_4K);
 
 	parents->parent[level-2] = sp;
 
@@ -2075,7 +2075,7 @@ static void mmu_pages_clear_parents(struct mmu_page_path *parents)
 		if (!sp)
 			return;
 
-		WARN_ON(idx == INVALID_INDEX);
+		WARN_ON_ONCE(idx == INVALID_INDEX);
 		clear_unsync_child_bit(sp, idx);
 		level++;
 	} while (!sp->unsync_children);
@@ -2196,7 +2196,7 @@ static struct kvm_mmu_page *kvm_mmu_find_shadow_page(struct kvm *kvm,
 			if (ret < 0)
 				break;
 
-			WARN_ON(!list_empty(&invalid_list));
+			WARN_ON_ONCE(!list_empty(&invalid_list));
 			if (ret > 0)
 				kvm_flush_remote_tlbs(kvm);
 		}
@@ -2651,7 +2651,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	kvm_flush_remote_tlbs(kvm);
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
-		WARN_ON(!sp->role.invalid || sp->root_count);
+		WARN_ON_ONCE(!sp->role.invalid || sp->root_count);
 		kvm_mmu_free_shadow_page(sp);
 	}
 }
@@ -2846,7 +2846,7 @@ int mmu_try_to_unsync_pages(struct kvm *kvm, const struct kvm_memory_slot *slot,
 				continue;
 		}
 
-		WARN_ON(sp->role.level != PG_LEVEL_4K);
+		WARN_ON_ONCE(sp->role.level != PG_LEVEL_4K);
 		kvm_unsync_page(kvm, sp);
 	}
 	if (locked)
@@ -2999,7 +2999,7 @@ static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
 	u64 *spte, *start = NULL;
 	int i;
 
-	WARN_ON(!sp->role.direct);
+	WARN_ON_ONCE(!sp->role.direct);
 
 	i = spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
 	spte = sp->spt + i;
@@ -3545,7 +3545,7 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 	 * SPTE to ensure any non-PA bits are dropped.
 	 */
 	sp = spte_to_child_sp(*root_hpa);
-	if (WARN_ON(!sp))
+	if (WARN_ON_ONCE(!sp))
 		return;
 
 	if (is_tdp_mmu_page(sp))
@@ -4160,7 +4160,7 @@ static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
 		return RET_PF_EMULATE;
 
 	reserved = get_mmio_spte(vcpu, addr, &spte);
-	if (WARN_ON(reserved))
+	if (WARN_ON_ONCE(reserved))
 		return -EINVAL;
 
 	if (is_mmio_spte(spte)) {
@@ -5495,9 +5495,9 @@ void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 	struct kvm *kvm = vcpu->kvm;
 
 	kvm_mmu_free_roots(kvm, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root.hpa));
+	WARN_ON_ONCE(VALID_PAGE(vcpu->arch.root_mmu.root.hpa));
 	kvm_mmu_free_roots(kvm, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root.hpa));
+	WARN_ON_ONCE(VALID_PAGE(vcpu->arch.guest_mmu.root.hpa));
 	vcpu_clear_mmio_info(vcpu, MMIO_GVA_ANY);
 }
 
@@ -5701,7 +5701,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 	int r, emulation_type = EMULTYPE_PF;
 	bool direct = vcpu->arch.mmu->root_role.direct;
 
-	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
+	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		return RET_PF_RETRY;
 
 	r = RET_PF_INVALID;
@@ -6050,7 +6050,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
 		 * pages.  Skip the bogus page, otherwise we'll get stuck in an
 		 * infinite loop if the page gets put back on the list (again).
 		 */
-		if (WARN_ON(sp->role.invalid))
+		if (WARN_ON_ONCE(sp->role.invalid))
 			continue;
 
 		/*
@@ -6692,7 +6692,7 @@ void kvm_mmu_zap_all(struct kvm *kvm)
 	write_lock(&kvm->mmu_lock);
 restart:
 	list_for_each_entry_safe(sp, node, &kvm->arch.active_mmu_pages, link) {
-		if (WARN_ON(sp->role.invalid))
+		if (WARN_ON_ONCE(sp->role.invalid))
 			continue;
 		if (__kvm_mmu_prepare_zap_page(kvm, sp, &invalid_list, &ign))
 			goto restart;
@@ -6710,7 +6710,7 @@ void kvm_mmu_zap_all(struct kvm *kvm)
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 {
-	WARN_ON(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS);
+	WARN_ON_ONCE(gen & KVM_MEMSLOT_GEN_UPDATE_IN_PROGRESS);
 
 	gen &= MMIO_SPTE_GEN_MASK;
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index bb1649669bc9..cfe925fefa68 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -9,7 +9,7 @@
 #undef MMU_DEBUG
 
 #ifdef MMU_DEBUG
-#define KVM_MMU_WARN_ON(x) WARN_ON(x)
+#define KVM_MMU_WARN_ON(x) WARN_ON_ONCE(x)
 #else
 #define KVM_MMU_WARN_ON(x) do { } while (0)
 #endif
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index 0a2ac438d647..fd16918b3a7a 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -94,7 +94,7 @@ static void update_gfn_track(struct kvm_memory_slot *slot, gfn_t gfn,
 
 	val = slot->arch.gfn_track[mode][index];
 
-	if (WARN_ON(val + count < 0 || val + count > USHRT_MAX))
+	if (WARN_ON_ONCE(val + count < 0 || val + count > USHRT_MAX))
 		return;
 
 	slot->arch.gfn_track[mode][index] += count;
@@ -117,11 +117,11 @@ void kvm_slot_page_track_add_page(struct kvm *kvm,
 				  enum kvm_page_track_mode mode)
 {
 
-	if (WARN_ON(!page_track_mode_is_valid(mode)))
+	if (WARN_ON_ONCE(!page_track_mode_is_valid(mode)))
 		return;
 
-	if (WARN_ON(mode == KVM_PAGE_TRACK_WRITE &&
-		    !kvm_page_track_write_tracking_enabled(kvm)))
+	if (WARN_ON_ONCE(mode == KVM_PAGE_TRACK_WRITE &&
+			 !kvm_page_track_write_tracking_enabled(kvm)))
 		return;
 
 	update_gfn_track(slot, gfn, mode, 1);
@@ -155,11 +155,11 @@ void kvm_slot_page_track_remove_page(struct kvm *kvm,
 				     struct kvm_memory_slot *slot, gfn_t gfn,
 				     enum kvm_page_track_mode mode)
 {
-	if (WARN_ON(!page_track_mode_is_valid(mode)))
+	if (WARN_ON_ONCE(!page_track_mode_is_valid(mode)))
 		return;
 
-	if (WARN_ON(mode == KVM_PAGE_TRACK_WRITE &&
-		    !kvm_page_track_write_tracking_enabled(kvm)))
+	if (WARN_ON_ONCE(mode == KVM_PAGE_TRACK_WRITE &&
+			 !kvm_page_track_write_tracking_enabled(kvm)))
 		return;
 
 	update_gfn_track(slot, gfn, mode, -1);
@@ -181,7 +181,7 @@ bool kvm_slot_page_track_is_active(struct kvm *kvm,
 {
 	int index;
 
-	if (WARN_ON(!page_track_mode_is_valid(mode)))
+	if (WARN_ON_ONCE(!page_track_mode_is_valid(mode)))
 		return false;
 
 	if (!slot)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 7a97f769a7cb..a3fc7c1a7f8d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -633,7 +633,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	if (FNAME(gpte_changed)(vcpu, gw, top_level))
 		goto out_gpte_changed;
 
-	if (WARN_ON(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
+	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		goto out_gpte_changed;
 
 	for_each_shadow_entry(vcpu, fault->addr, it) {
@@ -830,7 +830,7 @@ static gpa_t FNAME(get_level1_sp_gpa)(struct kvm_mmu_page *sp)
 {
 	int offset = 0;
 
-	WARN_ON(sp->role.level != PG_LEVEL_4K);
+	WARN_ON_ONCE(sp->role.level != PG_LEVEL_4K);
 
 	if (PTTYPE == 32)
 		offset = sp->role.quadrant << SPTE_LEVEL_BITS;
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 438a86bda9f3..4a599130e9c9 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -61,7 +61,7 @@ static u64 generation_mmio_spte_mask(u64 gen)
 {
 	u64 mask;
 
-	WARN_ON(gen & ~MMIO_SPTE_GEN_MASK);
+	WARN_ON_ONCE(gen & ~MMIO_SPTE_GEN_MASK);
 
 	mask = (gen << MMIO_SPTE_GEN_LOW_SHIFT) & MMIO_SPTE_GEN_LOW_MASK;
 	mask |= (gen << MMIO_SPTE_GEN_HIGH_SHIFT) & MMIO_SPTE_GEN_HIGH_MASK;
@@ -240,7 +240,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	if ((spte & PT_WRITABLE_MASK) && kvm_slot_dirty_track_enabled(slot)) {
 		/* Enforced by kvm_mmu_hugepage_adjust. */
-		WARN_ON(level > PG_LEVEL_4K);
+		WARN_ON_ONCE(level > PG_LEVEL_4K);
 		mark_page_dirty_in_slot(vcpu->kvm, slot, gfn);
 	}
 
diff --git a/arch/x86/kvm/mmu/tdp_iter.c b/arch/x86/kvm/mmu/tdp_iter.c
index d2eb0d4f8710..5bb09f8d9fc6 100644
--- a/arch/x86/kvm/mmu/tdp_iter.c
+++ b/arch/x86/kvm/mmu/tdp_iter.c
@@ -41,8 +41,8 @@ void tdp_iter_start(struct tdp_iter *iter, struct kvm_mmu_page *root,
 {
 	int root_level = root->role.level;
 
-	WARN_ON(root_level < 1);
-	WARN_ON(root_level > PT64_ROOT_MAX_LEVEL);
+	WARN_ON_ONCE(root_level < 1);
+	WARN_ON_ONCE(root_level > PT64_ROOT_MAX_LEVEL);
 
 	iter->next_last_level_gfn = next_last_level_gfn;
 	iter->root_level = root_level;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6ef44d60ba2b..799479e84f8b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -475,9 +475,9 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
 
-	WARN_ON(level > PT64_ROOT_MAX_LEVEL);
-	WARN_ON(level < PG_LEVEL_4K);
-	WARN_ON(gfn & (KVM_PAGES_PER_HPAGE(level) - 1));
+	WARN_ON_ONCE(level > PT64_ROOT_MAX_LEVEL);
+	WARN_ON_ONCE(level < PG_LEVEL_4K);
+	WARN_ON_ONCE(gfn & (KVM_PAGES_PER_HPAGE(level) - 1));
 
 	/*
 	 * If this warning were to trigger it would indicate that there was a
@@ -522,9 +522,9 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 		 * impact the guest since both the former and current SPTEs
 		 * are nonpresent.
 		 */
-		if (WARN_ON(!is_mmio_spte(old_spte) &&
-			    !is_mmio_spte(new_spte) &&
-			    !is_removed_spte(new_spte)))
+		if (WARN_ON_ONCE(!is_mmio_spte(old_spte) &&
+				 !is_mmio_spte(new_spte) &&
+				 !is_removed_spte(new_spte)))
 			pr_err("Unexpected SPTE change! Nonpresent SPTEs\n"
 			       "should not be replaced with another,\n"
 			       "different nonpresent SPTE, unless one or both\n"
@@ -658,7 +658,7 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 	 * should be used. If operating under the MMU lock in write mode, the
 	 * use of the removed SPTE should not be necessary.
 	 */
-	WARN_ON(is_removed_spte(old_spte) || is_removed_spte(new_spte));
+	WARN_ON_ONCE(is_removed_spte(old_spte) || is_removed_spte(new_spte));
 
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
@@ -706,7 +706,7 @@ static inline bool __must_check tdp_mmu_iter_cond_resched(struct kvm *kvm,
 							  struct tdp_iter *iter,
 							  bool flush, bool shared)
 {
-	WARN_ON(iter->yielded);
+	WARN_ON_ONCE(iter->yielded);
 
 	/* Ensure forward progress has been made before yielding. */
 	if (iter->next_last_level_gfn == iter->yielded_gfn)
@@ -725,7 +725,7 @@ static inline bool __must_check tdp_mmu_iter_cond_resched(struct kvm *kvm,
 
 		rcu_read_lock();
 
-		WARN_ON(iter->gfn > iter->next_last_level_gfn);
+		WARN_ON_ONCE(iter->gfn > iter->next_last_level_gfn);
 
 		iter->yielded = true;
 	}
@@ -1238,7 +1238,7 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
 	u64 new_spte;
 
 	/* Huge pages aren't expected to be modified without first being zapped. */
-	WARN_ON(pte_huge(range->pte) || range->start + 1 != range->end);
+	WARN_ON_ONCE(pte_huge(range->pte) || range->start + 1 != range->end);
 
 	if (iter->level != PG_LEVEL_4K ||
 	    !is_shadow_present_pte(iter->old_spte))
-- 
2.40.1.606.ga4b1b128d6-goog

