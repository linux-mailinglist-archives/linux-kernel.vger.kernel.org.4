Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645A5F0649
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiI3IOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiI3IOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 04:14:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2774B3B731
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:14:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i6so3630667pfb.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Rx90Rt7fO84UH8DCCroYyG45NZ4RPd5Rm+ugKTi1MDg=;
        b=NQMf+cd775HNrQxuqA8tdVyckHfKQotbLLBSc1pN6xC12R3kJb70tW57wkkn9E3heV
         KdCo/94ZGdsaDKYyeFuv5Q1f4o7jVnapNwYxYaKbSvKoCkH8l+hR3wZTHFDbzh3qGhBH
         m8B+L4B6cPK2TZm8J791N1rhPFqs4JjUWjv4nZXKfybV1saAqtBMym6ZbBjdnbUI1jHt
         PE0tozCEtBcw5oULkSSwot+Li3Nuizpxu0nQbCKc6X9yTYR8ZdMN97M8zOt1oOwM45ew
         HEiF9DjuR2sym7INsKVrmu+z1wZgurD4s2PLL8yzHSZ/gsSde59OQg8hwvbbeXZ4Ga9b
         UGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Rx90Rt7fO84UH8DCCroYyG45NZ4RPd5Rm+ugKTi1MDg=;
        b=E+knrBX2XYKBBE3QI7rs/GDz2+w9e0vYSKpRahlzEPkMkbEq4cWrrtDhHcHPtSSbs+
         d34nuLV9Nj2DRKfMnj27bmyVzdvAcgw5qf/bJ2nVsfVDtPd1vbDG1Tv+TIPD+IepsYjL
         qTA/Zd7bqSdNz99eSaVt2OpqtROXca6UTztgFFAxoFFViGkahpxh0LenNmAj5K+vcp/l
         2qC22AQcEDvyuxuiB8RLux9PwVxcR075yvnsbmzy1lvWPCEkIDaisZnZESPEKReKxboL
         gf3bCxQvGJo4rfKcj5VtSrglFy6G8lD0UYwt83qLHkiPNLdNJtfMhyrvn3rr81KVKxZt
         Tivw==
X-Gm-Message-State: ACrzQf1aVPY6lW2ewNZfUI+As4+PfyWCvUPhxHJAVQwH8OSrmc71rfLX
        ylFB1x7DwR6RV75nwaHD/f4=
X-Google-Smtp-Source: AMsMyM5fiNbDmNeSunPc8btv2JMkPxWYzJsOmtsoPMAreYEAWKpLNAfC+9tSyZd8pP2ZI9fWwbLC4A==
X-Received: by 2002:a63:91c2:0:b0:440:faa6:eb63 with SMTP id l185-20020a6391c2000000b00440faa6eb63mr2558685pge.6.1664525643625;
        Fri, 30 Sep 2022 01:14:03 -0700 (PDT)
Received: from localhost.localdomain (l3b2w1.cn. [159.138.1.25])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b001746f66244asm1303035plg.18.2022.09.30.01.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 01:14:03 -0700 (PDT)
From:   Binglei Wang <l3b2w1@gmail.com>
X-Google-Original-From: Binglei Wang
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Binglei Wang <l3b2w1@gmail.com>
Subject: [PATCH v8] rethook: add riscv rethook implementation
Date:   Fri, 30 Sep 2022 16:13:57 +0800
Message-Id: <20220930081357.651914-1-l3b2w1@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
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

Notes:
    v8: Add the omitted rethook.h
    v7: Add the changelog.
    v6: Remove the kretprobes trampoline.
    v5: Trt to fix robot compiling error and warnings.
    v4: Add patch version number.
    v3: Trt to fix robot compiling error and warnings.
    v2: Add comit log to explain reasons behind changes.
        Use my personal email instead of work email
            to avoid the attachments of company informaton.
        Make the kprobes_trampoline.S code to be shared.
    v1: Add riscv rethook implementation.

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
index 59d18881f..bfb66cdc5 100644
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
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 217ef89f2..e7882ccb0 100644
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
index 7f0840dcc..c40139e9c 100644
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
index e6e950b7c..f21592d20 100644
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
index 000000000..cbd0da059
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
+NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
+
+
+void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs, bool mcount)
+{
+	rhn->ret_addr = regs->ra;
+	rhn->frame = regs->s0;
+
+	/* replace return addr with trampoline */
+	regs->ra = (unsigned long)arch_rethook_trampoline;
+}
+NOKPROBE_SYMBOL(arch_rethook_prepare);
+
diff --git a/arch/riscv/kernel/probes/rethook.h b/arch/riscv/kernel/probes/rethook.h
new file mode 100644
index 000000000..cc573d701
--- /dev/null
+++ b/arch/riscv/kernel/probes/rethook.h
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
index 7bdb09ded..21bac92a1 100644
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
2.27.0

