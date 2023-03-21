Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B036C3D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCUWBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCUWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:01:16 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DEC52932
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:45 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id a6-20020aa795a6000000b006262c174d64so6018247pfk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UukHHmzYp3jbnwpYv/v1FsmAZ+NnOZSwMuugHGlP2/0=;
        b=s5j9K7qbU+HX10Fei6AhiU+MmRATSG8GykyvbfcYCD9RB241fVkf4CqaD/UO08AAq3
         BOl/Btyaj9RgY5Pq5j8tWUvWGV6xvVBzjS0mTP9MTax0P8AGs2IHNQXA5GVHy5pPAT/v
         x9tU0H2UAOpK1ALOYklmBkfpr933WgEQue8YVsn8c6BlGL6vkm174eLAnXG169QPN1s3
         +765bkk3eL6Q1KoIveG+LTGa3v5P6CG3Q9wZT7wExdepi5nbokgAQEf26OjPOsTgjWzC
         ET/aNTrfHGr/2RV4LUrERXQFyJct2jvNf2pEUcUHdoaZEC4M5qLGGewQO9WhK92P/GFJ
         887w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436044;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UukHHmzYp3jbnwpYv/v1FsmAZ+NnOZSwMuugHGlP2/0=;
        b=qCJwlxEPLH4HYuxxyg44AX6HCFq8YwtFmoa0GL5KXv7KBhDD6yuiwSLsL/489J1xad
         KFRZUQ5N9FglTBUTn5248YaIhw9c8Ha0+KiYFP/NP6qlIMAAv0m59rnMD+rwQoWbOVyq
         2ZK4AscfFq05Bb5TbZCyZXqMgHpWBq6gCFjHOcYuwvWj3m86HYpGX9/XAoE3aZKhgIDO
         mZL0xjbwqGgXcNCc8jOk9TSRWNNipKlhqlzJ4c74ohUzpHGmpQaOYkCIkOlN3e6eA/EZ
         Xvr6vYxXaodbfzOMhymWH5Twk8nAspuD87V9y2KjDHRUspdrhHZ+VRlnb+oCsbxlVaNg
         d6GA==
X-Gm-Message-State: AO0yUKUA7dTShsIEtKnO9aPtR0FOPm3CYpng0xbXoGOOmKkMDxIx5MGg
        cGzddeMKfzfZuNkFUUX3NY1Iv78Dwb8=
X-Google-Smtp-Source: AK7set89NMM9G0JJ9iyRC4WIoVVZdGhkYAS++VuqnjYtGk8PQol09OlBuCWxxzLc4nep21LFiv8QxpuHaiI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7408:b0:23f:695a:1355 with SMTP id
 a8-20020a17090a740800b0023f695a1355mr436972pjg.5.1679436044297; Tue, 21 Mar
 2023 15:00:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:20 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-13-seanjc@google.com>
Subject: [PATCH v4 12/13] KVM: x86/mmu: Remove handle_changed_spte_dirty_log()
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

Remove handle_changed_spte_dirty_log() as there is no code flow which
sets 4KiB SPTE writable and hit this path. This function marks the page
dirty in a memslot only if new SPTE is 4KiB in size and writable.

Current users of handle_changed_spte_dirty_log() are:
1. set_spte_gfn() - Create only non writable SPTEs.
2. write_protect_gfn() - Change an SPTE to non writable.
3. zap leaf and roots APIs - Everything is 0.
4. handle_removed_pt() - Sets SPTEs to REMOVED_SPTE
5. tdp_mmu_link_sp() - Makes non leaf SPTEs.

There is also no path which creates a writable 4KiB without going
through make_spte() and this functions takes care of marking SPTE dirty
in the memslot if it is PT_WRITABLE.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
[sean: add blurb to __handle_changed_spte()'s comment]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 9649e0fe4302..e8ee49b6da5b 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -345,24 +345,6 @@ static void handle_changed_spte_acc_track(u64 old_spte, u64 new_spte, int level)
 		kvm_set_pfn_accessed(spte_to_pfn(old_spte));
 }
 
-static void handle_changed_spte_dirty_log(struct kvm *kvm, int as_id, gfn_t gfn,
-					  u64 old_spte, u64 new_spte, int level)
-{
-	bool pfn_changed;
-	struct kvm_memory_slot *slot;
-
-	if (level > PG_LEVEL_4K)
-		return;
-
-	pfn_changed = spte_to_pfn(old_spte) != spte_to_pfn(new_spte);
-
-	if ((!is_writable_pte(old_spte) || pfn_changed) &&
-	    is_writable_pte(new_spte)) {
-		slot = __gfn_to_memslot(__kvm_memslots(kvm, as_id), gfn);
-		mark_page_dirty_in_slot(kvm, slot, gfn);
-	}
-}
-
 static void tdp_account_mmu_page(struct kvm *kvm, struct kvm_mmu_page *sp)
 {
 	kvm_account_pgtable_pages((void *)sp->spt, +1);
@@ -516,7 +498,9 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  *	    the MMU lock and the operation must synchronize with other
  *	    threads that might be modifying SPTEs.
  *
- * Handle bookkeeping that might result from the modification of a SPTE.
+ * Handle bookkeeping that might result from the modification of a SPTE.  Note,
+ * dirty logging updates are handled in common code, not here (see make_spte()
+ * and fast_pf_fix_direct_spte()).
  */
 static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				  u64 old_spte, u64 new_spte, int level,
@@ -613,8 +597,6 @@ static void handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level,
 			      shared);
 	handle_changed_spte_acc_track(old_spte, new_spte, level);
-	handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte,
-				      new_spte, level);
 }
 
 /*
@@ -725,8 +707,6 @@ static u64 tdp_mmu_set_spte(struct kvm *kvm, int as_id, tdp_ptep_t sptep,
 
 	__handle_changed_spte(kvm, as_id, gfn, old_spte, new_spte, level, false);
 	handle_changed_spte_acc_track(old_spte, new_spte, level);
-	handle_changed_spte_dirty_log(kvm, as_id, gfn, old_spte, new_spte,
-				      level);
 	return old_spte;
 }
 
-- 
2.40.0.rc2.332.ga46443480c-goog

