Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B517960D053
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiJYPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiJYPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:20:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F515FE0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9237BB81D4F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2246C433D6;
        Tue, 25 Oct 2022 15:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666711175;
        bh=DE1F4TvoVP7AJhOmyQie2kpTOti803NS0bsN9b4in2U=;
        h=From:To:Cc:Subject:Date:From;
        b=AIyB/EAe5O/Dk4cq3GUmvEWOXbUwmgrJxjxBYYKp71ibK3jXCDAZLNgE4pxf38XwN
         ofsmwtImq4Y0ltv9kclyOJ3MH/kFUolxgCZy9VEZSkslzKVLkA8pKUANoK8i1lx0PG
         15NmipZQpyFlRjt6wN226pz1IUYf2vII7c81xvj5Og8fN/3RN9xS61joLfOh5qh7R6
         JFd8SM3wZgLVSj9Lnird+QKU7OZz5VnC7uOr5fHjVb59t0ZqZvgvL87nfSpANXRmlr
         HXAyV5/xIpq1d9pCDXC8bN1v7vk84ZpKRH0ohpxdw+hyBESNuVJ3HV2vd0zUfrnQZn
         KqRdQBcF3+J4w==
From:   Conor Dooley <conor@kernel.org>
To:     aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     l3b2w1@gmail.com, anil.s.keshavamurthy@intel.com, conor@kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v9] riscv: add riscv rethook implementation
Date:   Tue, 25 Oct 2022 16:18:32 +0100
Message-Id: <20221025151831.1097417-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Binglei Wang <l3b2w1@gmail.com>

Implement the kretprobes on riscv arch by using rethook machenism
which abstracts general kretprobe info into a struct rethook_node
to be embedded in the struct kretprobe_instance.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Binglei's patches do not seem to make it to the linux-riscv list, so
blindly resending on their behalf, with Masami's ack from v8 added.

 arch/riscv/Kconfig                            |  1 +
 arch/riscv/include/asm/kprobes.h              |  2 --
 arch/riscv/kernel/probes/Makefile             |  2 +-
 arch/riscv/kernel/probes/kprobes.c            | 13 ---------
 arch/riscv/kernel/probes/rethook.c            | 27 +++++++++++++++++++
 arch/riscv/kernel/probes/rethook.h            |  8 ++++++
 ...obes_trampoline.S => rethook_trampoline.S} |  6 ++---
 7 files changed, 40 insertions(+), 19 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/rethook.c
 create mode 100644 arch/riscv/kernel/probes/rethook.h
 rename arch/riscv/kernel/probes/{kprobes_trampoline.S => rethook_trampoline.S} (94%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6b48a3ae9843..413aeca71ca0 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -99,6 +99,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 217ef89f22b9..e7882ccb0fd4 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -40,8 +40,6 @@ void arch_remove_kprobe(struct kprobe *p);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
 bool kprobe_breakpoint_handler(struct pt_regs *regs);
 bool kprobe_single_step_handler(struct pt_regs *regs);
-void __kretprobe_trampoline(void);
-void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc31b..c40139e9ca47 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
-obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
+obj-$(CONFIG_RETHOOK)		+= rethook.o rethook_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7cf32..f21592d20306 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -345,19 +345,6 @@ int __init arch_populate_kprobe_blacklist(void)
 	return ret;
 }
 
-void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
-{
-	return (void *)kretprobe_trampoline_handler(regs, NULL);
-}
-
-void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
-				      struct pt_regs *regs)
-{
-	ri->ret_addr = (kprobe_opcode_t *)regs->ra;
-	ri->fp = NULL;
-	regs->ra = (unsigned long) &__kretprobe_trampoline;
-}
-
 int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 {
 	return 0;
diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
new file mode 100644
index 000000000000..5c27c1f50989
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Generic return hook for riscv.
+ */
+
+#include <linux/kprobes.h>
+#include <linux/rethook.h>
+#include "rethook.h"
+
+/* This is called from arch_rethook_trampoline() */
+unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *regs)
+{
+	return rethook_trampoline_handler(regs, regs->s0);
+}
+
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->ra;
+	rhn->frame = regs->s0;
+
+	/* replace return addr with trampoline */
+	regs->ra = (unsigned long)arch_rethook_trampoline;
+}
+
+NOKPROBE_SYMBOL(arch_rethook_prepare);
diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
new file mode 100644
index 000000000000..4758f7e3ce88
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __RISCV_RETHOOK_H
+#define __RISCV_RETHOOK_H
+
+unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount);
+
+#endif
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
similarity index 94%
rename from arch/riscv/kernel/probes/kprobes_trampoline.S
rename to arch/riscv/kernel/probes/rethook_trampoline.S
index 7bdb09ded39b..21bac92a170a 100644
--- a/arch/riscv/kernel/probes/kprobes_trampoline.S
+++ b/arch/riscv/kernel/probes/rethook_trampoline.S
@@ -75,13 +75,13 @@
 	REG_L x31, PT_T6(sp)
 	.endm
 
-ENTRY(__kretprobe_trampoline)
+ENTRY(arch_rethook_trampoline)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
 	save_all_base_regs
 
 	move a0, sp /* pt_regs */
 
-	call trampoline_probe_handler
+	call arch_rethook_trampoline_callback
 
 	/* use the result as the return-address */
 	move ra, a0
@@ -90,4 +90,4 @@ ENTRY(__kretprobe_trampoline)
 	addi sp, sp, PT_SIZE_ON_STACK
 
 	ret
-ENDPROC(__kretprobe_trampoline)
+ENDPROC(arch_rethook_trampoline)
-- 
2.38.0

