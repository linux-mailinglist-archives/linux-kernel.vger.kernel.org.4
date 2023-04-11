Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF96DD0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 06:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjDKEZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 00:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDKEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 00:25:25 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9E26B6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:25 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517c573b459so251135a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 21:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681187124; x=1683779124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3FRzs4MfhGJXugdp9HAHsz85BzfgozE6U/WQSP3LFk=;
        b=KB3ZIYaYrwBBvjA3ksjkSpF9ttsxxOVA9OXjhH2R19lbcUMG+7zgvNUTld3cp6yre+
         0FTg2UjI2DwtZ5ddhbh9eDZVc1M8q9dkkIm+ID1fMklwO78Fs0Ju517r0b6doGfLO+z7
         fW4zhvTAXFZ0v+MR/beIBl65yY1CmwgbXR3TPfjHgzV7ngV/eaiZ1gHpeILTawW2eeVn
         BtvCg2ytG62e+EBH7CrGDkzToti0ZFmxNor5G+syuw1BTtgvPYn+Y7bD7FVzMQ+v1svO
         G9hyMo+Pb+LgSo+iwTwDc+FY4GNXoYKvGnqJpCNdGfLYynpngoRF8QlGxLumJXJdOlys
         vINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681187124; x=1683779124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3FRzs4MfhGJXugdp9HAHsz85BzfgozE6U/WQSP3LFk=;
        b=wkD9c/p05pdCzAH5m2fdusBM+uXEgqmCnypHpfYVCQH6Vmhr2F4J+Cv1hz4v7z80rs
         w0Wz17rJsJ8S915NFa63L0XJBBRpnoOhnJzJhLARvU3FsOgtSjEEcjm0POS/H2bC2V0H
         KJEIWbj2vfCG49B1Hr4tj8ILGiAcuznMEyQJNqrGhWBUuAIGJBSh+JBIkC6ShP2li0xx
         aiDeUXCgSG4Gv2yoLV6t97KGGgaEGzks9fmOs1WGgwR4o/ba+74X97kjcqXL45De6C79
         o+zIUXu+pfYPwCTKi898s6iFgYRWekEoX0tASYGzGtwcH5svY+joV9KnhkbhCXqOkQXe
         IhTw==
X-Gm-Message-State: AAQBX9ftzMU1LKcFBdCkOOdlyWnthsWjARDYIoJfnargvnrXEUAUioiq
        FUlothCudrx40AFPeWq/cYTxOgXWcSUZA9HCcNiPh2z52+JW8Viv4sWVJipaaFv3+f8NM0h8OtB
        EShhClCiB4eJrtLk9k8gH6KjiElNyHocPD7Ww4EbZVvFgcfNiPmmEvwXWG9WfDPi2OYYlwlE=
X-Google-Smtp-Source: AKy350ZuWJgZLZlBbnPiFA9eRlMmOrmk/C+ziCWJvtvRhX2bVLrBABSqGIagX44nMmgpvFsY1hXGeTrqQRxE
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:2388:b0:626:2343:76b0 with SMTP
 id f8-20020a056a00238800b00626234376b0mr6116748pfc.6.1681187124493; Mon, 10
 Apr 2023 21:25:24 -0700 (PDT)
Date:   Tue, 11 Apr 2023 04:25:00 +0000
In-Reply-To: <20230411042511.1606592-1-jstultz@google.com>
Mime-Version: 1.0
References: <20230411042511.1606592-1-jstultz@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230411042511.1606592-4-jstultz@google.com>
Subject: [PATCH v3 03/14] locking/mutex: Rework task_struct::blocked_on
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Connor O'Brien" <connoro@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Track the blocked-on relation for mutexes, this allows following this
relation at schedule time.

   task
     | blocked-on
     v
   mutex
     | owner
     v
   task

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[minor changes while rebasing]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Fixed blocked_on tracking in error paths that was causing crashes
---
 include/linux/sched.h        | 5 +----
 kernel/fork.c                | 3 +--
 kernel/locking/mutex-debug.c | 9 +++++----
 kernel/locking/mutex.c       | 7 +++++++
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 63d242164b1a..6053c7dfb40e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1139,10 +1139,7 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	struct mutex			*blocked_on;	/* lock we're blocked on */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
diff --git a/kernel/fork.c b/kernel/fork.c
index 0c92f224c68c..933406f5596b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2221,9 +2221,8 @@ static __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
-#endif
+
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index bc8abb8549d2..7228909c3e62 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -52,17 +52,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	lockdep_assert_held(&lock->wait_lock);
 
-	/* Mark the current thread as blocked on the lock: */
-	task->blocked_on = waiter;
+	/* Current thread can't be already blocked (since it's executing!) */
+	DEBUG_LOCKS_WARN_ON(task->blocked_on);
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
+	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
-	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
-	task->blocked_on = NULL;
+	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
 
 	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a528e7f42caa..d7a202c35ebe 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -646,6 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	current->blocked_on = lock;
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -683,6 +684,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		/*
+		 * Gets reset by ttwu_runnable().
+		 */
+		current->blocked_on = lock;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -720,6 +725,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
+	current->blocked_on = NULL;
 	/* got the lock - cleanup and rejoice! */
 	lock_acquired(&lock->dep_map, ip);
 	trace_contention_end(lock, 0);
@@ -734,6 +740,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
+	current->blocked_on = NULL;
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-- 
2.40.0.577.gac1e443424-goog

