Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92010665E27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjAKOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjAKOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:40:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B75C13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447877; x=1704983877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Lq5/FX0ABfC7h72F60HMHF/CtDYeMSLanwV57PhYYg=;
  b=E9Q6qvjqEEmDFSz9QbJkqQbmTU4incSB5GaugU3p23oLr9P/ij5LPG9r
   Et5sh7z/h72+dt+yBf2nUn46H4t3NeCWcDGpHC/L0r+uSJKrqPmGmo5yQ
   GBpQVww2twoCO8eNAjRgVWyW59UnXNv19MBRScPzKw0vO553YV8P/NJ+Z
   Ao8wQKtCZZS6ZdlJmqfHNEv25qFjI5W9L0D6v0ky04mwJ3IvkAyaU95BC
   Dj7xV59VaAXgmeom3kMzkMUsuWNavFoevYn96uSP+j5QWlvOyK6T7nyut
   pKq3kw+G1Y3bsRrnBJYnxrNByeN6ZiaLGYqrpRKJLBx6ksnCCqGYQIK5Q
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="350655536"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="350655536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:37:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687940578"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="687940578"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:37:50 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 41E21104377; Wed, 11 Jan 2023 17:37:47 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     kirill@shutemov.name
Cc:     ak@linux.intel.com, andreyknvl@gmail.com, ashok.raj@intel.com,
        bharata@amd.com, dave.hansen@linux.intel.com, dvyukov@google.com,
        glider@google.com, hjl.tools@gmail.com,
        jacob.jun.pan@linux.intel.com, kcc@google.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org, peterz@infradead.org,
        rick.p.edgecombe@intel.com, ryabinin.a.a@gmail.com,
        tarasmadan@google.com, torvalds@linux-foundation.org,
        x86@kernel.org
Subject: [PATCHv14.1 04/17] x86/mm: Handle LAM on context switch
Date:   Wed, 11 Jan 2023 17:37:40 +0300
Message-Id: <20230111143740.28106-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111141459.ah7ijfbm733c4g7m@box.shutemov.name>
References: <20230111141459.ah7ijfbm733c4g7m@box.shutemov.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Address Masking mode for userspace pointers encoded in CR3 bits.
The mode is selected per-process and stored in mm_context_t.

switch_mm_irqs_off() now respects selected LAM mode and constructs CR3
accordingly.

The active LAM mode gets recorded in the tlb_state.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
---
 v14.1:
  - Drop unneeded READ_ONCE();
---
 arch/x86/include/asm/mmu.h         |  5 +++
 arch/x86/include/asm/mmu_context.h | 24 ++++++++++++++
 arch/x86/include/asm/tlbflush.h    | 38 ++++++++++++++++++++-
 arch/x86/mm/tlb.c                  | 53 +++++++++++++++++++++---------
 4 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index efa3eaee522c..22fc9fbf1d0a 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -42,6 +42,11 @@ typedef struct {
 	unsigned long flags;
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
+	unsigned long lam_cr3_mask;
+#endif
+
 	struct mutex lock;
 	void __user *vdso;			/* vdso base address */
 	const struct vdso_image *vdso_image;	/* vdso image in use */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 53ef591a6166..a62e70801ea8 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -91,6 +91,29 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 }
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
+{
+	return mm->context.lam_cr3_mask;
+}
+
+static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
+}
+
+#else
+
+static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
+{
+}
+#endif
+
 #define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
@@ -168,6 +191,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	arch_dup_pkeys(oldmm, mm);
 	paravirt_arch_dup_mmap(oldmm, mm);
+	dup_lam(oldmm, mm);
 	return ldt_dup_context(oldmm, mm);
 }
 
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index cda3118f3b27..e8b47f57bd4a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_TLBFLUSH_H
 #define _ASM_X86_TLBFLUSH_H
 
-#include <linux/mm.h>
+#include <linux/mm_types.h>
 #include <linux/sched.h>
 
 #include <asm/processor.h>
@@ -12,6 +12,7 @@
 #include <asm/invpcid.h>
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
+#include <asm/pgtable.h>
 
 void __flush_tlb_all(void);
 
@@ -101,6 +102,16 @@ struct tlb_state {
 	 */
 	bool invalidate_other;
 
+#ifdef CONFIG_ADDRESS_MASKING
+	/*
+	 * Active LAM mode.
+	 *
+	 * X86_CR3_LAM_U57/U48 shifted right by X86_CR3_LAM_U57_BIT or 0 if LAM
+	 * disabled.
+	 */
+	u8 lam;
+#endif
+
 	/*
 	 * Mask that contains TLB_NR_DYN_ASIDS+1 bits to indicate
 	 * the corresponding user PCID needs a flush next time we
@@ -357,6 +368,31 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
 }
 #define huge_pmd_needs_flush huge_pmd_needs_flush
 
+#ifdef CONFIG_ADDRESS_MASKING
+static inline  u64 tlbstate_lam_cr3_mask(void)
+{
+	u64 lam = this_cpu_read(cpu_tlbstate.lam);
+
+	return lam << X86_CR3_LAM_U57_BIT;
+}
+
+static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+{
+	this_cpu_write(cpu_tlbstate.lam,
+		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
+}
+
+#else
+
+static inline u64 tlbstate_lam_cr3_mask(void)
+{
+	return 0;
+}
+
+static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+{
+}
+#endif
 #endif /* !MODULE */
 
 static inline void __native_tlb_flush_global(unsigned long cr4)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index c1e31e9a85d7..8c330a6d0ece 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -154,26 +154,30 @@ static inline u16 user_pcid(u16 asid)
 	return ret;
 }
 
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid, unsigned long lam)
 {
+	unsigned long cr3 = __sme_pa(pgd) | lam;
+
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		return __sme_pa(pgd) | kern_pcid(asid);
+		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
+		cr3 |= kern_pcid(asid);
 	} else {
 		VM_WARN_ON_ONCE(asid != 0);
-		return __sme_pa(pgd);
 	}
+
+	return cr3;
 }
 
-static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid,
+					      unsigned long lam)
 {
-	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 	/*
 	 * Use boot_cpu_has() instead of this_cpu_has() as this function
 	 * might be called during early boot. This should work even after
 	 * boot because all CPU's the have same capabilities:
 	 */
 	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+	return build_cr3(pgd, asid, lam) | CR3_NOFLUSH;
 }
 
 /*
@@ -274,15 +278,16 @@ static inline void invalidate_user_asid(u16 asid)
 		  (unsigned long *)this_cpu_ptr(&cpu_tlbstate.user_pcid_flush_mask));
 }
 
-static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
+static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, unsigned long lam,
+			    bool need_flush)
 {
 	unsigned long new_mm_cr3;
 
 	if (need_flush) {
 		invalidate_user_asid(new_asid);
-		new_mm_cr3 = build_cr3(pgdir, new_asid);
+		new_mm_cr3 = build_cr3(pgdir, new_asid, lam);
 	} else {
-		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid);
+		new_mm_cr3 = build_cr3_noflush(pgdir, new_asid, lam);
 	}
 
 	/*
@@ -491,6 +496,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 {
 	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
 	u64 next_tlb_gen;
@@ -520,7 +526,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * isn't free.
 	 */
 #ifdef CONFIG_DEBUG_VM
-	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid))) {
+	if (WARN_ON_ONCE(__read_cr3() != build_cr3(real_prev->pgd, prev_asid,
+						   tlbstate_lam_cr3_mask()))) {
 		/*
 		 * If we were to BUG here, we'd be very likely to kill
 		 * the system so hard that we don't see the call trace.
@@ -552,9 +559,15 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * instruction.
 	 */
 	if (real_prev == next) {
+		/* Not actually switching mm's */
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
 			   next->context.ctx_id);
 
+		/*
+		 * If this races with another thread that enables lam, 'new_lam'
+		 * might not match tlbstate_lam_cr3_mask().
+		 */
+
 		/*
 		 * Even in lazy TLB mode, the CPU should stay set in the
 		 * mm_cpumask. The TLB shootdown code can figure out from
@@ -622,15 +635,16 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		barrier();
 	}
 
+	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
-		load_new_mm_cr3(next->pgd, new_asid, true);
+		load_new_mm_cr3(next->pgd, new_asid, new_lam, true);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, TLB_FLUSH_ALL);
 	} else {
 		/* The new ASID is already up to date. */
-		load_new_mm_cr3(next->pgd, new_asid, false);
+		load_new_mm_cr3(next->pgd, new_asid, new_lam, false);
 
 		trace_tlb_flush(TLB_FLUSH_ON_TASK_SWITCH, 0);
 	}
@@ -691,6 +705,10 @@ void initialize_tlbstate_and_flush(void)
 	/* Assert that CR3 already references the right mm. */
 	WARN_ON((cr3 & CR3_ADDR_MASK) != __pa(mm->pgd));
 
+	/* LAM expected to be disabled */
+	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
+	WARN_ON(mm_lam_cr3_mask(mm));
+
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
 	 * doesn't work like other CR4 bits because it can only be set from
@@ -699,8 +717,8 @@ void initialize_tlbstate_and_flush(void)
 	WARN_ON(boot_cpu_has(X86_FEATURE_PCID) &&
 		!(cr4_read_shadow() & X86_CR4_PCIDE));
 
-	/* Force ASID 0 and force a TLB flush. */
-	write_cr3(build_cr3(mm->pgd, 0));
+	/* Disable LAM, force ASID 0 and force a TLB flush. */
+	write_cr3(build_cr3(mm->pgd, 0, 0));
 
 	/* Reinitialize tlbstate. */
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
@@ -708,6 +726,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
+	set_tlbstate_lam_mode(mm);
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
@@ -1071,8 +1090,10 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
  */
 unsigned long __get_current_cr3_fast(void)
 {
-	unsigned long cr3 = build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
-		this_cpu_read(cpu_tlbstate.loaded_mm_asid));
+	unsigned long cr3 =
+		build_cr3(this_cpu_read(cpu_tlbstate.loaded_mm)->pgd,
+			  this_cpu_read(cpu_tlbstate.loaded_mm_asid),
+			  tlbstate_lam_cr3_mask());
 
 	/* For now, be very restrictive about when this can be called. */
 	VM_WARN_ON(in_nmi() || preemptible());
-- 
2.38.2

