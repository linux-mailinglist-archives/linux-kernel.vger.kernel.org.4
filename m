Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FAF6C3D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjCUWAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjCUWAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:00:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8B0E1AF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:34 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 16-20020a056a00071000b00627e9b4871eso4514615pfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679436034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=HzfCgHSGwiR4AoBi0+VDzgdM9euLusEu5CGS2HK69v4=;
        b=Yu7X9URVZznsAeySx9Qhfzav+zZs4b9qm/SerUUpFioJW+7M+vcfPplgBY/xdz0XvA
         NMhdVwoUnZSerYrGDyxjtElMeU8AVF7JLm2h04tQ6ICADq8sXuJIclZdZmsRXOep9o7W
         75z5DUQbLCLtn3+9NSfYpE3B0LZhqMQ6mHWTb0Wo/mGw+RQpjmHhkfkeh7wFPoHtLlmy
         hoj8lgSAu+/x1iIuwxYOx9sGGPKkUDKyIipDDIh13JeAbgnHnE960vttauivNTcCXTY1
         Ek17Bwty+k6JHhE5OvYK3eKVdHS6gEy8KIi7JdvPS0zWoYPUO2NjQsf6GCwC/N2ws4VS
         rhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzfCgHSGwiR4AoBi0+VDzgdM9euLusEu5CGS2HK69v4=;
        b=3qR2FG7Dcf8JbUELztwDhcy8MIYsheaTBv6hJFD5lAZLNHBGMAE7EKo6gLgsR0CPeN
         8TQhLr1ibspsGhkewN5JsPJnmZ8BVhBqhrGnWj+ztsZg26SVVIsFZmjiGAXkwJk1g7FL
         k+DRb/eAcxGMLdsV8y2E7CPLf6/lDJzsdxetzfJZK0w4varh4+Br1n6bQsfxTpslr/4T
         g0dUQOIip+ijjdn2I2PW9SEBva9Iab3W7nyNi7qQHaqtIRQmorHeneleXFDypSLyM3NS
         fa/+fGiz4n2ibFokB+YObKab7yI2l4vbcp6jRMrR/THfX1JPhj4slo778TfrvuNu5oda
         Psow==
X-Gm-Message-State: AO0yUKU6Lfnu9tKMGUGHEcKHzgoIt2r7TdcwWPXeR5kRCO1cKPkZugbM
        UeMm4k7M7sVOvH5nI/a5DGn57sPYl1o=
X-Google-Smtp-Source: AK7set/2qMBQoItgnF2UfGuWjnb/SN0i6Ilhs0VHre6SWbR31nyde30w38bk+RZLr+phG73CUYuyOzmTwxQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2283:b0:23b:446b:bbfd with SMTP id
 kx3-20020a17090b228300b0023b446bbbfdmr466592pjb.1.1679436034138; Tue, 21 Mar
 2023 15:00:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Mar 2023 15:00:14 -0700
In-Reply-To: <20230321220021.2119033-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230321220021.2119033-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230321220021.2119033-7-seanjc@google.com>
Subject: [PATCH v4 06/13] KVM: x86/mmu: Bypass __handle_changed_spte() when
 clearing TDP MMU dirty bits
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

Drop everything except marking the PFN dirty and the relevant tracepoint
parts of __handle_changed_spte() when clearing the dirty status of gfns in
the TDP MMU.  Clearing only the Dirty (or Writable) bit doesn't affect
the SPTEs shadow-present status, whether or not the SPTE is a leaf, or
change the SPTE's PFN.  I.e. other than marking the PFN dirty, none of the
functional updates handled by __handle_changed_spte() are relevant.

Losing __handle_changed_spte()'s sanity checks does mean that a bug could
theoretical go unnoticed, but that scenario is extremely unlikely, e.g.
would effectively require a misconfigured or a locking bug elsewhere.

Opportunistically remove a comment blurb from __handle_changed_spte()
about all modifications to TDP MMU SPTEs needing to invoke said function,
that "rule" hasn't been true since fast page fault support was added for
the TDP MMU (and perhaps even before).

Tested on a VM (160 vCPUs, 160 GB memory) and found that performance of
clear dirty log stage improved by ~40% in dirty_log_perf_test (with the
full optimization applied).

Before optimization:
--------------------
Iteration 1 clear dirty log time: 3.638543593s
Iteration 2 clear dirty log time: 3.145032742s
Iteration 3 clear dirty log time: 3.142340358s
Clear dirty log over 3 iterations took 9.925916693s. (Avg 3.308638897s/iteration)

After optimization:
-------------------
Iteration 1 clear dirty log time: 2.318988110s
Iteration 2 clear dirty log time: 1.794470164s
Iteration 3 clear dirty log time: 1.791668628s
Clear dirty log over 3 iterations took 5.905126902s. (Avg 1.968375634s/iteration)

Link: https://lore.kernel.org/all/Y9hXmz%2FnDOr1hQal@google.com
Signed-off-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
[sean: split the switch to atomic-AND to a separate patch]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 950c5d23ecee..467931c43968 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -517,7 +517,6 @@ static void handle_removed_pt(struct kvm *kvm, tdp_ptep_t pt, bool shared)
  *	    threads that might be modifying SPTEs.
  *
  * Handle bookkeeping that might result from the modification of a SPTE.
- * This function must be called for all TDP SPTE modifications.
  */
 static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 				  u64 old_spte, u64 new_spte, int level,
@@ -1689,8 +1688,10 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 							iter.old_spte, dbit,
 							iter.level);
 
-		__handle_changed_spte(kvm, iter.as_id, iter.gfn, iter.old_spte,
-				      iter.old_spte & ~dbit, iter.level, false);
+		trace_kvm_tdp_mmu_spte_changed(iter.as_id, iter.gfn, iter.level,
+					       iter.old_spte,
+					       iter.old_spte & ~dbit);
+		kvm_set_pfn_dirty(spte_to_pfn(iter.old_spte));
 	}
 
 	rcu_read_unlock();
-- 
2.40.0.rc2.332.ga46443480c-goog

