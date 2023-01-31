Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EA4682F23
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAaOXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjAaOWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:22:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06802222D1;
        Tue, 31 Jan 2023 06:22:31 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:22:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Um5LKI/9hScNlYvhBVuAMl7qOTHMQENc5JKgiBOlKk=;
        b=fF/OfaSloyV3VbAU3W/Pcrt1QcvvFFea2BgWT4FK5A+UleMEXNcAkd7BWdU7hBB3IbqqON
        zMlyi48csIlUJvOzFY6JDap27BrBjee6/CmRw6RvYbM7/l09nNMmwrzXPKeowHsS2e1ENg
        oyNL/OHq8F9V18/Jx+rVxKmxKcJUBh7vCedqQfkowf8H/EJwPwJvjNUXizPRNit/88kKIM
        MGyXlL9i8UltdYiQv3vUnTIiT5vNlGrbdW0b/Vaj5QOkiDpEptgP1Xf8ZRg8t5pp21pU/o
        GHOFoLm2s+8feYzJT9XcI1sUYKhSK56QhhkyFFRuZy+8UoiyMH9E3ovHEF8Eog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1675174948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Um5LKI/9hScNlYvhBVuAMl7qOTHMQENc5JKgiBOlKk=;
        b=/9nnECGq4EUylg9Z3bJRH4RBnUUJBWnfygUW3LUVonxRr+QZZ4gfGEJKMG8iAd5ErPg9wQ
        aDInwWqIqsLK+ACQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230126151323.408156109@infradead.org>
References: <20230126151323.408156109@infradead.org>
MIME-Version: 1.0
Message-ID: <167517494843.4906.16680899245524839121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a5d7e9badd2cb8065db171961bd30bd3595e4b6
Gitweb:        https://git.kernel.org/tip/5a5d7e9badd2cb8065db171961bd30bd3595e4b6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 26 Jan 2023 16:08:31 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 31 Jan 2023 15:01:45 +01:00

cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG

In order to avoid WARN/BUG from generating nested or even recursive
warnings, force rcu_is_watching() true during
WARN/lockdep_rcu_suspicious().

Notably things like unwinding the stack can trigger rcu_dereference()
warnings, which then triggers more unwinding which then triggers more
warnings etc..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230126151323.408156109@infradead.org
---
 include/linux/context_tracking.h | 27 +++++++++++++++++++++++++++
 kernel/locking/lockdep.c         |  3 +++
 kernel/panic.c                   |  5 +++++
 lib/bug.c                        | 15 ++++++++++++++-
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index dcef4a9..d4afa85 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -130,9 +130,36 @@ static __always_inline unsigned long ct_state_inc(int incby)
 	return arch_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
+static __always_inline bool warn_rcu_enter(void)
+{
+	bool ret = false;
+
+	/*
+	 * Horrible hack to shut up recursive RCU isn't watching fail since
+	 * lots of the actual reporting also relies on RCU.
+	 */
+	preempt_disable_notrace();
+	if (rcu_dynticks_curr_cpu_in_eqs()) {
+		ret = true;
+		ct_state_inc(RCU_DYNTICKS_IDX);
+	}
+
+	return ret;
+}
+
+static __always_inline void warn_rcu_exit(bool rcu)
+{
+	if (rcu)
+		ct_state_inc(RCU_DYNTICKS_IDX);
+	preempt_enable_notrace();
+}
+
 #else
 static inline void ct_idle_enter(void) { }
 static inline void ct_idle_exit(void) { }
+
+static __always_inline bool warn_rcu_enter(void) { return false; }
+static __always_inline void warn_rcu_exit(bool rcu) { }
 #endif /* !CONFIG_CONTEXT_TRACKING_IDLE */
 
 #endif
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e3375bc..50d4863 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -55,6 +55,7 @@
 #include <linux/rcupdate.h>
 #include <linux/kprobes.h>
 #include <linux/lockdep.h>
+#include <linux/context_tracking.h>
 
 #include <asm/sections.h>
 
@@ -6555,6 +6556,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 {
 	struct task_struct *curr = current;
 	int dl = READ_ONCE(debug_locks);
+	bool rcu = warn_rcu_enter();
 
 	/* Note: the following can be executed concurrently, so be careful. */
 	pr_warn("\n");
@@ -6595,5 +6597,6 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	lockdep_print_held_locks(curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
+	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
diff --git a/kernel/panic.c b/kernel/panic.c
index 463c929..487f5b0 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -34,6 +34,7 @@
 #include <linux/ratelimit.h>
 #include <linux/debugfs.h>
 #include <linux/sysfs.h>
+#include <linux/context_tracking.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -679,6 +680,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 		       const char *fmt, ...)
 {
+	bool rcu = warn_rcu_enter();
 	struct warn_args args;
 
 	pr_warn(CUT_HERE);
@@ -693,11 +695,13 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 	va_start(args.args, fmt);
 	__warn(file, line, __builtin_return_address(0), taint, NULL, &args);
 	va_end(args.args);
+	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL(warn_slowpath_fmt);
 #else
 void __warn_printk(const char *fmt, ...)
 {
+	bool rcu = warn_rcu_enter();
 	va_list args;
 
 	pr_warn(CUT_HERE);
@@ -705,6 +709,7 @@ void __warn_printk(const char *fmt, ...)
 	va_start(args, fmt);
 	vprintk(fmt, args);
 	va_end(args);
+	warn_rcu_exit(rcu);
 }
 EXPORT_SYMBOL(__warn_printk);
 #endif
diff --git a/lib/bug.c b/lib/bug.c
index c223a25..e0ff219 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -47,6 +47,7 @@
 #include <linux/sched.h>
 #include <linux/rculist.h>
 #include <linux/ftrace.h>
+#include <linux/context_tracking.h>
 
 extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
@@ -153,7 +154,7 @@ struct bug_entry *find_bug(unsigned long bugaddr)
 	return module_find_bug(bugaddr);
 }
 
-enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
+static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
 	struct bug_entry *bug;
 	const char *file;
@@ -209,6 +210,18 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	return BUG_TRAP_TYPE_BUG;
 }
 
+enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
+{
+	enum bug_trap_type ret;
+	bool rcu = false;
+
+	rcu = warn_rcu_enter();
+	ret = __report_bug(bugaddr, regs);
+	warn_rcu_exit(rcu);
+
+	return ret;
+}
+
 static void clear_once_table(struct bug_entry *start, struct bug_entry *end)
 {
 	struct bug_entry *bug;
