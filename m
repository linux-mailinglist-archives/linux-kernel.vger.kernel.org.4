Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085445BE48C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiITLfG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Sep 2022 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiITLfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:35:03 -0400
X-Greylist: delayed 6776 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Sep 2022 04:35:01 PDT
Received: from h3cspam01-ex.h3c.com (smtp.h3c.com [221.12.31.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26965251
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 04:35:00 -0700 (PDT)
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 28K9g1OR099096
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 17:42:01 +0800 (GMT-8)
        (envelope-from wang.binglei@h3c.com)
Received: from mail.maildlp.com ([172.25.15.155])
        by h3cspam01-ex.h3c.com with ESMTP id 28K9dsDj085705;
        Tue, 20 Sep 2022 17:39:54 +0800 (GMT-8)
        (envelope-from wang.binglei@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (unknown [172.20.54.133])
        by mail.maildlp.com (Postfix) with ESMTP id ED25722BE810;
        Tue, 20 Sep 2022 17:40:56 +0800 (CST)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 20 Sep 2022 17:39:55 +0800
From:   Binglei Wang <wang.binglei@h3c.com>
To:     <paul.walmsley@sifive.com>
CC:     <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <l3b2w1@gmail.com>, "wang.binglei" <wang.binglei@h3c.com>
Subject: [PATCH] rethook: add riscv rethook implementation.
Date:   Tue, 20 Sep 2022 17:36:30 +0800
Message-ID: <20220920093630.32085-1-wang.binglei@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX10-IDC.srv.huawei-3com.com (172.20.54.133)
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 28K9g1OR099096
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "wang.binglei" <wang.binglei@h3c.com>

Most of the code copied from
arch/riscv/kernel/probes/kprobes_trampoline.S

Signed-off-by: wang.binglei <wang.binglei@h3c.com>
---
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/kernel/probes/Makefile             |  1 +
 arch/riscv/kernel/probes/kprobes.c            |  7 ++
 arch/riscv/kernel/probes/rethook.c            | 24 +++++
 arch/riscv/kernel/probes/rethook_trampoline.S | 94 +++++++++++++++++++
 5 files changed, 127 insertions(+)
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook_trampoline.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ed66c31e4..c5cae0825 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -97,6 +97,7 @@ config RISCV
        select HAVE_KPROBES if !XIP_KERNEL
        select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
        select HAVE_KRETPROBES if !XIP_KERNEL
+       select HAVE_RETHOOK if !XIP_KERNEL
        select HAVE_MOVE_PMD
        select HAVE_MOVE_PUD
        select HAVE_PCI
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc..ee345e7e9 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)           += kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)          += kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)        += ftrace.o
 obj-$(CONFIG_UPROBES)          += uprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_RETHOOK)          += rethook.o rethook_trampoline.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7c..2c1847921 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -345,6 +345,7 @@ int __init arch_populate_kprobe_blacklist(void)
        return ret;
 }

+#ifndef CONFIG_KRETPROBE_ON_RETHOOK
 void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 {
        return (void *)kretprobe_trampoline_handler(regs, NULL);
@@ -357,6 +358,12 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
        ri->fp = NULL;
        regs->ra = (unsigned long) &__kretprobe_trampoline;
 }
+#else
+void __kprobes *trampoline_probe_handler(struct pt_regs *regs)
+{
+       return NULL;
+}
+#endif

 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
new file mode 100644
index 000000000..47853bc36
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic return hook for riscv.
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+
+/* This is called from arch_rethook_trampoline() */
+unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+       return rethook_trampoline_handler(regs, regs->s0);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+       rhn->ret_addr = regs->ra;
+       rhn->frame = regs->s0;
+
+       /* replace return addr with trampoline */
+       regs->ra = (u64)arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
new file mode 100644
index 000000000..aa79630ac
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook_trampoline.S
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * rethook trampoline.
+ * Copied from arch/riscv/kernel/probes/kprobes_trampoline.S
+ */
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+
+       .text
+       .altmacro
+
+       .macro save_all_base_regs
+       REG_S x1,  PT_RA(sp)
+       REG_S x3,  PT_GP(sp)
+       REG_S x4,  PT_TP(sp)
+       REG_S x5,  PT_T0(sp)
+       REG_S x6,  PT_T1(sp)
+       REG_S x7,  PT_T2(sp)
+       REG_S x8,  PT_S0(sp)
+       REG_S x9,  PT_S1(sp)
+       REG_S x10, PT_A0(sp)
+       REG_S x11, PT_A1(sp)
+       REG_S x12, PT_A2(sp)
+       REG_S x13, PT_A3(sp)
+       REG_S x14, PT_A4(sp)
+       REG_S x15, PT_A5(sp)
+       REG_S x16, PT_A6(sp)
+       REG_S x17, PT_A7(sp)
+       REG_S x18, PT_S2(sp)
+       REG_S x19, PT_S3(sp)
+       REG_S x20, PT_S4(sp)
+       REG_S x21, PT_S5(sp)
+       REG_S x22, PT_S6(sp)
+       REG_S x23, PT_S7(sp)
+       REG_S x24, PT_S8(sp)
+       REG_S x25, PT_S9(sp)
+       REG_S x26, PT_S10(sp)
+       REG_S x27, PT_S11(sp)
+       REG_S x28, PT_T3(sp)
+       REG_S x29, PT_T4(sp)
+       REG_S x30, PT_T5(sp)
+       REG_S x31, PT_T6(sp)
+       .endm
+
+       .macro restore_all_base_regs
+       REG_L x3,  PT_GP(sp)
+       REG_L x4,  PT_TP(sp)
+       REG_L x5,  PT_T0(sp)
+       REG_L x6,  PT_T1(sp)
+       REG_L x7,  PT_T2(sp)
+       REG_L x8,  PT_S0(sp)
+       REG_L x9,  PT_S1(sp)
+       REG_L x10, PT_A0(sp)
+       REG_L x11, PT_A1(sp)
+       REG_L x12, PT_A2(sp)
+       REG_L x13, PT_A3(sp)
+       REG_L x14, PT_A4(sp)
+       REG_L x15, PT_A5(sp)
+       REG_L x16, PT_A6(sp)
+       REG_L x17, PT_A7(sp)
+       REG_L x18, PT_S2(sp)
+       REG_L x19, PT_S3(sp)
+       REG_L x20, PT_S4(sp)
+       REG_L x21, PT_S5(sp)
+       REG_L x22, PT_S6(sp)
+       REG_L x23, PT_S7(sp)
+       REG_L x24, PT_S8(sp)
+       REG_L x25, PT_S9(sp)
+       REG_L x26, PT_S10(sp)
+       REG_L x27, PT_S11(sp)
+       REG_L x28, PT_T3(sp)
+       REG_L x29, PT_T4(sp)
+       REG_L x30, PT_T5(sp)
+       REG_L x31, PT_T6(sp)
+       .endm
+
+ENTRY(arch_rethook_trampoline)
+       addi sp, sp, -(PT_SIZE_ON_STACK)
+       save_all_base_regs
+
+       move a0, sp /* pt_regs */
+
+       call arch_rethook_trampoline_callback
+
+       /* use the result as the return-address */
+       move ra, a0
+
+       restore_all_base_regs
+       addi sp, sp, PT_SIZE_ON_STACK
+
+       ret
+ENDPROC(arch_rethook_trampoline)
--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
邮件！
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
