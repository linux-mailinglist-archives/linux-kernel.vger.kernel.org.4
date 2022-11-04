Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E3C619A86
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiKDOs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbiKDOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB8B2EF3C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667573243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G5uZrYNW8KRY7IE0M4RMF/Qh88ncdbKdR3lEziiXd/o=;
        b=fpYHNLaeqV4iU6dwrSl1+btTy7GQ6U15jJBMSakE6y0vftR1QDJc2Hh34XT5C81RjDsVg3
        SHJAwhT3Hz7QIe7eMdvDXMiK7JbnWs6GmCE6LwQ6IfE4yyWa47wTNt5bTU7cSguN0yXEp4
        rZjTW8vx8sISOLcLf/PTUk4vwtx9Fa8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-qO8MsRDFMzKKbFfsa0tXvQ-1; Fri, 04 Nov 2022 10:47:20 -0400
X-MC-Unique: qO8MsRDFMzKKbFfsa0tXvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 637521818212;
        Fri,  4 Nov 2022 14:47:20 +0000 (UTC)
Received: from ovpn-192-136.brq.redhat.com (ovpn-192-136.brq.redhat.com [10.40.192.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60454C16932;
        Fri,  4 Nov 2022 14:47:18 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] KVM: VMX: Resurrect vmcs_conf sanitization for KVM-on-Hyper-V
Date:   Fri,  4 Nov 2022 15:47:08 +0100
Message-Id: <20221104144708.435865-5-vkuznets@redhat.com>
In-Reply-To: <20221104144708.435865-1-vkuznets@redhat.com>
References: <20221104144708.435865-1-vkuznets@redhat.com>
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

Commit 9bcb90650e31 ("KVM: VMX: Get rid of eVMCS specific VMX controls
sanitization") dropped 'vmcs_conf' sanitization for KVM-on-Hyper-V because
there's no known Hyper-V version which would expose a feature
unsupported in eVMCS in VMX feature MSRs. This works well for all
currently existing Hyper-V version, however, future Hyper-V versions
may add features which are supported by KVM and are currently missing
in eVMCSv1 definition (e.g. APIC virtualization, PML,...). When this
happens, existing KVMs will get broken. With the inverted 'unsupported
by eVMCSv1' checks, we can resurrect vmcs_conf sanitization and make
KVM future proof.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/evmcs.c | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/evmcs.h |  1 +
 arch/x86/kvm/vmx/vmx.c   |  5 +++++
 3 files changed, 40 insertions(+)

diff --git a/arch/x86/kvm/vmx/evmcs.c b/arch/x86/kvm/vmx/evmcs.c
index 47f6d1cbd428..c27e3ca59fbc 100644
--- a/arch/x86/kvm/vmx/evmcs.c
+++ b/arch/x86/kvm/vmx/evmcs.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#define pr_fmt(fmt) "kvm/hyper-v: " fmt
+
 #include <linux/errno.h>
 #include <linux/smp.h>
 
@@ -511,6 +513,38 @@ int nested_evmcs_check_controls(struct vmcs12 *vmcs12)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_HYPERV)
+/*
+ * KVM on Hyper-V always uses the latest known eVMCSv1 revision, the assumption
+ * is: in case a feature has corresponding fields in eVMCS described and it was
+ * exposed in VMX feature MSRs, KVM is free to use it. Warn if KVM meets a
+ * feature which has no corresponding eVMCS field, this likely means that KVM
+ * needs to be updated.
+ */
+#define evmcs_check_vmcs_conf(field, ctrl)					\
+	do {									\
+		typeof(vmcs_conf->field) unsupported;				\
+										\
+		unsupported = vmcs_conf->field & ~EVMCS1_SUPPORTED_ ## ctrl;	\
+		if (unsupported) {						\
+			pr_warn_once(#field " unsupported with eVMCS: 0x%llx\n",\
+				     (u64)unsupported);				\
+			vmcs_conf->field &= EVMCS1_SUPPORTED_ ## ctrl;		\
+		}								\
+	}									\
+	while (0)
+
+__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf)
+{
+	evmcs_check_vmcs_conf(cpu_based_exec_ctrl, EXEC_CTRL);
+	evmcs_check_vmcs_conf(pin_based_exec_ctrl, PINCTRL);
+	evmcs_check_vmcs_conf(cpu_based_2nd_exec_ctrl, 2NDEXEC);
+	evmcs_check_vmcs_conf(cpu_based_3rd_exec_ctrl, 3RDEXEC);
+	evmcs_check_vmcs_conf(vmentry_ctrl, VMENTRY_CTRL);
+	evmcs_check_vmcs_conf(vmexit_ctrl, VMEXIT_CTRL);
+}
+#endif
+
 int nested_enable_evmcs(struct kvm_vcpu *vcpu,
 			uint16_t *vmcs_version)
 {
diff --git a/arch/x86/kvm/vmx/evmcs.h b/arch/x86/kvm/vmx/evmcs.h
index 205b5b467617..300e50d52042 100644
--- a/arch/x86/kvm/vmx/evmcs.h
+++ b/arch/x86/kvm/vmx/evmcs.h
@@ -271,6 +271,7 @@ static inline void evmcs_load(u64 phys_addr)
 	vp_ap->enlighten_vmentry = 1;
 }
 
+__init void evmcs_sanitize_exec_ctrls(struct vmcs_config *vmcs_conf);
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static __always_inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 05a747c9a9ff..a54702b44c17 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2721,6 +2721,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	vmcs_conf->vmentry_ctrl        = _vmentry_control;
 	vmcs_conf->misc	= misc_msr;
 
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (enlightened_vmcs)
+		evmcs_sanitize_exec_ctrls(vmcs_conf);
+#endif
+
 	return 0;
 }
 
-- 
2.38.1

