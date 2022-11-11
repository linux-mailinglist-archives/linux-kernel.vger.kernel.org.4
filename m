Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEA625853
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKKK15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiKKK1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:27:16 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97B98;
        Fri, 11 Nov 2022 02:27:15 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so7390061pjs.4;
        Fri, 11 Nov 2022 02:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzOaBpwkmS+JyOIsS/V/diMHkb8z+4FSiF7VtVek/Ww=;
        b=Fr99We31ejU/oYgUHojBpphQSL6G+A7lNtPX2qEFOfjo/1Z3NAISIoNiFxHkUSjd5Q
         QVP0DmQaYgk8+4ePdWJngO3ibncAWoTvtWYkS3RPoySiE8OSO6M/l2zN9e8Xzd0i9UmJ
         KhntJUQbG9WW/xCpk8Ay79ZdJHkJ/zqdHDqU+i8iGW7UiL7yMlJ14R3+Yup7WKY9Yf8K
         4FV+dULwhPUv8OMbaf3YunOmAXaRXNar90jSxF5bQ6RdpzUpuCS3JCqeeMqB/z3FdZC3
         +wVXhoD8tyH7sAVxkkX5V8WJpgpiJFW0lsycPxi5dhmBYoNlAY++VNz1HF2m0pJKkeKy
         9qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzOaBpwkmS+JyOIsS/V/diMHkb8z+4FSiF7VtVek/Ww=;
        b=DF5u7ubYaWehfzJIcHFChrSdmZVUTgC/0BtsFhAx1n6MV2Si+XYuT6xc0WJEntoj2v
         vg8CSorJxRf8oFuRApKOqrfX40IigsizXODDqVJAVEWYGpV5GK8qYv+rdAyczf2u8n/F
         EZyNQD+5b1+LDYZlEpcyy3V7R3RKbr1RmHY/1WCIDJKEjE6/1HIvd5T9+ZH1WXjPcXOD
         S/NU+vnHD3Yyf3uxZtae30Hc7lZTL851/0Zt3lyBJNlw1WybjNRVaFsFG4j+ALkBJshp
         y6hPGOIWeE674D1GMyMjwOaM4JcBF8dBUOQl8YKCi1XGU+Hank/vw/E0mwvVaai6riSC
         lPkQ==
X-Gm-Message-State: ANoB5pkvG+ZOezYE0xPqQHQ7ExXwmDHIJ5FZjI6D1A9HtzGOpBubcqRA
        pTefEZ/er/vheF5lQy6cki1QtxuFnYhL/4Sc
X-Google-Smtp-Source: AA0mqf6EGkOXxzgag5ClbyG5t3sG8ilOlfoQjhauy1QlEmksbEjwKw/KGRL/9O86HM5EH7hFBSO0GA==
X-Received: by 2002:a17:90a:9a85:b0:213:e4:3f57 with SMTP id e5-20020a17090a9a8500b0021300e43f57mr1126902pjp.204.1668162434935;
        Fri, 11 Nov 2022 02:27:14 -0800 (PST)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id u67-20020a626046000000b0056b6acb58a0sm1248612pfb.102.2022.11.11.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:27:14 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v3 6/8] KVM: x86/svm/pmu: Add AMD PerfMonV2 support
Date:   Fri, 11 Nov 2022 18:26:43 +0800
Message-Id: <20221111102645.82001-7-likexu@tencent.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111102645.82001-1-likexu@tencent.com>
References: <20221111102645.82001-1-likexu@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

If AMD Performance Monitoring Version 2 (PerfMonV2) is detected by
the guest, it can use a new scheme to manage the Core PMCs using the
new global control and status registers.

In addition to benefiting from the PerfMonV2 functionality in the same
way as the host (higher precision), the guest also can reduce the number
of vm-exits by lowering the total number of MSRs accesses.

In terms of implementation details, amd_is_valid_msr() is resurrected
since three newly added MSRs could not be mapped to one vPMC.
The possibility of emulating PerfMonV2 on the mainframe has also
been eliminated for reasons of precision.

Co-developed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/pmu.c              |  6 ++++
 arch/x86/kvm/svm/pmu.c          | 64 +++++++++++++++++++++++++++------
 arch/x86/kvm/x86.c              | 14 ++++++--
 4 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 81114a376c4e..d02990fcd46f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -512,6 +512,7 @@ struct kvm_pmc {
 #define MSR_ARCH_PERFMON_EVENTSEL_MAX	(MSR_ARCH_PERFMON_EVENTSEL0 + KVM_INTEL_PMC_MAX_GENERIC - 1)
 #define KVM_PMC_MAX_FIXED	3
 #define KVM_AMD_PMC_MAX_GENERIC	6
+#define MSR_F15H_PERF_MSR_MAX	(MSR_F15H_PERF_CTR0 + 2 * (KVM_AMD_PMC_MAX_GENERIC - 1))
 struct kvm_pmu {
 	unsigned nr_arch_gp_counters;
 	unsigned nr_arch_fixed_counters;
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a3726af5416d..c70ff57ee44c 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -471,12 +471,15 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 		msr_info->data = pmu->global_status;
 		return 0;
 	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 		msr_info->data = pmu->global_ctrl;
 		return 0;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		msr_info->data = 0;
 		return 0;
 	default:
@@ -495,12 +498,14 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 		if (!msr_info->host_initiated)
 			return 1; /* RO MSR */
 
 		pmu->global_status = data;
 		return 0;
 	case MSR_CORE_PERF_GLOBAL_CTRL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 		if (!kvm_valid_perf_global_ctrl(pmu, data))
 			return 1;
 
@@ -511,6 +516,7 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		return 0;
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (data & pmu->global_ovf_ctrl_mask)
 			return 1;
 
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 4e7d7e6cccec..e58f39f8f10b 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -92,12 +92,6 @@ static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
 	return amd_pmc_idx_to_pmc(vcpu_to_pmu(vcpu), idx & ~(3u << 30));
 }
 
-static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
-{
-	/* All MSRs refer to exactly one PMC, so msr_idx_to_pmc is enough.  */
-	return false;
-}
-
 static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -109,6 +103,29 @@ static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
 	return pmc;
 }
 
+static bool amd_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
+{
+	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+
+	switch (msr) {
+	case MSR_K7_EVNTSEL0 ... MSR_K7_PERFCTR3:
+		return pmu->version > 0;
+	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
+		return guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE);
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+		return pmu->version > 1;
+	default:
+		if (msr > MSR_F15H_PERF_CTR5 &&
+		    msr < MSR_F15H_PERF_CTL0 + 2 * pmu->nr_arch_gp_counters)
+			return pmu->version > 1;
+		break;
+	}
+
+	return amd_msr_idx_to_pmc(vcpu, msr);
+}
+
 static int amd_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
@@ -162,20 +179,42 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	struct kvm_cpuid_entry2 *entry;
+	union cpuid_0x80000022_ebx ebx;
 
-	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE))
-		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS_CORE;
+	pmu->version = 1;
+	if (kvm_cpu_cap_has(X86_FEATURE_AMD_PMU_V2) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_AMD_PMU_V2)) {
+		pmu->version = 2;
+		entry = kvm_find_cpuid_entry_index(vcpu, 0x80000022, 0);
+		ebx.full = entry->ebx;
+		pmu->nr_arch_gp_counters = min3((unsigned int)ebx.split.num_core_pmc,
+						(unsigned int)kvm_pmu_cap.num_counters_gp,
+						(unsigned int)KVM_AMD_PMC_MAX_GENERIC);
+	}
+
+	/* Commitment to minimal PMCs, regardless of CPUID.80000022 */
+	if (kvm_cpu_cap_has(X86_FEATURE_PERFCTR_CORE) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE))
+		pmu->nr_arch_gp_counters = max_t(unsigned int,
+						 pmu->nr_arch_gp_counters,
+						 AMD64_NUM_COUNTERS_CORE);
 	else
-		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
+		pmu->nr_arch_gp_counters = max_t(unsigned int,
+						 pmu->nr_arch_gp_counters,
+						 AMD64_NUM_COUNTERS);
+
+	if (pmu->version > 1) {
+		pmu->global_ctrl_mask = ~((1ull << pmu->nr_arch_gp_counters) - 1);
+		pmu->global_ovf_ctrl_mask = pmu->global_ctrl_mask;
+	}
 
 	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
-	pmu->version = 1;
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->nr_arch_fixed_counters = 0;
-	pmu->global_status = 0;
 	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 }
 
@@ -186,6 +225,7 @@ static void amd_pmu_init(struct kvm_vcpu *vcpu)
 
 	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > AMD64_NUM_COUNTERS_CORE);
 	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC > INTEL_PMC_MAX_GENERIC);
+	BUILD_BUG_ON(KVM_AMD_PMC_MAX_GENERIC < 1);
 
 	for (i = 0; i < KVM_AMD_PMC_MAX_GENERIC ; i++) {
 		pmu->gp_counters[i].type = KVM_PMC_GP;
@@ -206,6 +246,8 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 		pmc_stop_counter(pmc);
 		pmc->counter = pmc->prev_counter = pmc->eventsel = 0;
 	}
+
+	pmu->global_ctrl = pmu->global_status = 0;
 }
 
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e46e458c5b08..99bc47f1a40e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1458,6 +1458,10 @@ static const u32 msrs_to_save_all[] = {
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
 
+	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+
 	MSR_IA32_XFD, MSR_IA32_XFD_ERR,
 };
 
@@ -3859,7 +3863,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_PEBS_ENABLE:
 	case MSR_IA32_DS_AREA:
 	case MSR_PEBS_DATA_CFG:
-	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
+	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_MSR_MAX:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (kvm_pmu_is_valid_msr(vcpu, msr))
 			return kvm_pmu_set_msr(vcpu, msr_info);
 		/*
@@ -3962,7 +3969,10 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_PEBS_ENABLE:
 	case MSR_IA32_DS_AREA:
 	case MSR_PEBS_DATA_CFG:
-	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_CTR5:
+	case MSR_F15H_PERF_CTL0 ... MSR_F15H_PERF_MSR_MAX:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (kvm_pmu_is_valid_msr(vcpu, msr_info->index))
 			return kvm_pmu_get_msr(vcpu, msr_info);
 		/*
-- 
2.38.1

