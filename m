Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDDD6B56A8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCKAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCKAYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:24:40 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A4713EBAB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:54 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id t24-20020a1709028c9800b0019eaa064a51so3640654plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UJLL0EPUo19me5J0i4EMPHQADwiwXxBwpAy+HnKKqJM=;
        b=Ezz+fnDWWlBK70CA+7XZnivF8Z50Oo2xZVtUDsT+vPhVst1blCQstri3YU291MrGCd
         /gIJe4EdZVS2uXwFfhgIdnLH81FvnSdDh9ZOO2wwTY94LJfODrVCfdn5tHlyoc3wozDg
         DEMhqXCb5vWfrRk8d+aiFLTFqnF64CWPV/X9jcMymnFIgXu/w+WhD9iUivEV5M8xAwDJ
         WB2G3R1UU7dqnh10DoPBAm5TruGVVgEhIWo5jhXguMT++g5lloBe+oip6RCzH6WDEEva
         eaaN+vYVq0x2mhYositDUR3O8N2/sjmHQuoCbcFN6jMXtHvoYYojB7nK7rAoEpe7EL5C
         8JMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UJLL0EPUo19me5J0i4EMPHQADwiwXxBwpAy+HnKKqJM=;
        b=B+SE3RLwHtO/ZTd8ZTVzCxZpe0A3vtuQeXM0W0MdfIFLySjBqNwg/GQd4yRwJeaaT5
         T5ZO+wzj0o6jr0aRpvgzb8QNiL8a9dAGfELV2WsFqX2bWsSEmB8wHvBWe4V+rySMWeMJ
         6ffYz3JVCeRILmpNRwNvVJEwaKjeChN/ypM8MqlIqxKpJaaAn+lGDISbupulddJxp73y
         qWwEsQTXgdcIv72vJ5zw8X1fuYcG8Qa8vg1wLgGpInOh5c60XPSVkKbPC7z/qXAoKXC2
         ETUXdseCGBx8QYrZvQLA/ZC7rzMY9nIpI+eBHsh7mRoDNysq5geJHMOiw4xp3sm2ZtuA
         3btg==
X-Gm-Message-State: AO0yUKWa8Aqah+QY5GJ6SlTKQ6MTg8eb2hOU0JfgD9PdzukZ7TKVaIpY
        yQ0s3S9mFLm48SRDlmplQgjMDhd3FVc=
X-Google-Smtp-Source: AK7set9xIsp/owUP+tx5zbIbI7LTvGVXs/oz607/58uRHJkalFPSILRGBF4otBdhDlNEtNvINP9Bd23i5ZM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3889:b0:233:c921:ab7e with SMTP id
 mu9-20020a17090b388900b00233c921ab7emr1601258pjb.4.1678494219865; Fri, 10 Mar
 2023 16:23:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:49 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-19-seanjc@google.com>
Subject: [PATCH v2 18/27] KVM: x86: Remove the unused page-track hook track_flush_slot()
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yan Zhao <yan.y.zhao@intel.com>

Remove ->track_remove_slot(), there are no longer any users and it's
unlikely a "flush" hook will ever be the correct API to provide to an
external page-track user.

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_page_track.h | 11 -----------
 arch/x86/kvm/mmu/page_track.c         | 26 --------------------------
 arch/x86/kvm/x86.c                    |  2 --
 3 files changed, 39 deletions(-)

diff --git a/arch/x86/include/asm/kvm_page_track.h b/arch/x86/include/asm/kvm_page_track.h
index 152c5e7d7868..e5eb98ca4fce 100644
--- a/arch/x86/include/asm/kvm_page_track.h
+++ b/arch/x86/include/asm/kvm_page_track.h
@@ -33,16 +33,6 @@ struct kvm_page_track_notifier_node {
 	 */
 	void (*track_write)(gpa_t gpa, const u8 *new, int bytes,
 			    struct kvm_page_track_notifier_node *node);
-	/*
-	 * It is called when memory slot is being moved or removed
-	 * users can drop write-protection for the pages in that memory slot
-	 *
-	 * @kvm: the kvm where memory slot being moved or removed
-	 * @slot: the memory slot being moved or removed
-	 * @node: this node
-	 */
-	void (*track_flush_slot)(struct kvm *kvm, struct kvm_memory_slot *slot,
-			    struct kvm_page_track_notifier_node *node);
 
 	/*
 	 * Invoked when a memory region is removed from the guest.  Or in KVM
@@ -87,7 +77,6 @@ kvm_page_track_unregister_notifier(struct kvm *kvm,
 				   struct kvm_page_track_notifier_node *n);
 void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 			  int bytes);
-void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_page_track_delete_slot(struct kvm *kvm, struct kvm_memory_slot *slot);
 
 bool kvm_page_track_has_external_user(struct kvm *kvm);
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index d4a8a995276a..907ab8abb452 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -278,32 +278,6 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 	kvm_mmu_track_write(vcpu, gpa, new, bytes);
 }
 
-/*
- * Notify the node that memory slot is being removed or moved so that it can
- * drop write-protection for the pages in the memory slot.
- *
- * The node should figure out it has any write-protected pages in this slot
- * by itself.
- */
-void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
-{
-	struct kvm_page_track_notifier_head *head;
-	struct kvm_page_track_notifier_node *n;
-	int idx;
-
-	head = &kvm->arch.track_notifier_head;
-
-	if (hlist_empty(&head->track_notifier_list))
-		return;
-
-	idx = srcu_read_lock(&head->track_srcu);
-	hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
-				srcu_read_lock_held(&head->track_srcu))
-		if (n->track_flush_slot)
-			n->track_flush_slot(kvm, slot, n);
-	srcu_read_unlock(&head->track_srcu, idx);
-}
-
 /*
  * Notify external page track nodes that a memory region is being removed from
  * the VM, e.g. so that users can free any associated metadata.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0da5ff007d20..59b02650cefc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12673,8 +12673,6 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 				   struct kvm_memory_slot *slot)
 {
 	kvm_mmu_zap_all_fast(kvm);
-
-	kvm_page_track_flush_slot(kvm, slot);
 }
 
 static inline bool kvm_guest_apic_has_interrupt(struct kvm_vcpu *vcpu)
-- 
2.40.0.rc1.284.g88254d51c5-goog

