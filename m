Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EA26AD1D7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCFWmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCFWlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:41:49 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688575854
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:41:46 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m9-20020a17090a7f8900b0023769205928so7063204pjl.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 14:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678142506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fud6El3rNU/znA5Y7aANLknllha9pomZRWuqilbnIcQ=;
        b=RHrpxvtkoJL3G7M+x0b7vy1LMCEVHhhInmhGl/pZvP+imrCBzb7gpuU9I4dY0Mk4Md
         E3mJ9rZE0xkYlu56wN7H7+Wv0o0LrN/Lsh+B4Iz7k7L6oemm3rolHrxMC9Xmod2/w4TW
         9ZrbsWYDscNpA+wbxAxnZ74ClfSjyspMqWYI5BhgxKLQLACztlfI3fgQ+2/ZBHEfqFYC
         pOojCBBKl63E8QCWBNXnDHjA9+D2C3+w4VS6GuaMuxeHHk+KEvBBFbBvqnfWyu1wsOjc
         24XDTa7FyWo1Ei8/jlkbUDsoFeAwntPi/zr2ly80qNFKEHtAPSMAmyCiZMgoHlRKOWMK
         VBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678142506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fud6El3rNU/znA5Y7aANLknllha9pomZRWuqilbnIcQ=;
        b=KxcunUmA0ObQT4c0oYBvqrkdryfp9n77Cchhsc5+AzaVz/gRIq3qBHkm0fSYb+euIX
         6FqJymPkRbWS6fSoBAb4mM7XLnTzAPOLn2bWt80NxN2SKaUNOT89RU7G38gh/PxsYj5y
         xL4ZTnoe3Ib65vPU0XedfsHJ/KxmSDGxJd4OUvi74pfkbEnqImzHe8ZfL/Yo4dC/kQXn
         guUDYN7Fd+hU/vGPpY8IkMArnAhkl1akgE2LNL2tjLAIv47f42YAD0Uj0SEoa1zEjMQc
         yUEpH81Ut0kmrRu73Z5K9b5HxaDxBgxSNG/3gW63XV4RSn5e2dPtHAT7zWnYxq9/DVjn
         EU4Q==
X-Gm-Message-State: AO0yUKXVDk0xhJyy9cM7qKodCpbjLz3Tzhg1uJhxPE0+Zv8DACITeEBT
        oVAgS/AAowiMpzQK+Qz4KAsVzZqkE6qS
X-Google-Smtp-Source: AK7set9b0/v6Geu4DXnRkHsEWeT3CmFfj0wEOQBYiSgplekLFzbGS00cUR6Ne+Y+3saMoYhownTfzbVX3gco
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:f0c9:b0:237:4a5d:5a57 with SMTP id
 fa9-20020a17090af0c900b002374a5d5a57mr4698851pjb.1.1678142506491; Mon, 06 Mar
 2023 14:41:46 -0800 (PST)
Date:   Mon,  6 Mar 2023 14:41:16 -0800
In-Reply-To: <20230306224127.1689967-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20230306224127.1689967-1-vipinsh@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Message-ID: <20230306224127.1689967-8-vipinsh@google.com>
Subject: [Patch v4 07/18] KVM: x86/mmu: Unconditionally count allocations from
 MMU page caches
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        dmatlack@google.com
Cc:     jmattson@google.com, mizhang@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

Remove count_shadow_page_allocations from struct shadow_page_caches{}.
Remove count_allocation boolean condition check from
mmu_sp_memory_cache_alloc().

Both split_shadow_page_cache and mmu_shadow_page_cache are counted in
global count of unused cache pages. count_shadow_page_allocations
boolean is obsolete and can be removed.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 11 +++--------
 arch/x86/kvm/mmu/mmu_internal.h |  3 +--
 arch/x86/kvm/mmu/tdp_mmu.c      |  3 +--
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 73a0ac9c11ce..0a0962d8108b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2184,7 +2184,6 @@ struct shadow_page_caches {
 	struct kvm_mmu_memory_cache *page_header_cache;
 	struct kvm_mmu_memory_cache *shadow_page_cache;
 	struct kvm_mmu_memory_cache *shadowed_info_cache;
-	bool count_shadow_page_allocation;
 };
 
 static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
@@ -2196,8 +2195,7 @@ static struct kvm_mmu_page *kvm_mmu_alloc_shadow_page(struct kvm *kvm,
 	struct kvm_mmu_page *sp;
 
 	sp = kvm_mmu_memory_cache_alloc(caches->page_header_cache);
-	sp->spt = mmu_sp_memory_cache_alloc(caches->shadow_page_cache,
-					    caches->count_shadow_page_allocation);
+	sp->spt = mmu_sp_memory_cache_alloc(caches->shadow_page_cache);
 	if (!role.direct)
 		sp->shadowed_translation = kvm_mmu_memory_cache_alloc(caches->shadowed_info_cache);
 
@@ -2254,7 +2252,6 @@ static struct kvm_mmu_page *kvm_mmu_get_shadow_page(struct kvm_vcpu *vcpu,
 		.page_header_cache = &vcpu->arch.mmu_page_header_cache,
 		.shadow_page_cache = &vcpu->arch.mmu_shadow_page_cache,
 		.shadowed_info_cache = &vcpu->arch.mmu_shadowed_info_cache,
-		.count_shadow_page_allocation = true,
 	};
 
 	return __kvm_mmu_get_shadow_page(vcpu->kvm, vcpu, &caches, gfn, role);
@@ -6330,7 +6327,6 @@ static struct kvm_mmu_page *shadow_mmu_get_sp_for_split(struct kvm *kvm, u64 *hu
 	/* Direct SPs do not require a shadowed_info_cache. */
 	caches.page_header_cache = &kvm->arch.split_page_header_cache;
 	caches.shadow_page_cache = &kvm->arch.split_shadow_page_cache;
-	caches.count_shadow_page_allocation = true;
 
 	/* Safe to pass NULL for vCPU since requesting a direct SP. */
 	return __kvm_mmu_get_shadow_page(kvm, NULL, &caches, gfn, role);
@@ -7101,10 +7097,9 @@ void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
 		kthread_stop(kvm->arch.nx_huge_page_recovery_thread);
 }
 
-void *mmu_sp_memory_cache_alloc(struct kvm_mmu_memory_cache *shadow_page_cache,
-				bool count_allocation)
+void *mmu_sp_memory_cache_alloc(struct kvm_mmu_memory_cache *shadow_page_cache)
 {
-	if (count_allocation && shadow_page_cache->nobjs)
+	if (shadow_page_cache->nobjs)
 		percpu_counter_dec(&kvm_total_unused_cached_pages);
 	return kvm_mmu_memory_cache_alloc(shadow_page_cache);
 }
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 798cfbf0a36b..a607314348e3 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -338,7 +338,6 @@ void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc);
 
 void track_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
 void untrack_possible_nx_huge_page(struct kvm *kvm, struct kvm_mmu_page *sp);
-void *mmu_sp_memory_cache_alloc(struct kvm_mmu_memory_cache *cache,
-				bool count_allocation);
+void *mmu_sp_memory_cache_alloc(struct kvm_mmu_memory_cache *cache);
 
 #endif /* __KVM_X86_MMU_INTERNAL_H */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index fa6eb1e9101e..d1e85012a008 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -265,8 +265,7 @@ static struct kvm_mmu_page *tdp_mmu_alloc_sp(struct kvm_vcpu *vcpu)
 	struct kvm_mmu_page *sp;
 
 	sp = kvm_mmu_memory_cache_alloc(&vcpu->arch.mmu_page_header_cache);
-	sp->spt = mmu_sp_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache,
-					    true);
+	sp->spt = mmu_sp_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);
 
 	return sp;
 }
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

