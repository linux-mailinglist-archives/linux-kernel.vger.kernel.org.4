Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452366B5662
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjCKAX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCKAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:23:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7B1E5ED
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:10 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id t12-20020aa7938c000000b005ac41980708so3591675pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678494190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eHqcqPuh0X7PQYReRTzohsMCRBED7m2vs4Y/3/bIpTQ=;
        b=tQGcDl0LzQbxToMGy5qxSYm8BEkXfhbWlTvTCiUHeYOQgTHbWZTZZRkA7ZqcvX9S86
         3KiDsW9HNTSISW2P73wBpcZ88hyQ+IeGlvy5TgSamFq6NZTm/UCrON8iXa2dzvIiWiGp
         +W4KemfD5UbSRZai7O68Kru+sWhdpFoikAvEsG8v0bmcf6DxSsz56ky4hZo8E4ooAgFs
         IspDuedJicbD6DnDrr+rpTcXPSUmA74Zy61zSlLY4/K0RTTs/UISui5nZTVB4TEsa+jv
         TweVwST4EA6OgArjt0oJ45NmU6Sj1e+QIO04KVV0l5mDaDbix4kdjntEKEREKSIzJqHJ
         LaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678494190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHqcqPuh0X7PQYReRTzohsMCRBED7m2vs4Y/3/bIpTQ=;
        b=e5s28jSbX8MHdVyUCBQUcONhetzUaLxtPVnWx3141uvo/9tC464q0uz/t39ud0zl8n
         lpgZRBiO9dZ74z9Z0ULwC06Z7QetI3/gicLa2K0dYXboCnUjMYZY9FDb+gc+LlDuzTM5
         g4sln6ZRaRf3Hmkifj40Fd6+KNd/yfeHnBbgcJZPH3U/2wV7VmlX3VyQaz7vHTgqozjO
         N5SSpWU2ubj9TTNA9lpuFp2wq26KCMEa1Af6W4PpNA7VmpitIy/2ww3J5LTzUns32xHE
         8ts70DmnbPu5UdKXF9qSxfL9fA/5svhumKkR0swjBl0Ft8CKbgmCwnAfXGAv13sMl5SQ
         aD4A==
X-Gm-Message-State: AO0yUKX2uQui64Bl8YmRtFTFcJhAgqwPF78/mEdjvd/W2r5cpK29rYRE
        fzM0JCVo05niU0BKeiilAr+aZR+4xzs=
X-Google-Smtp-Source: AK7set9jx7Uy7PzVJsl0JZUMlerJnH1eqXkOWuYf0hsbDX1FhGPzk3Q6AIFhADI5JkJoBFyLT7Lz5rpwrlo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c688:b0:22c:89b:8e97 with SMTP id
 n8-20020a17090ac68800b0022c089b8e97mr1510024pjt.1.1678494189968; Fri, 10 Mar
 2023 16:23:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:22:33 -0800
In-Reply-To: <20230311002258.852397-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311002258.852397-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311002258.852397-3-seanjc@google.com>
Subject: [PATCH v2 02/27] KVM: x86/mmu: Factor out helper to get max mapping
 size of a memslot
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

Extract the memslot-related logic of kvm_mmu_max_mapping_level() into a
new helper so that KVMGT can determine whether or not mapping a 2MiB page
into the guest is (dis)allowed per KVM's memslots.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c          | 21 +++++++++++++++------
 arch/x86/kvm/mmu/mmu_internal.h |  2 ++
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index c8ebe542c565..4685c80e441b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3083,20 +3083,29 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	return level;
 }
 
+int kvm_mmu_max_slot_mapping_level(const struct kvm_memory_slot *slot,
+				   gfn_t gfn, int max_level)
+{
+	struct kvm_lpage_info *linfo;
+
+	for ( ; max_level > PG_LEVEL_4K; max_level--) {
+		linfo = lpage_info_slot(gfn, slot, max_level);
+		if (!linfo->disallow_lpage)
+			break;
+	}
+	return max_level;
+}
+
 int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn,
 			      int max_level)
 {
-	struct kvm_lpage_info *linfo;
 	int host_level;
 
 	max_level = min(max_level, max_huge_page_level);
-	for ( ; max_level > PG_LEVEL_4K; max_level--) {
-		linfo = lpage_info_slot(gfn, slot, max_level);
-		if (!linfo->disallow_lpage)
-			break;
-	}
+	max_level = kvm_mmu_max_slot_mapping_level(slot, gfn, max_level);
 
+	/* Avoid walking the host page tables if a hugepage is impossible. */
 	if (max_level == PG_LEVEL_4K)
 		return PG_LEVEL_4K;
 
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index cc58631e2336..9db7fa0b3bf9 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -328,6 +328,8 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	return r;
 }
 
+int kvm_mmu_max_slot_mapping_level(const struct kvm_memory_slot *slot,
+				   gfn_t gfn, int max_level);
 int kvm_mmu_max_mapping_level(struct kvm *kvm,
 			      const struct kvm_memory_slot *slot, gfn_t gfn,
 			      int max_level);
-- 
2.40.0.rc1.284.g88254d51c5-goog

