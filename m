Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2E6FFD91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 01:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbjEKX7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 19:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239623AbjEKX71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 19:59:27 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFFB2689
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53017eb8b2eso5565251a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 16:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683849566; x=1686441566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PikE2sys0Bkw6OuFwhsOmriaAvdxJeJy0bEZXYHR6ps=;
        b=dZK3TIMY1KqU98/dI2bh88MzcBwpNW/nl4yCarDpLAxx5tYXXWm/+94gBnBN8jaTTa
         a4ZSO3mz0BDPUpqRLN+T177f+nEGv1K34k6YguSfdMsD1oD5E7JM3w2RYqSdL3JdRQbl
         Y4CGw1pePwomjKrjZTfGH1pLhgooy7ncPlEAL86vDItZPf57h/fLbm+bexMZv8rELGFd
         WnuhXWPcpXTO5EIINh2kH7XSKRtECYbPz7EvbfLuSP8elSf77h0hvLRihkPqSZwNHBQo
         HD49nVUppK2fo1ud/3++WO2wC4lcTjI/nHf3UPRHk0/g1tbM5FqFR/aTP9i6y8mLpsDm
         JeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683849566; x=1686441566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PikE2sys0Bkw6OuFwhsOmriaAvdxJeJy0bEZXYHR6ps=;
        b=YUpE5S1Kd/9mnp3ZAy5lpdYUVNf/bmimgFX3tbURetdj5rcER/WSqIpJcQm7djRtmu
         iDDeJpoBPjb8dHdfaqH0FJ/pWZhIXBSxz/kvlnvz/ENMlw49Z19wK5o4S1MmNqed4H8D
         ioKvx+9bl/0bzCMpriDdKUwgChcZj3GwyufzLRE1rF4/2Io6vGDxGKkrjpw4O9PHceJL
         a87FeC3iAI2uVE/2NoRXtgeaOkWh53PlB41lPuINKliPG5pzpmXdOEgD/dVguLjT3AaK
         gGeKmFfYjUYLDQrgtkLO3O+llQ1/Trurp7ZTxjBjxLkwOJRUQVkwTGodQb8IqJP/RIU9
         aO9g==
X-Gm-Message-State: AC+VfDxNLHtOXrovE1sQZZjjlmkL/bHgy+2/a71gErRN1lxnRRyq5KF/
        OjKZoe+ZgpSqY6B2HvhjWzzN2hEL+Qo=
X-Google-Smtp-Source: ACHHUZ5rDKGyUS4GvTb7gmtbjPIQqXx4fUgA3xtEszH3sHui2Ppu/htGcfPhkCGRTei+fbyk6Tovrv37/lI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2807:0:b0:52c:4227:aa60 with SMTP id
 bs7-20020a632807000000b0052c4227aa60mr6346089pgb.7.1683849566231; Thu, 11 May
 2023 16:59:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 May 2023 16:59:12 -0700
In-Reply-To: <20230511235917.639770-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230511235917.639770-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230511235917.639770-5-seanjc@google.com>
Subject: [PATCH 4/9] KVM: x86/mmu: Rename MMU_WARN_ON() to KVM_MMU_WARN_ON()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mingwei Zhang <mizhang@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename MMU_WARN_ON() to make it super obvious that the assertions are
all about KVM's MMU, not the primary MMU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 4 ++--
 arch/x86/kvm/mmu/mmu_internal.h | 4 ++--
 arch/x86/kvm/mmu/spte.h         | 8 ++++----
 arch/x86/kvm/mmu/tdp_mmu.c      | 8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2b65a62fb953..240272b10ceb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1252,7 +1252,7 @@ static bool spte_clear_dirty(u64 *sptep)
 {
 	u64 spte = *sptep;
 
-	MMU_WARN_ON(!spte_ad_enabled(spte));
+	KVM_MMU_WARN_ON(!spte_ad_enabled(spte));
 	spte &= ~shadow_dirty_mask;
 	return mmu_spte_update(sptep, spte);
 }
@@ -1728,7 +1728,7 @@ static void kvm_unaccount_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 
 static void kvm_mmu_free_shadow_page(struct kvm_mmu_page *sp)
 {
-	MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
+	KVM_MMU_WARN_ON(!is_empty_shadow_page(sp->spt));
 	hlist_del(&sp->hash_link);
 	list_del(&sp->link);
 	free_page((unsigned long)sp->spt);
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 9ea80e4d463c..bb1649669bc9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -9,9 +9,9 @@
 #undef MMU_DEBUG
 
 #ifdef MMU_DEBUG
-#define MMU_WARN_ON(x) WARN_ON(x)
+#define KVM_MMU_WARN_ON(x) WARN_ON(x)
 #else
-#define MMU_WARN_ON(x) do { } while (0)
+#define KVM_MMU_WARN_ON(x) do { } while (0)
 #endif
 
 /* Page table builder macros common to shadow (host) PTEs and guest PTEs. */
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 1279db2eab44..83e6614f3720 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -265,13 +265,13 @@ static inline bool sp_ad_disabled(struct kvm_mmu_page *sp)
 
 static inline bool spte_ad_enabled(u64 spte)
 {
-	MMU_WARN_ON(!is_shadow_present_pte(spte));
+	KVM_MMU_WARN_ON(!is_shadow_present_pte(spte));
 	return (spte & SPTE_TDP_AD_MASK) != SPTE_TDP_AD_DISABLED;
 }
 
 static inline bool spte_ad_need_write_protect(u64 spte)
 {
-	MMU_WARN_ON(!is_shadow_present_pte(spte));
+	KVM_MMU_WARN_ON(!is_shadow_present_pte(spte));
 	/*
 	 * This is benign for non-TDP SPTEs as SPTE_TDP_AD_ENABLED is '0',
 	 * and non-TDP SPTEs will never set these bits.  Optimize for 64-bit
@@ -282,13 +282,13 @@ static inline bool spte_ad_need_write_protect(u64 spte)
 
 static inline u64 spte_shadow_accessed_mask(u64 spte)
 {
-	MMU_WARN_ON(!is_shadow_present_pte(spte));
+	KVM_MMU_WARN_ON(!is_shadow_present_pte(spte));
 	return spte_ad_enabled(spte) ? shadow_accessed_mask : 0;
 }
 
 static inline u64 spte_shadow_dirty_mask(u64 spte)
 {
-	MMU_WARN_ON(!is_shadow_present_pte(spte));
+	KVM_MMU_WARN_ON(!is_shadow_present_pte(spte));
 	return spte_ad_enabled(spte) ? shadow_dirty_mask : 0;
 }
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 08340219c35a..6ef44d60ba2b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1545,8 +1545,8 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!is_shadow_present_pte(iter.old_spte))
 			continue;
 
-		MMU_WARN_ON(kvm_ad_enabled() &&
-			    spte_ad_need_write_protect(iter.old_spte));
+		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
+				spte_ad_need_write_protect(iter.old_spte));
 
 		if (!(iter.old_spte & dbit))
 			continue;
@@ -1604,8 +1604,8 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!mask)
 			break;
 
-		MMU_WARN_ON(kvm_ad_enabled() &&
-			    spte_ad_need_write_protect(iter.old_spte));
+		KVM_MMU_WARN_ON(kvm_ad_enabled() &&
+				spte_ad_need_write_protect(iter.old_spte));
 
 		if (iter.level > PG_LEVEL_4K ||
 		    !(mask & (1UL << (iter.gfn - gfn))))
-- 
2.40.1.606.ga4b1b128d6-goog

