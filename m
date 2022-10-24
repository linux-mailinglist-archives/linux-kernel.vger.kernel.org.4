Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D977609F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJXKzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJXKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:54:58 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56582175B7;
        Mon, 24 Oct 2022 03:54:38 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C5B261D82;
        Mon, 24 Oct 2022 12:44:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1666608274; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=3ybaud1kyiVS7GuVr4/KkcFRcnBUsmRucVe0CCHGVXw=;
        b=PdGcuYXB2KhNfeE3P/LI4rjJHS+bNnyqguGy7XMp4h5tqjtGaxZ3C9jidrABfnn20gGxCa
        x8U0SibXgJ9SFLlbRdWM4+HwTCMlX+m3R9LGhBH/Ez6dnJp9cXCESaGa4aU9QDM55elTsW
        W921MugGlOUr0iXeSnVA3OmIqxwun4I/yK5aYGSrxtPHYibQeYnqgB8HKFt7/VEp7nouNX
        URuxTo573KswFnmbqoDWiv0taHBQD9CsLokceD4uAKc6lYXCFJbihfIV5+U4V5EnzCkXLs
        k2wi8nAbGQL5LGwQVH6afxnA59Uw8TpNAYWVkBjfZewPWzF5mXUBLSDDhUABRQ==
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Cc:     Daniel Wagner <wagi@monom.org>
Subject: [PATCH RT 7/9] rcu: Update rcuwait
Date:   Mon, 24 Oct 2022 12:44:23 +0200
Message-Id: <20221024104425.16423-8-wagi@monom.org>
In-Reply-To: <20221024104425.16423-1-wagi@monom.org>
References: <20221024104425.16423-1-wagi@monom.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4.19.255-rt114-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


This is an all in one commit backporting updates for rcuwait:
 - 03f4b48edae7 ("rcuwait: Annotate task_struct with __rcu")
 - 191a43be61d6 ("rcuwait: Introduce rcuwait_active()")
 - 5c21f7b322cb ("rcuwait: Introduce prepare_to and finish_rcuwait")
 - 80fbaf1c3f29 ("rcuwait: Add @state argument to rcuwait_wait_event()")
 - 9d9a6ebfea32 ("rcuwait: Let rcuwait_wake_up() return whether or not a task was awoken")
 - 58d4292bd037 ("rcu: Uninline multi-use function: finish_rcuwait()")

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
 include/linux/rcuwait.h       | 42 +++++++++++++++++++++++++++--------
 kernel/exit.c                 |  7 ++++--
 kernel/locking/percpu-rwsem.c |  2 +-
 kernel/rcu/update.c           |  8 +++++++
 4 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..4fe9ecd56aac 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -3,6 +3,7 @@
 #define _LINUX_RCUWAIT_H_
 
 #include <linux/rcupdate.h>
+#include <linux/sched/signal.h>
 
 /*
  * rcuwait provides a way of blocking and waking up a single
@@ -18,7 +19,7 @@
  * awoken.
  */
 struct rcuwait {
-	struct task_struct *task;
+	struct task_struct __rcu *task;
 };
 
 #define __RCUWAIT_INITIALIZER(name)		\
@@ -29,14 +30,33 @@ static inline void rcuwait_init(struct rcuwait *w)
 	w->task = NULL;
 }
 
-extern void rcuwait_wake_up(struct rcuwait *w);
+extern int rcuwait_wake_up(struct rcuwait *w);
+
+/*
+ * Note: this provides no serialization and, just as with waitqueues,
+ * requires care to estimate as to whether or not the wait is active.
+ */
+static inline int rcuwait_active(struct rcuwait *w)
+{
+	return !!rcu_access_pointer(w->task);
+}
 
 /*
  * The caller is responsible for locking around rcuwait_wait_event(),
- * such that writes to @task are properly serialized.
+ * and [prepare_to/finish]_rcuwait() such that writes to @task are
+ * properly serialized.
  */
-#define rcuwait_wait_event(w, condition)				\
+
+static inline void prepare_to_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, current);
+}
+
+extern void finish_rcuwait(struct rcuwait *w);
+
+#define rcuwait_wait_event(w, condition, state)				\
 ({									\
+	int __ret = 0;							\
 	/*								\
 	 * Complain if we are called after do_exit()/exit_notify(),     \
 	 * as we cannot rely on the rcu critical region for the		\
@@ -44,21 +64,25 @@ extern void rcuwait_wake_up(struct rcuwait *w);
 	 */                                                             \
 	WARN_ON(current->exit_state);                                   \
 									\
-	rcu_assign_pointer((w)->task, current);				\
+	prepare_to_rcuwait(w);						\
 	for (;;) {							\
 		/*							\
 		 * Implicit barrier (A) pairs with (B) in		\
 		 * rcuwait_wake_up().					\
 		 */							\
-		set_current_state(TASK_UNINTERRUPTIBLE);		\
+		set_current_state(state);				\
 		if (condition)						\
 			break;						\
 									\
+		if (signal_pending_state(state, current)) {		\
+			__ret = -EINTR;					\
+			break;						\
+		}							\
+									\
 		schedule();						\
 	}								\
-									\
-	WRITE_ONCE((w)->task, NULL);					\
-	__set_current_state(TASK_RUNNING);				\
+	finish_rcuwait(w);						\
+	__ret;								\
 })
 
 #endif /* _LINUX_RCUWAIT_H_ */
diff --git a/kernel/exit.c b/kernel/exit.c
index 2a414fc71b87..cf68896a94fa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -291,8 +291,9 @@ struct task_struct *task_rcu_dereference(struct task_struct **ptask)
 	return task;
 }
 
-void rcuwait_wake_up(struct rcuwait *w)
+int rcuwait_wake_up(struct rcuwait *w)
 {
+	int ret = 0;
 	struct task_struct *task;
 
 	rcu_read_lock();
@@ -316,8 +317,10 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 */
 	task = rcu_dereference(w->task);
 	if (task)
-		wake_up_process(task);
+		ret = wake_up_process(task);
 	rcu_read_unlock();
+
+	return ret;
 }
 
 /*
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 883cf1b92d90..41787e80dbde 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -159,7 +159,7 @@ void percpu_down_write(struct percpu_rw_semaphore *sem)
 	 */
 
 	/* Wait for all now active readers to complete. */
-	rcuwait_wait_event(&sem->writer, readers_active_check(sem));
+	rcuwait_wait_event(&sem->writer, readers_active_check(sem), TASK_UNINTERRUPTIBLE);
 }
 EXPORT_SYMBOL_GPL(percpu_down_write);
 
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index ed75addd3ccd..4b2ce6bb94a4 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -53,6 +53,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/isolation.h>
 #include <linux/kprobes.h>
+#include <linux/rcuwait.h>
 
 #define CREATE_TRACE_POINTS
 
@@ -375,6 +376,13 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
 
+void finish_rcuwait(struct rcuwait *w)
+{
+	rcu_assign_pointer(w->task, NULL);
+	__set_current_state(TASK_RUNNING);
+}
+EXPORT_SYMBOL_GPL(finish_rcuwait);
+
 #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
 void init_rcu_head(struct rcu_head *head)
 {
-- 
2.38.0

