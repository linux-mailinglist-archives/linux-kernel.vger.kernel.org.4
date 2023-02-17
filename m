Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0CF69A31F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjBQAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBQAud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:33 -0500
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E45828A;
        Thu, 16 Feb 2023 16:50:14 -0800 (PST)
X-QQ-mid: bizesmtp76t1676594991t44bsp5y
Received: from localhost.localdomain ( [116.30.131.224])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 17 Feb 2023 08:49:49 +0800 (CST)
X-QQ-SSF: 01200000000000C0T000000A0000000
X-QQ-FEAT: jGGC4gWX7WEdtHNjbW2La5D1yIRo1r+Zw/KaMj6Bl464xthLk0kAH0yAvRVPu
        pQdpYfLzsKgWo0JcHqKeObB4CrGIvHKePNNUzCW3kJCwsR3UUngiOXTUDO2pSg5aXI5963T
        w7WclL2OLpN1imcjF5siVtz2b6B6g4sRmXFVZMTQzEHe7zv76gtN3EFNDOZTxrEl1Mqp4eQ
        oHep0yeehO8eA+Cwwd+Iw4beO1XFcCt+dJ5cV+YpBSQoTHm/Ngf11fhZYRFGSsljUYsGb6L
        9yBH/B5Mt7pWcK5iwojBnpW3zqBCnthsxNlqGdlXPAEuemx7vbHMCzkkB0/xKKlhEsFouD+
        mLEpshtFxpdm8ttAwcJUSciB3GCHrBdeebHRFIkUgqAeR/VpZsr9k3ws58PpM1AN9d+HCtD
X-QQ-GoodBg: 0
From:   Zhangjin Wu <falcon@tinylab.org>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Palmer Dabbelt <palmer@rivosinc.com>, Willy Tarreau <w@1wt.eu>,
        Paul Burton <paulburton@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Zhangjin Wu <falcon@tinylab.org>
Subject: [RFC PATCH 4/5] RISC-V: Add dead syscalls elimination support
Date:   Fri, 17 Feb 2023 08:49:24 +0800
Message-Id: <9a4d0339dd8175cdb3801dc66d68167cac47ddbf.1676594211.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1676594211.git.falcon@tinylab.org>
References: <cover.1676594211.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By enabling CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION and setting
CONFIG_SYSCALLS_USED, It is able to remove the left 'dead' syscalls.

For example, if setting CONFIG_SYSCALLS_USED="write exit reboot", a
'used' variant of the *syscall_table.c will be generated.

Here is a test result on qemu with a minimal rv64 config.

                    | rv64            | config
    ----------------|-----------------|-------------------
            vmlinux | 4893488         | https://pastebin.com/crz82T0s
      + gc-sections | 4376400 (-10.5%)| CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y
    + syscalls_used | 4172112 (-4.67%)| CONFIG_SYSCALLS_USED="pselect6"
    + syscalls_used | 4172848 (-4.65%)| CONFIG_SYSCALLS_USED="write exit reboot"

notes:

- The shrink ratios of the syscalls_used lines are based on the
  gc-sections line.

- "write exit reboot" are used by a hello.c to simply print "Hello,
   World!", exit and shutdown qemu.

- "pselect6" is used by rcutorture to do a long-time sleep.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 arch/riscv/Kconfig                  |  1 +
 arch/riscv/kernel/Makefile          |  5 ++--
 arch/riscv/kernel/syscalls/Makefile | 46 +++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)
 create mode 100644 arch/riscv/kernel/syscalls/Makefile

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8a73d7180cb8..f78cc6b2413f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -140,6 +140,7 @@ config RISCV
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_SYSCALLS_USED
 
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..fd716d5ffda5 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -8,7 +8,8 @@ CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
-CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
+
+obj-y += syscalls/
 
 ifdef CONFIG_KEXEC
 AFLAGS_kexec_relocate.o := -mcmodel=medany $(call cc-option,-mno-relax)
@@ -42,7 +43,6 @@ obj-y	+= ptrace.o
 obj-y	+= reset.o
 obj-y	+= setup.o
 obj-y	+= signal.o
-obj-y	+= syscall_table.o
 obj-y	+= sys_riscv.o
 obj-y	+= time.o
 obj-y	+= traps.o
@@ -86,6 +86,5 @@ obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 obj-$(CONFIG_EFI)		+= efi.o
-obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
diff --git a/arch/riscv/kernel/syscalls/Makefile b/arch/riscv/kernel/syscalls/Makefile
new file mode 100644
index 000000000000..7bd327331a98
--- /dev/null
+++ b/arch/riscv/kernel/syscalls/Makefile
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
+#
+
+CFLAGS_syscall_table_used.o	+= $(call cc-option,-Wno-override-init,)
+obj-y				+= syscall_table_used.o
+obj-$(CONFIG_COMPAT)		+= compat_syscall_table_used.o
+
+ifdef CONFIG_SYSCALLS_USED
+syscalls_used := $(shell echo $(CONFIG_SYSCALLS_USED) | tr -s ' ' | tr ' ' '|')
+endif
+
+ifneq ($(syscalls_used),)
+
+quiet_cmd_calc = CALC    $@
+      cmd_calc = sed -n -e '/^\[([0-9 +]*)\] = /{s/.*\[\(.*\)\] = .*/sed \\"s%^\\\\[\1\\\\] = %[$$((\1))] = %g\\" -i /gp}' $@ | xargs -I{} echo {} $@ | sh;
+
+quiet_cmd_used = USED    $@
+      cmd_used = sed -E -e '/^\[[0-9]*\] = /{/(^\[($(syscalls_used))\] *=|= *\((sys_)*($(syscalls_used))\),)/!{s%^%// %g}}' -i $@;
+
+$(obj)/syscall_table.i: $(src)/../syscall_table.c $(objtree)/.config FORCE
+	$(call if_changed_dep,cpp_i_c)
+	$(call cmd,calc)
+	$(call cmd,used)
+
+$(obj)/syscall_table_used.o: $(obj)/syscall_table.i FORCE
+	$(call if_changed,cc_o_c)
+
+$(obj)/compat_syscall_table.i: $(src)/../compat_syscall_table.c $(objtree)/.config FORCE
+	$(call if_changed_dep,cpp_i_c)
+	$(call cmd,calc)
+	$(call cmd,used)
+
+$(obj)/compat_syscall_table_used.o: $(obj)/compat_syscall_table.i FORCE
+	$(call if_changed,cc_o_c)
+
+else
+
+$(obj)/syscall_table_used.o: $(src)/../syscall_table.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/compat_syscall_table_used.o: $(src)/../compat_syscall_table.c FORCE
+	$(call if_changed_rule,cc_o_c)
+
+endif
-- 
2.25.1

