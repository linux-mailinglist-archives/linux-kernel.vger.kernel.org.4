Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4338C704F7E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjEPNkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjEPNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:40:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D1C90;
        Tue, 16 May 2023 06:40:03 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDbVUV010413;
        Tue, 16 May 2023 13:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xxJNztKTA3zJhhkcN32/bFUs1HImmaNEsFHe415i7oU=;
 b=LfMJkjnItHquO9QBhQCuB+HQMFJ2YV3xRU3iyf7si+hyu7LX5a9mqrTmtNiMNi3XMidR
 mRKGvjR7Qn7/BKIvTkMllGzOeKO//K4cw3wNno1wTFhUye/H/tKrJqGM5fAIrQZbt1I+
 IybTEklcxpq0MYumV00szsgVu9qcB0X6MmlLZ/ug67iVGJxS3/ZIHdHb7atf+zhJJBoe
 stI9liHbN7W6EjwDnpRTW/HGrWtUFrUpu6mJuiniECX08XX6QDAedkgNXvdIVcC1Jyo2
 BUGd32n6pn8bGvK8MQNP/qK14sjTOvSgExFkPkbOrMxyqhkzKwGkLKkThci+wZULZpoJ qQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8h655j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:39:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G4UV0P012372;
        Tue, 16 May 2023 13:38:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sp4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:38:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GDcJ5Y39453362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 13:38:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F6E220043;
        Tue, 16 May 2023 13:38:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0330E20040;
        Tue, 16 May 2023 13:38:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 16 May 2023 13:38:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id AD1ADE0803; Tue, 16 May 2023 15:38:18 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-s390@vger.kernel.org, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] entry: move the exit path to header files
Date:   Tue, 16 May 2023 15:38:09 +0200
Message-Id: <20230516133810.171487-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516133810.171487-1-svens@linux.ibm.com>
References: <20230516133810.171487-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KKQzG2VSrvRZYV0pS2-7zbMQJnaS2n_k
X-Proofpoint-ORIG-GUID: KKQzG2VSrvRZYV0pS2-7zbMQJnaS2n_k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=843
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160114
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow inlining the generic entry C functions,
move them to include/linux/entry-common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 182 ++++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 168 --------------------------------
 2 files changed, 179 insertions(+), 171 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..b409fbcbd3ac 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,8 +7,13 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-
+#include <linux/livepatch.h>
 #include <asm/entry-common.h>
+#include <linux/context_tracking.h>
+#include <linux/resume_user_mode.h>
+#include <linux/tick.h>
+
+#include <trace/events/syscalls.h>
 
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
@@ -291,7 +296,7 @@ void exit_to_user_mode(void);
  * make the final state transitions. Interrupts must stay disabled between
  * return from this function and the invocation of exit_to_user_mode().
  */
-void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+static void syscall_exit_to_user_mode_work(struct pt_regs *regs);
 
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
@@ -350,7 +355,7 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
  * Interrupt exit is not invoking #1 which is the syscall specific one time
  * work.
  */
-void irqentry_exit_to_user_mode(struct pt_regs *regs);
+static void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
 #ifndef irqentry_state
 /**
@@ -465,4 +470,175 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
  */
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
 
+static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+					    unsigned long ti_work)
+{
+	/*
+	 * Before returning to user space ensure that all pending work
+	 * items have been completed.
+	 */
+	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+
+		local_irq_enable_exit_to_user(ti_work);
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_UPROBE)
+			uprobe_notify_resume(regs);
+
+		if (ti_work & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			arch_do_signal_or_restart(regs);
+
+		if (ti_work & _TIF_NOTIFY_RESUME)
+			resume_user_mode_work(regs);
+
+		/* Architecture specific TIF work */
+		arch_exit_to_user_mode_work(regs, ti_work);
+
+		/*
+		 * Disable interrupts and reevaluate the work flags as they
+		 * might have changed while interrupts and preemption was
+		 * enabled above.
+		 */
+		local_irq_disable_exit_to_user();
+
+		/* Check if any of the above work has queued a deferred wakeup */
+		tick_nohz_user_enter_prepare();
+
+		ti_work = read_thread_flags();
+	}
+
+	/* Return the latest work state for arch_exit_to_user_mode() */
+	return ti_work;
+}
+
+
+static void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work = read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that the address limit is intact and no locks are held */
+	addr_limit_user_check();
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
+/*
+ * If SYSCALL_EMU is set, then the only reason to report is when
+ * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
+ * instruction has been already reported in syscall_enter_from_user_mode().
+ */
+static inline bool report_single_step(unsigned long work)
+{
+	if (work & SYSCALL_WORK_SYSCALL_EMU)
+		return false;
+
+	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
+}
+
+static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
+{
+	bool step;
+
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch = false;
+			return;
+		}
+	}
+
+	audit_syscall_exit(regs);
+
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
+		trace_sys_exit(regs, syscall_get_return_value(current, regs));
+
+	step = report_single_step(work);
+	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
+		ptrace_report_syscall_exit(regs, step);
+}
+
+/*
+ * Syscall specific exit to user mode preparation. Runs with interrupts
+ * enabled.
+ */
+static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+	unsigned long nr = syscall_get_nr(current, regs);
+
+	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
+
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
+			local_irq_enable();
+	}
+
+	rseq_syscall(regs);
+
+	/*
+	 * Do one-time syscall specific work. If these work items are
+	 * enabled, we want to run them exactly once per syscall exit with
+	 * interrupts enabled.
+	 */
+	if (unlikely(work & SYSCALL_WORK_EXIT))
+		syscall_exit_work(regs, work);
+}
+
+static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	syscall_exit_to_user_mode_prepare(regs);
+	local_irq_disable_exit_to_user();
+	exit_to_user_mode_prepare(regs);
+}
+
+static __always_inline void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	__syscall_exit_to_user_mode_work(regs);
+}
+
+/* See comment for exit_to_user_mode() in entry-common.h */
+static __always_inline void __exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
+
+
+static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	exit_to_user_mode_prepare(regs);
+	instrumentation_end();
+	__exit_to_user_mode();
+}
+
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index be61332c66b5..66af971c3fe4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -123,19 +123,6 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/* See comment for exit_to_user_mode() in entry-common.h */
-static __always_inline void __exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
 void noinstr exit_to_user_mode(void)
 {
 	__exit_to_user_mode();
@@ -144,153 +131,6 @@ void noinstr exit_to_user_mode(void)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
-{
-	/*
-	 * Before returning to user space ensure that all pending work
-	 * items have been completed.
-	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
-
-		local_irq_enable_exit_to_user(ti_work);
-
-		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
-
-		if (ti_work & _TIF_UPROBE)
-			uprobe_notify_resume(regs);
-
-		if (ti_work & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
-
-		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-			arch_do_signal_or_restart(regs);
-
-		if (ti_work & _TIF_NOTIFY_RESUME)
-			resume_user_mode_work(regs);
-
-		/* Architecture specific TIF work */
-		arch_exit_to_user_mode_work(regs, ti_work);
-
-		/*
-		 * Disable interrupts and reevaluate the work flags as they
-		 * might have changed while interrupts and preemption was
-		 * enabled above.
-		 */
-		local_irq_disable_exit_to_user();
-
-		/* Check if any of the above work has queued a deferred wakeup */
-		tick_nohz_user_enter_prepare();
-
-		ti_work = read_thread_flags();
-	}
-
-	/* Return the latest work state for arch_exit_to_user_mode() */
-	return ti_work;
-}
-
-static void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work = read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that the address limit is intact and no locks are held */
-	addr_limit_user_check();
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
-/*
- * If SYSCALL_EMU is set, then the only reason to report is when
- * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
- * instruction has been already reported in syscall_enter_from_user_mode().
- */
-static inline bool report_single_step(unsigned long work)
-{
-	if (work & SYSCALL_WORK_SYSCALL_EMU)
-		return false;
-
-	return work & SYSCALL_WORK_SYSCALL_EXIT_TRAP;
-}
-
-static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
-{
-	bool step;
-
-	/*
-	 * If the syscall was rolled back due to syscall user dispatching,
-	 * then the tracers below are not invoked for the same reason as
-	 * the entry side was not invoked in syscall_trace_enter(): The ABI
-	 * of these syscalls is unknown.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (unlikely(current->syscall_dispatch.on_dispatch)) {
-			current->syscall_dispatch.on_dispatch = false;
-			return;
-		}
-	}
-
-	audit_syscall_exit(regs);
-
-	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-		trace_sys_exit(regs, syscall_get_return_value(current, regs));
-
-	step = report_single_step(work);
-	if (step || work & SYSCALL_WORK_SYSCALL_TRACE)
-		ptrace_report_syscall_exit(regs, step);
-}
-
-/*
- * Syscall specific exit to user mode preparation. Runs with interrupts
- * enabled.
- */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-	unsigned long nr = syscall_get_nr(current, regs);
-
-	CT_WARN_ON(ct_state() != CONTEXT_KERNEL);
-
-	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
-		if (WARN(irqs_disabled(), "syscall %lu left IRQs disabled", nr))
-			local_irq_enable();
-	}
-
-	rseq_syscall(regs);
-
-	/*
-	 * Do one-time syscall specific work. If these work items are
-	 * enabled, we want to run them exactly once per syscall exit with
-	 * interrupts enabled.
-	 */
-	if (unlikely(work & SYSCALL_WORK_EXIT))
-		syscall_exit_work(regs, work);
-}
-
-static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	syscall_exit_to_user_mode_prepare(regs);
-	local_irq_disable_exit_to_user();
-	exit_to_user_mode_prepare(regs);
-}
-
-void syscall_exit_to_user_mode_work(struct pt_regs *regs)
-{
-	__syscall_exit_to_user_mode_work(regs);
-}
-
 __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 {
 	instrumentation_begin();
@@ -304,14 +144,6 @@ noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
 	__enter_from_user_mode(regs);
 }
 
-noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
-{
-	instrumentation_begin();
-	exit_to_user_mode_prepare(regs);
-	instrumentation_end();
-	__exit_to_user_mode();
-}
-
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret = {
-- 
2.39.2

