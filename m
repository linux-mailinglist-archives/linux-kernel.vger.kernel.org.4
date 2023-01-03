Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006B365C468
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbjACRAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbjACRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:08 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED9212D2F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 355691C3E602
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=iqUNNzDLisafreTxbEHRNtewypp1lhCyKCi+cWHBHhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DdMu7idMgb/2y7InhUf3eQ9VKIpCzxXU2wAWOlGVevlynpqhcmD960iZsF7XqKkGc
         QdDILvdOGJC1vg0YW1ITyZvrsFLf3BlVReqe44CnLPOkMNq3A6EodR4fsDYFr23M4k
         lHMD5kdwq3tL7vlzDf7oN6Hz6xd5gN03/5FRLEo0=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 1A26F1C3E5FD; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id A9D381C3E568; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 84B1827E03F9; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 69A3127E03F5; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 i1wsBIIbpDs4; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 330E927E03F6; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <b5cd.63b45b71.a872c.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 69A3127E03F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=hhpDT2TDNtjd7uFw01tx3aoQasVcNdqeCrX/hr/2ndo=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=ZMDBTVYennsNAV+vNi1sJir/8senGhbF++meVyt/d3y3yGSUvd+sXbrYPox+ibcY8
 h5UbesEi3Eq61477W9mS4bk4DLVFpImztfwPwncxNNtKxDduOmfw01g2+TpIaSK7UB
 JVVEP1RVoZYnFJ+qgog1YsoFa/emEFWY078Jm+24=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>
Subject: [RFC PATCH 23/25] kvx: Add debugging related support
Date:   Tue,  3 Jan 2023 17:43:57 +0100
Message-ID: <20230103164359.24347-24-ysionneau@kalray.eu>
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

Add kvx support for ptrace and hw breakpoints.

CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/asm/debug.h      |  35 ++
 arch/kvx/include/asm/insns.h      |  16 +
 arch/kvx/include/asm/insns_defs.h | 197 +++++++++++
 arch/kvx/kernel/break_hook.c      |  77 +++++
 arch/kvx/kernel/debug.c           |  64 ++++
 arch/kvx/kernel/hw_breakpoint.c   | 556 ++++++++++++++++++++++++++++++
 arch/kvx/kernel/insns.c           | 146 ++++++++
 7 files changed, 1091 insertions(+)
 create mode 100644 arch/kvx/include/asm/debug.h
 create mode 100644 arch/kvx/include/asm/insns.h
 create mode 100644 arch/kvx/include/asm/insns_defs.h
 create mode 100644 arch/kvx/kernel/break_hook.c
 create mode 100644 arch/kvx/kernel/debug.c
 create mode 100644 arch/kvx/kernel/hw_breakpoint.c
 create mode 100644 arch/kvx/kernel/insns.c

diff --git a/arch/kvx/include/asm/debug.h b/arch/kvx/include/asm/debug.h
new file mode 100644
index 000000000000..f60c632e6697
--- /dev/null
+++ b/arch/kvx/include/asm/debug.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef __ASM_KVX_DEBUG_HOOK_H_
+#define __ASM_KVX_DEBUG_HOOK_H_
+
+/**
+ * enum debug_ret - Break return value
+ * @DEBUG_HOOK_HANDLED: Hook handled successfully
+ * @DEBUG_HOOK_IGNORED: Hook call has been ignored
+ */
+enum debug_ret {
+	DEBUG_HOOK_HANDLED = 0,
+	DEBUG_HOOK_IGNORED = 1,
+};
+
+/**
+ * struct debug_hook - Debug hook description
+ * @node: List node
+ * @handler: handler called on debug entry
+ * @mode: Hook mode (user/kernel)
+ */
+struct debug_hook {
+	struct list_head node;
+	int (*handler)(u64 ea, struct pt_regs *regs);
+	u8 mode;
+};
+
+void debug_hook_register(struct debug_hook *dbg_hook);
+void debug_hook_unregister(struct debug_hook *dbg_hook);
+
+#endif /* __ASM_KVX_DEBUG_HOOK_H_ */
diff --git a/arch/kvx/include/asm/insns.h b/arch/kvx/include/asm/insns.h
new file mode 100644
index 000000000000..36a9e8335ce8
--- /dev/null
+++ b/arch/kvx/include/asm/insns.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_INSNS_H
+#define _ASM_KVX_INSNS_H
+
+int kvx_insns_write_nostop(u32 *insns, u8 insns_len, u32 *insn_addr);
+
+int kvx_insns_write(u32 *insns, unsigned long insns_len, u32 *addr);
+
+int kvx_insns_read(u32 *insns, unsigned long insns_len, u32 *addr);
+
+#endif
diff --git a/arch/kvx/include/asm/insns_defs.h b/arch/kvx/include/asm/insns_defs.h
new file mode 100644
index 000000000000..ed8d9d6f0817
--- /dev/null
+++ b/arch/kvx/include/asm/insns_defs.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Guillaume Thouvenin
+ */
+
+#ifndef __ASM_KVX_INSNS_DEFS_H_
+#define __ASM_KVX_INSNS_DEFS_H_
+
+#include <linux/bits.h>
+
+#ifndef __ASSEMBLY__
+static inline int check_signed_imm(long long imm, int bits)
+{
+	long long min, max;
+
+	min = -BIT_ULL(bits - 1);
+	max = BIT_ULL(bits - 1) - 1;
+	if (imm < min || imm > max)
+		return 1;
+
+	return 0;
+}
+#endif /* __ASSEMBLY__ */
+
+#define BITMASK(bits)		(BIT_ULL(bits) - 1)
+
+#define KVX_INSN_SYLLABLE_WIDTH 4
+
+#define IS_INSN(__insn, __mnemo) \
+	((__insn & KVX_INSN_ ## __mnemo ## _MASK_0) == \
+	 KVX_INSN_ ## __mnemo ## _OPCODE_0)
+
+#define INSN_SIZE(__insn) \
+	(KVX_INSN_ ## __insn ## _SIZE * KVX_INSN_SYLLABLE_WIDTH)
+
+/* Values for general registers */
+#define KVX_REG_R0	0
+#define KVX_REG_R1	1
+#define KVX_REG_R2	2
+#define KVX_REG_R3	3
+#define KVX_REG_R4	4
+#define KVX_REG_R5	5
+#define KVX_REG_R6	6
+#define KVX_REG_R7	7
+#define KVX_REG_R8	8
+#define KVX_REG_R9	9
+#define KVX_REG_R10	10
+#define KVX_REG_R11	11
+#define KVX_REG_R12	12
+#define KVX_REG_SP	12
+#define KVX_REG_R13	13
+#define KVX_REG_TP	13
+#define KVX_REG_R14	14
+#define KVX_REG_FP	14
+#define KVX_REG_R15	15
+#define KVX_REG_R16	16
+#define KVX_REG_R17	17
+#define KVX_REG_R18	18
+#define KVX_REG_R19	19
+#define KVX_REG_R20	20
+#define KVX_REG_R21	21
+#define KVX_REG_R22	22
+#define KVX_REG_R23	23
+#define KVX_REG_R24	24
+#define KVX_REG_R25	25
+#define KVX_REG_R26	26
+#define KVX_REG_R27	27
+#define KVX_REG_R28	28
+#define KVX_REG_R29	29
+#define KVX_REG_R30	30
+#define KVX_REG_R31	31
+#define KVX_REG_R32	32
+#define KVX_REG_R33	33
+#define KVX_REG_R34	34
+#define KVX_REG_R35	35
+#define KVX_REG_R36	36
+#define KVX_REG_R37	37
+#define KVX_REG_R38	38
+#define KVX_REG_R39	39
+#define KVX_REG_R40	40
+#define KVX_REG_R41	41
+#define KVX_REG_R42	42
+#define KVX_REG_R43	43
+#define KVX_REG_R44	44
+#define KVX_REG_R45	45
+#define KVX_REG_R46	46
+#define KVX_REG_R47	47
+#define KVX_REG_R48	48
+#define KVX_REG_R49	49
+#define KVX_REG_R50	50
+#define KVX_REG_R51	51
+#define KVX_REG_R52	52
+#define KVX_REG_R53	53
+#define KVX_REG_R54	54
+#define KVX_REG_R55	55
+#define KVX_REG_R56	56
+#define KVX_REG_R57	57
+#define KVX_REG_R58	58
+#define KVX_REG_R59	59
+#define KVX_REG_R60	60
+#define KVX_REG_R61	61
+#define KVX_REG_R62	62
+#define KVX_REG_R63	63
+
+/* Value for bitfield parallel */
+#define KVX_INSN_PARALLEL_EOB	0x0
+#define KVX_INSN_PARALLEL_NONE	0x1
+
+#define KVX_INSN_PARALLEL(__insn)       (((__insn) >> 31) & 0x1)
+
+#define KVX_INSN_MAKE_IMM64_SIZE 3
+#define KVX_INSN_MAKE_IMM64_W64_CHECK(__val) \
+	(check_signed_imm(__val, 64))
+#define KVX_INSN_MAKE_IMM64_MASK_0 0xff030000
+#define KVX_INSN_MAKE_IMM64_OPCODE_0 0xe0000000
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_0(__rw, __w64) \
+	(KVX_INSN_MAKE_IMM64_OPCODE_0 | (((__rw) & 0x3f) << 18) | (((__w64) & 0x3ff) << 6))
+#define KVX_INSN_MAKE_IMM64_MASK_1 0xe0000000
+#define KVX_INSN_MAKE_IMM64_OPCODE_1 0x80000000
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_1(__w64) \
+	(KVX_INSN_MAKE_IMM64_OPCODE_1 | (((__w64) >> 10) & 0x7ffffff))
+#define KVX_INSN_MAKE_IMM64_SYLLABLE_2(__p, __w64) \
+	(((__p) << 31) | (((__w64) >> 37) & 0x7ffffff))
+#define KVX_INSN_MAKE_IMM64(__buf, __p, __rw, __w64) \
+do { \
+	(__buf)[0] = KVX_INSN_MAKE_IMM64_SYLLABLE_0(__rw, __w64); \
+	(__buf)[1] = KVX_INSN_MAKE_IMM64_SYLLABLE_1(__w64); \
+	(__buf)[2] = KVX_INSN_MAKE_IMM64_SYLLABLE_2(__p, __w64); \
+} while (0)
+
+#define KVX_INSN_ICALL_SIZE 1
+#define KVX_INSN_ICALL_MASK_0 0x7ffc0000
+#define KVX_INSN_ICALL_OPCODE_0 0xfdc0000
+#define KVX_INSN_ICALL_SYLLABLE_0(__p, __rz) \
+	(KVX_INSN_ICALL_OPCODE_0 | ((__p) << 31) | ((__rz) & 0x3f))
+#define KVX_INSN_ICALL(__buf, __p, __rz) \
+do { \
+	(__buf)[0] = KVX_INSN_ICALL_SYLLABLE_0(__p, __rz); \
+} while (0)
+
+#define KVX_INSN_IGOTO_SIZE 1
+#define KVX_INSN_IGOTO_MASK_0 0x7ffc0000
+#define KVX_INSN_IGOTO_OPCODE_0 0xfd80000
+#define KVX_INSN_IGOTO_SYLLABLE_0(__p, __rz) \
+	(KVX_INSN_IGOTO_OPCODE_0 | ((__p) << 31) | ((__rz) & 0x3f))
+#define KVX_INSN_IGOTO(__buf, __p, __rz) \
+do { \
+	(__buf)[0] = KVX_INSN_IGOTO_SYLLABLE_0(__p, __rz); \
+} while (0)
+
+#define KVX_INSN_CALL_SIZE 1
+#define KVX_INSN_CALL_PCREL27_CHECK(__val) \
+	(((__val) & BITMASK(2)) || check_signed_imm((__val) >> 2, 27))
+#define KVX_INSN_CALL_MASK_0 0x78000000
+#define KVX_INSN_CALL_OPCODE_0 0x18000000
+#define KVX_INSN_CALL_SYLLABLE_0(__p, __pcrel27) \
+	(KVX_INSN_CALL_OPCODE_0 | ((__p) << 31) | (((__pcrel27) >> 2) & 0x7ffffff))
+#define KVX_INSN_CALL(__buf, __p, __pcrel27) \
+do { \
+	(__buf)[0] = KVX_INSN_CALL_SYLLABLE_0(__p, __pcrel27); \
+} while (0)
+
+#define KVX_INSN_GOTO_SIZE 1
+#define KVX_INSN_GOTO_PCREL27_CHECK(__val) \
+	(((__val) & BITMASK(2)) || check_signed_imm((__val) >> 2, 27))
+#define KVX_INSN_GOTO_MASK_0 0x78000000
+#define KVX_INSN_GOTO_OPCODE_0 0x10000000
+#define KVX_INSN_GOTO_SYLLABLE_0(__p, __pcrel27) \
+	(KVX_INSN_GOTO_OPCODE_0 | ((__p) << 31) | (((__pcrel27) >> 2) & 0x7ffffff))
+#define KVX_INSN_GOTO(__buf, __p, __pcrel27) \
+do { \
+	(__buf)[0] = KVX_INSN_GOTO_SYLLABLE_0(__p, __pcrel27); \
+} while (0)
+
+#define KVX_INSN_NOP_SIZE 1
+#define KVX_INSN_NOP_MASK_0 0x7f03f000
+#define KVX_INSN_NOP_OPCODE_0 0x7f03f000
+#define KVX_INSN_NOP_SYLLABLE_0(__p) \
+	(KVX_INSN_NOP_OPCODE_0 | ((__p) << 31))
+#define KVX_INSN_NOP(__buf, __p) \
+do { \
+	(__buf)[0] = KVX_INSN_NOP_SYLLABLE_0(__p); \
+} while (0)
+
+#define KVX_INSN_SET_SIZE 1
+#define KVX_INSN_SET_MASK_0 0x7ffc0000
+#define KVX_INSN_SET_OPCODE_0 0xfc00000
+#define KVX_INSN_SET_SYLLABLE_0(__p, __systemT3, __rz) \
+	(KVX_INSN_SET_OPCODE_0 | ((__p) << 31) | (((__systemT3) & 0x1ff) << 6) | ((__rz) & 0x3f))
+#define KVX_INSN_SET(__buf, __p, __systemT3, __rz) \
+do { \
+	(__buf)[0] = KVX_INSN_SET_SYLLABLE_0(__p, __systemT3, __rz); \
+} while (0)
+
+#endif /* __ASM_KVX_INSNS_DEFS_H_ */
diff --git a/arch/kvx/kernel/break_hook.c b/arch/kvx/kernel/break_hook.c
new file mode 100644
index 000000000000..2c02287c04a6
--- /dev/null
+++ b/arch/kvx/kernel/break_hook.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+#include <asm/insns.h>
+#include <asm/traps.h>
+#include <asm/processor.h>
+#include <asm/break_hook.h>
+
+static DEFINE_SPINLOCK(debug_hook_lock);
+static LIST_HEAD(user_break_hook);
+static LIST_HEAD(kernel_break_hook);
+
+void kvx_skip_break_insn(struct pt_regs *regs)
+{
+	regs->spc += KVX_BREAK_INSN_SIZE;
+}
+
+int break_hook_handler(uint64_t es, struct pt_regs *regs)
+{
+	int (*fn)(struct break_hook *brk_hook, struct pt_regs *regs) = NULL;
+	struct break_hook *tmp_hook, *hook = NULL;
+	struct list_head *list;
+	unsigned long flags;
+	u32 idx;
+
+	if (trap_sfri(es) != KVX_TRAP_SFRI_SET ||
+	    trap_sfrp(es) != KVX_SFR_VSFR0)
+		return BREAK_HOOK_ERROR;
+
+	idx = trap_gprp(es);
+	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
+
+	local_irq_save(flags);
+	list_for_each_entry_rcu(tmp_hook, list, node) {
+		if (idx == tmp_hook->id) {
+			hook = tmp_hook;
+			break;
+		}
+	}
+	local_irq_restore(flags);
+
+	if (!hook)
+		return BREAK_HOOK_ERROR;
+
+	fn = hook->handler;
+	return fn(hook, regs);
+}
+
+void break_hook_register(struct break_hook *brk_hook)
+{
+	struct list_head *list;
+
+	if (brk_hook->mode == MODE_USER)
+		list = &user_break_hook;
+	else
+		list = &kernel_break_hook;
+
+	spin_lock(&debug_hook_lock);
+	list_add_rcu(&brk_hook->node, list);
+	spin_unlock(&debug_hook_lock);
+}
+
+void break_hook_unregister(struct break_hook *brk_hook)
+{
+	spin_lock(&debug_hook_lock);
+	list_del_rcu(&brk_hook->node);
+	spin_unlock(&debug_hook_lock);
+	synchronize_rcu();
+}
diff --git a/arch/kvx/kernel/debug.c b/arch/kvx/kernel/debug.c
new file mode 100644
index 000000000000..d4cde403bca9
--- /dev/null
+++ b/arch/kvx/kernel/debug.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/spinlock.h>
+#include <linux/rcupdate.h>
+
+#include <asm/dame.h>
+#include <asm/debug.h>
+
+static DEFINE_SPINLOCK(debug_hook_lock);
+static LIST_HEAD(user_debug_hook);
+static LIST_HEAD(kernel_debug_hook);
+
+static struct list_head *debug_hook_list(bool user_mode)
+{
+	return user_mode ? &user_debug_hook : &kernel_debug_hook;
+}
+
+static void call_debug_hook(u64 ea, struct pt_regs *regs)
+{
+	int ret;
+	struct debug_hook *hook;
+	struct list_head *list = debug_hook_list(user_mode(regs));
+
+	list_for_each_entry_rcu(hook, list, node) {
+		ret = hook->handler(ea, regs);
+		if (ret == DEBUG_HOOK_HANDLED)
+			return;
+	}
+
+	panic("Entered debug but no requester !");
+}
+
+void debug_hook_register(struct debug_hook *dbg_hook)
+{
+	struct list_head *list = debug_hook_list(dbg_hook->mode == MODE_USER);
+
+	spin_lock(&debug_hook_lock);
+	list_add_rcu(&dbg_hook->node, list);
+	spin_unlock(&debug_hook_lock);
+}
+
+void debug_hook_unregister(struct debug_hook *dbg_hook)
+{
+	spin_lock(&debug_hook_lock);
+	list_del_rcu(&dbg_hook->node);
+	spin_unlock(&debug_hook_lock);
+	synchronize_rcu();
+}
+
+/**
+ * Main debug handler called by the _debug_handler routine in entry.S
+ * This handler will perform the required action
+ */
+void debug_handler(u64 ea, struct pt_regs *regs)
+{
+	trace_hardirqs_off();
+	call_debug_hook(ea, regs);
+	dame_irq_check(regs);
+}
diff --git a/arch/kvx/kernel/hw_breakpoint.c b/arch/kvx/kernel/hw_breakpoint.c
new file mode 100644
index 000000000000..f28ed1a99bf2
--- /dev/null
+++ b/arch/kvx/kernel/hw_breakpoint.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/hw_breakpoint.h>
+#include <linux/percpu.h>
+#include <linux/perf_event.h>
+#include <linux/bitops.h>
+#include <linux/cache.h>
+
+#include <asm/hw_breakpoint.h>
+#include <asm/sfr.h>
+
+#define HW_BREAKPOINT_SIZE	4
+#define HW_BREAKPOINT_RANGE	2
+#define MAX_STORE_LENGTH	32
+#define L1_LINE_MASK		((u64) KVX_DCACHE_LINE_SIZE - 1)
+
+#define ES_AS_DZEROL_CODE	0x3F
+#define ES_AS_MAINT_CODE	0x21
+
+#define WATCHPOINT_STEPPED	1
+#define WATCHPOINT_GDB_HIT	2
+
+#define hw_breakpoint_remap(idx) (KVX_HW_BREAKPOINT_COUNT - 1 - (idx))
+#define hw_watchpoint_remap(idx) (idx)
+
+/* Breakpoint currently in use */
+static DEFINE_PER_CPU(struct perf_event *, hbp_on_reg[KVX_HW_BREAKPOINT_COUNT]);
+
+/* Watchpoint currently in use */
+static DEFINE_PER_CPU(struct perf_event *, hwp_on_reg[KVX_HW_WATCHPOINT_COUNT]);
+
+/* Get and set function of the debug hardware registers */
+#define gen_set_hw_sfr(__name, __sfr) \
+static inline void set_hw_ ## __name(int idx, u64 addr) \
+{ \
+	if (idx == 0) \
+		kvx_sfr_set(__sfr ## 0, addr); \
+	else \
+		kvx_sfr_set(__sfr ## 1, addr); \
+}
+
+#define gen_set_hw_sfr_field(__name, __sfr, __field) \
+static inline void set_hw_ ## __name(int idx, u32 value) \
+{ \
+	if (idx == 0) \
+		kvx_sfr_set_field(__sfr, __field ## 0, value); \
+	else \
+		kvx_sfr_set_field(__sfr, __field ## 1, value); \
+}
+
+#define gen_get_hw_sfr_field(__name, __sfr, __field) \
+static inline u32 get_hw_ ## __name(int idx) \
+{ \
+	if (idx == 0) \
+		return kvx_sfr_field_val(kvx_sfr_get(__sfr), \
+					 __sfr, __field ## 0); \
+	return kvx_sfr_field_val(kvx_sfr_get(__sfr), __sfr, \
+				 __field ## 1); \
+}
+
+gen_set_hw_sfr_field(bp_owner, DOW, B);
+gen_set_hw_sfr_field(wp_owner, DOW, W);
+gen_get_hw_sfr_field(bp_owner, DO, B);
+gen_get_hw_sfr_field(wp_owner, DO, W);
+gen_set_hw_sfr(bp_addr, DBA);
+gen_set_hw_sfr(wp_addr, DWA);
+gen_set_hw_sfr_field(bp_range, DC, BR);
+gen_set_hw_sfr_field(wp_range, DC, WR);
+gen_set_hw_sfr_field(bp_enable, DC, BE);
+gen_set_hw_sfr_field(wp_enable, DC, WE);
+
+/**
+ * hw_breakpoint_slots() - obtain the maximum available number of hardware
+ * resources for the specified type
+ * @type: Requested hardware watchpoint/breakpoint type
+ * Return: The maximum number of hardware resources for the given type
+ * or 0 if type is invalide
+ */
+int hw_breakpoint_slots(int type)
+{
+	switch (type) {
+	case TYPE_INST:
+		return KVX_HW_BREAKPOINT_COUNT;
+	case TYPE_DATA:
+		return KVX_HW_WATCHPOINT_COUNT;
+	default:
+		pr_warn("unknown slot type: %d\n", type);
+		return 0;
+	}
+}
+
+/**
+ * arch_check_bp_in_kernelspace() - verify if the specified
+ * watchpoint/breakpoint address is inside the kernel
+ * @hw: The arch hardware watchpoint/breakpoint whose address should be checked
+ * Return: The result of the verification
+ */
+int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
+{
+	return hw->addr >= PAGE_OFFSET;
+}
+
+/*
+ * compute_hw_watchpoint_range() - compute the watchpoint hardware registers to
+ * cover attr->bp_len bytes beginning from attr->bp_addr
+ * @attr: Provides the address and length for which the hardware registers
+ * should be computed
+ * @hw: Address of the arch_hw_breakpoint where the computed values should be
+ * stored
+ * Observation: Because of the kvx watchpoint range problem, both hardware
+ * watchpoints may be used for index 0
+ */
+static void compute_hw_watchpoint_range(const struct perf_event_attr *attr,
+					struct arch_hw_breakpoint *hw)
+{
+	u64 addr = attr->bp_addr;
+	u32 size = attr->bp_len;
+	u64 begin = (addr >= MAX_STORE_LENGTH - 1) ?
+		(addr - (MAX_STORE_LENGTH - 1)) : 0;
+	u64 end = addr + size - 1;
+	u64 addr_l1_aligned = addr & ~L1_LINE_MASK;
+	u64 end_l1_aligned = end & ~L1_LINE_MASK;
+
+	/* The maximum range of a store instruction is 32 bytes (store octuple).
+	 * The stores may be unaligned. The dzerol instruction fills the
+	 * specified line cache with 0, so its range is the L1 cache line size
+	 * (64 bytes for Coolidge). So, the range that should be covered is:
+	 * MIN(MAX(addr - 31, 0), (addr & ~L1_LINE_MASK)) to (addr + len -1)
+	 * We can have MAX(addr - 31, 0) less (addr & ~L1_LINE_MASK) only for an
+	 * unaligned access. In this case, we have a store that modifies data in
+	 * 2 L1 cache lines. If the addresses of the 2 consecutive L1 cache
+	 * lines have many bits different (e.g. 0x10000000 and 0xfffffc0), the
+	 * watchpoint range will be very big (29 bits (512 MB) in the example)
+	 * and each time a byte in this range will change, the watchpoint will
+	 * be triggered, so, in fact, almost all stores will trigger the
+	 * watchpoint and the execution will be very very slow. To avoid this,
+	 * in this case, we use 2 hardware watchpoints, one for each L1 cache
+	 * line, each covering only a few bytes in their cache line.
+	 * A similar case, requiring 2 hardware watchpoints, happens when
+	 * (addr + len -1) is in next cache line
+	 */
+	if (begin < addr_l1_aligned) {
+		hw->wp.hw_addr[0] = begin;
+		hw->wp.hw_range[0] = fls64(begin ^ (addr_l1_aligned - 1));
+
+		hw->wp.use_wp1 = 1;
+		hw->wp.hw_addr[1] = addr_l1_aligned;
+		hw->wp.hw_range[1] = fls64(addr_l1_aligned ^ end);
+	} else if (addr_l1_aligned != end_l1_aligned) {
+		hw->wp.hw_addr[0] = addr_l1_aligned;
+		hw->wp.hw_range[0] =
+			fls64(addr_l1_aligned ^ (end_l1_aligned - 1));
+
+		hw->wp.use_wp1 = 1;
+		hw->wp.hw_addr[1] = end_l1_aligned;
+		hw->wp.hw_range[1] = fls64(end_l1_aligned ^ end);
+	} else {
+		hw->wp.use_wp1 = 0;
+		hw->wp.hw_addr[0] = addr_l1_aligned;
+		hw->wp.hw_range[0] = fls64(addr_l1_aligned ^ end);
+	}
+
+	if (!hw->wp.use_wp1) {
+		hw->wp.hw_addr[1] = 0;
+		hw->wp.hw_range[1] = 0;
+	}
+	hw->wp.hit_info = 0;
+}
+
+/*
+ * hw_breakpoint_arch_parse() - Construct an arch_hw_breakpoint from
+ * a perf_event
+ * @bp: The source perf event
+ * @attr: Attributes of the perf_event
+ * @hw: Address of the arch_hw_breakpoint to be constructed
+ * Return: 0 for success, or negative error code
+ */
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
+{
+	/* Type */
+	if (attr->bp_type == HW_BREAKPOINT_X) {
+		if (!attr->disabled) {
+			if (!IS_ALIGNED(attr->bp_addr, HW_BREAKPOINT_SIZE) ||
+			    attr->bp_len != HW_BREAKPOINT_SIZE)
+				return -EINVAL;
+		}
+
+		hw->type = KVX_HW_BREAKPOINT_TYPE;
+		hw->bp.hw_addr = attr->bp_addr;
+		hw->bp.hw_range = HW_BREAKPOINT_RANGE;
+	} else {
+		if (attr->bp_type == HW_BREAKPOINT_W) {
+			hw->type = KVX_HW_WATCHPOINT_TYPE;
+			if (!attr->disabled)
+				compute_hw_watchpoint_range(attr, hw);
+		} else
+			return -EINVAL;
+	}
+
+	hw->addr = attr->bp_addr;
+	hw->len = attr->bp_len;
+
+	return 0;
+}
+
+int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
+				    unsigned long val, void *data)
+{
+	return NOTIFY_DONE;
+}
+
+static int alloc_slot(struct perf_event **slot, size_t n,
+		      struct perf_event *bp)
+{
+	int idx;
+
+	for (idx = 0; idx < n; idx++) {
+		if (!slot[idx]) {
+			slot[idx] = bp;
+			return idx;
+		}
+	}
+	return -EBUSY;
+}
+
+static void enable_hw_breakpoint(int idx, int enable, struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	idx = hw_breakpoint_remap(idx);
+	if (enable) {
+		set_hw_bp_addr(idx, info->bp.hw_addr);
+		set_hw_bp_range(idx, info->bp.hw_range);
+	}
+
+	set_hw_bp_enable(idx, enable);
+}
+
+/*
+ * ptrace_request_hw_breakpoint() - tries to obtain the ownership for the
+ * requested hardware breakpoint
+ * @idx: The index of the requested hardware breakpoint
+ * Return: 0 for success, or negative error code
+ */
+int ptrace_request_hw_breakpoint(int idx)
+{
+	int linux_pl, pl;
+
+	if (idx < 0 || idx >= KVX_HW_BREAKPOINT_COUNT)
+		return -EINVAL;
+
+	linux_pl = kvx_sfr_field_val(kvx_sfr_get(PS), PS, PL);
+
+	/* Remap the indexes: request first the last hw breakpoint */
+	idx = hw_breakpoint_remap(idx);
+	pl = get_hw_bp_owner(idx);
+	if (pl < linux_pl) {
+		set_hw_bp_owner(idx, 0);
+		pl = get_hw_bp_owner(idx);
+	}
+
+	return (pl == linux_pl) ? 0 : -EPERM;
+}
+
+static int reserve_one_hw_watchpoint(int idx)
+{
+	int linux_pl = kvx_sfr_field_val(kvx_sfr_get(PS), PS, PL);
+	int pl = get_hw_wp_owner(idx);
+
+	if (pl < linux_pl) {
+		set_hw_wp_owner(idx, 0);
+		pl = get_hw_wp_owner(idx);
+	}
+
+	return (pl == linux_pl) ? 0 : -EPERM;
+}
+
+/*
+ * ptrace_request_hw_watchpoint() - tries to obtain the ownership for the
+ * requested hardware watchpoint
+ * @idx: The index of the requested hardware watchpoint
+ * Return: 0 for success, or negative error code
+ *
+ * Observation: Because of the kvx watchpoint range limitation, both hardware
+ * watchpoints are used for index 0 for Coolidge V1
+ */
+int ptrace_request_hw_watchpoint(int idx)
+{
+	int res;
+
+	if (idx < 0 || idx >= KVX_HW_WATCHPOINT_COUNT)
+		return -EINVAL;
+
+	idx = hw_watchpoint_remap(idx);
+	res = reserve_one_hw_watchpoint(idx);
+	if (res)
+		return res;
+
+	/* Request the both watchpoints for Coolidge V1. W0 is ours, now W1 */
+	return reserve_one_hw_watchpoint(idx + 1);
+}
+
+static void enable_one_watchpoint(int idx, int sub_idx, int enable,
+				  struct arch_hw_breakpoint *info)
+{
+	if (enable) {
+		set_hw_wp_addr(idx, info->wp.hw_addr[sub_idx]);
+		set_hw_wp_range(idx, info->wp.hw_range[sub_idx]);
+	}
+
+	set_hw_wp_enable(idx, enable);
+}
+
+static void enable_hw_watchpoint(int idx, int enable, struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+
+	if (idx < 0 || idx >= KVX_HW_WATCHPOINT_COUNT)
+		return;
+
+	idx = hw_watchpoint_remap(idx);
+	enable_one_watchpoint(idx, 0, enable, info);
+	if (info->wp.use_wp1)
+		enable_one_watchpoint(idx + 1, 1, enable, info);
+}
+
+static void get_hw_pt_list(int type, struct perf_event ***p, int *count)
+{
+	if (type == KVX_HW_BREAKPOINT_TYPE) {
+		/* Breakpoint */
+		*p = this_cpu_ptr(hbp_on_reg);
+		*count = KVX_HW_BREAKPOINT_COUNT;
+	} else {
+		/* Watchpoint */
+		*p = this_cpu_ptr(hwp_on_reg);
+		*count = KVX_HW_WATCHPOINT_COUNT;
+	}
+}
+
+static void enable_hw_pt(int idx, int enable, struct perf_event *bp)
+{
+	int type = counter_arch_bp(bp)->type;
+
+	if (type == KVX_HW_BREAKPOINT_TYPE)
+		enable_hw_breakpoint(idx, enable, bp);
+	else
+		enable_hw_watchpoint(idx, enable, bp);
+}
+
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	struct perf_event **p;
+	int idx, count;
+
+	get_hw_pt_list(counter_arch_bp(bp)->type, &p, &count);
+	idx = alloc_slot(p, count, bp);
+	if (idx < 0)
+		return idx;
+
+	enable_hw_pt(idx, 1, bp);
+
+	return 0;
+}
+
+static int free_slot(struct perf_event **slot, size_t n,
+		     struct perf_event *bp)
+{
+	int idx;
+
+	for (idx = 0; idx < n; idx++) {
+		if (slot[idx] == bp) {
+			slot[idx] = NULL;
+			return idx;
+		}
+	}
+	return -EBUSY;
+}
+
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct perf_event **p;
+	int idx, count;
+
+	get_hw_pt_list(counter_arch_bp(bp)->type, &p, &count);
+	idx = free_slot(p, count, bp);
+	if (idx < 0)
+		return;
+
+	enable_hw_pt(idx, 0, bp);
+}
+
+void hw_breakpoint_pmu_read(struct perf_event *bp)
+{
+}
+
+void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	int i;
+	struct thread_struct *t = &tsk->thread;
+
+	for (i = 0; i < KVX_HW_BREAKPOINT_COUNT; i++) {
+		if (t->debug.ptrace_hbp[i]) {
+			unregister_hw_breakpoint(t->debug.ptrace_hbp[i]);
+			t->debug.ptrace_hbp[i] = NULL;
+		}
+	}
+	for (i = 0; i < KVX_HW_WATCHPOINT_COUNT; i++) {
+		if (t->debug.ptrace_hwp[i]) {
+			unregister_hw_breakpoint(t->debug.ptrace_hwp[i]);
+			t->debug.ptrace_hwp[i] = NULL;
+		}
+	}
+}
+
+/*
+ * Set ptrace breakpoint pointers to zero for this task.
+ * This is required in order to prevent child processes from unregistering
+ * breakpoints held by their parent.
+ */
+void clear_ptrace_hw_breakpoint(struct task_struct *tsk)
+{
+	struct debug_info *d = &tsk->thread.debug;
+
+	memset(d->ptrace_hbp, 0, sizeof(d->ptrace_hbp));
+	memset(d->ptrace_hwp, 0, sizeof(d->ptrace_hwp));
+}
+
+/**
+ * check_hw_breakpoint() - called from debug_handler for each hardware
+ * breakpoint exception
+ * @regs: Pointer to registers saved when trapping
+ *
+ * This function informs the debugger if a hardware breakpoint hit
+ */
+void check_hw_breakpoint(struct pt_regs *regs)
+{
+	int i;
+	struct perf_event **bp = this_cpu_ptr(hbp_on_reg);
+
+	for (i = 0; i < KVX_HW_BREAKPOINT_COUNT; i++) {
+		if (bp[i] && !bp[i]->attr.disabled &&
+		    regs->spc == bp[i]->attr.bp_addr)
+			perf_bp_event(bp[i], regs);
+	}
+}
+
+static void watchpoint_triggered(struct perf_event *wp, struct pt_regs *regs,
+				 int idx, u64 ea)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
+	int as = kvx_sfr_field_val(regs->es, ES, AS);
+
+	/* Disable the watchpoint in order to be able to stepi */
+	info->wp.hit_info = WATCHPOINT_STEPPED;
+	enable_hw_watchpoint(idx, 0, wp);
+
+	if (as == ES_AS_MAINT_CODE)
+		return;
+
+	if (as == ES_AS_DZEROL_CODE) {
+		as = KVX_DCACHE_LINE_SIZE;
+		ea &= ~L1_LINE_MASK;
+	}
+
+	/* Check if the user watchpoint range was written */
+	if (ea < info->addr + info->len && ea + as >= info->addr)
+		info->wp.hit_info |= WATCHPOINT_GDB_HIT;
+}
+
+/**
+ * check_hw_watchpoint() - called from debug_handler for each hardware
+ * watchpoint exception
+ * @regs: Pointer to registers saved when trapping
+ * @ea: Exception Address register
+ * Return: 1 if this exception was caused by a registered user watchpoint,
+ * otherwise returns 0
+ */
+int check_hw_watchpoint(struct pt_regs *regs, u64 ea)
+{
+	struct perf_event **wp;
+	struct arch_hw_breakpoint *info;
+	u64 mask;
+	int i, ret = 0;
+
+	wp = this_cpu_ptr(hwp_on_reg);
+	for (i = 0; i < KVX_HW_WATCHPOINT_COUNT; i++) {
+		if (!wp[i] || wp[i]->attr.disabled)
+			continue;
+
+		info = counter_arch_bp(wp[i]);
+		mask = ~(BIT_ULL(info->wp.hw_range[0]) - 1);
+		if ((info->wp.hw_addr[0] & mask) == (ea & mask)) {
+			ret = 1;
+			watchpoint_triggered(wp[i], regs, i, ea);
+		}
+
+		if (info->wp.use_wp1) {
+			mask = ~(BIT_ULL(info->wp.hw_range[1]) - 1);
+			if ((info->wp.hw_addr[1] & mask) == (ea & mask)) {
+				ret = 1;
+				watchpoint_triggered(wp[i], regs, i, ea);
+			}
+		}
+	}
+
+	return ret;
+}
+
+/**
+ * check_hw_watchpoint_stepped() - called from debug_handler for each
+ * stepi exception
+ * @regs: Pointer to registers saved when trapping
+ * Return: 1 if this stepi event was caused by stepping a watchpoint,
+ * otherwise returns 0
+ *
+ * This function verifies if this stepi event was caused by stepping a
+ * watchpoint, restores the watchpoints disabled before stepping and informs
+ * the debugger about the wathcpoint hit
+ */
+int check_hw_watchpoint_stepped(struct pt_regs *regs)
+{
+	struct perf_event **wp;
+	struct arch_hw_breakpoint *info;
+	int i, ret = 0;
+
+	wp = this_cpu_ptr(hwp_on_reg);
+	for (i = 0; i < KVX_HW_WATCHPOINT_COUNT; i++) {
+		if (!wp[i] || wp[i]->attr.disabled)
+			continue;
+
+		info = counter_arch_bp(wp[i]);
+		if (info->wp.hit_info & WATCHPOINT_STEPPED) {
+			ret = 1;
+			enable_hw_watchpoint(i, 1, wp[i]);
+		}
+
+		/* Inform the debugger about the watchpoint only if the
+		 * requested watched range was written to
+		 */
+		if (info->wp.hit_info & WATCHPOINT_GDB_HIT) {
+			if (user_mode(regs))
+				perf_bp_event(wp[i], regs);
+		}
+
+		info->wp.hit_info = 0;
+	}
+
+	return ret;
+}
diff --git a/arch/kvx/kernel/insns.c b/arch/kvx/kernel/insns.c
new file mode 100644
index 000000000000..d25d8ad2a48c
--- /dev/null
+++ b/arch/kvx/kernel/insns.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Yann Sionneau
+ *            Marius Gligor
+ *            Guillaume Thouvenin
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/atomic.h>
+#include <linux/cpumask.h>
+#include <linux/uaccess.h>
+#include <linux/stop_machine.h>
+
+#include <asm/cacheflush.h>
+#include <asm/insns_defs.h>
+#include <asm/fixmap.h>
+
+struct insns_patch {
+	atomic_t cpu_count;
+	u32 *addr;
+	u32 *insns;
+	unsigned long insns_len;
+};
+
+static void *insn_patch_map(void *addr)
+{
+	unsigned long uintaddr = (uintptr_t) addr;
+	bool module = !core_kernel_text(uintaddr);
+	struct page *page;
+
+	if (module && IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		page = vmalloc_to_page(addr);
+	else if (!module && IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+		page = phys_to_page(__pa_symbol(addr));
+	else
+		return addr;
+
+	BUG_ON(!page);
+	return (void *)set_fixmap_offset(FIX_TEXT_PATCH, page_to_phys(page) +
+			(uintaddr & ~PAGE_MASK));
+}
+
+static void insn_patch_unmap(void)
+{
+	clear_fixmap(FIX_TEXT_PATCH);
+}
+
+int kvx_insns_write_nostop(u32 *insns, u8 insns_len, u32 *insn_addr)
+{
+	unsigned long current_insn_addr = (unsigned long) insn_addr;
+	unsigned long len_remain = insns_len;
+	unsigned long next_insn_page, patch_len;
+	void *map_patch_addr;
+	int ret = 0;
+
+	do {
+		/* Compute next upper page boundary */
+		next_insn_page = (current_insn_addr + PAGE_SIZE) & PAGE_MASK;
+
+		patch_len = min(next_insn_page - current_insn_addr, len_remain);
+		len_remain -= patch_len;
+
+		/* Map & patch insns */
+		map_patch_addr = insn_patch_map((void *) current_insn_addr);
+		ret = copy_to_kernel_nofault(map_patch_addr, insns, patch_len);
+		if (ret)
+			break;
+
+		insns = (void *) insns + patch_len;
+		current_insn_addr = next_insn_page;
+
+	} while (len_remain);
+
+	insn_patch_unmap();
+
+	/*
+	 * Flush & invalidate L2 + L1 icache to reload instructions from memory
+	 * L2 wbinval is necessary because we write through DEVICE cache policy
+	 * mapping which is uncached therefore L2 is bypassed
+	 */
+	wbinval_icache_range(virt_to_phys(insn_addr), insns_len);
+
+	return ret;
+}
+
+static int patch_insns_percpu(void *data)
+{
+	struct insns_patch *ip = data;
+	unsigned long insn_addr = (unsigned long) ip->addr;
+	int ret;
+
+	if (atomic_inc_return(&ip->cpu_count) == 1) {
+		ret = kvx_insns_write_nostop(ip->insns, ip->insns_len,
+					     ip->addr);
+		/* Additionnal up to release other processors */
+		atomic_inc(&ip->cpu_count);
+
+		return ret;
+	}
+
+	/* Wait for first processor to update instructions */
+	while (atomic_read(&ip->cpu_count) <= num_online_cpus())
+		cpu_relax();
+
+	/* Simply invalidate L1 I-cache to reload from L2 or memory */
+	l1_inval_icache_range(insn_addr, insn_addr + ip->insns_len);
+	return 0;
+}
+
+/**
+ * kvx_insns_write() Patch instructions at a specified address
+ * @insns: Instructions to be written at @addr
+ * @insns_len: Size of instructions to patch
+ * @addr: Address of the first instruction to patch
+ */
+int kvx_insns_write(u32 *insns, unsigned long insns_len, u32 *addr)
+{
+	struct insns_patch ip = {
+		.cpu_count = ATOMIC_INIT(0),
+		.addr = addr,
+		.insns = insns,
+		.insns_len = insns_len
+	};
+
+	if (!insns_len)
+		return -EINVAL;
+
+	if (!IS_ALIGNED((unsigned long) addr, KVX_INSN_SYLLABLE_WIDTH))
+		return -EINVAL;
+
+	/*
+	 * Function name is a "bit" misleading. while being named
+	 * stop_machine, this function does not stop the machine per se
+	 * but execute the provided function on all CPU in a safe state.
+	 */
+	return stop_machine(patch_insns_percpu, &ip, cpu_online_mask);
+}
+
+int kvx_insns_read(u32 *insns, unsigned long insns_len, u32 *addr)
+{
+	l1_inval_dcache_range((unsigned long)addr, insns_len);
+	return copy_from_kernel_nofault(insns, addr, insns_len);
+}
-- 
2.37.2





