Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FEF691581
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBJAcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjBJAcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:32:21 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCFD6E887
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:06 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x21-20020a056a000bd500b005a84de949aeso1776454pfu.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VYjOjrIZ5J+p9clyJLFd8A3MTNNwgKXkenVfNtTjRZE=;
        b=UTo9fRkp/Godq8jVF1yiCX5WmacvA07Lr+TfmwdK76MoOGbR/2HIzzxroOmKVrMY0m
         NhVtAjfAgOpLQZd2qUYFB2dWKyL+M8K21DXxuWuQrsGWfFT3WKvK6tggND4VvAuaRmcO
         EQXIwBhngs31eZCswvbCHq6HSPHeQosXSJpSWnNXSp3CEnY44C+WbBizGCSl6LiV5z87
         Kt3XEFR5A9SLf/mlbTGX8HhkdJmq+whAwsQt61v045kj2CVanZa7w473+IMpwV5zssps
         Ed7iOFFf9DIjTVsg68O5b/2g1rfHGXqj3TWJ/aEGtQv67gJirjk1l8SGKPZTD7opw3a3
         5yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYjOjrIZ5J+p9clyJLFd8A3MTNNwgKXkenVfNtTjRZE=;
        b=DKTdnPK47tN2//I974BTd6WeYSSSxJ+9P3Vc3xf9PDfSxN1/7+AqgBdRiPiJauEduc
         6kZnmje8E//kaG70aXgjDBWBSqem9+B+FDZ+anrT0HWSTwmwPXE5olIUC5cU54uL1+PY
         KkCXtLYPq+h3aw9ujgChDV520BtU9siof3vq01I7m/ZRSCpoWd38CW5km9qPtIMrrf9s
         6NfwpFf2yIstHzruLRTzaBWH2sb1vZOvXA+MUj+R7gnKMwgsSP1QXh0aKX/vMSEDPkun
         YwVi2SZFjayYdJUwq1sRLhCsDQ0ggSnQCx6djmtN2HVPvdbWwS+qiQoOjl0vbWb2/QDf
         OHyw==
X-Gm-Message-State: AO0yUKV7PHU2sZuOS/Y0xjvFcDhdkt3/7s5LfRlr5nRYiD5GtWU+wkse
        T5lhv+eegYatAwbby7+mXJQyUc+LXts=
X-Google-Smtp-Source: AK7set+FFtLChGWMkz+uej7yxu55dHEMHw5g1Pb/trMPIlJDADBKAdjLRo7mSzBQn11S+deJpMs7J5eYU+c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8a90:b0:199:527d:42c2 with SMTP id
 p16-20020a1709028a9000b00199527d42c2mr1675552plo.18.1675989126261; Thu, 09
 Feb 2023 16:32:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:36 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-10-seanjc@google.com>
Subject: [PATCH v2 09/21] KVM: selftests: Move 0/initial value PERF_CAPS
 checks to dedicated sub-test
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
2.39.1.581.gbfd45094c4-goog

