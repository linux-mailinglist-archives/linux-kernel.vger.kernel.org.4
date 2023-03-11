Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C0A6B5716
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 01:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjCKAsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 19:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCKAr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 19:47:57 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF813D1F0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:47:10 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id bh9-20020a170902a98900b0019e506b80d0so3672475plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678495610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8shLf2BD8j5DUhNgoX3o6+mHtMqyjRCN50sfLrkOnl0=;
        b=DzIJin/sBdxZML/E6j9IbyfB58NFBLF8eEspI/Uquf+oD2qtETdUnzoBF8auHpny27
         eq4mIh7mZVBqBL4IbIGn3vzTT89YOInoNUdQ818qbYezkIF6meu5kKIHs5NNGfjoArOR
         5RY8ukjOIZuBheNV8jAjVASnihu20OUr6XnsgyLMS8YijC6PWVblx7nCnVCQYx2BkMsP
         FSnbbBNIRJf4AVS61IuFyKhfISIENSJngu4fMeFZQ/v1sKDc1Qi//ZGM03eOl5DNQQOz
         AcJSuM6stNsMShoHvhJGiXzM47AEALKEVeeyZPA3GxgrQiX2QvMvbXfSD/n+snhXjafJ
         gSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678495610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8shLf2BD8j5DUhNgoX3o6+mHtMqyjRCN50sfLrkOnl0=;
        b=khLyabsDWQlApbeX7os8rFs3CVZxf8pHQ347HlIA81MKeRZB7eYArMMph2gaP7CPyN
         NAEr92kkcrb8ppiNII5YTij75aLYfYzhzv4F+z3g3vN4QOrnak4kx0cXNhgldUIrN3+s
         lxpd0y4NrT6kDfPHYR7FZThywxAS4ePgdFJZYDCaXLpGUk6zn+cFChp7FOn/LprotqDQ
         WGS71bB6xsZ6WpwuAvJqbVd5bbD4aVyZzr93tR0D5Xbno5R7S0ToeEks5FcRFYl63Tby
         xJIj/TbzN4oRJFsQlMW1waZOQKMWSaPVzK0ciQ+zAGJkQVTN7VZWQpNrI687BjewXOU9
         ln4Q==
X-Gm-Message-State: AO0yUKW3+Z4ctN3SpM6jjYkkIMD04bT3ZZFaWftQrOrZ3//VTA098FEx
        CJYzxBfnDgKepCcOSzGPPClYj5K/HUs=
X-Google-Smtp-Source: AK7set8ji35GdrABX70264YHSZ0clvQ2YZjx7+nYdKp881dNrsJ0rPofQeE7MR1tL9gsOH2keLIq4C2Ktd8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:a512:0:b0:593:fcfb:208b with SMTP id
 v18-20020a62a512000000b00593fcfb208bmr11074485pfm.3.1678495609926; Fri, 10
 Mar 2023 16:46:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 16:46:12 -0800
In-Reply-To: <20230311004618.920745-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230311004618.920745-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230311004618.920745-16-seanjc@google.com>
Subject: [PATCH v3 15/21] KVM: selftests: Test all immutable non-format bits
 in PERF_CAPABILITIES
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

Add negative testing of all immutable bits in PERF_CAPABILITIES, i.e.
single bits that are reserved-0 or are effectively reserved-1 by KVM.

Omit LBR and PEBS format bits from the test as it's easier to test them
manually than it is to add safeguards to the comment path, e.g. toggling
a single bit can yield a format of '0', which is legal as a "disable"
value.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 2647282ff380..d91bf44a2e39 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -49,6 +49,11 @@ static const union perf_capabilities immutable_caps = {
 	.pebs_baseline = 1,
 };
 
+static const union perf_capabilities format_caps = {
+	.lbr_format = -1,
+	.pebs_format = -1,
+};
+
 static void guest_code(void)
 {
 	wrmsr(MSR_IA32_PERF_CAPABILITIES, PMU_CAP_LBR_FMT);
@@ -91,12 +96,30 @@ static void test_fungible_perf_capabilities(union perf_capabilities host_cap)
 	kvm_vm_free(vm);
 }
 
+/*
+ * Verify KVM rejects attempts to set unsupported and/or immutable features in
+ * PERF_CAPABILITIES.  Note, LBR format and PEBS format need to be validated
+ * separately as they are multi-bit values, e.g. toggling or setting a single
+ * bit can generate a false positive without dedicated safeguards.
+ */
 static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
 {
+	const uint64_t reserved_caps = (~host_cap.capabilities |
+					immutable_caps.capabilities) &
+				       ~format_caps.capabilities;
+
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm = vm_create_with_one_vcpu(&vcpu, NULL);
 	uint64_t val;
-	int ret;
+	int r, bit;
+
+	for_each_set_bit(bit, &reserved_caps, 64) {
+		r = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES,
+				  host_cap.capabilities ^ BIT_ULL(bit));
+		TEST_ASSERT(!r, "%s immutable feature 0x%llx (bit %d) didn't fail",
+			    host_cap.capabilities & BIT_ULL(bit) ? "Setting" : "Clearing",
+			    BIT_ULL(bit), bit);
+	}
 
 	/*
 	 * KVM only supports the host's native LBR format, as well as '0' (to
@@ -106,9 +129,10 @@ static void test_immutable_perf_capabilities(union perf_capabilities host_cap)
 		if (val == (host_cap.capabilities & PMU_CAP_LBR_FMT))
 			continue;
 
-		ret = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
-		TEST_ASSERT(!ret, "Bad LBR FMT = 0x%lx didn't fail", val);
+		r = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, val);
+		TEST_ASSERT(!r, "Bad LBR FMT = 0x%lx didn't fail", val);
 	}
+
 	kvm_vm_free(vm);
 }
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

