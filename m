Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B97E67E66B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjA0NTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjA0NSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:18:32 -0500
Received: from cstnet.cn (smtp80.cstnet.cn [159.226.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B091165EF7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:18:01 -0800 (PST)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-01 (Coremail) with SMTP id qwCowADX3Eg9zNNjDyF3Ag--.52827S5;
        Fri, 27 Jan 2023 21:06:08 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v6 01/13] riscv/kprobe: Prepare the skeleton to implement RISCV OPTPROBES
Date:   Fri, 27 Jan 2023 21:05:29 +0800
Message-Id: <20230127130541.1250865-2-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
References: <20230127130541.1250865-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADX3Eg9zNNjDyF3Ag--.52827S5
X-Coremail-Antispam: 1UD129KBjvJXoWxtr48Gr4DZFy5ur45JryxZrb_yoW7Ar4DpF
        s5Cws5WrWrAas3G3yay3WkurWSqan5Ga17KrWDAry5Jr4xtr45Awn2grWUXrWxJrn0gryf
        WF1FvryYkry3X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQj14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
        C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVAFwVW5GwCF04k20xvY0x0EwIxGrwCF
        x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
        v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
        67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
        IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUw2-5UUUUU=
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiAwoEE2PTrr4gzgAAsQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

Prepare skeleton to implement optimized kprobe on RISCV, although some
architecture specific functions are left blank, they do not change the
correctness of existing kprobe code, on account of these functions just
return zero. To avoid each patch being too complicated to review and
test, these functions will be implemented incrementally.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
 arch/riscv/Kconfig                        |  1 +
 arch/riscv/include/asm/kprobes.h          | 32 ++++++++++++++
 arch/riscv/kernel/probes/Makefile         |  1 +
 arch/riscv/kernel/probes/opt.c            | 51 +++++++++++++++++++++++
 arch/riscv/kernel/probes/opt_trampoline.S | 12 ++++++
 5 files changed, 97 insertions(+)
 create mode 100644 arch/riscv/kernel/probes/opt.c
 create mode 100644 arch/riscv/kernel/probes/opt_trampoline.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 9c687da7756d..48a639c7c055 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -101,6 +101,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_OPTPROBES if !XIP_KERNEL
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index e7882ccb0fd4..96cd36e67e2e 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -41,5 +41,37 @@ int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
 
+#ifdef CONFIG_OPTPROBES
+
+/* optinsn template addresses */
+extern __visible kprobe_opcode_t optprobe_template_entry[];
+extern __visible kprobe_opcode_t optprobe_template_end[];
+
+#define MAX_OPTINSN_SIZE				\
+	((unsigned long)optprobe_template_end -		\
+	 (unsigned long)optprobe_template_entry)
+
+/*
+ * For RVI and RVC hybrid encoding kernel, although long jump just needs
+ * 2 RVI instructions(AUIPC/JALR), optimized instructions are 10 bytes long
+ * at most to ensure no RVI would be truncated actually, so it means four
+ * combinations:
+ * - 2 RVI
+ * - 4 RVC
+ * - 2 RVC + 1 RVI
+ * - 3 RVC + 1 RVI (truncated, need padding)
+ */
+#define MAX_COPIED_INSN		4
+#define MAX_OPTIMIZED_LENGTH	10
+
+struct arch_optimized_insn {
+	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
+	/* detour code buffer */
+	kprobe_opcode_t *insn;
+	unsigned long length;
+	int rd;
+};
+
+#endif /* CONFIG_OPTPROBES */
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index c40139e9ca47..3d837eb5f9be 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_OPTPROBES)		+= opt.o opt_trampoline.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
new file mode 100644
index 000000000000..56c8a227c857
--- /dev/null
+++ b/arch/riscv/kernel/probes/opt.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Kernel Probes Jump Optimization (Optprobes)
+ *
+ * Copyright (C) Guokai Chen, 2022
+ * Author: Guokai Chen chenguokai17@mails.ucas.ac.cn
+ */
+
+#define pr_fmt(fmt)	"optprobe: " fmt
+
+#include <linux/kprobes.h>
+#include <asm/kprobes.h>
+
+int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
+{
+	return 0;
+}
+
+int arch_check_optimized_kprobe(struct optimized_kprobe *op)
+{
+	return 0;
+}
+
+int arch_prepare_optimized_kprobe(struct optimized_kprobe *op,
+				  struct kprobe *orig)
+{
+	return 0;
+}
+
+void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
+{
+}
+
+void arch_optimize_kprobes(struct list_head *oplist)
+{
+}
+
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			     struct list_head *done_list)
+{
+}
+
+void arch_unoptimize_kprobe(struct optimized_kprobe *op)
+{
+}
+
+int arch_within_optimized_kprobe(struct optimized_kprobe *op,
+				 kprobe_opcode_t *addr)
+{
+	return 0;
+}
diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kernel/probes/opt_trampoline.S
new file mode 100644
index 000000000000..16160c4367ff
--- /dev/null
+++ b/arch/riscv/kernel/probes/opt_trampoline.S
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2022 Guokai Chen
+ */
+
+#include <linux/linkage.h>
+
+#incldue <asm/csr.h>
+#include <asm/asm-offsets.h>
+
+SYM_ENTRY(optprobe_template_entry, SYM_L_GLOBAL, SYM_A_NONE)
+SYM_ENTRY(optprobe_template_end, SYM_L_GLOBAL, SYM_A_NONE)
-- 
2.34.1

