Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000676127BF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 07:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ3GYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 02:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ3GYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 02:24:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02043A8;
        Sat, 29 Oct 2022 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667111040; x=1698647040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wz0IOBwmt08sjnia6i0n3OJTM/lMAvZ79Lb70SgXMts=;
  b=PcRz3WlvN2kzIZzgkGZNjbmHgKfH4IfslmkHfAIsJw4rFyq0IEQnj+N9
   PPYaxj0J4uERFOvNGUxubutU5FYbuMg5CSAEu9HJnB2/UkDUS1yBxH7+G
   Kwws201DeQMdKlMkNP5MG3uKVD14UYnI0XaPTK5NoIjuNjakuWUBhLYgU
   wSaRKAvw7QdIRAO0rNHHla8aIXh+bBLCBmrIVS5KuE6sBvxu1IlZoXMtg
   UkdTH2CV3k1qcGU3zPqe3aXsO2DSZLwj8hlVamqh9UhI5m0jAXStEOfjY
   RyCakXK7MXiKZid85dQJqrW7N6iYuPPdh3X+jDR5bp1Q5Y7V1j4h0WSrV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="395037116"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="395037116"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 23:23:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="878392847"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="878392847"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 23:23:57 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v10 006/108] KVM: x86: Introduce vm_type to differentiate default VMs from confidential VMs
Date:   Sat, 29 Oct 2022 23:22:07 -0700
Message-Id: <adf56a24d3a5d01aba3616445cefe45f1d6a2543.1667110240.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667110240.git.isaku.yamahata@intel.com>
References: <cover.1667110240.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Unlike default VMs, confidential VMs (Intel TDX and AMD SEV-ES) don't allow
some operations (e.g., memory read/write, register state access, etc).

Introduce vm_type to track the type of the VM to x86 KVM.  Other arch KVMs
already use vm_type, KVM_INIT_VM accepts vm_type, and x86 KVM callback
vm_init accepts vm_type.  So follow them.  Further, a different policy can
be made based on vm_type.  Define KVM_X86_DEFAULT_VM for default VM as
default and define KVM_X86_TDX_VM for Intel TDX VM.  The wrapper function
will be defined as "bool is_td(kvm) { return vm_type == VM_TYPE_TDX; }"

Add a capability KVM_CAP_VM_TYPES to effectively allow device model,
e.g. qemu, to query what VM types are supported by KVM.  This (introduce a
new capability and add vm_type) is chosen to align with other arch KVMs
that have VM types already.  Other arch KVMs uses different name to query
supported vm types and there is no common name for it, so new name was
chosen.

Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Documentation/virt/kvm/api.rst        | 21 +++++++++++++++++++++
 arch/x86/include/asm/kvm-x86-ops.h    |  1 +
 arch/x86/include/asm/kvm_host.h       |  2 ++
 arch/x86/include/uapi/asm/kvm.h       |  3 +++
 arch/x86/kvm/svm/svm.c                |  6 ++++++
 arch/x86/kvm/vmx/main.c               |  1 +
 arch/x86/kvm/vmx/tdx.h                |  6 +-----
 arch/x86/kvm/vmx/vmx.c                |  5 +++++
 arch/x86/kvm/vmx/x86_ops.h            |  1 +
 arch/x86/kvm/x86.c                    |  9 ++++++++-
 include/uapi/linux/kvm.h              |  1 +
 tools/arch/x86/include/uapi/asm/kvm.h |  3 +++
 tools/include/uapi/linux/kvm.h        |  1 +
 13 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 08253cf498d1..b6f08e8a8320 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -147,10 +147,31 @@ described as 'basic' will be available.
 The new VM has no virtual cpus and no memory.
 You probably want to use 0 as machine type.
 
+X86:
+^^^^
+
+Supported vm type can be queried from KVM_CAP_VM_TYPES, which returns the
+bitmap of supported vm types. The 1-setting of bit @n means vm type with
+value @n is supported.
+
+S390:
+^^^^^
+
 In order to create user controlled virtual machines on S390, check
 KVM_CAP_S390_UCONTROL and use the flag KVM_VM_S390_UCONTROL as
 privileged user (CAP_SYS_ADMIN).
 
+MIPS:
+^^^^^
+
+To use hardware assisted virtualization on MIPS (VZ ASE) rather than
+the default trap & emulate implementation (which changes the virtual
+memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
+flag KVM_VM_MIPS_VZ.
+
+ARM64:
+^^^^^^
+
 On arm64, the physical address size for a VM (IPA Size limit) is limited
 to 40bits by default. The limit can be configured if the host supports the
 extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 15c1515a0760..8a5c5ae70bc5 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -19,6 +19,7 @@ KVM_X86_OP(hardware_disable)
 KVM_X86_OP(hardware_unsetup)
 KVM_X86_OP(has_emulated_msr)
 KVM_X86_OP(vcpu_after_set_cpuid)
+KVM_X86_OP(is_vm_type_supported)
 KVM_X86_OP(vm_init)
 KVM_X86_OP_OPTIONAL(vm_destroy)
 KVM_X86_OP_OPTIONAL_RET0(vcpu_precreate)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 66b1ff1cec61..2a41a93a80f3 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1151,6 +1151,7 @@ enum kvm_apicv_inhibit {
 };
 
 struct kvm_arch {
+	unsigned long vm_type;
 	unsigned long n_used_mmu_pages;
 	unsigned long n_requested_mmu_pages;
 	unsigned long n_max_mmu_pages;
@@ -1468,6 +1469,7 @@ struct kvm_x86_ops {
 	bool (*has_emulated_msr)(struct kvm *kvm, u32 index);
 	void (*vcpu_after_set_cpuid)(struct kvm_vcpu *vcpu);
 
+	bool (*is_vm_type_supported)(unsigned long vm_type);
 	unsigned int vm_size;
 	int (*vm_init)(struct kvm *kvm);
 	void (*vm_destroy)(struct kvm *kvm);
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 46de10a809ec..54b08789c402 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -532,4 +532,7 @@ struct kvm_pmu_event_filter {
 #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
 
+#define KVM_X86_DEFAULT_VM	0
+#define KVM_X86_TDX_VM		1
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index aaf5f0623011..2bcf2e1a5271 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4713,6 +4713,11 @@ static void svm_vm_destroy(struct kvm *kvm)
 	sev_vm_destroy(kvm);
 }
 
+static bool svm_is_vm_type_supported(unsigned long type)
+{
+	return type == KVM_X86_DEFAULT_VM;
+}
+
 static int svm_vm_init(struct kvm *kvm)
 {
 	if (!pause_filter_count || !pause_filter_thresh)
@@ -4740,6 +4745,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_free = svm_vcpu_free,
 	.vcpu_reset = svm_vcpu_reset,
 
+	.is_vm_type_supported = svm_is_vm_type_supported,
 	.vm_size = sizeof(struct kvm_svm),
 	.vm_init = svm_vm_init,
 	.vm_destroy = svm_vm_destroy,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index a5cbf3ca2055..22bf49afc761 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -33,6 +33,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.hardware_disable = vmx_hardware_disable,
 	.has_emulated_msr = vmx_has_emulated_msr,
 
+	.is_vm_type_supported = vmx_is_vm_type_supported,
 	.vm_size = sizeof(struct kvm_vmx),
 	.vm_init = vmx_vm_init,
 	.vm_destroy = vmx_vm_destroy,
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index 060bf48ec3d6..473013265bd8 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -15,11 +15,7 @@ struct vcpu_tdx {
 
 static inline bool is_td(struct kvm *kvm)
 {
-	/*
-	 * TDX VM type isn't defined yet.
-	 * return kvm->arch.vm_type == KVM_X86_TDX_VM;
-	 */
-	return false;
+	return kvm->arch.vm_type == KVM_X86_TDX_VM;
 }
 
 static inline bool is_td_vcpu(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 68aef67c5eb7..dc05b78e0a1e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7410,6 +7410,11 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
 	return err;
 }
 
+bool vmx_is_vm_type_supported(unsigned long type)
+{
+	return type == KVM_X86_DEFAULT_VM;
+}
+
 #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
 
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 6196d651a00a..d4877f4f93de 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -27,6 +27,7 @@ void vmx_hardware_unsetup(void);
 int vmx_check_processor_compatibility(void);
 int vmx_hardware_enable(void);
 void vmx_hardware_disable(void);
+bool vmx_is_vm_type_supported(unsigned long type);
 int vmx_vm_init(struct kvm *kvm);
 void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 715a53d4fc3d..91053fdc4512 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4520,6 +4520,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_X86_NOTIFY_VMEXIT:
 		r = kvm_caps.has_notify_vmexit;
 		break;
+	case KVM_CAP_VM_TYPES:
+		r = BIT(KVM_X86_DEFAULT_VM);
+		if (static_call(kvm_x86_is_vm_type_supported)(KVM_X86_TDX_VM))
+			r |= BIT(KVM_X86_TDX_VM);
+		break;
 	default:
 		break;
 	}
@@ -12507,9 +12512,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	int ret;
 	unsigned long flags;
 
-	if (type)
+	if (!static_call(kvm_x86_is_vm_type_supported)(type))
 		return -EINVAL;
 
+	kvm->arch.vm_type = type;
+
 	ret = kvm_page_track_init(kvm);
 	if (ret)
 		goto out;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index fa60b032a405..49386e4de8b8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1216,6 +1216,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_CPU_TOPOLOGY 222
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
 #define KVM_CAP_PRIVATE_MEM 224
+#define KVM_CAP_VM_TYPES 225
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
diff --git a/tools/arch/x86/include/uapi/asm/kvm.h b/tools/arch/x86/include/uapi/asm/kvm.h
index 46de10a809ec..54b08789c402 100644
--- a/tools/arch/x86/include/uapi/asm/kvm.h
+++ b/tools/arch/x86/include/uapi/asm/kvm.h
@@ -532,4 +532,7 @@ struct kvm_pmu_event_filter {
 #define KVM_VCPU_TSC_CTRL 0 /* control group for the timestamp counter (TSC) */
 #define   KVM_VCPU_TSC_OFFSET 0 /* attribute for the TSC offset */
 
+#define KVM_X86_DEFAULT_VM	0
+#define KVM_X86_TDX_VM		1
+
 #endif /* _ASM_X86_KVM_H */
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 0d5d4419139a..812b771d8702 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1178,6 +1178,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_ZPCI_OP 221
 #define KVM_CAP_S390_CPU_TOPOLOGY 222
 #define KVM_CAP_DIRTY_LOG_RING_ACQ_REL 223
+#define KVM_CAP_VM_TYPES 225
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.25.1

