Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3725F090A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiI3K0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiI3KVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:21:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA315AB50;
        Fri, 30 Sep 2022 03:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664533161; x=1696069161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/VSC/zTeWjJYaVHuyqjuhTCPose3J3idbrcT67ndi1I=;
  b=E9OO9wNonIO6SCbadMUYgZjDPo3jmK7E68Wv/MdPIpnhgZXl+rnNWrGI
   s2UChSNO6ulgG8MDUKo9yRF/3dB6+pngM4ibeUtkb5fP6ygYxmVoCpdaw
   7JABEkd6YmRR8dEGOR6MeJMivDcxR9ngNLCn7AWABz7ZbzO0beHVf7qds
   gryRiB/tL7Glk7SVYP5HCTxf+Bf1x5TaI3bcm+x1is928h7zFC4a8W1ny
   +AmbNrEDYf84wcIcvdujbzT8vJ5eO5oVTX4ef4NQ9CiJv2fko9spRTxaz
   5tC5qMFMl2XukNJWa0FpiBQEmh2CjTKArPf9UIe8bMmXtSlN9X90osn+7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="328540163"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="328540163"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:19:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726807795"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="726807795"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:19:06 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v9 089/105] KVM: TDX: Add a place holder for handler of TDX hypercalls (TDG.VP.VMCALL)
Date:   Fri, 30 Sep 2022 03:18:23 -0700
Message-Id: <23c46b3896a56ca2c7bc980bbd1c27f9dcb8e4b0.1664530908.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664530907.git.isaku.yamahata@intel.com>
References: <cover.1664530907.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

The TDX module specification defines TDG.VP.VMCALL API (TDVMCALL for short)
for the guest TD to call hypercall to VMM.  When the guest TD issues
TDG.VP.VMCALL, the guest TD exits to VMM with a new exit reason of
TDVMCALL.  The arguments from the guest TD and returned values from the VMM
are passed in the guest registers.  The guest RCX registers indicates which
registers are used.  Define helper functions to access those registers as
ABI.

Define the TDVMCALL exit reason, which is carved out from the VMX exit
reason namespace as the TDVMCALL exit from TDX guest to TDX-SEAM is really
just a VM-Exit.  Add a place holder to handle TDVMCALL exit.

Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/uapi/asm/vmx.h |  4 ++-
 arch/x86/kvm/vmx/tdx.c          | 56 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/tdx.h          | 13 ++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/vmx.h b/arch/x86/include/uapi/asm/vmx.h
index b3a30ef3efdd..f0f4a4cf84a7 100644
--- a/arch/x86/include/uapi/asm/vmx.h
+++ b/arch/x86/include/uapi/asm/vmx.h
@@ -93,6 +93,7 @@
 #define EXIT_REASON_TPAUSE              68
 #define EXIT_REASON_BUS_LOCK            74
 #define EXIT_REASON_NOTIFY              75
+#define EXIT_REASON_TDCALL              77
 
 #define VMX_EXIT_REASONS \
 	{ EXIT_REASON_EXCEPTION_NMI,         "EXCEPTION_NMI" }, \
@@ -156,7 +157,8 @@
 	{ EXIT_REASON_UMWAIT,                "UMWAIT" }, \
 	{ EXIT_REASON_TPAUSE,                "TPAUSE" }, \
 	{ EXIT_REASON_BUS_LOCK,              "BUS_LOCK" }, \
-	{ EXIT_REASON_NOTIFY,                "NOTIFY" }
+	{ EXIT_REASON_NOTIFY,                "NOTIFY" }, \
+	{ EXIT_REASON_TDCALL,                "TDCALL" }
 
 #define VMX_EXIT_REASON_FLAGS \
 	{ VMX_EXIT_REASONS_FAILED_VMENTRY,	"FAILED_VMENTRY" }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 7edf28a36d83..3392da81ef14 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -85,6 +85,41 @@ static __always_inline unsigned long tdexit_intr_info(struct kvm_vcpu *vcpu)
 	return kvm_r9_read(vcpu);
 }
 
+#define BUILD_TDVMCALL_ACCESSORS(param, gpr)				\
+static __always_inline							\
+unsigned long tdvmcall_##param##_read(struct kvm_vcpu *vcpu)		\
+{									\
+	return kvm_##gpr##_read(vcpu);					\
+}									\
+static __always_inline void tdvmcall_##param##_write(struct kvm_vcpu *vcpu, \
+						     unsigned long val)	\
+{									\
+	kvm_##gpr##_write(vcpu, val);					\
+}
+BUILD_TDVMCALL_ACCESSORS(a0, r12);
+BUILD_TDVMCALL_ACCESSORS(a1, r13);
+BUILD_TDVMCALL_ACCESSORS(a2, r14);
+BUILD_TDVMCALL_ACCESSORS(a3, r15);
+
+static __always_inline unsigned long tdvmcall_exit_type(struct kvm_vcpu *vcpu)
+{
+	return kvm_r10_read(vcpu);
+}
+static __always_inline unsigned long tdvmcall_leaf(struct kvm_vcpu *vcpu)
+{
+	return kvm_r11_read(vcpu);
+}
+static __always_inline void tdvmcall_set_return_code(struct kvm_vcpu *vcpu,
+						     long val)
+{
+	kvm_r10_write(vcpu, val);
+}
+static __always_inline void tdvmcall_set_return_val(struct kvm_vcpu *vcpu,
+						    unsigned long val)
+{
+	kvm_r11_write(vcpu, val);
+}
+
 static inline bool is_td_vcpu_created(struct vcpu_tdx *tdx)
 {
 	return tdx->tdvpr.added;
@@ -654,7 +689,8 @@ static noinstr void tdx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 					struct vcpu_tdx *tdx)
 {
 	guest_enter_irqoff();
-	tdx->exit_reason.full = __tdx_vcpu_run(tdx->tdvpr.pa, vcpu->arch.regs, 0);
+	tdx->exit_reason.full = __tdx_vcpu_run(tdx->tdvpr.pa, vcpu->arch.regs,
+					tdx->tdvmcall.regs_mask);
 	guest_exit_irqoff();
 }
 
@@ -687,6 +723,11 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu)
 
 	tdx_complete_interrupts(vcpu);
 
+	if (tdx->exit_reason.basic == EXIT_REASON_TDCALL)
+		tdx->tdvmcall.rcx = vcpu->arch.regs[VCPU_REGS_RCX];
+	else
+		tdx->tdvmcall.rcx = 0;
+
 	return EXIT_FASTPATH_NONE;
 }
 
@@ -733,6 +774,17 @@ static int tdx_handle_triple_fault(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int handle_tdvmcall(struct kvm_vcpu *vcpu)
+{
+	switch (tdvmcall_leaf(vcpu)) {
+	default:
+		break;
+	}
+
+	tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_INVALID_OPERAND);
+	return 1;
+}
+
 void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 {
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa & PAGE_MASK);
@@ -1102,6 +1154,8 @@ int tdx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t fastpath)
 		return tdx_handle_exception(vcpu);
 	case EXIT_REASON_EXTERNAL_INTERRUPT:
 		return tdx_handle_external_interrupt(vcpu);
+	case EXIT_REASON_TDCALL:
+		return handle_tdvmcall(vcpu);
 	case EXIT_REASON_EPT_VIOLATION:
 		return tdx_handle_ept_violation(vcpu);
 	case EXIT_REASON_EPT_MISCONFIG:
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index 003544ead8fb..ce2f49e15243 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -92,6 +92,19 @@ struct vcpu_tdx {
 
 	struct list_head cpu_list;
 
+	union {
+		struct {
+			union {
+				struct {
+					u16 gpr_mask;
+					u16 xmm_mask;
+				};
+				u32 regs_mask;
+			};
+			u32 reserved;
+		};
+		u64 rcx;
+	} tdvmcall;
 	union tdx_exit_reason exit_reason;
 
 	bool vcpu_initialized;
-- 
2.25.1

