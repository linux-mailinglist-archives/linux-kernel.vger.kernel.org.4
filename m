Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2C65C46A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbjACRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238212AbjACRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:08 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C666B13CC8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id C43F51C3E570
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764273;
        bh=g8o7yBU0fW0Btbtr/FUOsx50o2zgPomgxUW06KoyPeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=rgGlqIpBrTzg4DfXf9iiz7JjxKB0eyMA66u7tsSzjIRkueOkRQnRPDAB3+F210bY5
         4GQ329VzvibdTCRiYVZa0Kuc1E/Zwhas1vZE+gx5jBWVLD7Gl7mb4/gGpDR0wZc5P5
         mYewbF26wtNAd/mdhfYBourkMvW6w2F9VH8fTE0w=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id AA3801C3E56F; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 303D31C3E33E; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id D793027E03F8; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id BAA8627E03F4; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 KLaOBY1LLSaI; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 4F60227E03FC; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <b5cc.63b45b71.b64f.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BAA8627E03F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764272;
 bh=FZoV3SI6m01mRRMGo+iEVAnlcBEvHRx80bZUqOcYkt0=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=LJAJzgxmhRcY6lxER+29WNQX5ZTIXqZOBhbVu9PH+V8Kz62Wx1qNgzGnNliIjgt9d
 jDz6O9QOyZGPBesXUbSevpGU1jfj2ABCarSWBArtlwJdycUmQnFMpWxgkDWM2LQyth
 jqb5egZfMHZEmQjssKBqbugqTLJc29Ve4qL8RoPk=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Julian Vetter <jvetter@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>
Subject: [RFC PATCH 17/25] kvx: Add multi-processor (SMP) support
Date:   Tue,  3 Jan 2023 17:43:51 +0100
Message-ID: <20230103164359.24347-18-ysionneau@kalray.eu>
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

Coolidge v1 SoC has 5 clusters of 16 kvx cores
(+1 special Resource Manager (RM) core).

Linux can run in SMP config on the 16 cores of
a Cluster.

Cache coherency is done by the L2 cache.

CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Julien Hascoet <jhascoet@kalray.eu>
Signed-off-by: Julien Hascoet <jhascoet@kalray.eu>
Co-developed-by: Louis Morhet <lmorhet@kalray.eu>
Signed-off-by: Louis Morhet <lmorhet@kalray.eu>
Co-developed-by: Luc Michel <lmichel@kalray.eu>
Signed-off-by: Luc Michel <lmichel@kalray.eu>
Co-developed-by: Marius Gligor <mgligor@kalray.eu>
Signed-off-by: Marius Gligor <mgligor@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/asm/pwr_ctrl.h |  45 ++++
 arch/kvx/include/asm/smp.h      |  42 +++
 arch/kvx/kernel/l2_cache.c      | 448 ++++++++++++++++++++++++++++++++
 arch/kvx/kernel/smp.c           | 110 ++++++++
 arch/kvx/kernel/smpboot.c       | 127 +++++++++
 arch/kvx/platform/pwr_ctrl.c    |  93 +++++++
 include/linux/cpuhotplug.h      |   2 +
 7 files changed, 867 insertions(+)
 create mode 100644 arch/kvx/include/asm/pwr_ctrl.h
 create mode 100644 arch/kvx/include/asm/smp.h
 create mode 100644 arch/kvx/kernel/l2_cache.c
 create mode 100644 arch/kvx/kernel/smp.c
 create mode 100644 arch/kvx/kernel/smpboot.c
 create mode 100644 arch/kvx/platform/pwr_ctrl.c

diff --git a/arch/kvx/include/asm/pwr_ctrl.h b/arch/kvx/include/asm/pwr_ctrl.h
new file mode 100644
index 000000000000..25f403ba935a
--- /dev/null
+++ b/arch/kvx/include/asm/pwr_ctrl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Marius Gligor
+ */
+
+#ifndef _ASM_KVX_PWR_CTRL_H
+#define _ASM_KVX_PWR_CTRL_H
+
+#ifndef __ASSEMBLY__
+
+int kvx_pwr_ctrl_probe(void);
+
+void kvx_pwr_ctrl_cpu_poweron(unsigned int cpu);
+
+#endif
+
+/* Power controller vector register definitions */
+#define KVX_PWR_CTRL_VEC_OFFSET 0x1000
+#define KVX_PWR_CTRL_VEC_WUP_SET_OFFSET     0x10
+#define KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET     0x20
+
+/* Power controller PE reset PC register definitions */
+#define KVX_PWR_CTRL_RESET_PC_OFFSET               0x2000
+
+/* Power controller global register definitions */
+#define KVX_PWR_CTRL_GLOBAL_OFFSET 0x4040
+
+#define KVX_PWR_CTRL_GLOBAL_SET_OFFSET     0x10
+#define KVX_PWR_CTRL_GLOBAL_SET_PE_EN_SHIFT           0x1
+
+#define PWR_CTRL_WUP_SET_OFFSET  \
+		(KVX_PWR_CTRL_VEC_OFFSET + \
+		 KVX_PWR_CTRL_VEC_WUP_SET_OFFSET)
+
+#define PWR_CTRL_WUP_CLEAR_OFFSET  \
+		(KVX_PWR_CTRL_VEC_OFFSET + \
+		 KVX_PWR_CTRL_VEC_WUP_CLEAR_OFFSET)
+
+#define PWR_CTRL_GLOBAL_CONFIG_OFFSET \
+		(KVX_PWR_CTRL_GLOBAL_OFFSET + \
+		 KVX_PWR_CTRL_GLOBAL_SET_OFFSET)
+
+#endif /* _ASM_KVX_PWR_CTRL_H */
diff --git a/arch/kvx/include/asm/smp.h b/arch/kvx/include/asm/smp.h
new file mode 100644
index 000000000000..e4fd4d001b2c
--- /dev/null
+++ b/arch/kvx/include/asm/smp.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SMP_H
+#define _ASM_KVX_SMP_H
+
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+
+#include <asm/sfr.h>
+
+#ifdef CONFIG_SMP
+
+/* Hook for the generic smp_call_function_many() routine. */
+void arch_send_call_function_ipi_mask(struct cpumask *mask);
+
+/* Hook for the generic smp_call_function_single() routine. */
+void arch_send_call_function_single_ipi(int cpu);
+
+void __init setup_processor(void);
+
+void smp_init_cpus(void);
+
+irqreturn_t ipi_call_interrupt(int irq, void *dev_id);
+
+#define raw_smp_processor_id() ((int) \
+	((kvx_sfr_get(PCR) & KVX_SFR_PCR_PID_MASK) \
+					>> KVX_SFR_PCR_PID_SHIFT))
+
+#define flush_cache_vmap(start, end)		do { } while (0)
+#define flush_cache_vunmap(start, end)		do { } while (0)
+
+#else
+
+void smp_init_cpus(void) {}
+
+#endif /* CONFIG_SMP */
+
+#endif
diff --git a/arch/kvx/kernel/l2_cache.c b/arch/kvx/kernel/l2_cache.c
new file mode 100644
index 000000000000..94a4d9159471
--- /dev/null
+++ b/arch/kvx/kernel/l2_cache.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Luc Michel
+ *            Julien Hascoet
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/jiffies.h>
+#include <linux/of_address.h>
+#include <linux/irqchip/irq-kvx-apic-mailbox.h>
+
+#include <asm/rm_fw.h>
+#include <asm/l2_cache.h>
+#include <asm/sections.h>
+#include <asm/cacheflush.h>
+
+#define L2_START_TIMEOUT_MS	10
+#define L2_CMD_TIMEOUT_MS	200
+
+#define L2_MK_OP(__cmd, __sync) (BIT(L2_CMD_OP_VALID_SHIFT) | \
+			 ((u64) __sync << L2_CMD_OP_SYNC_SHIFT) | \
+			 ((u64) __cmd << L2_CMD_OP_CMD_SHIFT))
+
+#define L2_ERROR(_err) \
+	((error & L2_ERROR_ERROR_CODE_MASK) >> L2_ERROR_ERROR_CODE_SHIFT)
+
+struct l2_cache_hw_cmd {
+	u64 op;
+	u64 args[L2_CMD_OP_ARG_COUNT];
+} __packed;
+
+struct l2_cache_cmd {
+	int sync;
+	int cmd_type;
+	unsigned int arg_count;
+	u64 args[L2_CMD_OP_ARG_COUNT];
+};
+
+/**
+ * struct l2_cached_data - Data associated to the l2-cache
+ * @regs: base of L2 registers
+ * @mbox_regs: Mailbox registers for L2 signaling
+ */
+struct l2_cache_data {
+	void __iomem *regs;
+	void __iomem *mbox_regs;
+	u64 fifo_cmd_count;
+};
+
+DEFINE_STATIC_KEY_FALSE(l2_enabled);
+static struct l2_cache_data l2c_ctrl;
+
+static void *l2_cmd_regs_addr(void)
+{
+	return l2c_ctrl.regs + L2_CMD_OFFSET;
+}
+
+static struct l2_cache_hw_cmd *l2_cache_hw_cmd_addr(u64 idx)
+{
+	void *cmd_regs = l2_cmd_regs_addr();
+
+	/* Wrap index */
+	idx &= (l2c_ctrl.fifo_cmd_count - 1);
+	return cmd_regs + L2_CMD_FIFO_OFFSET + idx * L2_CMD_FIFO_ELEM_SIZE;
+}
+
+static u64 l2_cache_get_cmd_idx(unsigned int cmd_count)
+{
+	u64 cmd_idx;
+	void *cmd_regs = l2_cmd_regs_addr();
+	u64 *write_idx_ptr = cmd_regs + L2_CMD_WRITE_IDX_OFFSET;
+	u64 *read_idx_ptr = cmd_regs + L2_CMD_READ_IDX_OFFSET;
+
+	/* Grab a commands tickets */
+	cmd_idx = __builtin_kvx_aladdd(write_idx_ptr, cmd_count);
+
+	/* Wait until there is room in command fifo to enqueue commands */
+	while ((cmd_idx + cmd_count) >=
+	       (readq(read_idx_ptr) + l2c_ctrl.fifo_cmd_count))
+		cpu_relax();
+
+	return cmd_idx;
+}
+
+static void l2_wait_completion(u64 cmd_idx)
+{
+	u64 *read_idx_ptr = l2_cmd_regs_addr() + L2_CMD_READ_IDX_OFFSET;
+	unsigned long timeout = jiffies + msecs_to_jiffies(L2_CMD_TIMEOUT_MS);
+
+	/* Wait for completion */
+	while (cmd_idx >= readq(read_idx_ptr)) {
+		cpu_relax();
+		if (time_after(jiffies, timeout))
+			panic("L2 cache completion timeout\n");
+	}
+}
+
+static u64 l2_cache_push_cmds(struct l2_cache_cmd *cmds, int cmd_count)
+{
+	int i, arg;
+	u64 cmd_op;
+	struct l2_cache_hw_cmd *cmd;
+	struct l2_cache_cmd *soft_cmd;
+	u64 cmd_idx = l2_cache_get_cmd_idx(cmd_count);
+
+	for (i = 0; i < cmd_count; i++) {
+		soft_cmd = &cmds[i];
+		cmd = l2_cache_hw_cmd_addr(cmd_idx);
+		cmd_idx++;
+
+		for (arg = 0; arg < soft_cmd->arg_count; arg++)
+			writeq_relaxed(soft_cmd->args[arg], &cmd->args[arg]);
+
+		cmd_op = L2_MK_OP(soft_cmd->cmd_type, soft_cmd->sync);
+		writeq(cmd_op, &cmd->op);
+	}
+
+	return cmd_idx - 1;
+}
+
+static void l2_cache_create_line_cmd(struct l2_cache_cmd *cmd, int cmd_type,
+				     int sync, u64 addr)
+{
+	cmd->cmd_type = cmd_type;
+	cmd->sync = sync;
+	cmd->arg_count = 1;
+	cmd->args[0] = addr;
+}
+
+static void l2_cache_create_area_cmd(struct l2_cache_cmd *cmd, int cmd_type,
+				     int sync, u64 addr, u64 size)
+{
+	l2_cache_create_line_cmd(cmd, cmd_type, sync, addr);
+	cmd->arg_count = 2;
+	cmd->args[1] = size;
+}
+
+static void l2_cache_push_inval_cmd(phys_addr_t start,
+			    unsigned long size)
+{
+	phys_addr_t end = start + size;
+	struct l2_cache_cmd cmds[3];
+	unsigned long irq_flags;
+	int cmd_count = 0;
+	u64 cmd_idx;
+
+	/*
+	 * In case of invalidation, we must make sure we do not invalidate
+	 * unwanted area and thus discard legit data. In case we are not aligned
+	 * send a purge line command (writeback + inval) to unaligned lines
+	 * (which can be the end line or the start line)
+	 */
+	if (!IS_ALIGNED(end, L2_CACHE_LINE_SIZE)) {
+		end &= ~L2_CACHE_LINE_MASK;
+		l2_cache_create_line_cmd(&cmds[cmd_count],
+					 L2_CMD_OP_CMD_PURGE_LINE, 1, end);
+		cmd_count++;
+	}
+
+	if (!IS_ALIGNED(start, L2_CACHE_LINE_SIZE)) {
+		start &= ~L2_CACHE_LINE_MASK;
+		/* If there is at least another line to clear */
+		if (end != start) {
+			l2_cache_create_line_cmd(&cmds[cmd_count],
+						 L2_CMD_OP_CMD_PURGE_LINE, 1,
+						 start);
+			cmd_count++;
+			start += L2_CACHE_LINE_SIZE;
+		}
+	}
+
+	BUG_ON(end < start);
+
+	size = (end - start);
+	if (size > 0) {
+		l2_cache_create_area_cmd(&cmds[cmd_count],
+					 L2_CMD_OP_CMD_INVAL_AREA, 1, start,
+					 size);
+		cmd_count++;
+	}
+
+	BUG_ON(cmd_count == 0);
+
+	local_irq_save(irq_flags);
+
+	cmd_idx = l2_cache_push_cmds(cmds, cmd_count);
+
+	/* Finally, ping the L2 cache controller */
+	writeq(1, l2c_ctrl.mbox_regs);
+
+	local_irq_restore(irq_flags);
+
+	l2_wait_completion(cmd_idx);
+}
+
+static void l2_cache_push_generic_cmd(u64 cmd_type, phys_addr_t start,
+			    unsigned long size)
+{
+	unsigned long irq_flags;
+	struct l2_cache_cmd cmd;
+	u64 cmd_idx;
+
+	/* Align the start address and size on cache line */
+	size += start & (L2_CACHE_LINE_SIZE - 1);
+	size = ALIGN(size, L2_CACHE_LINE_SIZE);
+	start = ALIGN_DOWN(start, L2_CACHE_LINE_SIZE);
+
+	local_irq_save(irq_flags);
+
+	l2_cache_create_area_cmd(&cmd, cmd_type, 1, start, size);
+	cmd_idx = l2_cache_push_cmds(&cmd, 1);
+
+	/* Finally, ping the L2 cache controller */
+	writeq(1, l2c_ctrl.mbox_regs);
+
+	local_irq_restore(irq_flags);
+
+	l2_wait_completion(cmd_idx);
+}
+
+void l2_cache_push_area_cmd(u64 cmd_type, phys_addr_t start,
+			    unsigned long size)
+{
+	if (WARN_ON(size == 0))
+		return;
+
+	if (cmd_type == L2_CMD_OP_CMD_INVAL_AREA)
+		l2_cache_push_inval_cmd(start, size);
+	else
+		l2_cache_push_generic_cmd(cmd_type, start, size);
+}
+
+static void __init l2_disp_error(u64 error)
+{
+	const char *err_type;
+
+	if (error & L2_ERROR_API_ERR_MASK)
+		err_type = "API";
+	else if (error & L2_ERROR_SETUP_ERR_MASK)
+		err_type = "SETUP";
+	else
+		err_type = "UNKNOWN";
+
+	pr_err("%s error: 0x%llx\n", err_type, L2_ERROR(error));
+}
+
+static int __init l2_cache_configure_mailboxes(void)
+{
+	phys_addr_t l2_mbox_addr = 0;
+	void *cmd_regs = l2_cmd_regs_addr();
+
+	/* We do not use mailbox to wait for completion, set it to 0 */
+	writeq(0, cmd_regs + L2_CMD_DOORBELL_READ_ADDR_OFFSET);
+
+	/* Read mailbox address from L2 registers */
+	l2_mbox_addr = readq(cmd_regs + L2_CMD_DOORBELL_WRITE_ADDR_OFFSET);
+
+	/* Then map the mailbox */
+	l2c_ctrl.mbox_regs = ioremap(l2_mbox_addr, PAGE_SIZE);
+	if (!l2c_ctrl.mbox_regs) {
+		pr_err("Failed to map mailbox\n");
+		return 1;
+	}
+
+	/* Lock this entry into the LTLB */
+	kvx_mmu_ltlb_add_entry((unsigned long) l2c_ctrl.mbox_regs & PAGE_MASK,
+			       l2_mbox_addr & PAGE_MASK,
+			       PAGE_KERNEL_DEVICE, TLB_PS_4K);
+
+	return 0;
+}
+
+static int __init l2_cache_read_queue_size(void)
+{
+	u64 inst;
+
+	/* Read command queue size */
+	inst = readq(l2c_ctrl.regs + L2_INSTANCE_OFFSET);
+	l2c_ctrl.fifo_cmd_count = (inst & L2_INSTANCE_CMD_QUEUE_SIZE_MASK)
+				   >> L2_INSTANCE_CMD_QUEUE_SIZE_SHIFT;
+
+	/* Check if value is a power of two */
+	if (hweight64(l2c_ctrl.fifo_cmd_count) != 1) {
+		pr_err("Command queue size is not a power of two\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __init l2_cache_init_hw(void)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(L2_START_TIMEOUT_MS);
+	unsigned long flags;
+	u64 status, error;
+	int ret;
+
+	/* Wait for L2 to be up */
+	do {
+		status = readq(l2c_ctrl.regs + L2_STATUS_OFFSET);
+		if (status & (L2_STATUS_READY_MASK | L2_STATUS_ERROR_MASK))
+			break;
+	} while (time_before(jiffies, timeout));
+
+	if (!status) {
+		pr_err("Timeout while waiting for firmware status\n");
+		return -ENODEV;
+	}
+
+	if (status & L2_STATUS_ERROR_MASK) {
+		error = readq(l2c_ctrl.regs + L2_ERROR_OFFSET);
+		l2_disp_error(error);
+		return -EINVAL;
+	}
+
+	/* Now write ack to L2 firmware */
+	writeq(status | L2_STATUS_ACK_MASK, l2c_ctrl.regs + L2_STATUS_OFFSET);
+
+	ret = l2_cache_read_queue_size();
+	if (ret)
+		return ret;
+
+	ret = l2_cache_configure_mailboxes();
+	if (ret)
+		return ret;
+
+	/* Enable the L2 atomically */
+	local_irq_save(flags);
+
+	/* Fence data accesses */
+	kvx_fence();
+	/* Purge L1 */
+	l1_inval_dcache_all();
+	l1_inval_icache_all();
+	__builtin_kvx_barrier();
+
+	local_irq_restore(flags);
+
+	/* Enable L2$ */
+	kvx_sfr_set_field(PS, L2E, 1);
+
+	return 0;
+}
+
+static phys_addr_t __init l2_get_regs_addr(struct device_node *np)
+{
+	const void *reg;
+	struct resource res;
+	phys_addr_t l2_regs_addr;
+	int ret;
+
+	/*
+	 * If regs is specified in device tree, then the L2$ has been loaded by
+	 * someone else and not by ourself.
+	 */
+	reg = of_get_property(np, "reg", NULL);
+	if (reg) {
+		ret = of_address_to_resource(np, 0, &res);
+		if (ret) {
+			pr_err("Address translation error\n");
+			return 0;
+		}
+		if ((res.end - res.start) > PAGE_SIZE) {
+			pr_err("L2 reg size > PAGE_SIZE\n");
+			return 0;
+		}
+
+		l2_regs_addr = res.start;
+	} else {
+		l2_regs_addr = (phys_addr_t) __rm_firmware_regs_start;
+	}
+
+	if (!IS_ALIGNED(l2_regs_addr, PAGE_SIZE)) {
+		pr_err("Registers not aligned on PAGE_SIZE\n");
+		return 0;
+	}
+
+	return l2_regs_addr;
+}
+
+static int __init l2_cache_init(void)
+{
+	int ret = -ENODEV;
+	struct device_node *np;
+	phys_addr_t l2_regs_addr;
+
+	np = of_find_compatible_node(NULL, NULL, "kalray,kvx-l2-cache");
+	if (!np || !of_device_is_available(np)) {
+		if (!IS_ENABLED(CONFIG_SMP)) {
+			pr_info("controller disabled\n");
+			return 0;
+		}
+
+		if (np && of_get_property(np, "kalray,is-qemu", NULL)) {
+			/*
+			 * QEMU is always full cache coherent. The L2 cache controller is
+			 * not strictly necessary to ensure coherency in SMP.
+			 */
+			pr_info("controller disabled (QEMU detected)\n");
+			return 0;
+		}
+
+		/* Else, SMP is enabled and L2 is mandatory for it */
+		goto err;
+	}
+
+	l2_regs_addr = l2_get_regs_addr(np);
+	if (!l2_regs_addr)
+		goto err;
+
+	/* Map the L2 registers */
+	l2c_ctrl.regs = ioremap(l2_regs_addr, PAGE_SIZE);
+	if (!l2c_ctrl.regs)
+		goto err;
+
+	/* Lock this entry into the LTLB */
+	kvx_mmu_ltlb_add_entry((unsigned long) l2c_ctrl.regs, l2_regs_addr,
+			       PAGE_KERNEL_NOCACHE, TLB_PS_4K);
+
+	ret = l2_cache_init_hw();
+	if (ret) {
+		pr_err("Failed to init L2 cache controller");
+		goto err_unmap_l2;
+	}
+
+	static_branch_enable(&l2_enabled);
+
+	pr_info("controller enabled\n");
+
+	return 0;
+
+err_unmap_l2:
+	kvx_mmu_ltlb_remove_entry((unsigned long) l2c_ctrl.regs);
+	iounmap(l2c_ctrl.regs);
+err:
+	if (IS_ENABLED(CONFIG_SMP))
+		panic("L2$ controller is mandatory for SMP");
+
+	return ret;
+}
+
+
+early_initcall(l2_cache_init);
diff --git a/arch/kvx/kernel/smp.c b/arch/kvx/kernel/smp.c
new file mode 100644
index 000000000000..ed4c35a8c4bc
--- /dev/null
+++ b/arch/kvx/kernel/smp.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/of_irq.h>
+#include <linux/cpumask.h>
+#include <linux/irq_work.h>
+#include <linux/mm_types.h>
+#include <linux/interrupt.h>
+
+#include <asm/ipi.h>
+#include <asm/tlbflush.h>
+
+enum ipi_message_type {
+	IPI_RESCHEDULE,
+	IPI_CALL_FUNC,
+	IPI_IRQ_WORK,
+	IPI_MAX
+};
+
+/* A collection of single bit ipi messages.  */
+static struct {
+	unsigned long bits ____cacheline_aligned;
+} ipi_data[NR_CPUS] __cacheline_aligned;
+
+static void send_ipi_message(const struct cpumask *mask,
+			     enum ipi_message_type operation)
+{
+	unsigned long flags;
+	int cpu;
+
+	/* Set operation that must be done by receiver */
+	for_each_cpu(cpu, mask)
+		set_bit(operation, &ipi_data[cpu].bits);
+
+	/* Commit the write before sending IPI */
+	smp_wmb();
+
+	local_irq_save(flags);
+
+	kvx_ipi_send(mask);
+
+	local_irq_restore(flags);
+}
+
+void arch_send_call_function_ipi_mask(struct cpumask *mask)
+{
+	send_ipi_message(mask, IPI_CALL_FUNC);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_CALL_FUNC);
+}
+
+#ifdef CONFIG_IRQ_WORK
+void arch_irq_work_raise(void)
+{
+	send_ipi_message(cpumask_of(smp_processor_id()), IPI_IRQ_WORK);
+}
+#endif
+
+static void ipi_stop(void *unused)
+{
+	local_cpu_stop();
+}
+
+void smp_send_stop(void)
+{
+	struct cpumask targets;
+
+	cpumask_copy(&targets, cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), &targets);
+
+	smp_call_function_many(&targets, ipi_stop, NULL, 0);
+}
+
+void smp_send_reschedule(int cpu)
+{
+	send_ipi_message(cpumask_of(cpu), IPI_RESCHEDULE);
+}
+
+irqreturn_t ipi_call_interrupt(int irq, void *dev_id)
+{
+	unsigned long *pending_ipis = &ipi_data[smp_processor_id()].bits;
+
+	while (true) {
+		unsigned long ops = xchg(pending_ipis, 0);
+
+		if (ops == 0)
+			return IRQ_HANDLED;
+
+		if (ops & (1 << IPI_RESCHEDULE))
+			scheduler_ipi();
+
+		if (ops & (1 << IPI_CALL_FUNC))
+			generic_smp_call_function_interrupt();
+
+		if (ops & (1 << IPI_IRQ_WORK))
+			irq_work_run();
+
+		BUG_ON((ops >> IPI_MAX) != 0);
+	}
+
+	return IRQ_HANDLED;
+}
diff --git a/arch/kvx/kernel/smpboot.c b/arch/kvx/kernel/smpboot.c
new file mode 100644
index 000000000000..987a6f014163
--- /dev/null
+++ b/arch/kvx/kernel/smpboot.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ *            Julian Vetter
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/sched/mm.h>
+#include <linux/mm_types.h>
+#include <linux/of_platform.h>
+#include <linux/sched/task_stack.h>
+
+#include <asm/pwr_ctrl.h>
+#include <asm/tlbflush.h>
+#include <asm/ipi.h>
+
+void *__cpu_up_stack_pointer[NR_CPUS];
+void *__cpu_up_task_pointer[NR_CPUS];
+
+void __init smp_prepare_boot_cpu(void)
+{
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
+	__cpu_up_task_pointer[cpu] = tidle;
+	/* We need to be sure writes are committed */
+	smp_mb();
+
+	kvx_pwr_ctrl_cpu_poweron(cpu);
+	while (!cpu_online(cpu))
+		cpu_relax();
+
+	return 0;
+}
+
+void __init smp_cpus_done(unsigned int max_cpus)
+{
+}
+
+void __init smp_init_cpus(void)
+{
+	struct cpumask cpumask;
+	struct device_node *cpu;
+	const __be32 *reg;
+	u32 cpu_num;
+	unsigned int nr_cpus = 0;
+
+	cpumask_clear(&cpumask);
+
+	for_each_of_cpu_node(cpu) {
+		if (!of_device_is_available(cpu))
+			continue;
+
+		reg = of_get_property(cpu, "reg", NULL);
+		if (!reg)
+			continue;
+
+		cpu_num = be32_to_cpup(reg);
+		if (cpu_num >= nr_cpu_ids)
+			continue;
+
+		nr_cpus++;
+		cpumask_set_cpu(cpu_num, &cpumask);
+	}
+
+	pr_info("%d possible cpus\n", nr_cpus);
+	init_cpu_possible(&cpumask);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	if (num_present_cpus() <= 1)
+		init_cpu_present(cpu_possible_mask);
+}
+
+int __init setup_smp(void)
+{
+	int ret;
+
+	ret = kvx_pwr_ctrl_probe();
+	if (ret)
+		panic("Failed to probe power controller !");
+
+	ret = kvx_ipi_ctrl_probe(ipi_call_interrupt);
+	if (ret)
+		panic("Failed to probe IPI controller !");
+
+	return 0;
+}
+
+early_initcall(setup_smp);
+
+/*
+ * C entry point for a secondary processor.
+ */
+void __init start_kernel_secondary(void)
+{
+	struct mm_struct *mm = &init_mm;
+	unsigned int cpu = smp_processor_id();
+
+	setup_processor();
+	kvx_mmu_early_setup();
+
+	/* All kernel threads share the same mm context.  */
+	mmgrab(mm);
+	current->active_mm = mm;
+	cpumask_set_cpu(cpu, mm_cpumask(mm));
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+	trace_hardirqs_off();
+
+	local_flush_tlb_all();
+
+	local_irq_enable();
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+}
diff --git a/arch/kvx/platform/pwr_ctrl.c b/arch/kvx/platform/pwr_ctrl.c
new file mode 100644
index 000000000000..64c86cd18695
--- /dev/null
+++ b/arch/kvx/platform/pwr_ctrl.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+
+#include <asm/pwr_ctrl.h>
+#include <asm/symbols.h>
+
+struct kvx_pwr_ctrl {
+	void __iomem *regs;
+};
+
+static struct kvx_pwr_ctrl kvx_pwr_controller;
+
+/**
+ * kvx_pwr_ctrl_cpu_poweron() - Wakeup a cpu
+ * @cpu: cpu to wakeup
+ */
+void kvx_pwr_ctrl_cpu_poweron(unsigned int cpu)
+{
+	/* Set PE boot address */
+	writeq((unsigned long long)kvx_start,
+			kvx_pwr_controller.regs + KVX_PWR_CTRL_RESET_PC_OFFSET);
+	/* Wake up processor ! */
+	writeq(1ULL << cpu,
+	       kvx_pwr_controller.regs + PWR_CTRL_WUP_SET_OFFSET);
+	/* Then clear wakeup to allow processor to sleep */
+	writeq(1ULL << cpu,
+	       kvx_pwr_controller.regs + PWR_CTRL_WUP_CLEAR_OFFSET);
+}
+
+static struct device_node * __init get_pwr_ctrl_node(void)
+{
+	const phandle *ph;
+	struct device_node *cpu;
+	struct device_node *node;
+
+	cpu = of_get_cpu_node(raw_smp_processor_id(), NULL);
+	if (!cpu) {
+		pr_err("Failed to get CPU node\n");
+		return NULL;
+	}
+
+	ph = of_get_property(cpu, "power-controller", NULL);
+	if (!ph) {
+		pr_err("Failed to get power-controller phandle\n");
+		return NULL;
+	}
+
+	node = of_find_node_by_phandle(be32_to_cpup(ph));
+	if (!node) {
+		pr_err("Failed to get power-controller node\n");
+		return NULL;
+	}
+
+	return node;
+}
+
+int __init kvx_pwr_ctrl_probe(void)
+{
+	struct device_node *ctrl;
+
+	ctrl = get_pwr_ctrl_node();
+	if (!ctrl) {
+		pr_err("Failed to get power controller node\n");
+		return -EINVAL;
+	}
+
+	if (!of_device_is_compatible(ctrl, "kalray,kvx-pwr-ctrl")) {
+		pr_err("Failed to get power controller node\n");
+		return -EINVAL;
+	}
+
+	kvx_pwr_controller.regs = of_iomap(ctrl, 0);
+	if (!kvx_pwr_controller.regs) {
+		pr_err("Failed ioremap\n");
+		return -EINVAL;
+	}
+
+	pr_info("kvx power controller probed\n");
+
+	return 0;
+}
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f61447913db9..f5a484547b15 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -152,6 +152,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_RISCV_STARTING,
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
+	CPUHP_AP_IRQ_KVX_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
 	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
@@ -189,6 +190,7 @@ enum cpuhp_state {
 	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
 	CPUHP_AP_KVM_ARM_VGIC_STARTING,
 	CPUHP_AP_KVM_ARM_TIMER_STARTING,
+	CPUHP_AP_KVX_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
-- 
2.37.2





