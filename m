Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54C704F80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjEPNkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbjEPNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:40:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89142CA;
        Tue, 16 May 2023 06:40:06 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GDbZaI011013;
        Tue, 16 May 2023 13:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KQEQEFbumEsDNKL38NwfbWvV/XWByejTyz8oeYut8Q0=;
 b=TW3NlfUOx7A0joi2/uojCjxrSuMiZab0UZmy7SrEmrUl2YMBP85Z40eji0hMDv2loGzV
 2SAeJbBMvbRIZQiM3WNRcVJOGTFsw2FcddkIEIg6YA1irtNFqowlH7ooz8B7EzgFBCXT
 nBK9VoW7YAOfGfyBRYQkQeQLG5zHHODXz4i00UeXBoLVQSpZdH86sxclXRJgLOOVl3Dt
 kaPkvIZDWi7KOgRICG0vXdjGkWbeDQj3wnB6t3cv+PkCOoRR8NDTIxlfy7bAaB/spr9p
 2fgD1eVD26poqtMzc9wDE646nM1TObqSBLFMg24spqLgCjwsmoFm4RgdSoP/FBlt6Gbm 2g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qm8h655m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:39:08 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34G5LLil028625;
        Tue, 16 May 2023 13:38:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qj264sp4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 13:38:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34GDcJfC17957414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 May 2023 13:38:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C43A2004B;
        Tue, 16 May 2023 13:38:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F105920040;
        Tue, 16 May 2023 13:38:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 16 May 2023 13:38:18 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B0648E081B; Tue, 16 May 2023 15:38:18 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-s390@vger.kernel.org, hca@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] entry: move the enter path to header files
Date:   Tue, 16 May 2023 15:38:10 +0200
Message-Id: <20230516133810.171487-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516133810.171487-1-svens@linux.ibm.com>
References: <20230516133810.171487-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5SxnUMWZzuC7Od8wZRdo27VWoJAXjWva
X-Proofpoint-ORIG-GUID: 5SxnUMWZzuC7Od8wZRdo27VWoJAXjWva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_06,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=605
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0
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
 include/linux/entry-common.h | 123 +++++++++++++++++++++++++++++++++--
 kernel/entry/common.c        | 113 --------------------------------
 2 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b409fbcbd3ac..cada155bf316 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -15,6 +15,8 @@
 
 #include <trace/events/syscalls.h>
 
+bool syscall_user_dispatch(struct pt_regs *regs);
+
 /*
  * Define dummy _TIF work flags if not defined by the architecture or for
  * disabled functionality.
@@ -103,7 +105,7 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs) {}
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-void enter_from_user_mode(struct pt_regs *regs);
+static void enter_from_user_mode(struct pt_regs *regs);
 
 /**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
@@ -120,7 +122,7 @@ void enter_from_user_mode(struct pt_regs *regs);
  * This is invoked when there is extra architecture specific functionality
  * to be done between establishing state and handling user mode entry work.
  */
-void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
+static void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
@@ -145,7 +147,7 @@ void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
  *     ptrace_report_syscall_entry(), __secure_computing(), trace_sys_enter()
  *  2) Invocation of audit_syscall_entry()
  */
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
+static long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
 
 /**
  * syscall_enter_from_user_mode - Establish state and check and handle work
@@ -164,7 +166,7 @@ long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall);
  * Returns: The original or a modified syscall number. See
  * syscall_enter_from_user_mode_work() for further explanation.
  */
-long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
+static long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall);
 
 /**
  * local_irq_enable_exit_to_user - Exit to user variant of local_irq_enable()
@@ -281,7 +283,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * non-instrumentable.
  * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
-void exit_to_user_mode(void);
+static void exit_to_user_mode(void);
 
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
@@ -640,5 +642,116 @@ static __always_inline void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	__exit_to_user_mode();
 }
 
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
+{
+	arch_enter_from_user_mode(regs);
+	lockdep_hardirqs_off(CALLER_ADDR0);
+
+	CT_WARN_ON(__ct_state() != CONTEXT_USER);
+	user_exit_irqoff();
+
+	instrumentation_begin();
+	kmsan_unpoison_entry_regs(regs);
+	trace_hardirqs_off_finish();
+	instrumentation_end();
+}
+
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs);
+}
+
+static __always_inline void exit_to_user_mode(void)
+{
+	__exit_to_user_mode();
+}
+
+static inline __always_inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
+{
+	if (unlikely(audit_context())) {
+		unsigned long args[6];
+
+		syscall_get_arguments(current, regs, args);
+		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
+	}
+}
+
+static __always_inline long syscall_trace_enter(struct pt_regs *regs, long syscall,
+				unsigned long work)
+{
+	long ret = 0;
+
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
+	/* Handle ptrace */
+	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
+		ret = ptrace_report_syscall_entry(regs);
+		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
+			return -1L;
+	}
+
+	/* Do seccomp after ptrace, to catch any tracer changes. */
+	if (work & SYSCALL_WORK_SECCOMP) {
+		ret = __secure_computing(NULL);
+		if (ret == -1L)
+			return ret;
+	}
+
+	/* Either of the above might have changed the syscall number */
+	syscall = syscall_get_nr(current, regs);
+
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
+		trace_sys_enter(regs, syscall);
+
+	syscall_enter_audit(regs, syscall);
+
+	return ret ? : syscall;
+}
+
+static __always_inline long
+__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
+{
+	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
+
+	if (work & SYSCALL_WORK_ENTER)
+		syscall = syscall_trace_enter(regs, syscall, work);
+
+	return syscall;
+}
+
+static __always_inline long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
+{
+	return __syscall_enter_from_user_work(regs, syscall);
+}
+
+static __always_inline  long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
+{
+	long ret;
+
+	__enter_from_user_mode(regs);
+
+	instrumentation_begin();
+	local_irq_enable();
+	ret = __syscall_enter_from_user_work(regs, syscall);
+	instrumentation_end();
+
+	return ret;
+}
+
+static __always_inline void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs);
+	instrumentation_begin();
+	local_irq_enable();
+	instrumentation_end();
+}
 
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 66af971c3fe4..3bd528bb5d47 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -15,119 +15,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/* See comment for enter_from_user_mode() in entry-common.h */
-static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
-{
-	arch_enter_from_user_mode(regs);
-	lockdep_hardirqs_off(CALLER_ADDR0);
-
-	CT_WARN_ON(__ct_state() != CONTEXT_USER);
-	user_exit_irqoff();
-
-	instrumentation_begin();
-	kmsan_unpoison_entry_regs(regs);
-	trace_hardirqs_off_finish();
-	instrumentation_end();
-}
-
-void noinstr enter_from_user_mode(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-}
-
-static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
-{
-	if (unlikely(audit_context())) {
-		unsigned long args[6];
-
-		syscall_get_arguments(current, regs, args);
-		audit_syscall_entry(syscall, args[0], args[1], args[2], args[3]);
-	}
-}
-
-static long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
-{
-	long ret = 0;
-
-	/*
-	 * Handle Syscall User Dispatch.  This must comes first, since
-	 * the ABI here can be something that doesn't make sense for
-	 * other syscall_work features.
-	 */
-	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
-		if (syscall_user_dispatch(regs))
-			return -1L;
-	}
-
-	/* Handle ptrace */
-	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
-		ret = ptrace_report_syscall_entry(regs);
-		if (ret || (work & SYSCALL_WORK_SYSCALL_EMU))
-			return -1L;
-	}
-
-	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (work & SYSCALL_WORK_SECCOMP) {
-		ret = __secure_computing(NULL);
-		if (ret == -1L)
-			return ret;
-	}
-
-	/* Either of the above might have changed the syscall number */
-	syscall = syscall_get_nr(current, regs);
-
-	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
-		trace_sys_enter(regs, syscall);
-
-	syscall_enter_audit(regs, syscall);
-
-	return ret ? : syscall;
-}
-
-static __always_inline long
-__syscall_enter_from_user_work(struct pt_regs *regs, long syscall)
-{
-	unsigned long work = READ_ONCE(current_thread_info()->syscall_work);
-
-	if (work & SYSCALL_WORK_ENTER)
-		syscall = syscall_trace_enter(regs, syscall, work);
-
-	return syscall;
-}
-
-long syscall_enter_from_user_mode_work(struct pt_regs *regs, long syscall)
-{
-	return __syscall_enter_from_user_work(regs, syscall);
-}
-
-noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
-{
-	long ret;
-
-	__enter_from_user_mode(regs);
-
-	instrumentation_begin();
-	local_irq_enable();
-	ret = __syscall_enter_from_user_work(regs, syscall);
-	instrumentation_end();
-
-	return ret;
-}
-
-noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
-{
-	__enter_from_user_mode(regs);
-	instrumentation_begin();
-	local_irq_enable();
-	instrumentation_end();
-}
-
-void noinstr exit_to_user_mode(void)
-{
-	__exit_to_user_mode();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-- 
2.39.2

