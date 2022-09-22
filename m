Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231955E607A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIVLIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiIVLIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:08:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64093DB96F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:08:13 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWsbQixjVBIgAA--.58768S2;
        Thu, 22 Sep 2022 19:08:11 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Use generic BUG() handler
Date:   Thu, 22 Sep 2022 19:08:10 +0800
Message-Id: <1663844890-10776-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8BxXWsbQixjVBIgAA--.58768S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyruw4rJry7urykuryUWrg_yoWxWr18pF
        Z3ZFn5JrWkWFn3Ja43JF109FWayws3Gr47WF17Wa4Fva42qr1kXr4vvrsxZFy0g39a9rW0
        gF9YgFnIqF4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8KwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07bF2NNUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by commit 9fb7410f955("arm64/BUG: Use BRK instruction for
generic BUG traps"), do similar to LoongArch to use generic BUG()
handler.

This patch uses the BREAK software breakpoint instruction to generate
a trap instead, similarly to most other arches, with the generic BUG
code generating the dmesg boilerplate.

This allows bug metadata to be moved to a separate table and reduces
the amount of inline code at BUG and WARN sites. This also avoids
clobbering any registers before they can be dumped.

To mitigate the size of the bug table further, this patch makes use
of the existing infrastructure for encoding addresses within the bug
table as 32-bit relative pointers instead of absolute pointers. (Note
that this limits the kernel size to 2GB.)

Before patch:
[ 3018.338013] lkdtm: Performing direct entry BUG
[ 3018.342445] Kernel bug detected[#5]:
[ 3018.345992] CPU: 2 PID: 865 Comm: cat Tainted: G D 6.0.0-rc6+ #35

After patch:
[  125.585985] lkdtm: Performing direct entry BUG
[  125.590433] ------------[ cut here ]------------
[  125.595020] kernel BUG at drivers/misc/lkdtm/bugs.c:78!
[  125.600211] Oops - BUG[#1]:
[  125.602980] CPU: 3 PID: 410 Comm: cat Not tainted 6.0.0-rc6+ #36

Out-of-line file/line data information obtained compared to before.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---

Note: The following modifications need to be made when adding objootl
support later:

WARN* and BUG* both use "break 0x1" opcodes and the distinction
is provided by the contents of the bug table. This table is not
accessible to objtool, so add an annotation to WARN* macros to
let objtool know that break handler will return an resume the
execution of the instructions following the WARN's break.

 #define __WARN_FLAGS(flags)                           \
 do {                                                  \
         instrumentation_begin();                      \
         __BUG_FLAGS(BUGFLAG_WARNING|(flags));         \
         annotate_reachable();                         \
         instrumentation_end();                        \

 } while (0)

 arch/loongarch/Kconfig           |  8 +++++
 arch/loongarch/include/asm/bug.h | 60 ++++++++++++++++++++++++++------
 arch/loongarch/kernel/head.S     |  3 ++
 arch/loongarch/kernel/traps.c    | 26 ++++++++++++--
 4 files changed, 84 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index b2da0a6f844e..4184aa710375 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -160,6 +160,14 @@ config LOCKDEP_SUPPORT
 	bool
 	default y
 
+config GENERIC_BUG
+	def_bool y
+	depends on BUG
+
+config GENERIC_BUG_RELATIVE_POINTERS
+	def_bool y
+	depends on GENERIC_BUG
+
 config STACKTRACE_SUPPORT
 	bool
 	default y
diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index bda49108a76d..814d464ce9a5 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -1,23 +1,61 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef __ASM_BUG_H
 #define __ASM_BUG_H
 
-#include <linux/compiler.h>
+#include <asm/break.h>
+#include <linux/stringify.h>
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define __BUGVERBOSE_LOCATION(file, line)			\
+		.pushsection .rodata.str, "aMS", @progbits, 1;	\
+	10002:	.string file;					\
+		.popsection;					\
+								\
+		.long 10002b - .;				\
+		.short line;
+#else
+#define _BUGVERBOSE_LOCATION(file, line)
+#endif
 
-#ifdef CONFIG_BUG
+#ifdef CONFIG_GENERIC_BUG
+
+#define __BUG_ENTRY(flags) 					\
+		.pushsection __bug_table, "aw";			\
+		.align 2;					\
+	10000:	.long 10001f - .;				\
+_BUGVERBOSE_LOCATION(__FILE__, __LINE__)			\
+		.short flags; 					\
+		.popsection;					\
+	10001:
+#else
+#define __BUG_ENTRY(flags)
+#endif
 
-#include <asm/break.h>
+#define ASM_BUG_FLAGS(flags)					\
+	__BUG_ENTRY(flags)					\
+	break	BRK_BUG
 
-static inline void __noreturn BUG(void)
-{
-	__asm__ __volatile__("break %0" : : "i" (BRK_BUG));
-	unreachable();
-}
+#define ASM_BUG()	ASM_BUG_FLAGS(0)
 
-#define HAVE_ARCH_BUG
+#define __BUG_FLAGS(flags)					\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags)));
 
-#endif
+#define BUG() do {						\
+	instrumentation_begin();				\
+	__BUG_FLAGS(0);						\
+	unreachable();						\
+} while (0)
+
+#define __WARN_FLAGS(flags) do {				\
+	instrumentation_begin();				\
+	__BUG_FLAGS(BUGFLAG_WARNING|(flags));			\
+	instrumentation_end();					\
+} while (0)
+
+#define HAVE_ARCH_BUG
 
 #include <asm-generic/bug.h>
 
-#endif /* __ASM_BUG_H */
+#endif /* ! __ASM_BUG_H */
diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
index 4d352230fbc3..2ab9b066ae6b 100644
--- a/arch/loongarch/kernel/head.S
+++ b/arch/loongarch/kernel/head.S
@@ -8,6 +8,7 @@
 #include <asm/addrspace.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/bug.h>
 #include <asm/regdef.h>
 #include <asm/loongarch.h>
 #include <asm/stackframe.h>
@@ -87,6 +88,7 @@ SYM_CODE_START(kernel_entry)			# kernel entry point
 	PTR_ADDI	sp, sp, -4 * SZREG	# init stack pointer
 
 	bl		start_kernel
+	ASM_BUG()
 
 SYM_CODE_END(kernel_entry)
 
@@ -118,6 +120,7 @@ SYM_CODE_START(smpboot_entry)
 	ld.d		tp, t0, CPU_BOOT_TINFO
 
 	bl		start_secondary
+	ASM_BUG()
 SYM_CODE_END(smpboot_entry)
 
 #endif /* CONFIG_SMP */
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index a692009fee31..dc05c6915b47 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -378,6 +378,29 @@ asmlinkage void noinstr do_ale(struct pt_regs *regs)
 	irqentry_exit(regs, state);
 }
 
+/* GENERIC_BUG traps */
+
+int is_valid_bugaddr(unsigned long addr)
+{
+	return 1;
+}
+
+static void bug_handler(struct pt_regs *regs)
+{
+	switch (report_bug(regs->csr_era, regs)) {
+	case BUG_TRAP_TYPE_NONE:
+	case BUG_TRAP_TYPE_BUG:
+		die_if_kernel("Oops - BUG", regs);
+		force_sig(SIGTRAP);
+		break;
+
+	case BUG_TRAP_TYPE_WARN:
+		/* Skip the BUG instruction and continue */
+		regs->csr_era += LOONGARCH_INSN_SIZE;
+		break;
+	}
+}
+
 asmlinkage void noinstr do_bp(struct pt_regs *regs)
 {
 	bool user = user_mode(regs);
@@ -431,8 +454,7 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 
 	switch (bcode) {
 	case BRK_BUG:
-		die_if_kernel("Kernel bug detected", regs);
-		force_sig(SIGTRAP);
+		bug_handler(regs);
 		break;
 	case BRK_DIVZERO:
 		die_if_kernel("Break instruction in kernel code", regs);
-- 
2.36.0

