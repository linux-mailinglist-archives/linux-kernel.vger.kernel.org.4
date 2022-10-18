Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743EC602A58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJRLgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiJRLfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:35:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEEDBA27D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666092916; x=1697628916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=URl4+yXuTZU7i5eHga9UDkYb72zi7S2whgUd+vZqeAk=;
  b=D+UwM9cnOKfHSbfnZXzEAOwkYc/ez5q3JUFT52pkj/PGAl6QIUbaMIOD
   z1P8zM72DEZRefp8wPNbcvvZZse4ic5R111jXENe5VMXHEN5/UqjIIzlC
   XLk7WoCwuKsmoIZloBPwUoeCzyYR02gbtC7laQvPG25O5JSfjFXtCm1ZE
   QvkwvMkxqpwpN3HdhGFbCVd+gLDgnafRxCZqwgJ9lX1tzjTzGeRUD8YDS
   m2qE2JyqNIx3LMjh7xCgY6Mgsx5FNMIMeZbtY042KtaIJBABhFoQKsZge
   qC6yRKR2XAEdM5Gh/hOWj/MhIPorUfQ+Q7ZB8fzWSJEZIyhOUgAdrbnO2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368105822"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="368105822"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:34:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691763173"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="691763173"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:34:13 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 252BC1046FB; Tue, 18 Oct 2022 14:34:04 +0300 (+03)
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
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 05/15] x86/uaccess: Provide untagged_addr() and remove tags before address check
Date:   Tue, 18 Oct 2022 14:33:48 +0300
Message-Id: <20221018113358.7833-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
References: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

untagged_addr() is a helper used by the core-mm to strip tag bits and
get the address to the canonical shape. In only handles userspace
addresses. The untagging mask is stored in mmu_context and will be set
on enabling LAM for the process.

The tags must not be included into check whether it's okay to access the
userspace address.

Strip tags in access_ok().

get_user() and put_user() don't use access_ok(), but check access
against TASK_SIZE directly in assembly. Strip tags, before calling into
the assembly helper.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mmu.h         |  3 +++
 arch/x86/include/asm/mmu_context.h | 11 ++++++++
 arch/x86/include/asm/uaccess.h     | 42 +++++++++++++++++++++++++++---
 arch/x86/kernel/process.c          |  3 +++
 4 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 002889ca8978..2fdb390040b5 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -43,6 +43,9 @@ typedef struct {
 
 	/* Active LAM mode:  X86_CR3_LAM_U48 or X86_CR3_LAM_U57 or 0 (disabled) */
 	unsigned long lam_cr3_mask;
+
+	/* Significant bits of the virtual address. Excludes tag bits. */
+	u64 untag_mask;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 69c943b2ae90..5bd3d46685dc 100644
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
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 8bc614cfe21b..c6062c07ccd2 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -7,6 +7,7 @@
 #include <linux/compiler.h>
 #include <linux/instrumented.h>
 #include <linux/kasan-checks.h>
+#include <linux/mm_types.h>
 #include <linux/string.h>
 #include <asm/asm.h>
 #include <asm/page.h>
@@ -21,6 +22,30 @@ static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()
 #endif
 
+#ifdef CONFIG_X86_64
+/*
+ * Mask out tag bits from the address.
+ *
+ * Magic with the 'sign' allows to untag userspace pointer without any branches
+ * while leaving kernel addresses intact.
+ */
+#define untagged_addr(mm, addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
+	s64 sign = (s64)__addr >> 63;					\
+	__addr &= (mm)->context.untag_mask | sign;			\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_ptr(mm, ptr)	({					\
+	u64 __ptrval = (__force u64)(ptr);				\
+	__ptrval = untagged_addr(mm, __ptrval);				\
+	(__force __typeof__(*(ptr)) *)__ptrval;				\
+})
+#else
+#define untagged_addr(mm, addr)	(addr)
+#define untagged_ptr(mm, ptr)	(ptr)
+#endif
+
 /**
  * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -41,7 +66,7 @@ static inline bool pagefault_disabled(void);
 #define access_ok(addr, size)					\
 ({									\
 	WARN_ON_IN_IRQ();						\
-	likely(__access_ok(addr, size));				\
+	likely(__access_ok(untagged_addr(current->mm, addr), size));	\
 })
 
 #include <asm-generic/access_ok.h>
@@ -127,7 +152,13 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
+#define get_user(x,ptr)							\
+({									\
+	__typeof__(*(ptr)) __user *__ptr_clean;				\
+	__ptr_clean = untagged_ptr(current->mm, ptr);			\
+	might_fault();							\
+	do_get_user_call(get_user,x,__ptr_clean);			\
+})
 
 /**
  * __get_user - Get a simple variable from user space, with less checking.
@@ -227,7 +258,12 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
+#define put_user(x, ptr) ({						\
+	__typeof__(*(ptr)) __user *__ptr_clean;				\
+	__ptr_clean = untagged_ptr(current->mm, ptr);			\
+	might_fault();							\
+	do_put_user_call(put_user,x,__ptr_clean);			\
+})
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index c21b7347a26d..d1e83ba21130 100644
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
-- 
2.38.0

