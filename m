Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76BD607B10
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiJUPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiJUPge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049722E69A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666366580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J2O7MrbHRwvLk6Nh1f+WLBvem7KdQxtiVqnJxSwNJSA=;
        b=aYn8q8TeGy0AzFPzubV5xr/pzrGilbC6fcNqQ9/L+fTxx8etLQ2Cid1hxU/04pZz5iOB7O
        YgnhhCw8oG5IYad+f0PuyhO8TD47a0b5GE9UHdI9FweXpTbgZXZS74OT1tO3tIiTBHmY+I
        a1hUnriHag/eBlyNutleHKwWayhDf/k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-HDXHXX_RPYulKw6HtOhesg-1; Fri, 21 Oct 2022 11:36:13 -0400
X-MC-Unique: HDXHXX_RPYulKw6HtOhesg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEC663C1E72D;
        Fri, 21 Oct 2022 15:36:12 +0000 (UTC)
Received: from ovpn-192-65.brq.redhat.com (ovpn-192-65.brq.redhat.com [10.40.192.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24C8400EA8B;
        Fri, 21 Oct 2022 15:36:10 +0000 (UTC)
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
Subject: [PATCH v12 19/46] KVM: nVMX: Keep track of hv_vm_id/hv_vp_id when eVMCS is in use
Date:   Fri, 21 Oct 2022 17:34:54 +0200
Message-Id: <20221021153521.1216911-20-vkuznets@redhat.com>
In-Reply-To: <20221021153521.1216911-1-vkuznets@redhat.com>
References: <20221021153521.1216911-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle L2 TLB flush requests, KVM needs to keep track of L2's VM_ID/
VP_IDs which are set by L1 hypervisor. 'Partition assist page' address is
also needed to handle post-flush exit to L1 upon request.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/vmx/nested.c       | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5d590157266e..ede163b6f955 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -649,6 +649,12 @@ struct kvm_vcpu_hv {
 
 	/* Preallocated buffer for handling hypercalls passing sparse vCPU set */
 	u64 sparse_banks[HV_MAX_SPARSE_VCPU_BANKS];
+
+	struct {
+		u64 pa_page_gpa;
+		u64 vm_id;
+		u32 vp_id;
+	} nested;
 };
 
 /* Xen HVM per vcpu emulation context */
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index feab88a13026..7a4260416d88 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -224,6 +224,7 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 
 static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
 	if (evmptr_is_valid(vmx->nested.hv_evmcs_vmptr)) {
@@ -232,6 +233,12 @@ static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
 	}
 
 	vmx->nested.hv_evmcs_vmptr = EVMPTR_INVALID;
+
+	if (hv_vcpu) {
+		hv_vcpu->nested.pa_page_gpa = INVALID_GPA;
+		hv_vcpu->nested.vm_id = 0;
+		hv_vcpu->nested.vp_id = 0;
+	}
 }
 
 static void vmx_sync_vmcs_host_state(struct vcpu_vmx *vmx,
@@ -1556,11 +1563,19 @@ static void copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx, u32 hv_clean_fields
 {
 	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
 	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(&vmx->vcpu);
 
 	/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
 	vmcs12->tpr_threshold = evmcs->tpr_threshold;
 	vmcs12->guest_rip = evmcs->guest_rip;
 
+	if (unlikely(!(hv_clean_fields &
+		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_ENLIGHTENMENTSCONTROL))) {
+		hv_vcpu->nested.pa_page_gpa = evmcs->partition_assist_page;
+		hv_vcpu->nested.vm_id = evmcs->hv_vm_id;
+		hv_vcpu->nested.vp_id = evmcs->hv_vp_id;
+	}
+
 	if (unlikely(!(hv_clean_fields &
 		       HV_VMX_ENLIGHTENED_CLEAN_FIELD_GUEST_BASIC))) {
 		vmcs12->guest_rsp = evmcs->guest_rsp;
-- 
2.37.3

