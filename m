Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82E6E590A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDRGAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjDRGAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:00:07 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CBF59ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:00:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7606d443bb2so84251139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681797604; x=1684389604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=adWNmACrjTjLUOrq3mP+DTglX7NsCpqXsSoz7wdnwK4=;
        b=ggyPiDKFKe9eCE9iwSEYkrcvCdBLu1APW6yYLB2vg3jsszsLrhRGNN492pIrQuBMH3
         baC3K/OOSy9L0r8uF/zgNF/I8E9gX270z1Ua/DWQjhgYrnkQQzyWZppx++/6Jq7re+7N
         gt0Wf6GC8S8qwZfar81c2wy1XmnjsOrkVCaz1KMugB59kDfZzISKxw2mLjDvwYhzZubw
         QugglExfv5v/R3k8pIcsEvaRCkEuvVM4bnLrQqbLkk/rgzKiiAyKvO4Euh1Jxi6Ob0EU
         in9mskhqK2QiPclSzrB0IbVRIcS2t/xQ2mxiOWsSFPh0ZtSisS3Q5g+n00SI6PTaoMRn
         25LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797604; x=1684389604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adWNmACrjTjLUOrq3mP+DTglX7NsCpqXsSoz7wdnwK4=;
        b=DRk6cr9DnZ+SshIz0dH4ujqS/fJTE4mBGhAbMGPSS/1OqYHaik4t19PfuQw5sBw7hn
         4ZtDrPGa6bW6qumnIbrghZ6r3cm2b4z97o8ukxN9IHb/5HesKeJBxkfcJtB+QNQMtZQb
         vZWBXh4sPHtlyGQiNbfQ5DCvZmuHZQSpEB10pw2fhddm+C5+6b2DWBCjwpbNAo5tb4Pn
         dq0yHoE+AqKkl9KOkxyIVQ9BBEX6U5qh4NB30HrEa1NgtUY3n/dGaE5gBy+EbNSmNzMI
         l6B6IEBEF8CxUA4qJRKsRLX4EQMvRhdR/Prow2iztCMpQU8hr1SLcKyA2Y1vRYbmhLU7
         f5vQ==
X-Gm-Message-State: AAQBX9flRfhDaMiSk5UXw+IWyt3L8nWyM3SSI0BhWa1Dtqd4FZEGJrZt
        dXbDiUYln2dr3PDlupM3lNuK66I2SE4xeFerNGnEKw==
X-Google-Smtp-Source: AKy350ZHUyao8ZHnHn5Qqrz4VzbdRgJUrmsZDxz5UA8gKjjMg6morBz4P9s0pNjldlJgDUfgzx9tXlEKcoAV/4+YNoI=
X-Received: by 2002:a6b:4f08:0:b0:761:b329:535f with SMTP id
 d8-20020a6b4f08000000b00761b329535fmr1157257iob.4.1681797604396; Mon, 17 Apr
 2023 23:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <87h6tsred7.ffs@tglx> <874jpsqdy1.ffs@tglx> <ZDADdMnY0oW2k5BV@lothringen>
 <87lej3twhv.ffs@tglx> <ZDBin2ZQwc69hGX4@lothringen> <87ile7trv7.ffs@tglx>
 <CANpmjNOFxGa6iuVbzVcXPyWO-6Zmd=edhatmDBHPKcZ-au35dg@mail.gmail.com> <87zg764ojw.ffs@tglx>
In-Reply-To: <87zg764ojw.ffs@tglx>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Apr 2023 08:00:00 +0200
Message-ID: <CANpmjNNJC=hZ+Tk3_XNx2ZTvs27+NtSdv0CApKKvJRgHGCsx4w@mail.gmail.com>
Subject: Re: [PATCH] posix-cpu-timers: Implement the missing
 timer_wait_running callback
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 at 15:37, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> For some unknown reason the introduction of the timer_wait_running callback
> missed to fixup posix CPU timers, which went unnoticed for almost four years.
> Marco reported recently that the WARN_ON() in timer_wait_running()
> triggers with a posix CPU timer test case.
>
> Posix CPU timers have two execution models for expiring timers depending on
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK:
>
> 1) If not enabled, the expiry happens in hard interrupt context so
>    spin waiting on the remote CPU is reasonably time bound.
>
>    Implement an empty stub function for that case.
>
> 2) If enabled, the expiry happens in task work before returning to user
>    space or guest mode. The expired timers are marked as firing and moved
>    from the timer queue to a local list head with sighand lock held. Once
>    the timers are moved, sighand lock is dropped and the expiry happens in
>    fully preemptible context. That means the expiring task can be scheduled
>    out, migrated, interrupted etc. So spin waiting on it is more than
>    suboptimal.
>
>    The timer wheel has a timer_wait_running() mechanism for RT, which uses
>    a per CPU timer-base expiry lock which is held by the expiry code and the
>    task waiting for the timer function to complete blocks on that lock.
>
>    This does not work in the same way for posix CPU timers as there is no
>    timer base and expiry for process wide timers can run on any task
>    belonging to that process, but the concept of waiting on an expiry lock
>    can be used too in a slightly different way:
>
>     - Add a mutex to struct posix_cputimers_work. This struct is per task
>       and used to schedule the expiry task work from the timer interrupt.
>
>     - Add a task_struct pointer to struct cpu_timer which is used to store
>       a the task which runs the expiry. That's filled in when the task
>       moves the expired timers to the local expiry list. That's not
>       affecting the size of the k_itimer union as there are bigger union
>       members already
>
>     - Let the task take the expiry mutex around the expiry function
>
>     - Let the waiter acquire a task reference with rcu_read_lock() held and
>       block on the expiry mutex
>
>    This avoids spin-waiting on a task which might not even be on a CPU and
>    works nicely for RT too.
>
> Reported-by: Marco Elver <elver@google.com>

Tested-by: Marco Elver <elver@google.com>

Thanks!

> Fixes: ec8f954a40da ("posix-timers: Use a callback for cancel synchronization on PREEMPT_RT")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/posix-timers.h   |    7 +++
>  kernel/time/posix-cpu-timers.c |   81 +++++++++++++++++++++++++++++++++--------
>  kernel/time/posix-timers.c     |    4 ++
>  3 files changed, 77 insertions(+), 15 deletions(-)
>
> --- a/include/linux/posix-timers.h
> +++ b/include/linux/posix-timers.h
> @@ -4,6 +4,7 @@
>
>  #include <linux/spinlock.h>
>  #include <linux/list.h>
> +#include <linux/mutex.h>
>  #include <linux/alarmtimer.h>
>  #include <linux/timerqueue.h>
>
> @@ -62,9 +63,10 @@ static inline int clockid_to_fd(const cl
>   * cpu_timer - Posix CPU timer representation for k_itimer
>   * @node:      timerqueue node to queue in the task/sig
>   * @head:      timerqueue head on which this timer is queued
> - * @task:      Pointer to target task
> + * @pid:       Pointer to target task PID
>   * @elist:     List head for the expiry list
>   * @firing:    Timer is currently firing
> + * @handling:  Pointer to the task which handles expiry
>   */
>  struct cpu_timer {
>         struct timerqueue_node  node;
> @@ -72,6 +74,7 @@ struct cpu_timer {
>         struct pid              *pid;
>         struct list_head        elist;
>         int                     firing;
> +       struct task_struct      *handling;
>  };
>
>  static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
> @@ -135,10 +138,12 @@ struct posix_cputimers {
>  /**
>   * posix_cputimers_work - Container for task work based posix CPU timer expiry
>   * @work:      The task work to be scheduled
> + * @mutex:     Mutex held around expiry in context of this task work
>   * @scheduled:  @work has been scheduled already, no further processing
>   */
>  struct posix_cputimers_work {
>         struct callback_head    work;
> +       struct mutex            mutex;
>         unsigned int            scheduled;
>  };
>
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -846,6 +846,8 @@ static u64 collect_timerqueue(struct tim
>                         return expires;
>
>                 ctmr->firing = 1;
> +               /* See posix_cpu_timer_wait_running() */
> +               WRITE_ONCE(ctmr->handling, current);
>                 cpu_timer_dequeue(ctmr);
>                 list_add_tail(&ctmr->elist, firing);
>         }
> @@ -1161,7 +1163,49 @@ static void handle_posix_cpu_timers(stru
>  #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
>  static void posix_cpu_timers_work(struct callback_head *work)
>  {
> +       struct posix_cputimers_work *cw = container_of(work, typeof(*cw), work);
> +
> +       mutex_lock(&cw->mutex);
>         handle_posix_cpu_timers(current);
> +       mutex_unlock(&cw->mutex);
> +}
> +
> +/*
> + * Invoked from the posix-timer core when a cancel operation failed because
> + * the timer is marked firing. The caller holds rcu_read_lock(), which
> + * protects the timer and the task which is expiring it from being freed.
> + */
> +static void posix_cpu_timer_wait_running(struct k_itimer *timr)
> +{
> +       struct task_struct *tsk = READ_ONCE(timr->it.cpu.handling);
> +
> +       /* Has the handling task completed expiry already? */
> +       if (!tsk)
> +               return;
> +
> +       /* Ensure that the task cannot go away */
> +       get_task_struct(tsk);
> +       /* Now drop the RCU protection so the mutex can be locked */
> +       rcu_read_unlock();
> +       /* Wait on the expiry mutex */
> +       mutex_lock(&tsk->posix_cputimers_work.mutex);
> +       /* Release it immediately again. */
> +       mutex_unlock(&tsk->posix_cputimers_work.mutex);
> +       /* Drop the task reference. */
> +       put_task_struct(tsk);
> +       /* Relock RCU so the callsite is balanced */
> +       rcu_read_lock();
> +}
> +
> +static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
> +{
> +       /* Ensure that timr->it.cpu.handling task cannot go away */
> +       rcu_read_lock();
> +       spin_unlock_irq(&timr->it_lock);
> +       posix_cpu_timer_wait_running(timr);
> +       rcu_read_unlock();
> +       /* @timr is on stack and is valid */
> +       spin_lock_irq(&timr->it_lock);
>  }
>
>  /*
> @@ -1177,6 +1221,7 @@ void clear_posix_cputimers_work(struct t
>                sizeof(p->posix_cputimers_work.work));
>         init_task_work(&p->posix_cputimers_work.work,
>                        posix_cpu_timers_work);
> +       mutex_init(&p->posix_cputimers_work.mutex);
>         p->posix_cputimers_work.scheduled = false;
>  }
>
> @@ -1255,6 +1300,18 @@ static inline void __run_posix_cpu_timer
>         lockdep_posixtimer_exit();
>  }
>
> +static void posix_cpu_timer_wait_running(struct k_itimer *timr)
> +{
> +       cpu_relax();
> +}
> +
> +static void posix_cpu_timer_wait_running_nsleep(struct k_itimer *timr)
> +{
> +       spin_unlock_irq(&timer.it_lock);
> +       cpu_relax();
> +       spin_lock_irq(&timer.it_lock);
> +}
> +
>  static inline bool posix_cpu_timers_work_scheduled(struct task_struct *tsk)
>  {
>         return false;
> @@ -1363,6 +1420,8 @@ static void handle_posix_cpu_timers(stru
>                  */
>                 if (likely(cpu_firing >= 0))
>                         cpu_timer_fire(timer);
> +               /* See posix_cpu_timer_wait_running() */
> +               WRITE_ONCE(timer->it.cpu.handling, NULL);
>                 spin_unlock(&timer->it_lock);
>         }
>  }
> @@ -1497,23 +1556,16 @@ static int do_cpu_nanosleep(const clocki
>                 expires = cpu_timer_getexpires(&timer.it.cpu);
>                 error = posix_cpu_timer_set(&timer, 0, &zero_it, &it);
>                 if (!error) {
> -                       /*
> -                        * Timer is now unarmed, deletion can not fail.
> -                        */
> +                       /* Timer is now unarmed, deletion can not fail. */
>                         posix_cpu_timer_del(&timer);
> +               } else {
> +                       while (error == TIMER_RETRY) {
> +                               posix_cpu_timer_wait_running_nsleep(&timer);
> +                               error = posix_cpu_timer_del(&timer);
> +                       }
>                 }
> -               spin_unlock_irq(&timer.it_lock);
>
> -               while (error == TIMER_RETRY) {
> -                       /*
> -                        * We need to handle case when timer was or is in the
> -                        * middle of firing. In other cases we already freed
> -                        * resources.
> -                        */
> -                       spin_lock_irq(&timer.it_lock);
> -                       error = posix_cpu_timer_del(&timer);
> -                       spin_unlock_irq(&timer.it_lock);
> -               }
> +               spin_unlock_irq(&timer.it_lock);
>
>                 if ((it.it_value.tv_sec | it.it_value.tv_nsec) == 0) {
>                         /*
> @@ -1623,6 +1675,7 @@ const struct k_clock clock_posix_cpu = {
>         .timer_del              = posix_cpu_timer_del,
>         .timer_get              = posix_cpu_timer_get,
>         .timer_rearm            = posix_cpu_timer_rearm,
> +       .timer_wait_running     = posix_cpu_timer_wait_running,
>  };
>
>  const struct k_clock clock_process = {
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -846,6 +846,10 @@ static struct k_itimer *timer_wait_runni
>         rcu_read_lock();
>         unlock_timer(timer, *flags);
>
> +       /*
> +        * kc->timer_wait_running() might drop RCU lock. So @timer
> +        * cannot be touched anymore after the function returns!
> +        */
>         if (!WARN_ON_ONCE(!kc->timer_wait_running))
>                 kc->timer_wait_running(timer);
>
