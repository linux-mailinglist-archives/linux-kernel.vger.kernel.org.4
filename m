Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AEE636E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiKWXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKWXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:12:21 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526DA942FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:12:17 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id a3-20020a17090a8c0300b00218bfce4c03so2113033pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lw8YVpJ4QcZaXBDWGwmxkYvUldKaoqYfJTtdfuKylU=;
        b=ddvdcMc3xKmgvJD3lQ7hmpQ9aEIKO8R/NZcLfG+Fzm+3riFXWUreazQwD3yLXCa0JR
         tIeqov/4hpP7Mha75D7lkHIRjHtdOLkA0JTypDmIKyMxYvUUSFV3Jgr8Td1CJafK3Dz7
         cFe1jO0aIBQtwDVNTJlGXJ8++Y7UBxyJKaTOf5B7Bq40rCOZ+oXUCcd0QF34qZcNraZE
         bJDrCYMudkYm1RTOr27lnoSAihsvxfVTfdec8KckYVawlD1Hfu3BSw27ZjKwxw7+dAfO
         u7PPW85RszwPiwlpSp+WnGMn1uv3gxK/HXrN3U4Ss72f/2SIno+RR3zguNqgXS0A9tMY
         kD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lw8YVpJ4QcZaXBDWGwmxkYvUldKaoqYfJTtdfuKylU=;
        b=WMn+FzFOuyUAPgpVbvUwhJHfPq/9WOCUHk11PQ9sImmDoDUpOTuKeZSKGScCc75GtN
         9Lra2UwuG08WhQj50Sdxu6HSECrJTxIVIC5YWabqTQ6qYUyIgwIK2VoGPHB2ZSsL1rdJ
         uqW9AFqwOSyk+0MxtGlRnb8sALsGkj4WN/mIpJ69X3GPWuJ9qlJ1IGn8N8WRb7NfCQet
         xutGWxMroCSP8KajYs2Xp7L/7Z58C75c1+44bLVhva2g0oB7CgtP8P9S55pJbXx+cuL/
         GE29mUwaM3AeGpMcNPHyIG0VBv3AZOdxCKexsZsmiWyGUaG6B1kCTtKRPMG/guchhedm
         XHvg==
X-Gm-Message-State: ANoB5pmMDppW9AnjfaKMMX0QLIuuOb0DbntHw+MZw8cXrdSal/5ut9Um
        293Fq7zRSVWawtU7ntP3nk40mBf9i/rW
X-Google-Smtp-Source: AA0mqf4TvJYJN94c3CdOAgOMKxBqrdXHb9FZ6HCiWB5YdccNpMOGINJeEWZHFXXD86cGXG/tTziS0GKnFyfS
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90a:df8c:b0:20a:fee1:8f69 with SMTP id
 p12-20020a17090adf8c00b0020afee18f69mr3055296pjv.0.1669245136574; Wed, 23 Nov
 2022 15:12:16 -0800 (PST)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Wed, 23 Nov 2022 23:12:06 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123231206.274392-1-mizhang@google.com>
Subject: [RFC PATCH] KVM: x86/mmu: replace BUG() with KVM_BUG() in shadow mmu
From:   Mingwei Zhang <mizhang@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nagareddy Reddy <nspreddy@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
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
only.

Cc: Nagareddy Reddy <nspreddy@google.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: David Matlack <dmatlack@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4736d7849c60..075d31b0db9c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -955,12 +955,12 @@ static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
 
 	if (!rmap_head->val) {
 		pr_err("%s: %p 0->BUG\n", __func__, spte);
-		BUG();
+		KVM_BUG();
 	} else if (!(rmap_head->val & 1)) {
 		rmap_printk("%p 1->0\n", spte);
 		if ((u64 *)rmap_head->val != spte) {
 			pr_err("%s:  %p 1->BUG\n", __func__, spte);
-			BUG();
+			KVM_BUG();
 		}
 		rmap_head->val = 0;
 	} else {
@@ -979,7 +979,7 @@ static void pte_list_remove(u64 *spte, struct kvm_rmap_head *rmap_head)
 			desc = desc->more;
 		}
 		pr_err("%s: %p many->many\n", __func__, spte);
-		BUG();
+		KVM_BUG();
 	}
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

