Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEB067D387
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjAZRwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAZRwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:52:14 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2504F873
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:52:13 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id d8so1005506ybe.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 09:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P0Sx7c96bRRnLjGYxI43rSng8gwU48yUoEl1nlwB8sE=;
        b=i286CWd/No84U5GQ1cXtaD85XbtrNAYyfsFMvuMxEgnsqHncloDJ5bv1z8p79qaYee
         cUE7mpLX7o2rQwqwRKqJ+ra2ig6+I8mcaR0VDfU0fzjFi2N13Uhju0ysZOqy4YJ1fU3b
         Jhm5LNxv71cV57bDfyVGUho/83qAm7Qdj9Sy5URnmPTe1Ul4CzYz5P7xGs3CoY0Z8Dxi
         jDm7irn7nyLTOHMKz9INqr0vSb62vCZdE1xmzopnza28a7fJpK9mc/c9ovXqodu8YDss
         R/tpfd5qlTwo6IAKeJmeZWFzh5BZhVcOktzI1JXz6zKlIyNbG/LN02j2rUBi0eH6Xhq2
         cUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0Sx7c96bRRnLjGYxI43rSng8gwU48yUoEl1nlwB8sE=;
        b=chSuEiVClPNmA8Zj9jHZBBumZO0hrPP0Dxx0idvrFm2iS+jNjojHxwFY6hv3oJMA57
         Wq7eY6oMGE4I9tnpZ1HaujH2r5c51tk3+nGzPBvKptA9AvT8HiLYj0U7yyn+a+zJG74D
         nNd/O9H8CKKOYQtsPU3yCqcpyIHAB5ifXG0LR4p+oLRlTib8nRSUk7JFvaGXu5/ezWkS
         A+wes3HMQsTah/oGtgH6aP0H1OQNG03MHZc3UCZ9jsfMrK9+mlFABNUrJnyKHIwv5ZQ7
         ZkQYLkdnTsAZCGPJd+g0BSTjDsQsuXOKer/CUdd6yi1DIDoKOFy5BvQEBcfz2/LXNUjk
         9v7g==
X-Gm-Message-State: AO0yUKVrRGJ6JEHxDFRPv8FBSbbnlv8REkeKhqscFM+ggeC50HMK2Yir
        p8o+FSRKCIT8NSsOmNzzjE+0RNt2VYXd0QlkC+98Bw==
X-Google-Smtp-Source: AK7set+sDxSQGuG2yqVXDzliz2rzl+e6Xtgvp5sBbI+W742jwILYxN1YTaucJzO53kl132nyqdfZHuGGRQQngHha/9s=
X-Received: by 2002:a5b:92:0:b0:80b:d161:ace9 with SMTP id b18-20020a5b0092000000b0080bd161ace9mr473745ybp.143.1674755532149;
 Thu, 26 Jan 2023 09:52:12 -0800 (PST)
MIME-Version: 1.0
References: <20230126105128.2249938-1-dvyukov@google.com> <20230126154118.2393850-1-dvyukov@google.com>
In-Reply-To: <20230126154118.2393850-1-dvyukov@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 26 Jan 2023 18:51:35 +0100
Message-ID: <CANpmjNM=PVigDZKu-H_-cLECUJKSx7TH+kxSjfF=4UHdrGBj+g@mail.gmail.com>
Subject: Re: [PATCH v4] posix-timers: Prefer delivery of signals to the
 current thread
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, oleg@redhat.com, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>
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

On Thu, 26 Jan 2023 at 16:41, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> Prefer to deliver signals to the current thread if SIGEV_THREAD_ID
> is not set. We used to prefer the main thread, but delivering
> to the current thread is both faster, and allows to sample actual thread
> activity for CLOCK_PROCESS_CPUTIME_ID timers, and does not change
> the semantics (since we queue into shared_pending, all thread may
> receive the signal in both cases).
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Marco Elver <elver@google.com>
>
> ---
>
> Changes in v4:
>  - restructured checks in send_sigqueue() as suggested
>
> Changes in v3:
>  - switched to the completely different implementation (much simpler)
>    based on the Oleg's idea
>
> Changes in RFC v2:
>  - added additional Cc as Thomas asked
> ---
>  kernel/signal.c                               | 23 +++++-
>  tools/testing/selftests/timers/posix_timers.c | 73 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 3 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

Nice - and and given the test, hopefully this behaviour won't regress in future.


> diff --git a/kernel/signal.c b/kernel/signal.c
> index ae26da61c4d9f..706ad3a21933d 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1003,8 +1003,7 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>         /*
>          * Now find a thread we can wake up to take the signal off the queue.
>          *
> -        * If the main thread wants the signal, it gets first crack.
> -        * Probably the least surprising to the average bear.
> +        * Try the suggested task first (may or may not be the main thread).
>          */
>         if (wants_signal(sig, p))
>                 t = p;
> @@ -1970,8 +1969,26 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>
>         ret = -1;
>         rcu_read_lock();
> +       /*
> +        * This is called from posix timers. SIGEV_THREAD_ID signals
> +        * (type == PIDTYPE_PID) must be delivered to the user-specified
> +        * thread, so we use that and queue into t->pending.
> +        * Non-SIGEV_THREAD_ID signals must be delivered to "the process",
> +        * so we queue into shared_pending, but prefer to deliver to the
> +        * current thread. We used to prefer the main thread, but delivering
> +        * to the current thread is both faster, and allows user-space to
> +        * sample actual thread activity for CLOCK_PROCESS_CPUTIME_ID timers,
> +        * and does not change the semantics (since we queue into
> +        * shared_pending, all thread may receive the signal in both cases).
> +        * Note: current may be from a completely unrelated process for
> +        * non-cpu-time-based timers, we must be careful to not kick it.
> +        */
>         t = pid_task(pid, type);
> -       if (!t || !likely(lock_task_sighand(t, &flags)))
> +       if (!t)
> +               goto ret;
> +       if (type != PIDTYPE_PID && same_thread_group(t, current))
> +               t = current;
> +       if (!likely(lock_task_sighand(t, &flags)))
>                 goto ret;
>
>         ret = 1; /* the signal is ignored */
> diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
> index 0ba500056e635..fd3b933a191fe 100644
> --- a/tools/testing/selftests/timers/posix_timers.c
> +++ b/tools/testing/selftests/timers/posix_timers.c
> @@ -188,6 +188,76 @@ static int check_timer_create(int which)
>         return 0;
>  }
>
> +int remain;
> +__thread int got_signal;
> +
> +static void *distribution_thr(void *arg) {
> +       while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> +       return NULL;
> +}
> +
> +static void distribution_handler(int nr)
> +{
> +       if (!__atomic_exchange_n(&got_signal, 1, __ATOMIC_RELAXED))
> +               __atomic_fetch_sub(&remain, 1, __ATOMIC_RELAXED);
> +}
> +
> +/* Test that all running threads receive CLOCK_PROCESS_CPUTIME_ID signals. */
> +static int check_timer_distribution(void)
> +{
> +       int err, i;
> +       timer_t id;
> +       const int nthreads = 10;
> +       pthread_t threads[nthreads];
> +       struct itimerspec val = {
> +               .it_value.tv_sec = 0,
> +               .it_value.tv_nsec = 1000 * 1000,
> +               .it_interval.tv_sec = 0,
> +               .it_interval.tv_nsec = 1000 * 1000,
> +       };
> +
> +       printf("Check timer_create() per process signal distribution... ");
> +       fflush(stdout);
> +
> +       remain = nthreads + 1;  /* worker threads + this thread */
> +       signal(SIGALRM, distribution_handler);
> +       err = timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
> +       if (err < 0) {
> +               perror("Can't create timer\n");
> +               return -1;
> +       }
> +       err = timer_settime(id, 0, &val, NULL);
> +       if (err < 0) {
> +               perror("Can't set timer\n");
> +               return -1;
> +       }
> +
> +       for (i = 0; i < nthreads; i++) {
> +               if (pthread_create(&threads[i], NULL, distribution_thr, NULL)) {
> +                       perror("Can't create thread\n");
> +                       return -1;
> +               }
> +       }
> +
> +       /* Wait for all threads to receive the signal. */
> +       while (__atomic_load_n(&remain, __ATOMIC_RELAXED));
> +
> +       for (i = 0; i < nthreads; i++) {
> +               if (pthread_join(threads[i], NULL)) {
> +                       perror("Can't join thread\n");
> +                       return -1;
> +               }
> +       }
> +
> +       if (timer_delete(id)) {
> +               perror("Can't delete timer\n");
> +               return -1;
> +       }
> +
> +       printf("[OK]\n");
> +       return 0;
> +}
> +
>  int main(int argc, char **argv)
>  {
>         printf("Testing posix timers. False negative may happen on CPU execution \n");
> @@ -217,5 +287,8 @@ int main(int argc, char **argv)
>         if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
>                 return ksft_exit_fail();
>
> +       if (check_timer_distribution() < 0)
> +               return ksft_exit_fail();
> +
>         return ksft_exit_pass();
>  }
>
> base-commit: 7c46948a6e9cf47ed03b0d489fde894ad46f1437
> --
> 2.39.1.456.gfc5497dd1b-goog
>
