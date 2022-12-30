Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919D565866B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbiL1TZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiL1TZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:25:00 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCD3183A2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 11:24:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-410f1a84ed2so182739257b3.15
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LehCRL1Bkg7m894um912QRzB94JErMqn1lJvj9EXRDg=;
        b=cao+rbPpEh0CM4eNRLM1YYxP2pEUWPF5BIRkUsfj4rNDx9tMa1UMwmLh/gsaxT2R9a
         TbQDPuzyWb+6AvKoXOoitB7sfl2tOX95dPoFEieF6+auG+rGxQ66VFr4zH6vQONur46I
         E9C6zsVWj3ij2PphdLOmMeH7rnbP+i5AUrfwl2QILD5/cgGK75dPOYvlRSzrbIvXlEwk
         jhMEhmlYZ5OxI3FTKKztXe0lmlyo26WoZ+dlHx80UviSfbIX7/1Op1MDK5HttSQH0PaX
         zNpWm8sAlZ/V98i3QgOxtGG42hcvfkqugKnzTNTSN9ahBF+13zPLYfz2E3W9eMDSycLT
         2uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LehCRL1Bkg7m894um912QRzB94JErMqn1lJvj9EXRDg=;
        b=mXkUMK3GXw42CP6B5WrRISgAcxLnqni5gYJZN70z8Xeay785d7pYauBLmNoUIKQlCc
         +k72b/kOr4uVoHogP+aeemnvI3Hf7393szK8ydpip0UHLfxIAt102HPqkiB6OxQU35uS
         dGfojLCl6WIX+YABQccwl4Jds+kx0Se24YB26cwscqj53w0tt6pZN5TpsVUq7bcYTgas
         YXxHYxOA4ewjk+lhqGFvrO+K3B/n1cMOnfhMELn6RoudF+srfwjte5mWWBGgHODj3aFW
         1HYfe4mG/ifpZQIYHMx7NrIFvy6xoz0wjAgQAC432OZmWCAAwVERKu5PRB3FfpLXPFZl
         MdYA==
X-Gm-Message-State: AFqh2kokOs2Mdmg48NiowuYu0QDUe5WRltLrTqtN0obR4ZpNAOLybcna
        bk52sIcgOugnjU+PYG/oHBeph4gk77ZuC/2m
X-Google-Smtp-Source: AMrXdXt2PhDvXl+WzsMKN54s0aF5L1C+kZGlOoaZPgyAMGpBWfQ5J1M81ETncp31dtw2epZSxW6pqVYR5e1dbGEx
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a25:bbd1:0:b0:70b:87c6:4fe with SMTP id
 c17-20020a25bbd1000000b0070b87c604femr2824610ybk.550.1672255494272; Wed, 28
 Dec 2022 11:24:54 -0800 (PST)
Date:   Wed, 28 Dec 2022 19:24:37 +0000
In-Reply-To: <20221228192438.2835203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221228192438.2835203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221228192438.2835203-4-vannapurve@google.com>
Subject: [V4 PATCH 3/4] KVM: sefltests: x86: Replace is_*cpu with is_host_*cpu
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com,
        Vishal Annapurve <vannapurve@google.com>
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

Replace APIs to query cpu type with APIs always checking the host cpu
type. This way there are two set of APIs to query CPU type:
1) this_cpu_is_*()
2) is_host_*cpu()
that can be invoked as per the usecase.

All the current callers of is_*cpu actually care about host cpu type so
they are updated to invoke is_host*cpu.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h |  4 ++--
 tools/testing/selftests/kvm/lib/x86_64/processor.c   | 12 ++++++------
 .../selftests/kvm/x86_64/fix_hypercall_test.c        |  4 ++--
 .../testing/selftests/kvm/x86_64/mmio_warning_test.c |  2 +-
 .../selftests/kvm/x86_64/pmu_event_filter_test.c     |  4 ++--
 .../x86_64/vmx_exception_with_invalid_guest_state.c  |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 84edac133d8f..8f9e066c89d9 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -713,8 +713,8 @@ static inline void cpu_relax(void)
 		"hlt\n"	\
 		)
 
-bool is_intel_cpu(void);
-bool is_amd_cpu(void);
+bool is_host_cpu_intel(void);
+bool is_host_cpu_amd(void);
 
 struct kvm_x86_state *vcpu_save_state(struct kvm_vcpu *vcpu);
 void vcpu_load_state(struct kvm_vcpu *vcpu, struct kvm_x86_state *state);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index b3d2a9ab5ced..18f0608743d1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -115,7 +115,7 @@ static void sregs_dump(FILE *stream, struct kvm_sregs *sregs, uint8_t indent)
 
 bool kvm_is_tdp_enabled(void)
 {
-	if (is_intel_cpu())
+	if (is_host_cpu_intel())
 		return get_kvm_intel_param_bool("ept");
 	else
 		return get_kvm_amd_param_bool("npt");
@@ -1010,14 +1010,14 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
 	free(state);
 }
 
-bool is_intel_cpu(void)
+bool is_host_cpu_intel(void)
 {
-	return this_cpu_is_intel();
+	return host_cpu_is_intel;
 }
 
-bool is_amd_cpu(void)
+bool is_host_cpu_amd(void)
 {
-	return this_cpu_is_amd();
+	return host_cpu_is_amd;
 }
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
@@ -1228,7 +1228,7 @@ unsigned long vm_compute_max_gfn(struct kvm_vm *vm)
 	max_gfn = (1ULL << (vm->pa_bits - vm->page_shift)) - 1;
 
 	/* Avoid reserved HyperTransport region on AMD processors.  */
-	if (!is_amd_cpu())
+	if (!is_host_cpu_amd())
 		return max_gfn;
 
 	/* On parts with <40 physical address bits, the area is fully hidden */
diff --git a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
index 32f7e09ef67c..e84c0c5a73b1 100644
--- a/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
+++ b/tools/testing/selftests/kvm/x86_64/fix_hypercall_test.c
@@ -48,10 +48,10 @@ static void guest_main(void)
 	const uint8_t *other_hypercall_insn;
 	uint64_t ret;
 
-	if (is_intel_cpu()) {
+	if (is_host_cpu_intel()) {
 		native_hypercall_insn = vmx_vmcall;
 		other_hypercall_insn  = svm_vmmcall;
-	} else if (is_amd_cpu()) {
+	} else if (is_host_cpu_amd()) {
 		native_hypercall_insn = svm_vmmcall;
 		other_hypercall_insn  = vmx_vmcall;
 	} else {
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index fb02581953a3..d2d5dcae98e7 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -93,7 +93,7 @@ int main(void)
 {
 	int warnings_before, warnings_after;
 
-	TEST_REQUIRE(is_intel_cpu());
+	TEST_REQUIRE(is_host_cpu_intel());
 
 	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
 
diff --git a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
index 2de98fce7edd..289226117513 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_event_filter_test.c
@@ -363,7 +363,7 @@ static void test_pmu_config_disable(void (*guest_code)(void))
  */
 static bool use_intel_pmu(void)
 {
-	return is_intel_cpu() &&
+	return is_host_cpu_intel() &&
 	       kvm_cpu_property(X86_PROPERTY_PMU_VERSION) &&
 	       kvm_cpu_property(X86_PROPERTY_PMU_NR_GP_COUNTERS) &&
 	       kvm_pmu_has(X86_PMU_FEATURE_BRANCH_INSNS_RETIRED);
@@ -397,7 +397,7 @@ static bool use_amd_pmu(void)
 	uint32_t family = kvm_cpu_family();
 	uint32_t model = kvm_cpu_model();
 
-	return is_amd_cpu() &&
+	return is_host_cpu_amd() &&
 		(is_zen1(family, model) ||
 		 is_zen2(family, model) ||
 		 is_zen3(family, model));
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
index 2641b286b4ed..d74b0d22385a 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_exception_with_invalid_guest_state.c
@@ -111,7 +111,7 @@ int main(int argc, char *argv[])
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	TEST_REQUIRE(is_intel_cpu());
+	TEST_REQUIRE(is_host_cpu_intel());
 	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
-- 
2.39.0.314.g84b9a713c41-goog

