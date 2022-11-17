Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5517262CF80
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiKQAYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbiKQAYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:24:01 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA28627C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:24:00 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v10-20020a17090a7c0a00b00215deac75b4so226248pjf.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=OQIty0gkGvimYsfAtcoPy8df73fwY+kl22+jSnaHr3Q=;
        b=XawF3gkr8CSKZ24fVYfQH/likVJmqrI6J+VgfY0e5oCqzv9OjobeFrDLWibgksGjp1
         bpT/73ID8XYCUWtDkHG2HllTtEz582TclewSThnNE0l3c5yF0jvFHZ1/ZL/wudSFnfNc
         22czahecA+4YL4y5BIk2STkzJ4Sl4F0uiU6ADlDXxHmn4GtTD2LizNnfounT0TGHV1ul
         /PifA+5TNyMgrcAklqK6NQw2i1wpsS5JW7doMrokg2FmWTpQJbyYBuHmTEcGBLiW9ITd
         7j6WcKeXgdmwApf4zSyXL5jmPW52XoIa3JdjF+0UF72NtCpSP+95c3KKIAP0X74sDOd8
         MIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OQIty0gkGvimYsfAtcoPy8df73fwY+kl22+jSnaHr3Q=;
        b=6csuKWjYzXG6UOEy7wQWRLlXe+IpgqQ5h4Na+xm0hb1IDaE7j46y4dXeAh1O2imtng
         XvjxkkVmb5MD1G6Y2Skj4MUDY3nX0Di4rusUIwRviwxu5VSvicPuQTt+3mViYsg8PQ86
         RdbQL/7N57X7gKRXKvNP742HhMfSYkLASttoOqRi41P/qEp4LG8yMePy/RDnNxpSgRqP
         9/ezDVn/l2C0iwqa++ImyEqWs/kp7sewfqEmgJVQM5P1uN2v1cjO3cEJNbLY4mhcH28S
         Rx1bg1jx40+f8lT/spGr1vg645h1D7TfIy3cCwOUE7ViGkQ080xQnphLggo+YSa6+dbq
         5cBA==
X-Gm-Message-State: ANoB5pmEDwNkfTfWrYrfetMdZQwFCjGYeMCES/ubzyjkH/CiwDkZC+Ed
        M/Ej0t5VDcVVnNxb1Mnf22FC2sP16fY=
X-Google-Smtp-Source: AA0mqf6UG7Saff0XvDUGklOofeYsmwntM1MGQ71SgLhPhHqsgDLhnxcroheVO1wVLxnzQCCJ1Ru+MrMvNxE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:9628:0:b0:56d:c3af:2d7f with SMTP id
 r8-20020aa79628000000b0056dc3af2d7fmr464212pfg.64.1668644639816; Wed, 16 Nov
 2022 16:23:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 17 Nov 2022 00:23:50 +0000
In-Reply-To: <20221117002350.2178351-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221117002350.2178351-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221117002350.2178351-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: arm64: selftests: Disable single-step without
 relying on ucall()
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Reiji Watanabe <reijiw@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Automatically disable single-step when the guest reaches the end of the
verified section instead of using an explicit ucall() to ask userspace to
disable single-step.  An upcoming change to implement a pool-based scheme
for ucall() will add an atomic operation (bit test and set) in the guest
ucall code, and if the compiler generate "old school" atomics, e.g.

  40e57c:       c85f7c20        ldxr    x0, [x1]
  40e580:       aa100011        orr     x17, x0, x16
  40e584:       c80ffc31        stlxr   w15, x17, [x1]
  40e588:       35ffffaf        cbnz    w15, 40e57c <__aarch64_ldset8_sync+0x1c>

the guest will hang as the local exclusive monitor is reset by eret,
i.e. the stlxr will always fail due to the VM-Exit for the debug
exception.

Link: https://lore.kernel.org/all/20221006003409.649993-8-seanjc@google.com
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/aarch64/debug-exceptions.c  | 28 ++++++++++---------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
index 91f55b45dfc7..65cd7e4f07fa 100644
--- a/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
+++ b/tools/testing/selftests/kvm/aarch64/debug-exceptions.c
@@ -241,7 +241,6 @@ static void guest_svc_handler(struct ex_regs *regs)
 
 enum single_step_op {
 	SINGLE_STEP_ENABLE = 0,
-	SINGLE_STEP_DISABLE = 1,
 };
 
 static void guest_code_ss(int test_cnt)
@@ -258,7 +257,7 @@ static void guest_code_ss(int test_cnt)
 		GUEST_SYNC(SINGLE_STEP_ENABLE);
 
 		/*
-		 * The userspace will veriry that the pc is as expected during
+		 * The userspace will verify that the pc is as expected during
 		 * single step execution between iter_ss_begin and iter_ss_end.
 		 */
 		asm volatile("iter_ss_begin:nop\n");
@@ -268,11 +267,9 @@ static void guest_code_ss(int test_cnt)
 		bvr = read_sysreg(dbgbvr0_el1);
 		wvr = read_sysreg(dbgwvr0_el1);
 
+		/* Userspace disables Single Step when the end is nigh. */
 		asm volatile("iter_ss_end:\n");
 
-		/* Disable Single Step execution */
-		GUEST_SYNC(SINGLE_STEP_DISABLE);
-
 		GUEST_ASSERT(bvr == w_bvr);
 		GUEST_ASSERT(wvr == w_wvr);
 	}
@@ -364,15 +361,12 @@ void test_single_step_from_userspace(int test_cnt)
 			TEST_ASSERT(cmd == UCALL_SYNC,
 				    "Unexpected ucall cmd 0x%lx", cmd);
 
-			if (uc.args[1] == SINGLE_STEP_ENABLE) {
-				debug.control = KVM_GUESTDBG_ENABLE |
-						KVM_GUESTDBG_SINGLESTEP;
-				ss_enable = true;
-			} else {
-				debug.control = KVM_GUESTDBG_ENABLE;
-				ss_enable = false;
-			}
+			TEST_ASSERT(uc.args[1] == SINGLE_STEP_ENABLE,
+				    "Unexpected ucall action 0x%lx", uc.args[1]);
 
+			debug.control = KVM_GUESTDBG_ENABLE |
+					KVM_GUESTDBG_SINGLESTEP;
+			ss_enable = true;
 			vcpu_guest_debug_set(vcpu, &debug);
 			continue;
 		}
@@ -385,6 +379,14 @@ void test_single_step_from_userspace(int test_cnt)
 			    "Unexpected pc 0x%lx (expected 0x%lx)",
 			    pc, test_pc);
 
+		if ((pc + 4) == (uint64_t)&iter_ss_end) {
+			test_pc = 0;
+			debug.control = KVM_GUESTDBG_ENABLE;
+			ss_enable = false;
+			vcpu_guest_debug_set(vcpu, &debug);
+			continue;
+		}
+
 		/*
 		 * If the current pc is between iter_ss_bgin and
 		 * iter_ss_end, the pc for the next KVM_EXIT_DEBUG should
-- 
2.38.1.431.g37b22c650d-goog

