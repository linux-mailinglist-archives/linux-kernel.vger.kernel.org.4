Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FC76B570D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCKAtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCKAsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:48:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6B213B97D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:47:29 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id lm13-20020a170903298d00b0019a8c8a13dfso3652997plb.16
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qD1jIziSrgpE9j3MUNLoJWWdusyfTlvDCPPTQgu6pW4=;
        b=cRu0v4x3nzZkysQwV7Hjv2HLzgmm+NtSGFmgLD80UubovRtPmuUIa4optzL3Fwvd/o
         hPF3a9cuL6DQlU5TImx1c07CESv3RjmbBkKkBKwtimUD4sqiH1YyurCPmVHrrZkVflcj
         nGsvH9MuFpe/HCIL+tf4oVjoBTSKR+/Q3+z+cBlb+tXlcJyuh51L5MY/qWNjb+yIHiRf
         FblBDwn2s8TEJ39B3Sgft0DISWOkaqz87xxdRGULPVaLzS+me/AOug2po6jpmZX7YQGo
         M/K/v8E+CuVP5nRs/sHyU1BI5i6e1AQNE36d+NV89sgJW/RiDrJx33tUZC4+2ML/yfPt
         X8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495621;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD1jIziSrgpE9j3MUNLoJWWdusyfTlvDCPPTQgu6pW4=;
        b=qelhvm0fUl/yv2tRLXGmxkV4bIWa+4nv5+z0J5beESc+xZLz1McxBj9w3JzZYvV7mH
         xzeKbsxzlEgOM78N9x00CV249A1FWPfPhaPB/n1SaqMFmIHqclnBZeCL4JRnbwaZK9I6
         w6ai3ph/kr6Cvs1SSPXrzY13QqrZ+8L40fGfOBa1XuPqnzAcWSZqafaTIL31S6PgdTmL
         x0zI2v0iSmWKtXuDVvp5XyVfBtkMl1c1nO1UmL+72hhUZxtBz1ui34HVUipQNWxQ05QQ
         vtxwavMpKY4E34ZUFNMsLHrGYFbhYrhkJon8Kd+itaqqjnwlhVLIuA2JGsWihNCrv5Im
         07nA==
X-Gm-Message-State: AO0yUKXQIc01XnKHOGfPY1Qpn8hOh/D9x8VAV1FVOo4u3A8OCNkE55ot
        OzlGSNt5aAQaQq7gZdNCevpoQITAT4k=
X-Google-Smtp-Source: AK7set+vF/Jqc70yV1/s3GYU99WeqUkc/YNhzWWZfOcpqVXElTJs48RHXD9kntZT1B35JY8QlrNsOAVwchA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2959:0:b0:503:7bcd:89e9 with SMTP id
 bu25-20020a632959000000b005037bcd89e9mr9679853pgb.1.1678495621202; Fri, 10
 Mar 2023 16:47:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:18 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-22-seanjc@google.com>
Subject: [PATCH v3 21/21] KVM: selftests: Verify LBRs are disabled if vPMU is disabled
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

Verify that disabling the guest's vPMU via CPUID also disables LBRs.
KVM has had at least one bug where LBRs would remain enabled even though
the intent was to disable everything PMU related.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 29aaa0419294..3009b3e5254d 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -204,6 +204,34 @@ static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
 	kvm_vm_free(vm);
 }
 
+/*
+ * Test that LBR MSRs are writable when LBRs are enabled, and then verify that
+ * disabling the vPMU via CPUID also disables LBR support.  Set bits 2:0 of
+ * LBR_TOS as those bits are writable across all uarch implementations (arch
+ * LBRs will need to poke a different MSR).
+ */
+static void test_lbr_perf_capabilities(union perf_capabilities host_cap)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	int r;
+
+	if (!host_cap.lbr_format)
+		return;
+
+	vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
+	vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);
+
+	vcpu_clear_cpuid_entry(vcpu, X86_PROPERTY_PMU_VERSION.function);
+
+	r = _vcpu_set_msr(vcpu, MSR_LBR_TOS, 7);
+	TEST_ASSERT(!r, "Writing LBR_TOS should fail after disabling vPMU");
+
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	union perf_capabilities host_cap;
@@ -222,4 +250,5 @@ int main(int argc, char *argv[])
 	test_fungible_perf_capabilities(host_cap);
 	test_immutable_perf_capabilities(host_cap);
 	test_guest_wrmsr_perf_capabilities(host_cap);
+	test_lbr_perf_capabilities(host_cap);
 }
-- 
2.40.0.rc1.284.g88254d51c5-goog

