Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A06612956
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiJ3JVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJ3JVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:21:40 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CD1DBC85
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:21:36 -0700 (PDT)
Received: from cgk-Precision-3650-Tower.. (unknown [219.141.235.82])
        by APP-03 (Coremail) with SMTP id rQCowABXCVmKPV5jkxYmBw--.33365S5;
        Sun, 30 Oct 2022 17:02:17 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH 1/8] riscv/kprobe: Prepare the skeleton to implement RISCV OPTPROBES feature
Date:   Sun, 30 Oct 2022 17:01:34 +0800
Message-Id: <20221030090141.2550837-2-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
References: <20221030090141.2550837-1-chenguokai17@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABXCVmKPV5jkxYmBw--.33365S5
X-Coremail-Antispam: 1UD129KBjvJXoW3XrykCr47Xr4rKFyxJFW8WFg_yoW7Kw4UpF
        s5Cwn5WrWDA3s3G3yfJw1kuFWFqan5Wa17KryDZry5Xw4rtr45Awn2grW5XryxGrs0gryf
        WF1Fvry5Cry3X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmK14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
        c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
        ACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I
        3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
        WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
        wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
        k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUjpnmDUUUU
X-Originating-IP: [219.141.235.82]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCQEPE2NeHVkoZAAAsh
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

Prepare skeleton to implement optimized kprobe on RISCV, it consists
of Makfile, Kconfig and some architecture specific files: kprobe.h and
opt.c opt.c includes some macro, type definition and functions required
by kprobe framework, opt_trampoline.S provides a piece of assembly code
template used to construct the detour buffer as the target of long jump
instruction(s) for each optimzed kprobe.

Since the jump range of PC-relative instruction JAL is +/-1M, that is
too small to reach the detour buffer, hence the foudamental idea to
address OPTPROBES on RISCV is to replace 'EBREAK' with 'AUIPC+JALR'. which
means it needs to clobber one more instruction beside the kprobe
instruction, furthermore, RISCV supports hybird RVI and RVC in single
kernel binary, so in theory a pair of 'AUIPC/JALR' is about to clobber
10 bytes(3 RVC and 1 RVI, 2 bytes is padding for alignment) at worst
case. The second hardsome problem is looking for one integer register as
the destination of 'AUIPC/JALR' without any side-effect.

More solution details will be introduced in the coming commits.

Co-developed-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
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
index 6b48a3ae9843..ca29306c93e2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -99,6 +99,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_OPTPROBES if !XIP_KERNEL
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 217ef89f22b9..22b73a2fd1fd 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -43,5 +43,37 @@ bool kprobe_single_step_handler(struct pt_regs *regs);
 void __kretprobe_trampoline(void);
 void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 
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
+ * For RVI and RVC hybird encoding kernel, althought long jump just needs
+ * 2 RVI instructions(AUIPC+JALR), optimized instructions is 10 bytes long
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
index 7f0840dcc31b..6255b4600875 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
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
2.25.1

