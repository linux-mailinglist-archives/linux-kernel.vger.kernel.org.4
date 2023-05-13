Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6897012BD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjELXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241009AbjELXvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:43 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E797EF1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:55 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-643a9203dc2so5875555b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935454; x=1686527454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=839Y/eRG8ebRjLuqi9Xn56iowlHDe8a0i2iqlO12mSc=;
        b=Gxu8ziQlfAlImSLHaPweZ+D4csyuikvy5ZGANEpKqYFv+GCEw8rBzatdOyzXvcrFlk
         khDmOjPXJOscRRcJ4R+I7+n+jt7SDqmKLS4p0LlsbDkXhrOtZ4PHBO0Rff66Sy3Y3f+p
         V1wIP9Im3C+Xh84d9suaPmW5FwvG0SU/hUV5/Xa8QTxMqPUUWw2DMi61KC6OBUQzTCzO
         V6Z3U+WAy2Iwz+uaQ0bRYQc/w/wAmnOI5SdSSLBKSltWgM7Ke2x6I8L34N+CpoPsx6fL
         yFor3M/l6L/c2FCl5sOOU2wqq/vQ1ehh17O8fWMXxmTnGYrJ0meqSa5rl9neC+fERQ0Y
         VzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935454; x=1686527454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=839Y/eRG8ebRjLuqi9Xn56iowlHDe8a0i2iqlO12mSc=;
        b=Cwxu78ukfuuKSoAow2+szFE79j2WMJ34qJ872cSfVHmoVj8fbp7igXdn2sNpofKaW6
         Mkwb6lmXpiiDd+GpiByMh/w3crh9lnBq/edndIYLFlBybrBfpRZ4ynPH2yqs9aO22Abd
         By+9X/CB04WMJUbW5FTsvL4I6Jbcsn8hb76XcPES7qFqvtB1X2v1iDQZZlX5JUVeRB/V
         M5Hg8qtmUJsHknMwrtrdIRl/tA5rCyCWawK8E68QoHcjrJGm4iZDTYkmNptaISrinfgg
         mi0OSEcz/3QYEwmVTnz/LdtK9z0MZIIMqY7+bAFAMLsfAiLL7FjwUiCKUwHQ5Bfaf9oN
         b9jQ==
X-Gm-Message-State: AC+VfDz6D6Nv00gFXji5vxeLGu+YT9eGpOQW2LR9c9JhLa9ElmA6hfSQ
        Ye6nG5yjvphbX/kC0t9y6ALkUDS7BYc=
X-Google-Smtp-Source: ACHHUZ4mHtECRrnVPp35jcjFcnGMuNIxlAKsj1ry/R/WdzRVKO2if/+73EmH3/wtXXem7OK9+uq0pdG6t2w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:be7:b0:641:31b1:e781 with SMTP id
 x39-20020a056a000be700b0064131b1e781mr7243898pfu.5.1683935453980; Fri, 12 May
 2023 16:50:53 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:21 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-14-seanjc@google.com>
Subject: [PATCH v3 13/18] x86/virt: KVM: Open code cpu_has_svm() into kvm_is_svm_supported()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fold the guts of cpu_has_svm() into kvm_is_svm_supported(), its sole
remaining user.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 28 ----------------------------
 arch/x86/kvm/svm/svm.c         | 11 ++++++++---
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index be50c414efe4..632575e257d8 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -22,35 +22,7 @@
 /*
  * SVM functions:
  */
-
-/** Check if the CPU has SVM support
- *
- * You can use the 'msg' arg to get a message describing the problem,
- * if the function returns zero. Simply pass NULL if you are not interested
- * on the messages; gcc should take care of not generating code for
- * the messages on this case.
- */
-static inline int cpu_has_svm(const char **msg)
-{
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
-		if (msg)
-			*msg = "not amd or hygon";
-		return 0;
-	}
-
-	if (!boot_cpu_has(X86_FEATURE_SVM)) {
-		if (msg)
-			*msg = "svm not available";
-		return 0;
-	}
-	return 1;
-}
-
-
 /** Disable SVM on the current CPU
- *
- * You should call this only if cpu_has_svm() returned true.
  */
 static inline void cpu_svm_disable(void)
 {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0f0d04900bf2..b347173b4e29 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -526,11 +526,16 @@ static void svm_init_osvw(struct kvm_vcpu *vcpu)
 static bool kvm_is_svm_supported(void)
 {
 	int cpu = raw_smp_processor_id();
-	const char *msg;
 	u64 vm_cr;
 
-	if (!cpu_has_svm(&msg)) {
-		pr_err("SVM not supported by CPU %d, %s\n", cpu, msg);
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
+		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
+		return false;
+	}
+
+	if (!boot_cpu_has(X86_FEATURE_SVM)) {
+		pr_err("SVM not supported by CPU %d\n", cpu);
 		return false;
 	}
 
-- 
2.40.1.606.ga4b1b128d6-goog

