Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA86B5696
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCKAYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCKAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:42 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7691B166C4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536bf649e70so70280337b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6pZnJVg25eyMveIv3/duenR4ioTSWK21ILUn7ktJtk=;
        b=fW7SIHxJHBoSqAPEBOS5mWe5gfPekz/J4gy/C9npc9LGXg1kzzQmPSW2KEO5NfzKlp
         jis4mUml6dDwPYEJ5EZcT7y+L/sifVjanJbvSe1dSA76S2a3KcL+RGWUWj51mHMSGMK4
         23dVrVI1ebYRhkXY9xvQdAzQr5WZCSmGMsUEAL50y6nt/qHXnrf5wFxpXeQM1bXSuF96
         RrUQQVwdizUqSPQQZnZBxSly3MAIDFNYxQJCirto1mxjd6kBRO1QifVyyAt9NcJvSVCD
         QeD8M6UW1G8Rtt3ZXqUFXprmDp5ZSEdcEjgHi/biCE9qe7KO3/AZcKgH9hIp2RkMU2Nn
         Owqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6pZnJVg25eyMveIv3/duenR4ioTSWK21ILUn7ktJtk=;
        b=TkCub5i65fgtI8cOH66LIEgnrrUUMTrPpvg125bk17NiKTJHXfN7JkxPYrz/hfcZG0
         VZS2d2TUlT6y3y+syyWTRoseIkrgNhepK8CPsvMzY4JJgAEJmG0aZgQUnE/6tLAySuf7
         +mTgo1sN/0SJ/zWGB5OXTdrFyhv/+n3Rgb+n2A+GUoJDX7ekybF9rIMiFVS8Blwt+gmC
         4+R2/pdYJGwUFpY0CJwYPYYttQgpoVhsiMJvCCb5hbVTHB87kBnVRD0euDmbJC/i9Kqt
         sgqjTvXXTifRt/m+TWFiQMapIU4D0fq64SXPS2OEQ8HP6IaEpcP3p3wMxAu+kY3wOhZh
         Lejg==
X-Gm-Message-State: AO0yUKUVOEd8xMJqRE3eA76WkGoao2pWVwyJaSykEzzWTROK2ylU+xz7
        20K2Y4LopibQTd4vl/kAZNX4NQo+wd8=
X-Google-Smtp-Source: AK7set8PLWS0LgJdEMlnGsWe/+oN00JCQoIoDrltuwf20ow6dvSbBI2QU7f6C7ZLsFu9kLElsim6V3gV2u4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188:b0:a99:de9d:d504 with SMTP id
 t8-20020a056902018800b00a99de9dd504mr16643426ybh.12.1678494206913; Fri, 10
 Mar 2023 16:23:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:42 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-12-seanjc@google.com>
Subject: [PATCH v2 11/27] KVM: x86/mmu: Don't rely on page-track mechanism to
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
bouncing through the page-track mechanism.  KVM (unfortunately) needs to
zap and flush all page tables on memslot DELETE/MOVE irrespective of
whether KVM is shadowing guest page tables.

This will allow changing KVM to register a page-track notifier on the
first shadow root allocation, and will also allow deleting the misguided
kvm_page_track_flush_slot() hook itself once KVM-GT also moves to a
different method for reacting to memslot changes.

No functional change intended.

Cc: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/r/20221110014821.1548347-2-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/mmu/mmu.c          | 10 +---------
 arch/x86/kvm/x86.c              |  2 ++
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 808c292ad3f4..17281d6825c9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1844,6 +1844,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 				   const struct kvm_memory_slot *memslot);
 void kvm_mmu_zap_all(struct kvm *kvm);
+void kvm_mmu_zap_all_fast(struct kvm *kvm);
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned long kvm_nr_mmu_pages);
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4685c80e441b..409dabec69df 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6030,7 +6030,7 @@ static void kvm_zap_obsolete_pages(struct kvm *kvm)
  * not use any resource of the being-deleted slot or all slots
  * after calling the function.
  */
-static void kvm_mmu_zap_all_fast(struct kvm *kvm)
+void kvm_mmu_zap_all_fast(struct kvm *kvm)
 {
 	lockdep_assert_held(&kvm->slots_lock);
 
@@ -6086,13 +6086,6 @@ static bool kvm_has_zapped_obsolete_pages(struct kvm *kvm)
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
@@ -6110,7 +6103,6 @@ int kvm_mmu_init_vm(struct kvm *kvm)
 	}
 
 	node->track_write = kvm_mmu_pte_write;
-	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
 	kvm_page_track_register_notifier(kvm, node);
 
 	kvm->arch.split_page_header_cache.kmem_cache = mmu_page_header_cache;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f706621c35b8..29dd6c97d145 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12662,6 +12662,8 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
+	kvm_mmu_zap_all_fast(kvm);
+
 	kvm_page_track_flush_slot(kvm, slot);
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

