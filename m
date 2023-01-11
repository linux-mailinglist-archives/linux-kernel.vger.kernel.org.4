Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1226665C72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbjAKNZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbjAKNYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:24:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAC35F55
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673443443; x=1704979443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SGiBGTV0pV1LSdKWzpftY7fVqqKe+kxFUGucNy6ovfQ=;
  b=Oy5FJwB+61G2i6gJr80oroQ8roSJKes7dWld9/8aSOTye5qGxlC3TRmL
   Ur2f9k2GaGa1crgRs28LsfST7JPDam1tprmYbEwDcCmCXiqVM2sOynNuD
   s0ln8ugV52Yb1TorUVcvxCG9JJ5La4TI+OERDVdcA3qXPMkBHRnMVEyNg
   OsLVpvJaeIWwsV4+NhXRV0wMhrpsbHbtXqyUg3IWz1mitveHjvjvWqIf7
   79FOlQ/5TnnnnMl3bSDfqc2Cu2x0xH/4gCSPnsjlVq4O9xEx9ZBeW57iK
   gZcn25AhLCZJT7F+kPUiT1K2z1gVM7F/xGERKT97ke9sAUZ4ucf0ToSxB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324646159"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="324646159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:24:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720725511"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="720725511"
Received: from bachaue1-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.250])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:23:56 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3DF10109C8B; Wed, 11 Jan 2023 15:37:41 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv14 06/17] x86/uaccess: Provide untagged_addr() and remove tags before address check
Date:   Wed, 11 Jan 2023 15:37:25 +0300
Message-Id: <20230111123736.20025-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
References: <20230111123736.20025-1-kirill.shutemov@linux.intel.com>
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

untagged_addr() is a helper used by the core-mm to strip tag bits and
get the address to the canonical shape based on rules of the current
thread. It only handles userspace addresses.

The untagging mask is stored in per-CPU variable and set on context
switching to the task.

The tags must not be included into check whether it's okay to access the
userspace address. Strip tags in access_ok().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h         |  3 +++
 arch/x86/include/asm/mmu_context.h | 11 +++++++++++
 arch/x86/include/asm/tlbflush.h    | 10 ++++++++++
 arch/x86/include/asm/uaccess.h     | 31 ++++++++++++++++++++++++++++--
 arch/x86/kernel/process.c          |  3 +++
 arch/x86/mm/init.c                 |  5 +++++
 6 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 22fc9fbf1d0a..9cac8c45a647 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -45,6 +45,9 @@ typedef struct {
 #ifdef CONFIG_ADDRESS_MASKING
 	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
 	unsigned long lam_cr3_mask;
+
+	/* Significant bits of the virtual address. Excludes tag bits. */
+	u64 untag_mask;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 8388fccc4700..1d0b743daebb 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -100,6 +100,12 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
+	mm->context.untag_mask = oldmm->context.untag_mask;
+}
+
+static inline void mm_reset_untag_mask(struct mm_struct *mm)
+{
+	mm->context.untag_mask = -1UL;
 }
 
 #else
@@ -112,6 +118,10 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 }
+
+static inline void mm_reset_untag_mask(struct mm_struct *mm)
+{
+}
 #endif
 
 #define enter_lazy_tlb enter_lazy_tlb
@@ -138,6 +148,7 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.execute_only_pkey = -1;
 	}
 #endif
+	mm_reset_untag_mask(mm);
 	init_new_context_ldt(mm);
 	return 0;
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index e8b47f57bd4a..75bfaa421030 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -54,6 +54,15 @@ static inline void cr4_clear_bits(unsigned long mask)
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_ADDRESS_MASKING
+DECLARE_PER_CPU(u64, tlbstate_untag_mask);
+
+static inline u64 current_untag_mask(void)
+{
+	return this_cpu_read(tlbstate_untag_mask);
+}
+#endif
+
 #ifndef MODULE
 /*
  * 6 because 6 should be plenty and struct tlb_state will fit in two cache
@@ -380,6 +389,7 @@ static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
 {
 	this_cpu_write(cpu_tlbstate.lam,
 		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
 }
 
 #else
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 1cc756eafa44..32c9dd052e43 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -7,11 +7,13 @@
 #include <linux/compiler.h>
 #include <linux/instrumented.h>
 #include <linux/kasan-checks.h>
+#include <linux/mm_types.h>
 #include <linux/string.h>
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/smap.h>
 #include <asm/extable.h>
+#include <asm/tlbflush.h>
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 static inline bool pagefault_disabled(void);
@@ -21,6 +23,31 @@ static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+/*
+ * Mask out tag bits from the address.
+ *
+ * Magic with the 'sign' allows to untag userspace pointer without any branches
+ * while leaving kernel addresses intact.
+ */
+#define __untagged_addr(untag_mask, addr)	({			\
+	u64 __addr = (__force u64)(addr);				\
+	s64 sign = (s64)__addr >> 63;					\
+	__addr &= untag_mask | sign;					\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_addr(addr) __untagged_addr(current_untag_mask(), addr)
+
+#define untagged_addr_remote(mm, addr)	({				\
+	mmap_assert_locked(mm);						\
+	__untagged_addr((mm)->context.untag_mask, addr);		\
+})
+
+#else
+#define untagged_addr(addr)    (addr)
+#endif
+
 /**
  * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -38,10 +65,10 @@ static inline bool pagefault_disabled(void);
  * Return: true (nonzero) if the memory block may be valid, false (zero)
  * if it is definitely invalid.
  */
-#define access_ok(addr, size)					\
+#define access_ok(addr, size)						\
 ({									\
 	WARN_ON_IN_IRQ();						\
-	likely(__access_ok(addr, size));				\
+	likely(__access_ok(untagged_addr(addr), size));			\
 })
 
 #include <asm-generic/access_ok.h>
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 40d156a31676..ef6bde1d40d8 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/frame.h>
 #include <asm/unwind.h>
 #include <asm/tdx.h>
+#include <asm/mmu_context.h>
 
 #include "process.h"
 
@@ -367,6 +368,8 @@ void arch_setup_new_exec(void)
 		task_clear_spec_ssb_noexec(current);
 		speculation_ctrl_update(read_thread_flags());
 	}
+
+	mm_reset_untag_mask(current->mm);
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d3987359d441..be5c7d1c0265 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1044,6 +1044,11 @@ __visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
 	.cr4 = ~0UL,	/* fail hard if we screw up cr4 shadow initialization */
 };
 
+#ifdef CONFIG_ADDRESS_MASKING
+DEFINE_PER_CPU(u64, tlbstate_untag_mask);
+EXPORT_PER_CPU_SYMBOL(tlbstate_untag_mask);
+#endif
+
 void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache)
 {
 	/* entry 0 MUST be WB (hardwired to speed up translations) */
-- 
2.38.2

