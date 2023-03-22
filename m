Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178E76C51CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjCVREx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjCVREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:04:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941C3E1CF;
        Wed, 22 Mar 2023 10:03:50 -0700 (PDT)
Date:   Wed, 22 Mar 2023 17:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679504588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EM2B2gXKteL/cc8JOZxRU68arE6jgAKqClUGr7Cvy5c=;
        b=Fy7ISBw1RO3mtEOQOnH5tW8nhbLisBLFTkdmgeYnDILlVDQ0/CsCd0pRbIN8Q4dVGNq/4M
        pXsJW0wCwKzszDPWEp6LMs3fjzjuYf0IPUlbiL2J3I7fxfmwHFjRqnM07rGKTVCbZMB2pU
        V9MG0L9se1dy6gjOYSeNAPDV/pYgSHI7BfUsnv8z9qKrhCNZ/91zbTK8CiCN2g8csHVZ6f
        HzWsg6k0tKXdqGLCIRGfDdBz08GvnHMqX/2+cMKR9HFXVv5+5kIeGxlpVJPBWkFUi/WB5w
        wuFCa5dRIt+KLBqazrf311XDKDtqXnQDCa5Nu6fCBM4ynvtCaJP1p3QkUUaV4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679504588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=EM2B2gXKteL/cc8JOZxRU68arE6jgAKqClUGr7Cvy5c=;
        b=ov1gCtiqPEIyExIlS+VNEqUhyZD5CHh889vj39Je0Yq7yV4qNdSXcu8yP7cKJjgR0/7wPb
        gSpnPoh3enh3WABg==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/uaccess: Provide untagged_addr() and remove tags
 before address check
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Potapenko <glider@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950458759.5837.3318176853736322830.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     74c228d20a51ddb1354409fdbed7b72427339d7b
Gitweb:        https://git.kernel.org/tip/74c228d20a51ddb1354409fdbed7b72427339d7b
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Sun, 12 Mar 2023 14:26:01 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 16 Mar 2023 13:08:39 -07:00

x86/uaccess: Provide untagged_addr() and remove tags before address check

untagged_addr() is a helper used by the core-mm to strip tag bits and
get the address to the canonical shape based on rules of the current
thread. It only handles userspace addresses.

The untagging mask is stored in per-CPU variable and set on context
switching to the task.

The tags must not be included into check whether it's okay to access the
userspace address. Strip tags in access_ok().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Alexander Potapenko <glider@google.com>
Link: https://lore.kernel.org/all/20230312112612.31869-7-kirill.shutemov%40linux.intel.com
---
 arch/x86/include/asm/mmu.h         |  3 ++-
 arch/x86/include/asm/mmu_context.h | 11 ++++++++-
 arch/x86/include/asm/tlbflush.h    | 10 +++++++-
 arch/x86/include/asm/uaccess.h     | 39 +++++++++++++++++++++++++++--
 arch/x86/kernel/process.c          |  3 ++-
 arch/x86/mm/init.c                 |  5 ++++-
 6 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 22fc9fb..9cac8c4 100644
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
index 0295c38..eb1387a 100644
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
index e8b47f5..75bfaa4 100644
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
index 1cc756e..c79ebdb 100644
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
index b650cde..bbc8c4c 100644
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
index cb258f5..659b6c0 100644
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
