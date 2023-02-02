Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4686D688688
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjBBSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbjBBS34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:29:56 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2111054542
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:29:00 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x9-20020aa79409000000b00593a1f7c3d8so1367486pfo.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1L53IKzbh0q2dj44QZHCfw/umfVO+10rbiNwcUgEhA=;
        b=W1S45eT23c0+qcokTUS8aeHe9NQ0UJlsA8P8amVpYEG5na6e9bWDZkdSemeWjy5s4c
         Q3x5YQdMqMG9sOw+jpBa0BuqS4vl1h5JFeEVTcscL7zQrdvi83yZU0mdweM3jK3Sybnc
         7bn1PGgFgtR7pQQ5yibMzVq38fz84GEMPIbRGY42hhwRwHkWdDXvI0LsCl1A+21U3dmT
         WbDhSnwzRmI8cVTzq19EpBrUIsXhdGHet3yG0DbiFyYYBZBQ9da39DANL1F2QxLZPpSf
         ifC9/mJFXwbWze15ZHLVPt1tb78Ksk9gqibxUCSuCLGD6JNE63FFu/w3e6I50lLnfMMG
         XbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1L53IKzbh0q2dj44QZHCfw/umfVO+10rbiNwcUgEhA=;
        b=Ztr/pWU97xUxBqlnI+awqDefRfeepK84LNIMZ27b81hRqxnborw5O/U2BsITpL7kSf
         fZGYJrtkUQxtap88ReD1hrZEs0RJTjsvmEjvsvBeRWsr7mCslgzqafbEPFZhbk9BO4Ca
         8BG/LK+4wqqJB6HUsb6UvMmEp4rbYbefr6bwEN9RWM3EZk9PYv6g36VsdN/S1fuBOLep
         /Z4gmhn3Lpg65w7Ri3ue8TlzNLgoAqNjEHh9Gg2udAxBvR4pCVZ9rZUgzXw5oQb9ex1/
         O+B/l/LxZ9yskht+GtDtaIOsP4PJizSmqGA4cjeSqN5BvxjHHIOUzDDJzOaV4qeeOVfV
         dDqA==
X-Gm-Message-State: AO0yUKXtJwbcTD2myOGkRC0KBeRfwTmCrSudJ+w/9HgrAm9+eZmeOhCp
        HcnxOq4yahlMNVh6InbroKNF6xaxqptZFwj0bGNzslnU+5tOyK9zf72qr3Gz/rK94Sf+s8zbQyn
        Uh7Cydmd4eqlf+5UQmOGRWfMD1zBHqxNj6b1Xfny3tpW9dqRExeqkBucG8zGqvEBl7QM7BWRS
X-Google-Smtp-Source: AK7set916/u3394HNJvodluH3daOOWYNeMl7oGeiAXyr4Do5NV8pOu3l5Ipq+/7T7xIqeoOJN2Xu+tfXg3kb
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a62:1a57:0:b0:593:bac2:b49 with SMTP id
 a84-20020a621a57000000b00593bac20b49mr1825572pfa.44.1675362524733; Thu, 02
 Feb 2023 10:28:44 -0800 (PST)
Date:   Thu,  2 Feb 2023 18:28:08 +0000
In-Reply-To: <20230202182809.1929122-1-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Message-ID: <20230202182809.1929122-21-bgardon@google.com>
Subject: [PATCH 20/21] KVM: x86/mmu: Move Shadow MMU init/teardown to shadow_mmu.c
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Ben Gardon <bgardon@google.com>
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

Move the meat of kvm_mmu_init_vm() and kvm_mmu_uninit_vm() pertaining to
the Shadow MMU to shadow_mmu.c.

Suggested-by: David Matlack <dmatlack@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 41 +++---------------------------
 arch/x86/kvm/mmu/mmu_internal.h |  2 ++
 arch/x86/kvm/mmu/shadow_mmu.c   | 44 +++++++++++++++++++++++++++++++--
 arch/x86/kvm/mmu/shadow_mmu.h   |  6 ++---
 4 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 63b928bded9d1..10aff23dea75d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2743,7 +2743,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
  * not use any resource of the being-deleted slot or all slots
  * after calling the function.
  */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+void kvm_mmu_zap_all_fast(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
 
@@ -2795,22 +2795,13 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm);
 }
 
-static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
-			struct kvm_memory_slot *slot,
-			struct kvm_page_track_notifier_node *node)
-{
-	kvm_mmu_zap_all_fast(kvm);
-}
-
 int kvm_mmu_init_vm(struct kvm *kvm)
 {
-	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
 	int r;
 
-	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
-	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
-	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
+
+	kvm_mmu_init_shadow_mmu(kvm);
 
 	if (tdp_mmu_enabled) {
 		r = kvm_mmu_init_tdp_mmu(kvm);
@@ -2818,38 +2809,14 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 			return r;
 	}
 
-	node->track_write = kvm_shadow_mmu_pte_write;
-	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
-	kvm_page_track_register_notifier(kvm, node);
-
-	kvm->arch.split_page_header_cache.kmem_cache = mmu_page_header_cache;
-	kvm->arch.split_page_header_cache.gfp_zero = __GFP_ZERO;
-
-	kvm->arch.split_shadow_page_cache.gfp_zero = __GFP_ZERO;
-
-	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
-	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
-
 	return 0;
 }
 
-static void mmu_free_vm_memory_caches(struct kvm *kvm)
-{
-	kvm_mmu_free_memory_cache(&kvm->arch.split_desc_cache);
-	kvm_mmu_free_memory_cache(&kvm->arch.split_page_header_cache);
-	kvm_mmu_free_memory_cache(&kvm->arch.split_shadow_page_cache);
-}
-
 void kvm_mmu_uninit_vm(struct kvm *kvm)
 {
-	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
-
-	kvm_page_track_unregister_notifier(kvm, node);
-
+	kvm_mmu_uninit_shadow_mmu(kvm);
 	if (tdp_mmu_enabled)
 		kvm_mmu_uninit_tdp_mmu(kvm);
-
-	mmu_free_vm_memory_caches(kvm);
 }
 
 /*
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 2273c6263faf0..c49d302b037ec 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -406,4 +406,6 @@ BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, pke);
 BUILD_MMU_ROLE_ACCESSOR(ext,  cr4, la57);
 BUILD_MMU_ROLE_ACCESSOR(base, efer, nx);
 BUILD_MMU_ROLE_ACCESSOR(ext,  efer, lma);
+
+void kvm_mmu_zap_all_fast(struct kvm *kvm);
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index c6d3da795992e..6449ac4de4883 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -3013,8 +3013,9 @@ static u64 *get_written_sptes(struct kvm_mmu_page *sp, gpa_t gpa, int *nspte)
 	return spte;
 }
 
-void kvm_shadow_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
-			      int bytes, struct kvm_page_track_notifier_node *node)
+static void kvm_shadow_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
+				     const u8 *new, int bytes,
+				     struct kvm_page_track_notifier_node *node)
 {
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct kvm_mmu_page *sp;
@@ -3623,3 +3624,42 @@ void kvm_shadow_mmu_zap_all(struct kvm *kvm)
 
 	kvm_shadow_mmu_commit_zap_page(kvm, &invalid_list);
 }
+
+static void kvm_shadow_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
+			struct kvm_memory_slot *slot,
+			struct kvm_page_track_notifier_node *node)
+{
+	kvm_mmu_zap_all_fast(kvm);
+}
+
+void kvm_mmu_init_shadow_mmu(struct kvm *kvm)
+{
+	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
+
+	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
+	INIT_LIST_HEAD(&kvm->arch.zapped_obsolete_pages);
+	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
+
+	node->track_write = kvm_shadow_mmu_pte_write;
+	node->track_flush_slot = kvm_shadow_mmu_invalidate_zap_pages_in_memslot;
+	kvm_page_track_register_notifier(kvm, node);
+
+	kvm->arch.split_page_header_cache.kmem_cache = mmu_page_header_cache;
+	kvm->arch.split_page_header_cache.gfp_zero = __GFP_ZERO;
+
+	kvm->arch.split_shadow_page_cache.gfp_zero = __GFP_ZERO;
+
+	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
+	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
+}
+
+void kvm_mmu_uninit_shadow_mmu(struct kvm *kvm)
+{
+	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
+
+	kvm_page_track_unregister_notifier(kvm, node);
+
+	kvm_mmu_free_memory_cache(&kvm->arch.split_desc_cache);
+	kvm_mmu_free_memory_cache(&kvm->arch.split_page_header_cache);
+	kvm_mmu_free_memory_cache(&kvm->arch.split_shadow_page_cache);
+}
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index ab01636373bda..f2e54355ebb19 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -65,9 +65,6 @@ int kvm_shadow_mmu_alloc_special_roots(struct kvm_vcpu *vcpu);
 int kvm_shadow_mmu_get_walk(struct kvm_vcpu *vcpu, u64 addr, u64 *sptes,
 			    int *root_level);
 
-void kvm_shadow_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
-			      int bytes, struct kvm_page_track_notifier_node *node);
-
 void kvm_shadow_mmu_zap_obsolete_pages(struct kvm *kvm);
 bool kvm_shadow_mmu_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end);
 
@@ -103,6 +100,9 @@ bool kvm_shadow_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
 
 void kvm_shadow_mmu_zap_all(struct kvm *kvm);
 
+void kvm_mmu_init_shadow_mmu(struct kvm *kvm);
+void kvm_mmu_uninit_shadow_mmu(struct kvm *kvm);
+
 /* Exports from paging_tmpl.h */
 gpa_t paging32_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			  gpa_t vaddr, u64 access,
-- 
2.39.1.519.gcb327c4b5f-goog

