Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088E6515B8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbiLSWzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLSWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:54:58 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEED12751;
        Mon, 19 Dec 2022 14:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671490497; x=1703026497;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nlBy/Wb2Wx6aw3SvxbdUtVsHvy92Mw6bMWw1vuINoxI=;
  b=Ejm/lz9odrxETODUMxuzP0QZsEKwFkWml/gCiLAG0WxkPw4cSYXxYCWT
   AaJ58NJMMdpAFv/2tVml9je10V2KeLb2hacrqOuDm16kX0KO/litYmgZ2
   kNXWOmOezZGBtp8wrwwNb2zuzz6zGZfUc0STyq70pmdTMaQbgehHqT2j8
   NxbMYS4X7Qu7WUpkNdp8Hjwac78outIXHiUdm6cqvDKbgPsGPgVBqiAxV
   yTAiA6nTvX/0uqG6MI2lBcT3S6270cgi42nimZZUmt9dFXq7f+YxKovei
   xuAirik0dclceY9Qc2OBh2BRHht3T/hx+cKjDX0GbnkYiROOED9/TkNLO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="302891184"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="302891184"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 14:54:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="652887646"
X-IronPort-AV: E=Sophos;i="5.96,257,1665471600"; 
   d="scan'208";a="652887646"
Received: from jiwooksh-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.85.161])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 14:54:55 -0800
Message-ID: <5ae0d53990c29aa25648cbf32ef3b16e9bec911c.camel@linux.intel.com>
Subject: Re: [RFC/RFT PATCH 1/2] sched/core: Check and schedule ksoftirq
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 19 Dec 2022 14:54:55 -0800
In-Reply-To: <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
         <20221215184300.1592872-2-srinivas.pandruvada@linux.intel.com>
         <Y5xURk3CkzhIjmmq@hirez.programming.kicks-ass.net>
         <20221216220748.GA1967978@lothringen>
         <Y6BMAp6A731F8ZL4@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-19 at 12:33 +0100, Peter Zijlstra wrote:
> On Fri, Dec 16, 2022 at 11:07:48PM +0100, Frederic Weisbecker wrote:
> > On Fri, Dec 16, 2022 at 12:19:34PM +0100, Peter Zijlstra wrote:
> > > On Thu, Dec 15, 2022 at 10:42:59AM -0800, Srinivas Pandruvada
> > > wrote:
> > > > +               /* Give ksoftirqd 1 jiffy to get a chance to
> > > > start its job */
> > > > +               if (!READ_ONCE(it.done) &&
> > > > task_is_running(__this_cpu_read(ksoftirqd))) {
> > > > +                       __set_current_state(TASK_UNINTERRUPTIBL
> > > > E);
> > > > +                       schedule_timeout(1);
> > > > +               }
> > > 
> > > That's absolutely disgusting :-/
> > 
> > I know, and I hate checking
> > task_is_running(__this_cpu_read(ksoftirqd))
> > everywhere in idle. And in fact it doesn't work because some
> > cpuidle drivers
> > also do need_resched() checks.
> 
> quite a few indeed.
> 
> > I guess that either we assume that the idle injection is more
> > important
> > than serving softirqs and we shutdown the warnings accordingly, or
> > we arrange
> > for idle injection to have a lower prio than ksoftirqd.
> 
> ksoftirq is typically a CFS task while idle injection is required to
> be
> a FIFO (typically FIFO-1) task -- so that would require lifting
> ksoftirqd to FIFO and that has other problems.
> 
> I'm guessing the problem case is where idle injection comes in while
> ksoftirq is running (and preempted), because in that case you cannot
> run
> the softirq stuff in-place.
> 
> The 'right' thing to do would be to PI boost ksoftirqd in that case I
> suppose. Perhaps something like so, it would boost ksoftirq when it's
> running, and otherwise runs the ksoftirqd thing in-situ.
> 
> I've not really throught hard about this though, so perhaps I
> completely
> wrecked things.
Had to fix some compile issues in the patch but able to test. This
fixes the case when softirq is pending before play_idle(). For example:

<idle>-0[004]   254.440116: softirq_raise:   vec=9 [action=RCU]
<idle>-0[004]   254.440116: softirq_exit:    vec=9 [action=RCU]
<idle>-0[004]   254.440116: sched_waking:    comm=ksoftirqd/4 pid=41
prio=120 target_cpu=004
<idle>-0[004]   254.440117: sched_wakeup:    ksoftirqd/4:41 [120]<CANT
FIND FIELD success> CPU:004
<idle>-0[004]   254.440119: sched_switch:    swapper/4:0 [120] R ==>
kidle_inj/4:1180 [49]
kidle_inj/4-1180[004]   254.440120: sched_kthread_work_execute_start:
work struct 0xffffd1dcbfd25230: function clamp_idle_injection_func
kidle_inj/4-1180[004]   254.440121: play_idle_enter: state=24000000
cpu_id=4
kidle_inj/4-1180[004]   254.440122: bputs: __run_ksoftirqd: running
from play_idle

"calliing __do_softirq() here"

kidle_inj/4-1180[004]   254.440122: softirq_entry:   vec=9 [action=RCU]
kidle_inj/4-1180[004]   254.440125: softirq_raise:   vec=9 [action=RCU]
kidle_inj/4-1180[004]   254.440126: softirq_exit:    vec=9 [action=RCU]

But after ksoftirqd_run_end(), which will renable local irq, this may
further cause more soft irq pending. Here RCU soft irq entry continues


kidle_inj/4-1180  [004]254.440141: softirq_exit:    vec=9 [action=RCU]
kidle_inj/4-1180  [004]254.440141: softirq_entry:   vec=9 [action=RCU]
kidle_inj/4-1180  [004]254.440143: softirq_raise:   vec=9 [action=RCU]
kidle_inj/4-1180  [004]254.440143: softirq_exit:    vec=9 [action=RCU]
kidle_inj/4-1180  [004]254.440144: bputs: can_stop_idle_tick.isra.0:
soft irq pending

Another warning above.


This log is with ping test.

Adding additional __run_ksoftirqd(), inside do_idle()  while
(!need_resched()) doesn't help.

If we add check to can_stop_idle_tick() before reporting helps. But
since __do_softirq() can't guarantee that there are no pending soft
irqs, it still have chance to get another warning.
 
Thanks,
Srinivas

> 
> 
> ---
>  include/linux/interrupt.h   |  3 +++
>  kernel/sched/build_policy.c |  1 +
>  kernel/sched/idle.c         |  4 ++++
>  kernel/softirq.c            | 20 +++++++++++++++++---
>  4 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index a92bce40b04b..a2db811d6947 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -606,6 +606,9 @@ extern void raise_softirq_irqoff(unsigned int
> nr);
>  extern void raise_softirq(unsigned int nr);
>  
>  DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
> +DECLARE_PER_CPU(struct rt_mutex, ksoftirq_lock);
> +
> +extern bool __run_ksoftirqd(unsigned int cpu);
>  
>  static inline struct task_struct *this_cpu_ksoftirqd(void)
>  {
> diff --git a/kernel/sched/build_policy.c
> b/kernel/sched/build_policy.c
> index d9dc9ab3773f..731c595e551c 100644
> --- a/kernel/sched/build_policy.c
> +++ b/kernel/sched/build_policy.c
> @@ -28,6 +28,7 @@
>  #include <linux/suspend.h>
>  #include <linux/tsacct_kern.h>
>  #include <linux/vtime.h>
> +#include <linux/interrupt.h>
>  
>  #include <uapi/linux/sched/types.h>
>  
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index f26ab2675f7d..093bfdfca2f1 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -370,6 +370,10 @@ void play_idle_precise(u64 duration_ns, u64
> latency_ns)
>         WARN_ON_ONCE(!duration_ns);
>         WARN_ON_ONCE(current->mm);
>  
> +       rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
> +       __run_ksoftirqd(smp_processor_id());
> +       rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
> +
>         rcu_sleep_check();
>         preempt_disable();
>         current->flags |= PF_IDLE;
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c8a6913c067d..a2cb600383a4 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -59,6 +59,7 @@ EXPORT_PER_CPU_SYMBOL(irq_stat);
>  static struct softirq_action softirq_vec[NR_SOFTIRQS]
> __cacheline_aligned_in_smp;
>  
>  DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
> +DEFINE_PER_CPU(struct rt_mutex, ksoftirq_lock);
>  
>  const char * const softirq_to_name[NR_SOFTIRQS] = {
>         "HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
> @@ -912,6 +913,7 @@ void __init softirq_init(void)
>                         &per_cpu(tasklet_vec, cpu).head;
>                 per_cpu(tasklet_hi_vec, cpu).tail =
>                         &per_cpu(tasklet_hi_vec, cpu).head;
> +               rt_mutex_init(&per_cpu(ksoftirq_mutex, cpu));
>         }
>  
>         open_softirq(TASKLET_SOFTIRQ, tasklet_action);
> @@ -923,7 +925,7 @@ static int ksoftirqd_should_run(unsigned int cpu)
>         return local_softirq_pending();
>  }
>  
> -static void run_ksoftirqd(unsigned int cpu)
> +bool __run_ksoftirqd(unsigned int cpu)
>  {
>         ksoftirqd_run_begin();
>         if (local_softirq_pending()) {
> @@ -933,10 +935,22 @@ static void run_ksoftirqd(unsigned int cpu)
>                  */
>                 __do_softirq();
>                 ksoftirqd_run_end();
> -               cond_resched();
> -               return;
> +               return true;
>         }
>         ksoftirqd_run_end();
> +       return false;
> +}
> +
> +static void run_ksoftirqd(unsigned int cpu)
> +{
> +       bool run;
> +
> +       rt_mutex_lock(&per_cpu(ksoftirq_lock, cpu));
> +       ran = __run_ksoftirqd(cpu);
> +       rt_mutex_unlock(&per_cpu(ksoftirq_lock, cpu));
> +
> +       if (ran)
> +               cond_resched();
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU

