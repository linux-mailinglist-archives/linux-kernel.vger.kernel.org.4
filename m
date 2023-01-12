Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA4667B79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbjALQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjALQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:37:28 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EBFBE14;
        Thu, 12 Jan 2023 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673541228; x=1705077228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MhzEgbYbU4DSUBPZWYOeStqm3v82wKV2b1DNlzibG7o=;
  b=mcJ8stwtmEqWgiCf6u7tTQ7EiZUhENwBhxp+UYxqPYV+6c+mE65A5CV5
   0x3Gqd76I1zKghwOtoU9Cek9nGjY1WPnJcWDVR6x7hRrvklTBUWL75AdC
   5mlb4hA/iHUk1Vfk6gGs9ptddKAduh3gtpi6hv661om5TjqBlrbnD2VRo
   4ajCQiAQGNUMxkvWBS3B8NgS1gyoSz2yc31tLQ04tLfPN5RRC1wyBwS0E
   eBt4eI6ozbNsnw0oVbKDjbVYwrnautIzwjtVA1e4bQa+WuunP+FeRydjZ
   El31Cny2vSKy+drei0fuwm8HlPCRAZn56T5MdKp9d73bJ5UBO1J8t+adC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="323811647"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="323811647"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:33:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="721151627"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="721151627"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 08:33:19 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>
Subject: [PATCH v11 002/113] KVM: x86/vmx: Refactor KVM VMX module init/exit functions
Date:   Thu, 12 Jan 2023 08:31:10 -0800
Message-Id: <20cc76b61488d461124c0818ee80268ee5e5afc4.1673539699.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673539699.git.isaku.yamahata@intel.com>
References: <cover.1673539699.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Currently, KVM VMX module initialization/exit functions are a single
function each.  Refactor KVM VMX module initialization functions into KVM
common part and VMX part so that TDX specific part can be added cleanly.
Opportunistically refactor module exit function as well.

The current module initialization flow is,
0.) Check if VMX is supported,
1.) hyper-v specific initialization,
2.) system-wide x86 specific and vendor specific initialization,
3.) Final VMX specific system-wide initialization,
4.) calculate the sizes of VMX kvm structure and VMX vcpu structure,
5.) report those sizes to the KVM common layer and KVM common
    initialization

Refactor the KVM VMX module initialization function into functions with a
wrapper function to separate VMX logic in vmx.c from a file, main.c, common
among VMX and TDX.  Introduce a wrapper function for vmx_init().

The KVM architecture common layer allocates struct kvm with reported size
for architecture-specific code.  The KVM VMX module defines its structure
as struct vmx_kvm { struct kvm; VMX specific members;} and uses it as
struct vmx kvm.  Similar for vcpu structure. TDX KVM patches will define
TDX specific kvm and vcpu structures.

The current module exit function is also a single function, a combination
of VMX specific logic and common KVM logic.  Refactor it into VMX specific
logic and KVM common logic.  This is just refactoring to keep the VMX
specific logic in vmx.c from main.c.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/vmx/main.c    | 51 +++++++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c     | 54 +++++---------------------------------
 arch/x86/kvm/vmx/x86_ops.h | 13 ++++++++-
 3 files changed, 69 insertions(+), 49 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index a39d9d68b1b3..58474511a057 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -154,3 +154,54 @@ struct kvm_x86_init_ops vt_init_ops __initdata = {
 	.runtime_ops = &vt_x86_ops,
 	.pmu_ops = &intel_pmu_ops,
 };
+
+static int __init vt_init(void)
+{
+	unsigned int vcpu_size, vcpu_align;
+	int r;
+
+	if (!kvm_is_vmx_supported())
+		return -EOPNOTSUPP;
+
+	/*
+	 * Note, hv_init_evmcs() touches only VMX knobs, i.e. there's nothing
+	 * to unwind if a later step fails.
+	 */
+	hv_init_evmcs();
+
+	r = kvm_x86_vendor_init(&vt_init_ops);
+	if (r)
+		return r;
+
+	r = vmx_init();
+	if (r)
+		goto err_vmx_init;
+
+	/*
+	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
+	 * exposed to userspace!
+	 */
+	vt_x86_ops.vm_size = sizeof(struct kvm_vmx);
+	vcpu_size = sizeof(struct vcpu_vmx);
+	vcpu_align = __alignof__(struct vcpu_vmx);
+	r = kvm_init(vcpu_size, vcpu_align, THIS_MODULE);
+	if (r)
+		goto err_kvm_init;
+
+	return 0;
+
+err_kvm_init:
+	vmx_exit();
+err_vmx_init:
+	kvm_x86_vendor_exit();
+	return r;
+}
+module_init(vt_init);
+
+static void vt_exit(void)
+{
+	kvm_exit();
+	kvm_x86_vendor_exit();
+	vmx_exit();
+}
+module_exit(vt_exit);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 63155166de45..5de1792c9902 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -553,7 +553,7 @@ static int hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
-static __init void hv_init_evmcs(void)
+__init void hv_init_evmcs(void)
 {
 	int cpu;
 
@@ -589,7 +589,7 @@ static __init void hv_init_evmcs(void)
 	}
 }
 
-static void hv_reset_evmcs(void)
+void hv_reset_evmcs(void)
 {
 	struct hv_vp_assist_page *vp_ap;
 
@@ -613,10 +613,6 @@ static void hv_reset_evmcs(void)
 	vp_ap->current_nested_vmcs = 0;
 	vp_ap->enlighten_vmentry = 0;
 }
-
-#else /* IS_ENABLED(CONFIG_HYPERV) */
-static void hv_init_evmcs(void) {}
-static void hv_reset_evmcs(void) {}
 #endif /* IS_ENABLED(CONFIG_HYPERV) */
 
 /*
@@ -2738,7 +2734,7 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	return 0;
 }
 
-static bool kvm_is_vmx_supported(void)
+bool kvm_is_vmx_supported(void)
 {
 	int cpu = raw_smp_processor_id();
 
@@ -8405,7 +8401,7 @@ static void vmx_cleanup_l1d_flush(void)
 	l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
 }
 
-static void __vmx_exit(void)
+void vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
@@ -8416,32 +8412,10 @@ static void __vmx_exit(void)
 	vmx_cleanup_l1d_flush();
 }
 
-static void vmx_exit(void)
-{
-	kvm_exit();
-	kvm_x86_vendor_exit();
-
-	__vmx_exit();
-}
-module_exit(vmx_exit);
-
-static int __init vmx_init(void)
+int __init vmx_init(void)
 {
 	int r, cpu;
 
-	if (!kvm_is_vmx_supported())
-		return -EOPNOTSUPP;
-
-	/*
-	 * Note, hv_init_evmcs() touches only VMX knobs, i.e. there's nothing
-	 * to unwind if a later step fails.
-	 */
-	hv_init_evmcs();
-
-	r = kvm_x86_vendor_init(&vt_init_ops);
-	if (r)
-		return r;
-
 	/*
 	 * Must be called after common x86 init so enable_ept is properly set
 	 * up. Hand the parameter mitigation value in which was stored in
@@ -8451,7 +8425,7 @@ static int __init vmx_init(void)
 	 */
 	r = vmx_setup_l1d_flush(vmentry_l1d_flush_param);
 	if (r)
-		goto err_l1d_flush;
+		return r;
 
 	vmx_setup_fb_clear_ctrl();
 
@@ -8475,21 +8449,5 @@ static int __init vmx_init(void)
 	if (!enable_ept)
 		allow_smaller_maxphyaddr = true;
 
-	/*
-	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
-	 * exposed to userspace!
-	 */
-	r = kvm_init(sizeof(struct vcpu_vmx), __alignof__(struct vcpu_vmx),
-		     THIS_MODULE);
-	if (r)
-		goto err_kvm_init;
-
 	return 0;
-
-err_kvm_init:
-	__vmx_exit();
-err_l1d_flush:
-	kvm_x86_vendor_exit();
-	return r;
 }
-module_init(vmx_init);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index e9ec4d259ff5..051b5c4b5c2f 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -8,11 +8,22 @@
 
 #include "x86.h"
 
-__init int vmx_hardware_setup(void);
+#if IS_ENABLED(CONFIG_HYPERV)
+__init void hv_init_evmcs(void);
+void hv_reset_evmcs(void);
+#else /* IS_ENABLED(CONFIG_HYPERV) */
+static inline void hv_init_evmcs(void) {}
+static inline void hv_reset_evmcs(void) {}
+#endif /* IS_ENABLED(CONFIG_HYPERV) */
+
+bool kvm_is_vmx_supported(void);
+int __init vmx_init(void);
+void vmx_exit(void);
 
 extern struct kvm_x86_ops vt_x86_ops __initdata;
 extern struct kvm_x86_init_ops vt_init_ops __initdata;
 
+__init int vmx_hardware_setup(void);
 void vmx_hardware_unsetup(void);
 int vmx_check_processor_compat(void);
 int vmx_hardware_enable(void);
-- 
2.25.1

