Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E22C5EDD3F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiI1M5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbiI1M5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:57:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B24AA72B7B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:56:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29C401063;
        Wed, 28 Sep 2022 05:57:03 -0700 (PDT)
Received: from wubuntu (unknown [10.57.34.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCF693F73D;
        Wed, 28 Sep 2022 05:56:53 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:56:52 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        John Dias <joaodias@google.com>,
        Connor O'Brien <connoro@google.com>,
        Rick Yiu <rickyiu@google.com>, John Kacur <jkacur@redhat.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC PATCH v3 3/3] softirq: defer softirq processing to
 ksoftirqd if CPU is busy with RT
Message-ID: <20220928125652.zp3nviowo56ck3ne@wubuntu>
References: <20220921012550.3288570-1-jstultz@google.com>
 <20220921012550.3288570-4-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921012550.3288570-4-jstultz@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/22 01:25, John Stultz wrote:
> From: Pavankumar Kondeti <pkondeti@codeaurora.org>
> 
> Defer the softirq processing to ksoftirqd if a RT task is
> running or queued on the current CPU. This complements the RT
> task placement algorithm which tries to find a CPU that is not
> currently busy with softirqs.
> 
> Currently NET_TX, NET_RX, BLOCK and TASKLET softirqs are only

Should we mention IRQ_POLL?

I think TASKLET is debatable as I mentioned in my other email.

> deferred as they can potentially run for long time.
> 
> Additionally, this patch stubs out ksoftirqd_running() logic,
> in the CONFIG_RT_SOFTIRQ_OPTIMIZATION case, as deferring
> potentially long-running softirqs will cause the logic to not
> process shorter-running softirqs immediately. By stubbing it out
> the potentially long running softirqs are deferred, but the
> shorter running ones can still run immediately.
> 
> This patch includes folded-in fixes by:
>   Lingutla Chandrasekhar <clingutla@codeaurora.org>
>   Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
>   J. Avila <elavila@google.com>
> 
> Cc: John Dias <joaodias@google.com>
> Cc: Connor O'Brien <connoro@google.com>
> Cc: Rick Yiu <rickyiu@google.com>
> Cc: John Kacur <jkacur@redhat.com>
> Cc: Qais Yousef <qais.yousef@arm.com>
> Cc: Chris Redpath <chris.redpath@arm.com>
> Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: kernel-team@android.com
> Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
> [satyap@codeaurora.org: trivial merge conflict resolution.]
> Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
> [elavila: Port to mainline, squash with bugfix]
> Signed-off-by: J. Avila <elavila@google.com>
> [jstultz: Rebase to linus/HEAD, minor rearranging of code,
>  included bug fix Reported-by: Qais Yousef <qais.yousef@arm.com> ]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  include/linux/sched.h | 10 ++++++++++
>  kernel/sched/cpupri.c | 13 +++++++++++++
>  kernel/softirq.c      | 25 +++++++++++++++++++++++--
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e7b2f8a5c711..7f76371cbbb0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1826,6 +1826,16 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
>  
>  extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
>  extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
> +
> +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> +extern bool cpupri_check_rt(void);
> +#else
> +static inline bool cpupri_check_rt(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #ifdef CONFIG_SMP
>  extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
>  extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
> diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
> index fa9ce9d83683..18dc75d16951 100644
> --- a/kernel/sched/cpupri.c
> +++ b/kernel/sched/cpupri.c
> @@ -64,6 +64,19 @@ static int convert_prio(int prio)
>  	return cpupri;
>  }
>  
> +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> +/*
> + * cpupri_check_rt - check if CPU has a RT task
> + * should be called from rcu-sched read section.
> + */
> +bool cpupri_check_rt(void)
> +{
> +	int cpu = raw_smp_processor_id();
> +
> +	return cpu_rq(cpu)->rd->cpupri.cpu_to_pri[cpu] > CPUPRI_NORMAL;
> +}

Priorities always mess up with my brain! I always forget which direction to
look at :D

Hmm I was wondering why not do rt_task(current), but if the task is not running
(which can only indicate there's a DL or a stopper task preempting it), that
won't work. But I think your code has a similar problem; you'll return true
even if there's only a DL task running since we set the priority to
CPUPRI_HIGHER which will cause your condition to return true.

This makes me think if we should enable this optimization for DL tasks too.
Hmm...

That said, is there a reason why we can't remove this function and just call
rt_task(current) directly in softirq_deferred_for_rt()?

If we decided to care about DL we can do rt_task(current) || dl_task(current).


Thanks

--
Qais Yousef

> +#endif
> +
>  static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
>  				struct cpumask *lowest_mask, int idx)
>  {
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 35ee79dd8786..203a70dc9459 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -87,6 +87,7 @@ static void wakeup_softirqd(void)
>  		wake_up_process(tsk);
>  }
>  
> +#ifndef CONFIG_RT_SOFTIRQ_OPTIMIZATION
>  /*
>   * If ksoftirqd is scheduled, we do not want to process pending softirqs
>   * right now. Let ksoftirqd handle this at its own rate, to get fairness,
> @@ -101,6 +102,9 @@ static bool ksoftirqd_running(unsigned long pending)
>  		return false;
>  	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
>  }
> +#else
> +#define ksoftirqd_running(pending) (false)
> +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
>  DEFINE_PER_CPU(int, hardirqs_enabled);
> @@ -532,6 +536,17 @@ static inline bool lockdep_softirq_start(void) { return false; }
>  static inline void lockdep_softirq_end(bool in_hardirq) { }
>  #endif
>  
> +static __u32 softirq_deferred_for_rt(__u32 *pending)
> +{
> +	__u32 deferred = 0;
> +
> +	if (cpupri_check_rt()) {
> +		deferred = *pending & LONG_SOFTIRQ_MASK;
> +		*pending &= ~LONG_SOFTIRQ_MASK;
> +	}
> +	return deferred;
> +}
> +
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
>  	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
> @@ -539,6 +554,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	int max_restart = MAX_SOFTIRQ_RESTART;
>  	struct softirq_action *h;
>  	bool in_hardirq;
> +	__u32 deferred;
>  	__u32 pending;
>  	int softirq_bit;
>  
> @@ -551,13 +567,15 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  
>  	pending = local_softirq_pending();
>  
> +	deferred = softirq_deferred_for_rt(&pending);
>  	softirq_handle_begin();
> +
>  	in_hardirq = lockdep_softirq_start();
>  	account_softirq_enter(current);
>  
>  restart:
>  	/* Reset the pending bitmask before enabling irqs */
> -	set_softirq_pending(0);
> +	set_softirq_pending(deferred);
>  	__this_cpu_write(active_softirqs, pending);
>  
>  	local_irq_enable();
> @@ -596,13 +614,16 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	local_irq_disable();
>  
>  	pending = local_softirq_pending();
> +	deferred = softirq_deferred_for_rt(&pending);
> +
>  	if (pending) {
>  		if (time_before(jiffies, end) && !need_resched() &&
>  		    --max_restart)
>  			goto restart;
> +	}
>  
> +	if (pending | deferred)
>  		wakeup_softirqd();
> -	}
>  
>  	account_softirq_exit(current);
>  	lockdep_softirq_end(in_hardirq);
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 
