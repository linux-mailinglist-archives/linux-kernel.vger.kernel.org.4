Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC6A650B18
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiLSMCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiLSMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:01:27 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0449210CA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:00:50 -0800 (PST)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NbJCy5tD6z16Lkt;
        Mon, 19 Dec 2022 19:59:42 +0800 (CST)
Received: from ubuntu.huawei.com (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 20:00:46 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v8 4/4] arm64: add cow to machine check safe
Date:   Mon, 19 Dec 2022 12:00:08 +0000
Message-ID: <20221219120008.3818828-5-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221219120008.3818828-1-tongtiangen@huawei.com>
References: <20221219120008.3818828-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, Recover from poison consumption from copy-on-write has been
supported[1], arm64 should also support this mechanism.

Add new helper copy_mc_page() which provide a page copy implementation with
machine check safe. At present, only used in cow. In the future, we can
expand more scenes. As long as the consequences of page copy failure are
not fatal(eg: only affect user process), we can use this helper.

The copy_mc_page() in copy_page_mc.S is largely borrows from copy_page()
in copy_page.S and the main difference is copy_mc_page() add extable entry
to every load/store insn to support machine check safe. largely to keep the
patch simple. If needed those optimizations can be folded in.

Add new extable type EX_TYPE_COPY_MC_PAGE which used in copy_mc_page().

[1]https://lore.kernel.org/lkml/20221031201029.102123-1-tony.luck@intel.com/

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h |  5 ++
 arch/arm64/include/asm/assembler.h   |  4 ++
 arch/arm64/include/asm/mte.h         |  4 ++
 arch/arm64/include/asm/page.h        | 10 ++++
 arch/arm64/lib/Makefile              |  2 +
 arch/arm64/lib/copy_mc_page.S        | 82 ++++++++++++++++++++++++++++
 arch/arm64/lib/mte.S                 | 19 +++++++
 arch/arm64/mm/copypage.c             | 42 ++++++++++++--
 arch/arm64/mm/extable.c              |  9 +++
 include/linux/highmem.h              |  2 +
 10 files changed, 173 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/lib/copy_mc_page.S

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 980d1dd8e1a3..32625c2839fb 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -10,6 +10,7 @@
 #define EX_TYPE_UACCESS_ERR_ZERO	2
 #define EX_TYPE_KACCESS_ERR_ZERO	3
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
+#define EX_TYPE_COPY_MC_PAGE		5
 
 /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -59,6 +60,10 @@
 	_ASM_EXTABLE_UACCESS(\insn, \fixup)
 	.endm
 
+	.macro          _asm_extable_copy_mc_page, insn, fixup
+	__ASM_EXTABLE_RAW(\insn, \fixup, EX_TYPE_COPY_MC_PAGE, 0)
+	.endm
+
 /*
  * Create an exception table entry for `insn` if `fixup` is provided. Otherwise
  * do nothing.
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 376a980f2bad..547ab2f85888 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -154,6 +154,10 @@ lr	.req	x30		// link register
 #define CPU_LE(code...) code
 #endif
 
+#define CPY_MC(l, x...)		\
+9999:   x;			\
+	_asm_extable_copy_mc_page    9999b, l
+
 /*
  * Define a macro that constructs a 64-bit value by concatenating two
  * 32-bit registers. Note that on big endian systems the order of the
diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 20dd06d70af5..a7a888ef9dbf 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -92,6 +92,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 void mte_zero_clear_page_tags(void *addr);
 void mte_sync_tags(pte_t old_pte, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
+void mte_copy_mc_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
 void mte_cpu_setup(void);
@@ -128,6 +129,9 @@ static inline void mte_sync_tags(pte_t old_pte, pte_t pte)
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
 {
 }
+static inline void mte_copy_mc_page_tags(void *kto, const void *kfrom)
+{
+}
 static inline void mte_thread_init_user(void)
 {
 }
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 993a27ea6f54..0780ac57ac27 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -29,6 +29,16 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+extern void copy_mc_page(void *to, const void *from);
+void copy_mc_highpage(struct page *to, struct page *from);
+#define __HAVE_ARCH_COPY_MC_HIGHPAGE
+
+int copy_mc_user_highpage(struct page *to, struct page *from,
+		unsigned long vaddr, struct vm_area_struct *vma);
+#define __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
+#endif
+
 struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
 						unsigned long vaddr);
 #define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE_MOVABLE
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29490be2546b..a2fd865b816d 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -15,6 +15,8 @@ endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
+lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc_page.o
+
 obj-$(CONFIG_CRC32) += crc32.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/arm64/lib/copy_mc_page.S b/arch/arm64/lib/copy_mc_page.S
new file mode 100644
index 000000000000..03d657a182f6
--- /dev/null
+++ b/arch/arm64/lib/copy_mc_page.S
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/assembler.h>
+#include <asm/page.h>
+#include <asm/cpufeature.h>
+#include <asm/alternative.h>
+#include <asm/asm-extable.h>
+
+/*
+ * Copy a page from src to dest (both are page aligned) with machine check
+ *
+ * Parameters:
+ *	x0 - dest
+ *	x1 - src
+ */
+SYM_FUNC_START(__pi_copy_mc_page)
+alternative_if ARM64_HAS_NO_HW_PREFETCH
+	// Prefetch three cache lines ahead.
+	prfm	pldl1strm, [x1, #128]
+	prfm	pldl1strm, [x1, #256]
+	prfm	pldl1strm, [x1, #384]
+alternative_else_nop_endif
+
+CPY_MC(9998f, ldp	x2, x3, [x1])
+CPY_MC(9998f, ldp	x4, x5, [x1, #16])
+CPY_MC(9998f, ldp	x6, x7, [x1, #32])
+CPY_MC(9998f, ldp	x8, x9, [x1, #48])
+CPY_MC(9998f, ldp	x10, x11, [x1, #64])
+CPY_MC(9998f, ldp	x12, x13, [x1, #80])
+CPY_MC(9998f, ldp	x14, x15, [x1, #96])
+CPY_MC(9998f, ldp	x16, x17, [x1, #112])
+
+	add	x0, x0, #256
+	add	x1, x1, #128
+1:
+	tst	x0, #(PAGE_SIZE - 1)
+
+alternative_if ARM64_HAS_NO_HW_PREFETCH
+	prfm	pldl1strm, [x1, #384]
+alternative_else_nop_endif
+
+CPY_MC(9998f, stnp	x2, x3, [x0, #-256])
+CPY_MC(9998f, ldp	x2, x3, [x1])
+CPY_MC(9998f, stnp	x4, x5, [x0, #16 - 256])
+CPY_MC(9998f, ldp	x4, x5, [x1, #16])
+CPY_MC(9998f, stnp	x6, x7, [x0, #32 - 256])
+CPY_MC(9998f, ldp	x6, x7, [x1, #32])
+CPY_MC(9998f, stnp	x8, x9, [x0, #48 - 256])
+CPY_MC(9998f, ldp	x8, x9, [x1, #48])
+CPY_MC(9998f, stnp	x10, x11, [x0, #64 - 256])
+CPY_MC(9998f, ldp	x10, x11, [x1, #64])
+CPY_MC(9998f, stnp	x12, x13, [x0, #80 - 256])
+CPY_MC(9998f, ldp	x12, x13, [x1, #80])
+CPY_MC(9998f, stnp	x14, x15, [x0, #96 - 256])
+CPY_MC(9998f, ldp	x14, x15, [x1, #96])
+CPY_MC(9998f, stnp	x16, x17, [x0, #112 - 256])
+CPY_MC(9998f, ldp	x16, x17, [x1, #112])
+
+	add	x0, x0, #128
+	add	x1, x1, #128
+
+	b.ne	1b
+
+CPY_MC(9998f, stnp	x2, x3, [x0, #-256])
+CPY_MC(9998f, stnp	x4, x5, [x0, #16 - 256])
+CPY_MC(9998f, stnp	x6, x7, [x0, #32 - 256])
+CPY_MC(9998f, stnp	x8, x9, [x0, #48 - 256])
+CPY_MC(9998f, stnp	x10, x11, [x0, #64 - 256])
+CPY_MC(9998f, stnp	x12, x13, [x0, #80 - 256])
+CPY_MC(9998f, stnp	x14, x15, [x0, #96 - 256])
+CPY_MC(9998f, stnp	x16, x17, [x0, #112 - 256])
+
+9998:	ret
+
+SYM_FUNC_END(__pi_copy_mc_page)
+SYM_FUNC_ALIAS(copy_mc_page, __pi_copy_mc_page)
+EXPORT_SYMBOL(copy_mc_page)
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 5018ac03b6bf..bf4dd861c41c 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -80,6 +80,25 @@ SYM_FUNC_START(mte_copy_page_tags)
 	ret
 SYM_FUNC_END(mte_copy_page_tags)
 
+/*
+ * Copy the tags from the source page to the destination one wiht machine check safe
+ *   x0 - address of the destination page
+ *   x1 - address of the source page
+ */
+SYM_FUNC_START(mte_copy_mc_page_tags)
+	mov	x2, x0
+	mov	x3, x1
+	multitag_transfer_size x5, x6
+1:
+CPY_MC(2f, ldgm	x4, [x3])
+	stgm	x4, [x2]
+	add	x2, x2, x5
+	add	x3, x3, x5
+	tst	x2, #(PAGE_SIZE - 1)
+	b.ne	1b
+2:	ret
+SYM_FUNC_END(mte_copy_mc_page_tags)
+
 /*
  * Read tags from a user buffer (one tag per byte) and set the corresponding
  * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 8dd5a8fe64b4..005ee2a3cb4e 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -14,21 +14,30 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
 
-void copy_highpage(struct page *to, struct page *from)
+static void do_mte(struct page *to, struct page *from, void *kto, void *kfrom, bool mc)
 {
-	void *kto = page_address(to);
-	void *kfrom = page_address(from);
-
-	copy_page(kto, kfrom);
 
 	if (system_supports_mte() && page_mte_tagged(from)) {
 		page_kasan_tag_reset(to);
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
-		mte_copy_page_tags(kto, kfrom);
+		if (mc)
+			mte_copy_mc_page_tags(kto, kfrom);
+		else
+			mte_copy_page_tags(kto, kfrom);
+
 		set_page_mte_tagged(to);
 	}
 }
+
+void copy_highpage(struct page *to, struct page *from)
+{
+	void *kto = page_address(to);
+	void *kfrom = page_address(from);
+
+	copy_page(kto, kfrom);
+	do_mte(to, from, kto, kfrom, false);
+}
 EXPORT_SYMBOL(copy_highpage);
 
 void copy_user_highpage(struct page *to, struct page *from,
@@ -38,3 +47,24 @@ void copy_user_highpage(struct page *to, struct page *from,
 	flush_dcache_page(to);
 }
 EXPORT_SYMBOL_GPL(copy_user_highpage);
+
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+void copy_mc_highpage(struct page *to, struct page *from)
+{
+	void *kto = page_address(to);
+	void *kfrom = page_address(from);
+
+	copy_mc_page(kto, kfrom);
+	do_mte(to, from, kto, kfrom, true);
+}
+EXPORT_SYMBOL(copy_mc_highpage);
+
+int copy_mc_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	copy_mc_highpage(to, from);
+	flush_dcache_page(to);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_mc_user_highpage);
+#endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 28ec35e3d210..0fdab18f2f07 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -16,6 +16,13 @@ get_ex_fixup(const struct exception_table_entry *ex)
 	return ((unsigned long)&ex->fixup + ex->fixup);
 }
 
+static bool ex_handler_fixup(const struct exception_table_entry *ex,
+			     struct pt_regs *regs)
+{
+	regs->pc = get_ex_fixup(ex);
+	return true;
+}
+
 static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
 					struct pt_regs *regs)
 {
@@ -88,6 +95,8 @@ bool fixup_exception_mc(struct pt_regs *regs)
 	switch (ex->type) {
 	case EX_TYPE_UACCESS_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
+	case EX_TYPE_COPY_MC_PAGE:
+		return ex_handler_fixup(ex, regs);
 	}
 
 	return false;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 44242268f53b..3ad39d4d81d5 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -319,6 +319,7 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifndef __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
 #ifdef copy_mc_to_kernel
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
@@ -344,6 +345,7 @@ static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 	return 0;
 }
 #endif
+#endif
 
 #ifndef __HAVE_ARCH_COPY_HIGHPAGE
 
-- 
2.25.1

