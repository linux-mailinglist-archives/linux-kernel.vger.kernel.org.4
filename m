Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EBC6F9D83
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 03:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjEHBpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 21:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjEHBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 21:45:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F22E156A6
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:45:03 -0700 (PDT)
Received: from kwepemm600017.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QF3rp0czMzTk2V;
        Mon,  8 May 2023 09:40:26 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 09:44:59 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v9 5/5] arm64: support copy_mc_[user]_highpage()
Date:   Mon, 8 May 2023 09:44:36 +0800
Message-ID: <20230508014436.198717-6-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508014436.198717-1-tongtiangen@huawei.com>
References: <20230508014436.198717-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, many scenarios that can tolerate memory errors when copying page
have been supported in the kernel[1][2][3], all of which are implemented by
copy_mc_[user]_highpage(). arm64 should also support this mechanism.

Due to mte, arm64 needs to have its own copy_mc_[user]_highpage()
architecture implementation, macros __HAVE_ARCH_COPY_MC_HIGHPAGE and
__HAVE_ARCH_COPY_MC_USER_HIGHPAGE have been added to control it.

Add new helper copy_mc_page() which provide a page copy implementation with
machine check safe. The copy_mc_page() in copy_mc_page.S is largely borrows
from copy_page() in copy_page.S and the main difference is copy_mc_page()
add extable entry to every load/store insn to support machine check safe.

Add new extable type EX_TYPE_COPY_MC_PAGE_ERR_ZERO which used in
copy_mc_page().

[1]a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")
[2]5f2500b93cc9 ("mm/khugepaged: recover from poisoned anonymous memory")
[3]6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-extable.h | 15 +++++
 arch/arm64/include/asm/assembler.h   |  4 ++
 arch/arm64/include/asm/mte.h         |  5 ++
 arch/arm64/include/asm/page.h        | 10 ++++
 arch/arm64/lib/Makefile              |  2 +
 arch/arm64/lib/copy_mc_page.S        | 89 ++++++++++++++++++++++++++++
 arch/arm64/lib/mte.S                 | 27 +++++++++
 arch/arm64/mm/copypage.c             | 64 +++++++++++++++++---
 arch/arm64/mm/extable.c              |  7 ++-
 include/linux/highmem.h              |  4 ++
 10 files changed, 217 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/lib/copy_mc_page.S

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 980d1dd8e1a3..819044fefbe7 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -10,6 +10,7 @@
 #define EX_TYPE_UACCESS_ERR_ZERO	2
 #define EX_TYPE_KACCESS_ERR_ZERO	3
 #define EX_TYPE_LOAD_UNALIGNED_ZEROPAD	4
+#define EX_TYPE_COPY_MC_PAGE_ERR_ZERO	5
 
 /* Data fields for EX_TYPE_UACCESS_ERR_ZERO */
 #define EX_DATA_REG_ERR_SHIFT	0
@@ -51,6 +52,16 @@
 #define _ASM_EXTABLE_UACCESS(insn, fixup)				\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
 
+#define _ASM_EXTABLE_COPY_MC_PAGE_ERR_ZERO(insn, fixup, err, zero)	\
+	__ASM_EXTABLE_RAW(insn, fixup, 					\
+			  EX_TYPE_COPY_MC_PAGE_ERR_ZERO,		\
+			  (						\
+			    EX_DATA_REG(ERR, err) |			\
+			    EX_DATA_REG(ZERO, zero)			\
+			  ))
+
+#define _ASM_EXTABLE_COPY_MC_PAGE(insn, fixup)				\
+	_ASM_EXTABLE_COPY_MC_PAGE_ERR_ZERO(insn, fixup, wzr, wzr)
 /*
  * Create an exception table entry for uaccess `insn`, which will branch to `fixup`
  * when an unhandled fault is taken.
@@ -59,6 +70,10 @@
 	_ASM_EXTABLE_UACCESS(\insn, \fixup)
 	.endm
 
+	.macro          _asm_extable_copy_mc_page, insn, fixup
+	_ASM_EXTABLE_COPY_MC_PAGE(\insn, \fixup)
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
index c028afb1cd0b..df00d4aa226a 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -92,6 +92,7 @@ static inline bool try_page_mte_tagging(struct page *page)
 void mte_zero_clear_page_tags(void *addr);
 void mte_sync_tags(pte_t old_pte, pte_t pte);
 void mte_copy_page_tags(void *kto, const void *kfrom);
+int mte_copy_mc_page_tags(void *kto, const void *kfrom);
 void mte_thread_init_user(void);
 void mte_thread_switch(struct task_struct *next);
 void mte_cpu_setup(void);
@@ -128,6 +129,10 @@ static inline void mte_sync_tags(pte_t old_pte, pte_t pte)
 static inline void mte_copy_page_tags(void *kto, const void *kfrom)
 {
 }
+static inline int mte_copy_mc_page_tags(void *kto, const void *kfrom)
+{
+	return 0;
+}
 static inline void mte_thread_init_user(void)
 {
 }
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 2312e6ee595f..304cc86b8a10 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -29,6 +29,16 @@ void copy_user_highpage(struct page *to, struct page *from,
 void copy_highpage(struct page *to, struct page *from);
 #define __HAVE_ARCH_COPY_HIGHPAGE
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+int copy_mc_page(void *to, const void *from);
+int copy_mc_highpage(struct page *to, struct page *from);
+#define __HAVE_ARCH_COPY_MC_HIGHPAGE
+
+int copy_mc_user_highpage(struct page *to, struct page *from,
+		unsigned long vaddr, struct vm_area_struct *vma);
+#define __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
+#endif
+
 struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *vma,
 						unsigned long vaddr);
 #define vma_alloc_zeroed_movable_folio vma_alloc_zeroed_movable_folio
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
index 000000000000..656d831ef4b8
--- /dev/null
+++ b/arch/arm64/lib/copy_mc_page.S
@@ -0,0 +1,89 @@
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
+ * Returns:
+ * 	x0 - Return 0 if copy success, or -EFAULT if anything goes wrong
+ *	     while copying.
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
+	mov x0, #0
+	ret
+
+9998:	mov x0, #-EFAULT
+	ret
+
+SYM_FUNC_END(__pi_copy_mc_page)
+SYM_FUNC_ALIAS(copy_mc_page, __pi_copy_mc_page)
+EXPORT_SYMBOL(copy_mc_page)
diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
index 5018ac03b6bf..2b748e83f6cf 100644
--- a/arch/arm64/lib/mte.S
+++ b/arch/arm64/lib/mte.S
@@ -80,6 +80,33 @@ SYM_FUNC_START(mte_copy_page_tags)
 	ret
 SYM_FUNC_END(mte_copy_page_tags)
 
+/*
+ * Copy the tags from the source page to the destination one wiht machine check safe
+ *   x0 - address of the destination page
+ *   x1 - address of the source page
+ * Returns:
+ *   x0 - Return 0 if copy success, or
+ *        -EFAULT if anything goes wrong while copying.
+ */
+SYM_FUNC_START(mte_copy_mc_page_tags)
+	mov	x2, x0
+	mov	x3, x1
+	multitag_transfer_size x5, x6
+1:
+CPY_MC(2f, ldgm	x4, [x3])
+CPY_MC(2f, stgm	x4, [x2])
+	add	x2, x2, x5
+	add	x3, x3, x5
+	tst	x2, #(PAGE_SIZE - 1)
+	b.ne	1b
+
+	mov x0, #0
+	ret
+
+2:	mov x0, #-EFAULT
+	ret
+SYM_FUNC_END(mte_copy_mc_page_tags)
+
 /*
  * Read tags from a user buffer (one tag per byte) and set the corresponding
  * tags at the given kernel address. Used by PTRACE_POKEMTETAGS.
diff --git a/arch/arm64/mm/copypage.c b/arch/arm64/mm/copypage.c
index 4aadcfb01754..7cbc12ee6009 100644
--- a/arch/arm64/mm/copypage.c
+++ b/arch/arm64/mm/copypage.c
@@ -14,21 +14,34 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
 
-void copy_highpage(struct page *to, struct page *from)
+static int do_mte(struct page *to, struct page *from, void *kto, void *kfrom, bool mc)
 {
-	void *kto = page_address(to);
-	void *kfrom = page_address(from);
-
-	copy_page(kto, kfrom);
+	int ret = 0;
 
 	if (system_supports_mte() && page_mte_tagged(from)) {
 		if (kasan_hw_tags_enabled())
 			page_kasan_tag_reset(to);
 		/* It's a new page, shouldn't have been tagged yet */
 		WARN_ON_ONCE(!try_page_mte_tagging(to));
-		mte_copy_page_tags(kto, kfrom);
-		set_page_mte_tagged(to);
+		if (mc)
+			ret = mte_copy_mc_page_tags(kto, kfrom);
+		else
+			mte_copy_page_tags(kto, kfrom);
+
+		if (!ret)
+			set_page_mte_tagged(to);
 	}
+
+	return ret;
+}
+
+void copy_highpage(struct page *to, struct page *from)
+{
+	void *kto = page_address(to);
+	void *kfrom = page_address(from);
+
+	copy_page(kto, kfrom);
+	do_mte(to, from, kto, kfrom, false);
 }
 EXPORT_SYMBOL(copy_highpage);
 
@@ -39,3 +52,40 @@ void copy_user_highpage(struct page *to, struct page *from,
 	flush_dcache_page(to);
 }
 EXPORT_SYMBOL_GPL(copy_user_highpage);
+
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+/*
+ * Return -EFAULT if anything goes wrong while copying page or mte.
+ */
+int copy_mc_highpage(struct page *to, struct page *from)
+{
+	void *kto = page_address(to);
+	void *kfrom = page_address(from);
+	int ret;
+
+	ret = copy_mc_page(kto, kfrom);
+	if (ret)
+		return -EFAULT;
+
+	ret = do_mte(to, from, kto, kfrom, true);
+	if (ret)
+		return -EFAULT;
+
+	return 0;
+}
+EXPORT_SYMBOL(copy_mc_highpage);
+
+int copy_mc_user_highpage(struct page *to, struct page *from,
+			unsigned long vaddr, struct vm_area_struct *vma)
+{
+	int ret;
+
+	ret = copy_mc_highpage(to, from);
+
+	if (!ret)
+		flush_dcache_page(to);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(copy_mc_user_highpage);
+#endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 28ec35e3d210..bdc81518d207 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -16,7 +16,7 @@ get_ex_fixup(const struct exception_table_entry *ex)
 	return ((unsigned long)&ex->fixup + ex->fixup);
 }
 
-static bool ex_handler_uaccess_err_zero(const struct exception_table_entry *ex,
+static bool ex_handler_fixup_err_zero(const struct exception_table_entry *ex,
 					struct pt_regs *regs)
 {
 	int reg_err = FIELD_GET(EX_DATA_REG_ERR, ex->data);
@@ -69,7 +69,7 @@ bool fixup_exception(struct pt_regs *regs)
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
 	case EX_TYPE_KACCESS_ERR_ZERO:
-		return ex_handler_uaccess_err_zero(ex, regs);
+		return ex_handler_fixup_err_zero(ex, regs);
 	case EX_TYPE_LOAD_UNALIGNED_ZEROPAD:
 		return ex_handler_load_unaligned_zeropad(ex, regs);
 	}
@@ -87,7 +87,8 @@ bool fixup_exception_mc(struct pt_regs *regs)
 
 	switch (ex->type) {
 	case EX_TYPE_UACCESS_ERR_ZERO:
-		return ex_handler_uaccess_err_zero(ex, regs);
+	case EX_TYPE_COPY_MC_PAGE_ERR_ZERO:
+		return ex_handler_fixup_err_zero(ex, regs);
 	}
 
 	return false;
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index c29f51ea8517..b36ac0d99176 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -371,19 +371,23 @@ static inline int copy_mc_highpage(struct page *to, struct page *from)
 	return ret ? -EFAULT : 0;
 }
 #else
+#ifndef __HAVE_ARCH_COPY_MC_USER_HIGHPAGE
 static inline int copy_mc_user_highpage(struct page *to, struct page *from,
 					unsigned long vaddr, struct vm_area_struct *vma)
 {
 	copy_user_highpage(to, from, vaddr, vma);
 	return 0;
 }
+#endif
 
+#ifndef __HAVE_ARCH_COPY_MC_HIGHPAGE
 static inline int copy_mc_highpage(struct page *to, struct page *from)
 {
 	copy_highpage(to, from);
 	return 0;
 }
 #endif
+#endif
 
 static inline void memcpy_page(struct page *dst_page, size_t dst_off,
 			       struct page *src_page, size_t src_off,
-- 
2.25.1

