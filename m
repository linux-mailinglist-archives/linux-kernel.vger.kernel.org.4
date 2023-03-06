Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2646AD1ED
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjCFWnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjCFWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:42:49 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF18286DDA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:42:17 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id m9-20020a17090a7f8900b0023769205928so7063446pjl.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6vNzM0GO5MbtnDqLqku67MPZbUcarzFcKpTc3q9nP3k=;
        b=gazM+TYEEbP14W+rWRFTwfUrHyN3KdQf76sB5eH96SwCJUfaR6rpxh8xN+WanYYVzF
         QBZLrpT4BSTNPefyyG4FPpaD7f79PmPGnD6/az01XAnLI2irX1Ygk7x4FjdbcR47ltI8
         3S4ScXjzy7/oo/VV+42a0ZFlbEIXdD0vA+eR8nbC1IkTPxJkfrj4/7xDVwjG32OXY1lb
         sOD+UhczN6cARoP51qOo89jeac+Oj5ykbaYZMttd8P4ADc9KG2JizR3WkTNQtYjmDzAn
         RiX7UM/yTffI3ZfCP0ekk4ug+KVybUSSaucVFneuKSZsWPQGeOC3eaia9hWC5MzitqYz
         IvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vNzM0GO5MbtnDqLqku67MPZbUcarzFcKpTc3q9nP3k=;
        b=FFumZAtTs2mXlU94fNlTStX+u2TSmg04k/KmILdRAQAFRELbnUhAD5TqhTwYQXsANg
         oSbWEHAGq3MsehZ7hDQIOa3CuxNA6Blu1uxX8nK3aJbFiHGaQOPOgO8zkmr0L3s0yLgd
         yGD0K5d1T8B0tuVXMXEi+6dK4jidugx71/FEbvUriavPIY7GRrST+id2iOTuQ/eNU2lu
         sl3LmzRYfkpFc3VQwN93VWLuzXyYPveTXZpsUtgSNTW3cSICyFXfqoYO97oP6fcxFuuo
         tYZ6rejyMKuiMPxGI4Eh5lR4L363/ZfDeUATVJvvTYBOyvZ55R/apL0f+/vn2i42/EwH
         rx5w==
X-Gm-Message-State: AO0yUKU8uZn8MBsGF9mRz/FyGn/SBRPK3LidgKzEemm0VrPcYYrRhNRp
        7Y72o0QEBnhLP2TwSHfrbYhTg6dApBOw
X-Google-Smtp-Source: AK7set/eezTIEbASuhG8LhM6PyFQFMMwDXgH1qzjZn8+eIggy+CHhD62jLS147rj2/81GVxpa6dZKyGYL5T3
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:c217:b0:234:b8cb:5133 with SMTP id
 e23-20020a17090ac21700b00234b8cb5133mr4591584pjt.7.1678142522518; Mon, 06 Mar
 2023 14:42:02 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:25 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-17-vipinsh@google.com>
Subject: [Patch v4 16/18] KVM: x86/mmu: Allocate numa aware page tables during
 page fault
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate page tables on the preferred NUMA node via memory cache during
page faults. If memory cache doesn't have a preferred NUMA node (node
value is set to NUMA_NO_NODE) then fallback to the default logic where
pages are selected based on thread's mempolicy. Also, free NUMA aware
page caches, mmu_shadow_page_cache, when memory shrinker is invoked.

Allocate root pages based on the current thread's NUMA node as there is
no way to know which will be the ideal NUMA node in long run.

This commit allocate page tables to be on the same NUMA node as the
physical page pointed by them, even if a vCPU causing page fault is on a
different NUMA node. If memory is not available on the requested NUMA
node then the other nearest NUMA node is selected by default. NUMA aware
page tables can be beneficial in cases where a thread touches lot of far
memory initially and then divide work among multiple threads. VMs
generally take advantage of NUMA architecture for faster memory access
by moving threads to the NUMA node of the memory they are accessing.
This change will help them in accessing pages faster.

Downside of this change is that an experimental workload can be created
where a guest threads are always accessing remote memory and not the one
local to them. This will cause performance to degrade compared to VMs
where numa aware page tables are not enabled. Ideally, these VMs when
using non-uniform memory access machine should generally be taking
advantage of NUMA architecture to improve their performance in the first
place.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/mmu/mmu.c          | 63 ++++++++++++++++++++++++---------
 arch/x86/kvm/mmu/mmu_internal.h | 24 ++++++++++++-
 arch/x86/kvm/mmu/paging_tmpl.h  |  4 +--
 arch/x86/kvm/mmu/tdp_mmu.c      | 14 +++++---
 include/linux/kvm_types.h       |  6 ++++
 virt/kvm/kvm_main.c             |  2 +-
 7 files changed, 88 insertions(+), 27 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 64de083cd6b9..77d3aa368e5e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -787,7 +787,7 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu *walk_mmu;
 
 	struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
-	struct kvm_mmu_memory_cache mmu_shadow_page_cache;
+	struct kvm_mmu_memory_cache mmu_shadow_page_cache[MAX_NUMNODES];
 	struct kvm_mmu_memory_cache mmu_shadowed_info_cache;
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d96afc849ee8..86f0d74d35ed 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -702,7 +702,7 @@ static void mmu_free_sp_memory_cache(struct kvm_mmu_memory_cache *cache)
 
 static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 {
-	int r;
+	int r, nid = KVM_MMU_DEFAULT_CACHE_INDEX;
 
 	/* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
 	r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
@@ -710,7 +710,16 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 	if (r)
 		return r;
 
-	r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache, PT64_ROOT_MAX_LEVEL);
+	if (kvm_numa_aware_page_table_enabled(vcpu->kvm)) {
+		for_each_online_node(nid) {
+			r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid],
+						      PT64_ROOT_MAX_LEVEL);
+		}
+	} else {
+		r = mmu_topup_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid],
+					      PT64_ROOT_MAX_LEVEL);
+	}
+
 	if (r)
 		return r;
 
@@ -726,9 +735,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
+	int nid;
+
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
 	mutex_lock(&vcpu->arch.mmu_shadow_page_cache_lock);
-	mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
+	for_each_node(nid)
+		mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadow_page_cache[nid]);
 	mmu_free_sp_memory_cache(&vcpu->arch.mmu_shadowed_info_cache);
 	mutex_unlock(&vcpu->arch.mmu_shadow_page_cache_lock);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
@@ -2245,12 +2257,12 @@ static struct kvm_mmu_page *__kvm_mmu_get_shadow_page(struct kvm *kvm,
 }
 
 static struct kvm_mmu_page *kvm_mmu_get_shadow_page(struct kvm_vcpu *vcpu,
-						    gfn_t gfn,
+						    gfn_t gfn, int nid,
 						    union kvm_mmu_page_role role)
 {
 	struct shadow_page_caches caches = {
 		.page_header_cache = &vcpu->arch.mmu_page_header_cache,
-		.shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache,
+		.shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache[nid],
 		.shadowed_info_cache = &vcpu->arch.mmu_shadowed_info_cache,
 	};
 
@@ -2305,15 +2317,18 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
 
 static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
-						 bool direct, unsigned int access)
+						 bool direct, unsigned int access,
+						 kvm_pfn_t pfn)
 {
 	union kvm_mmu_page_role role;
+	int nid;
 
 	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep))
 		return ERR_PTR(-EEXIST);
 
 	role = kvm_mmu_child_role(sptep, direct, access);
-	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
+	nid = kvm_pfn_to_mmu_cache_nid(vcpu->kvm, pfn);
+	return kvm_mmu_get_shadow_page(vcpu, gfn, nid, role);
 }
 
 static void shadow_walk_init_using_root(struct kvm_shadow_walk_iterator *iterator,
@@ -3205,7 +3220,8 @@ static int direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		if (it.level == fault->goal_level)
 			break;
 
-		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true, ACC_ALL);
+		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn, true,
+					  ACC_ALL, fault->pfn);
 		if (sp == ERR_PTR(-EEXIST))
 			continue;
 
@@ -3625,6 +3641,7 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 {
 	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
 	struct kvm_mmu_page *sp;
+	int nid;
 
 	role.level = level;
 	role.quadrant = quadrant;
@@ -3632,7 +3649,8 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, int quadrant,
 	WARN_ON_ONCE(quadrant && !role.has_4_byte_gpte);
 	WARN_ON_ONCE(role.direct && role.has_4_byte_gpte);
 
-	sp = kvm_mmu_get_shadow_page(vcpu, gfn, role);
+	nid = kvm_mmu_root_page_cache_nid(vcpu->kvm);
+	sp = kvm_mmu_get_shadow_page(vcpu, gfn, nid, role);
 	++sp->root_count;
 
 	return __pa(sp->spt);
@@ -5959,7 +5977,7 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 
 int kvm_mmu_create(struct kvm_vcpu *vcpu)
 {
-	int ret;
+	int ret, nid;
 
 	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_pte_list_desc_cache);
 	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
@@ -5967,7 +5985,12 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_page_header_cache);
 	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
 
-	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadow_page_cache);
+	for_each_node(nid) {
+		INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadow_page_cache[nid]);
+		if (kvm_numa_aware_page_table_enabled(vcpu->kvm))
+			vcpu->arch.mmu_shadow_page_cache[nid].node = nid;
+	}
+
 	mutex_init(&vcpu->arch.mmu_shadow_page_cache_lock);
 
 	INIT_KVM_MMU_MEMORY_CACHE(&vcpu->arch.mmu_shadowed_info_cache);
@@ -6695,13 +6718,17 @@ void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 }
 
 static int mmu_memory_cache_try_empty(struct kvm_mmu_memory_cache *cache,
-				      struct mutex *cache_lock)
+				      int cache_count, struct mutex *cache_lock)
 {
-	int freed = 0;
+	int freed = 0, nid;
 
 	if (mutex_trylock(cache_lock)) {
-		freed = cache->nobjs;
-		kvm_mmu_empty_memory_cache(cache);
+		for (nid = 0; nid < cache_count; nid++) {
+			if (!cache[nid].nobjs)
+				continue;
+			freed += cache[nid].nobjs;
+			kvm_mmu_empty_memory_cache(&cache[nid]);
+		}
 		mutex_unlock(cache_lock);
 	}
 	return freed;
@@ -6725,15 +6752,17 @@ static unsigned long mmu_shrink_scan(struct shrinker *shrink,
 		list_move_tail(&kvm->vm_list, &vm_list);
 
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			freed += mmu_memory_cache_try_empty(&vcpu->arch.mmu_shadow_page_cache,
+			freed += mmu_memory_cache_try_empty(vcpu->arch.mmu_shadow_page_cache,
+							    MAX_NUMNODES,
 							    &vcpu->arch.mmu_shadow_page_cache_lock);
 			freed += mmu_memory_cache_try_empty(&vcpu->arch.mmu_shadowed_info_cache,
+							    1,
 							    &vcpu->arch.mmu_shadow_page_cache_lock);
 			if (freed >= sc->nr_to_scan)
 				goto out;
 		}
 		freed += mmu_memory_cache_try_empty(&kvm->arch.split_shadow_page_cache,
-						    &kvm->slots_lock);
+						    1, &kvm->slots_lock);
 		if (freed >= sc->nr_to_scan)
 			goto out;
 	}
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index b9d0e09ae974..652fd0c2bcba 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -340,11 +340,16 @@ void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void *mmu_sp_memory_cache_alloc(struct kvm_mmu_memory_cache *cache);
 
+static inline bool kvm_numa_aware_page_table_enabled(struct kvm *kvm)
+{
+	return kvm->arch.numa_aware_page_table;
+}
+
 static inline int kvm_pfn_to_page_table_nid(struct kvm *kvm, kvm_pfn_t pfn)
 {
 	struct page *page;
 
-	if (!kvm->arch.numa_aware_page_table)
+	if (!kvm_numa_aware_page_table_enabled(kvm))
 		return NUMA_NO_NODE;
 
 	page = kvm_pfn_to_refcounted_page(pfn);
@@ -355,4 +360,21 @@ static inline int kvm_pfn_to_page_table_nid(struct kvm *kvm, kvm_pfn_t pfn)
 		return numa_mem_id();
 }
 
+static inline int kvm_pfn_to_mmu_cache_nid(struct kvm *kvm, kvm_pfn_t pfn)
+{
+	int index = kvm_pfn_to_page_table_nid(kvm, pfn);
+
+	if (index == NUMA_NO_NODE)
+		return KVM_MMU_DEFAULT_CACHE_INDEX;
+
+	return index;
+}
+
+static inline int kvm_mmu_root_page_cache_nid(struct kvm *kvm)
+{
+	if (kvm_numa_aware_page_table_enabled(kvm))
+		return numa_mem_id();
+
+	return KVM_MMU_DEFAULT_CACHE_INDEX;
+}
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1dea9be6849d..9db8b3df434d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -652,7 +652,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		table_gfn = gw->table_gfn[it.level - 2];
 		access = gw->pt_access[it.level - 2];
 		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, table_gfn,
-					  false, access);
+					  false, access, fault->pfn);
 
 		if (sp != ERR_PTR(-EEXIST)) {
 			/*
@@ -706,7 +706,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 		validate_direct_spte(vcpu, it.sptep, direct_access);
 
 		sp = kvm_mmu_get_child_sp(vcpu, it.sptep, base_gfn,
-					  true, direct_access);
+					  true, direct_access, fault->pfn);
 		if (sp == ERR_PTR(-EEXIST))
 			continue;
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 61fd9c177694..63113a66f560 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -260,12 +260,12 @@ static struct kvm_mmu_page *tdp_mmu_next_root(struct kvm *kvm,
 		    kvm_mmu_page_as_id(_root) != _as_id) {		\
 		} else
 
-static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu)
+static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu, int nid)
 {
 	struct kvm_mmu_page *sp;
 
 	sp = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_page_header_cache);
-	sp->spt = mmu_sp_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);
+	sp->spt = mmu_sp_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache[nid]);
 
 	return sp;
 }
@@ -304,6 +304,7 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 	union kvm_mmu_page_role role = vcpu->arch.mmu->root_role;
 	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_page *root;
+	int nid;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
@@ -317,7 +318,8 @@ hpa_t kvm_tdp_mmu_get_vcpu_root_hpa(struct kvm_vcpu *vcpu)
 			goto out;
 	}
 
-	root = tdp_mmu_alloc_sp(vcpu);
+	nid = kvm_mmu_root_page_cache_nid(vcpu->kvm);
+	root = tdp_mmu_alloc_sp(vcpu, nid);
 	tdp_mmu_init_sp(root, NULL, 0, role);
 
 	refcount_set(&root->tdp_mmu_root_count, 1);
@@ -1149,12 +1151,14 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 	struct kvm *kvm = vcpu->kvm;
 	struct tdp_iter iter;
 	struct kvm_mmu_page *sp;
-	int ret = RET_PF_RETRY;
+	int ret = RET_PF_RETRY, nid;
 
 	kvm_mmu_hugepage_adjust(vcpu, fault);
 
 	trace_kvm_mmu_spte_requested(fault);
 
+	nid = kvm_pfn_to_mmu_cache_nid(kvm, fault->pfn);
+
 	rcu_read_lock();
 
 	tdp_mmu_for_each_pte(iter, mmu, fault->gfn, fault->gfn + 1) {
@@ -1182,7 +1186,7 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * The SPTE is either non-present or points to a huge page that
 		 * needs to be split.
 		 */
-		sp = tdp_mmu_alloc_sp(vcpu);
+		sp = tdp_mmu_alloc_sp(vcpu, nid);
 		tdp_mmu_init_child_sp(sp, &iter);
 
 		sp->nx_huge_page_disallowed = fault->huge_page_disallowed;
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index b2a405c8e629..13032da2ddfc 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -113,6 +113,12 @@ static inline void INIT_KVM_MMU_MEMORY_CACHE(struct kvm_mmu_memory_cache *cache)
 {
 	*cache = (struct kvm_mmu_memory_cache)KVM_MMU_MEMORY_CACHE_INIT();
 }
+
+/*
+ * When NUMA aware page table option is disabled for a VM then use cache at the
+ * below index in the array of NUMA caches.
+ */
+#define KVM_MMU_DEFAULT_CACHE_INDEX 0
 #endif
 
 #define HALT_POLL_HIST_COUNT			32
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 47006d209309..25a549705c8e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -401,7 +401,7 @@ static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
 	if (mc->kmem_cache)
 		return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
 	else
-		return (void *)__get_free_page(gfp_flags);
+		return kvm_mmu_get_free_page(gfp_flags, mc->node);
 }
 
 int __kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int capacity, int min)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

