Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01B5E60C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbiIVLTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiIVLTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:19:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5C111445
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:19:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fv3so9499559pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1DOD/mtKRhSpb4t1SpN7N4MZKca6Um+juPD/SwpyDeQ=;
        b=BV8uHCPiVFhanMNpkZ8jgZqYURxEaOJGieiIeiIYguJN2fXDJLW1njA2PKKK2Ir69n
         1hx6u3hZ/Zw05sVHPbVuU0luz52oHyC5kZ3uaEZqMrlA+k5tPxcPMd4AE966hq5Jmwrj
         FdFg3JE+4N0eJXGdjqScQt1hGGtZkp9kncXnvQi+I9lp+5/klnMibrf2x6P1rSLZ7SxN
         xsQ/WGl29MgsjpBHdngDMZfDjsny5JM/I5CwaonIX3XUklyrnZQpVSihff9uapXovFzC
         4XdwxrLkAYA8iaHspvjKfOgD8EWcJcNAREXWG1SPGvK8kdJxNRdzaqAMWUkta2luTCwj
         v0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1DOD/mtKRhSpb4t1SpN7N4MZKca6Um+juPD/SwpyDeQ=;
        b=HpM9OgNPV3XUas9zvR4mwMSL0w5gMTxCzZ+ZNlE+EoNM99MQbDckjEh6V6VI1FSaND
         ODHJP7Z/aWcW8mVvBf9l8MNLFw9l5eb0IaxnLrOU1yPfFl3PcsO5VVt3xGa5HLBKils3
         fKKBdQRYTfFDLv35WDiALwHyqzHyblBhoGFEZ7wpd277XFufTlTApsupvq4sMcgHuO98
         1FGxQu8iBsO7hM01cE3sb9O4BeQi9PdlEoX0RXc44zgR5MqmNyRPAN16DoFGUVIJbPX3
         sMJ0NQOjq5JQwT6spGWSUErkp7Vt8pjowfmVV+VaJYRd79PuV+1h2Ykp4SriqbTbyCrM
         1hbA==
X-Gm-Message-State: ACrzQf3QAWDV1BzZKDlBm5embN1yur5i4GyfgrN8oeR5ayORVsgUSHW3
        f1UB9tVQQHwD97ACRoVsUPE=
X-Google-Smtp-Source: AMsMyM7YrfpSdbm1Z1LrYliuhwXeR4ezHq3AgZrmoO6YH9luFFx7/fjhKv/vCxHTuNTeB4rLAb23bQ==
X-Received: by 2002:a17:902:edd0:b0:178:a475:6e18 with SMTP id q16-20020a170902edd000b00178a4756e18mr2840057plk.94.1663845579689;
        Thu, 22 Sep 2022 04:19:39 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00178aaf6247bsm3862644plm.21.2022.09.22.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 04:19:39 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH] rethook: add riscv rethook implementation.
Date:   Thu, 22 Sep 2022 19:19:33 +0800
Message-Id: <20220922111933.607219-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220922040443.605175-1-l3b2w1@gmail.com>
References: <20220922040443.605175-1-l3b2w1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Binglei Wang <l3b2w1@gmail.com>

Implement the kretprobes on riscv arch by using rethook machenism
which abstracts general kretprobe info into a struct rethook_node
to be embedded in the struct kretprobe_instance.

Signed-off-by: Binglei Wang <l3b2w1@gmail.com>
---
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/kernel/probes/Makefile             |  1 +
 arch/riscv/kernel/probes/kprobes.c            |  8 --
 arch/riscv/kernel/probes/kprobes_trampoline.S | 73 +----------------
 arch/riscv/kernel/probes/kprobes_trampoline.h | 79 +++++++++++++++++++
 arch/riscv/kernel/probes/rethook.c            | 26 ++++++
 arch/riscv/kernel/probes/rethook_trampoline.S | 22 ++++++
 include/linux/kprobes.h                       |  6 ++
 8 files changed, 136 insertions(+), 80 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.h
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
+	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc..ee345e7e9 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_RETHOOK) 		+= rethook.o rethook_trampoline.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index e6e950b7c..04911cc42 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -350,14 +350,6 @@ void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
 	return (void *)kretprobe_trampoline_handler(regs, NULL);
 }
 
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
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
index 7bdb09ded..54937f342 100644
--- a/arch/riscv/kernel/probes/kprobes_trampoline.S
+++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
@@ -2,78 +2,7 @@
 /*
  * Author: Patrick Stählin <me@packi.ch>
  */
-#include <linux/linkage.h>
-
-#include <asm/asm.h>
-#include <asm/asm-offsets.h>
-
-	.text
-	.altmacro
-
-	.macro save_all_base_regs
-	REG_S x1,  PT_RA(sp)
-	REG_S x3,  PT_GP(sp)
-	REG_S x4,  PT_TP(sp)
-	REG_S x5,  PT_T0(sp)
-	REG_S x6,  PT_T1(sp)
-	REG_S x7,  PT_T2(sp)
-	REG_S x8,  PT_S0(sp)
-	REG_S x9,  PT_S1(sp)
-	REG_S x10, PT_A0(sp)
-	REG_S x11, PT_A1(sp)
-	REG_S x12, PT_A2(sp)
-	REG_S x13, PT_A3(sp)
-	REG_S x14, PT_A4(sp)
-	REG_S x15, PT_A5(sp)
-	REG_S x16, PT_A6(sp)
-	REG_S x17, PT_A7(sp)
-	REG_S x18, PT_S2(sp)
-	REG_S x19, PT_S3(sp)
-	REG_S x20, PT_S4(sp)
-	REG_S x21, PT_S5(sp)
-	REG_S x22, PT_S6(sp)
-	REG_S x23, PT_S7(sp)
-	REG_S x24, PT_S8(sp)
-	REG_S x25, PT_S9(sp)
-	REG_S x26, PT_S10(sp)
-	REG_S x27, PT_S11(sp)
-	REG_S x28, PT_T3(sp)
-	REG_S x29, PT_T4(sp)
-	REG_S x30, PT_T5(sp)
-	REG_S x31, PT_T6(sp)
-	.endm
-
-	.macro restore_all_base_regs
-	REG_L x3,  PT_GP(sp)
-	REG_L x4,  PT_TP(sp)
-	REG_L x5,  PT_T0(sp)
-	REG_L x6,  PT_T1(sp)
-	REG_L x7,  PT_T2(sp)
-	REG_L x8,  PT_S0(sp)
-	REG_L x9,  PT_S1(sp)
-	REG_L x10, PT_A0(sp)
-	REG_L x11, PT_A1(sp)
-	REG_L x12, PT_A2(sp)
-	REG_L x13, PT_A3(sp)
-	REG_L x14, PT_A4(sp)
-	REG_L x15, PT_A5(sp)
-	REG_L x16, PT_A6(sp)
-	REG_L x17, PT_A7(sp)
-	REG_L x18, PT_S2(sp)
-	REG_L x19, PT_S3(sp)
-	REG_L x20, PT_S4(sp)
-	REG_L x21, PT_S5(sp)
-	REG_L x22, PT_S6(sp)
-	REG_L x23, PT_S7(sp)
-	REG_L x24, PT_S8(sp)
-	REG_L x25, PT_S9(sp)
-	REG_L x26, PT_S10(sp)
-	REG_L x27, PT_S11(sp)
-	REG_L x28, PT_T3(sp)
-	REG_L x29, PT_T4(sp)
-	REG_L x30, PT_T5(sp)
-	REG_L x31, PT_T6(sp)
-	.endm
+#include "kprobes_trampoline.h"
 
 ENTRY(__kretprobe_trampoline)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.h b/arch/riscv/kernel/probes/kprobes_trampoline.h
new file mode 100644
index 000000000..48895a5e3
--- /dev/null
+++ b/arch/riscv/kernel/probes/kprobes_trampoline.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef _KPROBES_TRAMPOLINE_H
+#define _KPROBES_TRAMPOLINE_H
+/*
+ * Author: Patrick Stählin <me@packi.ch>
+ */
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/asm-offsets.h>
+
+	.text
+	.altmacro
+
+	.macro save_all_base_regs
+	REG_S x1,  PT_RA(sp)
+	REG_S x3,  PT_GP(sp)
+	REG_S x4,  PT_TP(sp)
+	REG_S x5,  PT_T0(sp)
+	REG_S x6,  PT_T1(sp)
+	REG_S x7,  PT_T2(sp)
+	REG_S x8,  PT_S0(sp)
+	REG_S x9,  PT_S1(sp)
+	REG_S x10, PT_A0(sp)
+	REG_S x11, PT_A1(sp)
+	REG_S x12, PT_A2(sp)
+	REG_S x13, PT_A3(sp)
+	REG_S x14, PT_A4(sp)
+	REG_S x15, PT_A5(sp)
+	REG_S x16, PT_A6(sp)
+	REG_S x17, PT_A7(sp)
+	REG_S x18, PT_S2(sp)
+	REG_S x19, PT_S3(sp)
+	REG_S x20, PT_S4(sp)
+	REG_S x21, PT_S5(sp)
+	REG_S x22, PT_S6(sp)
+	REG_S x23, PT_S7(sp)
+	REG_S x24, PT_S8(sp)
+	REG_S x25, PT_S9(sp)
+	REG_S x26, PT_S10(sp)
+	REG_S x27, PT_S11(sp)
+	REG_S x28, PT_T3(sp)
+	REG_S x29, PT_T4(sp)
+	REG_S x30, PT_T5(sp)
+	REG_S x31, PT_T6(sp)
+	.endm
+
+	.macro restore_all_base_regs
+	REG_L x3,  PT_GP(sp)
+	REG_L x4,  PT_TP(sp)
+	REG_L x5,  PT_T0(sp)
+	REG_L x6,  PT_T1(sp)
+	REG_L x7,  PT_T2(sp)
+	REG_L x8,  PT_S0(sp)
+	REG_L x9,  PT_S1(sp)
+	REG_L x10, PT_A0(sp)
+	REG_L x11, PT_A1(sp)
+	REG_L x12, PT_A2(sp)
+	REG_L x13, PT_A3(sp)
+	REG_L x14, PT_A4(sp)
+	REG_L x15, PT_A5(sp)
+	REG_L x16, PT_A6(sp)
+	REG_L x17, PT_A7(sp)
+	REG_L x18, PT_S2(sp)
+	REG_L x19, PT_S3(sp)
+	REG_L x20, PT_S4(sp)
+	REG_L x21, PT_S5(sp)
+	REG_L x22, PT_S6(sp)
+	REG_L x23, PT_S7(sp)
+	REG_L x24, PT_S8(sp)
+	REG_L x25, PT_S9(sp)
+	REG_L x26, PT_S10(sp)
+	REG_L x27, PT_S11(sp)
+	REG_L x28, PT_T3(sp)
+	REG_L x29, PT_T4(sp)
+	REG_L x30, PT_T5(sp)
+	REG_L x31, PT_T6(sp)
+	.endm
+#endif
diff --git a/arch/riscv/kernel/probes/rethook.c b/arch/riscv/kernel/probes/rethook.c
new file mode 100644
index 000000000..4a41d5eb6
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.c
@@ -0,0 +1,26 @@
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
+	return rethook_trampoline_handler(regs, regs->s0);
+}
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->ra;
+	rhn->frame = regs->s0;
+
+	/* replace return addr with trampoline */
+	regs->ra = (u64)arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);
+
diff --git a/arch/riscv/kernel/probes/rethook_trampoline.S b/arch/riscv/kernel/probes/rethook_trampoline.S
new file mode 100644
index 000000000..e81c3d4e0
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook_trampoline.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Author: Patrick Stählin <me@packi.ch>
+ */
+#include "kprobes_trampoline.h"
+
+ENTRY(arch_rethook_trampoline)
+	addi sp, sp, -(PT_SIZE_ON_STACK)
+	save_all_base_regs
+
+	move a0, sp /* pt_regs */
+
+	call arch_rethook_trampoline_callback
+
+	/* use the result as the return-address */
+	move ra, a0
+
+	restore_all_base_regs
+	addi sp, sp, PT_SIZE_ON_STACK
+
+	ret
+ENDPROC(arch_rethook_trampoline)
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 55041d2f8..a3805b5b2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -210,6 +210,12 @@ static nokprobe_inline unsigned long get_kretprobe_retaddr(struct kretprobe_inst
 {
 	return ri->node.ret_addr;
 }
+static nokprobe_inline
+unsigned long kretprobe_trampoline_handler(struct pt_regs *regs,
+					   void *frame_pointer)
+{
+	return 0;
+}
 #else
 extern void arch_prepare_kretprobe(struct kretprobe_instance *ri,
 				   struct pt_regs *regs);
-- 
2.27.0

