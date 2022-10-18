Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F3602911
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJRKKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiJRKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897EA6E2EE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666087808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMQabhdwb3BLcuLEzR1DIb/sWdQpYIKs7hPVH4e9Q4s=;
        b=gatk51IVbusQTaDiJY0HOPGR+p8qx/nc8ySYhHRuuIIRz8gvef2VD5SBTfa4CBgiTjKDXv
        6UhIGkKMYyTd/U+LQcsbyrcXA/qj5frpEg003oEfio9/pSdGvJeoqWlPDZm25mo2yMD45D
        t08r2qYzuCCmDtEQc0mGOK+clKB+FMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-RT7eKZ09P32-qMNnFhcHxA-1; Tue, 18 Oct 2022 06:10:05 -0400
X-MC-Unique: RT7eKZ09P32-qMNnFhcHxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 110D4101A58E;
        Tue, 18 Oct 2022 10:10:05 +0000 (UTC)
Received: from ovpn-193-156.brq.redhat.com (ovpn-193-156.brq.redhat.com [10.40.193.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 203BF40AE7F0;
        Tue, 18 Oct 2022 10:10:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] KVM: nVMX: Sanitize primary processor-based VM-execution controls with eVMCS too
Date:   Tue, 18 Oct 2022 12:09:57 +0200
Message-Id: <20221018101000.934413-2-vkuznets@redhat.com>
In-Reply-To: <20221018101000.934413-1-vkuznets@redhat.com>
References: <20221018101000.934413-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only unsupported primary processor-based VM-execution control at the
moment is CPU_BASED_ACTIVATE_TERTIARY_CONTROLS and KVM doesn't expose it
in nested VMX feature MSRs anyway (see nested_vmx_setup_ctls_msrs())
but in preparation to inverting "unsupported with eVMCS" checks (and
for completeness) it's better to sanitize MSR_IA32_VMX_PROCBASED_CTLS/
MSR_IA32_VMX_TRUE_PROCBASED_CTLS too.

No functional change intended.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index d8b23c96d627..337783675731 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -368,6 +368,7 @@ enum evmcs_revision {
 enum evmcs_ctrl_type {
 	EVMCS_EXIT_CTRLS,
 	EVMCS_ENTRY_CTRLS,
+	EVMCS_EXEC_CTRL,
 	EVMCS_2NDEXEC,
 	EVMCS_PINCTRL,
 	EVMCS_VMFUNC,
@@ -381,6 +382,9 @@ static const u32 evmcs_unsupported_ctrls[NR_EVMCS_CTRLS][NR_EVMCS_REVISIONS] = {
 	[EVMCS_ENTRY_CTRLS] = {
 		[EVMCSv1_LEGACY] = EVMCS1_UNSUPPORTED_VMENTRY_CTRL,
 	},
+	[EVMCS_EXEC_CTRL] = {
+		[EVMCSv1_LEGACY] = EVMCS1_UNSUPPORTED_EXEC_CTRL,
+	},
 	[EVMCS_2NDEXEC] = {
 		[EVMCSv1_LEGACY] = EVMCS1_UNSUPPORTED_2NDEXEC,
 	},
@@ -441,6 +445,10 @@ void nested_evmcs_filter_control_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 *
 			unsupported_ctrls |= VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
 		ctl_high &= ~unsupported_ctrls;
 		break;
+	case MSR_IA32_VMX_PROCBASED_CTLS:
+	case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
+		ctl_high &= ~evmcs_get_unsupported_ctls(EVMCS_EXEC_CTRL);
+		break;
 	case MSR_IA32_VMX_PROCBASED_CTLS2:
 		ctl_high &= ~evmcs_get_unsupported_ctls(EVMCS_2NDEXEC);
 		break;
@@ -468,6 +476,10 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 					       vmcs12->pin_based_vm_exec_control)))
 		return -EINVAL;
 
+	if (CC(!nested_evmcs_is_valid_controls(EVMCS_EXEC_CTRL,
+					       vmcs12->cpu_based_vm_exec_control)))
+		return -EINVAL;
+
 	if (CC(!nested_evmcs_is_valid_controls(EVMCS_2NDEXEC,
 					       vmcs12->secondary_vm_exec_control)))
 		return -EINVAL;
-- 
2.37.3

