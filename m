Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BF638BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKYNz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiKYNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:55:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3690221258;
        Fri, 25 Nov 2022 05:55:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA49C6245B;
        Fri, 25 Nov 2022 13:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D975C433D6;
        Fri, 25 Nov 2022 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669384514;
        bh=02dI1lNmveQrMuT/Cc1xXAnRLUb8g7J9hwX6UzoKBFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KouTAujdIoK+X5R0bHouk8vqaIt+Uy9J1A6+KgwwpYJ3AYYmoFXZnLIqJqWhthu+0
         LB6nXrlZWPPq0lvRrz/IeIXqy2x0/ZH4aJoWJph3oOzxAYrOWqMc9PrfMy7/QEI4rG
         vSmOivxxi1G0DES8NNcOg/EYByyXiGT63lxyjmQ/BzupqnEP4dZmBQQWllDfjQYH0k
         BuTH/ydfgjl5T8rQdvCGwniEUmbZN5IdlZhpPH85qIO+5oqoNXXzKVXWmlZmHBZAzA
         AMJCvZ2gcpSUjnSFQ5RJ9166NT8dAHz0F9kiTSft1aZDe3g0D8c+LZynmvxEoNOEyS
         KqZCdzKoO/DBw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org
Subject: [PATCH 3/3] rcu-tasks: Fix synchronize_rcu_tasks() VS zap_pid_ns_processes()
Date:   Fri, 25 Nov 2022 14:55:00 +0100
Message-Id: <20221125135500.1653800-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125135500.1653800-1-frederic@kernel.org>
References: <20221125135500.1653800-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU Tasks and PID-namespace unshare can interact in do_exit() in a
complicated circular dependency:

1) TASK A calls unshare(CLONE_NEWPID), this creates a new PID namespace
   that every subsequent child of TASK A will belong to. But TASK A
   doesn't itself belong to that new PID namespace.

2) TASK A forks() and creates TASK B. TASK A stays attached to its PID
   namespace (let's say PID_NS1) and TASK B is the first task belonging
   to the new PID namespace created by unshare()  (let's call it PID_NS2).

3) Since TASK B is the first task attached to PID_NS2, it becomes the
   PID_NS2 child reaper.

4) TASK A forks() again and creates TASK C which get attached to PID_NS2.
   Note how TASK C has TASK A as a parent (belonging to PID_NS1) but has
   TASK B (belonging to PID_NS2) as a pid_namespace child_reaper.

5) TASK B exits and since it is the child reaper for PID_NS2, it has to
   kill all other tasks attached to PID_NS2, and wait for all of them to
   die before getting reaped itself (zap_pid_ns_process()).

6) TASK A calls synchronize_rcu_tasks() which leads to
   synchronize_srcu(&tasks_rcu_exit_srcu).

7) TASK B is waiting for TASK C to get reaped. But TASK B is under a
   tasks_rcu_exit_srcu SRCU critical section (exit_notify() is between
   exit_tasks_rcu_start() and exit_tasks_rcu_finish()), blocking TASK A.

8) TASK C exits and since TASK A is its parent, it waits for it to reap
   TASK C, but it can't because TASK A waits for TASK B that waits for
   TASK C.

Pid_namespace semantics can hardly be changed at this point. But the
coverage of tasks_rcu_exit_srcu can be reduced instead.

The current task is assumed not to be concurrently reapable at this
stage of exit_notify() and therefore tasks_rcu_exit_srcu can be
temporarily relaxed without breaking its constraints, providing a way
out of the deadlock scenario.

Fixes: 3f95aa81d265 ("rcu: Make TASKS_RCU handle tasks that are almost done exiting")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Suggested-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Eric W . Biederman <ebiederm@xmission.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcupdate.h |  2 ++
 kernel/pid_namespace.c   | 17 +++++++++++++++++
 kernel/rcu/tasks.h       | 14 ++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 89b3036746d2..a19d91d5461c 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -238,6 +238,7 @@ void synchronize_rcu_tasks_rude(void);
 
 #define rcu_note_voluntary_context_switch(t) rcu_tasks_qs(t, false)
 void exit_tasks_rcu_start(void);
+void exit_tasks_rcu_stop(void);
 void exit_tasks_rcu_finish(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 #define rcu_tasks_classic_qs(t, preempt) do { } while (0)
@@ -246,6 +247,7 @@ void exit_tasks_rcu_finish(void);
 #define call_rcu_tasks call_rcu
 #define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
+static inline void exit_tasks_rcu_stop(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index f4f8cb0435b4..fc21c5d5fd5d 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -244,7 +244,24 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
+		/*
+		 * Release tasks_rcu_exit_srcu to avoid following deadlock:
+		 *
+		 * 1) TASK A unshare(CLONE_NEWPID)
+		 * 2) TASK A fork() twice -> TASK B (child reaper for new ns)
+		 *    and TASK C
+		 * 3) TASK B exits, kills TASK C, waits for TASK A to reap it
+		 * 4) TASK A calls synchronize_rcu_tasks()
+		 *                   -> synchronize_srcu(tasks_rcu_exit_srcu)
+		 * 5) *DEADLOCK*
+		 *
+		 * It is considered safe to release tasks_rcu_exit_srcu here
+		 * because we assume the current task can not be concurrently
+		 * reaped at this point.
+		 */
+		exit_tasks_rcu_stop();
 		schedule();
+		exit_tasks_rcu_start();
 	}
 	__set_current_state(TASK_RUNNING);
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9a8114114b48..f9dfc2ece287 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1016,12 +1016,22 @@ void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
  * task is exiting and may be removed from the tasklist. See
  * corresponding synchronize_srcu() for further details.
  */
-void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
+void exit_tasks_rcu_stop(void) __releases(&tasks_rcu_exit_srcu)
 {
 	struct task_struct *t = current;
 
 	__srcu_read_unlock(&tasks_rcu_exit_srcu, t->rcu_tasks_idx);
-	exit_tasks_rcu_finish_trace(t);
+}
+
+/*
+ * Contribute to protect against tasklist scan blind spot while the
+ * task is exiting and may be removed from the tasklist. See
+ * corresponding synchronize_srcu() for further details.
+ */
+void exit_tasks_rcu_finish(void)
+{
+	exit_tasks_rcu_stop();
+	exit_tasks_rcu_finish_trace(current);
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
-- 
2.25.1

