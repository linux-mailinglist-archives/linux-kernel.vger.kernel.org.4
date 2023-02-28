Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0B46A5411
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjB1IES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjB1IED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:04:03 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EA6522002
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:03:41 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Dx_5dUtf1j42UGAA--.6634S3;
        Tue, 28 Feb 2023 16:03:32 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB707tf1jb3tAAA--.49681S5;
        Tue, 28 Feb 2023 16:03:28 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] LoongArch: Create a exception handlers section
Date:   Tue, 28 Feb 2023 16:02:54 +0800
Message-Id: <20230228080257.28807-4-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230228080257.28807-1-hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB707tf1jb3tAAA--.49681S5
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3ZF4DZr47uryxWFyxWFyrXrb_yoW8Jr13to
        W3C3W09F1rKa12vF9xJF4xJa18XF1ktrZ5A397AFyru3yDu34UW34rt3WvvryjvFs3JrW7
        Cay3JF1kGws3Zrnrn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a section named .ex_handlers to collect exception handlers.
Use strict alignment for using it later. As some handlers is shared
to other exception, we can not define symbol directly. Correct these
symbols by adding suffix or by using number label.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/traps.h  | 39 +++++++++++++++++
 arch/loongarch/kernel/entry.S       |  5 +++
 arch/loongarch/kernel/genex.S       | 65 ++++++++++++++++++++++-------
 arch/loongarch/kernel/vmlinux.lds.S | 19 +++++++++
 arch/loongarch/mm/tlbex.S           | 53 ++++++++++++++++-------
 5 files changed, 149 insertions(+), 32 deletions(-)
 create mode 100644 arch/loongarch/include/asm/traps.h

diff --git a/arch/loongarch/include/asm/traps.h b/arch/loongarch/include/asm/traps.h
new file mode 100644
index 000000000000..b348d66c16a1
--- /dev/null
+++ b/arch/loongarch/include/asm/traps.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+#ifndef _ASM_TRAPS_H
+#define _ASM_TRAPS_H
+
+#include <asm/loongarch.h>		// For EXCCODES
+
+#ifdef __ASSEMBLY__
+/* Used for create exception handlers. */
+#define EXCCODE_UNDEF	26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,	\
+			37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,	\
+			48, 49, 50, 51, 52, 53, 54, 55,	56, 57, 58,	\
+			59, 60, 61, 62, 63
+#define EXCCODE_NOHND	EXCCODE_OOB, EXCCODE_BTE, EXCCODE_PSI,		\
+			EXCCODE_HYP, EXCCODE_GCM, EXCCODE_SE
+
+/* As merrentry is set to the same value as eentry, the merr handler can
+ * be thought as the first exception handler.
+ */
+#define EXCCODE_MERR			EXCCODE_RSV
+
+#define _SET_EXCEPTION_HANDLER(EXCCODE, ...)			\
+	.pushsection .exception_handlers.##EXCCODE, "ax";	\
+	.align	9;						\
+	__VA_ARGS__;						\
+	.popsection;
+
+#define SET_EXCEPTION_HANDLER(EXCCODE, ...)			\
+	_SET_EXCEPTION_HANDLER(EXCCODE, __VA_ARGS__)
+
+#define SET_TLBR_HANDLER(...)					\
+	.pushsection .tlbrhandler, "ax";			\
+	__VA_ARGS__;						\
+	.popsection;
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_TRAPS_H */
diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/entry.S
index d6e9572eb279..ca4651f91e73 100644
--- a/arch/loongarch/kernel/entry.S
+++ b/arch/loongarch/kernel/entry.S
@@ -14,9 +14,11 @@
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
+#include <asm/traps.h>
 
 	.text
 	.cfi_sections	.debug_frame
+	.macro	_handle_sys
 	.align	5
 SYM_FUNC_START(handle_sys)
 	csrrd		t0, PERCPU_BASE_KS
@@ -69,6 +71,9 @@ SYM_FUNC_START(handle_sys)
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_sys)
 _ASM_NOKPROBE(handle_sys)
+	.endm
+
+SET_EXCEPTION_HANDLER(EXCCODE_SYS, _handle_sys)
 
 SYM_CODE_START(ret_from_fork)
 	bl		schedule_tail		# a0 = struct task_struct *prev
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index de591a9270bd..86abafc8b95b 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -15,6 +15,7 @@
 #include <asm/fpregdef.h>
 #include <asm/stackframe.h>
 #include <asm/thread_info.h>
+#include <asm/traps.h>
 
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
@@ -31,7 +32,8 @@ SYM_FUNC_START(__arch_cpu_idle)
 1:	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
-SYM_FUNC_START(handle_vint)
+	.macro _handle_vint idx
+SYM_FUNC_START(handle_vint\idx)
 	BACKUP_T0T1
 	SAVE_ALL
 	la_abs	t1, __arch_cpu_idle
@@ -46,11 +48,14 @@ SYM_FUNC_START(handle_vint)
 	la_abs	t0, do_vint
 	jirl	ra, t0, 0
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_vint)
+SYM_FUNC_END(handle_vint\idx)
+	.endm
 
+	.macro _except_vec_cex
 SYM_FUNC_START(except_vec_cex)
 	b	cache_parity_error
 SYM_FUNC_END(except_vec_cex)
+	.endm
 
 	.macro	build_prep_badv
 	csrrd	t0, LOONGARCH_CSR_BADV
@@ -66,7 +71,7 @@ SYM_FUNC_END(except_vec_cex)
 
 	.macro	BUILD_HANDLER exception handler prep
 	.align	5
-	SYM_FUNC_START(handle_\exception)
+SYM_FUNC_START(handle_\exception)
 	666:
 	BACKUP_T0T1
 	SAVE_ALL
@@ -76,20 +81,48 @@ SYM_FUNC_END(except_vec_cex)
 	jirl	ra, t0, 0
 	668:
 	RESTORE_ALL_AND_RET
-	SYM_FUNC_END(handle_\exception)
+SYM_FUNC_END(handle_\exception)
 	.pushsection .rodata
-	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
+SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
 	.popsection
 	.endm
 
-	BUILD_HANDLER ade ade badv
-	BUILD_HANDLER ale ale badv
-	BUILD_HANDLER bp bp none
-	BUILD_HANDLER fpe fpe fcsr
-	BUILD_HANDLER fpu fpu none
-	BUILD_HANDLER lsx lsx none
-	BUILD_HANDLER lasx lasx none
-	BUILD_HANDLER lbt lbt none
-	BUILD_HANDLER ri ri none
-	BUILD_HANDLER watch watch none
-	BUILD_HANDLER reserved reserved none	/* others */
+SET_EXCEPTION_HANDLER(EXCCODE_SIP0,  _handle_vint)
+SET_EXCEPTION_HANDLER(EXCCODE_SIP1,  _handle_vint 1)
+SET_EXCEPTION_HANDLER(EXCCODE_IP0,   _handle_vint 2)
+SET_EXCEPTION_HANDLER(EXCCODE_IP1,   _handle_vint 3)
+SET_EXCEPTION_HANDLER(EXCCODE_IP2,   _handle_vint 4)
+SET_EXCEPTION_HANDLER(EXCCODE_IP3,   _handle_vint 5)
+SET_EXCEPTION_HANDLER(EXCCODE_IP4,   _handle_vint 6)
+SET_EXCEPTION_HANDLER(EXCCODE_IP5,   _handle_vint 7)
+SET_EXCEPTION_HANDLER(EXCCODE_IP6,   _handle_vint 8)
+SET_EXCEPTION_HANDLER(EXCCODE_IP7,   _handle_vint 9)
+SET_EXCEPTION_HANDLER(EXCCODE_PMC,   _handle_vint 10)
+SET_EXCEPTION_HANDLER(EXCCODE_TIMER, _handle_vint 11)
+SET_EXCEPTION_HANDLER(EXCCODE_IPI,   _handle_vint 12)
+SET_EXCEPTION_HANDLER(EXCCODE_NMI,   _handle_vint 13)
+
+SET_EXCEPTION_HANDLER(EXCCODE_MERR, _except_vec_cex)
+
+SET_EXCEPTION_HANDLER(EXCCODE_ADE,     BUILD_HANDLER ade ade badv)
+SET_EXCEPTION_HANDLER(EXCCODE_ALE,     BUILD_HANDLER ale ale badv)
+SET_EXCEPTION_HANDLER(EXCCODE_BP,      BUILD_HANDLER bp bp none)
+SET_EXCEPTION_HANDLER(EXCCODE_FPE,     BUILD_HANDLER fpe fpe fcsr)
+SET_EXCEPTION_HANDLER(EXCCODE_FPDIS,   BUILD_HANDLER fpu fpu none)
+SET_EXCEPTION_HANDLER(EXCCODE_LSXDIS,  BUILD_HANDLER lsx lsx none)
+SET_EXCEPTION_HANDLER(EXCCODE_LASXDIS, BUILD_HANDLER lasx lasx none)
+SET_EXCEPTION_HANDLER(EXCCODE_BTDIS,   BUILD_HANDLER lbt lbt none)
+SET_EXCEPTION_HANDLER(EXCCODE_INE,     BUILD_HANDLER ri ri none)
+SET_EXCEPTION_HANDLER(EXCCODE_IPE,     BUILD_HANDLER ri1 ri none)
+SET_EXCEPTION_HANDLER(EXCCODE_WATCH,   BUILD_HANDLER watch watch none)
+
+.irp i, EXCCODE_UNDEF
+SET_EXCEPTION_HANDLER(\i, BUILD_HANDLER reserved\i reserved none)
+.endr
+
+.irp i, EXCCODE_NOHND
+SET_EXCEPTION_HANDLER(\i, BUILD_HANDLER reserved\i reserved none)
+.endr
+
+/* Create handle_reserved for temporary build. */
+BUILD_HANDLER reserved reserved none
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index ad2ce1a0908e..e99b50359900 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -21,6 +21,11 @@
  */
 PECOFF_FILE_ALIGN = 0x200;
 PECOFF_SEGMENT_ALIGN = 0x10000;
+EX_HANDLER_ALIGN = SZ_512;
+EX_HANDLER_SIZE = SZ_512;
+EX_HANDLER_TOTAL = 78; /* 64 Exceptions + 14 Interrupts */
+EXCEPTION_ENTRY_ALIGN = SZ_64K;
+TLBR_ENTRY_ALIGN = SZ_4K;
 
 OUTPUT_ARCH(loongarch)
 ENTRY(kernel_entry)
@@ -54,6 +59,17 @@ SECTIONS
 	. = ALIGN(PECOFF_SEGMENT_ALIGN);
 	_etext = .;
 
+	. = ALIGN(EXCEPTION_ENTRY_ALIGN);
+	.ex_handlers : {
+		__ex_handlers = .;
+		*(SORT_BY_INIT_PRIORITY(.exception_handlers.*))
+		. = ALIGN(EX_HANDLER_ALIGN);
+		__ex_handlers_end = .;
+		. = ALIGN(TLBR_ENTRY_ALIGN);
+		__tlbr_entry = .;
+		*(.tlbrhandler)
+	}
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
@@ -154,3 +170,6 @@ SECTIONS
 		*(.eh_frame)
 	}
 }
+
+ASSERT(__ex_handlers_end == (__ex_handlers + EX_HANDLER_SIZE * EX_HANDLER_TOTAL),
+       "The amount of exception handlers does not match!");
diff --git a/arch/loongarch/mm/tlbex.S b/arch/loongarch/mm/tlbex.S
index 244e2f5aeee5..53321d3447a2 100644
--- a/arch/loongarch/mm/tlbex.S
+++ b/arch/loongarch/mm/tlbex.S
@@ -9,6 +9,7 @@
 #include <asm/pgtable.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
+#include <asm/traps.h>
 
 #define INVTLB_ADDR_GFALSE_AND_ASID	5
 
@@ -32,7 +33,8 @@
 	tlb_do_page_fault 0
 	tlb_do_page_fault 1
 
-SYM_FUNC_START(handle_tlb_protect)
+	.macro _handle_tlb_protect idx
+SYM_FUNC_START(handle_tlb_protect\idx)
 	BACKUP_T0T1
 	SAVE_ALL
 	move		a0, sp
@@ -42,9 +44,11 @@ SYM_FUNC_START(handle_tlb_protect)
 	la_abs		t0, do_page_fault
 	jirl		ra, t0, 0
 	RESTORE_ALL_AND_RET
-SYM_FUNC_END(handle_tlb_protect)
+SYM_FUNC_END(handle_tlb_protect\idx)
+	.endm
 
-SYM_FUNC_START(handle_tlb_load)
+	.macro _handle_tlb_load idx
+SYM_FUNC_START(handle_tlb_load\idx)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
 	csrwr		ra, EXCEPTION_KS2
@@ -53,10 +57,10 @@ SYM_FUNC_START(handle_tlb_load)
 	 * The vmalloc handling is not in the hotpath.
 	 */
 	csrrd		t0, LOONGARCH_CSR_BADV
-	bltz		t0, vmalloc_load
+	bltz		t0, 3f
 	csrrd		t1, LOONGARCH_CSR_PGDL
 
-vmalloc_done_load:
+1: /* vmalloc_done_load: */
 	/* Get PGD offset in bytes */
 	bstrpick.d	ra, t0, PTRS_PER_PGD_BITS + PGDIR_SHIFT - 1, PGDIR_SHIFT
 	alsl.d		t1, ra, t1, 3
@@ -78,25 +82,25 @@ vmalloc_done_load:
 	 * see if we need to jump to huge tlb processing.
 	 */
 	rotri.d		ra, ra, _PAGE_HUGE_SHIFT + 1
-	bltz		ra, tlb_huge_update_load
+	bltz		ra, 4f
 
 	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
 	bstrpick.d	t0, t0, PTRS_PER_PTE_BITS + PAGE_SHIFT - 1, PAGE_SHIFT
 	alsl.d		t1, t0, ra, _PTE_T_LOG2
 
 #ifdef CONFIG_SMP
-smp_pgtable_change_load:
+2: /* smp_pgtable_change_load: */
 	ll.d		t0, t1, 0
 #else
 	ld.d		t0, t1, 0
 #endif
 	andi		ra, t0, _PAGE_PRESENT
-	beqz		ra, nopage_tlb_load
+	beqz		ra, 5f
 
 	ori		t0, t0, _PAGE_VALID
 #ifdef CONFIG_SMP
 	sc.d		t0, t1, 0
-	beqz		t0, smp_pgtable_change_load
+	beqz		t0, 2b
 #else
 	st.d		t0, t1, 0
 #endif
@@ -114,23 +118,23 @@ smp_pgtable_change_load:
 	ertn
 
 #ifdef CONFIG_64BIT
-vmalloc_load:
+3: /* vmalloc_load: */
 	la_abs		t1, swapper_pg_dir
-	b		vmalloc_done_load
+	b		1b
 #endif
 
 	/* This is the entry point of a huge page. */
-tlb_huge_update_load:
+4: /* tlb_huge_update_load: */
 #ifdef CONFIG_SMP
 	ll.d		ra, t1, 0
 #endif
 	andi		t0, ra, _PAGE_PRESENT
-	beqz		t0, nopage_tlb_load
+	beqz		t0, 5f
 
 #ifdef CONFIG_SMP
 	ori		t0, ra, _PAGE_VALID
 	sc.d		t0, t1, 0
-	beqz		t0, tlb_huge_update_load
+	beqz		t0, 4b
 	ori		t0, ra, _PAGE_VALID
 #else
 	rotri.d		ra, ra, 64 - (_PAGE_HUGE_SHIFT + 1)
@@ -183,13 +187,15 @@ tlb_huge_update_load:
 	csrrd		ra, EXCEPTION_KS2
 	ertn
 
-nopage_tlb_load:
+5: /* nopage_tlb_load: */
 	dbar		0
 	csrrd		ra, EXCEPTION_KS2
 	la_abs		t0, tlb_do_page_fault_0
 	jr		t0
-SYM_FUNC_END(handle_tlb_load)
+SYM_FUNC_END(handle_tlb_load\idx)
+	.endm
 
+	.macro _handle_tlb_store
 SYM_FUNC_START(handle_tlb_store)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
@@ -338,7 +344,9 @@ nopage_tlb_store:
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_store)
+	.endm
 
+	.macro _handle_tlb_modify
 SYM_FUNC_START(handle_tlb_modify)
 	csrwr		t0, EXCEPTION_KS0
 	csrwr		t1, EXCEPTION_KS1
@@ -485,7 +493,9 @@ nopage_tlb_modify:
 	la_abs		t0, tlb_do_page_fault_1
 	jr		t0
 SYM_FUNC_END(handle_tlb_modify)
+	.endm
 
+	.macro _handle_tlb_refill
 SYM_FUNC_START(handle_tlb_refill)
 	csrwr		t0, LOONGARCH_CSR_TLBRSAVE
 	csrrd		t0, LOONGARCH_CSR_PGD
@@ -502,3 +512,14 @@ SYM_FUNC_START(handle_tlb_refill)
 	csrrd		t0, LOONGARCH_CSR_TLBRSAVE
 	ertn
 SYM_FUNC_END(handle_tlb_refill)
+	.endm
+
+SET_EXCEPTION_HANDLER(EXCCODE_TLBI,  _handle_tlb_load)
+SET_EXCEPTION_HANDLER(EXCCODE_TLBL,  _handle_tlb_load 1)
+SET_EXCEPTION_HANDLER(EXCCODE_TLBS,  _handle_tlb_store)
+SET_EXCEPTION_HANDLER(EXCCODE_TLBM,  _handle_tlb_modify)
+SET_EXCEPTION_HANDLER(EXCCODE_TLBNR, _handle_tlb_protect)
+SET_EXCEPTION_HANDLER(EXCCODE_TLBNX, _handle_tlb_protect 1)
+SET_EXCEPTION_HANDLER(EXCCODE_TLBPE, _handle_tlb_protect 2)
+
+SET_TLBR_HANDLER(_handle_tlb_refill)
-- 
2.34.3

