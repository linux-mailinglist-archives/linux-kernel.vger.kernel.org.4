Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83346AD7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCGHKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCGHKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:10:08 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B835303EB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:10:05 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxedlL4wZkwj8JAA--.11679S3;
        Tue, 07 Mar 2023 15:10:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf+RJ4wZkk7hNAA--.35219S2;
        Tue, 07 Mar 2023 15:10:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH] LoongArch: Add support for function error injection
Date:   Tue,  7 Mar 2023 15:10:01 +0800
Message-Id: <1678173001-16852-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxf+RJ4wZkk7hNAA--.35219S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAF4kKr47Jr13Zr13GFWktFb_yoWrJr1kpF
        9IywnrGrWkWr4xJr9IyFyrZFyvvFs7CFW29F1Ika4rCrW7Zr1ktr4kKryqqF48G3yUGrW0
        g3WrGr43tF45CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
        0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
        W8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inspired by the commit 42d038c4fb00 ("arm64: Add support for function error
injection") and commit ee55ff803b38 ("riscv: Add support for function error
injection"), support function error injection for LoongArch.

Mainly implement two functions:
(1) regs_set_return_value() which is used to overwrite the return value,
(2) override_function_with_return() which is used to override the probed
function returning and jump to its caller.

Here is a simple test under CONFIG_FUNCTION_ERROR_INJECTION and
CONFIG_FAIL_FUNCTION:

  # echo sys_clone > /sys/kernel/debug/fail_function/inject
  # echo 100 > /sys/kernel/debug/fail_function/probability
  # dmesg
  bash: fork: Invalid argument
  # dmesg
  ...
  FAULT_INJECTION: forcing a failure.
  name fail_function, interval 1, probability 100, space 0, times 1
  ...
  Call Trace:
  [<90000000002238f4>] show_stack+0x5c/0x180
  [<90000000012e384c>] dump_stack_lvl+0x60/0x88
  [<9000000000b1879c>] should_fail_ex+0x1b0/0x1f4
  [<900000000032ead4>] fei_kprobe_handler+0x28/0x6c
  [<9000000000230970>] kprobe_breakpoint_handler+0xf0/0x118
  [<90000000012e3e60>] do_bp+0x2c4/0x358
  [<9000000002241924>] exception_handlers+0x1924/0x10000
  [<900000000023b7d0>] sys_clone+0x0/0x4
  [<90000000012e4744>] do_syscall+0x7c/0x94
  [<9000000000221e44>] handle_syscall+0xc4/0x160

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ptrace.h |  6 ++++++
 arch/loongarch/lib/Makefile         |  2 ++
 arch/loongarch/lib/error-inject.c   | 10 ++++++++++
 4 files changed, 19 insertions(+)
 create mode 100644 arch/loongarch/lib/error-inject.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 7fd5125..b16ff7e 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -99,6 +99,7 @@ config LOONGARCH
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
index d761db9..db7332a 100644
--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -154,6 +154,12 @@ static inline long regs_return_value(struct pt_regs *regs)
 	return regs->regs[4];
 }
 
+static inline void regs_set_return_value(struct pt_regs *regs,
+					 unsigned long val)
+{
+	regs->regs[4] = val;
+}
+
 #define instruction_pointer(regs) ((regs)->csr_era)
 #define profile_pc(regs) instruction_pointer(regs)
 
diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 40bde63..30b1595 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -5,3 +5,5 @@
 
 lib-y	+= delay.o memset.o memcpy.o memmove.o \
 	   clear_user.o copy_user.o dump_tlb.o unaligned.o
+
+obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/arch/loongarch/lib/error-inject.c b/arch/loongarch/lib/error-inject.c
new file mode 100644
index 0000000..afc9e1c
--- /dev/null
+++ b/arch/loongarch/lib/error-inject.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/error-injection.h>
+#include <linux/kprobes.h>
+
+void override_function_with_return(struct pt_regs *regs)
+{
+	instruction_pointer_set(regs, regs->regs[1]);
+}
+NOKPROBE_SYMBOL(override_function_with_return);
-- 
2.1.0

