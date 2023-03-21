Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C426C3D57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCUWBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCUWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:01:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB75748E0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p9-20020a170902e74900b001a1c7b2e7afso4864001plf.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=TXYP/la1qhNyvVoZkTScqrgtgxD2yAawazbtnCeBxio=;
        b=g+1xhV9HsMHnKFM49waIK6sqkS2EKBFRc3TBIumBs9n9HLYewdRG78hEvTPZimgJuF
         jOZCE9/uPtqTkdpOX96ixTH0A1jj/qpMTudZtnOg2HBqXrPlFJ2vNamX2wNk3YxqMR1K
         8S+VRHbSrN3k7nQTqBoSEpcMETj0nkdITGJbmcqzjVBQlsawg5hTdDH/z6D/YbrAPIr5
         1lZh+OfD/2Poua0cWt0WCnu9A8paciTZqfS5DRH34XWsE5P8heG6DZxwSIF7wZbK+Zhx
         aa3y/2ZarGX0G4zmlREasDuUbDqvZSlQwchIVBxZCUsvAskwrf7ne9EhA3R0W8p1vX7A
         yQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXYP/la1qhNyvVoZkTScqrgtgxD2yAawazbtnCeBxio=;
        b=DqZAkdxwNQZ2v9C3Y39IeWp/PpHpt96UNfQBsNvhD+l+mc5jRa6K6P85km7ZjRTnZL
         BdMd2of/tRcFpbrraF9MiHA37J501fXABDL6XB3nD5cbGqUztQEFPAAovPp1/WOIbY/N
         gBR5bx+dtSBv58ut+zbIpn79OQocwn4Yn3v/754uN/GoBVePQkOJpdu9Olr1VhL33DaP
         VANiWujI/I80w1GhOB/vAaDl1Ia3j59KpD36hw5dpDSo621i2eKtLMH0oeUNMXlRxuXk
         Vf9iwbC2lyUfIed5o0omj7UwSlrjXdOO004miOTwoOnP+JsZDGdlZNx5/qM+jNK953Z+
         PIUA==
X-Gm-Message-State: AO0yUKVVALoN+Cj99AvPqYR1znpY0MTvjAOlYsvPV/5exk065W2hMuf1
        1elJAuIekXRixjdx5pYduQsfL2HAZZs=
X-Google-Smtp-Source: AK7set8yAJ++eaFWIiZL69K1/iFr2Dk4PnlCeEmj8UEu5lEOX0S0xMFPwLF8x1AF0Y/AYImhOvtUl9w2ZXY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:f3d5:b0:23d:2000:ccd6 with SMTP id
 ha21-20020a17090af3d500b0023d2000ccd6mr460733pjb.2.1679436042594; Tue, 21 Mar
 2023 15:00:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:19 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-12-seanjc@google.com>
Subject: [PATCH v4 11/13] KVM: x86/mmu: Remove "record_acc_track" in __tdp_mmu_set_spte()
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

Remove bool parameter "record_acc_track" from __tdp_mmu_set_spte() and
refactor the code. This variable is always set to true by its caller.

Remove single and double underscore prefix from tdp_mmu_set_spte()
related APIs:
1. Change __tdp_mmu_set_spte() to tdp_mmu_set_spte()
2. Change _tdp_mmu_set_spte() to tdp_mmu_iter_set_spte()

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 51 +++++++++++++-------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index cdfb67ef5800..9649e0fe4302 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -695,7 +695,7 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 
 
 /*
- * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
+ * tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
  * @kvm:	      KVM instance
  * @as_id:	      Address space ID, i.e. regular vs. SMM
  * @sptep:	      Pointer to the SPTE
@@ -703,18 +703,12 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
  * @new_spte:	      The new value that will be set for the SPTE
  * @gfn:	      The base GFN that was (or will be) mapped by the SPTE
  * @level:	      The level _containing_ the SPTE (its parent PT's level)
- * @record_acc_track: Notify the MM subsystem of changes to the accessed state
- *		      of the page. Should be set unless handling an MMU
- *		      notifier for access tracking. Leaving record_acc_track
- *		      unset in that case prevents page accesses from being
- *		      double counted.
  *
  * Returns the old SPTE value, which _may_ be different than @old_spte if the
  * SPTE had voldatile bits.
  */
-static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
-			      u64 old_spte, u64 new_spte, gfn_t gfn, int level,
-			      bool record_acc_track)
+static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
+			    u64 old_spte, u64 new_spte, gfn_t gfn, int level)
 {
 	lockdep_assert_held_write(&kvm->mmu_lock);
 
@@ -730,30 +724,19 @@ static u64 __tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 	old_spte = kvm_tdp_mmu_write_spte(sptep, old_spte, new_spte, level);
 
 	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
-
-	if (record_acc_track)
-		handle_changed_spte_acc_track(old_spte, new_spte, level);
-
+	handle_changed_spte_acc_track(old_spte, new_spte, level);
 	handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte, new_spte,
 				      level);
 	return old_spte;
 }
 
-static inline void _tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
-				     u64 new_spte, bool record_acc_track)
+static inline void tdp_mmu_iter_set_spte(struct kvm *kvm, struct tdp_iter *iter,
+					 u64 new_spte)
 {
 	WARN_ON_ONCE(iter->yielded);
-
-	iter->old_spte = __tdp_mmu_set_spte(kvm, iter->as_id, iter->sptep,
-					    iter->old_spte, new_spte,
-					    iter->gfn, iter->level,
-					    record_acc_track);
-}
-
-static inline void tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
-				    u64 new_spte)
-{
-	_tdp_mmu_set_spte(kvm, iter, new_spte, true);
+	iter->old_spte = tdp_mmu_set_spte(kvm, iter->as_id, iter->sptep,
+					  iter->old_spte, new_spte,
+					  iter->gfn, iter->level);
 }
 
 #define tdp_root_for_each_pte(_iter, _root, _start, _end) \
@@ -845,7 +828,7 @@ static void __tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
 			continue;
 
 		if (!shared)
-			tdp_mmu_set_spte(kvm, &iter, 0);
+			tdp_mmu_iter_set_spte(kvm, &iter, 0);
 		else if (tdp_mmu_set_spte_atomic(kvm, &iter, 0))
 			goto retry;
 	}
@@ -902,8 +885,8 @@ bool kvm_tdp_mmu_zap_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
 	if (WARN_ON_ONCE(!is_shadow_present_pte(old_spte)))
 		return false;
 
-	__tdp_mmu_set_spte(kvm, kvm_mmu_page_as_id(sp), sp->ptep, old_spte, 0,
-			   sp->gfn, sp->role.level + 1, true);
+	tdp_mmu_set_spte(kvm, kvm_mmu_page_as_id(sp), sp->ptep, old_spte, 0,
+			 sp->gfn, sp->role.level + 1);
 
 	return true;
 }
@@ -937,7 +920,7 @@ static bool tdp_mmu_zap_leafs(struct kvm *kvm, struct kvm_mmu_page *root,
 		    !is_last_spte(iter.old_spte, iter.level))
 			continue;
 
-		tdp_mmu_set_spte(kvm, &iter, 0);
+		tdp_mmu_iter_set_spte(kvm, &iter, 0);
 		flush = true;
 	}
 
@@ -1107,7 +1090,7 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
 		if (ret)
 			return ret;
 	} else {
-		tdp_mmu_set_spte(kvm, iter, spte);
+		tdp_mmu_iter_set_spte(kvm, iter, spte);
 	}
 
 	tdp_account_mmu_page(kvm, sp);
@@ -1314,13 +1297,13 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
 	 * invariant that the PFN of a present * leaf SPTE can never change.
 	 * See __handle_changed_spte().
 	 */
-	tdp_mmu_set_spte(kvm, iter, 0);
+	tdp_mmu_iter_set_spte(kvm, iter, 0);
 
 	if (!pte_write(range->pte)) {
 		new_spte = kvm_mmu_changed_pte_notifier_make_spte(iter->old_spte,
 								  pte_pfn(range->pte));
 
-		tdp_mmu_set_spte(kvm, iter, new_spte);
+		tdp_mmu_iter_set_spte(kvm, iter, new_spte);
 	}
 
 	return true;
@@ -1805,7 +1788,7 @@ static bool write_protect_gfn(struct kvm *kvm, struct kvm_mmu_page *root,
 		if (new_spte == iter.old_spte)
 			break;
 
-		tdp_mmu_set_spte(kvm, &iter, new_spte);
+		tdp_mmu_iter_set_spte(kvm, &iter, new_spte);
 		spte_set = true;
 	}
 
-- 
2.40.0.rc2.332.ga46443480c-goog

