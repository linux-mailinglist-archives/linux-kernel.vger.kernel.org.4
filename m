Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE12A691595
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBJAdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjBJAcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:32:52 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1C23A84D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:19 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-52ec7c792b1so11488637b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/yC4dBTyHw4BCiIIE+mQoyLNyewJpNpr9hXU3HEhe04=;
        b=dlFTWIrj5xuEqCgUwiK8eF69WB3PynzH9yUbo/CRFqeCmeAV07IDNmKLTxj9gfHIEl
         QRajxEu3mwYakZTPaC3A8Ilm9JHeauGNoJ5/n+EKd77uEAO2oU6czqKqSEEkCQC89dRf
         jYvdefaqRkNNtezzCdDpemGQ7PUWxHdUDLhqeAVUxpK5E7cS5f2j1ytsC3l2e0aYnUQt
         4uSrDnSM93RiTBzgzciApnWIjjNdLp0Sk3xWXLxMvJqtZZ062vrjOpR3NNd01Cnn4IfE
         U1wJoTYNzFVkN+DlYGsS7Bngc9fZm5k/+FOWfI5/Jl+q3L65nbV6Nv3++BK4z3QKVIOz
         TAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yC4dBTyHw4BCiIIE+mQoyLNyewJpNpr9hXU3HEhe04=;
        b=naYU92Qgtt0lRSxf1jpYI7x0MquM3bCnpNnHz++6kAzUd8Fd5cx6mbQAcIOAw2vkS+
         XJ7ybwEhuJj3BTUE1cQD6j80SsahVjJ0zM82VlJmHunwk5MZ7Q1RQB0vU3lk081kEvaH
         7DC2JKZPLofnitiJEZS44fUekg0+wDzvr6mZanJxBT14BXHigYlgfRsiEpykfxGbbFJG
         k+vWXvkoprc+bCzUiKd4ys4S2onb0NgOFaQ7/AFLYOJL0cbauBcw6rd15gnMyyc6lNa7
         EY4wSjuklJ0lJVEvEEX+/6csEGVrnYuhnEO3kicfzSazJltaEwYFauih3RlEtHO4KmX9
         Ui8Q==
X-Gm-Message-State: AO0yUKXIqdGqt6OU4AxoyeYmmKeiBq/iF9wfx/GhSxvFKHgUmR9rY2p1
        NtMswLmMbzyTKqwfYsh5BdQfd72cg9M=
X-Google-Smtp-Source: AK7set/a1VPnE1qh75p3Qr32V59FVbB5jrkL/zut0x05iyZEjpKihKDjiuQ52fCyobrlQ49ZnmbrEBPgh/A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:81c2:0:b0:527:98b2:bce with SMTP id
 r185-20020a8181c2000000b0052798b20bcemr1538735ywf.222.1675989132992; Thu, 09
 Feb 2023 16:32:12 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:40 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-14-seanjc@google.com>
Subject: [PATCH v2 13/21] KVM: selftests: Drop now-redundant checks on
 PERF_CAPABILITIES writes
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

Now that vcpu_set_msr() verifies the expected "read what was wrote"
semantics of all durable MSRs, including PERF_CAPABILITIES, drop the
now-redundant manual checks in the VMX PMU caps test.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 035470b38400..f7a27b5c949b 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -51,10 +51,7 @@ static void test_basic_perf_capabilities(union perf_capabilities host_cap)
 	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), 0);
-
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), host_cap.capabilities);
 
 	kvm_vm_free(vm);
 }
@@ -67,9 +64,6 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 	/* testcase 1, set capabilities when we have PDCM bit */
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
 
-	/* check capabilities can be retrieved with KVM_GET_MSR */
-	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
-
 	/* check whatever we write with KVM_SET_MSR is _not_ modified */
 	vcpu_run(vcpu);
 	ASSERT_EQ(vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES), PMU_CAP_FW_WRITES);
-- 
2.39.1.581.gbfd45094c4-goog

