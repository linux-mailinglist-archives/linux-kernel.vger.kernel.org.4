Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D36B56F7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCKAq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCKAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:46:43 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F59D13E0B4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:32 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z4-20020a63e104000000b005033bc79287so1671334pgh.22
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/K3SNYnoXPbtGJnYKgYAyon1VCKMrYBBJfg3kvO2j1w=;
        b=HAXKMJmlAXL3VlLkD8B15Nc2mewXMfn/fVqBuTwrhEKRliaSZuq2QGcmlrcyOVTo1Z
         4GtTMYDZZ4mW3vD23LMpqxsiLZONLboQddJeoDmBK++P6Zp8X9s6BXjKMsPDqimIKsGL
         rx80XqlPJgSkdLg7arjnfsW3aYS2qbmw2prNTjObh+IyBnMtUlW3xPqckd6aaXDHjINz
         m5NAza8F6+ZVgzqf5NMdMbZm846UYwgltZltA42Zl5Nh63gwfe0QN8cUHlnOobdCP9sX
         iXRKejCmzlbFQHIHjcV5RnEa4yLF5E7e/2XtUTRip6yTlgJkF3Fs2sKYTJ9F0SyBEgGm
         qKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/K3SNYnoXPbtGJnYKgYAyon1VCKMrYBBJfg3kvO2j1w=;
        b=eEwV2oIc7M34M334Vs7ahrKz0ni6ft6825/trVm2dQLZ1z8WqkJX/QeEOfRX3yaggl
         8DonIvwwdE2drPCXNu8VmttephSE/10DpTXN0Oojx2JWVt29h8aOdbM5NyfoKMgDJAl4
         LEJ2xtSkxZt9a2PsWKVOjj2ToEOJRNdlJVrm90WoqNVsGonTcCCVHt9jz0tql+mGHyP0
         0EyJ/ARwK5aYnG/LHJheiuvmFCoCRmwXn23TOz5t1i68EvW/2siEf02pwILBugKfxAkO
         tng8p696F2xXvj7Nj91jM7XeUCGVT9AOJd+mcyp2qEnw3Rr8qnyxiir2BNvpMqWAK0r9
         8ulg==
X-Gm-Message-State: AO0yUKUnFwzAZoYIV1cJifzqAiASYu6fl4n7EVqxYQsU/BDbgA/XbLOQ
        T8ygipBrmkc1qsXaY88Hj2OgAbSIzww=
X-Google-Smtp-Source: AK7set/6fcyxyyaEUDeDMuzHefFQJJJd/EwplJORjyavhZJxxlgYMcEUkZ5th6QY8PWLVy4HTWtKql2tl30=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d18a:b0:234:c035:7749 with SMTP id
 fu10-20020a17090ad18a00b00234c0357749mr9644225pjb.0.1678495591577; Fri, 10
 Mar 2023 16:46:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:02 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-6-seanjc@google.com>
Subject: [PATCH v3 05/21] KVM: selftests: Split PMU caps sub-tests to avoid
 writing MSR after KVM_RUN
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the PERF_CAPABILITIES subtests into two parts so that the LBR format
testcases don't execute after KVM_RUN.  Similar to the guest CPUID model,
KVM will soon disallow changing PERF_CAPABILITIES after KVM_RUN, at which
point attempting to set the MSR after KVM_RUN will yield false positives
and/or false negatives depending on what the test is trying to do.

Land the LBR format test in a more generic "immutable features" test in
anticipation of expanding its scope to other immutable features.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 51 +++++++++++--------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index c280ba1e6572..ac08c0fdd84d 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -41,24 +41,10 @@ static void guest_code(void)
 	wrmsr(MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
 }
 
-int main(int argc, char *argv[])
+static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 {
-	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
-	int ret;
-	union perf_capabilities host_cap;
-	uint64_t val;
-
-	host_cap.capabilities = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
-	host_cap.capabilities &= (PMU_CAP_FW_WRITES | PMU_CAP_LBR_FMT);
-
-	/* Create VM */
-	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
-
-	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
-	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 
 	/* testcase 1, set capabilities when we have PDCM bit */
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
@@ -70,7 +56,16 @@ int main(int argc, char *argv[])
 	vcpu_run(vcpu);
 	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
 
-	/* testcase 2, check valid LBR formats are accepted */
+	kvm_vm_free(vm);
+}
+
+static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
+	uint64_t val;
+	int ret;
+
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
 	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), 0);
 
@@ -78,8 +73,8 @@ int main(int argc, char *argv[])
 	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), (u64)host_cap.lbr_format);
 
 	/*
-	 * Testcase 3, check that an "invalid" LBR format is rejected.  Only an
-	 * exact match of the host's format (and 0/disabled) is allowed.
+	 * KVM only supports the host's native LBR format, as well as '0' (to
+	 * disable LBR support).  Verify KVM rejects all other LBR formats.
 	 */
 	for (val = 1; val <= PMU_CAP_LBR_FMT; val++) {
 		if (val == (host_cap.capabilities & PMU_CAP_LBR_FMT))
@@ -88,7 +83,23 @@ int main(int argc, char *argv[])
 		ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
 		TEST_ASSERT(!ret, "Bad LBR FMT = 0x%lx didn't fail", val);
 	}
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	union perf_capabilities host_cap;
+
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
+
+	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
+	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+
+	host_cap.capabilities = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
+	host_cap.capabilities &= (PMU_CAP_FW_WRITES | PMU_CAP_LBR_FMT);
+
+	test_fungible_perf_capabilities(host_cap);
+	test_immutable_perf_capabilities(host_cap);
 
 	printf("Completed perf capability tests.\n");
-	kvm_vm_free(vm);
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

