Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E816C3D50
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCUWAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCUWAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:00:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A562B9ED7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:31 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z31-20020a25a122000000b00b38d2b9a2e9so17504754ybh.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BlZkVbsBQRGxsE44yMzQP4FXruxJde6CtimkWJbV8J8=;
        b=smB55WpYv1jmLE5QmtjKXgdM9pRlkQKAcGwOpp/dWCOg56bnwmNXE5NUz7vGTUxqRY
         CTzd946M5ldXW05bAsz8CqOTkyTXF0BcWB0QnIIwV0JeZcEEuGklbMp55rusJcJPfOyy
         Gaz4RvJIO9o/DfSeBRgZVH87G4z1qHgkkIhY9qCKfyfpMr4t52pu2jZLF/iD25PqIe04
         2F9SWz5/lKRAWzThoQBbAF3qJVXMxENtuFIN/0YTHNFIOZxghdFJrIeANzQQAyqbChJ4
         POk8yrEtWRXqUUlcXlBwuwkuLToTJJJFtvTmAWBuQ7p2XWqVDfg69qzFkds/nIdL9S2N
         5WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436031;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlZkVbsBQRGxsE44yMzQP4FXruxJde6CtimkWJbV8J8=;
        b=zSlJbLlB5HRtLzFYcqt1GDYlypCGZTiorrc3cOE+F1O6Q4KBLq5CaHI8SprpcPlg56
         e7fzKOYOnqVwg0qwVRUnhQpMJMRJ+l2QHx68Z59rtelBuAmEwqB19oaq8+lQzNMEf8VM
         OhdLFT5yBjyupSwC2cfKDoT8VGhET5byh/AosjDOLwMYO9uXBsEVwSK8vk4A6Ub4/4Ys
         NiZas6EKtnucJITPHMOEGzcujiYHf/IQtinwP6ctE1F2KdGePAv3NUOs6nQTh87jiYwW
         +hz8VTcDYp9auOy1Xdbr5SwT3tKFnQ758/ZRPdOm2bspGOqTj5miHaPMwYflNpvGL3I2
         33Ww==
X-Gm-Message-State: AAQBX9caViCtzwJSU9SrDTE07WGejAtKi2leISbPAZ1Pmfk6lKa9SJx7
        jL2UF8oWcHGksVJPWQGKKIAk6o3M0Ns=
X-Google-Smtp-Source: AKy350aq4ai1xb1LHX7ScaJbYrRF3vWOThLimkcEkrhHJUUWQze2N0EJcxYHOh+0oMXJwWPvJWpHoCpcESk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:302:b0:b6e:d788:eba4 with SMTP id
 b2-20020a056902030200b00b6ed788eba4mr2156679ybs.6.1679436030890; Tue, 21 Mar
 2023 15:00:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:12 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-5-seanjc@google.com>
Subject: [PATCH v4 04/13] KVM: x86/mmu: Atomically clear SPTE dirty state in
 the clear-dirty-log flow
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

Optimize the clearing of dirty state in TDP MMU SPTEs by doing an
atomic-AND (on SPTEs that have volatile bits) instead of the full XCHG
that currently ends up being invoked (see kvm_tdp_mmu_write_spte()).
Clearing _only_ the bit in question will allow KVM to skip the many
irrelevant checks in __handle_changed_spte() by avoiding any collateral
damage due to the XCHG writing all SPTE bits, e.g. the XCHG could race
with fast_page_fault() setting the W-bit and the CPU setting the D-bit,
and thus incorrectly drop the CPU's D-bit update.

Link: https://lore.kernel.org/all/Y9hXmz%2FnDOr1hQal@google.com
Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
[sean: split the switch to atomic-AND to a separate patch]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_iter.h | 14 ++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 16 ++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_iter.h b/arch/x86/kvm/mmu/tdp_iter.h
index c11c5d00b2c1..fae559559a80 100644
--- a/arch/x86/kvm/mmu/tdp_iter.h
+++ b/arch/x86/kvm/mmu/tdp_iter.h
@@ -58,6 +58,20 @@ static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t sptep, u64 old_spte,
 	return old_spte;
 }
 
+static inline u64 tdp_mmu_clear_spte_bits(tdp_ptep_t sptep, u64 old_spte,
+					  u64 mask, int level)
+{
+	atomic64_t *sptep_atomic;
+
+	if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level)) {
+		sptep_atomic = (atomic64_t *)rcu_dereference(sptep);
+		return (u64)atomic64_fetch_and(~mask, sptep_atomic);
+	}
+
+	__kvm_tdp_mmu_write_spte(sptep, old_spte & ~mask);
+	return old_spte;
+}
+
 /*
  * A TDP iterator performs a pre-order walk over a TDP paging structure.
  */
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b32c9ba05c89..a70cc1dae18a 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -770,13 +770,6 @@ static inline void tdp_mmu_set_spte_no_acc_track(struct kvm *kvm,
 	_tdp_mmu_set_spte(kvm, iter, new_spte, false, true);
 }
 
-static inline void tdp_mmu_set_spte_no_dirty_log(struct kvm *kvm,
-						 struct tdp_iter *iter,
-						 u64 new_spte)
-{
-	_tdp_mmu_set_spte(kvm, iter, new_spte, true, false);
-}
-
 #define tdp_root_for_each_pte(_iter, _root, _start, _end) \
 	for_each_tdp_pte(_iter, _root, _start, _end)
 
@@ -1692,7 +1685,14 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (!(iter.old_spte & dbit))
 			continue;
 
-		tdp_mmu_set_spte_no_dirty_log(kvm, &iter, iter.old_spte & ~dbit);
+		iter.old_spte = tdp_mmu_clear_spte_bits(iter.sptep,
+							iter.old_spte, dbit,
+							iter.level);
+
+		__handle_changed_spte(kvm, iter.as_id, iter.gfn, iter.old_spte,
+				      iter.old_spte & ~dbit, iter.level, false);
+		handle_changed_spte_acc_track(iter.old_spte, iter.old_spte & ~dbit,
+					      iter.level);
 	}
 
 	rcu_read_unlock();
-- 
2.40.0.rc2.332.ga46443480c-goog

