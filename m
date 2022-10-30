Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDD661282D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 07:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJ3G2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 02:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiJ3GZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 02:25:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207AECD;
        Sat, 29 Oct 2022 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667111054; x=1698647054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ufYZmSZ96y68rMKiY+g+qpCyP7GuiojMoXyG0WorRl0=;
  b=ZXbdNmn3FS6afCLIGUTJY2rCVHw4ZiES0txDS3zNfCgYBN86FvXVsdV1
   PAazCSEwdcMK3mOirNnEzl+RGaJJ7QLVqSQxIZk90BaPow6CzzqJ7KXQQ
   +E/bp2IMZQMaSHkGoDoY+E2pQu7z21uctEFHTiTmt0W8vFU7mOVddJHpT
   quwrGSygmTud6UUIwljXsZ6j1YECuUtNi63bfwooFZBUXq+i/evWenWPd
   JXZNDHq3cTWDVDnVojlJpj3AoW9LZ89TMsCTtfegKN3lMQh/Eh+65hRc4
   EV1Xw2q+mEURjEoMXA1tNywUp9k1xp7UOLDO78pjggt4n4HHfTC705W8O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="395037171"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="395037171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 23:24:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="878393033"
X-IronPort-AV: E=Sophos;i="5.95,225,1661842800"; 
   d="scan'208";a="878393033"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 23:24:06 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>
Subject: [PATCH v10 058/108] KVM: TDX: TDP MMU TDX support
Date:   Sat, 29 Oct 2022 23:22:59 -0700
Message-Id: <d94f76ace2078fd3200967a1079a1df14b526758.1667110240.git.isaku.yamahata@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Implement hooks of TDP MMU for TDX backend.  TLB flush, TLB shootdown,
propagating the change private EPT entry to Secure EPT and freeing Secure
EPT page. TLB flush handles both shared EPT and private EPT.  It flushes
shared EPT same as VMX.  It also waits for the TDX TLB shootdown.  For the
hook to free Secure EPT page, unlinks the Secure EPT page from the Secure
EPT so that the page can be freed to OS.

Propagate the entry change to Secure EPT.  The possible entry changes are
present -> non-present(zapping) and non-present -> present(population).  On
population just link the Secure EPT page or the private guest page to the
Secure EPT by TDX SEAMCALL. Because TDP MMU allows concurrent
zapping/population, zapping requires synchronous TLB shoot down with the
frozen EPT entry.  It zaps the secure entry, increments TLB counter, sends
IPI to remote vcpus to trigger TLB flush, and then unlinks the private
guest page from the Secure EPT. For simplicity, batched zapping with
exclude lock is handled as concurrent zapping.  Although it's inefficient,
it can be optimized in the future.

For MMIO SPTE, the spte value changes as follows.
initial value (suppress VE bit is set)
-> Guest issues MMIO and triggers EPT violation
-> KVM updates SPTE value to MMIO value (suppress VE bit is cleared)
-> Guest MMIO resumes.  It triggers VE exception in guest TD
-> Guest VE handler issues TDG.VP.VMCALL<MMIO>
-> KVM handles MMIO
-> Guest VE handler resumes its execution after MMIO instruction

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kvm/mmu/spte.c    |   3 +-
 arch/x86/kvm/vmx/main.c    |  61 +++++++-
 arch/x86/kvm/vmx/tdx.c     | 299 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kvm/vmx/tdx.h     |   7 +
 arch/x86/kvm/vmx/tdx_ops.h |   2 +
 arch/x86/kvm/vmx/x86_ops.h |   4 +
 6 files changed, 368 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 8f468ee2b985..3167c12d9c74 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -74,7 +74,8 @@ u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
 	u64 spte = generation_mmio_spte_mask(gen);
 	u64 gpa = gfn << PAGE_SHIFT;
 
-	WARN_ON_ONCE(!vcpu->kvm->arch.shadow_mmio_value);
+	WARN_ON_ONCE(!vcpu->kvm->arch.shadow_mmio_value &&
+		     !kvm_gfn_shared_mask(vcpu->kvm));
 
 	access &= shadow_mmio_access_mask;
 	spte |= vcpu->kvm->arch.shadow_mmio_value | access;
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index fe9583b640fb..3163915e2e3d 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -100,6 +100,55 @@ static void vt_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	return vmx_vcpu_reset(vcpu, init_event);
 }
 
+static void vt_flush_tlb_all(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return tdx_flush_tlb(vcpu);
+
+	vmx_flush_tlb_all(vcpu);
+}
+
+static void vt_flush_tlb_current(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return tdx_flush_tlb(vcpu);
+
+	vmx_flush_tlb_current(vcpu);
+}
+
+static int vt_tlb_remote_flush(struct kvm *kvm)
+{
+	if (is_td(kvm))
+		return tdx_sept_tlb_remote_flush(kvm);
+
+	return vmx_tlb_remote_flush(kvm);
+}
+
+static int vt_tlb_remote_flush_with_range(struct kvm *kvm,
+					  struct kvm_tlb_range *range)
+{
+	if (is_td(kvm))
+		return -EOPNOTSUPP; /* fall back to tlb_remote_flush */
+
+	return vmx_tlb_remote_flush_with_range(kvm, range);
+}
+
+static void vt_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
+{
+	if (KVM_BUG_ON(is_td_vcpu(vcpu), vcpu->kvm))
+		return;
+
+	vmx_flush_tlb_gva(vcpu, addr);
+}
+
+static void vt_flush_tlb_guest(struct kvm_vcpu *vcpu)
+{
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_flush_tlb_guest(vcpu);
+}
+
 static void vt_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa,
 			int pgd_level)
 {
@@ -176,12 +225,12 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.set_rflags = vmx_set_rflags,
 	.get_if_flag = vmx_get_if_flag,
 
-	.flush_tlb_all = vmx_flush_tlb_all,
-	.flush_tlb_current = vmx_flush_tlb_current,
-	.tlb_remote_flush = vmx_tlb_remote_flush,
-	.tlb_remote_flush_with_range = vmx_tlb_remote_flush_with_range,
-	.flush_tlb_gva = vmx_flush_tlb_gva,
-	.flush_tlb_guest = vmx_flush_tlb_guest,
+	.flush_tlb_all = vt_flush_tlb_all,
+	.flush_tlb_current = vt_flush_tlb_current,
+	.tlb_remote_flush = vt_tlb_remote_flush,
+	.tlb_remote_flush_with_range = vt_tlb_remote_flush_with_range,
+	.flush_tlb_gva = vt_flush_tlb_gva,
+	.flush_tlb_guest = vt_flush_tlb_guest,
 
 	.vcpu_pre_run = vmx_vcpu_pre_run,
 	.vcpu_run = vmx_vcpu_run,
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 6328eaa65126..5378d2c35e27 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -6,7 +6,9 @@
 #include "capabilities.h"
 #include "x86_ops.h"
 #include "tdx.h"
+#include "vmx.h"
 #include "x86.h"
+#include "mmu.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "tdx: " fmt
@@ -295,6 +297,22 @@ int tdx_vm_init(struct kvm *kvm)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 
+	/*
+	 * Because guest TD is protected, VMM can't parse the instruction in TD.
+	 * Instead, guest uses MMIO hypercall.  For unmodified device driver,
+	 * #VE needs to be injected for MMIO and #VE handler in TD converts MMIO
+	 * instruction into MMIO hypercall.
+	 *
+	 * SPTE value for MMIO needs to be setup so that #VE is injected into
+	 * TD instead of triggering EPT MISCONFIG.
+	 * - RWX=0 so that EPT violation is triggered.
+	 * - suppress #VE bit is cleared to inject #VE.
+	 */
+	kvm_mmu_set_mmio_spte_value(kvm, 0);
+
+	/* TODO: Enable 2mb and 1gb large page support. */
+	kvm->arch.tdp_max_page_level = PG_LEVEL_4K;
+
 	kvm_tdx->hkid = -1;
 
 	/*
@@ -399,6 +417,258 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
 	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa & PAGE_MASK);
 }
 
+static void tdx_unpin(struct kvm *kvm, kvm_pfn_t pfn)
+{
+	struct page *page = pfn_to_page(pfn);
+
+	put_page(page);
+}
+
+static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, kvm_pfn_t pfn)
+{
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	hpa_t hpa = pfn_to_hpa(pfn);
+	gpa_t gpa = gfn_to_gpa(gfn);
+	struct tdx_module_output out;
+	u64 err;
+
+	if (WARN_ON_ONCE(is_error_noslot_pfn(pfn) ||
+			 !kvm_pfn_to_refcounted_page(pfn)))
+		return 0;
+
+	/* TODO: handle large pages. */
+	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
+		return -EINVAL;
+
+	/* To prevent page migration, do nothing on mmu notifier. */
+	get_page(pfn_to_page(pfn));
+
+	if (likely(is_td_finalized(kvm_tdx))) {
+		err = tdh_mem_page_aug(kvm_tdx->tdr.pa, gpa, hpa, &out);
+		if (err == TDX_ERROR_SEPT_BUSY) {
+			tdx_unpin(kvm, pfn);
+			return -EAGAIN;
+		}
+		if (KVM_BUG_ON(err, kvm)) {
+			pr_tdx_error(TDH_MEM_PAGE_AUG, err, &out);
+			tdx_unpin(kvm, pfn);
+		}
+		return 0;
+	}
+
+	/* TODO: tdh_mem_page_add() comes here */
+
+	return 0;
+}
+
+static int tdx_sept_drop_private_spte(struct kvm *kvm, gfn_t gfn,
+				       enum pg_level level, kvm_pfn_t pfn)
+{
+	int tdx_level = pg_level_to_tdx_sept_level(level);
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	struct tdx_module_output out;
+	gpa_t gpa = gfn_to_gpa(gfn);
+	hpa_t hpa = pfn_to_hpa(pfn);
+	hpa_t hpa_with_hkid;
+	u64 err;
+
+	/* TODO: handle large pages. */
+	if (KVM_BUG_ON(level != PG_LEVEL_4K, kvm))
+		return -EINVAL;
+
+	if (!is_hkid_assigned(kvm_tdx)) {
+		/*
+		 * The HKID assigned to this TD was already freed and cache
+		 * was already flushed. We don't have to flush again.
+		 */
+		err = tdx_reclaim_page((unsigned long)__va(hpa), hpa, false, 0);
+		if (KVM_BUG_ON(err, kvm))
+			return -EIO;
+		tdx_unpin(kvm, pfn);
+		return 0;
+	}
+
+	do {
+		/*
+		 * When zapping private page, write lock is held. So no race
+		 * condition with other vcpu sept operation.  Race only with
+		 * TDH.VP.ENTER.
+		 */
+		err = tdh_mem_page_remove(kvm_tdx->tdr.pa, gpa, tdx_level, &out);
+	} while (err == TDX_ERROR_SEPT_BUSY);
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error(TDH_MEM_PAGE_REMOVE, err, &out);
+		return -EIO;
+	}
+
+	hpa_with_hkid = set_hkid_to_hpa(hpa, (u16)kvm_tdx->hkid);
+	do {
+		/*
+		 * TDX_OPERAND_BUSY can happen on locking PAMT entry.  Because
+		 * this page was removed above, other thread shouldn't be
+		 * repeatedly operating on this page.  Just retry loop.
+		 */
+		err = tdh_phymem_page_wbinvd(hpa_with_hkid);
+	} while (err == (TDX_OPERAND_BUSY | TDX_OPERAND_ID_RCX));
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error(TDH_PHYMEM_PAGE_WBINVD, err, NULL);
+		return -EIO;
+	}
+	tdx_unpin(kvm, pfn);
+	return 0;
+}
+
+static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, void *private_spt)
+{
+	int tdx_level = pg_level_to_tdx_sept_level(level);
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	gpa_t gpa = gfn_to_gpa(gfn);
+	hpa_t hpa = __pa(private_spt);
+	struct tdx_module_output out;
+	u64 err;
+
+	err = tdh_mem_sept_add(kvm_tdx->tdr.pa, gpa, tdx_level, hpa, &out);
+	if (err == TDX_ERROR_SEPT_BUSY)
+		return -EAGAIN;
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error(TDH_MEM_SEPT_ADD, err, &out);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int tdx_sept_zap_private_spte(struct kvm *kvm, gfn_t gfn,
+				      enum pg_level level)
+{
+	int tdx_level = pg_level_to_tdx_sept_level(level);
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	gpa_t gpa = gfn_to_gpa(gfn);
+	struct tdx_module_output out;
+	u64 err;
+
+	/* For now large page isn't supported yet. */
+	WARN_ON_ONCE(level != PG_LEVEL_4K);
+	err = tdh_mem_range_block(kvm_tdx->tdr.pa, gpa, tdx_level, &out);
+	if (err == TDX_ERROR_SEPT_BUSY)
+		return -EAGAIN;
+	if (KVM_BUG_ON(err, kvm)) {
+		pr_tdx_error(TDH_MEM_RANGE_BLOCK, err, &out);
+		return -EIO;
+	}
+	return 0;
+}
+
+/*
+ * TLB shoot down procedure:
+ * There is a global epoch counter and each vcpu has local epoch counter.
+ * - TDH.MEM.RANGE.BLOCK(TDR. level, range) on one vcpu
+ *   This blocks the subsequenct creation of TLB translation on that range.
+ *   This corresponds to clear the present bit(all RXW) in EPT entry
+ * - TDH.MEM.TRACK(TDR): advances the epoch counter which is global.
+ * - IPI to remote vcpus
+ * - TDExit and re-entry with TDH.VP.ENTER on remote vcpus
+ * - On re-entry, TDX module compares the local epoch counter with the global
+ *   epoch counter.  If the local epoch counter is older than the global epoch
+ *   counter, update the local epoch counter and flushes TLB.
+ */
+static void tdx_track(struct kvm_tdx *kvm_tdx)
+{
+	u64 err;
+
+	KVM_BUG_ON(!is_hkid_assigned(kvm_tdx), &kvm_tdx->kvm);
+	/* If TD isn't finalized, it's before any vcpu running. */
+	if (unlikely(!is_td_finalized(kvm_tdx)))
+		return;
+
+	/*
+	 * tdx_flush_tlb() waits for this function to issue TDH.MEM.TRACK() by
+	 * the counter.  The counter is used instead of bool because multiple
+	 * TDH_MEM_TRACK() can be issued concurrently by multiple vcpus.
+	 */
+	atomic_inc(&kvm_tdx->tdh_mem_track);
+	/*
+	 * KVM_REQ_TLB_FLUSH waits for the empty IPI handler, ack_flush(), with
+	 * KVM_REQUEST_WAIT.
+	 */
+	kvm_make_all_cpus_request(&kvm_tdx->kvm, KVM_REQ_TLB_FLUSH);
+
+	do {
+		/*
+		 * kvm_flush_remote_tlbs() doesn't allow to return error and
+		 * retry.
+		 */
+		err = tdh_mem_track(kvm_tdx->tdr.pa);
+	} while ((err & TDX_SEAMCALL_STATUS_MASK) == TDX_OPERAND_BUSY);
+
+	/* Release remote vcpu waiting for TDH.MEM.TRACK in tdx_flush_tlb(). */
+	atomic_dec(&kvm_tdx->tdh_mem_track);
+
+	if (KVM_BUG_ON(err, &kvm_tdx->kvm))
+		pr_tdx_error(TDH_MEM_TRACK, err, NULL);
+
+}
+
+static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
+				     enum pg_level level, void *private_spt)
+{
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+
+	/*
+	 * The HKID assigned to this TD was already freed and cache was
+	 * already flushed. We don't have to flush again.
+	 */
+	if (!is_hkid_assigned(kvm_tdx))
+		return tdx_reclaim_page((unsigned long)private_spt,
+					__pa(private_spt), false, 0);
+
+	/*
+	 * free_private_spt() is (obviously) called when a shadow page is being
+	 * zapped.  KVM doesn't (yet) zap private SPs while the TD is active.
+	 * Note: This function is for private shadow page.  Not for private
+	 * guest page.   private guest page can be zapped during TD is active.
+	 * shared <-> private conversion and slot move/deletion.
+	 */
+	KVM_BUG_ON(is_hkid_assigned(kvm_tdx), kvm);
+	return -EINVAL;
+}
+
+int tdx_sept_tlb_remote_flush(struct kvm *kvm)
+{
+	struct kvm_tdx *kvm_tdx;
+
+	if (!is_td(kvm))
+		return -EOPNOTSUPP;
+
+	kvm_tdx = to_kvm_tdx(kvm);
+	if (is_hkid_assigned(kvm_tdx))
+		tdx_track(kvm_tdx);
+
+	return 0;
+}
+
+static int tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
+					 enum pg_level level, kvm_pfn_t pfn)
+{
+	/*
+	 * TDX requires TLB tracking before dropping private page.  Do
+	 * it here, although it is also done later.
+	 * If hkid isn't assigned, the guest is destroying and no vcpu
+	 * runs further.  TLB shootdown isn't needed.
+	 *
+	 * TODO: implement with_range version for optimization.
+	 * kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+	 *   => tdx_sept_tlb_remote_flush_with_range(kvm, gfn,
+	 *                                 KVM_PAGES_PER_HPAGE(level));
+	 */
+	if (is_hkid_assigned(to_kvm_tdx(kvm)))
+		kvm_flush_remote_tlbs(kvm);
+
+	return tdx_sept_drop_private_spte(kvm, gfn, level, pfn);
+}
+
 int tdx_dev_ioctl(void __user *argp)
 {
 	struct kvm_tdx_capabilities __user *user_caps;
@@ -802,6 +1072,25 @@ static int tdx_td_init(struct kvm *kvm, struct kvm_tdx_cmd *cmd)
 	return ret;
 }
 
+void tdx_flush_tlb(struct kvm_vcpu *vcpu)
+{
+	struct kvm_tdx *kvm_tdx = to_kvm_tdx(vcpu->kvm);
+	struct kvm_mmu *mmu = vcpu->arch.mmu;
+	u64 root_hpa = mmu->root.hpa;
+
+	/* Flush the shared EPTP, if it's valid. */
+	if (VALID_PAGE(root_hpa))
+		ept_sync_context(construct_eptp(vcpu, root_hpa,
+						mmu->root_role.level));
+
+	/*
+	 * See tdx_track().  Wait for tlb shootdown initiater to finish
+	 * TDH_MEM_TRACK() so that TLB is flushed on the next TDENTER.
+	 */
+	while (atomic_read(&kvm_tdx->tdh_mem_track))
+		cpu_relax();
+}
+
 int tdx_vm_ioctl(struct kvm *kvm, void __user *argp)
 {
 	struct kvm_tdx_cmd tdx_cmd;
@@ -1011,8 +1300,16 @@ int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops)
 	if (!r)
 		r = tdx_module_setup();
 	vmxoff_all();
+	if (r)
+		return r;
 
-	return r;
+	x86_ops->link_private_spt = tdx_sept_link_private_spt;
+	x86_ops->free_private_spt = tdx_sept_free_private_spt;
+	x86_ops->set_private_spte = tdx_sept_set_private_spte;
+	x86_ops->remove_private_spte = tdx_sept_remove_private_spte;
+	x86_ops->zap_private_spte = tdx_sept_zap_private_spte;
+
+	return 0;
 }
 
 void tdx_hardware_unsetup(void)
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index a95f25845f24..80d595c5f96f 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -24,6 +24,7 @@ struct kvm_tdx {
 	int hkid;
 
 	bool finalized;
+	atomic_t tdh_mem_track;
 
 	u64 tsc_offset;
 };
@@ -181,6 +182,12 @@ static __always_inline u64 td_tdcs_exec_read64(struct kvm_tdx *kvm_tdx, u32 fiel
 	return out.r8;
 }
 
+static __always_inline int pg_level_to_tdx_sept_level(enum pg_level level)
+{
+	WARN_ON_ONCE(level == PG_LEVEL_NONE);
+	return level - 1;
+}
+
 #else
 struct kvm_tdx {
 	struct kvm kvm;
diff --git a/arch/x86/kvm/vmx/tdx_ops.h b/arch/x86/kvm/vmx/tdx_ops.h
index 8cc2f01c509b..35e285ae6f9e 100644
--- a/arch/x86/kvm/vmx/tdx_ops.h
+++ b/arch/x86/kvm/vmx/tdx_ops.h
@@ -18,6 +18,8 @@
 
 void pr_tdx_error(u64 op, u64 error_code, const struct tdx_module_output *out);
 
+#define TDX_ERROR_SEPT_BUSY	(TDX_OPERAND_BUSY | TDX_OPERAND_ID_SEPT)
+
 static inline u64 tdh_mng_addcx(hpa_t tdr, hpa_t addr)
 {
 	clflush_cache_range(__va(addr), PAGE_SIZE);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cf7e0c6c65ac..5fccd98be06e 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -151,6 +151,8 @@ void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
 int tdx_vm_ioctl(struct kvm *kvm, void __user *argp);
 int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp);
 
+void tdx_flush_tlb(struct kvm_vcpu *vcpu);
+int tdx_sept_tlb_remote_flush(struct kvm *kvm);
 void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 #else
 static inline int tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { return 0; }
@@ -171,6 +173,8 @@ static inline void tdx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event) {}
 static inline int tdx_vm_ioctl(struct kvm *kvm, void __user *argp) { return -EOPNOTSUPP; }
 static inline int tdx_vcpu_ioctl(struct kvm_vcpu *vcpu, void __user *argp) { return -EOPNOTSUPP; }
 
+static inline void tdx_flush_tlb(struct kvm_vcpu *vcpu) {}
+static inline int tdx_sept_tlb_remote_flush(struct kvm *kvm) { return 0; }
 static inline void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level) {}
 #endif
 
-- 
2.25.1

