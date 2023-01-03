Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C577265C47B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbjACRBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbjACRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:11 -0500
Received: from fx303.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD513CF0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:05 -0800 (PST)
Received: from localhost (fx303.security-mail.net [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 6B1CF30F746
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764273;
        bh=YsGCInplS78OY4FbLIXgfSN1YcEPf6X6mfWXV89vBvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iapvgWQPugkF+ij+JJi57HBXiM8xb5/FoPm87NTJwM3sg7Jq+H6uUF9uB8UNKPvpe
         r2WgdHJY4Y0CIvO4LYptmrey6sOUF7eM1g/oeKuYkNIZw6bklVYABVs4Cofo7+Wn8V
         KwVNBCum24C4M4c5njayspvJ3bUguc9XMmq7WcTg=
Received: from fx303 (fx303.security-mail.net [127.0.0.1]) by
 fx303.security-mail.net (Postfix) with ESMTP id 5031830F6BC; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx303.security-mail.net (Postfix) with ESMTPS id F31C130F757; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 886E627E03F5; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 57FF027E0409; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 ijQJ5FVLfePU; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 2CB2327E0402; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <7ccc.63b45b70.f1a59.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 57FF027E0409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764272;
 bh=2pMx1EinMnupMrhjZ9BVp9XqP8fEonrZkrtQViVPpvQ=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=f3CEjTjfGl5AT2N+JOvAl3bCcrHrlQiTmXpuquvFeQZBe45uNVRCdyrpp3qhtMRcj
 YGAu5wKpgEQ/LqFJMMVvvzCQIBQ/EbCzx9uf5+S6xn6xcAqJTThKA9jtKzfcdpw9vk
 ptUZUz/jVMCfkRkQ4JFbUPJd9cJfRzU05/DgC37A=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>
Subject: [RFC PATCH 15/25] kvx: Add misc common routines
Date:   Tue,  3 Jan 2023 17:43:49 +0100
Message-ID: <20230103164359.24347-16-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some misc common routines for kvx, including: asm-offsets
routines, futex functions, i/o memory access functions.

CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Jonathan Borne <jborne@kalray.eu>
Signed-off-by: Jonathan Borne <jborne@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Villette <jvillette@kalray.eu>
Signed-off-by: Julien Villette <jvillette@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/asm/futex.h  | 141 ++++++++++++++++++++++++++++++
 arch/kvx/include/asm/io.h     |  34 ++++++++
 arch/kvx/kernel/asm-offsets.c | 157 ++++++++++++++++++++++++++++++++++
 arch/kvx/kernel/io.c          |  96 +++++++++++++++++++++
 4 files changed, 428 insertions(+)
 create mode 100644 arch/kvx/include/asm/futex.h
 create mode 100644 arch/kvx/include/asm/io.h
 create mode 100644 arch/kvx/kernel/asm-offsets.c
 create mode 100644 arch/kvx/kernel/io.c

diff --git a/arch/kvx/include/asm/futex.h b/arch/kvx/include/asm/futex.h
new file mode 100644
index 000000000000..b71b52339729
--- /dev/null
+++ b/arch/kvx/include/asm/futex.h
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018-2023 Kalray Inc.
+ * Authors:
+ *      Clement Leger <cleger@kalray.eu>
+ *      Yann Sionneau <ysionneau@kalray.eu>
+ *      Jonathan Borne <jborne@kalray.eu>
+ *
+ * Part of code is taken from RiscV port
+ */
+
+#ifndef _ASM_KVX_FUTEX_H
+#define _ASM_KVX_FUTEX_H
+
+#ifdef __KERNEL__
+
+#include <linux/futex.h>
+#include <linux/uaccess.h>
+
+#define __futex_atomic_op(insn, ret, oldval, uaddr, oparg) \
+{ \
+	__enable_user_access();                                 \
+	__asm__ __volatile__ (                                  \
+	"       fence                                   \n"     \
+	"       ;;\n                                      "     \
+	"1:     lwz $r63 = 0[%[u]]                      \n"     \
+	"       ;;\n                                      "     \
+	"       " insn "                                \n"     \
+	"       ;;\n                                      "     \
+	"       acswapw 0[%[u]], $r62r63                \n"     \
+	"       ;;\n                                      "     \
+	"       cb.deqz $r62? 1b                        \n"     \
+	"       ;;\n                                      "     \
+	"       copyd %[ov] = $r63                      \n"     \
+	"       ;;\n                                      "     \
+	"2:                                             \n"     \
+	"       .section .fixup,\"ax\"                  \n"     \
+	"3:     make %[r] = 2b                          \n"     \
+	"       ;;\n                                      "     \
+	"       make %[r] = %[e]                        \n"     \
+	"       igoto %[r]                              \n"     \
+	"       ;;\n                                      "     \
+	"       .previous                               \n"     \
+	"       .section __ex_table,\"a\"               \n"     \
+	"       .align 8                                \n"     \
+	"       .dword 1b,3b                            \n"     \
+	"       .dword 2b,3b                            \n"     \
+	"       .previous                               \n"     \
+	: [r] "+r" (ret), [ov] "+r" (oldval)                   \
+	: [u] "r" (uaddr),                                      \
+	  [op] "r" (oparg), [e] "i" (-EFAULT)                   \
+	: "r62", "r63", "memory");                              \
+	__disable_user_access();                                \
+}
+
+
+static inline int
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	int oldval = 0, ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	switch (op) {
+	case FUTEX_OP_SET: /* *(int *)UADDR = OPARG; */
+		__futex_atomic_op("copyd $r62 = %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ADD: /* *(int *)UADDR += OPARG; */
+		__futex_atomic_op("addw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_OR: /* *(int *)UADDR |= OPARG; */
+		__futex_atomic_op("orw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_ANDN: /* *(int *)UADDR &= ~OPARG; */
+		__futex_atomic_op("andnw $r62 = %[op], $r63",
+				  ret, oldval, uaddr, oparg);
+		break;
+	case FUTEX_OP_XOR:
+		__futex_atomic_op("xorw $r62 = $r63, %[op]",
+				  ret, oldval, uaddr, oparg);
+		break;
+	default:
+		ret = -ENOSYS;
+	}
+
+	if (!ret)
+		*oval = oldval;
+
+	return ret;
+}
+
+static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+						u32 oldval, u32 newval)
+{
+	int ret = 0;
+
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+	__enable_user_access();
+	__asm__ __volatile__ (
+	"      fence                           \n"/* commit previous stores  */
+	"      copyd $r63 = %[ov]              \n"/* init "expect" with ov   */
+	"      copyd $r62 = %[nv]              \n"/* init "update" with nv   */
+	"      ;;\n                              "
+	"1:    acswapw 0[%[u]], $r62r63        \n"
+	"      ;;\n                              "
+	"      cb.dnez $r62? 3f                \n"/* if acswap ok -> return  */
+	"      ;;\n                              "
+	"2:    lws $r63 = 0[%[u]]              \n"/* fail -> load old value  */
+	"      ;;\n                              "
+	"      compw.ne $r62 = $r63, %[ov]     \n"/* check if equal to "old" */
+	"      ;;\n                              "
+	"      cb.deqz $r62? 1b                \n"/* if not equal, try again */
+	"      ;;\n                              "
+	"3:                                    \n"
+	"      .section .fixup,\"ax\"          \n"
+	"4:    make %[r] = 3b                  \n"
+	"      ;;\n                              "
+	"      make %[r] = %[e]                \n"
+	"      igoto %[r]                      \n"/* goto 3b                 */
+	"      ;;\n                              "
+	"      .previous                       \n"
+	"      .section __ex_table,\"a\"       \n"
+	"      .align 8                        \n"
+	"      .dword 1b,4b                    \n"
+	"      .dword 2b,4b                    \n"
+	".previous                             \n"
+	: [r] "+r" (ret)
+	: [ov] "r" (oldval), [nv] "r" (newval),
+	  [e] "i" (-EFAULT), [u] "r" (uaddr)
+	: "r62", "r63", "memory");
+	__disable_user_access();
+	*uval = oldval;
+	return ret;
+}
+
+#endif
+#endif /* _ASM_KVX_FUTEX_H */
diff --git a/arch/kvx/include/asm/io.h b/arch/kvx/include/asm/io.h
new file mode 100644
index 000000000000..c5e458c59bbb
--- /dev/null
+++ b/arch/kvx/include/asm/io.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_IO_H
+#define _ASM_KVX_IO_H
+
+#include <linux/types.h>
+
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#define _PAGE_IOREMAP _PAGE_KERNEL_DEVICE
+
+/*
+ * String version of I/O memory access operations.
+ */
+extern void __memcpy_fromio(void *to, const volatile void __iomem *from,
+			    size_t count);
+extern void __memcpy_toio(volatile void __iomem *to, const void *from,
+			  size_t count);
+extern void __memset_io(volatile void __iomem *dst, int c, size_t count);
+
+#define memset_io(c, v, l)	__memset_io((c), (v), (l))
+#define memcpy_fromio(a, c, l)	__memcpy_fromio((a), (c), (l))
+#define memcpy_toio(c, a, l)	__memcpy_toio((c), (a), (l))
+
+#include <asm-generic/io.h>
+
+extern int devmem_is_allowed(unsigned long pfn);
+
+#endif	/* _ASM_KVX_IO_H */
diff --git a/arch/kvx/kernel/asm-offsets.c b/arch/kvx/kernel/asm-offsets.c
new file mode 100644
index 000000000000..3e79b6dd13bd
--- /dev/null
+++ b/arch/kvx/kernel/asm-offsets.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ *            Yann Sionneau
+ */
+
+#include <linux/preempt.h>
+#include <linux/thread_info.h>
+#include <linux/kbuild.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/bug.h>
+
+#include <asm/processor.h>
+#include <asm/ptrace.h>
+#include <asm/page.h>
+#include <asm/fixmap.h>
+#include <asm/page_size.h>
+#include <asm/pgtable.h>
+#include <asm/ptrace.h>
+#include <asm/tlb_defs.h>
+#include <asm/mmu_stats.h>
+#include <asm/stacktrace.h>
+
+int foo(void)
+{
+	BUILD_BUG_ON(sizeof(struct pt_regs) != PT_REGS_STRUCT_EXPECTED_SIZE);
+	/*
+	 * For stack alignment purposes we must make sure the pt_regs size is
+	 * a mutliple of stack_align
+	 */
+	BUILD_BUG_ON(!IS_ALIGNED(sizeof(struct pt_regs), STACK_ALIGNMENT));
+
+	/* Check that user_pt_regs size matches the beginning of pt_regs */
+	BUILD_BUG_ON((offsetof(struct user_pt_regs, spc) + sizeof(uint64_t)) !=
+		     sizeof(struct user_pt_regs));
+
+	DEFINE(FIX_GDB_MEM_BASE_IDX, FIX_GDB_BARE_DISPLACED_MEM_BASE);
+
+#ifdef CONFIG_DEBUG_EXCEPTION_STACK
+	DEFINE(STACK_REG_SIZE, ALIGN(sizeof(uint64_t), STACK_ALIGNMENT));
+#endif
+
+	/*
+	 * We allocate a pt_regs on the stack when entering the kernel.  This
+	 * ensures the alignment is sane.
+	 */
+	DEFINE(PT_SIZE_ON_STACK, sizeof(struct pt_regs));
+	DEFINE(TI_FLAGS_SIZE, sizeof(unsigned long));
+	DEFINE(QUAD_REG_SIZE, 4 * sizeof(uint64_t));
+
+	/*
+	 * When restoring registers, we do not want to restore r12
+	 * right now since this is our stack pointer. Allow to save
+	 * only $r13 by using this offset.
+	 */
+	OFFSET(PT_R12, pt_regs, r12);
+	OFFSET(PT_R13, pt_regs, r13);
+	OFFSET(PT_TP, pt_regs, tp);
+	OFFSET(PT_R14R15, pt_regs, r14);
+	OFFSET(PT_R16R17, pt_regs, r16);
+	OFFSET(PT_R18R19, pt_regs, r18);
+	OFFSET(PT_FP, pt_regs, fp);
+	OFFSET(PT_SPS, pt_regs, sps);
+
+	/* Quad description */
+	OFFSET(PT_Q0, pt_regs, r0);
+	OFFSET(PT_Q4, pt_regs, r4);
+	OFFSET(PT_Q8, pt_regs, r8);
+	OFFSET(PT_Q12, pt_regs, r12);
+	OFFSET(PT_Q16, pt_regs, r16);
+	OFFSET(PT_Q20, pt_regs, r20);
+	OFFSET(PT_Q24, pt_regs, r24);
+	OFFSET(PT_Q28, pt_regs, r28);
+	OFFSET(PT_Q32, pt_regs, r32);
+	OFFSET(PT_Q36, pt_regs, r36);
+	OFFSET(PT_R38, pt_regs, r38);
+	OFFSET(PT_Q40, pt_regs, r40);
+	OFFSET(PT_Q44, pt_regs, r44);
+	OFFSET(PT_Q48, pt_regs, r48);
+	OFFSET(PT_Q52, pt_regs, r52);
+	OFFSET(PT_Q56, pt_regs, r56);
+	OFFSET(PT_Q60, pt_regs, r60);
+	OFFSET(PT_CS_SPC_SPS_ES, pt_regs, cs);
+	OFFSET(PT_LC_LE_LS_RA, pt_regs, lc);
+	OFFSET(PT_ILR, pt_regs, ilr);
+	OFFSET(PT_ORIG_R0, pt_regs, orig_r0);
+
+	/*
+	 * Flags in thread info
+	 */
+	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
+
+	/*
+	 * Stack pointers
+	 */
+	OFFSET(TASK_THREAD_KERNEL_SP, task_struct, thread.kernel_sp);
+
+	/*
+	 * Offsets to save registers in switch_to using quads
+	 */
+	OFFSET(CTX_SWITCH_RA_SP_R18_R19, task_struct, thread.ctx_switch.ra);
+	OFFSET(CTX_SWITCH_Q20, task_struct, thread.ctx_switch.r20);
+	OFFSET(CTX_SWITCH_Q24, task_struct, thread.ctx_switch.r24);
+	OFFSET(CTX_SWITCH_Q28, task_struct, thread.ctx_switch.r28);
+	OFFSET(CTX_SWITCH_FP, task_struct, thread.ctx_switch.fp);
+
+#ifdef CONFIG_ENABLE_TCA
+	OFFSET(CTX_SWITCH_TCA_REGS, task_struct, thread.ctx_switch.tca_regs[0]);
+	OFFSET(CTX_SWITCH_TCA_REGS_SAVED, task_struct,
+					thread.ctx_switch.tca_regs_saved);
+	DEFINE(TCA_REG_SIZE, sizeof(struct tca_reg));
+#endif
+
+	/* Save area offset */
+	OFFSET(TASK_THREAD_SAVE_AREA, task_struct, thread.save_area);
+
+	/* Fast tlb refill defines */
+	OFFSET(TASK_ACTIVE_MM, task_struct, active_mm);
+	OFFSET(MM_PGD, mm_struct, pgd);
+#ifdef CONFIG_KVX_DEBUG_ASN
+	OFFSET(MM_CTXT_ASN, mm_struct, context.asn);
+#endif
+
+#ifdef CONFIG_KVX_MMU_STATS
+	DEFINE(MMU_REFILL_SIZE, sizeof(struct mmu_refill_stats));
+
+	OFFSET(MMU_STATS_REFILL_USER_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_USER]);
+	OFFSET(MMU_STATS_REFILL_KERNEL_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_KERNEL]);
+	OFFSET(MMU_STATS_REFILL_KERNEL_DIRECT_OFF, mmu_stats,
+	       refill[MMU_REFILL_TYPE_KERNEL_DIRECT]);
+	OFFSET(MMU_STATS_CYCLES_BETWEEN_REFILL_OFF, mmu_stats,
+	       cycles_between_refill);
+	OFFSET(MMU_STATS_LAST_REFILL, mmu_stats, last_refill);
+
+	OFFSET(TASK_THREAD_ENTRY_TS, task_struct, thread.trap_entry_ts);
+#endif
+
+	DEFINE(ASM_PGDIR_SHIFT, PGDIR_SHIFT);
+	DEFINE(ASM_PMD_SHIFT, PMD_SHIFT);
+
+	DEFINE(ASM_PGDIR_BITS, PGDIR_BITS);
+	DEFINE(ASM_PMD_BITS, PMD_BITS);
+	DEFINE(ASM_PTE_BITS, PTE_BITS);
+
+	DEFINE(ASM_PTRS_PER_PGD, PTRS_PER_PGD);
+	DEFINE(ASM_PTRS_PER_PMD, PTRS_PER_PMD);
+	DEFINE(ASM_PTRS_PER_PTE, PTRS_PER_PTE);
+
+	DEFINE(ASM_TLB_PS, TLB_DEFAULT_PS);
+
+	return 0;
+}
diff --git a/arch/kvx/kernel/io.c b/arch/kvx/kernel/io.c
new file mode 100644
index 000000000000..0922c1d6d0f7
--- /dev/null
+++ b/arch/kvx/kernel/io.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm/kernel/io.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/export.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define REPLICATE_BYTE_MASK	0x0101010101010101
+
+/*
+ * Copy data from IO memory space to "real" memory space.
+ */
+void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		*(u64 *)to = __raw_readq(from);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		*(u8 *)to = __raw_readb(from);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_fromio);
+
+/*
+ * Copy data from "real" memory space to IO memory space.
+ */
+void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
+{
+	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(*(u64 *)from, to);
+		from += 8;
+		to += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(*(u8 *)from, to);
+		from++;
+		to++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memcpy_toio);
+
+/*
+ * "memset" on IO memory space.
+ */
+void __memset_io(volatile void __iomem *dst, int c, size_t count)
+{
+	u64 qc = __builtin_kvx_sbmm8(c, REPLICATE_BYTE_MASK);
+
+	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+
+	while (count >= 8) {
+		__raw_writeq(qc, dst);
+		dst += 8;
+		count -= 8;
+	}
+
+	while (count) {
+		__raw_writeb(c, dst);
+		dst++;
+		count--;
+	}
+}
+EXPORT_SYMBOL(__memset_io);
-- 
2.37.2





