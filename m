Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E556484A6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiLIPHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiLIPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:07:26 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEAC245A2B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:07:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3986623A;
        Fri,  9 Dec 2022 07:07:31 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7153F73D;
        Fri,  9 Dec 2022 07:07:20 -0800 (PST)
Message-ID: <38ab85af-7cc2-55b5-7e3b-2b8444b95133@arm.com>
Date:   Fri, 9 Dec 2022 16:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RFC 1/3] sched/pe: Exclude balance callback queuing during
 proxy()'s migrate
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
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
        Connor O'Brien <connoro@google.com>
References: <20221123012104.3317665-1-joel@joelfernandes.org>
 <20221123012104.3317665-2-joel@joelfernandes.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221123012104.3317665-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2022 02:21, Joel Fernandes (Google) wrote:
> In commit 565790d28b1e ("sched: Fix balance_callback()"), it is clear
> that rq lock needs to be held from when balance callbacks are queued to
> when __balance_callbacks() in schedule() is called.
> 
> This has to be done without dropping the runqueue lock in between. If
> dropped between queuing and executing callbacks, it is possible that
> another CPU, say in __sched_setscheduler() can queue balancing callbacks
> and cause issues as show in that commit.
> 
> This is precisely what happens in proxy(). During a proxy(), the current
> CPU's rq lock is temporary dropped when moving the tasks in the migrate
> list to the owner CPU.
> 
> This commit therefore make proxy() exclude balance callback queuing on
> other CPUs, in the section where proxy() temporarily drops the rq lock
> of current CPU.
> 
> CPUs that acquire a remote CPU's rq lock but later queue a balance
> callback, are made to call the new helpers in this commit to check
> whether balance_lock is held. If it is held, then the rq lock is
> released and a re-attempt is made to acquire it in the hopes that
> the ban on balancing callback queuing has elapsed.
> 
> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/core.c  | 72 ++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/sched.h |  7 ++++-
>  2 files changed, 76 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 88a5fa34dc06..aba90b3dc3ef 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -633,6 +633,29 @@ struct rq *__task_rq_lock(struct task_struct *p, struct rq_flags *rf)
>  	}
>  }
>  
> +/*
> + * Helper to call __task_rq_lock safely, in scenarios where we might be about to
> + * queue a balance callback on a remote CPU. That CPU might be in proxy(), and
> + * could have released its rq lock while holding balance_lock. So release rq
> + * lock in such a situation to avoid deadlock, and retry.
> + */
> +struct rq *__task_rq_lock_balance(struct task_struct *p, struct rq_flags *rf)
> +{
> +	struct rq *rq;
> +	bool locked = false;
> +
> +	do {
> +		if (locked) {
> +			__task_rq_unlock(rq, rf);
> +			cpu_relax();
> +		}
> +		rq = __task_rq_lock(p, rf);
> +		locked = true;
> +	} while (raw_spin_is_locked(&rq->balance_lock));
> +
> +	return rq;
> +}
> +
>  /*
>   * task_rq_lock - lock p->pi_lock and lock the rq @p resides on.
>   */
> @@ -675,6 +698,29 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
>  	}
>  }
>  
> +/*
> + * Helper to call task_rq_lock safely, in scenarios where we might be about to
> + * queue a balance callback on a remote CPU. That CPU might be in proxy(), and
> + * could have released its rq lock while holding balance_lock. So release rq
> + * lock in such a situation to avoid deadlock, and retry.
> + */
> +struct rq *task_rq_lock_balance(struct task_struct *p, struct rq_flags *rf)
> +{
> +	struct rq *rq;
> +	bool locked = false;
> +
> +	do {
> +		if (locked) {
> +			task_rq_unlock(rq, p, rf);
> +			cpu_relax();
> +		}
> +		rq = task_rq_lock(p, rf);
> +		locked = true;
> +	} while (raw_spin_is_locked(&rq->balance_lock));
> +
> +	return rq;
> +}
> +
>  /*
>   * RQ-clock updating methods:
>   */
> @@ -6739,6 +6785,12 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>  		p->wake_cpu = wake_cpu;
>  	}
>  
> +	/*
> +	 * Prevent other CPUs from queuing balance callbacks while we migrate
> +	 * tasks in the migrate_list with the rq lock released.
> +	 */
> +	raw_spin_lock(&rq->balance_lock);
> +
>  	rq_unpin_lock(rq, rf);
>  	raw_spin_rq_unlock(rq);
>  	raw_spin_rq_lock(that_rq);
> @@ -6758,7 +6810,21 @@ proxy(struct rq *rq, struct task_struct *next, struct rq_flags *rf)
>  	}
>  
>  	raw_spin_rq_unlock(that_rq);
> +
> +	/*
> +	 * This may make lockdep unhappy as we acquire rq->lock with
> +	 * balance_lock held. But that should be a false positive, as the
> +	 * following pattern happens only on the current CPU with interrupts
> +	 * disabled:
> +	 * rq_lock()
> +	 * balance_lock();
> +	 * rq_unlock();
> +	 * rq_lock();
> +	 */
>  	raw_spin_rq_lock(rq);
> +
> +	raw_spin_unlock(&rq->balance_lock);
> +
>  	rq_repin_lock(rq, rf);
>  
>  	return NULL; /* Retry task selection on _this_ CPU. */
> @@ -7489,7 +7555,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
>  	if (p->pi_top_task == pi_task && prio == p->prio && !dl_prio(prio))
>  		return;
>  
> -	rq = __task_rq_lock(p, &rf);
> +	rq = __task_rq_lock_balance(p, &rf);
>  	update_rq_clock(rq);
>  	/*
>  	 * Set under pi_lock && rq->lock, such that the value can be used under
> @@ -8093,7 +8159,8 @@ static int __sched_setscheduler(struct task_struct *p,
>  	 * To be able to change p->policy safely, the appropriate
>  	 * runqueue lock must be held.
>  	 */
> -	rq = task_rq_lock(p, &rf);
> +	rq = task_rq_lock_balance(p, &rf);
> +
>  	update_rq_clock(rq);
>  
>  	/*

You consider rt_mutex_setprio() and __sched_setscheduler() versus
proxy() but what about all the other places like load_balance(),
update_blocked_averages(),  __set_cpus_allowed_ptr() and many
more in which we take the rq lock (via task_rq_lock() or
rq_lock{_xxx}())?

With your changes to locktorture in {2-3}/3 you still run CFS
lock_torture_writers but you should see the issue popping up
in __set_cpus_allowed_ptr() (from torture_shuffle()) for example.

Tried with:

insmod /lib/modules/torture.ko
insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=1 nlocks=3
                                                                      ^^^^^^^^^^^^^^^^^

When changing all lock_torture_writer's to FIFO it becomes even
more visible.

-->8--

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index e4529c2166e9..ea75d525fe7c 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -683,7 +683,8 @@ static int lock_torture_writer(void *arg)
        DEFINE_TORTURE_RANDOM(rand);
 
        VERBOSE_TOROUT_STRING("lock_torture_writer task started");
-       set_user_nice(current, MAX_NICE);
+       if (!rt_task(current))
+               set_user_nice(current, MAX_NICE);
 
        do {
                if ((torture_random(&rand) & 0xfffff) == 0)
diff --git a/kernel/torture.c b/kernel/torture.c
index 1d0dd88369e3..55d8ac417a4a 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -57,6 +57,9 @@ module_param(verbose_sleep_duration, int, 0444);
 static int random_shuffle;
 module_param(random_shuffle, int, 0444);
 
+static int lock_torture_writer_fifo;
+module_param(lock_torture_writer_fifo, int, 0444);
+
 static char *torture_type;
 static int verbose;
 
@@ -734,7 +737,7 @@ bool stutter_wait(const char *title)
        cond_resched_tasks_rcu_qs();
        spt = READ_ONCE(stutter_pause_test);
        for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-               if (!ret) {
+               if (!ret && !rt_task(current)) {
                        sched_set_normal(current, MAX_NICE);
                        ret = true;
                }
@@ -944,6 +947,11 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
                *tp = NULL;
                return ret;
        }
+
+       if (lock_torture_writer_fifo &&
+           !strncmp(s, "lock_torture_writer", strlen(s)))
+               sched_set_fifo(*tp);
+
        wake_up_process(*tp);  // Process is sleeping, so ordering provided.
        torture_shuffle_task_register(*tp);
        return ret;

[...]
