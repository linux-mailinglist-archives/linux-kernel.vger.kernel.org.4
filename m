Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C6C691598
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBJAdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjBJAdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:33:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C8F6F8FD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id l18-20020a17090add9200b00230f60889d6so1595572pjv.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u+uN37eWphC2DXBy/eZAMutSohHuiH84z9BjA6Yonic=;
        b=a23HHkIyyBmPIc9LXUuzfy6mgHqnSj8/Xj+GczXDjbPEG9C9VhW3YLCnaVrGASU4It
         dRMLgQ0Ds6KR7AF7VA5wMEdz1pY5REJp1bswbQ13++0xCdoNi9eGewi/wt/JpVA3CpsJ
         VibX0yz9vMRbTuJ0PzAXnZcuHGub1oyv0ffubrVq38Gfyn49hEAYN+gHDKB1vILwLouw
         MRymvft4bHIhVvVGp3LdNW2O6gORiCt7rLmDela8Gz7awxkPZN5iNsxMNFbZwUQVXGS9
         VZyufZMAD4IfLnuP1VHvx94QEj70p3sUrJX8nsNtu7zY/zfm7bxMBRPUtTGjiQfXK6OS
         tx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+uN37eWphC2DXBy/eZAMutSohHuiH84z9BjA6Yonic=;
        b=xQvGpC3H9Kb5S2nWJTPPq+DO9L2PRZCRWIWuaEAmOXTMR5Xsd24i3BKeRNm88zKkOm
         jFARRi1dqOrfpm/SzEtVALZNmWMQHkA8UPTK0fgg/2crLXj0J0zU8TTR7oYl7HgLM8Ks
         gANjdb2q/ymN13wtUPzuxWh/n5Bak4011mdu32iDc1GkemxYTcgPZNrkg1I4b/z3vxJy
         bqMWZR/bxGC6ZM+rbOLOAW4OyULFZTqQYgbosXz/xoZemHsNXzQoOoHxyckdfYDO9nuJ
         ftBnTYXIIVW1J81vsxxFXXivTf1rghhkLshQMJNag60a67zGjpOjKvHG0suh6/MLUNxf
         HO3Q==
X-Gm-Message-State: AO0yUKXK1T7NoS+dFudj559JZwWstetdI0kWKsHHRwIcfAr9A4+PhUYj
        4eMTKHyKR8PH7/0t5PFwyDLO0DHdmz0=
X-Google-Smtp-Source: AK7set/pSJFj96UiXm5itrLBsMLS9XaoBFrHLiki+1QbJoSiIpVyZB/8ZeVe5DKNHsvqsmCOnr3K2h1BH1s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7c0f:b0:199:49fc:8669 with SMTP id
 x15-20020a1709027c0f00b0019949fc8669mr2022019pll.6.1675989137722; Thu, 09 Feb
 2023 16:32:17 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:43 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-17-seanjc@google.com>
Subject: [PATCH v2 16/21] KVM: selftests: Expand negative testing of guest
 writes to PERF_CAPABILITIES
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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

Test that the guest can't write 0 to PERF_CAPABILITIES, can't write the
current value, and can't toggle _any_ bits.  There is no reason to special
case the LBR format.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 61 ++++++++++++++++---
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index d91bf44a2e39..44fc6101a547 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -54,9 +54,59 @@ static const union perf_capabilities format_caps = {
 	.pebs_format = -1,
 };
 
-static void guest_code(void)
+static void guest_code(uint64_t current_val)
 {
-	wrmsr(MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
+	uint8_t vector;
+	int i;
+
+	vector = wrmsr_safe(MSR_IA32_PERF_CAPABILITIES, current_val);
+	GUEST_ASSERT_2(vector == GP_VECTOR, current_val, vector);
+
+	vector = wrmsr_safe(MSR_IA32_PERF_CAPABILITIES, 0);
+	GUEST_ASSERT_2(vector == GP_VECTOR, 0, vector);
+
+	for (i = 0; i < 64; i++) {
+		vector = wrmsr_safe(MSR_IA32_PERF_CAPABILITIES,
+				    current_val ^ BIT_ULL(i));
+		GUEST_ASSERT_2(vector == GP_VECTOR,
+			       current_val ^ BIT_ULL(i), vector);
+	}
+
+	GUEST_DONE();
+}
+
+/*
+ * Verify that guest WRMSRs to PERF_CAPABILITIES #GP regardless of the value
+ * written, that the guest always sees the userspace controlled value, and that
+ * PERF_CAPABILITIES is immutable after KVM_RUN.
+ */
+static void test_guest_wrmsr_perf_capabilities(union perf_capabilities host_cap)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	struct ucall uc;
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
+
+	vcpu_args_set(vcpu, 1, host_cap.capabilities);
+	vcpu_run(vcpu);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT_2(uc, "val = 0x%lx, vector = %lu");
+		break;
+	case UCALL_DONE:
+		break;
+	default:
+		TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+	}
+
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
+
+	kvm_vm_free(vm);
 }
 
 /*
@@ -79,7 +129,7 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 	const uint64_t fungible_caps = host_cap.capabilities & ~immutable_caps.capabilities;
 
 	struct kvm_vcpu *vcpu;
-	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	int bit;
 
 	for_each_set_bit(bit, &fungible_caps, 64) {
@@ -89,10 +139,6 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 	}
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
 
-	/* check whatever we write with KVM_SET_MSR is _not_ modified */
-	vcpu_run(vcpu);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
-
 	kvm_vm_free(vm);
 }
 
@@ -153,6 +199,7 @@ int main(int argc, char *argv[])
 	test_basic_perf_capabilities(host_cap);
 	test_fungible_perf_capabilities(host_cap);
 	test_immutable_perf_capabilities(host_cap);
+	test_guest_wrmsr_perf_capabilities(host_cap);
 
 	printf("Completed perf capability tests.\n");
 }
-- 
2.39.1.581.gbfd45094c4-goog

