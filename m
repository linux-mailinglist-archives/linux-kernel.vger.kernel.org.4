Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FA72D9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjFMGJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238727AbjFMGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:09:08 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD968AA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:09:05 -0700 (PDT)
X-UUID: d19af8c6f57343e3905741d00c96f208-20230613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:c5a6ae68-30ef-42d4-8f93-34414e48ee36,IP:25,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-15
X-CID-INFO: VERSION:1.1.22,REQID:c5a6ae68-30ef-42d4-8f93-34414e48ee36,IP:25,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-META: VersionHash:120426c,CLOUDID:5556713e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:2306131408572XCVVZAK,BulkQuantity:0,Recheck:0,SF:24|17|19|44|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: d19af8c6f57343e3905741d00c96f208-20230613
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 638067123; Tue, 13 Jun 2023 14:08:56 +0800
From:   Haoran Jiang <jianghaoran@kylinos.cn>
To:     jianghaoran@kylinos.cn
Cc:     chenhuacai@kernel.org, conor.dooley@microchip.com,
        hejinyang@loongson.cn, jhrhhao@163.com, kernel@xen0n.name,
        l3b2w1@gmail.com, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, masahiroy@kernel.org,
        mhiramat@kernel.org, palmer@rivosinc.com, tangyouling@loongson.cn,
        yangtiezhu@loongson.cn, zhangqing@loongson.cn
Subject: [PATCH v3] LoongArch/rethook: Replace kretprobe with rethook on LoongArch
Date:   Tue, 13 Jun 2023 14:03:29 +0800
Message-Id: <20230613060329.356201-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230613011439.59168-1-jianghaoran@kylinos.cn>
References: <20230613011439.59168-1-jianghaoran@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
Replace kretprobe with rethook on x86")and commit b57c2f124098
("riscv: add riscv rethook implementation") to LoongArch.
Mainly refer to this commit
b57c2f124098 ("riscv: add riscv rethook implementation").

Replaces the kretprobe code with rethook on LoongArch. With this patch,
kretprobe on LoongArch uses the rethook instead of kretprobe specific
trampoline code.

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>

---
v3:
1,Fixed some format and spelling issues
2,According to this commit 571a2a50a8fc
(rethook, fprobe: do not trace rethook related functions),
the problem described in this commit Should be modified on LoongArch.

v2:
Modified the patch format and commit message.
---
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/kprobes.h          |  3 ---
 arch/loongarch/kernel/Makefile                |  7 ++++-
 arch/loongarch/kernel/kprobes.c               | 20 --------------
 arch/loongarch/kernel/rethook.c               | 27 +++++++++++++++++++
 arch/loongarch/kernel/rethook.h               |  8 ++++++
 ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
 7 files changed, 45 insertions(+), 27 deletions(-)
 create mode 100644 arch/loongarch/kernel/rethook.c
 create mode 100644 arch/loongarch/kernel/rethook.h
 rename arch/loongarch/kernel/{kprobes_trampoline.S => rethook_trampoline.S} (93%)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066fc931..5800aa52c82f 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -120,6 +120,7 @@ config LOONGARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RETHOOK
 	select HAVE_RSEQ
 	select HAVE_SAMPLE_FTRACE_DIRECT
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
index 798020ae02c6..7b9fc3ed71c3 100644
--- a/arch/loongarch/include/asm/kprobes.h
+++ b/arch/loongarch/include/asm/kprobes.h
@@ -49,9 +49,6 @@ bool kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_singlestep_handler(struct pt_regs *regs);
 
-void __kretprobe_trampoline(void);
-void *trampoline_probe_handler(struct pt_regs *regs);
-
 #else /* !CONFIG_KPROBES */
 
 static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) { return false; }
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 9a72d91cd104..7106ca996e55 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -52,6 +52,11 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes_trampoline.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
+
+CFLAGS_REMOVE_rethook.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_rethook_trampoline.o = $(CC_FLAGS_FTRACE)
+
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index 56c8c4b09a42..dbce23ba9970 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -378,26 +378,6 @@ int __init arch_init_kprobes(void)
 	return 0;
 }
 
-/* ASM function that handles the kretprobes must not be probed */
-NOKPROBE_SYMBOL(__kretprobe_trampoline);
-
-/* Called from __kretprobe_trampoline */
-void __used *trampoline_probe_handler(struct pt_regs *regs)
-{
-	return (void *)kretprobe_trampoline_handler(regs, NULL);
-}
-NOKPROBE_SYMBOL(trampoline_probe_handler);
-
-void arch_prepare_kretprobe(struct kretprobe_instance *ri,
-			    struct pt_regs *regs)
-{
-	ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
-	ri->fp = NULL;
-
-	/* Replace the return addr with trampoline addr */
-	regs->regs[1] = (unsigned long)&__kretprobe_trampoline;
-}
-NOKPROBE_SYMBOL(arch_prepare_kretprobe);
 
 int arch_trampoline_kprobe(struct kprobe *p)
 {
diff --git a/arch/loongarch/kernel/rethook.c b/arch/loongarch/kernel/rethook.c
new file mode 100644
index 000000000000..b5e7f62f7dea
--- /dev/null
+++ b/arch/loongarch/kernel/rethook.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic return hook for LoongArch.
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+#include "rethook.h"
+
+/* This is called from arch_rethook_trampoline() */
+unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, 0);
+}
+
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->regs[1];
+	rhn->frame = 0;
+
+	/* replace return addr with trampoline */
+	regs->regs[1] = (unsigned long)arch_rethook_trampoline;
+}
+
+NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/arch/loongarch/kernel/rethook.h b/arch/loongarch/kernel/rethook.h
new file mode 100644
index 000000000000..3f1c1edf0d0b
--- /dev/null
+++ b/arch/loongarch/kernel/rethook.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LOONGARCH_RETHOOK_H
+#define __LOONGARCH_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loongarch/kernel/rethook_trampoline.S
similarity index 93%
rename from arch/loongarch/kernel/kprobes_trampoline.S
rename to arch/loongarch/kernel/rethook_trampoline.S
index af94b0d213fa..bd5772c96338 100644
--- a/arch/loongarch/kernel/kprobes_trampoline.S
+++ b/arch/loongarch/kernel/rethook_trampoline.S
@@ -75,7 +75,7 @@
 	csrxchg t0, t1, LOONGARCH_CSR_CRMD
 	.endm
 
-SYM_CODE_START(__kretprobe_trampoline)
+SYM_CODE_START(arch_rethook_trampoline)
 	addi.d	sp, sp, -PT_SIZE
 	save_all_base_regs
 
@@ -84,7 +84,7 @@ SYM_CODE_START(__kretprobe_trampoline)
 
 	move a0, sp /* pt_regs */
 
-	bl trampoline_probe_handler
+	bl arch_rethook_trampoline_callback
 
 	/* use the result as the return-address */
 	move ra, a0
@@ -93,4 +93,4 @@ SYM_CODE_START(__kretprobe_trampoline)
 	addi.d	sp, sp, PT_SIZE
 
 	jr ra
-SYM_CODE_END(__kretprobe_trampoline)
+SYM_CODE_END(arch_rethook_trampoline)
-- 
2.27.0

