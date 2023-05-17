Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9295C706CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjEQP15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjEQP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:27:21 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41C9ECB;
        Wed, 17 May 2023 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684337224;
        bh=1RursNp9qkMTEe/+yMwWnmeNTzScNBsuw1A9Btx9VgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EmcH9M9uGLTxz1YI6yx1ArarwBBRUSw2TPdgE8iVHAMD9UT7tr/3iiFq244PhEw8o
         +Gr9a+zVV/aRi+thfHp+rrk4OlidHlM/r6zMlInIZUBrTJkh2K2qsJKpPBI10cGrRk
         P7Z6U6DAmDnJdtq4tRBfv3dzZfMswU1QVRshqBB8E7eUCXAyUhgl54p8BGWpKcscaS
         6kN2/UQguakV2xf384R2W3zsMUOP7vaXC9hSn41w7FJSNzFUYdm/EqCiY77zMfNheZ
         INdQlrRmyq1mF60w+pTO0boVcG1e8vbRqIZmnMc8jJrlAxfrM670yaz0JfbKGa+75/
         1+C6Qp62LE5IQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QLxmR53HXz131r;
        Wed, 17 May 2023 11:27:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
Date:   Wed, 17 May 2023 11:26:51 -0400
Message-Id: <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose the "on-cpu" state for each thread through struct rseq to allow
adaptative mutexes to decide more accurately between busy-waiting and
calling sys_futex() to release the CPU, based on the on-cpu state of the
mutex owner.

It is only provided as an optimization hint, because there is no
guarantee that the page containing this field is in the page cache, and
therefore the scheduler may very well fail to clear the on-cpu state on
preemption. This is expected to be rare though, and is resolved as soon
as the task returns to user-space.

The goal is to improve use-cases where the duration of the critical
sections for a given lock follows a multi-modal distribution, preventing
statistical guesses from doing a good job at choosing between busy-wait
and futex wait behavior.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: libc-alpha@sourceware.org
---
 include/linux/sched.h     | 12 ++++++++++++
 include/uapi/linux/rseq.h | 17 +++++++++++++++++
 kernel/rseq.c             | 14 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..c7e9248134c1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
 	rseq_handle_notify_resume(ksig, regs);
 }
 
+void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
+
+static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
+{
+	if (t->rseq)
+		__rseq_set_sched_state(t, state);
+}
+
 /* rseq_preempt() requires preemption to be disabled. */
 static inline void rseq_preempt(struct task_struct *t)
 {
 	__set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
 	rseq_set_notify_resume(t);
+	rseq_set_sched_state(t, 0);
 }
 
 /* rseq_migrate() requires preemption to be disabled. */
@@ -2405,6 +2414,9 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
 }
+static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
+{
+}
 static inline void rseq_preempt(struct task_struct *t)
 {
 }
diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index c233aae5eac9..c6d8537e23ca 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -37,6 +37,13 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_sched_state {
+	/*
+	 * Task is currently running on a CPU if bit is set.
+	 */
+	RSEQ_SCHED_STATE_ON_CPU		= (1U << 0),
+};
+
 /*
  * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -148,6 +155,16 @@ struct rseq {
 	 */
 	__u32 mm_cid;
 
+	/*
+	 * Restartable sequences sched_state field. Updated by the kernel. Read
+	 * by user-space with single-copy atomicity semantics. This fields can
+	 * be read by any userspace thread. Aligned on 32-bit. Contains a
+	 * bitmask of enum rseq_sched_state. This field is provided as a hint
+	 * by the scheduler, and requires that the page holding struct rseq is
+	 * faulted-in for the state update to be performed by the scheduler.
+	 */
+	__u32 sched_state;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..b2eb3bbaa9ef 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -91,6 +91,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
+	u32 sched_state = RSEQ_SCHED_STATE_ON_CPU;
 
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
@@ -99,6 +100,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
+	unsafe_put_user(sched_state, &rseq->sched_state, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -339,6 +341,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	force_sigsegv(sig);
 }
 
+/*
+ * Attempt to update rseq scheduler state.
+ */
+void __rseq_set_sched_state(struct task_struct *t, unsigned int state)
+{
+	if (unlikely(t->flags & PF_EXITING))
+		return;
+	pagefault_disable();
+	(void) put_user(state, &t->rseq->sched_state);
+	pagefault_enable();
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 /*
-- 
2.25.1

