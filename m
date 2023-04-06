Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2CF6D9944
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbjDFONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbjDFOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:12:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C277EE1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:12:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e13so17447366ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680790361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EK2TuG+WkLupwO9C8GXLQol+GTLoseAFOILf7LMA4Ag=;
        b=tYw73/FyTv5WaJ2rhzmMHPoBwLZmIl1kP79Cm+DPhR8Bio9CXcigKm2MZdEI9PbSK2
         yyI4fRp937L9lL1uad95bKspK2fe6c0FhAjKTqCFFAJFUUoVd79F9OGw1SynOtQ/fxKk
         jRtwJSrIOoskNiC1HuaSBoXRW5VHpPW48JP7mPyh2nqCvP5oCtk40np8S4dVXG9pSamP
         xREEqvZib8vgIIICvvVBDkBHzaAptHbVxNKdNh9VUuP4G48X7Hjt4vdrjNmtnlQKBY0k
         GuLKtn0cvgC59502Tp1PUYcnzkJcOHCD38s4NQF5DXC7+mspTwE0JWlhBTpLqQZxdXUm
         XwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680790361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EK2TuG+WkLupwO9C8GXLQol+GTLoseAFOILf7LMA4Ag=;
        b=3xoFoalo5MkNC0b8YiBqSTt+GBzcAaFO2mduZPFD1gFHWIfDp1EFvDEY2y7agEWHs4
         XhEIOitIKHMVAfAXB0gL7AaDUq5XXIwOAx0iGGY3SdqK+vgXYkNqvJKfe3tHWRYTxS+s
         K0cfMEukRQyCBGP5jp83HeoosQ0wiL9jkJeKEhXsvxwACPx2A0fJWRmvRAm9sncCMy2Q
         Zfd6FATFblrDEyxbGL4yP9sYX1XTcbwAJBnmYo24kLhzxueCQmS4U2Noz6TPQhm3u9Od
         jctmJ1bOU0AwZBwIDPqPPS6QCBlZFX4XMszHtn74D5+iVNFZq9bblZHlFO0FDqZLHRhc
         10bA==
X-Gm-Message-State: AAQBX9ctcoNi0zHG0LYHRYzeHK/Ri3T2IejUNUITsCD+XZmwjfESlLyp
        T1OQNSyS3H3QghjTlQBSyjgelGkq7THNyl4xCI2G/Q==
X-Google-Smtp-Source: AKy350ZfMeq75xGiCP03gTiGqNqmMx1cPRWF+FsoE17HCPQ7PHCvr67VYtxzWA3ws1glln92pVHB5xOFHTA8Ouz5LAs=
X-Received: by 2002:a6b:d10a:0:b0:744:b4c2:30fa with SMTP id
 l10-20020a6bd10a000000b00744b4c230famr6986944iob.18.1680790360988; Thu, 06
 Apr 2023 07:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com>
In-Reply-To: <20230316123028.2890338-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 Apr 2023 16:12:04 +0200
Message-ID: <CANpmjNOwo=4_VpUs1PYajtxb8gvt3hyhgwc-Bk9RN4VgupZCyQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 13:31, Marco Elver <elver@google.com> wrote:
>
> From: Dmitry Vyukov <dvyukov@google.com>
>
> POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
> thread of a thread group for signal delivery.     However, this has a
> significant downside: it requires waking up a potentially idle thread.
>
> Instead, prefer to deliver signals to the current thread (in the same
> thread group) if SIGEV_THREAD_ID is not set by the user. This does not
> change guaranteed semantics, since POSIX process CPU time timers have
> never guaranteed that signal delivery is to a specific thread (without
> SIGEV_THREAD_ID set).
>
> The effect is that we no longer wake up potentially idle threads, and
> the kernel is no longer biased towards delivering the timer signal to
> any particular thread (which better distributes the timer signals esp.
> when multiple timers fire concurrently).
>
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v6:
> - Split test from this patch.
> - Update wording on what this patch aims to improve.
>
> v5:
> - Rebased onto v6.2.
>
> v4:
> - Restructured checks in send_sigqueue() as suggested.
>
> v3:
> - Switched to the completely different implementation (much simpler)
>   based on the Oleg's idea.
>
> RFC v2:
> - Added additional Cc as Thomas asked.
> ---
>  kernel/signal.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8cb28f1df294..605445fa27d4 100644
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
> @@ -1970,8 +1969,23 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>
>         ret = -1;
>         rcu_read_lock();
> +       /*
> +        * This function is used by POSIX timers to deliver a timer signal.
> +        * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
> +        * set), the signal must be delivered to the specific thread (queues
> +        * into t->pending).
> +        *
> +        * Where type is not PIDTYPE_PID, signals must just be delivered to the
> +        * current process. In this case, prefer to deliver to current if it is
> +        * in the same thread group as the target, as it avoids unnecessarily
> +        * waking up a potentially idle task.
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
> @@ -1993,6 +2007,11 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
>         q->info.si_overrun = 0;
>
>         signalfd_notify(t, sig);
> +       /*
> +        * If the type is not PIDTYPE_PID, we just use shared_pending, which
> +        * won't guarantee that the specified task will receive the signal, but
> +        * is sufficient if t==current in the common case.
> +        */
>         pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
>         list_add_tail(&q->list, &pending->list);
>         sigaddset(&pending->signal, sig);
> --

One last semi-gentle ping. ;-)

1. We're seeing that in some applications that use POSIX timers
heavily, but where the main thread is mostly idle, the main thread
receives a disproportional amount of the signals along with being
woken up constantly. This is bad, because the main thread usually
waits with the help of a futex or really long sleeps. Now the main
thread will steal time (to go back to sleep) from another thread that
could have instead just proceeded with whatever it was doing.

2. Delivering signals to random threads is currently way too
expensive. We need to resort to this crazy algorithm: 1) receive timer
signal, 2) check if main thread, 3) if main thread (which is likely),
pick a random thread and do tgkill. To find a random thread, iterate
/proc/self/task, but that's just abysmal for various reasons. Other
alternatives, like inherited task clock perf events are too expensive
as soon as we need to enable/disable the timers (does IPIs), and
maintaining O(#threads) timers is just as horrible.

This patch solves both the above issues.

We acknowledge the unfortunate situation of attributing this patch to
one clear subsystem and owner: it straddles into signal delivery and
POSIX timers territory, and perhaps some scheduling. The patch itself
only touches kernel/signal.c.

If anyone has serious objections, please shout (soon'ish). Given the
patch has been reviewed by Oleg, and scrutinized by Dmitry and myself,
presumably we need to find a tree that currently takes kernel/signal.c
patches?

Thanks!

-- Marco
