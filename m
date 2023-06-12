Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B14772B7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjFLFzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjFLFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:55:22 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408A5B7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 22:55:19 -0700 (PDT)
X-UUID: fd8932f1c2ac43c4a9da1a991d25c288-20230612
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:192ed0d9-28fc-4d8f-9b62-1ebb2203813c,IP:15,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-25
X-CID-INFO: VERSION:1.1.22,REQID:192ed0d9-28fc-4d8f-9b62-1ebb2203813c,IP:15,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:a31b503e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230612135506W0JV12BG,BulkQuantity:0,Recheck:0,SF:44|24|17|19|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: fd8932f1c2ac43c4a9da1a991d25c288-20230612
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1443604619; Mon, 12 Jun 2023 13:55:05 +0800
From:   jianghaoran <jianghaoran@kylinos.cn>
To:     chenhuacai@kernel.org
Cc:     kernel@xen0n.name, yangtiezhu@loongson.cn, zhangqing@loongson.cn,
        hejinyang@loongson.cn, tangyouling@loongson.cn,
        masahiroy@kernel.org, conor.dooley@microchip.com, l3b2w1@gmail.com,
        palmer@rivosinc.com, mhiramat@kernel.org,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        jhrhhao <jhrhhao@163.com>
Subject: [PATCH] LoongArch/rethook: Replace kretprobe with rethook on loongarch
Date:   Mon, 12 Jun 2023 13:49:49 +0800
Message-Id: <20230612054949.305652-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.27.0
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
Replace kretprobe with rethook on x86") to loongarch.

Replaces the kretprobe code with rethook on loongarch. With this patch,
kretprobe on loongarch uses the rethook instead of kretprobe specific
trampoline code.

Signed-off-by: jianghaoran<jianghaoran@kylinos.cn>
Signed-off-by: jhrhhao<jhrhhao@163.com>
---
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/include/asm/kprobes.h          |  3 ---
 arch/loongarch/kernel/Makefile                |  3 ++-
 arch/loongarch/kernel/kprobes.c               | 20 --------------
 arch/loongarch/kernel/rethook.c               | 27 +++++++++++++++++++
 arch/loongarch/kernel/rethook.h               |  9 +++++++
 ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
 7 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 arch/loongarch/kernel/rethook.c
 create mode 100644 arch/loongarch/kernel/rethook.h
 rename arch/loongarch/kernel/{kprobes_trampoline.S => rethook_trampoline.S} (93%)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066fc931..33753a1ab0bb 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -113,6 +113,7 @@ config LOONGARCH
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
+	select HAVE_RETHOOK
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PCI
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
index 9a72d91cd104..e0d4d29a6f0f 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
-obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes_trampoline.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 
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
index 000000000000..ac97b78daf55
--- /dev/null
+++ b/arch/loongarch/kernel/rethook.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic return hook for loongarch.
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
index 000000000000..22967d1e1281
--- /dev/null
+++ b/arch/loongarch/kernel/rethook.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LOONGARCH_RETHOOK_H
+#define __LOONGARCH_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
+
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

