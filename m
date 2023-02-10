Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805576915A5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjBJAeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBJAdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:33:46 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB67096A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:47 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id u3-20020a056a00124300b0056d4ab0c7cbso1769129pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=J6Gk09VCdivQ/Y/BQoeE1Efc/j/nP2LOhjM52BokYHY=;
        b=QjfcNWfF+9MosGU5G67r8yr2rtgu0nmHJmhphY7KHFmTTQSKrVcPSVIYRFvfe0RNXf
         5ulfvqqBYZ4AyrtK0O08jFiAWUCdJqaFantIPhan7pmEAJHv4B97orVlhsuitHwMvf/R
         L9WiLGUq4kHCb4/AwzyJm4tArS6NfvH2di3UwYs4LqHeThgzt87PLN9gdkTivZKRwoIw
         IvaXKhYrUWnv+KNnKkhIwYgxc6P1q8+mKPdM5UE5spmX2CcpJyh+lTMadIS4JIZLLhI/
         ZOBkI6q0zgV3XX+lX4v8002KDf5yK3fjEfHzfM/3VEOijq46rrZ1eJvtVu9AXpyV+GRl
         OS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6Gk09VCdivQ/Y/BQoeE1Efc/j/nP2LOhjM52BokYHY=;
        b=1PcikNQA6WEtHGH6ipprXYrDQ5Pk11k30j+ql5F4/xDqqTav2dotlvg2ugyLSTiXc6
         QTqtUvEmQJmpuPP8wdIGhtOLviP11Zzgrl8j3UotkQeQ9sNA+EoHJVhGt0AFqnURICbF
         BDuyER/hNOTPWOkGalFs4dnln67BsdLReDaWdfVUR1mWfgccDx5ppWWei7CXco4fYSh1
         wp5cUa078Fly7zaqYNvKHeIcU4mMZEGsG9IC/AwWja99NSIvX7oCEqPoPPW2v6WvpZeI
         pnx11sLuh+XrtjvSYvU2wD0L5huhmiBvnHM+9BcUWg3Hfuu+qBvoWAGAW9sIWaIHXPiN
         sedw==
X-Gm-Message-State: AO0yUKUg7l/hgybX9E9VwZHnhh6CRTB2ViKILVM95ZHjl8EE8eGEWz9d
        D7d3aohzEySmf7iVeM4MUlF/8MzjyfU=
X-Google-Smtp-Source: AK7set8Tf+Mu4344x73YHYpL2zzFxQMThn8EfRNvY0tOHY8icvYWnk+m0wIurpkbQyNmq8saBDnIqVaXXvA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:be48:0:b0:4fb:2c72:9168 with SMTP id
 g8-20020a63be48000000b004fb2c729168mr1791740pgo.85.1675989146248; Thu, 09 Feb
 2023 16:32:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:48 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-22-seanjc@google.com>
Subject: [PATCH v2 21/21] KVM: selftests: Verify LBRs are disabled if vPMU is disabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <like.xu.linux@gmail.com>
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
2.39.1.581.gbfd45094c4-goog

