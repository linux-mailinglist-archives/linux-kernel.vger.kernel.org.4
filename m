Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAC365C47E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbjACRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbjACRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:36 -0500
Received: from fx409.security-mail.net (smtpout253.security-mail.net [46.30.205.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41812D21
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:34 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 506ED3498BB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764274;
        bh=YAhHVKCFSItXY3JP8X3F/pgT4bTHS5Msujm/rE01rU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c+baqjhrxB7aHgu97Cakb23Phs7L8Itn9rWt26MsCatzAc87SlS/woSMojiCSMKTF
         YVn9Pu0PGmULCA+PcaOKZmjtQyP/HtMiZmQgB27Aa5KhUnahPPLm4W+0Cim87xkNew
         KxuZ8fD6LQimipEsGXwScTKQ7PEAMJXqWJ2/Z+SQ=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 337513498A0; Tue,  3 Jan
 2023 17:44:34 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id 72F6C34988C; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 3EDE127E0401; Tue,  3 Jan 2023
 17:44:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 1B80427E0405; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 AVO6NqNF6QxZ; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id E6D6227E0401; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <bc36.63b45b71.71119.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1B80427E0405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764273;
 bh=IWfNrDjRtn/T7pq54HUZCcTdeNkxLR1ctUYrt0HDWHA=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=rKWefKgs2yGb5uDUjGi/XqCeRJ487fyfJSfXG4aqAZyacIcjvTpX1QLewGrsuJI/Y
 WQQ99MiHquSYjsfCq/kOI0uA4X2XFvecbdgud+UodeBb500syUZYUMOrLGdr2qKXcK
 Y46sNqwF4xJmNIFEjxkbVLE/h2tUpnHT7fUx9g0s=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>
Subject: [RFC PATCH 21/25] kvx: Add support for ftrace
Date:   Tue,  3 Jan 2023 17:43:55 +0100
Message-ID: <20230103164359.24347-22-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ftrace to kvx arch.

CC: Steven Rostedt <rostedt@goodmis.org>
CC: Masami Hiramatsu <mhiramat@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
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
 arch/kvx/include/asm/ftrace.h    |  41 ++++
 arch/kvx/kernel/ftrace.c         | 339 ++++++++++++++++++++++++++++++
 arch/kvx/kernel/mcount.S         | 340 +++++++++++++++++++++++++++++++
 arch/kvx/kernel/return_address.c |  55 +++++
 4 files changed, 775 insertions(+)
 create mode 100644 arch/kvx/include/asm/ftrace.h
 create mode 100644 arch/kvx/kernel/ftrace.c
 create mode 100644 arch/kvx/kernel/mcount.S
 create mode 100644 arch/kvx/kernel/return_address.c

diff --git a/arch/kvx/include/asm/ftrace.h b/arch/kvx/include/asm/ftrace.h
new file mode 100644
index 000000000000..f7bcb325d255
--- /dev/null
+++ b/arch/kvx/include/asm/ftrace.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_FTRACE_H
+#define _ASM_KVX_FTRACE_H
+
+#include <asm/insns_defs.h>
+
+#define INSN_MAKE_IMM64_SYLLABLE_SIZE  INSN_SIZE(MAKE_IMM64)
+#define INSN_ICALL_SYLLABLE_SIZE       INSN_SIZE(ICALL)
+#define INSN_IGOTO_SYLLABLE_SIZE       INSN_SIZE(IGOTO)
+#define INSN_CALL_SYLLABLE_SIZE        INSN_SIZE(CALL)
+#define INSN_NOP_SYLLABLE_SIZE         INSN_SIZE(NOP)
+
+#define INSN_ICALL_REG_MASK  0x3f
+
+#define MCOUNT_ADDR	((unsigned long)(__mcount))
+#define MCOUNT_INSN_SIZE   INSN_CALL_SYLLABLE_SIZE /* sizeof mcount call */
+
+extern void ftrace_graph_call(void);
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern unsigned long ftrace_call_adjust(unsigned long addr);
+struct dyn_arch_ftrace {
+	unsigned int insn;
+};
+#endif
+
+extern void *return_address(unsigned int level);
+#define ftrace_return_address(n) return_address(n)
+
+#ifdef CONFIG_FUNCTION_TRACER
+extern void __mcount(void);
+#define mcount __mcount
+#endif /* CONFIG_FUNCTION_TRACER */
+
+#endif /* _ASM_KVX_FTRACE_H */
diff --git a/arch/kvx/kernel/ftrace.c b/arch/kvx/kernel/ftrace.c
new file mode 100644
index 000000000000..4c9e3ef62714
--- /dev/null
+++ b/arch/kvx/kernel/ftrace.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/ftrace.h>
+#include <linux/atomic.h>
+#include <linux/stop_machine.h>
+#include <asm/insns.h>
+#include <asm/insns_defs.h>
+#include <asm/cacheflush.h>
+
+/* The longest insns we check are for the far call: make + icall */
+#define MAX_SYLLABLES_TO_CHECK (KVX_INSN_MAKE_IMM64_SIZE + INSN_ICALL_SYLLABLE_SIZE)
+
+static int read_insns_and_check(u32 *insns, u8 insns_len, u32 *addr)
+{
+	u32 insns_read[MAX_SYLLABLES_TO_CHECK];
+	int syllables = insns_len / KVX_INSN_SYLLABLE_WIDTH;
+	int i;
+
+	if (syllables > MAX_SYLLABLES_TO_CHECK) {
+		pr_err("%s: shouldn't have more than %d syllables to check\n",
+		       __func__, MAX_SYLLABLES_TO_CHECK);
+		return -EINVAL;
+	}
+
+	if (kvx_insns_read(insns_read, insns_len, addr)) {
+		pr_err("%s: error when trying to read syllable\n", __func__);
+		return -EFAULT;
+	}
+
+	for (i = 0; i < syllables; i++) {
+		if (insns[i] != insns_read[i]) {
+			pr_err("%s: Instruction verification failed at PC 0x%lx\n",
+			       __func__,
+			       (unsigned long)addr + i * KVX_INSN_SYLLABLE_WIDTH);
+			pr_err("%s: \tExpect  0x%x\n", __func__, insns[i]);
+			pr_err("%s: \tRead    0x%x\n", __func__, insns_read[i]);
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+static int write_insns_and_check(u32 *insns, u8 insns_len, u32 *insn_addr)
+{
+	int ret;
+
+	ret = kvx_insns_write_nostop(insns, insns_len, insn_addr);
+	if (ret)
+		return ret;
+
+	/* Check that what have been written is correct. */
+	return read_insns_and_check(insns, insns_len, insn_addr);
+}
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
+			   unsigned long frame_pointer)
+{
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+	unsigned long old;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	old = *parent;
+	*parent = return_hooker;
+
+	if (function_graph_enter(old, self_addr, frame_pointer, NULL))
+		*parent = old;
+}
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned int insn[KVX_INSN_MAKE_IMM64_SIZE + KVX_INSN_IGOTO_SIZE];
+	void *ip = (void *)ftrace_call;
+
+	KVX_INSN_MAKE_IMM64(insn, KVX_INSN_PARALLEL_EOB, KVX_REG_R32,
+			    (unsigned long)&ftrace_graph_call);
+	KVX_INSN_IGOTO(&insn[KVX_INSN_MAKE_IMM64_SIZE],
+		       KVX_INSN_PARALLEL_EOB,
+		       KVX_REG_R32);
+
+	return write_insns_and_check(insn,
+				     INSN_MAKE_IMM64_SYLLABLE_SIZE
+				     + INSN_IGOTO_SYLLABLE_SIZE,
+				     ip);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned int nop;
+	void *ip = (void *)ftrace_call;
+
+	KVX_INSN_NOP(&nop, KVX_INSN_PARALLEL_EOB);
+	return write_insns_and_check(&nop,
+				     INSN_NOP_SYLLABLE_SIZE,
+				     ip + INSN_MAKE_IMM64_SYLLABLE_SIZE);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+struct kvx_ftrace_modify_param {
+	atomic_t	cpu_ack;
+	int		cpu_master;
+	int		cmd;
+};
+
+static int __ftrace_modify_code_kvx(void *data)
+{
+	struct kvx_ftrace_modify_param *mp = data;
+	int no_cpus = num_online_cpus();
+	int cpu = smp_processor_id();
+
+	if (cpu == mp->cpu_master) {
+		ftrace_modify_all_code(mp->cmd);
+
+		/* Inform the other cpus that they can invalidate I-cache */
+		atomic_inc(&mp->cpu_ack);
+
+		/* param (which contains the cpu_ack counter) is allocated on the
+		 * master stack: the master must wait for all other CPUs to leave
+		 * this function before returning and releasing the stack
+		 * allocation.
+		 */
+		while (atomic_read(&mp->cpu_ack) < no_cpus)
+			cpu_relax();
+	} else {
+		/* Wait for the master cpu to finish the code modification */
+		while (atomic_read(&mp->cpu_ack) == 0)
+			cpu_relax();
+		atomic_inc(&mp->cpu_ack);
+
+		l1_inval_icache_all();
+	}
+
+	return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+	const struct cpumask *cpumask = cpu_online_mask;
+	struct kvx_ftrace_modify_param mp = {
+		.cpu_ack = ATOMIC_INIT(0),
+		.cpu_master = smp_processor_id(),
+		.cmd = command,
+	};
+
+	stop_machine(__ftrace_modify_code_kvx, &mp, cpu_online_mask);
+}
+
+unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	/*
+	 * Module are using far call and kernel functions are using
+	 * pcrel. If it is a call we don't need to adjust the address but
+	 * if it is an icall the address is on the make. The generated code
+	 * looks like:
+	 *
+	 * 1c:   e0 00 c4 8f                             get $r32 = $ra
+	 * 20:   00 00 84 e0 00 00 00 80 00 00 00 00     make $r33 = 0 (0x0);;
+	 *
+	 *            20: R_KVX_S64_LO10      __mcount
+	 *            24: R_KVX_S64_UP27      __mcount
+	 *            28: R_KVX_S64_EX27      __mcount
+	 * 2c:   21 00 dc 0f                             icall $r33;;
+	 *
+	 * So we just need to add INSN_MAKE_IMM64_SYLLABLE_SIZE (0xc) to the
+	 * address.
+	 */
+	unsigned int insn;
+
+	/*
+	 * The CALL is 1 syllable while the MAKE IMM64 is 3. But we just
+	 * need to check that the first syllable of the MAKE IMM64 is the
+	 * LO10. So finally we just need to read one syllable to adjust the
+	 * call.
+	 */
+	if (kvx_insns_read(&insn, KVX_INSN_SYLLABLE_WIDTH, (void *)addr)) {
+		pr_err("%s: error when trying to read syllable\n", __func__);
+		return 0;
+	}
+
+	if (IS_INSN(insn, CALL))
+		return addr;
+
+	if (IS_INSN(insn, MAKE_IMM64))
+		return addr + INSN_MAKE_IMM64_SYLLABLE_SIZE;
+
+	pr_err("%s: syllable is neither a CALL nor a MAKE\n", __func__);
+	return 0;
+}
+
+/*
+ * Do runtime patching of the active tracer.
+ * This will be modifying the assembly code at the location of the
+ * ftrace_call symbol inside of the ftrace_caller() function.
+ */
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	void *ip;
+	unsigned int insn[KVX_INSN_MAKE_IMM64_SIZE + KVX_INSN_ICALL_SIZE];
+
+	ip = (void *)ftrace_call;
+	KVX_INSN_MAKE_IMM64(insn, KVX_INSN_PARALLEL_EOB, KVX_REG_R32,
+			    (unsigned long)func);
+	KVX_INSN_ICALL(&insn[KVX_INSN_MAKE_IMM64_SIZE],
+		       KVX_INSN_PARALLEL_EOB,
+		       KVX_REG_R32);
+	return write_insns_and_check(insn,
+				     INSN_MAKE_IMM64_SYLLABLE_SIZE
+				     + INSN_ICALL_SYLLABLE_SIZE,
+				     ip);
+}
+
+/*
+ * Turn the mcount call site into a call to an arbitrary location (but
+ * typically that is ftrace_caller()) at runtime.
+ */
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	void *ip = (void *)rec->ip;
+	unsigned int insn;
+	int ret;
+
+	/* Ensure that a NOP will be replaced */
+	if (kvx_insns_read(&insn, KVX_INSN_SYLLABLE_WIDTH, ip)) {
+		pr_err("%s: failed to read insn\n", __func__);
+		return -EFAULT;
+	}
+
+	if (!IS_INSN(insn, NOP)) {
+		pr_err("%s: insn 0x%x is not a NOP\n", __func__, insn);
+		return -EINVAL;
+	}
+
+	/*
+	 * Now we can replace the instruction depending of what has been
+	 * nopified (call or icall)
+	 */
+	insn = rec->arch.insn;
+
+	if (IS_INSN(insn, CALL)) {
+		s32 pcrel = addr - (unsigned long) ip;
+		u32 insn_call;
+
+		BUG_ON(KVX_INSN_GOTO_PCREL27_CHECK(pcrel));
+		KVX_INSN_CALL(&insn_call, KVX_INSN_PARALLEL_EOB, pcrel);
+
+		return write_insns_and_check(&insn_call,
+					     INSN_CALL_SYLLABLE_SIZE, ip);
+	}
+
+	if (IS_INSN(insn, ICALL)) {
+		u32 insn_make[KVX_INSN_MAKE_IMM64_SIZE];
+		u32 r = insn & INSN_ICALL_REG_MASK;
+
+		KVX_INSN_MAKE_IMM64(insn_make, KVX_INSN_PARALLEL_EOB, r, addr);
+		ret = write_insns_and_check(insn_make,
+					    INSN_MAKE_IMM64_SYLLABLE_SIZE,
+					    ip - INSN_MAKE_IMM64_SYLLABLE_SIZE);
+		if (ret)
+			return ret;
+
+		return write_insns_and_check(&insn,
+					      INSN_ICALL_SYLLABLE_SIZE, ip);
+	}
+
+	/* It is neither a call nor an icall */
+	pr_err("%s: insn 0x%x is neither a CALL nor ICALL\n", __func__, insn);
+	return -EINVAL;
+}
+
+/*
+ * Turn the mcount call site into a nop at runtime
+ */
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	unsigned long ip = rec->ip;
+	unsigned int insn;
+	unsigned int nop;
+
+	/*
+	 * Ensure that the instruction that will be replaced is a call or an
+	 * icall to addr.
+	 */
+	if (kvx_insns_read(&insn, KVX_INSN_SYLLABLE_WIDTH, (void *)ip)) {
+		pr_err("%s: error when trying to read syllable\n", __func__);
+		return -EFAULT;
+	}
+
+	if (IS_INSN(insn, CALL)) {
+		int pcrel = ((int)(insn & 0x7ffffff) << 5) >> 3;
+
+		if ((ip + pcrel != addr)) {
+			pr_err("%s: failed to check call addr 0x%lx != 0x%lx\n",
+			       __func__, ip + pcrel, addr);
+			return -EINVAL;
+		}
+	} else if (IS_INSN(insn, ICALL)) {
+		unsigned int insn_make[KVX_INSN_MAKE_IMM64_SIZE];
+		unsigned int reg = insn & INSN_ICALL_REG_MASK;
+		int ret;
+
+		KVX_INSN_MAKE_IMM64(insn_make,
+				    KVX_INSN_PARALLEL_EOB, reg,
+				    addr);
+
+		ret = read_insns_and_check(insn_make,
+					   INSN_MAKE_IMM64_SYLLABLE_SIZE,
+					   (void *)ip -
+					   INSN_MAKE_IMM64_SYLLABLE_SIZE);
+		if (ret)
+			return ret;
+	} else {
+		pr_err("%s: insn 0x%x is neither a CALL nor an ICALL\n",
+		       __func__, insn);
+		return -EINVAL;
+	}
+
+	rec->arch.insn = insn;
+	KVX_INSN_NOP(&nop, KVX_INSN_PARALLEL_EOB);
+	return write_insns_and_check(&nop, INSN_NOP_SYLLABLE_SIZE, (void *)ip);
+}
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+/* __mcount is defined in mcount.S */
+EXPORT_SYMBOL(__mcount);
diff --git a/arch/kvx/kernel/mcount.S b/arch/kvx/kernel/mcount.S
new file mode 100644
index 000000000000..317797aeed42
--- /dev/null
+++ b/arch/kvx/kernel/mcount.S
@@ -0,0 +1,340 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Guillaume Thouvenin
+ *            Marius Gligor
+ *            Clement Leger
+ */
+
+#include <linux/linkage.h>
+#include <asm/insns_defs.h>
+#include <asm/sfr_defs.h>
+
+.altmacro
+
+/*
+ * !!! The call to __mcount is special and breaks the ABI !!!
+ * It is because with dynamic ftrace the call can be replaced by any
+ * tracer and GCC cannot assume which caller registers must be saved.
+ * It's because the call is being inserted in the prologue of functions
+ * that is out of GCC knowledge.
+ * We could make this known to GCC, but then we would hit the problem of not
+ * being able to easily decide which insns are emitted and how they are
+ * bundled. So we choose to save nothing when calling __mcount and we will
+ * save all caller registers once __mcount called.
+ *
+ * Another specificity is that parameter is passed in $r32 instead of $r0.
+ *
+ * Our stack will be:
+ *	0  | $FP $RA $r15 -
+ *	32 | $r0 $r1 $r2 $r3
+ *	64 | $r4 $r5 $r6 $r7
+ *	96 | $r8 $r9 $r10 $r11
+ *	128| $r32 $r33 $r34 $r35
+ *	160| $r36 $r37 $r38 $r39
+ *	192| $r40 $r41 $r42 $r43
+ *	224| $r44 $r45 $r46 $r47
+ *	256| $r48 $r49 $r50 $r51
+ *	288| $r52 $r53 $r54 $r55
+ *	320| $r56 $r57 $r58 $r59
+ *	352| $r60 $r61 $r62 $r63
+ *	384| $r16 $r17
+ */
+
+#define STACK_OFFSET_FP   0
+#define STACK_OFFSET_RA   (STACK_OFFSET_FP + 8)
+#define STACK_OFFSET_R15  (STACK_OFFSET_RA + 8)
+#define STACK_OFFSET_Q0   (STACK_OFFSET_FP + 32)
+#define STACK_OFFSET_Q4   (STACK_OFFSET_Q0 + 32)
+#define STACK_OFFSET_Q8   (STACK_OFFSET_Q4 + 32)
+#define STACK_OFFSET_Q32  (STACK_OFFSET_Q8 + 32)
+#define STACK_OFFSET_Q36  (STACK_OFFSET_Q32 + 32)
+#define STACK_OFFSET_Q40  (STACK_OFFSET_Q36 + 32)
+#define STACK_OFFSET_Q44  (STACK_OFFSET_Q40 + 32)
+#define STACK_OFFSET_Q48  (STACK_OFFSET_Q44 + 32)
+#define STACK_OFFSET_Q52  (STACK_OFFSET_Q48 + 32)
+#define STACK_OFFSET_Q56  (STACK_OFFSET_Q52 + 32)
+#define STACK_OFFSET_Q60  (STACK_OFFSET_Q56 + 32)
+#define STACK_OFFSET_P16  (STACK_OFFSET_Q60 + 32)
+#define STACK_SIZE        (STACK_OFFSET_P16 + 16)
+
+#define RA_DWARF_REGNO    (64 + KVX_SFR_RA)
+#define R14_DWARF_REGNO   14
+
+.macro save_all_context_but_P16
+	/*
+	 * r16 and r17 are already saved. r16 is already used to store the
+	 * address of the function tracer if any.
+	 * so !!! USE r17 as scratch register !!!
+	 */
+	get $r17 = $ra
+	sd STACK_OFFSET_FP[$r12] = $r14
+	;;
+	.cfi_offset R14_DWARF_REGNO, -STACK_SIZE + STACK_OFFSET_FP
+	sd STACK_OFFSET_RA[$r12] = $r17
+	;;
+	.cfi_offset RA_DWARF_REGNO, -STACK_SIZE + STACK_OFFSET_RA
+	sd STACK_OFFSET_R15[$r12] = $r15
+	;;
+	so STACK_OFFSET_Q0[$r12] = $r0r1r2r3
+	;;
+	so STACK_OFFSET_Q4[$r12] = $r4r5r6r7
+	;;
+	so STACK_OFFSET_Q8[$r12] = $r8r9r10r11
+	;;
+	so STACK_OFFSET_Q32[$r12] = $r32r33r34r35
+	;;
+	so STACK_OFFSET_Q36[$r12] = $r36r37r38r39
+	;;
+	so STACK_OFFSET_Q40[$r12] = $r40r41r42r43
+	;;
+	so STACK_OFFSET_Q44[$r12] = $r44r45r46r47
+	;;
+	so STACK_OFFSET_Q48[$r12] = $r48r49r50r51
+	;;
+	so STACK_OFFSET_Q52[$r12] = $r52r53r54r55
+	;;
+	so STACK_OFFSET_Q56[$r12] = $r56r57r58r59
+	;;
+	so STACK_OFFSET_Q60[$r12] = $r60r61r62r63
+	;;
+.endm
+
+.macro restore_all_context
+	ld $r15 = STACK_OFFSET_RA[$r12]
+	;;
+	ld $r14 = STACK_OFFSET_FP[$r12]
+	set $ra = $r15
+	;;
+	.cfi_restore RA_DWARF_REGNO
+	.cfi_restore R14_DWARF_REGNO
+	ld $r15 = STACK_OFFSET_R15[$r12]
+	;;
+	lq $r16r17 = STACK_OFFSET_P16[$r12]
+	;;
+	lo $r0r1r2r3 = STACK_OFFSET_Q0[$r12]
+	;;
+	lo $r4r5r6r7 = STACK_OFFSET_Q4[$r12]
+	;;
+	lo $r8r9r10r11 = STACK_OFFSET_Q8[$r12]
+	;;
+	lo $r32r33r34r35 = STACK_OFFSET_Q32[$r12]
+	;;
+	lo $r36r37r38r39 = STACK_OFFSET_Q36[$r12]
+	;;
+	lo $r40r41r42r43 = STACK_OFFSET_Q40[$r12]
+	;;
+	lo $r44r45r46r47 = STACK_OFFSET_Q44[$r12]
+	;;
+	lo $r48r49r50r51 = STACK_OFFSET_Q48[$r12]
+	;;
+	lo $r52r53r54r55 = STACK_OFFSET_Q52[$r12]
+	;;
+	lo $r56r57r58r59 = STACK_OFFSET_Q56[$r12]
+	;;
+	lo $r60r61r62r63 = STACK_OFFSET_Q60[$r12]
+	;;
+	addd $r12 = $r12, STACK_SIZE
+	;;
+	.cfi_def_cfa_offset 0
+.endm
+
+ENTRY(__mcount)
+.cfi_startproc
+#ifdef CONFIG_DYNAMIC_FTRACE
+	/*
+	 * With dynamic ftrace mcount() is only used during boot and then all
+	 * references to it will be patched out never to return. ftrace_caller
+	 * is used.
+	 */
+	ret
+	;;
+#endif
+	addd $r12 = $r12, -STACK_SIZE
+	;;
+	.cfi_def_cfa_offset STACK_SIZE
+	sq STACK_OFFSET_P16[$r12] = $r16r17
+	;;
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	/*
+	 * Check the function pointers ftrace_graph_return
+	 * (compare to ftrace_stub) and ftrace_graph_entry (compare to
+	 * ftrace_graph_entry_stub).  If either of those is not set to the
+	 * relevant stub function, call the arch-specific function
+	 * ftrace_graph_caller.
+	 */
+	make $r16 = ftrace_graph_return
+	make $r17 = ftrace_graph_entry
+	;;
+	ld $r16 = 0[$r16]
+	;;
+	compd.eq $r16 = $r16, ftrace_stub
+	ld $r17 = 0[$r17]
+	;;
+	/*
+	 * If ftrace_graph_return is not equal to ftrace_stub ($r16 == 0) then
+	 * jump to ftrace_graph_caller. Otherwise compare ftrace_graph_entry.
+	 */
+	cb.deqz $r16? ftrace_graph_caller
+	compd.eq $r17 = $r17, ftrace_graph_entry_stub
+	;;
+	/*
+	 * If ftrace_graph_entry is equal to ftrace_graph_entry_stub ($r17 == 1)
+	 * then jump to ftrace_graph_end. If not we continue.
+	 */
+	cb.dnez $r17? ftrace_graph_end
+	;;
+ftrace_graph_caller:
+	save_all_context_but_P16
+	;;
+GLOBAL(ftrace_graph_call)
+	ld $r16 = 0[$r12]
+	;;
+	addd $r0 = $r16, 0x8 /* a pointer to the frompc */
+	get $r1 = $ra /* selfpc */
+	copyd $r2 = $r16 /* FP of the function that called __mcount */
+	;;
+	/* get the address of the bundle */
+	addd $r1 = $r1, -KVX_INSN_SYLLABLE_WIDTH
+	;;
+	call prepare_ftrace_return
+	;;
+	restore_all_context
+	;;
+	ret
+	;;
+ftrace_graph_end:
+	.cfi_def_cfa_offset STACK_SIZE
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+	/*
+	 * Check if function pointer ftrace_trace_function is set to
+	 * ftrace_stub.
+	 * If it isn't, then call that function in the same way the mcount
+	 * function normally calls __mcount_internal
+	 * - the first argument is the "frompc" ($r0)
+	 * - the second argument is the "selfpc" ($ra - mcount size adjustement)
+	 * As we don't use any callee saved registers we don't need to save
+	 * them.
+	 */
+	make $r16 = ftrace_trace_function
+	;;
+	ld $r16 = 0[$r16]
+	;;
+	/*
+	 * NOTE: keep value in $r16 (the function we may call if set). See
+	 *       comment in save_all_context_but_P16.
+	 */
+	compd.eq $r17 = $r16, ftrace_stub
+	;;
+	/*
+	 * If ftrace_trace_function is equal to ftrace_stub ($r17 == 1), there
+	 * is nothing to do, so return immediately otherwise call the function
+	 * in $r16 with correct parameters.
+	 */
+	cb.deqz $r17? 1f
+	;;
+	/* Only need to restore P16 */
+	lq $r16r17 = STACK_OFFSET_P16[$r12]
+	;;
+	addd $r12 = $r12, STACK_SIZE
+	;;
+	.cfi_def_cfa_offset 0
+	ret
+	;;
+
+1:
+	save_all_context_but_P16
+	;;
+	copyd $r0 = $r32
+	get $r1 = $ra
+	;;
+	addd $r1 = $r1, -KVX_INSN_SYLLABLE_WIDTH
+	;;
+	icall $r16
+	;;
+	restore_all_context
+	;;
+	ret
+	;;
+.cfi_endproc
+ENDPROC(__mcount)
+
+/* Required by ftrace_graph_ret_addr */
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+ENTRY(return_to_handler)
+	addd $r12 = $r12, -128
+	;;
+	so 0[$r12] = $r0r1r2r3
+	;;
+	so 32[$r12] = $r4r5r6r7
+	;;
+	so 64[$r12] = $r8r9r10r11
+	;;
+	call ftrace_return_to_handler
+	;;
+	set $ra = $r0
+	lo $r0r1r2r3 = 0[$r12]
+	;;
+	lo $r4r5r6r7 = 32[$r12]
+	;;
+	lo $r8r9r10r11 = 64[$r12]
+	addd $r12 = $r12, 128
+	;;
+	ret
+	;;
+ENDPROC(return_to_handler)
+#endif
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+ENTRY(ftrace_caller)
+.cfi_startproc
+
+	addd $r12 = $r12, -STACK_SIZE
+	;;
+	.cfi_def_cfa_offset STACK_SIZE
+	sq STACK_OFFSET_P16[$r12] = $r16r17
+	;;
+	save_all_context_but_P16
+	;;
+	copyd $r0 = $r32
+	get $r1 = $ra
+	;;
+	addd $r1 = $r1, -KVX_INSN_SYLLABLE_WIDTH
+	;;
+	goto ftrace_call
+	;;
+.align 64
+GLOBAL(ftrace_call)
+	/*
+	 * To work with module we need to use far call. So prepare the
+	 * space for them:
+	 *  - make: 3 syllables
+	 *  - icall/igoto: 1 syllable
+	 *
+	 * We are using igoto in ftrace_enable_ftrace_graph_caller(). This is
+	 * because this path is a tweak to enable function graph tracer with
+	 * dynamic ftrace. We need to jump to ftrace_graph_call without updating
+	 * RA and FP. Once in ftrace_graph_call we will return to the correct
+	 * address from the classical path of the function graph tracer.
+	 */
+	nop
+	;;
+	nop
+	;;
+	nop
+	;;
+	nop
+	;;
+	restore_all_context
+	;;
+	ret
+	;;
+.cfi_endproc
+ENDPROC(ftrace_caller)
+#endif // CONFIG_DYNAMIC_FTRACE
+
+ENTRY(ftrace_stub)
+	ret
+	;;
+ENDPROC(ftrace_stub)
+
diff --git a/arch/kvx/kernel/return_address.c b/arch/kvx/kernel/return_address.c
new file mode 100644
index 000000000000..3ddf7b79662c
--- /dev/null
+++ b/arch/kvx/kernel/return_address.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * derived from arch/arm64/kernel/return_address.c
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/export.h>
+#include <linux/ftrace.h>
+#include <linux/kprobes.h>
+
+#include <asm/stacktrace.h>
+
+struct return_address_data {
+	unsigned int level;
+	void *addr;
+};
+
+static bool save_return_addr(unsigned long pc, void *d)
+{
+	struct return_address_data *data = d;
+
+	/* We hit the desired level, return the address */
+	if (data->level == 0) {
+		data->addr = (void *) pc;
+		return true;
+	}
+
+	data->level--;
+	return false;
+}
+NOKPROBE_SYMBOL(save_return_addr);
+
+void *return_address(unsigned int level)
+{
+	struct return_address_data data;
+	struct stackframe frame;
+
+	/* Skip this function + caller */
+	data.level = level + 2;
+	data.addr = NULL;
+
+	start_stackframe(&frame,
+			 (unsigned long) __builtin_frame_address(0),
+			 (unsigned long) return_address);
+	walk_stackframe(current, &frame, save_return_addr, &data);
+
+	if (!data.level)
+		return data.addr;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(return_address);
+NOKPROBE_SYMBOL(return_address);
-- 
2.37.2





