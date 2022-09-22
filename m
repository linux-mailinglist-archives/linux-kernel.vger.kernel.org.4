Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE715E65D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiIVOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiIVOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:37:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8081F6F4D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663857428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J1VDEsnEh9wkG81vtfR47Z3WfZc6Wox6QC7/mnkfa20=;
        b=RnovtRi2RSkN9CvDLrh6vmEFpwrfZeSHwjTlYWO/9B9KK7YTtslBYaQ2z3LsGsPyTy7S/p
        6ydMsAy1/d+ORVcu+dFLbO1EjkNsvHMAmiCe96JJZLJ4SSXOLue7gggEs8cJAADJvUKQ09
        6bx01LesSGhwjFQ+h8yZDoWApYdN9fM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-XNuQQ0CSPZ2gNopNujl7MQ-1; Thu, 22 Sep 2022 10:37:05 -0400
X-MC-Unique: XNuQQ0CSPZ2gNopNujl7MQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7A9E8630CC;
        Thu, 22 Sep 2022 14:37:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40D984041023;
        Thu, 22 Sep 2022 14:37:03 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/6] KVM: x86: Hyper-V invariant TSC control
Date:   Thu, 22 Sep 2022 16:36:52 +0200
Message-Id: <20220922143655.3721218-4-vkuznets@redhat.com>
In-Reply-To: <20220922143655.3721218-1-vkuznets@redhat.com>
References: <20220922143655.3721218-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, genuine Hyper-V doesn't expose architectural invariant TSC
(CPUID.80000007H:EDX[8]) to its guests by default. A special PV MSR
(HV_X64_MSR_TSC_INVARIANT_CONTROL, 0x40000118) and corresponding CPUID
feature bit (CPUID.0x40000003.EAX[15]) were introduced. When bit 0 of the
PV MSR is set, invariant TSC bit starts to show up in CPUID. When the
feature is exposed to Hyper-V guests, reenlightenment becomes unneeded.

Add the feature to KVM. Keep CPUID output intact when the feature
wasn't exposed to L1 and implement the required logic for hiding
invariant TSC when the feature was exposed and invariant TSC control
MSR wasn't written to. Copy genuine Hyper-V behavior and forbid to
disable the feature once it was enabled.

For the reference, for linux guests, support for the feature was added
in commit dce7cd62754b ("x86/hyperv: Allow guests to enable InvariantTSC").

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            |  3 +++
 arch/x86/kvm/hyperv.c           | 19 +++++++++++++++++++
 arch/x86/kvm/hyperv.h           | 27 +++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  4 +++-
 5 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ee940c4c0f64..20fa0fd665db 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1028,6 +1028,7 @@ struct kvm_hv {
 	u64 hv_reenlightenment_control;
 	u64 hv_tsc_emulation_control;
 	u64 hv_tsc_emulation_status;
+	u64 hv_invtsc_control;
 
 	/* How many vCPUs have VP index != vCPU index */
 	atomic_t num_mismatched_vp_indexes;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b95a4b7489ec..ea97d78d2522 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1463,6 +1463,9 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 		        if (!__kvm_get_msr(vcpu, MSR_IA32_TSX_CTRL, &data, true) &&
 			    (data & TSX_CTRL_CPUID_CLEAR))
 				*ebx &= ~(F(RTM) | F(HLE));
+		} else if (function == 0x80000007) {
+			if (kvm_hv_invtsc_suppressed(vcpu))
+				*edx &= ~SF(CONSTANT_TSC);
 		}
 	} else {
 		*eax = *ebx = *ecx = *edx = 0;
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0adf4a437e85..41b60ec9bc53 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -989,6 +989,7 @@ static bool kvm_hv_msr_partition_wide(u32 msr)
 	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
 	case HV_X64_MSR_SYNDBG_OPTIONS:
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		r = true;
@@ -1273,6 +1274,9 @@ static bool hv_check_msr_access(struct kvm_vcpu_hv *hv_vcpu, u32 msr)
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		return hv_vcpu->cpuid_cache.features_eax &
 			HV_ACCESS_REENLIGHTENMENT;
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
+		return hv_vcpu->cpuid_cache.features_eax &
+			HV_ACCESS_TSC_INVARIANT;
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 	case HV_X64_MSR_CRASH_CTL:
 		return hv_vcpu->cpuid_cache.features_edx &
@@ -1400,6 +1404,17 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		if (!host)
 			return 1;
 		break;
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
+		/* Only bit 0 is supported */
+		if (data & ~HV_INVARIANT_TSC_EXPOSED)
+			return 1;
+
+		/* The feature can't be disabled from the guest */
+		if (!host && hv->hv_invtsc_control && !data)
+			return 1;
+
+		hv->hv_invtsc_control = data;
+		break;
 	case HV_X64_MSR_SYNDBG_OPTIONS:
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		return syndbg_set_msr(vcpu, msr, data, host);
@@ -1575,6 +1590,9 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
 		data = hv->hv_tsc_emulation_status;
 		break;
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
+		data = hv->hv_invtsc_control;
+		break;
 	case HV_X64_MSR_SYNDBG_OPTIONS:
 	case HV_X64_MSR_SYNDBG_CONTROL ... HV_X64_MSR_SYNDBG_PENDING_BUFFER:
 		return syndbg_get_msr(vcpu, msr, pdata, host);
@@ -2491,6 +2509,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 			ent->eax |= HV_MSR_REFERENCE_TSC_AVAILABLE;
 			ent->eax |= HV_ACCESS_FREQUENCY_MSRS;
 			ent->eax |= HV_ACCESS_REENLIGHTENMENT;
+			ent->eax |= HV_ACCESS_TSC_INVARIANT;
 
 			ent->ebx |= HV_POST_MESSAGES;
 			ent->ebx |= HV_SIGNAL_EVENTS;
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 1030b1b50552..0f7382f2b157 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -136,6 +136,33 @@ static inline bool kvm_hv_has_stimer_pending(struct kvm_vcpu *vcpu)
 			     HV_SYNIC_STIMER_COUNT);
 }
 
+/*
+ * With HV_ACCESS_TSC_INVARIANT feature, invariant TSC (CPUID.80000007H:EDX[8])
+ * is only observed after HV_X64_MSR_TSC_INVARIANT_CONTROL was written to.
+ */
+static inline bool kvm_hv_invtsc_suppressed(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	/*
+	 * If Hyper-V's invariant TSC control is not exposed to the guest,
+	 * the invariant TSC CPUID flag is not suppressed, Windows guests were
+	 * observed to be able to handle it correctly. Going forward, VMMs are
+	 * encouraged to enable Hyper-V's invariant TSC control when invariant
+	 * TSC CPUID flag is set to make KVM's behavior match genuine Hyper-V.
+	 */
+	if (!hv_vcpu ||
+	    !(hv_vcpu->cpuid_cache.features_eax & HV_ACCESS_TSC_INVARIANT))
+		return false;
+
+	/*
+	 * If Hyper-V's invariant TSC control is exposed to the guest, KVM is
+	 * responsible for suppressing the invariant TSC CPUID flag if the
+	 * Hyper-V control is not enabled.
+	 */
+	return !(to_kvm_hv(vcpu->kvm)->hv_invtsc_control & HV_INVARIANT_TSC_EXPOSED);
+}
+
 void kvm_hv_process_stimers(struct kvm_vcpu *vcpu);
 
 void kvm_hv_setup_tsc_page(struct kvm *kvm,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5b8328cb6c14..d9a9335d28bd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1489,7 +1489,7 @@ static const u32 emulated_msrs_all[] = {
 	HV_X64_MSR_STIMER0_CONFIG,
 	HV_X64_MSR_VP_ASSIST_PAGE,
 	HV_X64_MSR_REENLIGHTENMENT_CONTROL, HV_X64_MSR_TSC_EMULATION_CONTROL,
-	HV_X64_MSR_TSC_EMULATION_STATUS,
+	HV_X64_MSR_TSC_EMULATION_STATUS, HV_X64_MSR_TSC_INVARIANT_CONTROL,
 	HV_X64_MSR_SYNDBG_OPTIONS,
 	HV_X64_MSR_SYNDBG_CONTROL, HV_X64_MSR_SYNDBG_STATUS,
 	HV_X64_MSR_SYNDBG_SEND_BUFFER, HV_X64_MSR_SYNDBG_RECV_BUFFER,
@@ -3795,6 +3795,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
 		return kvm_hv_set_msr_common(vcpu, msr, data,
 					     msr_info->host_initiated);
 	case MSR_IA32_BBL_CR_CTL3:
@@ -4165,6 +4166,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_CONTROL:
 	case HV_X64_MSR_TSC_EMULATION_STATUS:
+	case HV_X64_MSR_TSC_INVARIANT_CONTROL:
 		return kvm_hv_get_msr_common(vcpu,
 					     msr_info->index, &msr_info->data,
 					     msr_info->host_initiated);
-- 
2.37.3

