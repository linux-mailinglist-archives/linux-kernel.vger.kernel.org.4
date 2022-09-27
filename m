Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B19F5EB642
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiI0A1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiI0A1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:27:21 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08FA1007
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:27:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id g15-20020aa7874f000000b0053e8b9630c7so4848583pfo.19
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=9LlUllMuSCCNuvy8nXr0WUw6cjOfzqrjmVjCju9k9xE=;
        b=ib28nrR8JpjsrppII6G9v/dkNoieDbqAEGPjxFDDXpZ6X2dzYHAQgGQAGNeZsoN0E+
         QivbBd1z3z72bEgc4ZrqGDiqM5n8tCaBCejTC384XUmG+MXYCSNsPSCMPasXavv9I9ju
         7UxNYQXgwEHcdbOixKGvEN8J1at2ARMARli6/3VS5Vquhqwyf0HYlB/5vJ784LvBoNBt
         r0Ue8vNvTZXN6cpds0UdPc0Wjh7tN2e6knqL4lQQjuPByoh94Hfrp/pylM5QAgzvOgMi
         uPw2vyCKgVaO1z0v7Ynf3hRhgS3OJcG5bElgEhT0Y4BPuktbEk4Rdt7sJcnwJBSLPTZl
         VxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=9LlUllMuSCCNuvy8nXr0WUw6cjOfzqrjmVjCju9k9xE=;
        b=r4AaDxeXryYu5Nj0HAHnkaOh2lCGP0wx5u1vGKC/63qgcgTKQxzmJITgj9O2vOybP7
         qF+fdTQwWt1YOuiLkxDKMsjyLil+8VdQ4U367UQxSNzfXYsG66Yjmm2Umqmb98YSKjwx
         Y/f7OLphlycQ63yjHDsdQUIjGNzC1v6fRyqoYS1H85MUZIaxj0hXjPaoEZ09KXmTjw9k
         W5zp8bMWYd8O6BrhO2TToZ6svCFbZceW7Lp4IvDFjMvMk8UaVP5pMmeYquynxu9QR6Cb
         zBpTp6dl9bObR9QuXhWKoMy8Ycmt+OzLP2/EIFz5aFjb/OLgWrzA9W4l6kEpk4/kM/uJ
         I9xA==
X-Gm-Message-State: ACrzQf1rrMqhzrWaCCoc2Qr0uT7n+dXNxeSqa7aqO+8IrisBC0kAupHw
        8pTrAmGvN9ZhOSMlfZ2C5HX3+YS9bfPd
X-Google-Smtp-Source: AMsMyM7beut503w2dGOmNLcBHb2fmbJhHsJKZpriWBWPTuRptWckWaynxJFBeEmIGXr7bX7q5SvnLReY33W1
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a05:6a00:1342:b0:545:4d30:eecb with SMTP
 id k2-20020a056a00134200b005454d30eecbmr25908814pfu.69.1664238440461; Mon, 26
 Sep 2022 17:27:20 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue, 27 Sep 2022 00:27:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220927002715.2142353-1-mizhang@google.com>
Subject: [PATCH] KVM: arm64: Cleanup the __get_fault_info() to take out the
 code that validates HPFAR
From:   Mingwei Zhang <mizhang@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
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

Cleanup __get_fault_info() to take out the code that checks HPFAR. The
conditions in __get_fault_info() that checks if HPFAR contains a valid IPA
is slightly messy in that several conditions are written within one IF
statement acrossing multiple lines and are connected with different logical
operators. Among them, some conditions come from ARM Spec, while others
come from CPU erratum. This makes the code hard to read and difficult to
extend.

So, cleanup the function to improve the readability. In particular,
explicitly specify each condition separately within a newly created inline
function.

No functional changes are intended.

Suggested-by: Oliver Upton <oupton@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/arm64/kvm/hyp/include/hyp/fault.h | 36 ++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
index 1b8a2dcd712f..4575500d26ff 100644
--- a/arch/arm64/kvm/hyp/include/hyp/fault.h
+++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
@@ -41,12 +41,6 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	return true;
 }
 
-static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
-{
-	u64 hpfar, far;
-
-	far = read_sysreg_el2(SYS_FAR);
-
 	/*
 	 * The HPFAR can be invalid if the stage 2 fault did not
 	 * happen during a stage 1 page table walk (the ESR_EL2.S1PTW
@@ -58,14 +52,30 @@ static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
 	 * permission fault or the errata workaround is enabled, we
 	 * resolve the IPA using the AT instruction.
 	 */
-	if (!(esr & ESR_ELx_S1PTW) &&
-	    (cpus_have_final_cap(ARM64_WORKAROUND_834220) ||
-	     (esr & ESR_ELx_FSC_TYPE) == FSC_PERM)) {
-		if (!__translate_far_to_hpfar(far, &hpfar))
-			return false;
-	} else {
+static inline bool __hpfar_is_valid(u64 esr)
+{
+	if (esr & ESR_ELx_S1PTW)
+		return true;
+
+	if ((esr & ESR_ELx_FSC_TYPE) == FSC_PERM)
+		return false;
+
+	if (cpus_have_final_cap(ARM64_WORKAROUND_834220))
+		return false;
+
+	return true;
+}
+
+static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
+{
+	u64 hpfar, far;
+
+	far = read_sysreg_el2(SYS_FAR);
+
+	if (!__hpfar_is_valid(esr) && !__translate_far_to_hpfar(far, &hpfar))
+		return false;
+	else
 		hpfar = read_sysreg(hpfar_el2);
-	}
 
 	fault->far_el2 = far;
 	fault->hpfar_el2 = hpfar;

base-commit: c59fb127583869350256656b7ed848c398bef879
-- 
2.37.3.998.g577e59143f-goog

