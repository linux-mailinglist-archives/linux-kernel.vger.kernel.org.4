Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591D06B5702
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjCKArk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjCKAq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:46:59 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7B13F68F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:39 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id iw4-20020a170903044400b0019ccafc1fbeso3625784plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UwMxWX9lXc3VYeDgFb3qxT6J0GWhUZ4fTBpHKmaPUo4=;
        b=hLQNM/3Ck9a+9imtZyP3GGuRTeJaPSfHJ3XwUnAuDM6l7vf+ikPghSZhCLyFewxoTt
         718eWMvalMU42w8rWkdJJUZkYM2/S2CxvLq3CW8IHb/ZZTrMYsJys6tQHDuLVfegXA6M
         3e3RDgLF8L7LDGWlIiLgvGG/7GYRPQYdnqTqWJVtR/Hhwk4IhRQiIKAyv/7J42kNq6g6
         XzfJZIzEDu7cNBDO8+zQAibWaYjGYP2MDPxuYR2rpR/7KWp4X7/GmqvpstJp4cB6eTiD
         Gc2tU8JPK9q3ttX1zc+p525ikfyD+dpPWif0Dtg7kB2APcnlLrPxDZHEa/BRVNYR8j1x
         Yaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495599;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwMxWX9lXc3VYeDgFb3qxT6J0GWhUZ4fTBpHKmaPUo4=;
        b=gJBEZwGvo0bk3n7OK76IJgo9hM5DJhf9ni3Rh+pEtgqQz5A+tLHcjWJMiUbswm14oc
         0x3OO8jFthudtJso00Ksjenjmpn0830i1J6R4U6yZCcHela6OUoUH5Pj21QqyT/SVZa4
         nIe0i4NG8UjPYK1W2iNWTR64QWotyIa1/GZGMKFNXzucqUEZb8GKr+wIsB1zsn357c9q
         D7Prwt2lBAawbvrrwZ3X1PBHwrSm9ZwhcELCxc8oAgiUu4K3Tdg4p5btDkPUffJJ2V4W
         BvKIRWmrlMnLZzZsbrRmvHjCkwLTgCk/FxihFajqbY8Acc2PHnLmcJxHV1hGUFcpXC/5
         t39A==
X-Gm-Message-State: AO0yUKV1jxZMnWU2lTN/Z17CpSUVJz5mMYRAkIWKkV7jbuRLTMzHR+5r
        /oXUMEGPzICeUHgNbQkMseAzzONGWLg=
X-Google-Smtp-Source: AK7set/4vPR76Kbgdz9p8EAthmWAAnq7WtUuTEjcW1T+e90PxuXEbMs1G0zbXFkGUgiWE0nh5GotPVsTEXQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:894:b0:23b:318d:dda7 with SMTP id
 bj20-20020a17090b089400b0023b318ddda7mr224259pjb.4.1678495599064; Fri, 10 Mar
 2023 16:46:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:06 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-10-seanjc@google.com>
Subject: [PATCH v3 09/21] KVM: selftests: Move 0/initial value PERF_CAPS
 checks to dedicated sub-test
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

Use a separate sub-test to verify userspace can clear PERF_CAPABILITIES
and restore it to the KVM-supported value, as the testcase isn't unique
to the LBR format.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index ac08c0fdd84d..c3b0738e361b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -41,6 +41,24 @@ static void guest_code(void)
 	wrmsr(MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
 }
 
+/*
+ * Verify KVM allows writing PERF_CAPABILITIES with all KVM-supported features
+ * enabled, as well as '0' (to disable all features).
+ */
+static void test_basic_perf_capabilities(union perf_capabilities host_cap)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), 0);
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
+	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
+
+	kvm_vm_free(vm);
+}
+
 static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 {
 	struct kvm_vcpu *vcpu;
@@ -66,12 +84,6 @@ static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
 	uint64_t val;
 	int ret;
 
-	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), 0);
-
-	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.lbr_format);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), (u64)host_cap.lbr_format);
-
 	/*
 	 * KVM only supports the host's native LBR format, as well as '0' (to
 	 * disable LBR support).  Verify KVM rejects all other LBR formats.
@@ -98,6 +110,7 @@ int main(int argc, char *argv[])
 	host_cap.capabilities = kvm_get_feature_msr(MSR_IA32_PERF_CAPABILITIES);
 	host_cap.capabilities &= (PMU_CAP_FW_WRITES | PMU_CAP_LBR_FMT);
 
+	test_basic_perf_capabilities(host_cap);
 	test_fungible_perf_capabilities(host_cap);
 	test_immutable_perf_capabilities(host_cap);
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

