Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE57714F95
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjE2TOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE2TO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:14:27 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56917CD;
        Mon, 29 May 2023 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685387662;
        bh=5w4NZKyVPLUH045JI3QXxaLJDagv6gC2n7xAu8bq0T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RT3UWrn+xCHr3vwR5d6xOmhi+qsJFoWgO9oCztv7nV/2TiQiUZftnDSF/TkGXcp/4
         Es6GYMDISPv38LHGOlcxuAc6Ufi4SjqT34iOSyq19HmowHXFmaPXfoZvjh0w86wHxJ
         MBK8jQoSt0qdPsH6mdJFT8FHk73uZjozgDWGvqL/JjvDJUEMRBBtDN2HdENZ6YQWxW
         faTesn9z7bCV/eB8eOpDK93TsQx4yZU9V986ev6EdjIm8SqBYTHrxCJeEXo6/5y8Ay
         vbs8ovkZJLyZhGvizgtfiAQhMexR8etOpNhnD3qm55NGzWNtF8vc808BDQgdVFFqW3
         8AEIGjTYOiKjA==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QVQFB0xl1z16DH;
        Mon, 29 May 2023 15:14:22 -0400 (EDT)
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
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>, longman@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Date:   Mon, 29 May 2023 15:14:13 -0400
Message-Id: <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
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
 include/linux/sched.h     | 16 +++++++++++++++
 include/uapi/linux/rseq.h | 41 +++++++++++++++++++++++++++++++++++++
 kernel/rseq.c             | 43 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index eed5d65b8d1f..7741ff10136a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1311,6 +1311,7 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+	struct rseq_sched_state __user *rseq_sched_state;
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
@@ -2351,11 +2352,20 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
 	rseq_handle_notify_resume(ksig, regs);
 }
 
+void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
+
+static inline void rseq_set_sched_state(struct task_struct *t, unsigned int state)
+{
+	if (t->rseq_sched_state)
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
@@ -2376,11 +2386,13 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 		t->rseq_len = 0;
 		t->rseq_sig = 0;
 		t->rseq_event_mask = 0;
+		t->rseq_sched_state = NULL;
 	} else {
 		t->rseq = current->rseq;
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
 		t->rseq_event_mask = current->rseq_event_mask;
+		t->rseq_sched_state = current->rseq_sched_state;
 	}
 }
 
@@ -2390,6 +2402,7 @@ static inline void rseq_execve(struct task_struct *t)
 	t->rseq_len = 0;
 	t->rseq_sig = 0;
 	t->rseq_event_mask = 0;
+	t->rseq_sched_state = NULL;
 }
 
 #else
@@ -2405,6 +2418,9 @@ static inline void rseq_signal_deliver(struct ksignal *ksig,
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
index c233aae5eac9..b28588225fa7 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -37,6 +37,13 @@ enum rseq_cs_flags {
 		(1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
 };
 
+enum rseq_sched_state_flags {
+	/*
+	 * Task is currently running on a CPU if bit is set.
+	 */
+	RSEQ_SCHED_STATE_FLAG_ON_CPU		= (1U << 0),
+};
+
 /*
  * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line. It is usually declared as
@@ -53,6 +60,31 @@ struct rseq_cs {
 	__u64 abort_ip;
 } __attribute__((aligned(4 * sizeof(__u64))));
 
+/*
+ * rseq_sched_state should be aligned on the cache line size.
+ */
+struct rseq_sched_state {
+	/*
+	 * Version of this structure. Populated by the kernel, read by
+	 * user-space.
+	 */
+	__u32 version;
+	/*
+	 * The state is updated by the kernel. Read by user-space with
+	 * single-copy atomicity semantics. This field can be read by any
+	 * userspace thread. Aligned on 32-bit. Contains a bitmask of enum
+	 * rseq_sched_state_flags. This field is provided as a hint by the
+	 * scheduler, and requires that the page holding this state is
+	 * faulted-in for the state update to be performed by the scheduler.
+	 */
+	__u32 state;
+	/*
+	 * Thread ID associated with the thread registering this structure.
+	 * Initialized by user-space before registration.
+	 */
+	__u32 tid;
+};
+
 /*
  * struct rseq is aligned on 4 * 8 bytes to ensure it is always
  * contained within a single cache-line.
@@ -148,6 +180,15 @@ struct rseq {
 	 */
 	__u32 mm_cid;
 
+	__u32 padding1;
+
+	/*
+	 * Restartable sequences sched_state_ptr field. Initialized by
+	 * userspace to the address at which the struct rseq_sched_state is
+	 * located. Read by the kernel on rseq registration.
+	 */
+	__u64 sched_state_ptr;
+
 	/*
 	 * Flexible array member at end of structure, after last feature field.
 	 */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe679..e36d6deeae77 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -87,10 +87,12 @@
 
 static int rseq_update_cpu_node_id(struct task_struct *t)
 {
+	struct rseq_sched_state __user *rseq_sched_state = t->rseq_sched_state;
 	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id = raw_smp_processor_id();
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
+	u32 sched_state = RSEQ_SCHED_STATE_FLAG_ON_CPU;
 
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
@@ -99,6 +101,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
 	unsafe_put_user(node_id, &rseq->node_id, efault_end);
 	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
+	unsafe_put_user(sched_state, &rseq_sched_state->state, efault_end);
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
@@ -339,6 +342,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
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
+	(void) put_user(state, &t->rseq_sched_state->state);
+	pagefault_enable();
+}
+
 #ifdef CONFIG_DEBUG_RSEQ
 
 /*
@@ -359,6 +374,29 @@ void rseq_syscall(struct pt_regs *regs)
 
 #endif
 
+static int rseq_get_sched_state_ptr(struct rseq __user *rseq, u32 rseq_len,
+				    struct rseq_sched_state __user **_sched_state_ptr)
+{
+	struct rseq_sched_state __user *sched_state_ptr;
+	u64 sched_state_ptr_value;
+	u32 version = 0;
+	int ret;
+
+	if (rseq_len < offsetofend(struct rseq, sched_state_ptr))
+		return 0;
+	ret = get_user(sched_state_ptr_value, &rseq->sched_state_ptr);
+	if (ret)
+		return ret;
+	sched_state_ptr = (struct rseq_sched_state __user *)(unsigned long)sched_state_ptr_value;
+	if (!sched_state_ptr)
+		return 0;
+	ret = put_user(version, &sched_state_ptr->version);
+	if (ret)
+		return ret;
+	*_sched_state_ptr = sched_state_ptr;
+	return 0;
+}
+
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
@@ -366,6 +404,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		int, flags, u32, sig)
 {
 	int ret;
+	struct rseq_sched_state __user *sched_state_ptr = NULL;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -383,6 +422,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		current->rseq = NULL;
 		current->rseq_sig = 0;
 		current->rseq_len = 0;
+		current->rseq_sched_state = NULL;
 		return 0;
 	}
 
@@ -420,9 +460,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+	if (rseq_get_sched_state_ptr(rseq, rseq_len, &sched_state_ptr))
+		return -EFAULT;
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
+	current->rseq_sched_state = sched_state_ptr;
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
-- 
2.25.1

