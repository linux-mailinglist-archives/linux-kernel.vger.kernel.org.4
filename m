Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E170EDC1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbjEXGRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbjEXGRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:17:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4B11D;
        Tue, 23 May 2023 23:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684909019; x=1716445019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XvdDalOzO6dPftSCyB2wcRuCPA9Wximcc78/Jb4PyuU=;
  b=O6YA8b4gyjjao9MvU7aUvjmOibaMgokSQMzGNiFW6DM74nrGsp3/xmeM
   pxkSUf4Oe/853hX4dDNA/NtBqZh4/QRok3ewwrMRMJPLauy/Cr4C6IyeM
   OWBS4ZKmO3xAVso+aPNltT3PP6GTI5BLq/fM8OULDshEp4s1hy5XvKCA1
   vvptuh8TzR4hyeevSGX1y57CMPOKB6zWWgNrmdm7fOWDNI5k5zj8VqLS7
   HbqOcOO2vbmK/pYuyVL043fZFznQzA+ujBCV6BlV2oh6vF7dEBbRKki8s
   uWUifq1Xv2NJrZPBxWxABseE7opZDEdYY8q7wXctLQWJ2DNgcdh8qhSZ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="356695065"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="356695065"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="704212361"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="704212361"
Received: from spr.sh.intel.com ([10.239.53.106])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 23:16:54 -0700
From:   Chao Gao <chao.gao@intel.com>
To:     kvm@vger.kernel.org, x86@kernel.org
Cc:     xiaoyao.li@intel.com, Chao Gao <chao.gao@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] KVM: x86: Track supported ARCH_CAPABILITIES in kvm_caps
Date:   Wed, 24 May 2023 14:16:31 +0800
Message-Id: <20230524061634.54141-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230524061634.54141-1-chao.gao@intel.com>
References: <20230524061634.54141-1-chao.gao@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to avoid computing the supported value at runtime every time.

Toggle the ARCH_CAP_SKIP_VMENTRY_L1DFLUSH bit when l1tf_vmx_mitigation
is modified to achieve the same result as runtime computing.

Opportunistically, add a comment to document the problem of allowing
changing the supported value of ARCH_CAPABILITIES and the reason why
we don't fix it.

No functional change intended.

Link: https://lore.kernel.org/all/ZGZhW%2Fx5OWPmx1qD@google.com/
Link: https://lore.kernel.org/all/ZGeU9sYTPxqNGSqI@google.com/
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/kvm/vmx/vmx.c | 25 +++++++++++++++++++++++--
 arch/x86/kvm/x86.c     |  7 ++++---
 arch/x86/kvm/x86.h     |  1 +
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 44fb619803b8..8274ef5e89e5 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -309,10 +309,31 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 
 	l1tf_vmx_mitigation = l1tf;
 
-	if (l1tf != VMENTER_L1D_FLUSH_NEVER)
+	/*
+	 * Update static keys and supported arch capabilities according to
+	 * the new mitigation state.
+	 *
+	 * ARCH_CAP_SKIP_VMENTRY_L1DFLUSH is toggled because if we do cache
+	 * flushes for L1 guests on (nested) vmlaunch/vmresume to L2, L1
+	 * guests can skip the flush and if we don't, then L1 guests need
+	 * to do a flush.
+	 *
+	 * Toggling ARCH_CAP_SKIP_VMENTRY_L1DFLUSH may present inconsistent
+	 * model to the guest, e.g., if userspace isn't careful, a VM can
+	 * have vCPUs with different values for ARCH_CAPABILITIES. But
+	 * there is almost no chance to fix the issue. Because, to present
+	 * a consistent model, KVM essentially needs to disallow changing
+	 * the module param after VMs/vCPUs have been created, but that
+	 * would prevent userspace from toggling the param while VMs are
+	 * running, e.g., in response to a new vulnerability.
+	 */
+	if (l1tf != VMENTER_L1D_FLUSH_NEVER) {
 		static_branch_enable(&vmx_l1d_should_flush);
-	else
+		kvm_caps.supported_arch_cap |= ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
+	} else {
 		static_branch_disable(&vmx_l1d_should_flush);
+		kvm_caps.supported_arch_cap &= ~ARCH_CAP_SKIP_VMENTRY_L1DFLUSH;
+	}
 
 	if (l1tf == VMENTER_L1D_FLUSH_COND)
 		static_branch_enable(&vmx_l1d_flush_cond);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c0778ca39650..2408b5f554b7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1672,7 +1672,7 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_ARCH_CAPABILITIES:
-		msr->data = kvm_get_arch_capabilities();
+		msr->data = kvm_caps.supported_arch_cap;
 		break;
 	case MSR_IA32_PERF_CAPABILITIES:
 		msr->data = kvm_caps.supported_perf_cap;
@@ -7156,7 +7156,7 @@ static void kvm_probe_msr_to_save(u32 msr_index)
 			return;
 		break;
 	case MSR_IA32_TSX_CTRL:
-		if (!(kvm_get_arch_capabilities() & ARCH_CAP_TSX_CTRL_MSR))
+		if (!(kvm_caps.supported_arch_cap & ARCH_CAP_TSX_CTRL_MSR))
 			return;
 		break;
 	default:
@@ -9532,6 +9532,7 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 		kvm_caps.max_guest_tsc_khz = max;
 	}
 	kvm_caps.default_tsc_scaling_ratio = 1ULL << kvm_caps.tsc_scaling_ratio_frac_bits;
+	kvm_caps.supported_arch_cap = kvm_get_arch_capabilities();
 	kvm_init_msr_lists();
 	return 0;
 
@@ -11895,7 +11896,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (r)
 		goto free_guest_fpu;
 
-	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
+	vcpu->arch.arch_capabilities = kvm_caps.supported_arch_cap;
 	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
 	kvm_xen_init_vcpu(vcpu);
 	kvm_vcpu_mtrr_init(vcpu);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index c544602d07a3..d3e524bcc169 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -29,6 +29,7 @@ struct kvm_caps {
 	u64 supported_xcr0;
 	u64 supported_xss;
 	u64 supported_perf_cap;
+	u64 supported_arch_cap;
 };
 
 void kvm_spurious_fault(void);
-- 
2.40.0

