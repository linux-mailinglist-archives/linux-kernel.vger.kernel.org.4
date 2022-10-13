Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2BE5FD3D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 06:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJMEaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 00:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJMEaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 00:30:16 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAC18BB96
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:30:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id 8so416452ilj.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 21:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OEJ4dYV4+wnU5uEbW0h8AeQr5ak0EOPYUwNNv98kTx4=;
        b=hDyf5PTqfzZOS0iQSaSOP+bJeJY62qM0YAEy4HvFsViICUpwMUvBl+W4cNGFSO/T4f
         kO3KAeh4PpljeJz5OPXOLW6DkXJGLPhtu5QGMX09ri6nh0OD8N7siAbYU3cLAD0tGkqu
         EjJ9+lHfRK5VPxkonlRI2xP4zn+PnzKYNVHpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEJ4dYV4+wnU5uEbW0h8AeQr5ak0EOPYUwNNv98kTx4=;
        b=OLtF9zzlN3twtFsykjUcsXnK6p/BiY64mVXzfVWtI1PYdU9IcsVWStHBQ+JYZI0zUs
         7uKytMWr4XAzfOge9NWMu8+G8PPQbnOeqC9YO6nd0oQyw5eH2+4c5zByKX4JV0iKr3Pc
         JkwDIi6Ji2omq4/jYl0E4r5M8JDK7FTo49DQN9kX5jDV2s1w0HzBZ6+k5Gf1RiAngCq5
         1Y50DQlu24lJ3S6Ps775y4C0c3ExXNVcBQGVc9xsqxqJsc4J7f1LBiapVmZvStdK+p8K
         ixhwXSdDsic+z0qujYrG23/WP4FdWo5q2ldXzdOvQIVwr6K7MtpX99im1ROzQDCrWBsQ
         WWxA==
X-Gm-Message-State: ACrzQf056AjlhCzfX/eKQW0iwiszDKmjU/TgiR4VHq1RCZ76IeVq+Mrd
        xus2sYRQWEvjFBO7HHvZwqj/akGquX3DysmnujW6vA==
X-Google-Smtp-Source: AMsMyM67IZ2hPzQTKYm1SL8L/e900kvsm5LPmzDay94vl9GaRRn+cyqsDl3P7LX83wnpTXTRV/blSAvRPZUw9PhPbQE=
X-Received: by 2002:a05:6e02:164c:b0:2fc:7179:bc41 with SMTP id
 v12-20020a056e02164c00b002fc7179bc41mr7565468ilu.190.1665635413543; Wed, 12
 Oct 2022 21:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-5-connoro@google.com>
In-Reply-To: <20221003214501.2050087-5-connoro@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 13 Oct 2022 00:30:02 -0400
Message-ID: <CAEXW_YRSj3T7MY1qu=hy7+Wf=p34bBKnCLfE7vMJUmFbg0wCKA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/11] locking/mutex: make mutex::wait_lock irq safe
To:     "Connor O'Brien" <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 3, 2022 at 5:45 PM Connor O'Brien <connoro@google.com> wrote:
>
> From: Juri Lelli <juri.lelli@redhat.com>
>
> mutex::wait_lock might be nested under rq->lock.
>
> Make it irq safe then.

Hi Juri, can you give an example where not doing this is an issue?

When nested under rq->lock, interrupts should already be disabled,
otherwise try_to_wake_up() from an interrupt can cause a deadlock no?
Then, why do you need this patch?

Thanks.



> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20181009092434.26221-7-juri.lelli@redhat.com
> [rebase & fix {un,}lock_wait_lock helpers in ww_mutex.h]
> Signed-off-by: Connor O'Brien <connoro@google.com>
> ---
>  kernel/locking/mutex.c    | 18 ++++++++++--------
>  kernel/locking/ww_mutex.h | 22 ++++++++++++----------
>  2 files changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 7800380219db..f39e9ee3c4d0 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -572,6 +572,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  {
>         struct mutex_waiter waiter;
>         struct ww_mutex *ww;
> +       unsigned long flags;
>         int ret;
>
>         if (!use_ww_ctx)
> @@ -614,7 +615,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>                 return 0;
>         }
>
> -       raw_spin_lock(&lock->wait_lock);
> +       raw_spin_lock_irqsave(&lock->wait_lock, flags);
>         /*
>          * After waiting to acquire the wait_lock, try again.
>          */
> @@ -676,7 +677,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>                                 goto err;
>                 }
>
> -               raw_spin_unlock(&lock->wait_lock);
> +               raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>                 if (ww_ctx)
>                         ww_ctx_wake(ww_ctx);
>                 schedule_preempt_disabled();
> @@ -703,9 +704,9 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>                         trace_contention_begin(lock, LCB_F_MUTEX);
>                 }
>
> -               raw_spin_lock(&lock->wait_lock);
> +               raw_spin_lock_irqsave(&lock->wait_lock, flags);
>         }
> -       raw_spin_lock(&lock->wait_lock);
> +       raw_spin_lock_irqsave(&lock->wait_lock, flags);
>  acquired:
>         __set_current_state(TASK_RUNNING);
>
> @@ -732,7 +733,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>         if (ww_ctx)
>                 ww_mutex_lock_acquired(ww, ww_ctx);
>
> -       raw_spin_unlock(&lock->wait_lock);
> +       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>         if (ww_ctx)
>                 ww_ctx_wake(ww_ctx);
>         preempt_enable();
> @@ -743,7 +744,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>         __mutex_remove_waiter(lock, &waiter);
>  err_early_kill:
>         trace_contention_end(lock, ret);
> -       raw_spin_unlock(&lock->wait_lock);
> +       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>         debug_mutex_free_waiter(&waiter);
>         mutex_release(&lock->dep_map, ip);
>         if (ww_ctx)
> @@ -915,6 +916,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>         struct task_struct *next = NULL;
>         DEFINE_WAKE_Q(wake_q);
>         unsigned long owner;
> +       unsigned long flags;
>
>         mutex_release(&lock->dep_map, ip);
>
> @@ -941,7 +943,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>                 }
>         }
>
> -       raw_spin_lock(&lock->wait_lock);
> +       raw_spin_lock_irqsave(&lock->wait_lock, flags);
>         debug_mutex_unlock(lock);
>         if (!list_empty(&lock->wait_list)) {
>                 /* get the first entry from the wait-list: */
> @@ -959,7 +961,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
>                 __mutex_handoff(lock, next);
>
>         preempt_disable();
> -       raw_spin_unlock(&lock->wait_lock);
> +       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>
>         wake_up_q(&wake_q);
>         preempt_enable();
> diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
> index dfc174cd96c6..7edd55d10f87 100644
> --- a/kernel/locking/ww_mutex.h
> +++ b/kernel/locking/ww_mutex.h
> @@ -70,14 +70,14 @@ __ww_mutex_has_waiters(struct mutex *lock)
>         return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
>  }
>
> -static inline void lock_wait_lock(struct mutex *lock)
> +static inline void lock_wait_lock(struct mutex *lock, unsigned long *flags)
>  {
> -       raw_spin_lock(&lock->wait_lock);
> +       raw_spin_lock_irqsave(&lock->wait_lock, *flags);
>  }
>
> -static inline void unlock_wait_lock(struct mutex *lock)
> +static inline void unlock_wait_lock(struct mutex *lock, unsigned long flags)
>  {
> -       raw_spin_unlock(&lock->wait_lock);
> +       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
>  }
>
>  static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
> @@ -144,14 +144,14 @@ __ww_mutex_has_waiters(struct rt_mutex *lock)
>         return rt_mutex_has_waiters(&lock->rtmutex);
>  }
>
> -static inline void lock_wait_lock(struct rt_mutex *lock)
> +static inline void lock_wait_lock(struct rt_mutex *lock, unsigned long *flags)
>  {
> -       raw_spin_lock(&lock->rtmutex.wait_lock);
> +       raw_spin_lock_irqsave(&lock->rtmutex.wait_lock, *flags);
>  }
>
> -static inline void unlock_wait_lock(struct rt_mutex *lock)
> +static inline void unlock_wait_lock(struct rt_mutex *lock, flags)
>  {
> -       raw_spin_unlock(&lock->rtmutex.wait_lock);
> +       raw_spin_unlock_irqrestore(&lock->rtmutex.wait_lock, flags);
>  }
>
>  static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
> @@ -382,6 +382,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
>  static __always_inline void
>  ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>  {
> +       unsigned long flags;
> +
>         ww_mutex_lock_acquired(lock, ctx);
>
>         /*
> @@ -409,9 +411,9 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
>          * Uh oh, we raced in fastpath, check if any of the waiters need to
>          * die or wound us.
>          */
> -       lock_wait_lock(&lock->base);
> +       lock_wait_lock(&lock->base, &flags);
>         __ww_mutex_check_waiters(&lock->base, ctx);
> -       unlock_wait_lock(&lock->base);
> +       unlock_wait_lock(&lock->base, flags);
>  }
>
>  static __always_inline int
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
