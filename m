Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A99720CEA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 03:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjFCBMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 21:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbjFCBLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 21:11:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6045710FA
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 18:11:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565c380565dso61344517b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 18:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685754682; x=1688346682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru4NXMiYqBKlufWL9jxqCVd/0d0D25zGIOSPpyTm3aM=;
        b=V3X79M39GOaEpzyiwPbShLWgs/39VTBmFVjJc2GZySWh481lXM2HZbFBC8L4O9uI24
         4TK1ZpDDjZo9KyaD8pfYqBc8cyLMtrwuq+Vs611gm4VRZ5shL0dBL0z8L2oj7TlPFF13
         gB4GnKoHO0FVTVjBZRKS6OkcU6XCC5b1MXMqIwXS0gv3bBmgaxgz3+dSCXTqH+13Mh0P
         Jje/hUBZbjB1CmIS7iOUBGXv3NHL2bBDSMOlKLIdEWkTTv6F7jShljDAuSuQil3C8r5G
         +TwQuwlkNYRgyrjHjN+pNeb4KlCRuAHEs4Gsg3WX0WpvmdgHzwzm7fgoW0OuSZDSP5r4
         DMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685754682; x=1688346682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru4NXMiYqBKlufWL9jxqCVd/0d0D25zGIOSPpyTm3aM=;
        b=ZfZxjPYJYLXsx0p+Ey0l3BzCUPuu2Q1M7Nsl4M8WhntUA/a7LxrqZ+bd5M7KFk04X4
         mzOW8IKBprw1ZlfjZQVvBQWvGt3S75buLiHZ6IkxpAsAcR7FTEZh+qY5s24QSW7PzhsG
         AEZvseOF+UCwgP0eg4qwbBWWPRbEhRLtwcyAXOLKQqJZNFi7cmgfUzOE81fe2ohnPYP+
         CRgXcFomMBtCtQxW/Avocn2gBUtXwTmXV75hyyXdl9LCcDOI4JUeX9+8Hn/4hqWt55Uh
         M1xfNftHLzUJ2ffZj1rLvDhM0uy8QvlfPVC6C2zC6tTdiUW4S5muXP8nsDxAkQblPJBz
         o9aw==
X-Gm-Message-State: AC+VfDxn6MKfoABRcVzChoKi+wI9BDp5LKrswMHnm0rGKp8/1SHQ2gLF
        NU0/v2Vx2K+6NNqTOOSU/aJ4BGPxiP8=
X-Google-Smtp-Source: ACHHUZ4Ax00P3OBB5zcoiD+bjlYBSQ75XLvh6ta/bvdoFWmeGs8yJxOlppBceCDSIr1q1PDDh3eGpHnhMcE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:700c:0:b0:561:4723:2088 with SMTP id
 l12-20020a81700c000000b0056147232088mr908922ywc.4.1685754682122; Fri, 02 Jun
 2023 18:11:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  2 Jun 2023 18:10:57 -0700
In-Reply-To: <20230603011058.1038821-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230603011058.1038821-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230603011058.1038821-12-seanjc@google.com>
Subject: [PATCH v7 11/12] KVM: x86/svm/pmu: Add AMD PerfMonV2 support
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>,
        Like Xu <likexu@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
[sean: drop "Based on the observed HW." comments]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c     | 18 +++++++++++++-
 arch/x86/kvm/svm/pmu.c | 55 ++++++++++++++++++++++++++++++++++--------
 arch/x86/kvm/x86.c     | 10 ++++++++
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 4315f46aabfb..bf653df86112 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -585,11 +585,14 @@ int kvm_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
 		msr_info->data = pmu->global_status;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
 	case MSR_CORE_PERF_GLOBAL_CTRL:
 		msr_info->data = pmu->global_ctrl;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
 		msr_info->data = 0;
 		break;
@@ -607,16 +610,28 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	u64 data = msr_info->data;
 	u64 diff;
 
+	/*
+	 * Note, AMD ignores writes to reserved bits and read-only PMU MSRs,
+	 * whereas Intel generates #GP on attempts to write reserved/RO MSRs.
+	 */
 	switch (msr) {
 	case MSR_CORE_PERF_GLOBAL_STATUS:
 		if (!msr_info->host_initiated)
 			return 1; /* RO MSR */
+		fallthrough;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+		/* Per PPR, Read-only MSR. Writes are ignored. */
+		if (!msr_info->host_initiated)
+			break;
 
 		if (data & pmu->global_status_mask)
 			return 1;
 
 		pmu->global_status = data;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+		data &= ~pmu->global_ctrl_mask;
+		fallthrough;
 	case MSR_CORE_PERF_GLOBAL_CTRL:
 		if (!kvm_valid_perf_global_ctrl(pmu, data))
 			return 1;
@@ -634,7 +649,8 @@ int kvm_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 */
 		if (data & pmu->global_status_mask)
 			return 1;
-
+		fallthrough;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
 		if (!msr_info->host_initiated)
 			pmu->global_status &= ~data;
 		break;
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index c03958063a76..cef5a3d0abd0 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -94,12 +94,6 @@ static struct kvm_pmc *amd_rdpmc_ecx_to_pmc(struct kvm_vcpu *vcpu,
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
@@ -111,6 +105,29 @@ static struct kvm_pmc *amd_msr_idx_to_pmc(struct kvm_vcpu *vcpu, u32 msr)
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
@@ -164,23 +181,39 @@ static int amd_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 {
 	struct kvm_pmu *pmu = vcpu_to_pmu(vcpu);
+	union cpuid_0x80000022_ebx ebx;
 
-	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE))
+	pmu->version = 1;
+	if (guest_cpuid_has(vcpu, X86_FEATURE_PERFMON_V2)) {
+		pmu->version = 2;
+		/*
+		 * Note, PERFMON_V2 is also in 0x80000022.0x0, i.e. the guest
+		 * CPUID entry is guaranteed to be non-NULL.
+		 */
+		BUILD_BUG_ON(x86_feature_cpuid(X86_FEATURE_PERFMON_V2).function != 0x80000022 ||
+			     x86_feature_cpuid(X86_FEATURE_PERFMON_V2).index);
+		ebx.full = kvm_find_cpuid_entry_index(vcpu, 0x80000022, 0)->ebx;
+		pmu->nr_arch_gp_counters = ebx.split.num_core_pmc;
+	} else if (guest_cpuid_has(vcpu, X86_FEATURE_PERFCTR_CORE)) {
 		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS_CORE;
-	else
+	} else {
 		pmu->nr_arch_gp_counters = AMD64_NUM_COUNTERS;
+	}
 
 	pmu->nr_arch_gp_counters = min_t(unsigned int, pmu->nr_arch_gp_counters,
 					 kvm_pmu_cap.num_counters_gp);
 
+	if (pmu->version > 1) {
+		pmu->global_ctrl_mask = ~((1ull << pmu->nr_arch_gp_counters) - 1);
+		pmu->global_status_mask = pmu->global_ctrl_mask;
+	}
+
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
 
@@ -211,6 +244,8 @@ static void amd_pmu_reset(struct kvm_vcpu *vcpu)
 		pmc_stop_counter(pmc);
 		pmc->counter = pmc->prev_counter = pmc->eventsel = 0;
 	}
+
+	pmu->global_ctrl = pmu->global_status = 0;
 }
 
 struct kvm_pmu_ops amd_pmu_ops __initdata = {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c0778ca39650..abfba3cae0ba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1483,6 +1483,10 @@ static const u32 msrs_to_save_pmu[] = {
 	MSR_F15H_PERF_CTL3, MSR_F15H_PERF_CTL4, MSR_F15H_PERF_CTL5,
 	MSR_F15H_PERF_CTR0, MSR_F15H_PERF_CTR1, MSR_F15H_PERF_CTR2,
 	MSR_F15H_PERF_CTR3, MSR_F15H_PERF_CTR4, MSR_F15H_PERF_CTR5,
+
+	MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+	MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
 };
 
 static u32 msrs_to_save[ARRAY_SIZE(msrs_to_save_base) +
@@ -7150,6 +7154,12 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 		    kvm_pmu_cap.num_counters_fixed)
 			return;
 		break;
+	case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
+	case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
+		if (!kvm_cpu_cap_has(X86_FEATURE_PERFMON_V2))
+			return;
+		break;
 	case MSR_IA32_XFD:
 	case MSR_IA32_XFD_ERR:
 		if (!kvm_cpu_cap_has(X86_FEATURE_XFD))
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

