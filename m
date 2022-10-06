Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C115F5E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 02:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJFAwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 20:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJFAvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 20:51:48 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454EB550BC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 17:51:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id ay1-20020a056a00300100b0053e7e97696bso266235pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 17:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=v7OV2vEb3CfLD6y3M/Ila/csEIC+wXlUHfZbk3TEtJY=;
        b=oRlFhlW1744pXFVV/ibp9XVk+7RzS/xkhrdbuWk3MTwga19Gy30r7xzfZasfjHVpUo
         mbpF4/+kCIRVNx14mYGd6f7qCSskikgm94oPJ4jvDZQ2sF6Ef3JIVXjhz6PN6/WTlkJT
         1RA5BhqQ7i51Ak4M4ive2zHPp+nB97ftnVzb91Fi2NVTh6abD/MzP1vUYoQuF72N5k47
         jthfGvo6mdTKTrhjU0VCCKLcj1C1J+lqjVEll0ml8IBvt0wJXX+qL3J9YClEFGxcQKSA
         0bWUoLdbLk9BOCbl27wj1VA2W59H3jd45OdEIWsMpBUGNZVB089EY+Jc5cUXs0Le64pJ
         KprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7OV2vEb3CfLD6y3M/Ila/csEIC+wXlUHfZbk3TEtJY=;
        b=BSqesWYT6wFn1A3TBVA/GOk5bwcpgW7QdWFj++W8gcZ2T1o30Ww2ZyXirwiub7lXcI
         +/lv0DiScJ0VrIdHA6qLpaq0rLQ6u/xaH0cuEArqxZnmHrz+E2DPTRh3t84nNfZoyAVa
         CTUABZkIipUba3bG3MvEGgIrDx1sE3GF8DbiKL9typrP2zlQxfokoQC2Y+H0ooQmoBBo
         eI09LmRffdVJx8v7EcmbIXC6wEi9Gd5u4wRlKmlmhqTFQ/Qgx0/YEz3PNGVmz0Nr8wUI
         5FEwfQeRz/CwU/sp9Coegb20ZrqvvDODSKpblhkL44BCjcJ5BYj4WtEBOu52mzugiuZH
         O2mw==
X-Gm-Message-State: ACrzQf23BqUCRCjd3iMlQnr6nd/EQQjlROm47ivXRAZXbHYOP8nt3gSL
        I+ugZInmnKnDM35TkroUqJn0RJjqIPg=
X-Google-Smtp-Source: AMsMyM43aEoUU+hD34YqenieIomQMLVGPDRheMg9vUHZZHX67C8ud78E4Tcw1qVPq00TZqbZQF/qiu9SZjw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6f61:b0:20a:e71e:3a75 with SMTP id
 d88-20020a17090a6f6100b0020ae71e3a75mr7817814pjk.76.1665017501725; Wed, 05
 Oct 2022 17:51:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:51:21 +0000
In-Reply-To: <20221006005125.680782-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006005125.680782-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006005125.680782-9-seanjc@google.com>
Subject: [PATCH 08/12] KVM: selftests: Convert vmx_pmu_caps_test to use X86_PROPERTY_*
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
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

Add X86_PROPERTY_PMU_VERSION and use it in vmx_pmu_caps_test to replace
open coded versions of the same functionality.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  |  6 ++----
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 19 ++-----------------
 2 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 15200afd7dc6..209de48eb501 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -200,6 +200,8 @@ struct kvm_x86_cpu_property {
 })
 
 #define X86_PROPERTY_MAX_BASIC_LEAF		KVM_X86_CPU_PROPERTY(0, 0, EAX, 0, 31)
+#define X86_PROPERTY_PMU_VERSION		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 0, 7)
+
 #define X86_PROPERTY_XSTATE_MAX_SIZE_XCR0	KVM_X86_CPU_PROPERTY(0xd,  0, EBX,  0, 31)
 #define X86_PROPERTY_XSTATE_MAX_SIZE		KVM_X86_CPU_PROPERTY(0xd,  0, ECX,  0, 31)
 #define X86_PROPERTY_XSTATE_TILE_SIZE		KVM_X86_CPU_PROPERTY(0xd, 18, EAX,  0, 31)
@@ -842,10 +844,6 @@ static inline void vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index,
 	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_SET_MSRS, r));
 }
 
-static inline uint32_t kvm_get_cpuid_max_basic(void)
-{
-	return kvm_get_supported_cpuid_entry(0)->eax;
-}
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 bool vm_is_unrestricted_guest(struct kvm_vm *vm);
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 069589c52f41..c280ba1e6572 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -20,16 +20,6 @@
 #define PMU_CAP_FW_WRITES	(1ULL << 13)
 #define PMU_CAP_LBR_FMT		0x3f
 
-union cpuid10_eax {
-	struct {
-		unsigned int version_id:8;
-		unsigned int num_counters:8;
-		unsigned int bit_width:8;
-		unsigned int mask_length:8;
-	} split;
-	unsigned int full;
-};
-
 union perf_capabilities {
 	struct {
 		u64	lbr_format:6;
@@ -53,11 +43,9 @@ static void guest_code(void)
 
 int main(int argc, char *argv[])
 {
-	const struct kvm_cpuid_entry2 *entry_a_0;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
 	int ret;
-	union cpuid10_eax eax;
 	union perf_capabilities host_cap;
 	uint64_t val;
 
@@ -69,11 +57,8 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
 
-	TEST_REQUIRE(kvm_get_cpuid_max_basic() >= 0xa);
-	entry_a_0 = kvm_get_supported_cpuid_entry(0xa);
-
-	eax.full = entry_a_0->eax;
-	__TEST_REQUIRE(eax.split.version_id, "PMU is not supported by the vCPU");
+	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
+	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
 
 	/* testcase 1, set capabilities when we have PDCM bit */
 	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, PMU_CAP_FW_WRITES);
-- 
2.38.0.rc1.362.ged0d419d3c-goog

