Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B287691592
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 01:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBJAdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 19:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjBJAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 19:32:51 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1B8234F2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 16:32:16 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mi18-20020a17090b4b5200b00230e56d5a44so1703057pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 16:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+k4M952d2GDbH8aircBGQJTgd8PxrJu8zZm+/DfU8l4=;
        b=IA6OgOX8vNndOZJU73bfgl/4tQXWJRnJ0OPt0ATsMtBAaIlTnc/X8ihp+C3Z5DSI4C
         suqFEyLg7Ruh/4V/G/szO99iX9MFJQosyR0tVPr3w0WQZ/6+TRzGb5ylSg+i2EB6P76p
         h83f3FdmOSCeQJvaS5UHWuFZSS7WcGJgvg6PZF8ggMV2MBJ4ouRc0c2uPDHt9fGawIcT
         cU6dBkEQtsuPzILLQnPQG7CCGxTwBFXN4mdRhqrPLDU2M5l5A4oXoGl9QzFmMUB1yaFn
         DKFtM8UKKAxLS4GBhXVdlJw2U24hdRM+QBifpZKjaMTVuAQfwYBhd8qG/WnWwMd0/Q6A
         1ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+k4M952d2GDbH8aircBGQJTgd8PxrJu8zZm+/DfU8l4=;
        b=VC5erubfCh0qASqV7OEloZ5r7Mvhyzjz3OULHIjRwFr8skUK9XXdknR+w/w1u00JD8
         ruFVX97D0Hl+eKyqUUezpHO3+FmJOaGpLKhVxmiuiZX91J/KHG3MJx/WtHYyy/PydXrw
         NHHng3/68nP6yEOLhwNTL6JCr6DxnLa+azpMfXMeSCSlDpFax149+RDODL6XgADu2QwZ
         mW2TKw98FGwttjx95PT9jM3kRd2CMKtr8rJn3Tm7N/6atkCKNwGJSxa85NsYYUjd/P4a
         aFLR4ynyPMOMxHOVeKD2R/LntNBj5mmAv/a/neYKjie+DP+rjbiGOZcMNn3pPkvJT2ek
         2nwQ==
X-Gm-Message-State: AO0yUKUIHfBELUY2iZ54FrbgxO0yLXTLCuQFHrEhLeQrBAiXegbFO5HO
        1rj44HHwUobxj8FTVdFWD+z+QOtqvTk=
X-Google-Smtp-Source: AK7set/Gj587GDdBiybnEi5JF56qDN7634spMhaskRTmQFZiTgZrLMy0GNg4ksXHO454W8FrTMWsEBQaauI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8ece:0:b0:5a8:5e12:a12e with SMTP id
 b14-20020aa78ece000000b005a85e12a12emr695322pfr.11.1675989136167; Thu, 09 Feb
 2023 16:32:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Feb 2023 00:31:42 +0000
In-Reply-To: <20230210003148.2646712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230210003148.2646712-1-seanjc@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210003148.2646712-16-seanjc@google.com>
Subject: [PATCH v2 15/21] KVM: selftests: Test all immutable non-format bits
 in PERF_CAPABILITIES
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
2.39.1.581.gbfd45094c4-goog

