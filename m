Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B069855B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBOUPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBOUPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:15:51 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E92597E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:15:50 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5331548edaaso1586617b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HidNewMfgCL/AbCu0ogQNhiw6e0hqOcAlP3xu28uaFk=;
        b=j1HVDiyUgDHt6WxfWz/10MGG7P+laj9pHWJdMCkvqltp763GkFissUWKZ8k0KtQUdJ
         L/jJ3mu43ukOClExUiyYbwPkhpLRmho5+vDyK/VmrwRE0+WAvMQtm0MyUh8rwyTAyUXz
         1JqAejb3S0fN5Jx+IPDjxyPOpEI0ZehTnybQf2CU4Be3OA5He8Ti58PlMAK5EiaTp63B
         /D3h8Rzy+7JPIpViU197424QzamBlb4L5cCwyviNdJQWCGpI1oQlOjLvjgY1rAE8vI0s
         +LR/FiV+Wpvw0cMl5PaW2IWWkk6n6XYuD+NoNRcuRREXKoNOENHFSIugRApVlrXvQ1n7
         2KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HidNewMfgCL/AbCu0ogQNhiw6e0hqOcAlP3xu28uaFk=;
        b=esfk+MLZ9B1mbg5u8gTQVhtDCw4EjPu7pqmT9xCrgnKVqQYrkZiGqI8ooCabk6Uuds
         mJWQaVBZ7fOq/m3nT9bKJF7ieBJNNIPl65d3Z9dn5H6k41z9+M7cv2AoaX7BwA5VOy31
         6MUOAnOcEd+h0To9JmznrI7Q7Jt+E9FlCjg+C4ilbLFW+HQDFccZSZXBHDt2pD/E3Fjr
         xJ2NSGfb1wSwMrRO5cb992b9Vz7ZHgOZAC0vmlQ2qXQT64rKGJLAgyCOuFiMDFviOS3A
         nCBwUruIFys6K57ztB3ortKt8SK0/irrQ0+3bjryADfkzlck51zgI+3+6FR/4jbla8pI
         0iPw==
X-Gm-Message-State: AO0yUKWYpBQLh17p4OqQxY1PAcjVOj9kD/gXspKLTAOME4QU4BbSQebG
        XC2Rdk0JzXFekN7ukbh6bp1wRjo4j8/xdPtRR8w=
X-Google-Smtp-Source: AK7set9hUeT5dDgeVOwX1fEc1zEZ8R08+CkW8+tupyb1S7Hnm0TeMovjgwyh76P6jYlpPoqyztk1+HfVhN/ovi52ssY=
X-Received: by 2002:a0d:e613:0:b0:52e:f3b5:1463 with SMTP id
 p19-20020a0de613000000b0052ef3b51463mr441367ywe.374.1676492148927; Wed, 15
 Feb 2023 12:15:48 -0800 (PST)
MIME-Version: 1.0
References: <20230202030429.3304875-1-avagin@google.com> <20230202030429.3304875-4-avagin@google.com>
In-Reply-To: <20230202030429.3304875-4-avagin@google.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 15 Feb 2023 12:15:37 -0800
Message-ID: <CANaxB-zp94AGT69ioK5JtwFf0K8r4-nzGt=J+pKe+jmWrVS0gg@mail.gmail.com>
Subject: Re: [PATCH 3/6] sched: add a few helpers to wake up tasks on the
 current cpu
To:     Andrei Vagin <avagin@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Could you take a look at this patch? I think I addressed comments that
you left to the previous version. Thanks.

On Wed, Feb 1, 2023 at 7:04 PM Andrei Vagin <avagin@google.com> wrote:
>
> Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
> up tasks on the current CPU.
>
> These two helpers are useful when the task needs to make a synchronous context
> switch to another task. In this context, synchronous means it wakes up the
> target task and falls asleep right after that.
>
> One example of such workloads is seccomp user notifies. This mechanism allows
> the  supervisor process handles system calls on behalf of a target process.
> While the supervisor is handling an intercepted system call, the target process
> will be blocked in the kernel, waiting for a response to come back.
>
> On-CPU context switches are much faster than regular ones.
>
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  include/linux/completion.h |  1 +
>  include/linux/swait.h      |  2 +-
>  include/linux/wait.h       |  3 +++
>  kernel/sched/completion.c  | 26 ++++++++++++++++++--------
>  kernel/sched/core.c        |  2 +-
>  kernel/sched/swait.c       |  8 ++++----
>  kernel/sched/wait.c        |  5 +++++
>  7 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/completion.h b/include/linux/completion.h
> index 62b32b19e0a8..fb2915676574 100644
> --- a/include/linux/completion.h
> +++ b/include/linux/completion.h
> @@ -116,6 +116,7 @@ extern bool try_wait_for_completion(struct completion *x);
>  extern bool completion_done(struct completion *x);
>
>  extern void complete(struct completion *);
> +extern void complete_on_current_cpu(struct completion *x);
>  extern void complete_all(struct completion *);
>
>  #endif
> diff --git a/include/linux/swait.h b/include/linux/swait.h
> index 6a8c22b8c2a5..d324419482a0 100644
> --- a/include/linux/swait.h
> +++ b/include/linux/swait.h
> @@ -146,7 +146,7 @@ static inline bool swq_has_sleeper(struct swait_queue_head *wq)
>
>  extern void swake_up_one(struct swait_queue_head *q);
>  extern void swake_up_all(struct swait_queue_head *q);
> -extern void swake_up_locked(struct swait_queue_head *q);
> +extern void swake_up_locked(struct swait_queue_head *q, int wake_flags);
>
>  extern void prepare_to_swait_exclusive(struct swait_queue_head *q, struct swait_queue *wait, int state);
>  extern long prepare_to_swait_event(struct swait_queue_head *q, struct swait_queue *wait, int state);
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index a0307b516b09..5ec7739400f4 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -210,6 +210,7 @@ __remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq
>  }
>
>  int __wake_up(struct wait_queue_head *wq_head, unsigned int mode, int nr, void *key);
> +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key);
>  void __wake_up_locked_key(struct wait_queue_head *wq_head, unsigned int mode, void *key);
>  void __wake_up_locked_key_bookmark(struct wait_queue_head *wq_head,
>                 unsigned int mode, void *key, wait_queue_entry_t *bookmark);
> @@ -237,6 +238,8 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
>  #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
>  #define wake_up_poll(x, m)                                                     \
>         __wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
> +#define wake_up_poll_on_current_cpu(x, m)                                      \
> +       __wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
>  #define wake_up_locked_poll(x, m)                                              \
>         __wake_up_locked_key((x), TASK_NORMAL, poll_to_key(m))
>  #define wake_up_interruptible_poll(x, m)                                       \
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index d57a5c1c1cd9..3561ab533dd4 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -13,6 +13,23 @@
>   * Waiting for completion is a typically sync point, but not an exclusion point.
>   */
>
> +static void complete_with_flags(struct completion *x, int wake_flags)
> +{
> +       unsigned long flags;
> +
> +       raw_spin_lock_irqsave(&x->wait.lock, flags);
> +
> +       if (x->done != UINT_MAX)
> +               x->done++;
> +       swake_up_locked(&x->wait, wake_flags);
> +       raw_spin_unlock_irqrestore(&x->wait.lock, flags);
> +}
> +
> +void complete_on_current_cpu(struct completion *x)
> +{
> +       return complete_with_flags(x, WF_CURRENT_CPU);
> +}
> +
>  /**
>   * complete: - signals a single thread waiting on this completion
>   * @x:  holds the state of this particular completion
> @@ -27,14 +44,7 @@
>   */
>  void complete(struct completion *x)
>  {
> -       unsigned long flags;
> -
> -       raw_spin_lock_irqsave(&x->wait.lock, flags);
> -
> -       if (x->done != UINT_MAX)
> -               x->done++;
> -       swake_up_locked(&x->wait);
> -       raw_spin_unlock_irqrestore(&x->wait.lock, flags);
> +       complete_with_flags(x, 0);
>  }
>  EXPORT_SYMBOL(complete);
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 25e902b40a18..5233e5182755 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6925,7 +6925,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
>  int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
>                           void *key)
>  {
> -       WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~WF_SYNC);
> +       WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
>         return try_to_wake_up(curr->private, mode, wake_flags);
>  }
>  EXPORT_SYMBOL(default_wake_function);
> diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> index 76b9b796e695..72505cd3b60a 100644
> --- a/kernel/sched/swait.c
> +++ b/kernel/sched/swait.c
> @@ -18,7 +18,7 @@ EXPORT_SYMBOL(__init_swait_queue_head);
>   * If for some reason it would return 0, that means the previously waiting
>   * task is already running, so it will observe condition true (or has already).
>   */
> -void swake_up_locked(struct swait_queue_head *q)
> +void swake_up_locked(struct swait_queue_head *q, int wake_flags)
>  {
>         struct swait_queue *curr;
>
> @@ -26,7 +26,7 @@ void swake_up_locked(struct swait_queue_head *q)
>                 return;
>
>         curr = list_first_entry(&q->task_list, typeof(*curr), task_list);
> -       wake_up_process(curr->task);
> +       try_to_wake_up(curr->task, TASK_NORMAL, wake_flags);
>         list_del_init(&curr->task_list);
>  }
>  EXPORT_SYMBOL(swake_up_locked);
> @@ -41,7 +41,7 @@ EXPORT_SYMBOL(swake_up_locked);
>  void swake_up_all_locked(struct swait_queue_head *q)
>  {
>         while (!list_empty(&q->task_list))
> -               swake_up_locked(q);
> +               swake_up_locked(q, 0);
>  }
>
>  void swake_up_one(struct swait_queue_head *q)
> @@ -49,7 +49,7 @@ void swake_up_one(struct swait_queue_head *q)
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&q->lock, flags);
> -       swake_up_locked(q);
> +       swake_up_locked(q, 0);
>         raw_spin_unlock_irqrestore(&q->lock, flags);
>  }
>  EXPORT_SYMBOL(swake_up_one);
> diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
> index 133b74730738..47803a0b8d5d 100644
> --- a/kernel/sched/wait.c
> +++ b/kernel/sched/wait.c
> @@ -161,6 +161,11 @@ int __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
>  }
>  EXPORT_SYMBOL(__wake_up);
>
> +void __wake_up_on_current_cpu(struct wait_queue_head *wq_head, unsigned int mode, void *key)
> +{
> +       __wake_up_common_lock(wq_head, mode, 1, WF_CURRENT_CPU, key);
> +}
> +
>  /*
>   * Same as __wake_up but called with the spinlock in wait_queue_head_t held.
>   */
> --
> 2.39.1.456.gfc5497dd1b-goog
>
