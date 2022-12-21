Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBAA653899
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiLUW0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiLUWZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:25:27 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACA727939
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:24:44 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v17-20020a17090abb9100b002239a73bc6eso1967512pjr.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUvSzm6zhuFwhwDfBHcpPhD05Pwase/3rciSEa3uh/0=;
        b=Vfbr638K23Tkpy4chmhkz5LuwrNuGxo4NEmcxSAginABFnm1kw7ZenYH4gp9QgSO11
         VQEQb+QJWIIWf6UTTkicMqeyvNOQ352ckTefjpJ6hIeef8iMLigA+xLhQvl76CZDldhG
         /vfNHHh2mcYSByw2dshKNTQmiFQt9db7lIIZKsspjCSPfGPOckOaqu0Re/ZpfkAgeV5V
         4s01ixfykyOpDlcceEuPlsaGCSvIfjrIOGdaPFeqj8oct91A/9XvjCMreyP4kDEFUQJM
         d+Txg1y1hD7UEgILJf9ZMrBjmrH+CglkTPz4qTdePAikPG7sByHhuN1IRTByAXxE7Gvv
         F1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUvSzm6zhuFwhwDfBHcpPhD05Pwase/3rciSEa3uh/0=;
        b=Uao2IzAY22IRShfTO6IdbOxPv1KMJTY/msREbAVOw/u8SV9sbzBTFuCLJzpWO4y91U
         DnqW4XnYguvsaX/lgbIWLE27wl11CwmS12r0ReOl9orV43GHInglhu8Ynxn7jZHogK3k
         BnWurU9BApRDN8xENgqx4i9ldp1Znfi9+jciloFsA8OTzUhsW8tAfcXHEdLMmZYfoRM6
         9qHiDmORR3PhAj6shjuq5mtjtsoqeBxcyDQz5JU/2BeDSvAxsVn9cvC1mmQ15nKxqNQ8
         3OLD4/V3rGzo+Hepi9mPBIL7rXVea3rIsnK+0Ft+PqFAMV/zTHWgc9/AQfT3WPt84k+D
         M3hw==
X-Gm-Message-State: AFqh2koJYT3OomofT40x2DT0P7O/tAEVt8UBb9FoOnY6WZAgnZlRKByf
        35rQw7635TCvvh2zU8W4JEcInqGKNVeH7w9CgUEttTWgiM8/Eo13Vx55eDvtAbp5pA9lMz6TMzY
        ZklV5VVyRjAwJzp81/6+q19XieWosQqOqDgt90E2c75QUg92u1H7eC0+NPgh50IR5qh+nW9TA
X-Google-Smtp-Source: AMrXdXtJshUqhw+9mehxMoK1nRrMONQlvaH9Vi3VdQOpEWUV7f5Sq0x8urLAg0f8htgiC5XpMFkfjkBaJ071
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a05:6a00:1d81:b0:576:ba28:29a8 with SMTP
 id z1-20020a056a001d8100b00576ba2829a8mr204908pfw.47.1671661484083; Wed, 21
 Dec 2022 14:24:44 -0800 (PST)
Date:   Wed, 21 Dec 2022 22:24:17 +0000
In-Reply-To: <20221221222418.3307832-1-bgardon@google.com>
Mime-Version: 1.0
References: <20221221222418.3307832-1-bgardon@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221221222418.3307832-14-bgardon@google.com>
Subject: [RFC 13/14] KVM: x86/MMU: Wrap uses of kvm_handle_gfn_range in mmu.c
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Nagareddy Reddy <nspreddy@google.com>,
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

handle_gfn_range + callback is not a bad interface, but it requires
exporting the whole callback scheme to mmu.c. Simplify the interface
with some basic wrapper functions, making the callback scheme internal
to shadow_mmu.c.

No functional change intended.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/mmu.c        |  8 +++---
 arch/x86/kvm/mmu/shadow_mmu.c | 54 +++++++++++++++++++++++++----------
 arch/x86/kvm/mmu/shadow_mmu.h | 25 ++++------------
 3 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ce2a6dd38c67..ceb3146016d0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -530,7 +530,7 @@ bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 	bool flush = false;
 
 	if (kvm_memslots_have_rmaps(kvm))
-		flush = kvm_handle_gfn_range(kvm, range, kvm_zap_rmap);
+		flush = kvm_shadow_mmu_unmap_gfn_range(kvm, range);
 
 	if (is_tdp_mmu_enabled(kvm))
 		flush = kvm_tdp_mmu_unmap_gfn_range(kvm, range, flush);
@@ -543,7 +543,7 @@ bool kvm_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	bool flush = false;
 
 	if (kvm_memslots_have_rmaps(kvm))
-		flush = kvm_handle_gfn_range(kvm, range, kvm_set_pte_rmap);
+		flush = kvm_shadow_mmu_set_spte_gfn(kvm, range);
 
 	if (is_tdp_mmu_enabled(kvm))
 		flush |= kvm_tdp_mmu_set_spte_gfn(kvm, range);
@@ -556,7 +556,7 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	bool young = false;
 
 	if (kvm_memslots_have_rmaps(kvm))
-		young = kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
+		young = kvm_shadow_mmu_age_gfn_range(kvm, range);
 
 	if (is_tdp_mmu_enabled(kvm))
 		young |= kvm_tdp_mmu_age_gfn_range(kvm, range);
@@ -569,7 +569,7 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 	bool young = false;
 
 	if (kvm_memslots_have_rmaps(kvm))
-		young = kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
+		young = kvm_shadow_mmu_test_age_gfn(kvm, range);
 
 	if (is_tdp_mmu_enabled(kvm))
 		young |= kvm_tdp_mmu_test_age_gfn(kvm, range);
diff --git a/arch/x86/kvm/mmu/shadow_mmu.c b/arch/x86/kvm/mmu/shadow_mmu.c
index 77472eb9b06a..1c6ff6fe3d2c 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.c
+++ b/arch/x86/kvm/mmu/shadow_mmu.c
@@ -862,16 +862,16 @@ static bool __kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	return kvm_zap_all_rmap_sptes(kvm, rmap_head);
 }
 
-bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
-		  pte_t unused)
+static bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			 struct kvm_memory_slot *slot, gfn_t gfn, int level,
+			 pte_t unused)
 {
 	return __kvm_zap_rmap(kvm, rmap_head, slot);
 }
 
-bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		      struct kvm_memory_slot *slot, gfn_t gfn, int level,
-		      pte_t pte)
+static bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			     struct kvm_memory_slot *slot, gfn_t gfn, int level,
+			     pte_t pte)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -978,9 +978,13 @@ static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 	     slot_rmap_walk_okay(_iter_);				\
 	     slot_rmap_walk_next(_iter_))
 
-__always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
-					  struct kvm_gfn_range *range,
-					  rmap_handler_t handler)
+typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			       struct kvm_memory_slot *slot, gfn_t gfn,
+			       int level, pte_t pte);
+
+static __always_inline bool
+kvm_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
+		     rmap_handler_t handler)
 {
 	struct slot_rmap_walk_iterator iterator;
 	bool ret = false;
@@ -993,9 +997,9 @@ __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
 	return ret;
 }
 
-bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
-		  pte_t unused)
+static bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			 struct kvm_memory_slot *slot, gfn_t gfn, int level,
+			 pte_t unused)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1007,9 +1011,9 @@ bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 	return young;
 }
 
-bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		       struct kvm_memory_slot *slot, gfn_t gfn,
-		       int level, pte_t unused)
+static bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+			      struct kvm_memory_slot *slot, gfn_t gfn,
+			      int level, pte_t unused)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -3508,3 +3512,23 @@ void kvm_shadow_mmu_wrprot_slot(struct kvm *kvm,
 	slot_handle_level(kvm, memslot, slot_rmap_write_protect,
 			  start_level, KVM_MAX_HUGEPAGE_LEVEL, false);
 }
+
+bool kvm_shadow_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return kvm_handle_gfn_range(kvm, range, kvm_zap_rmap);
+}
+
+bool kvm_shadow_mmu_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return kvm_handle_gfn_range(kvm, range, kvm_set_pte_rmap);
+}
+
+bool kvm_shadow_mmu_age_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return kvm_handle_gfn_range(kvm, range, kvm_age_rmap);
+}
+
+bool kvm_shadow_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	return kvm_handle_gfn_range(kvm, range, kvm_test_age_rmap);
+}
diff --git a/arch/x86/kvm/mmu/shadow_mmu.h b/arch/x86/kvm/mmu/shadow_mmu.h
index 397fb463ef54..2ded3d674cb0 100644
--- a/arch/x86/kvm/mmu/shadow_mmu.h
+++ b/arch/x86/kvm/mmu/shadow_mmu.h
@@ -26,26 +26,6 @@ struct pte_list_desc {
 /* Only exported for debugfs.c. */
 unsigned int pte_list_count(struct kvm_rmap_head *rmap_head);
 
-bool kvm_zap_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
-		  pte_t unused);
-bool kvm_set_pte_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		      struct kvm_memory_slot *slot, gfn_t gfn, int level,
-		      pte_t pte);
-
-typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-			       struct kvm_memory_slot *slot, gfn_t gfn,
-			       int level, pte_t pte);
-bool kvm_handle_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
-			  rmap_handler_t handler);
-
-bool kvm_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		  struct kvm_memory_slot *slot, gfn_t gfn, int level,
-		  pte_t unused);
-bool kvm_test_age_rmap(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
-		       struct kvm_memory_slot *slot, gfn_t gfn,
-		       int level, pte_t unused);
-
 void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp);
 
 bool __kvm_shadow_mmu_prepare_zap_page(struct kvm *kvm, struct kvm_mmu_page *sp,
@@ -101,6 +81,11 @@ void kvm_shadow_mmu_wrprot_slot(struct kvm *kvm,
 				const struct kvm_memory_slot *memslot,
 				int start_level);
 
+bool kvm_shadow_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
+bool kvm_shadow_mmu_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
+bool kvm_shadow_mmu_age_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
+bool kvm_shadow_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
+
 /* Exports from paging_tmpl.h */
 gpa_t paging32_gva_to_gpa(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 			  gpa_t vaddr, u64 access,
-- 
2.39.0.314.g84b9a713c41-goog

