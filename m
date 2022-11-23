Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0263F634CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiKWBVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiKWBVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:21:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBF1B5A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:17 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cg5so10430958qtb.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 17:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GtnXpguQj4O0Y4VxU8SlCD6RocW4OIg2BaI4YRFC28=;
        b=AA9IN5HCivPYCzFmqlbWwF8baNeqOR9Ccmdvk3ZCGGkEayW3L++azUK+9Bgah47C5E
         /GHOjjDLal9oMLaNvJhcWfo8jCo0FSsdC2sfXTZ3f4KI2WJhp6EuE1nIObGJTo7N5phH
         V/nSlNvCnKkrWRiDgKlRqujAL6x+cz3UM3T6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GtnXpguQj4O0Y4VxU8SlCD6RocW4OIg2BaI4YRFC28=;
        b=2pGoYYO4rSpJ0OfJxrExhWlBAL9X0MuT0MkJO8VDwZ/GufdWCpsieqMzdmHOUXCJKI
         gunjGLggNilw7i852bJ5iiAWFMh18bjR72X7VYq49QaGFP739GvMAdugpE8Y9lGqbV3f
         Aqw7/ddkI9LUxTFsyrtlDJdrflwDhayCrAYU4xEci66q3VMDCAwNfY7P03f1kTFA/XiR
         1H3TVurU16UHQm0K6FGNfCYa/8qco1hSTLBVPn/gf9IY9qDQa0DG8sdNfbGhbzz+yK0q
         9pqYgYldb1GAS5bJUdVZ7snoAsvPr8r5NFrKaY+Ab7XisgzbnXe/vaZ1w7njVH/cFWjH
         3Arw==
X-Gm-Message-State: ANoB5pm1irUAKxBIGvBwxEUcxFQ27LFIELlChh4Yu0l/hMtfQfVOxVGE
        YYKs9aj76uf5OGi+7nqdN4FPtmkCUZvWSw==
X-Google-Smtp-Source: AA0mqf4C1zrZVf02my366Mut7UBgrffo7WKuTROXtE64lO8/bFc9S6NaTqSqltNwXqzsRCMakHJreA==
X-Received: by 2002:ac8:5551:0:b0:3a6:5573:5851 with SMTP id o17-20020ac85551000000b003a655735851mr4334524qtr.313.1669166476848;
        Tue, 22 Nov 2022 17:21:16 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id gc7-20020a05622a59c700b0035ce8965045sm9096026qtb.42.2022.11.22.17.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 17:21:16 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Connor O'Brien" <connoro@google.com>
Subject: [PATCH RFC 1/3] sched/pe: Exclude balance callback queuing during proxy()'s migrate
Date:   Wed, 23 Nov 2022 01:21:02 +0000
Message-Id: <20221123012104.3317665-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123012104.3317665-1-joel@joelfernandes.org>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 565790d28b1e ("sched: Fix balance_callback()"), it is clear
that rq lock needs to be held from when balance callbacks are queued to
when __balance_callbacks() in schedule() is called.

This has to be done without dropping the runqueue lock in between. If
dropped between queuing and executing callbacks, it is possible that
another CPU, say in __sched_setscheduler() can queue balancing callbacks
and cause issues as show in that commit.

This is precisely what happens in proxy(). During a proxy(), the current
CPU's rq lock is temporary dropped when moving the tasks in the migrate
list to the owner CPU.

This commit therefore make proxy() exclude balance callback queuing on
other CPUs, in the section where proxy() temporarily drops the rq lock
of current CPU.

CPUs that acquire a remote CPU's rq lock but later queue a balance
callback, are made to call the new helpers in this commit to check
whether balance_lock is held. If it is held, then the rq lock is
released and a re-attempt is made to acquire it in the hopes that
the ban on balancing callback queuing has elapsed.

Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 72 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  7 ++++-
 2 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88a5fa34dc06..aba90b3dc3ef 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -633,6 +633,29 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	}
 }
 
+/*
+ * Helper to call __task_rq_lock safely, in scenarios where we might be about to
+ * queue a balance callback on a remote CPU. That CPU might be in proxy(), and
+ * could have released its rq lock while holding balance_lock. So release rq
+ * lock in such a situation to avoid deadlock, and retry.
+ */
+struct rq *__task_rq_lock_balance(struct task_struct *p, struct rq_flags *rf)
+{
+	struct rq *rq;
+	bool locked = false;
+
+	do {
+		if (locked) {
+			__task_rq_unlock(rq, rf);
+			cpu_relax();
+		}
+		rq = __task_rq_lock(p, rf);
+		locked = true;
+	} while (raw_spin_is_locked(&rq->balance_lock));
+
+	return rq;
+}
+
 /*
  * task_rq_lock - lock p->pi_lock and lock the rq @p resides on.
  */
@@ -675,6 +698,29 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	}
 }
 
+/*
+ * Helper to call task_rq_lock safely, in scenarios where we might be about to
+ * queue a balance callback on a remote CPU. That CPU might be in proxy(), and
+ * could have released its rq lock while holding balance_lock. So release rq
+ * lock in such a situation to avoid deadlock, and retry.
+ */
+struct rq *task_rq_lock_balance(struct task_struct *p, struct rq_flags *rf)
+{
+	struct rq *rq;
+	bool locked = false;
+
+	do {
+		if (locked) {
+			task_rq_unlock(rq, p, rf);
+			cpu_relax();
+		}
+		rq = task_rq_lock(p, rf);
+		locked = true;
+	} while (raw_spin_is_locked(&rq->balance_lock));
+
+	return rq;
+}
+
 /*
  * RQ-clock updating methods:
  */
@@ -6739,6 +6785,12 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 		p->wake_cpu = wake_cpu;
 	}
 
+	/*
+	 * Prevent other CPUs from queuing balance callbacks while we migrate
+	 * tasks in the migrate_list with the rq lock released.
+	 */
+	raw_spin_lock(&rq->balance_lock);
+
 	rq_unpin_lock(rq, rf);
 	raw_spin_rq_unlock(rq);
 	raw_spin_rq_lock(that_rq);
@@ -6758,7 +6810,21 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
 	}
 
 	raw_spin_rq_unlock(that_rq);
+
+	/*
+	 * This may make lockdep unhappy as we acquire rq->lock with
+	 * balance_lock held. But that should be a false positive, as the
+	 * following pattern happens only on the current CPU with interrupts
+	 * disabled:
+	 * rq_lock()
+	 * balance_lock();
+	 * rq_unlock();
+	 * rq_lock();
+	 */
 	raw_spin_rq_lock(rq);
+
+	raw_spin_unlock(&rq->balance_lock);
+
 	rq_repin_lock(rq, rf);
 
 	return NULL; /* Retry task selection on _this_ CPU. */
@@ -7489,7 +7555,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 	if (p->pi_top_task == pi_task && prio == p->prio && !dl_prio(prio))
 		return;
 
-	rq = __task_rq_lock(p, &rf);
+	rq = __task_rq_lock_balance(p, &rf);
 	update_rq_clock(rq);
 	/*
 	 * Set under pi_lock && rq->lock, such that the value can be used under
@@ -8093,7 +8159,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	 * To be able to change p->policy safely, the appropriate
 	 * runqueue lock must be held.
 	 */
-	rq = task_rq_lock(p, &rf);
+	rq = task_rq_lock_balance(p, &rf);
+
 	update_rq_clock(rq);
 
 	/*
@@ -10312,6 +10379,7 @@ void __init sched_init(void)
 
 		rq = cpu_rq(i);
 		raw_spin_lock_init(&rq->__lock);
+		raw_spin_lock_init(&rq->balance_lock);
 		rq->nr_running = 0;
 		rq->calc_load_active = 0;
 		rq->calc_load_update = jiffies + LOAD_FREQ;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 354e75587fed..17947a4009de 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1057,6 +1057,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	raw_spinlock_t		balance_lock;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
@@ -1748,18 +1749,22 @@ queue_balance_callback(struct rq *rq,
 		       void (*func)(struct rq *rq))
 {
 	lockdep_assert_rq_held(rq);
+	raw_spin_lock(&rq->balance_lock);
 
 	/*
 	 * Don't (re)queue an already queued item; nor queue anything when
 	 * balance_push() is active, see the comment with
 	 * balance_push_callback.
 	 */
-	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
+	if (unlikely(head->next || rq->balance_callback == &balance_push_callback)) {
+		raw_spin_unlock(&rq->balance_lock);
 		return;
+	}
 
 	head->func = (void (*)(struct callback_head *))func;
 	head->next = rq->balance_callback;
 	rq->balance_callback = head;
+	raw_spin_unlock(&rq->balance_lock);
 }
 
 #define rcu_dereference_check_sched_domain(p) \
-- 
2.38.1.584.g0f3c55d4c2-goog

