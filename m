Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12247654A28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 01:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiLWA7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 19:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiLWA63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 19:58:29 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632A4220D3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:02 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f132-20020a636a8a000000b00473d0b600ebso1900253pgc.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ACcf4TIOY/KNCxT8YXaOwMosCx8LQofQdn0euCiCY4M=;
        b=TMBTtSKif9JQYrBRgC2Kk26Arhd33oSJssQxGXX/l24pjOtYOl3FvdMwZWJ1gMi8be
         fxmbPb0zXMsVCi1OjlfQel7xq87Va6mq6g/Ca3vzmLvdxVTKlW+1Q5rwQmDHpa7RT1bW
         1UfbKAXIuJxp0UmFpoguv7JwOpet+rHaqILtSPjCBepdHWNxYgrzerCuDKGQ78gVYADM
         K3tr43AkqFOOIuSyw/7t7XKS2KzvT+E6FucHlxZOO89VrQsP8riSCpTQBRNvLE43KMjj
         MAMf3oEGVz8uxC39pSO9satkIJA10i4iFcEgNSKCfejQPAsa5QzyABTCtrSsCnD+cbDL
         x8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACcf4TIOY/KNCxT8YXaOwMosCx8LQofQdn0euCiCY4M=;
        b=frV/BcveQiHintlm5op9jekrOmok5DsXouYoeDyLLgusqML4nhdS949LYvGadWiLWt
         bLwdK2M6HKipzx2tOanFqfXSl8vlHnRy0oRpP+oSBldTLRa3uqd5LHpoGzwQv/wrFPaY
         KiynyL3aK8Ld9g3KlCXtYZPqkdv1U6952RYEuEEFhkT/zWk7anvLpEzup3CO3ZMlL52F
         bQ28cTjA1n1qIJx8ScjNvwNvL4w1s6ofB7j73mRkYC0utSrOd3Qq49Wyz1N7c224OUMi
         5Q2357BKmunIl2S5ThmSCn9qwygrnFKpwiGQBSVC2iQrp/FvHro+b1Xg+QC9dSwKOPnd
         zKGQ==
X-Gm-Message-State: AFqh2kpFZcpfjCsZMouq0r9nqQ0l0jciRIB2+pY8jen28ADniWWoMARL
        RNPL4I+wjfr6xteW9+Uu2N4zPQ8HOAg=
X-Google-Smtp-Source: AMrXdXuqqyTgcQHilI53SefEG/5sBcIEwh5xs70zEETtCu7A3Q44yDAHVNGxCdXtPPvHf1LR8O/lpRt7G1I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4ca:b0:188:a51c:b570 with SMTP id
 o10-20020a170902d4ca00b00188a51cb570mr461459plg.7.1671757081979; Thu, 22 Dec
 2022 16:58:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Dec 2022 00:57:22 +0000
In-Reply-To: <20221223005739.1295925-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221223005739.1295925-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223005739.1295925-11-seanjc@google.com>
Subject: [PATCH 10/27] KVM: x86/mmu: Don't rely on page-track mechanism to
 flush on memslot change
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yan Zhao <yan.y.zhao@intel.com>,
        Ben Gardon <bgardon@google.com>
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

Call kvm_mmu_zap_all_fast() directly when flushing a memslot instead of
bounding through the page-track mechanism.  KVM (unfortunately) needs to
zap and flush all page tables on memslot DELETE/MOVE irrespective of
whether KVM is shadowing guest page tables.

This will allow changing KVM to register a page-track notifier on the
first shadow root allocation, and will also allow deleting the misguided
kvm_page_track_flush_slot() hook itself once KVM-GT also moves to a
different method for reacting to memslot changes.

No functional change intended.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20221110014821.1548347-2-seanjc@google.com
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 10 +---------
 arch/x86/kvm/x86.c              |  2 ++
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index aa4eb8cfcd7e..fcb042f971ee 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1798,6 +1798,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot);
 void kvm_mmu_zap_all(struct kvm *kvm);
+void kvm_mmu_zap_all_fast(struct kvm *kvm);
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ca7428b68eba..8c3a453554ed 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6009,7 +6009,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
  * not use any resource of the being-deleted slot or all slots
  * after calling the function.
  */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+void kvm_mmu_zap_all_fast(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
 
@@ -6065,13 +6065,6 @@ static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
 	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
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
 	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
@@ -6089,7 +6082,6 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 	}
 
 	node->track_write = kvm_mmu_pte_write;
-	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
 	kvm_page_track_register_notifier(kvm, node);
 
 	kvm->arch.split_page_header_cache.kmem_cache = mmu_page_header_cache;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 312aea1854ae..af0d83e33bc4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12599,6 +12599,8 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
+	kvm_mmu_zap_all_fast(kvm);
+
 	kvm_page_track_flush_slot(kvm, slot);
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

