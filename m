Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B756DB7B7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 02:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjDHARI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 20:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDHARG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 20:17:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FD812BCA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 17:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3154964DA0
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 00:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8D6C433EF;
        Sat,  8 Apr 2023 00:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680913020;
        bh=yyBshPJE3zpb4N1qtQfOgAYrGbI0hX73GlLo744jarA=;
        h=From:To:Cc:Subject:Date:From;
        b=F+qEFLR1B37ggSs2mUhdCKT0cnPbqUqxvPDcVvqAPxFCWb2O2SIRVdjV5eEX0Vp9A
         yXczXqmz+z92FfFt41p4CX0r1TN2suTyvMNw3EuhWqWDX/08Ok3IcdnXGj4Kc8NU+8
         uoHMZHrkbQ7PcRPl4oyV1fssTYjetVtKrWBy//IG7WC8ab+r/BiEQljTPUYyn8TUSt
         7vz6+JUYpUuWOnDEDrIaKarUJmUXIlnKAFn+xSDrpc7KMoLHwUvfdj4JyFVpBGLF4l
         KsVwLjs/e7FDQgDdkbPIrG5CaKFKBInJyjZAwX433SskDFvlMrJzJp26oXe+HSBhFa
         7yS/DgJR7HogA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] x86/ibt: Convert IBT selftest to asm
Date:   Fri,  7 Apr 2023 17:16:41 -0700
Message-Id: <99a7e16b97bda97bf0a04aa141d6241cd8a839a2.1680912949.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following warning is reported when frame pointers and kernel IBT are
enabled:

  vmlinux.o: warning: objtool: ibt_selftest+0x11: sibling call from callable instruction with modified stack frame

The problem is that objtool interprets the indirect branch in
ibt_selftest() as a sibling call, and GCC inserts a (partial) frame
pointer prologue before it:

  0000 000000000003f550 <ibt_selftest>:
  0000    3f550:	f3 0f 1e fa          	endbr64
  0004    3f554:	e8 00 00 00 00       	call   3f559 <ibt_selftest+0x9>	3f555: R_X86_64_PLT32	__fentry__-0x4
  0009    3f559:	55                   	push   %rbp
  000a    3f55a:	48 8d 05 02 00 00 00 	lea    0x2(%rip),%rax        # 3f563 <ibt_selftest_ip>
  0011    3f561:	ff e0                	jmp    *%rax

Note the inline asm is missing ASM_CALL_CONSTRAINT, so the 'push %rbp'
happens before the indirect branch and the 'mov %rsp, %rbp' happens
afterwards.

Simplify the generated code and make it easier to understand for both
tools and humans by moving the selftest to proper asm.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/traps.h   |  3 ++-
 arch/x86/kernel/Makefile       |  1 +
 arch/x86/kernel/cet.c          | 23 +----------------------
 arch/x86/kernel/cpu/common.c   |  2 +-
 arch/x86/kernel/ibt_selftest.S | 17 +++++++++++++++++
 5 files changed, 22 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/kernel/ibt_selftest.S

diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 75e0dabf0c45..b1c9cea6ba88 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -18,7 +18,8 @@ void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
-extern bool ibt_selftest(void);
+extern int ibt_selftest(void);
+extern int ibt_selftest_noendbr(void);
 
 #ifdef CONFIG_X86_F00F_BUG
 /* For handling the FOOF bug */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index b366641703e3..a6f830263000 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,6 +48,7 @@ obj-y			+= process_$(BITS).o signal.o signal_$(BITS).o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
 obj-$(CONFIG_MODIFY_LDT_SYSCALL)	+= ldt.o
+obj-$(CONFIG_X86_KERNEL_IBT)		+= ibt_selftest.o
 obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
diff --git a/arch/x86/kernel/cet.c b/arch/x86/kernel/cet.c
index cc10d8be9d74..d2c732a34e5d 100644
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,9 +81,6 @@ static void do_user_cp_fault(struct pt_regs *regs, unsigned long error_code)
 
 static __ro_after_init bool ibt_fatal = true;
 
-/* code label defined in asm below */
-extern void ibt_selftest_ip(void);
-
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -91,7 +88,7 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 		return;
 	}
 
-	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_ip)) {
+	if (unlikely(regs->ip == (unsigned long)&ibt_selftest_noendbr)) {
 		regs->ax = 0;
 		return;
 	}
@@ -105,24 +102,6 @@ static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 	BUG();
 }
 
-/* Must be noinline to ensure uniqueness of ibt_selftest_ip. */
-noinline bool ibt_selftest(void)
-{
-	unsigned long ret;
-
-	asm ("	lea ibt_selftest_ip(%%rip), %%rax\n\t"
-	     ANNOTATE_RETPOLINE_SAFE
-	     "	jmp *%%rax\n\t"
-	     "ibt_selftest_ip:\n\t"
-	     UNWIND_HINT_FUNC
-	     ANNOTATE_NOENDBR
-	     "	nop\n\t"
-
-	     : "=a" (ret) : : "memory");
-
-	return !ret;
-}
-
 static int __init ibt_setup(char *str)
 {
 	if (!strcmp(str, "off"))
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ea06b0b4570..4ed967c9959c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -623,7 +623,7 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 
 	cr4_set_bits(X86_CR4_CET);
 
-	if (kernel_ibt && !ibt_selftest()) {
+	if (kernel_ibt && ibt_selftest()) {
 		pr_err("IBT selftest: Failed!\n");
 		wrmsrl(MSR_IA32_S_CET, 0);
 		setup_clear_cpu_cap(X86_FEATURE_IBT);
diff --git a/arch/x86/kernel/ibt_selftest.S b/arch/x86/kernel/ibt_selftest.S
new file mode 100644
index 000000000000..c43c4ed28a9c
--- /dev/null
+++ b/arch/x86/kernel/ibt_selftest.S
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/linkage.h>
+#include <linux/objtool.h>
+#include <asm/nospec-branch.h>
+
+SYM_CODE_START(ibt_selftest_noendbr)
+	ANNOTATE_NOENDBR
+	UNWIND_HINT_FUNC
+	/* #CP handler sets %ax to 0 */
+	RET
+SYM_CODE_END(ibt_selftest_noendbr)
+
+SYM_FUNC_START(ibt_selftest)
+	lea ibt_selftest_noendbr(%rip), %rax
+	ANNOTATE_RETPOLINE_SAFE
+	jmp *%rax
+SYM_FUNC_END(ibt_selftest)
-- 
2.39.2

