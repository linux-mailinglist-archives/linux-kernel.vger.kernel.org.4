Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E96C3D54
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCUWAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCUWAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:00:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89F71F5E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s9-20020a634509000000b004fc1c14c9daso3940057pga.23
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=gnSD9O/lJZyBqYeNY2m7pEpV6MfgA8T7u5acuE9N9l0=;
        b=JtaOBpnozxchYgVWFwtMgv+aDGVJwKyGzpUb/zjycukt1br6dCwPcdxWCUtQUoev+7
         Jzwtxj9ovLQgpJfxJaMFKZ3y1J+az24NKn0O/lTAzAhflX2TqYRysBBsQnTpSNkS5oRO
         a6fHIGGrkCYoLXOJzMUnx3hcEUog2Fqw4cC5z6ljT8UqdmT0OLyuCnZObCt/J6WLdYOn
         AlnRaRLAm83exTiPdQsZI9iaLKkaSBkTIypHw3JYk5oIQJ5GKJ91/h2FR/f0qKam+Slj
         15Q8KyK8AVnARKNmwOjbjLpxtZyHvcF8t+EY9paR+b5s203RS7jjI95OvDF3ZQwy+Mip
         HIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnSD9O/lJZyBqYeNY2m7pEpV6MfgA8T7u5acuE9N9l0=;
        b=MR1Kj35LnU182dZAvD8s6ko0/nB61objHMtwUI3F+K456WnHuKq7HbtBkDWx2eDjfr
         b8LgW2KMPc2C4021BbHHMCR7EQiF/tjqKPpf9qtIvYX4Yx1uoSo2BhHe7gOeYWTQNl64
         eUoNZqF04knB/f3Dx08k9Ll1ZeaEHfYKu7aXaj7BEhXm9JFX5EMmFt3VHSz2XlhbfDgV
         Kpt1q6Suz+lKfHu6xVTC8+WGiwy1eKjrQrN2OQPcCYMMuX8qe5H3oeqjJPVlB8JVLptW
         Z4vY739a7clniDuu9ZW9HsapVWFZ5g+GzYW9FPNG1/5K3BJKTAmLXQ051B3ts9B3zjvB
         GHWA==
X-Gm-Message-State: AO0yUKWLpp8hSryyPaDjuTqFyeOAyyPb+7jlneR1B7+JW3i+kPohtM1H
        o/xgKSxoJol7qe/77nV95OZtzWBkFdw=
X-Google-Smtp-Source: AK7set9aqPWpa1gyyUEkGDOGHGDgAj6e8VwrKTp1VKCDuWxlbwccPOy+KMZ7Fpz1D3EUsC5Ps0BQgHxuJ7I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8bca:b0:1a1:c945:4b2c with SMTP id
 r10-20020a1709028bca00b001a1c9454b2cmr231691plo.7.1679436029272; Tue, 21 Mar
 2023 15:00:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:11 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-4-seanjc@google.com>
Subject: [PATCH v4 03/13] KVM: x86/mmu: Consolidate Dirty vs. Writable
 clearing logic in TDP MMU
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

Deduplicate the guts of the TDP MMU's clearing of dirty status by
snapshotting whether to check+clear the Dirty bit vs. the Writable bit,
which is the only difference between the two flavors of dirty tracking.

Note, kvm_ad_enabled() is just a wrapper for shadow_accessed_mask, i.e.
is constant after kvm-{intel,amd}.ko is loaded.

Link: https://lore.kernel.org/all/Yz4Qi7cn7TWTWQjj@google.com
Signed-off-by: Vipin Sharma <vipinsh@google.com>
[sean: split to separate patch, apply to dirty log, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 5a5642650c3e..b32c9ba05c89 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1607,8 +1607,8 @@ void kvm_tdp_mmu_try_split_huge_pages(struct kvm *kvm,
 static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 			   gfn_t start, gfn_t end)
 {
+	u64 dbit = kvm_ad_enabled() ? shadow_dirty_mask : PT_WRITABLE_MASK;
 	struct tdp_iter iter;
-	u64 new_spte;
 	bool spte_set = false;
 
 	rcu_read_lock();
@@ -1624,19 +1624,10 @@ static bool clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
 		MMU_WARN_ON(kvm_ad_enabled() &&
 			    spte_ad_need_write_protect(iter.old_spte));
 
-		if (!kvm_ad_enabled()) {
-			if (is_writable_pte(iter.old_spte))
-				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
-			else
-				continue;
-		} else {
-			if (iter.old_spte & shadow_dirty_mask)
-				new_spte = iter.old_spte & ~shadow_dirty_mask;
-			else
-				continue;
-		}
+		if (!(iter.old_spte & dbit))
+			continue;
 
-		if (tdp_mmu_set_spte_atomic(kvm, &iter, new_spte))
+		if (tdp_mmu_set_spte_atomic(kvm, &iter, iter.old_spte & ~dbit))
 			goto retry;
 
 		spte_set = true;
@@ -1678,8 +1669,9 @@ bool kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
 static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 				  gfn_t gfn, unsigned long mask, bool wrprot)
 {
+	u64 dbit = (wrprot || !kvm_ad_enabled()) ? PT_WRITABLE_MASK :
+						   shadow_dirty_mask;
 	struct tdp_iter iter;
-	u64 new_spte;
 
 	rcu_read_lock();
 
@@ -1697,19 +1689,10 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 
 		mask &= ~(1UL << (iter.gfn - gfn));
 
-		if (wrprot || !kvm_ad_enabled()) {
-			if (is_writable_pte(iter.old_spte))
-				new_spte = iter.old_spte & ~PT_WRITABLE_MASK;
-			else
-				continue;
-		} else {
-			if (iter.old_spte & shadow_dirty_mask)
-				new_spte = iter.old_spte & ~shadow_dirty_mask;
-			else
-				continue;
-		}
+		if (!(iter.old_spte & dbit))
+			continue;
 
-		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, new_spte);
+		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, iter.old_spte & ~dbit);
 	}
 
 	rcu_read_unlock();
-- 
2.40.0.rc2.332.ga46443480c-goog

