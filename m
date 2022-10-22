Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FADD608EFC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 20:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJVS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 14:28:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C000574B8D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:28:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l28so3558139qtv.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 11:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuaJ4JdIANK6ZdWuRdzGahM3Sj91AEVovXrCovDaGd8=;
        b=h7Pe1cp5eER7dgNaNsh37b0sQ/s90UaiANiYxil3t9+QxwCkn8ycMuOyJuU0W7Kf98
         c3+qaLVnCEOq6qYmFlIxEjgIx9cszViJXdZzHirPch44TdpPgoNTyOGSPQqT8i75Uww/
         dqs7ftrzEA7sSAEmYbr4hVky+GFjKZXZn2fbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuaJ4JdIANK6ZdWuRdzGahM3Sj91AEVovXrCovDaGd8=;
        b=KMM28eEBIjARq1zsEfdTK6/sFqJe5jBkVAZmmuz+iwPwSEr/2FjtgRbRHv6Vu3jDOb
         1jCJbS0LmLMRdnvkCN2Dly/dBKLeiDoapBtrwki359W8dmCYdiV/3e60L0GY+uEqNc2Y
         TU27FT4jT8KwOqhqtlddphPnW1e1B88uP5X9FB8UBVeOj8j4+WgjYF1UWitaufsSut+b
         sg5okP/Mzv4PN4ZCMeXtJ+oXiWWngdcwOAMFKDJBoKyCjL6Na0yfkmRUx5dbb7/GNMCa
         WnCKcnbkkKN4vlWstwhfDRZ4mbn68z/yu5Xr4B0hje6JQjii5aBttPrBrqXk68TuhV8q
         qbWQ==
X-Gm-Message-State: ACrzQf1gVLLYSwNxljjS2TMiB1v9ndi4Ky+3P3R90FfhWcm515oFI7ls
        Fu5LbUdkSi//9KFJZqGhS9sk3g==
X-Google-Smtp-Source: AMsMyM5Emo3C8knp8tFkQjKeCOqpGrjmMMhc4XdnSgHEVUwfd6uoHxH8dGOvBafcwQA2NGsBflRhsQ==
X-Received: by 2002:ac8:5f14:0:b0:39c:dae5:35d5 with SMTP id x20-20020ac85f14000000b0039cdae535d5mr21620805qta.312.1666463331796;
        Sat, 22 Oct 2022 11:28:51 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bw15-20020a05622a098f00b0035d08c1da35sm10062218qtb.45.2022.10.22.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 11:28:51 -0700 (PDT)
Date:   Sat, 22 Oct 2022 18:28:50 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Connor O'Brien <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>
Subject: Re: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores
 handling long softirqs
Message-ID: <Y1Q2YqUFSxADWWtS@google.com>
References: <20221003232033.3404802-1-jstultz@google.com>
 <20221003232033.3404802-3-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003232033.3404802-3-jstultz@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 03, 2022 at 11:20:32PM +0000, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> In certain audio use cases, scheduling RT threads on cores that
> are handling softirqs can lead to glitches. Prevent this
> behavior in cases where the softirq is likely to take a long
> time. To avoid unnecessary migrations, the old behavior is
> preserved for RCU, SCHED and TIMER irqs which are expected to be
> relatively quick.
> 
> This patch reworks and combines two related changes originally
> by John Dias <joaodias@google.com>
[..]
> ---
> v2:
> * Reformatted Kconfig entry to match coding style
>   (Reported-by: Randy Dunlap <rdunlap@infradead.org>)
> * Made rt_task_fits_capacity_and_may_preempt static to
>   avoid warnings (Reported-by: kernel test robot <lkp@intel.com>)
> * Rework to use preempt_count and drop kconfig dependency on ARM64
> v3:
> * Use introduced __cpu_softirq_pending() to avoid s390 build
>   issues (Reported-by: kernel test robot <lkp@intel.com>)
> v4:
> * Drop TASKLET_SOFTIRQ from LONG_SOFTIRQS (suggested by Qais)
> * Depend on !PREEMPT_RT (Suggested by Qais)
> * Larger simplification of logic (suggested by Qais)
> * Rework LONG_SOFTIRQS to use BIT() macros
> * Rename task_may_preempt() to cpu_busy_with_softirqs()
> ---
>  include/linux/interrupt.h |  6 ++++
>  init/Kconfig              | 10 +++++++
>  kernel/sched/rt.c         | 61 +++++++++++++++++++++++++++++++++------
>  kernel/softirq.c          |  9 ++++++
>  4 files changed, 77 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index a749a8663841..e3a4add67e8c 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -582,6 +582,11 @@ enum
>   * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
>   */
>  #define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
> +/* Softirq's where the handling might be long: */
> +#define LONG_SOFTIRQ_MASK (BIT(NET_TX_SOFTIRQ)    | \
> +			   BIT(NET_RX_SOFTIRQ)    | \
> +			   BIT(BLOCK_SOFTIRQ)     | \
> +			   BIT(IRQ_POLL_SOFTIRQ))

Instead of a mask, I wonder if a better approach is to have a heuristic based
on measurement of softirq load. There is already code to measure irq load
(see update_irq_load_avg). Perhaps, Vincent would be willing to add the
softirq load in it as well if asked nicely ;)

That's much better because:
1. Any new softirqs added will also trigger this optimization.
2. Systems where these softirqs are quiet will not unnecessarily trigger it.
3. You can also include irq load so that things like IRQ storms also don't
cause RT issues (when there are better "uncompromised" idle CPU candidates).
4. may not be need CONFIG option at all if the optimization makes
sense for everything. Think all the systems not running Android.

>  /* map softirq index to softirq name. update 'softirq_to_name' in
>   * kernel/softirq.c when adding a new softirq.
> @@ -617,6 +622,7 @@ extern void raise_softirq_irqoff(unsigned int nr);
>  extern void raise_softirq(unsigned int nr);
>  
>  DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
> +DECLARE_PER_CPU(u32, active_softirqs);
>  
>  static inline struct task_struct *this_cpu_ksoftirqd(void)
>  {
> diff --git a/init/Kconfig b/init/Kconfig
> index 532362fcfe31..3d1de6edcfa1 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1284,6 +1284,16 @@ config SCHED_AUTOGROUP
>  	  desktop applications.  Task group autogeneration is currently based
>  	  upon task session.
>  
> +config RT_SOFTIRQ_OPTIMIZATION

I much dislike this config option name because it does not self-explain what
the option is and it is too long. More so, any future such optimizations,
even if rare, will have to come up with another name causing more confusion.
Instead, CONFIG_RT_AVOID_SOFTIRQS seems cleaner, but I'll defer to scheduler
maintainers since they have to take the patch ultimately. Though I'll give my
tag for a rename / better name. More below:

> +	bool "Improve RT scheduling during long softirq execution"
> +	depends on SMP && !PREEMPT_RT
> +	default n
> +	help
> +	  Enable an optimization which tries to avoid placing RT tasks on CPUs
> +	  occupied by nonpreemptible tasks, such as a long softirq or CPUs
> +	  which may soon block preemptions, such as a CPU running a ksoftirq
> +	  thread which handles slow softirqs.
> +
>  config SYSFS_DEPRECATED
>  	bool "Enable deprecated sysfs features to support old userspace tools"
>  	depends on SYSFS
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 55f39c8f4203..3c628db807c8 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1599,6 +1599,44 @@ static void yield_task_rt(struct rq *rq)
>  #ifdef CONFIG_SMP
>  static int find_lowest_rq(struct task_struct *task);
>  
> +#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
> +#define __use_softirq_opt 1

Why not just use IS_ENABLED(CONFIG_RT_SOFTIRQ_OPT..) instead of defining new
macros?

> + * Return whether the given cpu is currently non-preemptible
> + * while handling a potentially long softirq, or if the current
> + * task is likely to block preemptions soon because it is a
> + * ksoftirq thread that is handling slow softirq.
> + */
> +static bool cpu_busy_with_softirqs(int cpu)
> +{
> +	u32 softirqs = per_cpu(active_softirqs, cpu) |
> +		       __cpu_softirq_pending(cpu);
> +	struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
> +	struct task_struct *curr;
> +	struct rq *rq = cpu_rq(cpu);
> +	int ret;
> +
> +	rcu_read_lock();

Could you clarify what is the RCU read-side critical section protecting?

> +	curr = READ_ONCE(rq->curr); /* unlocked access */
> +	ret = (softirqs & LONG_SOFTIRQ_MASK) &&
> +		 (curr == cpu_ksoftirqd ||
> +		  preempt_count() & SOFTIRQ_MASK);

If the goal is to avoid ksoftirqd when it is running an actual softirq,
doesn't ksoftirqd already run softirqs under local_bh_disable()? If so, then
SOFTIRQ_MASK should already be set. If ksoftirqd is in between softirqs (and
bh is enabled there), then scheduling the RT task on the CPU may preempt
ksoftirqd and give the RT task a chance to run anyway, right?.

> +	rcu_read_unlock();
> +	return ret;
> +}
> +#else
> +#define __use_softirq_opt 0

define not needed if using IS_ENABLED.

more comments later :)

thanks,

 - Joel


> +static bool cpu_busy_with_softirqs(int cpu)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
> +
> +static bool rt_task_fits_cpu(struct task_struct *p, int cpu)
> +{
> +	return !cpu_busy_with_softirqs(cpu) && rt_task_fits_capacity(p, cpu);
> +}
> +
>  static int
>  select_task_rq_rt(struct task_struct *p, int cpu, int flags)
>  {
> @@ -1637,22 +1675,24 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
>  	 * This test is optimistic, if we get it wrong the load-balancer
>  	 * will have to sort it out.
>  	 *
> -	 * We take into account the capacity of the CPU to ensure it fits the
> -	 * requirement of the task - which is only important on heterogeneous
> -	 * systems like big.LITTLE.
> +	 * We use rt_task_fits_cpu() to evaluate if the CPU is busy with
> +	 * potentially long-running softirq work, as well as take into
> +	 * account the capacity of the CPU to ensure it fits the
> +	 * requirement of the task - which is only important on
> +	 * heterogeneous systems like big.LITTLE.
>  	 */
>  	test = curr &&
>  	       unlikely(rt_task(curr)) &&
>  	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
>  
> -	if (test || !rt_task_fits_capacity(p, cpu)) {
> +	if (test || !rt_task_fits_cpu(p, cpu)) {
>  		int target = find_lowest_rq(p);
>  
>  		/*
>  		 * Bail out if we were forcing a migration to find a better
>  		 * fitting CPU but our search failed.
>  		 */
> -		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
> +		if (!test && target != -1 && !rt_task_fits_cpu(p, target))
>  			goto out_unlock;
>  
>  		/*
> @@ -1894,14 +1934,17 @@ static int find_lowest_rq(struct task_struct *task)
>  		return -1; /* No other targets possible */
>  
>  	/*
> -	 * If we're on asym system ensure we consider the different capacities
> -	 * of the CPUs when searching for the lowest_mask.
> +	 * If we're using the softirq optimization or if we are
> +	 * on asym system, ensure we consider the softirq processing
> +	 * or different capacities of the CPUs when searching for the
> +	 * lowest_mask.
>  	 */
> -	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +	if (__use_softirq_opt ||

replace with IS_ENABLED.

> +	    static_branch_unlikely(&sched_asym_cpucapacity)) {
>  
>  		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
>  					  task, lowest_mask,
> -					  rt_task_fits_capacity);
> +					  rt_task_fits_cpu);
>  	} else {
>  
>  		ret = cpupri_find(&task_rq(task)->rd->cpupri,
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..35ee79dd8786 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -60,6 +60,13 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
>  
>  DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
>  
> +/*
> + * active_softirqs -- per cpu, a mask of softirqs that are being handled,
> + * with the expectation that approximate answers are acceptable and therefore
> + * no synchronization.
> + */
> +DEFINE_PER_CPU(u32, active_softirqs);
> +
>  const char * const softirq_to_name[NR_SOFTIRQS] = {
>  	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
>  	"TASKLET", "SCHED", "HRTIMER", "RCU"
> @@ -551,6 +558,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  restart:
>  	/* Reset the pending bitmask before enabling irqs */
>  	set_softirq_pending(0);
> +	__this_cpu_write(active_softirqs, pending);
>  
>  	local_irq_enable();
>  
> @@ -580,6 +588,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  		pending >>= softirq_bit;
>  	}
>  
> +	__this_cpu_write(active_softirqs, 0);
>  	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
>  	    __this_cpu_read(ksoftirqd) == current)
>  		rcu_softirq_qs();
> -- 
> 2.38.0.rc1.362.ged0d419d3c-goog
> 
