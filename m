Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E016B571A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCKAr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjCKArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:47:15 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7AA13E082
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:44 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id s3-20020a632c03000000b0050300a8089aso1635096pgs.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UlahK4EgI3F4LmN6mIFBVS1s8jM35sN7dKW8KqGf28I=;
        b=XYfJ0XzSMcF3E1kvv8pyJPBUY1oOTCxtwnj2AeqySuQR1ZfvAKc1SW9iPHhnHJe3Gi
         XcutjwG0mgZaRNsN46psXVVdRMFDBq81EReYNPudybB7KQX35AkogMA4TCUr/VbuZvJx
         /Hku8ULfZNkx8JFRFzRKqCm+FH1VdoYEXygr0lWSRV08+fWnuTiTlMkxKw1BJvqob1GB
         3avYN4po4ipfmpO5vp3/rDjXCawszeDN6tP4Hn6j/nGQ5Mn2rLnkV2CSZ7GHd9sNhr7/
         o+PPXOXQsCoX2fQ9HR12St5LPalBRdIIsvavz0RQtcWzQFysV3ImhfIBkvx24fD+16hu
         zjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlahK4EgI3F4LmN6mIFBVS1s8jM35sN7dKW8KqGf28I=;
        b=lbfUSBd2XU1yoW/xbjpd2TlA91LBYNBxR3yV0wfJ5RMC6uswoVRtQWm0mHwHaLTklX
         r0T9n2Co3kNUUcz2l5M0adB886aElhHGLiJzqJmHwOWP2WLPHom4DpT+pZofhugVX6xI
         K+58q5lBQ71UryUZLZcPC5nEm+5IlqZnKsyULCSyu5yBg5W3IC/NNCaru2V/LqPp7x2u
         dx88fZsZ9AcDA/ZVZRMmDrGQYWzRPl1UuZlPxER8JWF5KKf/HYLo1OzR1cG3I+KZA97x
         UsoWxUTWIS2yzNZ1GJsU0epPBsCqi8oXNXR3Vrym59zUKSAM10Uy9+tG5y6tMHTvwEnE
         07Hw==
X-Gm-Message-State: AO0yUKUoJdMhj4Xx9bYaHsyQ3l8aK1sIf3nJRtYN6y/XiBC0uZkvdIuU
        TIfp/gJykK1e8qgQQfWIPIWpjA0USAE=
X-Google-Smtp-Source: AK7set8HwFPz9V2UekB+yM7oEJ6o6fajmdcDwtPEGxNDv9yOe0tK/NfCJPiB1RiF4p0C3VRjGYZd8q16rTg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:a512:0:b0:593:fcfb:208b with SMTP id
 v18-20020a62a512000000b00593fcfb208bmr11074429pfm.3.1678495602725; Fri, 10
 Mar 2023 16:46:42 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:08 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-12-seanjc@google.com>
Subject: [PATCH v3 11/21] KVM: selftests: Print out failing MSR and value in vcpu_set_msr()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Reimplement vcpu_set_msr() as a macro and pretty print the failing MSR
(when possible) and the value if KVM_SET_MSRS fails instead of using the
using the standard KVM_IOCTL_ERROR().  KVM_SET_MSRS is somewhat odd in
that it returns the index of the last successful write, i.e. will be
'0' on failure barring an entirely different KVM bug.  And for writing
MSRs, the MSR being written and the value being written are almost always
relevant to the failure, i.e. just saying "failed!" doesn't help debug.

Place the string goo in a separate macro in anticipation of using it to
further expand MSR testing.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 53ffa43c90db..26c8e202a956 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -928,14 +928,30 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
 
-static inline void vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index,
-				uint64_t msr_value)
-{
-	int r = _vcpu_set_msr(vcpu, msr_index, msr_value);
-
-	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_SET_MSRS, r));
-}
+/*
+ * Assert on an MSR access(es) and pretty print the MSR name when possible.
+ * Note, the caller provides the stringified name so that the name of macro is
+ * printed, not the value the macro resolves to (due to macro expansion).
+ */
+#define TEST_ASSERT_MSR(cond, fmt, msr, str, args...)				\
+do {										\
+	if (__builtin_constant_p(msr)) {					\
+		TEST_ASSERT(cond, fmt, str, args);				\
+	} else if (!(cond)) {							\
+		char buf[16];							\
+										\
+		snprintf(buf, sizeof(buf), "MSR 0x%x", msr);			\
+		TEST_ASSERT(cond, fmt, buf, args);				\
+	}									\
+} while (0)
 
+#define vcpu_set_msr(vcpu, msr, val)							\
+do {											\
+	uint64_t v = val;								\
+											\
+	TEST_ASSERT_MSR(_vcpu_set_msr(vcpu, msr, v) == 1,				\
+			"KVM_SET_MSRS failed on %s, value = 0x%lx", msr, #msr, v);	\
+} while (0)
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 bool vm_is_unrestricted_guest(struct kvm_vm *vm);
-- 
2.40.0.rc1.284.g88254d51c5-goog

