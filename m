Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415AC665FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbjAKPuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbjAKPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:50:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E2D3475E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:50:01 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id bn6so16409345ljb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0KXbEaqTu3Fy2qT3OyHzLbZPf+ncFOwKL1ipyxSdrY=;
        b=YZ/BKTRUy+bj8KBif69whxnPH0X3bvzxQbw2Gwzh/QpqNcRbo7+HUAqzjP4fio0APX
         lBRfIu17Pu9NzkWqu++qC8fTrwt+dfpR/usYdtkwaC4wJm8Gbm3uY5F0Sj4LOJNCGCaI
         6tqCCzBAqHoQ09iDrIxM4T+HaOz48Lo5brSV3gmB4WyJ0OMWZlS8JxM2a/uaj7Tc0P5h
         mQDMKHmhygBHjN4RWCs1bx//iUOVOUiVHIVMrp/K57ES14/+mbOU9+eeDI7J49ZVPxEe
         AMdZK9RtZO5laVsdSX0HZp6obWkltwMDegJgU5IkFjy/hxkJF75QpsmOnFYcWiHXzP/n
         u1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0KXbEaqTu3Fy2qT3OyHzLbZPf+ncFOwKL1ipyxSdrY=;
        b=Zual0Zn8ZNJu80c/tmUPoWSV23Ss3a/Q1nWo2KAhBGbzGOVrJtbooQDHnDrdBlf4/C
         XrbWC/0a8U+rpKs04uHDUzV7xGIC1uk1IZ6QpH6Qx2Jtjo7Aw1eBLvr/jSVk887SfduC
         I9xVN9uyVIQTrVdDuAXgqI9v+tDDCR6/q4mYC7xzpmhBqP0NlxPR9Jsifyk2WEjyaP1v
         xNKIUZme88iymWaMQ0CjoSciOiVfmJhZcJNVk1QhijHiqilnGfNIpWvMoO4xQ+kzqciP
         khonlmte6NIv39F5QwGvg3n7EhcTYeJyaOFofAA84S8QYWT25j40l2f4/N+STa3qNqKx
         NqjQ==
X-Gm-Message-State: AFqh2koGRHK0ZzPb3zmUN0mjJ5USOHQOTlHLNT1xExJ9YkSBGNRTEgSC
        s5raaYQCgZlnDimSmj+dp5LWFO2IR6/4ITi3S2VaFw==
X-Google-Smtp-Source: AMrXdXsu4zEHOTyLCqI43onReyQHf69+lKZ8IKIW8cObtSage9hQGN/5/sGk2OX5CDM2fzAypuv+IcfkmQ/T5Bizy3g=
X-Received: by 2002:a2e:978b:0:b0:287:7217:575b with SMTP id
 y11-20020a2e978b000000b002877217575bmr292661lji.99.1673452199375; Wed, 11 Jan
 2023 07:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20221216171807.760147-1-dvyukov@google.com>
In-Reply-To: <20221216171807.760147-1-dvyukov@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 11 Jan 2023 16:49:47 +0100
Message-ID: <CACT4Y+aqT=e30Rvhz233NQBqXioNE11kPWbfcdnYQPk8QMkRBQ@mail.gmail.com>
Subject: Re: [RFC PATCH] posix-timers: Support delivery of signals to the
 current thread
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Dec 2022 at 18:18, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Support CLOCK_PROCESS_CPUTIME_ID timers with SIGEV_SIGNAL | SIGEV_THREAD_ID
> and sigev_notify_thread_id == 0, which sends the signal to the current
> thread that fires the timer. This is useful for relatively uniform sampling
> of process execution across all threads with signals.
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marco Elver <elver@google.com>
>
> ---
>
> We are trying to implement sampling program analysis based on this.
> We don't need 100% uniform sampling as a CPU profiler would need,
> but we still need the signals to be reasonably distributed across
> the process threads.
>
> Thomas, does the idea look sane to you overall?
> Are there any existing alternatives to this?

Hi Thomas,

I guess this was lost in your inbox during the holidays period.
Please take a look. Should I mail this as a non-RFC patch?

Thanks

> All alternatives we found are complex and/or have high overhead.
> E.g. we considered using CLOCK_PROCESS_CPUTIME_ID+SIGEV_SIGNAL timer
> plus inherited for all threads perf_event(PERF_COUNT_SW_TASK_CLOCK).
> When the timer fires we enable the perf event, and then use the signals
> from the perf event, and then disable the perf event.
> But this has considerable memory overhead (perf event per thread)
> and issues IPIs to all CPUs for perf event enable/disable.
>
> We also considered using CLOCK_PROCESS_CPUTIME_ID+SIGEV_SIGNAL timer
> and then manually scan /proc/self/task/ and select some task at random.
> But this is also complex and makes it hard to do reasonable sampling
> proportional to activity of threads.
>
> All alternatives are based on CLOCK_PROCESS_CPUTIME_ID in some way,
> and it seems that just a single CLOCK_PROCESS_CPUTIME_ID timer is enough
> if it could deliver signals to active threads (what this patch is doing).
> The analysis we are trying to do is intended for production systems
> so we are aiming at as low overhead as possible.
>
> If this idea looks sane to you in general, I will add tests and I am open
> to suggestions on the user API (should it be a new SIGEV_CURRENT_THREAD?)
> and on how to represent this in the struct k_itimer. E.g. we could keep
> it_pid=current but add a special flag that says to send the signal to
> the current task rather than it_pid. This has an advantage that we can
> add the following check to posix_timer_event()
> (which would be pretty bad to violate):
> WARN_ON(!same_thread_group(pid_task(timr->it_pid, PIDTYPE_PID), current));
> ---
>  kernel/time/posix-timers.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index 5dead89308b74..411ba087e0699 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -336,6 +336,7 @@ void posixtimer_rearm(struct kernel_siginfo *info)
>  int posix_timer_event(struct k_itimer *timr, int si_private)
>  {
>         enum pid_type type;
> +       struct pid *pid;
>         int ret;
>         /*
>          * FIXME: if ->sigq is queued we can race with
> @@ -350,8 +351,9 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
>          */
>         timr->sigq->info.si_sys_private = si_private;
>
> +       pid = timr->it_pid ?: task_pid(current);
>         type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
> -       ret = send_sigqueue(timr->sigq, timr->it_pid, type);
> +       ret = send_sigqueue(timr->sigq, pid, type);
>         /* If we failed to send the signal the timer stops. */
>         return ret > 0;
>  }
> @@ -428,27 +430,31 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
>         return ret;
>  }
>
> -static struct pid *good_sigevent(sigevent_t * event)
> +static struct pid *good_sigevent(sigevent_t *event, clockid_t which_clock)
>  {
>         struct pid *pid = task_tgid(current);
>         struct task_struct *rtn;
>
>         switch (event->sigev_notify) {
>         case SIGEV_SIGNAL | SIGEV_THREAD_ID:
> +               /* This will use the current task for signals. */
> +               if (which_clock == CLOCK_PROCESS_CPUTIME_ID &&
> +                   !event->sigev_notify_thread_id)
> +                       return NULL;
>                 pid = find_vpid(event->sigev_notify_thread_id);
>                 rtn = pid_task(pid, PIDTYPE_PID);
>                 if (!rtn || !same_thread_group(rtn, current))
> -                       return NULL;
> +                       return ERR_PTR(-ENOENT);
>                 fallthrough;
>         case SIGEV_SIGNAL:
>         case SIGEV_THREAD:
>                 if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
> -                       return NULL;
> +                       return ERR_PTR(-EINVAL);
>                 fallthrough;
>         case SIGEV_NONE:
>                 return pid;
>         default:
> -               return NULL;
> +               return ERR_PTR(-EINVAL);
>         }
>  }
>
> @@ -502,6 +508,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
>         struct k_itimer *new_timer;
>         int error, new_timer_id;
>         int it_id_set = IT_ID_NOT_SET;
> +       struct pid *pid;
>
>         if (!kc)
>                 return -EINVAL;
> @@ -527,9 +534,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
>
>         if (event) {
>                 rcu_read_lock();
> -               new_timer->it_pid = get_pid(good_sigevent(event));
> +               pid = good_sigevent(event, which_clock);
> +               if (!IS_ERR(pid))
> +                       new_timer->it_pid = get_pid(pid);
>                 rcu_read_unlock();
> -               if (!new_timer->it_pid) {
> +               if (IS_ERR(pid)) {
>                         error = -EINVAL;
>                         goto out;
>                 }
>
> base-commit: 041fae9c105ae342a4245cf1e0dc56a23fbb9d3c
> --
> 2.39.0.314.g84b9a713c41-goog
>
