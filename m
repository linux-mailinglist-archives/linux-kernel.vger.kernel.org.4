Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300115F0900
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 12:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiI3KZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiI3KUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:20:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311C21E111A;
        Fri, 30 Sep 2022 03:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664533154; x=1696069154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VS+fjXx5KW+x8trTWHiTY8VED+Gp6eRibRac1D6F8h4=;
  b=No8EqmyiqsnZQ1XZEankw6Pea8K5sCOx0BbH3wjfU7bTrhVW0AiTIGIv
   IbQbSGO+AUGT+P6HwCMFxppqS7IekI9Dz+JUnaVsQvHurhq/l17+HyibW
   JqCLgc4pXRFyKaXqIqMvAWhKhjgFLvdVYMnAzEYv5rxEp8zYIaMA2LEhr
   wuwdlCj8YpW44M/dST40uVUaNwpaBPwWqT1NFBms+GbKVRLgA6dJzVPkF
   5XicxVWAye5rpAb5ND3sgKnGQgSFXplkzUdI0+4g0tDrBsTFhmOBoasp+
   VkTI5YMO+TpXVq6hNXyMI5xRYITdF769Bs0HxjbciwrixBQcsf8aN/2KT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="281870116"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="281870116"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:19:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="726807678"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="726807678"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 03:19:00 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>
Subject: [PATCH v9 054/105] KVM: x86/VMX: introduce vmx tlb_remote_flush and tlb_remote_flush_with_range
Date:   Fri, 30 Sep 2022 03:17:48 -0700
Message-Id: <8cf9b216985bebe427635f963cd216e7e05c35f0.1664530908.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664530907.git.isaku.yamahata@intel.com>
References: <cover.1664530907.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

This is preparation for TDX to define its own tlb_remote_flush and
tlb_remote_flush_with_range.  Currently vmx code defines tlb_remote_flush
and tlb_remote_flush_with_range defined as NULL by default and only when
nested hyper-v guest case, they are defined to non-NULL methods.

To make TDX code to override those two methods consistently with other
methods, define vmx_tlb_remote_flush and vmx_tlb_remote_flush_with_range
as nop and call hyper-v code only when nested hyper-v guest case.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/kvm_onhyperv.c     |  5 ++++-
 arch/x86/kvm/kvm_onhyperv.h     |  1 +
 arch/x86/kvm/mmu/mmu.c          |  2 +-
 arch/x86/kvm/svm/svm_onhyperv.h |  1 +
 arch/x86/kvm/vmx/main.c         |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 34 ++++++++++++++++++++++++++++-----
 arch/x86/kvm/vmx/x86_ops.h      |  3 +++
 7 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/kvm_onhyperv.c b/arch/x86/kvm/kvm_onhyperv.c
index ee4f696a0782..d43518da1c0e 100644
--- a/arch/x86/kvm/kvm_onhyperv.c
+++ b/arch/x86/kvm/kvm_onhyperv.c
@@ -93,11 +93,14 @@ int hv_remote_flush_tlb(struct kvm *kvm)
 }
 EXPORT_SYMBOL_GPL(hv_remote_flush_tlb);
 
+bool hv_use_remote_flush_tlb __ro_after_init;
+EXPORT_SYMBOL_GPL(hv_use_remote_flush_tlb);
+
 void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp)
 {
 	struct kvm_arch *kvm_arch = &vcpu->kvm->arch;
 
-	if (kvm_x86_ops.tlb_remote_flush == hv_remote_flush_tlb) {
+	if (hv_use_remote_flush_tlb) {
 		spin_lock(&kvm_arch->hv_root_tdp_lock);
 		vcpu->arch.hv_root_tdp = root_tdp;
 		if (root_tdp != kvm_arch->hv_root_tdp)
diff --git a/arch/x86/kvm/kvm_onhyperv.h b/arch/x86/kvm/kvm_onhyperv.h
index 287e98ef9df3..9a07a34666fb 100644
--- a/arch/x86/kvm/kvm_onhyperv.h
+++ b/arch/x86/kvm/kvm_onhyperv.h
@@ -10,6 +10,7 @@
 int hv_remote_flush_tlb_with_range(struct kvm *kvm,
 		struct kvm_tlb_range *range);
 int hv_remote_flush_tlb(struct kvm *kvm);
+extern bool hv_use_remote_flush_tlb __ro_after_init;
 void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp);
 #else /* !CONFIG_HYPERV */
 static inline void hv_track_root_tdp(struct kvm_vcpu *vcpu, hpa_t root_tdp)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8b41a73c8264..6bbfaa24d06c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -242,7 +242,7 @@ static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
 {
 	int ret = -ENOTSUPP;
 
-	if (range && kvm_x86_ops.tlb_remote_flush_with_range)
+	if (range && kvm_available_flush_tlb_with_range())
 		ret = static_call(kvm_x86_tlb_remote_flush_with_range)(kvm, range);
 
 	if (ret)
diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
index e2fc59380465..b3cd61c62305 100644
--- a/arch/x86/kvm/svm/svm_onhyperv.h
+++ b/arch/x86/kvm/svm/svm_onhyperv.h
@@ -36,6 +36,7 @@ static inline void svm_hv_hardware_setup(void)
 		svm_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
 		svm_x86_ops.tlb_remote_flush_with_range =
 				hv_remote_flush_tlb_with_range;
+		hv_use_remote_flush_tlb = true;
 	}
 
 	if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH) {
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 4d2717c64c62..025315e0934b 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -178,6 +178,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.flush_tlb_all = vmx_flush_tlb_all,
 	.flush_tlb_current = vmx_flush_tlb_current,
+	.tlb_remote_flush = vmx_tlb_remote_flush,
+	.tlb_remote_flush_with_range = vmx_tlb_remote_flush_with_range,
 	.flush_tlb_gva = vmx_flush_tlb_gva,
 	.flush_tlb_guest = vmx_flush_tlb_guest,
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d78f37e2e2af..3c0587f26f2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3172,6 +3172,33 @@ void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
 		vpid_sync_context(vmx_get_current_vpid(vcpu));
 }
 
+int vmx_tlb_remote_flush(struct kvm *kvm)
+{
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (hv_use_remote_flush_tlb)
+		return hv_remote_flush_tlb(kvm);
+#endif
+	/*
+	 * fallback to KVM_REQ_TLB_FLUSH.
+	 * See kvm_arch_flush_remote_tlb() and kvm_flush_remote_tlbs().
+	 */
+	return -EOPNOTSUPP;
+}
+
+int vmx_tlb_remote_flush_with_range(struct kvm *kvm,
+				    struct kvm_tlb_range *range)
+{
+#if IS_ENABLED(CONFIG_HYPERV)
+	if (hv_use_remote_flush_tlb)
+		return hv_remote_flush_tlb_with_range(kvm, range);
+#endif
+	/*
+	 * fallback to tlb_remote_flush. See
+	 * kvm_flush_remote_tlbs_with_range()
+	 */
+	return -EOPNOTSUPP;
+}
+
 void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
 {
 	/*
@@ -8226,11 +8253,8 @@ __init int vmx_hardware_setup(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
-	    && enable_ept) {
-		vt_x86_ops.tlb_remote_flush = hv_remote_flush_tlb;
-		vt_x86_ops.tlb_remote_flush_with_range =
-				hv_remote_flush_tlb_with_range;
-	}
+	    && enable_ept)
+		hv_use_remote_flush_tlb = true;
 #endif
 
 	if (!cpu_has_vmx_ple()) {
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index d4e8fefc37d1..f3c6ab7e517f 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -92,6 +92,9 @@ void vmx_set_rflags(struct kvm_vcpu *vcpu, unsigned long rflags);
 bool vmx_get_if_flag(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_all(struct kvm_vcpu *vcpu);
 void vmx_flush_tlb_current(struct kvm_vcpu *vcpu);
+int vmx_tlb_remote_flush(struct kvm *kvm);
+int vmx_tlb_remote_flush_with_range(struct kvm *kvm,
+				    struct kvm_tlb_range *range);
 void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr);
 void vmx_flush_tlb_guest(struct kvm_vcpu *vcpu);
 void vmx_set_interrupt_shadow(struct kvm_vcpu *vcpu, int mask);
-- 
2.25.1

