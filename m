Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E27161280D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 07:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbiJ3G0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 02:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJ3GYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 02:24:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179BE10B;
        Sat, 29 Oct 2022 23:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667111048; x=1698647048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HD0oZM0PQkBmnse5VNjuZto1jI4XWFmzeZByIMhGHcg=;
  b=SsgZWJx4G70prIzMrpPg3N2P0pFlkvfM/xPgKYt66gEc5FS7epPmaCVN
   cO9l6H85AvvnWzIfalOcFTs8W4ysZ6c2ChF8PQdwITqZYdnWnNfVHDqyz
   Bn+zqGna4FeLRKS0UGLuYpVGBseDcBl5fCw+xcLTaBg4pWGEE7+pCXzSm
   aBBfldfvp4qE/eWoxyrzUfNnoXjbg3VVDHvPo6bbctj1kTnUY/wumIVBN
   zoVutYIY2G6xSIBOEzAFr9WP2wqPAYmpbZSrXTUgzD9Xfdvrw5ApNd5bx
   UdVPs5tI1uM/NQotUpWSE7Z++xu457F5NQwM33Wr/LjNVjFJNEfjByv5n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="395037145"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="395037145"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 23:24:02 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="878392951"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="878392951"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 23:24:02 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v10 033/108] KVM: x86/mmu: Allow non-zero value for non-present SPTE and removed SPTE
Date:   Sat, 29 Oct 2022 23:22:34 -0700
Message-Id: <a5be8d9fd5753e17ad2ae4b5fc360501bdf2e84a.1667110240.git.isaku.yamahata@intel.com>
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

For TD guest, the current way to emulate MMIO doesn't work any more, as KVM
is not able to access the private memory of TD guest and do the emulation.
Instead, TD guest expects to receive #VE when it accesses the MMIO and then
it can explicitly makes hypercall to KVM to get the expected information.

To achieve this, the TDX module always enables "EPT-violation #VE" in the
VMCS control.  And accordingly, KVM needs to configure the MMIO spte to
trigger EPT violation (instead of misconfiguration) and at the same time,
also clear the "suppress #VE" bit so the TD guest can get the #VE instead
of causing actual EPT violation to KVM.

In order for KVM to be able to have chance to set up the correct SPTE for
MMIO for TD guest, the default non-present SPTE must have the "suppress
guest accesses the MMIO. Also, when TD guest accesses the actual shared
memory, it should continue to trigger EPT violation to the KVM instead of
receiving the #VE (the TDX module guarantees KVM will receive EPT violation
for private memory access).  This means for the shared memory, the SPTE
also must have the "suppress #VE" bit set for the non-present SPTE.

Add "suppress VE" bit (bit 63) to SHADOW_NONPRESENT_VALUE and REMOVED_SPTE.
Unconditionally set the "suppress #VE" bit (which is bit 63) for both AMD
and Intel as: 1) AMD hardware doesn't use this bit when present bit is off;
2) for normal VMX guest, KVM never enables the "EPT-violation #VE" in VMCS
control and "suppress #VE" bit is ignored by hardware.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/asm/vmx.h |  1 +
 arch/x86/kvm/mmu/spte.c    |  4 +++-
 arch/x86/kvm/mmu/spte.h    | 22 +++++++++++++++++++++-
 arch/x86/kvm/mmu/tdp_mmu.c |  8 ++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 498dc600bd5c..cdbf12c1a83c 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -511,6 +511,7 @@ enum vmcs_field {
 #define VMX_EPT_IPAT_BIT    			(1ull << 6)
 #define VMX_EPT_ACCESS_BIT			(1ull << 8)
 #define VMX_EPT_DIRTY_BIT			(1ull << 9)
+#define VMX_EPT_SUPPRESS_VE_BIT			(1ull << 63)
 #define VMX_EPT_RWX_MASK                        (VMX_EPT_READABLE_MASK |       \
 						 VMX_EPT_WRITABLE_MASK |       \
 						 VMX_EPT_EXECUTABLE_MASK)
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 2e08b2a45361..0b97a045c5f0 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -419,7 +419,9 @@ void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
 	shadow_dirty_mask	= has_ad_bits ? VMX_EPT_DIRTY_BIT : 0ull;
 	shadow_nx_mask		= 0ull;
 	shadow_x_mask		= VMX_EPT_EXECUTABLE_MASK;
-	shadow_present_mask	= has_exec_only ? 0ull : VMX_EPT_READABLE_MASK;
+	/* VMX_EPT_SUPPRESS_VE_BIT is needed for W or X violation. */
+	shadow_present_mask	=
+		(has_exec_only ? 0ull : VMX_EPT_READABLE_MASK) | VMX_EPT_SUPPRESS_VE_BIT;
 	/*
 	 * EPT overrides the host MTRRs, and so KVM must program the desired
 	 * memtype directly into the SPTEs.  Note, this mask is just the mask
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 42ecaa75da15..7e0f79e8f45b 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -148,7 +148,22 @@ static_assert(MMIO_SPTE_GEN_LOW_BITS == 8 && MMIO_SPTE_GEN_HIGH_BITS == 11);
 
 #define MMIO_SPTE_GEN_MASK		GENMASK_ULL(MMIO_SPTE_GEN_LOW_BITS + MMIO_SPTE_GEN_HIGH_BITS - 1, 0)
 
+/*
+ * non-present SPTE value for both VMX and SVM for TDP MMU.
+ * For SVM NPT, for non-present spte (bit 0 = 0), other bits are ignored.
+ * For VMX EPT, bit 63 is ignored if #VE is disabled. (EPT_VIOLATION_VE=0)
+ *              bit 63 is #VE suppress if #VE is enabled. (EPT_VIOLATION_VE=1)
+ * For TDX:
+ *   Secure-EPT: TDX module sets EPT_VIOLATION_VE for Secure-EPT
+ *   private EPT: "suppress #VE" bit is ignored.  CPU doesn't walk it.
+ *   conventional EPT: "suppress #VE" bit must be set to get EPT violation
+ */
+#ifdef CONFIG_X86_64
+#define SHADOW_NONPRESENT_VALUE	BIT_ULL(63)
+static_assert(!(SHADOW_NONPRESENT_VALUE & SPTE_MMU_PRESENT_MASK));
+#else
 #define SHADOW_NONPRESENT_VALUE	0ULL
+#endif
 
 extern u64 __read_mostly shadow_host_writable_mask;
 extern u64 __read_mostly shadow_mmu_writable_mask;
@@ -189,13 +204,18 @@ extern u64 __read_mostly shadow_nonpresent_or_rsvd_mask;
  * non-present intermediate value. Other threads which encounter this value
  * should not modify the SPTE.
  *
+ * For X86_64 case, SHADOW_NONPRESENT_VALUE, "suppress #VE" bit, is set because
+ * "EPT violation #VE" in the secondary VM execution control may be enabled.
+ * Because TDX module sets "EPT violation #VE" for TD, "suppress #VE" bit for
+ * the conventional EPT needs to be set.
+ *
  * Use a semi-arbitrary value that doesn't set RWX bits, i.e. is not-present on
  * bot AMD and Intel CPUs, and doesn't set PFN bits, i.e. doesn't create a L1TF
  * vulnerability.  Use only low bits to avoid 64-bit immediates.
  *
  * Only used by the TDP MMU.
  */
-#define REMOVED_SPTE	0x5a0ULL
+#define REMOVED_SPTE	(SHADOW_NONPRESENT_VALUE | 0x5a0ULL)
 
 /* Removed SPTEs must not be misconstrued as shadow present PTEs. */
 static_assert(!(REMOVED_SPTE & SPTE_MMU_PRESENT_MASK));
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 38bc4c2f0f1f..1eee9c159958 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -693,6 +693,14 @@ static inline int tdp_mmu_zap_spte_atomic(struct kvm *kvm,
 	 * overwrite the special removed SPTE value. No bookkeeping is needed
 	 * here since the SPTE is going from non-present to non-present.  Use
 	 * the raw write helper to avoid an unnecessary check on volatile bits.
+	 *
+	 * Set non-present value to SHADOW_NONPRESENT_VALUE, rather than 0.
+	 * It is because when TDX is enabled, TDX module always
+	 * enables "EPT-violation #VE", so KVM needs to set
+	 * "suppress #VE" bit in EPT table entries, in order to get
+	 * real EPT violation, rather than TDVMCALL.  KVM sets
+	 * SHADOW_NONPRESENT_VALUE (which sets "suppress #VE" bit) so it
+	 * can be set when EPT table entries are zapped.
 	 */
 	__kvm_tdp_mmu_write_spte(iter->sptep, SHADOW_NONPRESENT_VALUE);
 
-- 
2.25.1

