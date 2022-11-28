Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF95F639E78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 01:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiK1AVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 19:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiK1AUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 19:20:53 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F0210564
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 16:20:51 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id b13-20020a056a000a8d00b0057348c50123so6960899pfl.18
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 16:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=H/d/oQocVevk4kmXKYK3OFaeIddN2VYzbRh6TtN6NXs=;
        b=RYSaeGnD1CFO5MQ+J96I9RF7NlYonxwfHL6CIt2WqTYaK4cGzpAXzP4/sMZ5U/O4kr
         Cj+72NFKKCQzdphG0akXy2FQoKO3VPj0rpsVOo4J8vDEBTh/0uCI3F0/t7+aC1/AT2l4
         vAi6tToE0VuQnxEpqDxHXgr+iP77lS5LjGWPzcAuh2zBAYlrOc50HFpjY8kZLzUBOhBM
         2RzeerZl34oU5H9OAK1wVzKUlbLkLiN6/n/Rvw0lpkCIMRekPFn59clteRzACq5L+8a0
         PomoHd6qmoAXvpSEPVv7lEgG7Hw3VuR1NofbSkd+1aiT9bwKvxFqamiWT0Bkn9cdUy3h
         HvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/d/oQocVevk4kmXKYK3OFaeIddN2VYzbRh6TtN6NXs=;
        b=Ih7crnq72mPWHbcTa5kRHDvkPtLulx2s9oYVe2zkB41+HhNn+TYo4ONKLfenxGrxcb
         FA9MmJk+08qj/pt6S05i9oAMtuOuCIoFViODHgPcLHRdWdWnB334ceVnDSxt2HKRKqoD
         19gS2RC1x8FnHlrbuh5gpObEtHGdSCBX6RXLy+flMvQkHDgty5qJVMWKyjDWHn4sVMWC
         buobNTaVfr3er2+JumrIqoh/zV/OuhBoVbuF4tuljHaqAnDHoGgJ45EcQwReDfps8HbI
         i5O2pwb76HSw/SphIRpUtneTqkDVBaX62bANWfN7TUkBFHeVc96cwukzenbOWhNM6+S4
         ej1g==
X-Gm-Message-State: ANoB5pmKzIoGS2ZMG/tv0LQlLPIqGpfcVSRl7JItS1/Jd0Y5sE2KF1/i
        DauOqlPrXX65QwjshBWY/RzQGgFKGW18
X-Google-Smtp-Source: AA0mqf70bmGE1iewDzyzKW2Oz6r4kY7XpfsCh6ywjCIT8U3GJ/+nwsDsjYSpfUOyhB+F3b06nTirEJAWU8y7
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a62:ee0f:0:b0:56c:8dbc:f83e with SMTP id
 e15-20020a62ee0f000000b0056c8dbcf83emr28797392pfi.41.1669594851357; Sun, 27
 Nov 2022 16:20:51 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Mon, 28 Nov 2022 00:20:43 +0000
In-Reply-To: <20221128002043.1555543-1-mizhang@google.com>
Mime-Version: 1.0
References: <20221128002043.1555543-1-mizhang@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221128002043.1555543-3-mizhang@google.com>
Subject: [RFC PATCH v3 2/2] KVM: x86/mmu: replace BUG() with KVM_BUG() in
 shadow mmu
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mingwei Zhang <mizhang@google.com>,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>
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

Replace BUG() in pte_list_remove() with KVM_BUG() to avoid crashing the
host. MMU bug is difficult to discover due to various racing conditions and
corner cases and thus it extremely hard to debug. The situation gets much
worse when it triggers the shutdown of a host. Host machine crash
eliminates everything including the potential clues for debugging.

From cloud computing service perspective, BUG() or BUG_ON() is probably no
longer appropriate as the host reliability is top priority. Crashing the
physical machine is almost never a good option as it eliminates innocent
VMs and cause service outage in a larger scope. Even worse, if attacker can
reliably triggers this code by diverting the control flow or corrupting the
memory, then this becomes vm-of-death attack. This is a huge attack vector
to cloud providers, as the death of one single host machine is not the end
of the story. Without manual interferences, a failed cloud job may be
dispatched to other hosts and continue host crashes until all of them are
dead.

Because of the above reasons, shrink the scope of crash to the target VM
only. KVM_BUG() and KVM_BUG_ON() requires a valid struct kvm which requires
extra plumbing. Avoid it in this version by just using
kvm_get_running_vcpu()->kvm instead.

Cc: Nagareddy Reddy <nspreddy@google.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b5a44b8f5f7b..e132d82ab4c0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -956,12 +956,12 @@ static void pte_list_remove(struct kvm *kvm, u64 *spte,
 
 	if (!rmap_head->val) {
 		pr_err("%s: %p 0->BUG\n", __func__, spte);
-		BUG();
+		KVM_BUG(true, kvm, "");
 	} else if (!(rmap_head->val & 1)) {
 		rmap_printk("%p 1->0\n", spte);
 		if ((u64 *)rmap_head->val != spte) {
 			pr_err("%s:  %p 1->BUG\n", __func__, spte);
-			BUG();
+			KVM_BUG(true, kvm, "");
 		}
 		rmap_head->val = 0;
 	} else {
@@ -980,7 +980,7 @@ static void pte_list_remove(struct kvm *kvm, u64 *spte,
 			desc = desc->more;
 		}
 		pr_err("%s: %p many->many\n", __func__, spte);
-		BUG();
+		KVM_BUG(true, kvm, "");
 	}
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

