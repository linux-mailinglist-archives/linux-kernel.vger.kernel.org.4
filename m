Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4627B6B656C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjCLL1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjCLL1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:27:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A5B31E28
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620420; x=1710156420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tq6WtwHrazfLXD0XBMc2Q+r2SDElsHETE3zLNMxGwxY=;
  b=k3LKUTF6yAC/ZMEGgbk4wf5VNdENVldHrIfNR3iH6YIxu0S8VEcc4Q02
   7Msfg9r+8gs5snjHYNoP1jiHNoGZerg+qcCR+ENEyJLy5dYTmqznU7m+I
   4lECB9g3QqFl+J3ua43dXe2W7fZOQr7f6GJ9ZaBq2vQxC+ti7cWARVjQb
   Y+GIaJBKI7nbAyRJ7kfX2x9JYvzvjy24cWrDJvTW/J0bbdSXbNfqKAcJw
   OtCIm/QKArBOiZfkNKfEHQDjWt3aHcp0DRgXjeN43mYbcA5bD2gi6hB8D
   YJhzLa0vALsT8wUr3fkJfVY/O90dY2KzRHvRp9Ny0wEpgh/dt7njFF+dR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="399577574"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="399577574"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="671580735"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="671580735"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:30 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8FAA510D7B4; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
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
Subject: [PATCHv16 06/17] x86/uaccess: Provide untagged_addr() and remove tags before address check
Date:   Sun, 12 Mar 2023 14:26:01 +0300
Message-Id: <20230312112612.31869-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
References: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
---
 arch/x86/include/asm/mmu.h         |  3 +++
 arch/x86/include/asm/mmu_context.h | 11 +++++++++
 arch/x86/include/asm/tlbflush.h    | 10 ++++++++
 arch/x86/include/asm/uaccess.h     | 39 ++++++++++++++++++++++++++++--
 arch/x86/kernel/process.c          |  3 +++
 arch/x86/mm/init.c                 |  5 ++++
 6 files changed, 69 insertions(+), 2 deletions(-)

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
index 0295c3863db7..eb1387ac40fa 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -101,6 +101,12 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
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
@@ -113,6 +119,10 @@ static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 }
+
+static inline void mm_reset_untag_mask(struct mm_struct *mm)
+{
+}
 #endif
 
 #define enter_lazy_tlb enter_lazy_tlb
@@ -139,6 +149,7 @@ static inline int init_new_context(struct task_struct *tsk,
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
index 1cc756eafa44..c79ebdbd6356 100644
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
@@ -21,6 +23,39 @@ static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()
 #endif
 
+#ifdef CONFIG_ADDRESS_MASKING
+/*
+ * Mask out tag bits from the address.
+ *
+ * Magic with the 'sign' allows to untag userspace pointer without any branches
+ * while leaving kernel addresses intact.
+ */
+static inline unsigned long __untagged_addr(unsigned long addr,
+					    unsigned long mask)
+{
+	long sign = addr >> 63;
+
+	addr &= mask | sign;
+	return addr;
+}
+
+#define untagged_addr(addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
+	__addr = __untagged_addr(__addr, current_untag_mask());		\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_addr_remote(mm, addr)	({				\
+	u64 __addr = (__force u64)(addr);				\
+	mmap_assert_locked(mm);						\
+	__addr = __untagged_addr(__addr, (mm)->context.untag_mask);	\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#else
+#define untagged_addr(addr)	(addr)
+#endif
+
 /**
  * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -38,10 +73,10 @@ static inline bool pagefault_disabled(void);
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
index b650cde3f64d..bbc8c4c6e360 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -48,6 +48,7 @@
 #include <asm/frame.h>
 #include <asm/unwind.h>
 #include <asm/tdx.h>
+#include <asm/mmu_context.h>
 
 #include "process.h"
 
@@ -368,6 +369,8 @@ void arch_setup_new_exec(void)
 		task_clear_spec_ssb_noexec(current);
 		speculation_ctrl_update(read_thread_flags());
 	}
+
+	mm_reset_untag_mask(current->mm);
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index cb258f58fdc8..659b6c0f7910 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1048,6 +1048,11 @@ __visible DEFINE_PER_CPU_ALIGNED(struct tlb_state, cpu_tlbstate) = {
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
2.39.2

