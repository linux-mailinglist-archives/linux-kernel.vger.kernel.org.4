Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3BC7068A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjEQMw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjEQMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0CD30C8;
        Wed, 17 May 2023 05:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E2B363BFE;
        Wed, 17 May 2023 12:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A92FC433EF;
        Wed, 17 May 2023 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684327942;
        bh=RAAsqAvrUGXB7Btig0Rw08VQE5QvKzav1GuZ+vZtxkk=;
        h=From:To:Cc:Subject:Date:From;
        b=NoQn19pWkAHJUuFPfHo/hY3VTLpzmMN2D/fvc64xXkxa7c9AR126+xFmg8uihOGmf
         6SEpugPnxDiKCRpgOwkZpMF77B6dekDDXPqbPG17PVXAhlhR7HsZ4g3URFTk/44vki
         t5sw3LN6e5mm43hNfoopvG+NflX9R1jP+qpI/iMFbSU5lsoEnkt04Is9r6NSLiw7jk
         34R6pPcHrnehNS36sZ0HOWlbHF7duEY/FAtpua3bCp0rY/cKWIGOov8UXI5YvFFQOL
         WK++W/ls7z3j1/I6nfa9JnNwpG1om+x0Wr5bkg2fPzz96Af8Uxd5k3g2aE+1AdEYoc
         M4u8yhzxB175Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tracing: avoid missing-prototype warnings
Date:   Wed, 17 May 2023 14:51:48 +0200
Message-Id: <20230517125215.930689-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

These are all tracing W=1 warnings in arm64 allmodconfig about missing
prototypes:

kernel/trace/trace_kprobe_selftest.c:7:5: error: no previous prototype for 'kprobe_trace_selftest_target' [-Werror=missing-pro
totypes]
kernel/trace/ftrace.c:329:5: error: no previous prototype for '__register_ftrace_function' [-Werror=missing-prototypes]
kernel/trace/ftrace.c:372:5: error: no previous prototype for '__unregister_ftrace_function' [-Werror=missing-prototypes]
kernel/trace/ftrace.c:4130:15: error: no previous prototype for 'arch_ftrace_match_adjust' [-Werror=missing-prototypes]
kernel/trace/fgraph.c:243:15: error: no previous prototype for 'ftrace_return_to_handler' [-Werror=missing-prototypes]
kernel/trace/fgraph.c:358:6: error: no previous prototype for 'ftrace_graph_sleep_time_control' [-Werror=missing-prototypes]
arch/arm64/kernel/ftrace.c:460:6: error: no previous prototype for 'prepare_ftrace_return' [-Werror=missing-prototypes]
arch/arm64/kernel/ptrace.c:2172:5: error: no previous prototype for 'syscall_trace_enter' [-Werror=missing-prototypes]
arch/arm64/kernel/ptrace.c:2195:6: error: no previous prototype for 'syscall_trace_exit' [-Werror=missing-prototypes]

Move the declarations to an appropriate header where they can be seen
by the caller and callee, and make sure the headers are included where
needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/ftrace.h      | 4 ++++
 arch/arm64/include/asm/syscall.h     | 3 +++
 arch/arm64/kernel/syscall.c          | 3 ---
 include/linux/ftrace.h               | 3 +++
 kernel/trace/fgraph.c                | 1 +
 kernel/trace/ftrace_internal.h       | 5 +++--
 kernel/trace/trace_kprobe_selftest.c | 3 +++
 7 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index b87d70b693c6..f5e74a37a8f7 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -190,6 +190,10 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 	 */
 	return !strcmp(sym + 8, name);
 }
+
+void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
+			   unsigned long frame_pointer);
+
 #endif /* ifndef __ASSEMBLY__ */
 
 #endif /* __ASM_FTRACE_H */
diff --git a/arch/arm64/include/asm/syscall.h b/arch/arm64/include/asm/syscall.h
index 4cfe9b49709b..ab8e14b96f68 100644
--- a/arch/arm64/include/asm/syscall.h
+++ b/arch/arm64/include/asm/syscall.h
@@ -85,4 +85,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 	return AUDIT_ARCH_AARCH64;
 }
 
+int syscall_trace_enter(struct pt_regs *regs);
+void syscall_trace_exit(struct pt_regs *regs);
+
 #endif	/* __ASM_SYSCALL_H */
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index da84cf855c44..32f49f8f1b91 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -75,9 +75,6 @@ static inline bool has_syscall_work(unsigned long flags)
 	return unlikely(flags & _TIF_SYSCALL_WORK);
 }
 
-int syscall_trace_enter(struct pt_regs *regs);
-void syscall_trace_exit(struct pt_regs *regs);
-
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b23bdd414394..3ba539a04e54 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -41,6 +41,9 @@ struct ftrace_ops;
 struct ftrace_regs;
 struct dyn_ftrace;
 
+char *arch_ftrace_match_adjust(char *str, const char *search);
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer);
+
 #ifdef CONFIG_FUNCTION_TRACER
 /*
  * If the arch's mcount caller does not support all of ftrace's
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 218cd95bf8e4..b00de32249ac 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -15,6 +15,7 @@
 #include <trace/events/sched.h>
 
 #include "ftrace_internal.h"
+#include "trace.h"
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define ASSIGN_OPS_HASH(opsname, val) \
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 382775edf690..5012c04f92c0 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_KERNEL_FTRACE_INTERNAL_H
 #define  _LINUX_KERNEL_FTRACE_INTERNAL_H
 
+int __register_ftrace_function(struct ftrace_ops *ops);
+int __unregister_ftrace_function(struct ftrace_ops *ops);
+
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern struct mutex ftrace_lock;
@@ -15,8 +18,6 @@ int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
 
-int __register_ftrace_function(struct ftrace_ops *ops);
-int __unregister_ftrace_function(struct ftrace_ops *ops);
 /* Keep as macros so we do not need to define the commands */
 # define ftrace_startup(ops, command)					\
 	({								\
diff --git a/kernel/trace/trace_kprobe_selftest.c b/kernel/trace/trace_kprobe_selftest.c
index 16548ee4c8c6..3851cd1e6a62 100644
--- a/kernel/trace/trace_kprobe_selftest.c
+++ b/kernel/trace/trace_kprobe_selftest.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include "trace_kprobe_selftest.h"
+
 /*
  * Function used during the kprobe self test. This function is in a separate
  * compile unit so it can be compile with CC_FLAGS_FTRACE to ensure that it
-- 
2.39.2

