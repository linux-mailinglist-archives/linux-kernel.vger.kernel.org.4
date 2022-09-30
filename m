Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88545F08E8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbiI3KX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiI3KTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:19:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A591893AB;
        Fri, 30 Sep 2022 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664533146; x=1696069146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SmrDC7LkT2pOV82ObFM3LLr9crX/KxPGTCQnZqzp2+g=;
  b=FSu7vODs0QoGa3yVrqjXTo2AFb5htrSmIqjGjHTLIXzbHfymAxIo3Nnp
   AQXRcL3WF6MkYXBu0pRlUx7erO6fiF4/K6cNn/Ibfgy0W2TBJFxC8On0M
   TwDVYEYHN1O5vEbL7BFbg7b1j61ZfIKcP0XPyUBG4mgumCWlynIJATAGY
   zq+pSkSDRXBw2f5CNR/uISHF3yNlzn14eJq3nOcrTGwYyUXzyH2KqdEx5
   jprR/UacxeBJZijZFhpdg+4TYOVr7hffudLopaT50lunxlXfc5Fh0WFEL
   /1zEfoJDtlYuRgvbEEer5HKD8/Jcz7pZNO85pmPh57N9nyoW0e4u8+Vw4
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="281870106"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="281870106"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:18:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726807649"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="726807649"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:18:59 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>
Subject: [PATCH v9 046/105] KVM: x86/tdp_mmu: Support TDX private mapping for TDP MMU
Date:   Fri, 30 Sep 2022 03:17:40 -0700
Message-Id: <0ac18bef9f51e535bbcb0162882478987a41c595.1664530907.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664530907.git.isaku.yamahata@intel.com>
References: <cover.1664530907.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Allocate protected page table for private page table, and add hooks to
operate on protected page table.  This patch adds allocation/free of
protected page tables and hooks.  When calling hooks to update SPTE entry,
freeze the entry, call hooks and unfree the entry to allow concurrent
updates on page tables.  Which is the advantage of TDP MMU.  As
kvm_gfn_shared_mask() returns false always, those hooks aren't called yet
with this patch.

When the faulting GPA is private, the KVM fault is called private.  When
resolving private KVM, allocate protected page table and call hooks to
operate on protected page table. On the change of the private PTE entry,
invoke kvm_x86_ops hook in __handle_changed_spte() to propagate the change
to protected page table. The following depicts the relationship.

  private KVM page fault   |
      |                    |
      V                    |
 private GPA               |     CPU protected EPTP
      |                    |           |
      V                    |           V
 private PT root           |     protected PT root
      |                    |           |
      V                    |           V
   private PT --hook to propagate-->protected PT
      |                    |           |
      \--------------------+------\    |
                           |      |    |
                           |      V    V
                           |    private guest page
                           |
                           |
     non-encrypted memory  |    encrypted memory
                           |
PT: page table

The existing KVM TDP MMU code uses atomic update of SPTE.  On populating
the EPT entry, atomically set the entry.  However, it requires TLB
shootdown to zap SPTE.  To address it, the entry is frozen with the special
SPTE value that clears the present bit. After the TLB shootdown, the entry
is set to the eventual value (unfreeze).

For protected page table, hooks are called to update protected page table
in addition to direct access to the private SPTE. For the zapping case, it
works to freeze the SPTE. It can call hooks in addition to TLB shootdown.
For populating the private SPTE entry, there can be a race condition
without further protection

  vcpu 1: populating 2M private SPTE
  vcpu 2: populating 4K private SPTE
  vcpu 2: TDX SEAMCALL to update 4K protected SPTE => error
  vcpu 1: TDX SEAMCALL to update 2M protected SPTE

To avoid the race, the frozen SPTE is utilized.  Instead of atomic update
of the private entry, freeze the entry, call the hook that update protected
SPTE, set the entry to the final value.

Support 4K page only at this stage.  2M page support can be done in future
patches.

Co-developed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |   5 +
 arch/x86/include/asm/kvm_host.h    |  11 ++
 arch/x86/kvm/mmu/mmu.c             |  15 +-
 arch/x86/kvm/mmu/mmu_internal.h    |  32 ++++
 arch/x86/kvm/mmu/tdp_iter.h        |   2 +-
 arch/x86/kvm/mmu/tdp_mmu.c         | 237 +++++++++++++++++++++++++----
 arch/x86/kvm/mmu/tdp_mmu.h         |   2 +-
 virt/kvm/kvm_main.c                |   1 +
 8 files changed, 269 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 104a34b44e94..757952f186f8 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -94,6 +94,11 @@ KVM_X86_OP_OPTIONAL_RET0(set_tss_addr)
 KVM_X86_OP_OPTIONAL_RET0(set_identity_map_addr)
 KVM_X86_OP_OPTIONAL_RET0(get_mt_mask)
 KVM_X86_OP(load_mmu_pgd)
+KVM_X86_OP_OPTIONAL(link_private_spt)
+KVM_X86_OP_OPTIONAL(free_private_spt)
+KVM_X86_OP_OPTIONAL(set_private_spte)
+KVM_X86_OP_OPTIONAL(remove_private_spte)
+KVM_X86_OP_OPTIONAL(zap_private_spte)
 KVM_X86_OP(has_wbinvd_exit)
 KVM_X86_OP(get_l2_tsc_offset)
 KVM_X86_OP(get_l2_tsc_multiplier)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 789a8de4028a..b9ebe82a4c37 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -468,6 +468,7 @@ struct kvm_mmu {
 			 struct kvm_mmu_page *sp);
 	void (*invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa);
 	struct kvm_mmu_root_info root;
+	hpa_t private_root_hpa;
 	union kvm_cpu_role cpu_role;
 	union kvm_mmu_page_role root_role;
 
@@ -1607,6 +1608,16 @@ struct kvm_x86_ops {
 	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			     int root_level);
 
+	int (*link_private_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
+				void *private_spt);
+	int (*free_private_spt)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
+				void *private_spt);
+	void (*set_private_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
+				 kvm_pfn_t pfn);
+	void (*remove_private_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level,
+				    kvm_pfn_t pfn);
+	void (*zap_private_spte)(struct kvm *kvm, gfn_t gfn, enum pg_level level);
+
 	bool (*has_wbinvd_exit)(void);
 
 	u64 (*get_l2_tsc_offset)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 84a08aa180b7..c9013213641e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3608,7 +3608,12 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		goto out_unlock;
 
 	if (is_tdp_mmu_enabled(vcpu->kvm)) {
-		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu);
+		if (kvm_gfn_shared_mask(vcpu->kvm) &&
+		    !VALID_PAGE(mmu->private_root_hpa)) {
+			root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu, true);
+			mmu->private_root_hpa = root;
+		}
+		root = kvm_tdp_mmu_get_vcpu_root_hpa(vcpu, false);
 		mmu->root.hpa = root;
 	} else if (shadow_root_level >= PT64_ROOT_4LEVEL) {
 		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level);
@@ -4319,7 +4324,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	unsigned long mmu_seq;
 	int r;
 
-	fault->gfn = fault->addr >> PAGE_SHIFT;
+	fault->gfn = gpa_to_gfn(fault->addr) & ~kvm_gfn_shared_mask(vcpu->kvm);
 	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
 
 	if (page_fault_handle_page_track(vcpu, fault))
@@ -5859,6 +5864,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 
 	mmu->root.hpa = INVALID_PAGE;
 	mmu->root.pgd = 0;
+	mmu->private_root_hpa = INVALID_PAGE;
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 		mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
 
@@ -6082,7 +6088,7 @@ static void kvm_mmu_zap_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 		};
 
 		/*
-		 * this handles both private gfn and shared gfn.
+		 * This handles both private gfn and shared gfn.
 		 * All private page should be zapped on memslot deletion.
 		 */
 		flush = kvm_tdp_mmu_unmap_gfn_range(kvm, &range, flush, true);
@@ -6882,6 +6888,9 @@ int kvm_mmu_vendor_module_init(void)
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu)
 {
 	kvm_mmu_unload(vcpu);
+	if (is_tdp_mmu_enabled(vcpu->kvm))
+		mmu_free_root_page(vcpu->kvm, &vcpu->arch.mmu->private_root_hpa,
+				NULL);
 	free_mmu_pages(&vcpu->arch.root_mmu);
 	free_mmu_pages(&vcpu->arch.guest_mmu);
 	mmu_free_memory_caches(vcpu);
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index fb867270829e..e98f32b8eec2 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -6,6 +6,8 @@
 #include <linux/kvm_host.h>
 #include <asm/kvm_host.h>
 
+#include "mmu.h"
+
 #undef MMU_DEBUG
 
 #ifdef MMU_DEBUG
@@ -209,11 +211,29 @@ static inline void kvm_mmu_alloc_private_spt(struct kvm_vcpu *vcpu,
 	}
 }
 
+static inline int kvm_alloc_private_spt_for_split(struct kvm_mmu_page *sp, gfp_t gfp)
+{
+	gfp &= ~__GFP_ZERO;
+	sp->private_spt = (void *)__get_free_page(gfp);
+	if (!sp->private_spt)
+		return -ENOMEM;
+	return 0;
+}
+
 static inline void kvm_mmu_free_private_spt(struct kvm_mmu_page *sp)
 {
 	if (sp->private_spt)
 		free_page((unsigned long)sp->private_spt);
 }
+
+static inline gfn_t kvm_gfn_for_root(struct kvm *kvm, struct kvm_mmu_page *root,
+				     gfn_t gfn)
+{
+	if (is_private_sp(root))
+		return kvm_gfn_private(kvm, gfn);
+	else
+		return kvm_gfn_shared(kvm, gfn);
+}
 #else
 static inline void *kvm_mmu_private_spt(struct kvm_mmu_page *sp)
 {
@@ -230,9 +250,20 @@ static inline void kvm_mmu_alloc_private_spt(struct kvm_vcpu *vcpu,
 {
 }
 
+static inline int kvm_alloc_private_spt_for_split(struct kvm_mmu_page *sp, gfp_t gfp)
+{
+	return -ENOMEM;
+}
+
 static inline void kvm_mmu_free_private_spt(struct kvm_mmu_page *sp)
 {
 }
+
+static inline gfn_t kvm_gfn_for_root(struct kvm *kvm, struct kvm_mmu_page *root,
+				     gfn_t gfn)
+{
+	return gfn;
+}
 #endif
 
 bool kvm_mem_attr_is_mixed(struct kvm_memory_slot *slot, gfn_t gfn, int level);
@@ -369,6 +400,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		.is_tdp = likely(vcpu->arch.mmu->page_fault == kvm_tdp_page_fault),
 		.nx_huge_page_workaround_enabled =
 			is_nx_huge_page_enabled(vcpu->kvm),
+		.is_private = kvm_is_private_gpa(vcpu->kvm, cr2_or_gpa),
 
 		.max_level = vcpu->kvm->arch.tdp_max_page_level,
 		.req_level = PG_LEVEL_4K,
diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index 9e56a5b1024c..eab62baf8549 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -71,7 +71,7 @@ struct tdp_iter {
 	tdp_ptep_t pt_path[PT64_ROOT_MAX_LEVEL];
 	/* A pointer to the current SPTE */
 	tdp_ptep_t sptep;
-	/* The lowest GFN mapped by the current SPTE */
+	/* The lowest GFN (shared bits included) mapped by the current SPTE */
 	gfn_t gfn;
 	/* The level of the root page given to the iterator */
 	int root_level;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 542643b43162..3c89f0aa776c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -285,6 +285,9 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu,
 	sp->spt = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);
 	sp->role = role;
 
+	if (kvm_mmu_page_role_is_private(role))
+		kvm_mmu_alloc_private_spt(vcpu, NULL, sp);
+
 	return sp;
 }
 
@@ -305,7 +308,8 @@ static void tdp_mmu_init_sp(struct kvm_mmu_page *sp, tdp_ptep_t sptep,
 	trace_kvm_mmu_get_page(sp, true);
 }
 
-hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
+static struct kvm_mmu_page *kvm_tdp_mmu_get_vcpu_root(struct kvm_vcpu *vcpu,
+						      bool private)
 {
 	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
 	struct kvm *kvm = vcpu->kvm;
@@ -317,6 +321,8 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	 * Check for an existing root before allocating a new one.  Note, the
 	 * role check prevents consuming an invalid root.
 	 */
+	if (private)
+		kvm_mmu_page_role_set_private(&role);
 	for_each_tdp_mmu_root(kvm, root, kvm_mmu_role_as_id(role)) {
 		if (root->role.word == role.word &&
 		    kvm_tdp_mmu_get_root(root))
@@ -333,12 +339,17 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
 
 out:
-	return __pa(root->spt);
+	return root;
+}
+
+hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu, bool private)
+{
+	return __pa(kvm_tdp_mmu_get_vcpu_root(vcpu, private)->spt);
 }
 
 static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				u64 old_spte, u64 new_spte, int level,
-				bool shared);
+				u64 old_spte, u64 new_spte,
+				union kvm_mmu_page_role role, bool shared);
 
 static void handle_changed_spte_acc_track(u64 old_spte, u64 new_spte, int level)
 {
@@ -364,6 +375,8 @@ static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
 
 	if ((!is_writable_pte(old_spte) || pfn_changed) &&
 	    is_writable_pte(new_spte)) {
+		/* For memory slot operations, use GFN without aliasing */
+		gfn = gfn & ~kvm_gfn_shared_mask(kvm);
 		slot = __gfn_to_memslot(__kvm_memslots(kvm, as_id), gfn);
 		mark_page_dirty_in_slot(kvm, slot, gfn);
 	}
@@ -488,12 +501,76 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 							  REMOVED_SPTE, level);
 		}
 		handle_changed_spte(kvm, kvm_mmu_page_as_id(sp), gfn,
-				    old_spte, REMOVED_SPTE, level, shared);
+				    old_spte, REMOVED_SPTE, sp->role, shared);
+	}
+
+	if (is_private_sp(sp) &&
+	    WARN_ON(static_call(kvm_x86_free_private_spt)(kvm, sp->gfn, sp->role.level,
+							  kvm_mmu_private_spt(sp)))) {
+		/*
+		 * Failed to unlink Secure EPT page and there is nothing to do
+		 * further.  Intentionally leak the page to prevent the kernel
+		 * from accessing the encrypted page.
+		 */
+		kvm_mmu_init_private_spt(sp, NULL);
 	}
 
 	call_rcu(&sp->rcu_head, tdp_mmu_free_sp_rcu_callback);
 }
 
+static void *get_private_spt(gfn_t gfn, u64 new_spte, int level)
+{
+	if (is_shadow_present_pte(new_spte) && !is_last_spte(new_spte, level)) {
+		struct kvm_mmu_page *sp = to_shadow_page(pfn_to_hpa(spte_to_pfn(new_spte)));
+		void *private_spt = kvm_mmu_private_spt(sp);
+
+		WARN_ON_ONCE(!private_spt);
+		WARN_ON_ONCE(sp->role.level + 1 != level);
+		WARN_ON_ONCE(sp->gfn != gfn);
+		return private_spt;
+	}
+
+	return NULL;
+}
+
+static void handle_changed_private_spte(struct kvm *kvm, gfn_t gfn,
+					u64 old_spte, u64 new_spte,
+					int level)
+{
+	bool was_present = is_shadow_present_pte(old_spte);
+	bool is_present = is_shadow_present_pte(new_spte);
+	bool was_leaf = was_present && is_last_spte(old_spte, level);
+	bool is_leaf = is_present && is_last_spte(new_spte, level);
+	kvm_pfn_t old_pfn = spte_to_pfn(old_spte);
+	kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
+
+	lockdep_assert_held(&kvm->mmu_lock);
+	if (is_present) {
+		/* TDP MMU doesn't change present -> present */
+		KVM_BUG_ON(was_present, kvm);
+
+		/*
+		 * Use different call to either set up middle level
+		 * private page table, or leaf.
+		 */
+		if (is_leaf)
+			static_call(kvm_x86_set_private_spte)(kvm, gfn, level, new_pfn);
+		else {
+			void *private_spt = get_private_spt(gfn, new_spte, level);
+
+			KVM_BUG_ON(!private_spt, kvm);
+			if (static_call(kvm_x86_link_private_spt)(kvm, gfn, level, private_spt))
+				/* failed to update Secure-EPT.  */
+				WARN_ON(1);
+		}
+	} else if (was_leaf) {
+		/* non-present -> non-present doesn't make sense. */
+		KVM_BUG_ON(!was_present, kvm);
+		static_call(kvm_x86_zap_private_spte)(kvm, gfn, level);
+		static_call(kvm_x86_remove_private_spte)(kvm, gfn, level, old_pfn);
+	}
+}
+
 /**
  * __handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
@@ -501,7 +578,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  * @gfn: the base GFN that was mapped by the SPTE
  * @old_spte: The value of the SPTE before the change
  * @new_spte: The value of the SPTE after the change
- * @level: the level of the PT the SPTE is part of in the paging structure
+ * @role: the role of the PT the SPTE is part of in the paging structure
  * @shared: This operation may not be running under the exclusive use of
  *	    the MMU lock and the operation must synchronize with other
  *	    threads that might be modifying SPTEs.
@@ -510,14 +587,18 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  * This function must be called for all TDP SPTE modifications.
  */
 static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				  u64 old_spte, u64 new_spte, int level,
-				  bool shared)
+				  u64 old_spte, u64 new_spte,
+				  union kvm_mmu_page_role role, bool shared)
 {
+	bool is_private = kvm_mmu_page_role_is_private(role);
+	int level = role.level;
 	bool was_present = is_shadow_present_pte(old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
 	bool was_leaf = was_present && is_last_spte(old_spte, level);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
-	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
+	kvm_pfn_t old_pfn = spte_to_pfn(old_spte);
+	kvm_pfn_t new_pfn = spte_to_pfn(new_spte);
+	bool pfn_changed = old_pfn != new_pfn;
 
 	WARN_ON(level > PT64_ROOT_MAX_LEVEL);
 	WARN_ON(level < PG_LEVEL_4K);
@@ -584,7 +665,7 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 
 	if (was_leaf && is_dirty_spte(old_spte) &&
 	    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
-		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
+		kvm_set_pfn_dirty(old_pfn);
 
 	/*
 	 * Recursively handle child PTs if the change removed a subtree from
@@ -593,19 +674,36 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	 * pages are kernel allocations and should never be migrated.
 	 */
 	if (was_present && !was_leaf &&
-	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed))) {
+		KVM_BUG_ON(is_private != is_private_sptep(spte_to_child_pt(old_spte, level)),
+			   kvm);
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
+	}
+
+	/*
+	 * Special handling for the private mapping.  We are either
+	 * setting up new mapping at middle level page table, or leaf,
+	 * or tearing down existing mapping.
+	 *
+	 * This is after handling lower page table by above
+	 * handle_remove_tdp_mmu_page().  Secure-EPT requires to remove
+	 * Secure-EPT tables after removing children.
+	 */
+	if (is_private &&
+	    /* Ignore change of software only bits. e.g. host_writable */
+	    (was_leaf != is_leaf || was_present != is_present || pfn_changed)) {
+		handle_changed_private_spte(kvm, gfn, old_spte, new_spte, role.level);
+	}
 }
 
 static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				u64 old_spte, u64 new_spte, int level,
-				bool shared)
+				u64 old_spte, u64 new_spte,
+				union kvm_mmu_page_role role, bool shared)
 {
-	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level,
-			      shared);
-	handle_changed_spte_acc_track(old_spte, new_spte, level);
+	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, role, shared);
+	handle_changed_spte_acc_track(old_spte, new_spte, role.level);
 	handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
-				      new_spte, level);
+				      new_spte, role.level);
 }
 
 /*
@@ -629,6 +727,24 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
 					  struct tdp_iter *iter,
 					  u64 new_spte)
 {
+	/*
+	 * For conventional page table, the update flow is
+	 * - update STPE with atomic operation
+	 * - handle changed SPTE. __handle_changed_spte()
+	 * NOTE: __handle_changed_spte() (and functions) must be safe against
+	 * concurrent update.  It is an exception to zap SPTE.  See
+	 * tdp_mmu_zap_spte_atomic().
+	 *
+	 * For private page table, callbacks are needed to propagate SPTE
+	 * change into the protected page table.  In order to atomically update
+	 * both the SPTE and the protected page tables with callbacks, utilize
+	 * freezing SPTE.
+	 * - Freeze the SPTE. Set entry to REMOVED_SPTE.
+	 * - Trigger callbacks for protected page tables. __handle_changed_spte()
+	 * - Unfreeze the SPTE.  Set the entry to new_spte.
+	 */
+	bool freeze_spte = is_private_sptep(iter->sptep) && !is_removed_spte(new_spte);
+	u64 tmp_spte = freeze_spte ? REMOVED_SPTE : new_spte;
 	u64 *sptep = rcu_dereference(iter->sptep);
 
 	/*
@@ -645,13 +761,16 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	 * Note, fast_pf_fix_direct_spte() can also modify TDP MMU SPTEs and
 	 * does not hold the mmu_lock.
 	 */
-	if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
+	if (!try_cmpxchg64(sptep, &iter->old_spte, tmp_spte))
 		return -EBUSY;
 
 	__handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
-			      new_spte, iter->level, true);
+			      new_spte, sptep_to_sp(sptep)->role, true);
 	handle_changed_spte_acc_track(iter->old_spte, new_spte, iter->level);
 
+	if (freeze_spte)
+		__kvm_tdp_mmu_write_spte(sptep, new_spte);
+
 	return 0;
 }
 
@@ -718,9 +837,11 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
  * SPTE had voldatile bits.
  */
 static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
-			      u64 old_spte, u64 new_spte, gfn_t gfn, int level,
-			      bool record_acc_track, bool record_dirty_log)
+			       u64 old_spte, u64 new_spte, gfn_t gfn, int level,
+			       bool record_acc_track, bool record_dirty_log)
 {
+	union kvm_mmu_page_role role;
+
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
 	/*
@@ -734,7 +855,9 @@ static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
-	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
+	role = sptep_to_sp(sptep)->role;
+	role.level = level;
+	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, role, false);
 
 	if (record_acc_track)
 		handle_changed_spte_acc_track(old_spte, new_spte, level);
@@ -786,8 +909,11 @@ static inline void tdp_mmu_set_spte_no_dirty_log(struct kvm *kvm,
 			continue;					\
 		else
 
-#define tdp_mmu_for_each_pte(_iter, _mmu, _start, _end)		\
-	for_each_tdp_pte(_iter, to_shadow_page(_mmu->root.hpa), _start, _end)
+#define tdp_mmu_for_each_pte(_iter, _mmu, _private, _start, _end)	\
+	for_each_tdp_pte(_iter,						\
+		 to_shadow_page((_private) ? _mmu->private_root_hpa :	\
+				_mmu->root.hpa),			\
+		_start, _end)
 
 /*
  * Yield if the MMU lock is contended or this thread needs to return control
@@ -950,6 +1076,14 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
 	if (!zap_private && is_private_sp(root))
 		return false;
 
+	/*
+	 * start and end doesn't have GFN shared bit.  This function zaps
+	 * a region including alias.  Adjust shared bit of [start, end) if the
+	 * root is shared.
+	 */
+	start = kvm_gfn_for_root(kvm, root, start);
+	end = kvm_gfn_for_root(kvm, root, end);
+
 	rcu_read_lock();
 
 	for_each_tdp_pte_min_level(iter, root, PG_LEVEL_4K, start, end) {
@@ -1078,10 +1212,19 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	WARN_ON(sp->role.level != fault->goal_level);
 	if (unlikely(!fault->slot))
 		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
-	else
-		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
-					 fault->pfn, iter->old_spte, fault->prefetch, true,
-					 fault->map_writable, &new_spte);
+	else {
+		unsigned long pte_access = ACC_ALL;
+		gfn_t gfn_unalias = iter->gfn & ~kvm_gfn_shared_mask(vcpu->kvm);
+
+		/* TDX shared GPAs are no executable, enforce this for the SDV. */
+		if (kvm_gfn_shared_mask(vcpu->kvm) && !fault->is_private)
+			pte_access &= ~ACC_EXEC_MASK;
+
+		wrprot = make_spte(vcpu, sp, fault->slot, pte_access,
+				   gfn_unalias, fault->pfn, iter->old_spte,
+				   fault->prefetch, true, fault->map_writable,
+				   &new_spte);
+	}
 
 	if (new_spte == iter->old_spte)
 		ret = RET_PF_SPURIOUS;
@@ -1180,6 +1323,8 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 	struct tdp_iter iter;
+	gfn_t raw_gfn;
+	bool is_private = fault->is_private;
 	int ret;
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
@@ -1188,7 +1333,17 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 
 	rcu_read_lock();
 
-	tdp_mmu_for_each_pte(iter, mmu, fault->gfn, fault->gfn + 1) {
+	raw_gfn = gpa_to_gfn(fault->addr);
+
+	if (is_error_noslot_pfn(fault->pfn) ||
+	    !kvm_pfn_to_refcounted_page(fault->pfn)) {
+		if (is_private) {
+			rcu_read_unlock();
+			return -EFAULT;
+		}
+	}
+
+	tdp_mmu_for_each_pte(iter, mmu, is_private, raw_gfn, raw_gfn + 1) {
 		if (fault->nx_huge_page_workaround_enabled)
 			disallowed_hugepage_adjust(fault, iter.old_spte, iter.level);
 
@@ -1204,6 +1359,12 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		    is_large_pte(iter.old_spte)) {
 			if (tdp_mmu_zap_spte_atomic(vcpu->kvm, &iter))
 				break;
+			/*
+			 * TODO: large page support.
+			 * Doesn't support large page for TDX now
+			 */
+			KVM_BUG_ON(is_private_sptep(iter.sptep), vcpu->kvm);
+
 
 			/*
 			 * The iter must explicitly re-read the spte here
@@ -1446,6 +1607,12 @@ static struct kvm_mmu_page *__tdp_mmu_alloc_sp_for_split(gfp_t gfp, union kvm_mm
 
 	sp->role = role;
 	sp->spt = (void *)__get_free_page(gfp);
+	if (kvm_mmu_page_role_is_private(role)) {
+		if (kvm_alloc_private_spt_for_split(sp, gfp)) {
+			free_page((unsigned long)sp->spt);
+			sp->spt = NULL;
+		}
+	}
 	if (!sp->spt) {
 		kmem_cache_free(mmu_page_header_cache, sp);
 		return NULL;
@@ -1461,6 +1628,11 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp_for_split(struct kvm *kvm,
 	union kvm_mmu_page_role role = tdp_iter_child_role(iter);
 	struct kvm_mmu_page *sp;
 
+	KVM_BUG_ON(kvm_mmu_page_role_is_private(role) !=
+		   is_private_sptep(iter->sptep), kvm);
+	/* TODO: Large page isn't supported for private SPTE yet. */
+	KVM_BUG_ON(kvm_mmu_page_role_is_private(role), kvm);
+
 	/*
 	 * Since we are allocating while under the MMU lock we have to be
 	 * careful about GFP flags. Use GFP_NOWAIT to avoid blocking on direct
@@ -1895,7 +2067,7 @@ int kvm_tdp_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 	if (WARN_ON_ONCE(kvm_gfn_shared_mask(vcpu->kvm)))
 		return leaf;
 
-	tdp_mmu_for_each_pte(iter, mmu, gfn, gfn + 1) {
+	tdp_mmu_for_each_pte(iter, mmu, false, gfn, gfn + 1) {
 		leaf = iter.level;
 		sptes[leaf] = iter.old_spte;
 	}
@@ -1922,7 +2094,10 @@ u64 *kvm_tdp_mmu_fast_pf_get_last_sptep(struct kvm_vcpu *vcpu, u64 addr,
 	gfn_t gfn = addr >> PAGE_SHIFT;
 	tdp_ptep_t sptep = NULL;
 
-	tdp_mmu_for_each_pte(iter, mmu, gfn, gfn + 1) {
+	/* fast page fault for private GPA isn't supported. */
+	WARN_ON_ONCE(kvm_is_private_gpa(vcpu->kvm, addr));
+
+	tdp_mmu_for_each_pte(iter, mmu, false, gfn, gfn + 1) {
 		*spte = iter.old_spte;
 		sptep = iter.sptep;
 	}
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index c98c7df449a8..695175c921a5 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -5,7 +5,7 @@
 
 #include <linux/kvm_host.h>
 
-hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu);
+hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu, bool private);
 
 __must_check static inline bool kvm_tdp_mmu_get_root(struct kvm_mmu_page *root)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5d0e8fbca345..263885cd97c1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -209,6 +209,7 @@ struct page *kvm_pfn_to_refcounted_page(kvm_pfn_t pfn)
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(kvm_pfn_to_refcounted_page);
 
 /*
  * Switches to specified vcpu, until a matching vcpu_put()
-- 
2.25.1

