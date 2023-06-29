Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682E8743130
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjF2Xm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjF2Xmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:42:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490E62D50
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso996437276.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688082171; x=1690674171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MN5onT38odilPSNEoZC1Mi9+3N8xJapfm8z7ugW2tI=;
        b=LtG+9f8lNr90fFI+0QMhjtDA8ze7b45VrCWFW4nvV+BMtZh+noaxCy8vJqhikyQx2W
         /g5bMoJfwQyzCxXHsfZMaqFOno/7vLhcsmQM8RRs6J1k10YbHdloEaoKRzHArlWZh2oe
         EMyA7aTeM8Qnncho/1othEg+1iuSj4eImUZAkMny/ecWcCcMigVSPquriE64cQkal2eG
         uf3oGzOxkGj24hiTpbJ8BT1j+GuEQWHjRQBG0IeNpg4NIWh71wJXzpCx3MJERhXPF0O8
         35xcQAIAoT+Jorw4NbajO9g3CTzd1Qb87rZJfOVpmSV4VGjdMs/S+9kpDeCP/EvvqXfw
         8Q5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082171; x=1690674171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5MN5onT38odilPSNEoZC1Mi9+3N8xJapfm8z7ugW2tI=;
        b=gjAAQNdoBC+VBQNVMKhWiQ9Zu/f+4jKh0T+mjB5XnklMYXyRNzziAiqK+brxcvMzOW
         sLZI89M0N30L3yOvO+Ioq96D1dOB0lJf0WE0c+TFVvtgJM6W62wVjAgdomrJfjCfkOYq
         3b7zevN8lWQC6q4bJXHfafRnnHmZTUlQjf6p7tAQaizpC6whKl8sRHbLwixHBQ0VJEmG
         65x61bneBJfIoCGL2DMANw1sHxeYdrJZ8xGTKEl2KViz+xE4Px5G1TVphs9LHnuuWcc2
         IGuOJJGV7rdH7/cr9Q6PFJxNhsZml4YNdDLWjWNJI2NH4rBCjeR9sNCMb0HFA6pNzieh
         56fA==
X-Gm-Message-State: ABy/qLaRtAMU2P5Xwhn+vevZQxJM0T/WjO5IOwv3jzaLm7cL5N6B45gA
        ps0+vbk53MlYAvDtyfkfXKr08mZoUxhiOT/I0bQ=
X-Google-Smtp-Source: APBJJlGHGbByNsgOY724SZV19hkyK0T75VDbu520ooERhQ+lRG6ucOFyPWjbmLH7w+DGNK30QWPPvcGekMSjSa/C5O8=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a25:f621:0:b0:bc7:f6af:8cff with SMTP
 id t33-20020a25f621000000b00bc7f6af8cffmr7508ybd.2.1688082171394; Thu, 29 Jun
 2023 16:42:51 -0700 (PDT)
Date:   Thu, 29 Jun 2023 23:42:46 +0000
In-Reply-To: <20230629234244.1752366-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230629234244.1752366-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=8711; i=samitolvanen@google.com;
 h=from:subject; bh=cH71RIetyr2QuAmRr+J7d1k89bDxV7/5s6ugVqwLMbQ=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBknhb1QV8f/gaDfpgpTdMqS+FPj4u7EksN/UAMk
 HNeYAk6CA+JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZJ4W9QAKCRBMtfaEi7xW
 7jLMDACCmPDnsW10/UuozU16UpwfnLDHLqBpkQ1jdeCXRT12jmKHWETnIC4WJcHOdF18tQO1AGa
 v1aeMP0Rr/WdyMDCNLTCcAuSX/Fl7gBgh2YHcPC4+gVO1j93qIopMPNalvL9MXVOuFJ5pjGlm32
 j1xUE4gXh7w1wSpt+mQ3u74NLOLxdsIf1z1u01ydePmTR7KT6j5XWXBK8DxfbLq+RR1GgL1Rc7H
 Xdwhy0oj4WHnHNXvxlM0ECKp9uOYSVGdODHaIc5iB+2jnDHEPG+8bs8VO/u4RcjVnwcmtZSKbH9
 7n+4xxrmyXjQPpE8SoiWZv85EubD+UvngtjZD/Waf8RrD1oc36lhI6yRl46DBFETa6OaHVu5WJw
 EHDXKZ2yBHyztJ/bAo952jMSHqTycccYNtU3yqdW9H9hKhFQX6tVwzoOxr+36T9oXLaQh0CBvX4 T6o09yy2NGeWpjZgLuUeZAlHJJYCtMrHFHsZFa+egS2GWjvvrGDOeGjYWGmmKWhR4K45U=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629234244.1752366-9-samitolvanen@google.com>
Subject: [PATCH 1/6] riscv: Implement syscall wrappers
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f0bddf50586d ("riscv: entry: Convert to generic entry") moved
syscall handling to C code, which exposed function pointer type
mismatches that trip fine-grained forward-edge Control-Flow Integrity
(CFI) checks as syscall handlers are all called through the same
syscall_t pointer type. To fix the type mismatches, implement pt_regs
based syscall wrappers similarly to x86 and arm64.

This patch is based on arm64 syscall wrappers added in commit
4378a7d4be30 ("arm64: implement syscall wrappers"), where the main goal
was to minimize the risk of userspace-controlled values being used
under speculation. This may be a concern for riscv in future as well.

Following other architectures, the syscall wrappers generate three
functions for each syscall; __riscv_<compat_>sys_<name> takes a pt_regs
pointer and extracts arguments from registers, __se_<compat_>sys_<name>
is a sign-extension wrapper that casts the long arguments to the
correct types for the real syscall implementation, which is named
__do_<compat_>sys_<name>.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/Kconfig                       |  1 +
 arch/riscv/include/asm/syscall.h         |  5 +-
 arch/riscv/include/asm/syscall_wrapper.h | 87 ++++++++++++++++++++++++
 arch/riscv/kernel/compat_syscall_table.c |  8 ++-
 arch/riscv/kernel/sys_riscv.c            |  6 ++
 arch/riscv/kernel/syscall_table.c        |  8 ++-
 6 files changed, 108 insertions(+), 7 deletions(-)
 create mode 100644 arch/riscv/include/asm/syscall_wrapper.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a08917f681af..b54a830eb5c6 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -33,6 +33,7 @@ config RISCV
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
+	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 0148c6bd9675..121fff429dce 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -75,7 +75,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 #endif
 }
 
-typedef long (*syscall_t)(ulong, ulong, ulong, ulong, ulong, ulong, ulong);
+typedef long (*syscall_t)(const struct pt_regs *);
 static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 {
 	syscall_t fn;
@@ -87,8 +87,7 @@ static inline void syscall_handler(struct pt_regs *regs, ulong syscall)
 #endif
 		fn = sys_call_table[syscall];
 
-	regs->a0 = fn(regs->orig_a0, regs->a1, regs->a2,
-		      regs->a3, regs->a4, regs->a5, regs->a6);
+	regs->a0 = fn(regs);
 }
 
 static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..1d7942c8a6cb
--- /dev/null
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - riscv specific wrappers to syscall definitions
+ *
+ * Based on arch/arm64/include/syscall_wrapper.h
+ */
+
+#ifndef __ASM_SYSCALL_WRAPPER_H
+#define __ASM_SYSCALL_WRAPPER_H
+
+#include <asm/ptrace.h>
+
+asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
+
+#define SC_RISCV_REGS_TO_ARGS(x, ...)				\
+	__MAP(x,__SC_ARGS					\
+	      ,,regs->orig_a0,,regs->a1,,regs->a2		\
+	      ,,regs->a3,,regs->a4,,regs->a5,,regs->a6)
+
+#ifdef CONFIG_COMPAT
+
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)						\
+	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(__riscv_compat_sys##name, ERRNO);				\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __riscv_compat_sys##name(const struct pt_regs *regs)		\
+	{										\
+		return __se_compat_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}										\
+	static long __se_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{										\
+		return __do_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
+	}										\
+	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#define COMPAT_SYSCALL_DEFINE0(sname)							\
+	asmlinkage long __riscv_compat_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__riscv_compat_sys_##sname, ERRNO);			\
+	asmlinkage long __riscv_compat_sys_##sname(const struct pt_regs *__unused)
+
+#define COND_SYSCALL_COMPAT(name) 							\
+	asmlinkage long __weak __riscv_compat_sys_##name(const struct pt_regs *regs);	\
+	asmlinkage long __weak __riscv_compat_sys_##name(const struct pt_regs *regs)	\
+	{										\
+		return sys_ni_syscall();						\
+	}
+
+#define COMPAT_SYS_NI(name) \
+	SYSCALL_ALIAS(__riscv_compat_sys_##name, sys_ni_posix_timers);
+
+#endif /* CONFIG_COMPAT */
+
+#define __SYSCALL_DEFINEx(x, name, ...)						\
+	asmlinkage long __riscv_sys##name(const struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(__riscv_sys##name, ERRNO);			\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long __riscv_sys##name(const struct pt_regs *regs)		\
+	{									\
+		return __se_sys##name(SC_RISCV_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}									\
+	static long __se_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{									\
+		long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		__MAP(x,__SC_TEST,__VA_ARGS__);					\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));		\
+		return ret;							\
+	}									\
+	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#define SYSCALL_DEFINE0(sname)							\
+	SYSCALL_METADATA(_##sname, 0);						\
+	asmlinkage long __riscv_sys_##sname(const struct pt_regs *__unused);	\
+	ALLOW_ERROR_INJECTION(__riscv_sys_##sname, ERRNO);			\
+	asmlinkage long __riscv_sys_##sname(const struct pt_regs *__unused)
+
+#define COND_SYSCALL(name)							\
+	asmlinkage long __weak __riscv_sys_##name(const struct pt_regs *regs);	\
+	asmlinkage long __weak __riscv_sys_##name(const struct pt_regs *regs)	\
+	{									\
+		return sys_ni_syscall();					\
+	}
+
+#define SYS_NI(name) SYSCALL_ALIAS(__riscv_sys_##name, sys_ni_posix_timers);
+
+#endif /* __ASM_SYSCALL_WRAPPER_H */
diff --git a/arch/riscv/kernel/compat_syscall_table.c b/arch/riscv/kernel/compat_syscall_table.c
index 651f2b009c28..ad7f2d712f5f 100644
--- a/arch/riscv/kernel/compat_syscall_table.c
+++ b/arch/riscv/kernel/compat_syscall_table.c
@@ -9,11 +9,15 @@
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, call)      [nr] = (call),
+#define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct pt_regs *);
+#include <asm/unistd.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)      [nr] = __riscv_##call,
 
 asmlinkage long compat_sys_rt_sigreturn(void);
 
 void * const compat_sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
 #include <asm/unistd.h>
 };
diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
index 5db29683ebee..5cc3b9457dfd 100644
--- a/arch/riscv/kernel/sys_riscv.c
+++ b/arch/riscv/kernel/sys_riscv.c
@@ -297,3 +297,9 @@ SYSCALL_DEFINE5(riscv_hwprobe, struct riscv_hwprobe __user *, pairs,
 	return do_riscv_hwprobe(pairs, pair_count, cpu_count,
 				cpus, flags);
 }
+
+/* Not defined using SYSCALL_DEFINE0 to avoid error injection */
+asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *__unused)
+{
+	return -ENOSYS;
+}
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
index 44b1420a2270..dda913764903 100644
--- a/arch/riscv/kernel/syscall_table.c
+++ b/arch/riscv/kernel/syscall_table.c
@@ -10,9 +10,13 @@
 #include <asm/syscall.h>
 
 #undef __SYSCALL
-#define __SYSCALL(nr, call)	[nr] = (call),
+#define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct pt_regs *);
+#include <asm/unistd.h>
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)	[nr] = __riscv_##call,
 
 void * const sys_call_table[__NR_syscalls] = {
-	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
 #include <asm/unistd.h>
 };
-- 
2.41.0.255.g8b1d071c50-goog

