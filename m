Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4ED614D7F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 15:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiKAO63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiKAO5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 10:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79E1CFD9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667314558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zm9WXSecnQ89rdkjhrvYrdMmDK9PwhW6jqQG1/i94Tk=;
        b=cQQDlwNpk0erOOgN/kGVYyaMU45kwlTj2P6YiJ6V2vm9IjcdncwVX7B3eAw6ICjg7iqdLJ
        V3We1HiMDtdROPbdvMZ4qIMny6umbV/AYCF5efOIkelQORDV/G4f+h6oTP6AXO5VffHxbE
        TsSMYAysk4QEdkMoHqSxsUJ1Ln4Kfdc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-2qT-8-YpMvuNCiwuafeslg-1; Tue, 01 Nov 2022 10:55:52 -0400
X-MC-Unique: 2qT-8-YpMvuNCiwuafeslg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08A341C004F6;
        Tue,  1 Nov 2022 14:55:52 +0000 (UTC)
Received: from ovpn-194-149.brq.redhat.com (ovpn-194-149.brq.redhat.com [10.40.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48A0CC15BA5;
        Tue,  1 Nov 2022 14:55:49 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v13 26/48] KVM: nVMX: hyper-v: Enable L2 TLB flush
Date:   Tue,  1 Nov 2022 15:54:04 +0100
Message-Id: <20221101145426.251680-27-vkuznets@redhat.com>
In-Reply-To: <20221101145426.251680-1-vkuznets@redhat.com>
References: <20221101145426.251680-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable L2 TLB flush feature on nVMX when:
- Enlightened VMCS is in use.
- The feature flag is enabled in eVMCS.
- The feature flag is enabled in partition assist page.

Perform synthetic vmexit to L1 after processing TLB flush call upon
request (HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH).

Note: nested_evmcs_l2_tlb_flush_enabled() uses cached VP assist page copy
which gets updated from nested_vmx_handle_enlightened_vmptrld(). This is
also guaranteed to happen post migration with eVMCS backed L2 running.

Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/hyperv-tlfs.h |  9 +++++++++
 arch/x86/kvm/vmx/hyperv.c          | 17 +++++++++++++++++
 arch/x86/kvm/vmx/hyperv.h          |  1 +
 arch/x86/kvm/vmx/nested.c          | 20 ++++++++++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6639979302ab..b25c6792d409 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -600,6 +600,15 @@ struct hv_enlightened_vmcs {
 
 #define HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL			0xFFFF
 
+/*
+ * Note, Hyper-V isn't actually stealing bit 28 from Intel, just abusing it by
+ * pairing it with architecturally impossible exit reasons.  Bit 28 is set only
+ * on SMI exits to a SMI transfer monitor (STM) and if and only if a MTF VM-Exit
+ * is pending.  I.e. it will never be set by hardware for non-SMI exits (there
+ * are only three), nor will it ever be set unless the VMM is an STM.
+ */
+#define HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH		0x10000031
+
 /*
  * Hyper-V uses the software reserved 32 bytes in VMCB control area to expose
  * SVM enlightenments to guests.
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index bceca1a99804..04a0bba58c7d 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -5,6 +5,7 @@
 
 #include "../cpuid.h"
 #include "hyperv.h"
+#include "nested.h"
 #include "vmcs.h"
 #include "vmx.h"
 #include "trace.h"
@@ -500,6 +501,22 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+bool nested_evmcs_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
+
+	if (!hv_vcpu || !evmcs)
+		return false;
+
+	if (!evmcs->hv_enlightenments_control.nested_flush_hypercall)
+		return false;
+
+	return hv_vcpu->vp_assist_page.nested_control.features.directhypercall;
+}
+
 void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu)
 {
+	nested_vmx_vmexit(vcpu, HV_VMX_SYNTHETIC_EXIT_REASON_TRAP_AFTER_FLUSH, 0, 0);
 }
diff --git a/arch/x86/kvm/vmx/hyperv.h b/arch/x86/kvm/vmx/hyperv.h
index 8bf366730d33..571e7929d14e 100644
--- a/arch/x86/kvm/vmx/hyperv.h
+++ b/arch/x86/kvm/vmx/hyperv.h
@@ -243,6 +243,7 @@ int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version);
 void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *pdata);
 int nested_evmcs_check_controls(struct vmcs12 *vmcs12);
+bool nested_evmcs_l2_tlb_flush_enabled(struct kvm_vcpu *vcpu);
 void vmx_hv_inject_synthetic_vmexit_post_tlb_flush(struct kvm_vcpu *vcpu);
 
 #endif /* __KVM_X86_VMX_HYPERV_H */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 29a210df4066..d9814b91877c 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -1131,6 +1131,15 @@ static void nested_vmx_transition_tlb_flush(struct kvm_vcpu *vcpu,
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	/*
+	 * KVM_REQ_HV_TLB_FLUSH flushes entries from either L1's VP_ID or
+	 * L2's VP_ID upon request from the guest. Make sure we check for
+	 * pending entries in the right FIFO upon L1/L2 transition as these
+	 * requests are put by other vCPUs asynchronously.
+	 */
+	if (to_hv_vcpu(vcpu) && enable_ept)
+		kvm_make_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
+
 	/*
 	 * If vmcs12 doesn't use VPID, L1 expects linear and combined mappings
 	 * for *all* contexts to be flushed on VM-Enter/VM-Exit, i.e. it's a
@@ -3266,6 +3275,12 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 
 static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * Note: nested_get_evmcs_page() also updates 'vp_assist_page' copy
+	 * in 'struct kvm_vcpu_hv' in case eVMCS is in use, this is mandatory
+	 * to make nested_evmcs_l2_tlb_flush_enabled() work correctly post
+	 * migration.
+	 */
 	if (!nested_get_evmcs_page(vcpu)) {
 		pr_debug_ratelimited("%s: enlightened vmptrld failed\n",
 				     __func__);
@@ -6142,6 +6157,11 @@ static bool nested_vmx_l0_wants_exit(struct kvm_vcpu *vcpu,
 		 * Handle L2's bus locks in L0 directly.
 		 */
 		return true;
+	case EXIT_REASON_VMCALL:
+		/* Hyper-V L2 TLB flush hypercall is handled by L0 */
+		return guest_hv_cpuid_has_l2_tlb_flush(vcpu) &&
+			nested_evmcs_l2_tlb_flush_enabled(vcpu) &&
+			kvm_hv_is_tlb_flush_hcall(vcpu);
 	default:
 		break;
 	}
-- 
2.37.3

