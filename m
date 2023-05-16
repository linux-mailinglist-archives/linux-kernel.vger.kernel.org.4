Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66587052B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjEPPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjEPPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29769ED1;
        Tue, 16 May 2023 08:47:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C815F63B99;
        Tue, 16 May 2023 15:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D8FC433D2;
        Tue, 16 May 2023 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252002;
        bh=KLWXUkA+xw6ufIF2Y6Rrjld4fO8/uWU2onDLin/MBKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XupDrLYZfz0Ho8oARZnpqlV7xaLVt+1SYX+Rw9GsFzYijEbjeT3Fc29pymQBw2kun
         S46mkDG+ogDR5ZzG2DeBnrbJEjreYn1tdgGC42+VNYBRz+PnMnC1A93y6G17a0dBqd
         /71Le/zYCKvn3XuVjeeyuL2WYkt5EQnNSCKUFjijliubp5V8krFUKrnbdpYmfHjdNp
         OwlZ3MsP8J9aRERPsdfRrww1xfsOKIPo1bsN2dyVzufqWxlG33Ef6aTAst+NJwUUku
         WFbsGGc/WBmluku+L3eIJnNql2v60EpQSjdsufl8imSMZXbEvj+zi2zGJPc71Upc7U
         kRpmvCR1blZUw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 07/16] ARM: add prototype for function called only from asm
Date:   Tue, 16 May 2023 17:45:56 +0200
Message-Id: <20230516154605.517690-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with 'make W=1', the compiler warns about any function
definition that does not come with a prototype in a header, to ensure
it matches what the caller expects.

This includes functions that are only ever caller from assembly
code and don't technically need a declaration:

arch/arm/kernel/ftrace.c:227:6: error: no previous prototype for 'prepare_ftrace_return'
arch/arm/kernel/ptrace.c:850:16: error: no previous prototype for 'syscall_trace_enter'
arch/arm/kernel/ptrace.c:878:17: error: no previous prototype for 'syscall_trace_exit'
arch/arm/kernel/signal.c:601:1: error: no previous prototype for 'do_work_pending'
arch/arm/kernel/signal.c:672:17: error: no previous prototype for 'do_rseq_syscall'
arch/arm/kernel/suspend.c:75:6: error: no previous prototype for '__cpu_suspend_save'
arch/arm/kernel/traps.c:451:17: error: no previous prototype for 'do_undefinstr'
arch/arm/kernel/traps.c:516:39: error: no previous prototype for 'handle_fiq_as_nmi'
arch/arm/kernel/traps.c:535:17: error: no previous prototype for 'bad_mode'
arch/arm/kernel/traps.c:608:16: error: no previous prototype for 'arm_syscall'
arch/arm/kernel/traps.c:734:1: error: no previous prototype for 'baddataabort'
arch/arm/kernel/traps.c:774:17: error: no previous prototype for '__div0'
arch/arm/kernel/traps.c:97:6: error: no previous prototype for 'dump_backtrace_stm'
arch/arm/kernel/unwind.c:40:6: error: no previous prototype for '__aeabi_unwind_cpp_pr0'
arch/arm/kernel/unwind.c:45:6: error: no previous prototype for '__aeabi_unwind_cpp_pr1'
arch/arm/kernel/unwind.c:50:6: error: no previous prototype for '__aeabi_unwind_cpp_pr2'
arch/arm/mm/fault.c:554:1: error: no previous prototype for 'do_DataAbort'
arch/arm/mm/fault.c:584:1: error: no previous prototype for 'do_PrefetchAbort'
arch/arm/mm/proc-v7-bugs.c:280:6: error: no previous prototype for 'cpu_v7_ca8_ibe'
arch/arm/mm/proc-v7-bugs.c:293:6: error: no previous prototype for 'cpu_v7_bugs_init'
arch/arm/vdso/vgettimeofday.c:36:6: error: no previous prototype for '__aeabi_unwind_cpp_pr0'
arch/arm/vdso/vgettimeofday.c:40:6: error: no previous prototype for '__aeabi_unwind_cpp_pr1'
arch/arm/vdso/vgettimeofday.c:44:6: error: no previous prototype for '__aeabi_unwind_cpp_pr2'
arch/arm/vfp/vfpmodule.c:323:6: error: no previous prototype for 'VFP_bounce'

Add the prototypes anyway, to allow enabling this warning by default in
the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/ftrace.h  | 4 ++++
 arch/arm/include/asm/ptrace.h  | 3 +++
 arch/arm/include/asm/signal.h  | 5 +++++
 arch/arm/include/asm/spectre.h | 4 ++++
 arch/arm/include/asm/suspend.h | 1 +
 arch/arm/include/asm/traps.h   | 9 +++++++++
 arch/arm/include/asm/unwind.h  | 4 ++++
 arch/arm/include/asm/vfp.h     | 1 +
 arch/arm/mm/fault.h            | 4 ++++
 9 files changed, 35 insertions(+)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 4e29bff7556d..3b2d84ec11f3 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -73,6 +73,10 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	return !strcasecmp(sym, name);
 }
 
+void prepare_ftrace_return(unsigned long *parent, unsigned long self,
+			   unsigned long frame_pointer,
+			   unsigned long stack_pointer);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* _ASM_ARM_FTRACE */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 483b8ddfcb82..7f44e88d1f25 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -193,5 +193,8 @@ static inline unsigned long it_advance(unsigned long cpsr)
 	return cpsr;
 }
 
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_exit(struct pt_regs *regs);
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/arm/include/asm/signal.h b/arch/arm/include/asm/signal.h
index 430be7774402..8b84092d1518 100644
--- a/arch/arm/include/asm/signal.h
+++ b/arch/arm/include/asm/signal.h
@@ -22,4 +22,9 @@ typedef struct {
 #define __ARCH_HAS_SA_RESTORER
 
 #include <asm/sigcontext.h>
+
+void do_rseq_syscall(struct pt_regs *regs);
+int do_work_pending(struct pt_regs *regs, unsigned int thread_flags,
+		    int syscall);
+
 #endif
diff --git a/arch/arm/include/asm/spectre.h b/arch/arm/include/asm/spectre.h
index 85f9e538fb32..d9c28b3b6b62 100644
--- a/arch/arm/include/asm/spectre.h
+++ b/arch/arm/include/asm/spectre.h
@@ -35,4 +35,8 @@ static inline void spectre_v2_update_state(unsigned int state,
 
 int spectre_bhb_update_vectors(unsigned int method);
 
+void cpu_v7_ca8_ibe(void);
+void cpu_v7_ca15_ibe(void);
+void cpu_v7_bugs_init(void);
+
 #endif
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 506314265c6f..be81b9ca2ea1 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -13,5 +13,6 @@ extern void cpu_resume(void);
 extern void cpu_resume_no_hyp(void);
 extern void cpu_resume_arm(void);
 extern int cpu_suspend(unsigned long, int (*)(unsigned long));
+extern void __cpu_suspend_save(u32 *ptr, u32 ptrsz, u32 sp, u32 *save_ptr);
 
 #endif
diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 987fefb0a4db..0aaefe3e1700 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -35,4 +35,13 @@ extern void ptrace_break(struct pt_regs *regs);
 
 extern void *vectors_page;
 
+asmlinkage void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl);
+asmlinkage void do_undefinstr(struct pt_regs *regs);
+asmlinkage void handle_fiq_as_nmi(struct pt_regs *regs);
+asmlinkage void bad_mode(struct pt_regs *regs, int reason);
+asmlinkage int arm_syscall(int no, struct pt_regs *regs);
+asmlinkage void baddataabort(int code, unsigned long instr, struct pt_regs *regs);
+asmlinkage void __div0(void);
+asmlinkage void handle_bad_stack(struct pt_regs *regs);
+
 #endif
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index b51f85417f58..d60b09a5acfc 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -40,6 +40,10 @@ extern void unwind_table_del(struct unwind_table *tab);
 extern void unwind_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			     const char *loglvl);
 
+void __aeabi_unwind_cpp_pr0(void);
+void __aeabi_unwind_cpp_pr1(void);
+void __aeabi_unwind_cpp_pr2(void);
+
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_ARM_UNWIND
diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index 157ea3426158..5b57b8768bac 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -102,6 +102,7 @@
 
 #ifndef __ASSEMBLY__
 void vfp_disable(void);
+void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs);
 #endif
 
 #endif /* __ASM_VFP_H */
diff --git a/arch/arm/mm/fault.h b/arch/arm/mm/fault.h
index 54927ba1fa6e..e8f8c1902544 100644
--- a/arch/arm/mm/fault.h
+++ b/arch/arm/mm/fault.h
@@ -37,5 +37,9 @@ static inline int fsr_fs(unsigned int fsr)
 
 void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs);
 void early_abt_enable(void);
+asmlinkage void do_DataAbort(unsigned long addr, unsigned int fsr,
+			     struct pt_regs *regs);
+asmlinkage void do_PrefetchAbort(unsigned long addr, unsigned int ifsr,
+				 struct pt_regs *regs);
 
 #endif	/* __ARCH_ARM_FAULT_H */
-- 
2.39.2

