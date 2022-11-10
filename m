Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E6962387B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiKJA5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiKJA5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:57:13 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721EA20353
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 16:57:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b006ccc0e91098so464216ybp.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 16:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BdmLOLo8ckIk/eD8WeKbjTM/d1aHn6rPzktWT2f3TMg=;
        b=nInUs4Ycp74MNj1eD35CUJaL9lY8Eyb/h/dJTD9lddbutaqGfVtOhuNKr6/aqataUf
         D+LG0Us77KMejXtXhg74og6a+QN9BvagZO3ckJPxn4UkqL3/S2Z9oDvlUyxkNBIzIO23
         R3uyrfeG60VquBerxrXE+yn8BZLDTdFyHXoSL3lVGE1mjfiHVRKqXhhZkWPDI64BCd9V
         GE1DKPPeHrX2AVw8RDWpstDiRB4R6twhE4WhGcEoF6LV9eYeNshRmLjbK8yhd4mRBtvo
         XtFih4V+i+5V5Jmkh7TuYVAQ/a7gMCWJnjGWN9ebSY2gHYfGZAs86db01pTbAyMu7W6a
         IXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdmLOLo8ckIk/eD8WeKbjTM/d1aHn6rPzktWT2f3TMg=;
        b=f4uX1WDYI8d31b+x97+iJKyRkRMbBU8abBAonIdZir5exPxvPnoFO12DonkBJx6lAg
         xBmyQPmC2J4GmtDQkEmUVuUQo+e45bP4tCLYO6K9B43R+ODZjSpwsLIlTB4MWM1CG+yg
         7ngGNGhVtCIiMo193jOYwyw8X7ZUP52V8ThNFRm9h4JqcZn+sh/8fvw4e/EqtaDRWhMi
         mPPVPXoUXQtfEKCjW4XYL2Wa5OU5MtKmtj0h+HY5dYWOgQHC6Tc/GMXG0CDQbcdRVdsp
         wQ9LljOaRX0K51lkunyvY6+1GltiRgdpkmgOClrpHEUrCIV7X8ba2kbSPrhFO4lGs2i+
         S3Pw==
X-Gm-Message-State: ACrzQf3KzDot0vj0siLpRP2v6z1VKxOzewsXSA1DR9is8dyWnBa6WyEN
        n7TAcC5L09BDMZtoIGy3LzRPYi9oToE=
X-Google-Smtp-Source: AMsMyM79BCIYl/M4CjNpTv0V3PnHIdX4gE+4yaKq6ANayIGqsadRmR8lklQDD2uxGhCoCB5HTo3KbLSmYoo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:cf4f:0:b0:6cc:5c06:ab92 with SMTP id
 f76-20020a25cf4f000000b006cc5c06ab92mr61037330ybg.295.1668041831797; Wed, 09
 Nov 2022 16:57:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 10 Nov 2022 00:57:06 +0000
In-Reply-To: <20221110005706.1064832-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221110005706.1064832-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221110005706.1064832-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Test KVM's handling of VMX's sec exec MSR
 on KVM_SET_CPUID
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>
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

Verify that KVM does, and does not, modify the allowed set of VMX's
secondary execution controls during KVM_SET_CPUID.  Historically, KVM has
modified select bits in response to guest CPUID changes to try and force
a consistent CPU model.  KVM's meddling causes problems if userspace
invokes KVM_SET_CPUID after explicitly setting the MSR, as KVM may end up
overriding a legal userspace config.

Newer, fixed KVM versions maintain the historical meddling for backwards
compatibility, but only if userspace has never set the MSR for the vCPU.
I.e. KVM transfers ownership to userspace on the first write.

Opportunistically fix some funky names in tools' definitions for a few
secondary execution controls.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  1 +
 .../selftests/kvm/include/x86_64/vmx.h        |  4 +-
 .../selftests/kvm/x86_64/vmx_msrs_test.c      | 92 +++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e8ca0d8a6a7e..d01de81fc0ed 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -101,6 +101,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_INVPCID		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 10)
 #define	X86_FEATURE_RTM			KVM_X86_CPU_FEATURE(0x7, 0, EBX, 11)
 #define	X86_FEATURE_MPX			KVM_X86_CPU_FEATURE(0x7, 0, EBX, 14)
+#define X86_FEATURE_RDSEED		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 18)
 #define	X86_FEATURE_SMAP		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 20)
 #define	X86_FEATURE_PCOMMIT		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 22)
 #define	X86_FEATURE_CLFLUSHOPT		KVM_X86_CPU_FEATURE(0x7, 0, EBX, 23)
diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
index 71b290b6469d..56c1771ba6b8 100644
--- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
@@ -61,8 +61,8 @@
 #define SECONDARY_EXEC_SHADOW_VMCS		0x00004000
 #define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
 #define SECONDARY_EXEC_ENABLE_PML		0x00020000
-#define SECONDARY_EPT_VE			0x00040000
-#define SECONDARY_ENABLE_XSAV_RESTORE		0x00100000
+#define SECONDARY_EXEC_EPT_VE			0x00040000
+#define SECONDARY_EXEC_ENABLE_XSAVES		0x00100000
 #define SECONDARY_EXEC_TSC_SCALING		0x02000000
 
 #define PIN_BASED_EXT_INTR_MASK			0x00000001
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c b/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c
index 322d561b4260..dbd60a989b28 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_msrs_test.c
@@ -12,6 +12,96 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
+static void vmx_sec_exec_assert_allowed(struct kvm_vcpu *vcpu,
+					const char *name, uint64_t ctrl)
+{
+	TEST_ASSERT(vcpu_get_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS2) & ctrl,
+		    "Expected '%s' to be allowed in sec exec controls", name);
+}
+
+static void vmx_sec_exec_assert_denied(struct kvm_vcpu *vcpu,
+				       const char *name, uint64_t ctrl)
+{
+	TEST_ASSERT(!(vcpu_get_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS2) & ctrl),
+		    "Expected '%s' to be denied in sec exec controls", name);
+}
+
+static void vmx_sec_exec_control_test(struct kvm_vcpu *vcpu,
+				      const char *name,
+				      struct kvm_x86_cpu_feature feature,
+				      uint64_t ctrl, bool kvm_owned)
+{
+	/* Allowed-1 settings are in the upper 32 bits. */
+	ctrl <<= 32;
+
+	if (!this_cpu_has(feature))
+		return;
+
+	if (kvm_owned) {
+		vcpu_set_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_allowed(vcpu, name, ctrl);
+
+		vcpu_clear_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_denied(vcpu, name, ctrl);
+
+		/* Make sure KVM is actually toggling the bit. */
+		vcpu_set_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_allowed(vcpu, name, ctrl);
+	} else {
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS2,
+			     vcpu_get_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS2) | ctrl);
+		vmx_sec_exec_assert_allowed(vcpu, name, ctrl);
+
+		vcpu_set_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_allowed(vcpu, name, ctrl);
+
+		vcpu_clear_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_allowed(vcpu, name, ctrl);
+
+		vcpu_set_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS2,
+			     vcpu_get_msr(vcpu, MSR_IA32_VMX_PROCBASED_CTLS2) & ~ctrl);
+		vmx_sec_exec_assert_denied(vcpu, name, ctrl);
+
+		vcpu_set_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_denied(vcpu, name, ctrl);
+
+		vcpu_clear_cpuid_feature(vcpu, feature);
+		vmx_sec_exec_assert_denied(vcpu, name, ctrl);
+	}
+}
+
+#define vmx_sec_exec_feature_test(vcpu, name, kvm_owned)			\
+	vmx_sec_exec_control_test(vcpu, #name, X86_FEATURE_##name,		\
+				  SECONDARY_EXEC_ENABLE_##name, kvm_owned)
+
+#define vmx_sec_exec_exiting_test(vcpu, name, kvm_owned)			\
+	vmx_sec_exec_control_test(vcpu, #name, X86_FEATURE_##name,		\
+				  SECONDARY_EXEC_##name##_EXITING, kvm_owned)
+
+static void vmx_sec_exec_controls_test(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	if (this_cpu_has(X86_FEATURE_XSAVE))
+		vcpu_set_cpuid_feature(vcpu, X86_FEATURE_XSAVE);
+
+	if (this_cpu_has(X86_FEATURE_RDPID))
+		vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_RDPID);
+
+	/*
+	 * Verify that for features KVM has historically taken control of, KVM
+	 * updates PROCBASED_CTLS2 during KVM_SET_CPUID if userspace has never
+	 * set the MSR, but leaves it alone once userspace writes the MSR.
+	 */
+	for (i = 0; i < 2; i++) {
+		vmx_sec_exec_feature_test(vcpu, XSAVES, !i);
+		vmx_sec_exec_feature_test(vcpu, RDTSCP, !i);
+		vmx_sec_exec_feature_test(vcpu, INVPCID, !i);
+		vmx_sec_exec_exiting_test(vcpu, RDRAND, !i);
+		vmx_sec_exec_exiting_test(vcpu, RDSEED, !i);
+	}
+}
+
 static void vmx_fixed1_msr_test(struct kvm_vcpu *vcpu, uint32_t msr_index,
 				  uint64_t mask)
 {
@@ -78,6 +168,8 @@ int main(void)
 	/* No need to actually do KVM_RUN, thus no guest code. */
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
+	vmx_sec_exec_controls_test(vcpu);
+
 	vmx_save_restore_msrs_test(vcpu);
 
 	kvm_vm_free(vm);
-- 
2.38.1.431.g37b22c650d-goog

