Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E643746B24
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGDHwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGDHwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:52:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D44E59
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:51:54 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-53482b44007so2567989a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688457114; x=1691049114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcjFavyo0/8lleZG5RjIznx3IVQVCz54WpJ58XOvGXs=;
        b=Albj4+6v0VCXdDCyTd8S/qVKx1iS7d60NitIJ0zGq2gfsD9uA2yOkIP5HPDno1Vc54
         RZxr0iuzuIjN9YCeD80RHflQRyS9eKuQ5CbNLnh8ssmylhYTPqzQjZjDLhMNRN1S9oKR
         ug2PrGRMxrjzrBqVPcGzauwb2TOmu3BJoESrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457114; x=1691049114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcjFavyo0/8lleZG5RjIznx3IVQVCz54WpJ58XOvGXs=;
        b=E/t/LRuWloIwQLEZCD/Blg5TM8dilpU9EHDSDlOco/9K57pQjZwi1Fc1m73WwH7R9f
         Gpw0V3X56PB3VyrwS4fdaw5NLANxIAxtKhO16HOQZy/IKZDeQoKJN5pySEMrlD6zxrK2
         0TlivkuQlN7apZvkA0nnGky3yoBwX9JYcMupi16TDKBEbumaJers8ql+gTqeNK2tzSbP
         PVBY+FS3UHmalcTYZk5NTXGVgyviQurobVV0qgT0ePawwe5sYFyuhKMLU5t1VkK4mi9d
         CAvpKjZQP7MAN1AzhOfxgrsX3VmgU9MMAjTwTObmSmSMw3/NE0BUevnmUFzdr8KSI9HB
         WYVQ==
X-Gm-Message-State: AC+VfDz2krhq5PFdqTZQpXFueQLUOhWnjYZtWAS/qzhKsK6sEtsY3jHr
        AlpaBILXbM8Aa2DC3pOwQcr0Kg==
X-Google-Smtp-Source: ACHHUZ632/FeJEsRMiAgZp7avQZvnLREpWyjrFpW1jYaEDpRm2AjvUK5tT04q8UY3vwfvST/ZmeMog==
X-Received: by 2002:a05:6a20:9187:b0:10f:f672:6e88 with SMTP id v7-20020a056a20918700b0010ff6726e88mr12748149pzd.4.1688457113771;
        Tue, 04 Jul 2023 00:51:53 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:a11b:bff7:d8ae:bb0])
        by smtp.gmail.com with UTF8SMTPSA id x12-20020a170902820c00b001b3d7205401sm16444812pln.303.2023.07.04.00.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:51:53 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: [PATCH v7 5/8] KVM: x86/mmu: Don't pass FOLL_GET to __kvm_follow_pfn
Date:   Tue,  4 Jul 2023 16:50:50 +0900
Message-ID: <20230704075054.3344915-6-stevensd@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230704075054.3344915-1-stevensd@google.com>
References: <20230704075054.3344915-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Stevens <stevensd@chromium.org>

Stop passing FOLL_GET to __kvm_follow_pfn. This allows the host to map
memory into the guest that is backed by un-refcounted struct pages - for
example, higher order non-compound pages allocated by the amdgpu driver
via ttm_pool_alloc_page.

The bulk of this change is tracking the is_refcounted_page flag so that
non-refcounted pages don't trigger page_count() == 0 warnings. This is
done by storing the flag in an unused bit in the sptes.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 arch/x86/kvm/mmu/mmu.c          | 44 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/mmu_internal.h |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h  |  9 ++++---
 arch/x86/kvm/mmu/spte.c         |  4 ++-
 arch/x86/kvm/mmu/spte.h         | 12 ++++++++-
 arch/x86/kvm/mmu/tdp_mmu.c      | 22 ++++++++++-------
 6 files changed, 62 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e44ab512c3a1..b1607e314497 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -553,12 +553,14 @@ static bool mmu_spte_update(u64 *sptep, u64 new_spte)
 
 	if (is_accessed_spte(old_spte) && !is_accessed_spte(new_spte)) {
 		flush = true;
-		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
+		if (is_refcounted_page_pte(old_spte))
+			kvm_set_page_accessed(pfn_to_page(spte_to_pfn(old_spte)));
 	}
 
 	if (is_dirty_spte(old_spte) && !is_dirty_spte(new_spte)) {
 		flush = true;
-		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
+		if (is_refcounted_page_pte(old_spte))
+			kvm_set_page_dirty(pfn_to_page(spte_to_pfn(old_spte)));
 	}
 
 	return flush;
@@ -596,14 +598,18 @@ static u64 mmu_spte_clear_track_bits(struct kvm *kvm, u64 *sptep)
 	 * before they are reclaimed.  Sanity check that, if the pfn is backed
 	 * by a refcounted page, the refcount is elevated.
 	 */
-	page = kvm_pfn_to_refcounted_page(pfn);
-	WARN_ON(page && !page_count(page));
+	if (is_refcounted_page_pte(old_spte)) {
+		page = kvm_pfn_to_refcounted_page(pfn);
+		WARN_ON(!page || !page_count(page));
+	}
 
-	if (is_accessed_spte(old_spte))
-		kvm_set_pfn_accessed(pfn);
+	if (is_refcounted_page_pte(old_spte)) {
+		if (is_accessed_spte(old_spte))
+			kvm_set_page_accessed(pfn_to_page(pfn));
 
-	if (is_dirty_spte(old_spte))
-		kvm_set_pfn_dirty(pfn);
+		if (is_dirty_spte(old_spte))
+			kvm_set_page_dirty(pfn_to_page(pfn));
+	}
 
 	return old_spte;
 }
@@ -639,8 +645,8 @@ static bool mmu_spte_age(u64 *sptep)
 		 * Capture the dirty status of the page, so that it doesn't get
 		 * lost when the SPTE is marked for access tracking.
 		 */
-		if (is_writable_pte(spte))
-			kvm_set_pfn_dirty(spte_to_pfn(spte));
+		if (is_writable_pte(spte) && is_refcounted_page_pte(spte))
+			kvm_set_page_dirty(pfn_to_page(spte_to_pfn(spte)));
 
 		spte = mark_spte_for_access_track(spte);
 		mmu_spte_update_no_track(sptep, spte);
@@ -1278,8 +1284,8 @@ static bool spte_wrprot_for_clear_dirty(u64 *sptep)
 {
 	bool was_writable = test_and_clear_bit(PT_WRITABLE_SHIFT,
 					       (unsigned long *)sptep);
-	if (was_writable && !spte_ad_enabled(*sptep))
-		kvm_set_pfn_dirty(spte_to_pfn(*sptep));
+	if (was_writable && !spte_ad_enabled(*sptep) && is_refcounted_page_pte(*sptep))
+		kvm_set_page_dirty(pfn_to_page(spte_to_pfn(*sptep)));
 
 	return was_writable;
 }
@@ -2937,6 +2943,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	bool host_writable = !fault || fault->map_writable;
 	bool prefetch = !fault || fault->prefetch;
 	bool write_fault = fault && fault->write;
+	bool is_refcounted = !fault || fault->is_refcounted_page;
 
 	pgprintk("%s: spte %llx write_fault %d gfn %llx\n", __func__,
 		 *sptep, write_fault, gfn);
@@ -2969,7 +2976,7 @@ static int mmu_set_spte(struct kvm_vcpu *vcpu, struct kvm_memory_slot *slot,
 	}
 
 	wrprot = make_spte(vcpu, sp, slot, pte_access, gfn, pfn, *sptep, prefetch,
-			   true, host_writable, &spte);
+			   true, host_writable, is_refcounted, &spte);
 
 	if (*sptep == spte) {
 		ret = RET_PF_SPURIOUS;
@@ -4299,8 +4306,9 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	struct kvm_follow_pfn foll = {
 		.slot = slot,
 		.gfn = fault->gfn,
-		.flags = FOLL_GET | (fault->write ? FOLL_WRITE : 0),
+		.flags = fault->write ? FOLL_WRITE : 0,
 		.allow_write_mapping = true,
+		.guarded_by_mmu_notifier = true,
 	};
 
 	/*
@@ -4317,6 +4325,7 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			fault->slot = NULL;
 			fault->pfn = KVM_PFN_NOSLOT;
 			fault->map_writable = false;
+			fault->is_refcounted_page = false;
 			return RET_PF_CONTINUE;
 		}
 		/*
@@ -4366,6 +4375,7 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 success:
 	fault->hva = foll.hva;
 	fault->map_writable = foll.writable;
+	fault->is_refcounted_page = foll.is_refcounted_page;
 	return RET_PF_CONTINUE;
 }
 
@@ -4451,7 +4461,8 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	if (fault->is_refcounted_page)
+		kvm_set_page_accessed(pfn_to_page(fault->pfn));
 	return r;
 }
 
@@ -4529,7 +4540,8 @@ static int kvm_tdp_mmu_page_fault(struct kvm_vcpu *vcpu,
 
 out_unlock:
 	read_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	if (fault->is_refcounted_page)
+		kvm_set_page_accessed(pfn_to_page(fault->pfn));
 	return r;
 }
 #endif
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index d39af5639ce9..55790085884f 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -240,6 +240,7 @@ struct kvm_page_fault {
 	kvm_pfn_t pfn;
 	hva_t hva;
 	bool map_writable;
+	bool is_refcounted_page;
 
 	/*
 	 * Indicates the guest is trying to write a gfn that contains one or
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 0662e0278e70..3284e7bd9619 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -829,7 +829,8 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 out_unlock:
 	write_unlock(&vcpu->kvm->mmu_lock);
-	kvm_release_pfn_clean(fault->pfn);
+	if (fault->is_refcounted_page)
+		kvm_set_page_accessed(pfn_to_page(fault->pfn));
 	return r;
 }
 
@@ -883,7 +884,7 @@ static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
  */
 static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int i)
 {
-	bool host_writable;
+	bool host_writable, is_refcounted;
 	gpa_t first_pte_gpa;
 	u64 *sptep, spte;
 	struct kvm_memory_slot *slot;
@@ -940,10 +941,12 @@ static int FNAME(sync_spte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp, int
 	sptep = &sp->spt[i];
 	spte = *sptep;
 	host_writable = spte & shadow_host_writable_mask;
+	// TODO: is this correct?
+	is_refcounted = spte & SPTE_MMU_PAGE_REFCOUNTED;
 	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	make_spte(vcpu, sp, slot, pte_access, gfn,
 		  spte_to_pfn(spte), spte, true, false,
-		  host_writable, &spte);
+		  host_writable, is_refcounted, &spte);
 
 	return mmu_spte_update(sptep, spte);
 }
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index cf2c6426a6fc..46c681dc45e6 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -138,7 +138,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       const struct kvm_memory_slot *slot,
 	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
 	       u64 old_spte, bool prefetch, bool can_unsync,
-	       bool host_writable, u64 *new_spte)
+	       bool host_writable, bool is_refcounted, u64 *new_spte)
 {
 	int level = sp->role.level;
 	u64 spte = SPTE_MMU_PRESENT_MASK;
@@ -188,6 +188,8 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 
 	if (level > PG_LEVEL_4K)
 		spte |= PT_PAGE_SIZE_MASK;
+	else if (is_refcounted)
+		spte |= SPTE_MMU_PAGE_REFCOUNTED;
 
 	if (shadow_memtype_mask)
 		spte |= static_call(kvm_x86_get_mt_mask)(vcpu, gfn,
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 1279db2eab44..be93dd061ae3 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -95,6 +95,11 @@ static_assert(!(EPT_SPTE_MMU_WRITABLE & SHADOW_ACC_TRACK_SAVED_MASK));
 /* Defined only to keep the above static asserts readable. */
 #undef SHADOW_ACC_TRACK_SAVED_MASK
 
+/*
+ * Indicates that the SPTE refers to a page with a valid refcount.
+ */
+#define SPTE_MMU_PAGE_REFCOUNTED        BIT_ULL(59)
+
 /*
  * Due to limited space in PTEs, the MMIO generation is a 19 bit subset of
  * the memslots generation and is derived as follows:
@@ -332,6 +337,11 @@ static inline bool is_dirty_spte(u64 spte)
 	return dirty_mask ? spte & dirty_mask : spte & PT_WRITABLE_MASK;
 }
 
+static inline bool is_refcounted_page_pte(u64 spte)
+{
+	return spte & SPTE_MMU_PAGE_REFCOUNTED;
+}
+
 static inline u64 get_rsvd_bits(struct rsvd_bits_validate *rsvd_check, u64 pte,
 				int level)
 {
@@ -462,7 +472,7 @@ bool make_spte(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 	       const struct kvm_memory_slot *slot,
 	       unsigned int pte_access, gfn_t gfn, kvm_pfn_t pfn,
 	       u64 old_spte, bool prefetch, bool can_unsync,
-	       bool host_writable, u64 *new_spte);
+	       bool host_writable, bool is_refcounted, u64 *new_spte);
 u64 make_huge_page_split_spte(struct kvm *kvm, u64 huge_spte,
 		      	      union kvm_mmu_page_role role, int index);
 u64 make_nonleaf_spte(u64 *child_pt, bool ad_disabled);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 512163d52194..a9b1b14d2e26 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -474,6 +474,7 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	bool was_leaf = was_present && is_last_spte(old_spte, level);
 	bool is_leaf = is_present && is_last_spte(new_spte, level);
 	bool pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
+	bool is_refcounted = is_refcounted_page_pte(old_spte);
 
 	WARN_ON(level > PT64_ROOT_MAX_LEVEL);
 	WARN_ON(level < PG_LEVEL_4K);
@@ -538,9 +539,9 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	if (is_leaf != was_leaf)
 		kvm_update_page_stats(kvm, level, is_leaf ? 1 : -1);
 
-	if (was_leaf && is_dirty_spte(old_spte) &&
+	if (was_leaf && is_dirty_spte(old_spte) && is_refcounted &&
 	    (!is_present || !is_dirty_spte(new_spte) || pfn_changed))
-		kvm_set_pfn_dirty(spte_to_pfn(old_spte));
+		kvm_set_page_dirty(pfn_to_page(spte_to_pfn(old_spte)));
 
 	/*
 	 * Recursively handle child PTs if the change removed a subtree from
@@ -552,9 +553,9 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
 
-	if (was_leaf && is_accessed_spte(old_spte) &&
+	if (was_leaf && is_accessed_spte(old_spte) && is_refcounted &&
 	    (!is_present || !is_accessed_spte(new_spte) || pfn_changed))
-		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
+		kvm_set_page_accessed(pfn_to_page(spte_to_pfn(old_spte)));
 }
 
 /*
@@ -988,8 +989,9 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
 	else
 		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
-					 fault->pfn, iter->old_spte, fault->prefetch, true,
-					 fault->map_writable, &new_spte);
+				   fault->pfn, iter->old_spte, fault->prefetch, true,
+				   fault->map_writable, fault->is_refcounted_page,
+				   &new_spte);
 
 	if (new_spte == iter->old_spte)
 		ret = RET_PF_SPURIOUS;
@@ -1205,8 +1207,9 @@ static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
 		 * Capture the dirty status of the page, so that it doesn't get
 		 * lost when the SPTE is marked for access tracking.
 		 */
-		if (is_writable_pte(iter->old_spte))
-			kvm_set_pfn_dirty(spte_to_pfn(iter->old_spte));
+		if (is_writable_pte(iter->old_spte) &&
+		    is_refcounted_page_pte(iter->old_spte))
+			kvm_set_page_dirty(pfn_to_page(spte_to_pfn(iter->old_spte)));
 
 		new_spte = mark_spte_for_access_track(iter->old_spte);
 		iter->old_spte = kvm_tdp_mmu_write_spte(iter->sptep,
@@ -1626,7 +1629,8 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		trace_kvm_tdp_mmu_spte_changed(iter.as_id, iter.gfn, iter.level,
 					       iter.old_spte,
 					       iter.old_spte & ~dbit);
-		kvm_set_pfn_dirty(spte_to_pfn(iter.old_spte));
+		if (is_refcounted_page_pte(iter.old_spte))
+			kvm_set_page_dirty(pfn_to_page(spte_to_pfn(iter.old_spte)));
 	}
 
 	rcu_read_unlock();
-- 
2.41.0.255.g8b1d071c50-goog

