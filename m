Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E6A6C3D60
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCUWBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCUWBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:01:18 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559095614D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q99-20020a17090a1b6c00b0023f0c6c6b3dso5968106pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=G+iGntBtVRJjD4o480g3Ec0CENpb6X11x9JeRvhErT0=;
        b=j1gwEl2XqCykbfMpcCLwM8y8MF47Jdosm/r2/BLi61FTQRxWIMTi1IjHX9YQ9nQAKq
         p/Cle9TrbcWcZS/e26akLlTSXNsz2bY14u7mUg1Yk/vT+oGidLfPprXJN8cUHa97nfle
         5E37kyY+kc6QtIldgnBFO8VDYvAZmfbMLgVKQWZl17opxD3laEOw2KekIjr1k2EUaJNA
         c6d9nzDNWOlr0Hntu0jyxOs4L2czPLAuUWv9y5ElqxGAE2i18JhZ/sveILZVP1d2NcTD
         /rKSD4YbTNjlVViUPHy9KO4dGbXgEgUPh+d7/T6RXhQIC/Ngmq43PQXOQYn6aCFhB0xB
         jwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+iGntBtVRJjD4o480g3Ec0CENpb6X11x9JeRvhErT0=;
        b=opw2asb509DZZzXYDOf3HeG9sQthSmw0svkwGIyRxfregwIJuDWFcN+PgydOWpYO5l
         6dGFJRFJe1TF4Hiz1/kAJN+eBRrFwBPJTw6ci4M8Mzxbb3GtxQZ//pMjUpeLCBJbQSbF
         9qpGYSTZlPdNMva7dln5H2VINq2BnmdFXFAXArlXO801ex3z9oQoU9arO3aXgVlYbXdK
         034XIqFySgdMZrZH7a8g3JIBQALPbwW6nvVAhn4q2jspNNXN2Bm8vs70rI9vTx1zX1Z6
         y6HJnb6v1C6C3lDdXrHG5F3A8aamUwXAKaFyhWvy3GFcQQusb9hb5zKaKwVd8q581Tbw
         n0HA==
X-Gm-Message-State: AO0yUKX3wXffGYc3yFQPdAKa8WyVL2Aau3/s0c4bvhrF+p9mABRGSV95
        nZVtaCF0fwoLy2+fqmRfxslTNVOMdVE=
X-Google-Smtp-Source: AK7set9LH1Y3w0ma4uzI/zS8MJ9A1jvQwicm85z1bRm3olEHtxhvQqi/+Aw125ALJ3uKxOceH+dcr66rHIY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d0c:b0:627:df77:8303 with SMTP id
 fa12-20020a056a002d0c00b00627df778303mr680408pfb.5.1679436046123; Tue, 21 Mar
 2023 15:00:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:21 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-14-seanjc@google.com>
Subject: [PATCH v4 13/13] KVM: x86/mmu: Merge all handle_changed_pte*() functions
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vipin Sharma <vipinsh@google.com>

Merge __handle_changed_pte() and handle_changed_spte_acc_track() into a
single function, handle_changed_pte(), as the two are always used
together.  Remove the existing handle_changed_pte(), as it's just a
wrapper that calls __handle_changed_pte() and
handle_changed_spte_acc_track().

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
[sean: massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 42 +++++++++++---------------------------
 1 file changed, 12 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index e8ee49b6da5b..b2fca11b91ff 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -334,17 +334,6 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				u64 old_spte, u64 new_spte, int level,
 				bool shared);
 
-static void handle_changed_spte_acc_track(u64 old_spte, u64 new_spte, int level)
-{
-	if (!is_shadow_present_pte(old_spte) || !is_last_spte(old_spte, level))
-		return;
-
-	if (is_accessed_spte(old_spte) &&
-	    (!is_shadow_present_pte(new_spte) || !is_accessed_spte(new_spte) ||
-	     spte_to_pfn(old_spte) != spte_to_pfn(new_spte)))
-		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
-}
-
 static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, +1);
@@ -487,7 +476,7 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
 }
 
 /**
- * __handle_changed_spte - handle bookkeeping associated with an SPTE change
+ * handle_changed_spte - handle bookkeeping associated with an SPTE change
  * @kvm: kvm instance
  * @as_id: the address space of the paging structure the SPTE was a part of
  * @gfn: the base GFN that was mapped by the SPTE
@@ -502,9 +491,9 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  * dirty logging updates are handled in common code, not here (see make_spte()
  * and fast_pf_fix_direct_spte()).
  */
-static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				  u64 old_spte, u64 new_spte, int level,
-				  bool shared)
+static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
+				u64 old_spte, u64 new_spte, int level,
+				bool shared)
 {
 	bool was_present = is_shadow_present_pte(old_spte);
 	bool is_present = is_shadow_present_pte(new_spte);
@@ -588,15 +577,10 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	if (was_present && !was_leaf &&
 	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
 		handle_removed_pt(kvm, spte_to_child_pt(old_spte, level), shared);
-}
 
-static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
-				u64 old_spte, u64 new_spte, int level,
-				bool shared)
-{
-	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level,
-			      shared);
-	handle_changed_spte_acc_track(old_spte, new_spte, level);
+	if (was_leaf && is_accessed_spte(old_spte) &&
+	    (!is_present || !is_accessed_spte(new_spte) || pfn_changed))
+		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
 }
 
 /*
@@ -639,9 +623,8 @@ static inline int tdp_mmu_set_spte_atomic(struct kvm *kvm,
 	if (!try_cmpxchg64(sptep, &iter->old_spte, new_spte))
 		return -EBUSY;
 
-	__handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
-			      new_spte, iter->level, true);
-	handle_changed_spte_acc_track(iter->old_spte, new_spte, iter->level);
+	handle_changed_spte(kvm, iter->as_id, iter->gfn, iter->old_spte,
+			    new_spte, iter->level, true);
 
 	return 0;
 }
@@ -705,8 +688,7 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
-	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
-	handle_changed_spte_acc_track(old_spte, new_spte, level);
+	handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
 	return old_spte;
 }
 
@@ -1275,7 +1257,7 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
 	 * Note, when changing a read-only SPTE, it's not strictly necessary to
 	 * zero the SPTE before setting the new PFN, but doing so preserves the
 	 * invariant that the PFN of a present * leaf SPTE can never change.
-	 * See __handle_changed_spte().
+	 * See handle_changed_spte().
 	 */
 	tdp_mmu_iter_set_spte(kvm, iter, 0);
 
@@ -1300,7 +1282,7 @@ bool kvm_tdp_mmu_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	/*
 	 * No need to handle the remote TLB flush under RCU protection, the
 	 * target SPTE _must_ be a leaf SPTE, i.e. cannot result in freeing a
-	 * shadow page.  See the WARN on pfn_changed in __handle_changed_spte().
+	 * shadow page. See the WARN on pfn_changed in handle_changed_spte().
 	 */
 	return kvm_tdp_mmu_handle_gfn(kvm, range, set_spte_gfn);
 }
-- 
2.40.0.rc2.332.ga46443480c-goog

