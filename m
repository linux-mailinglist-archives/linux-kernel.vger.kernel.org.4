Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25170A106
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjESUvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:51:44 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DDFE1;
        Fri, 19 May 2023 13:51:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6aafdeab6b0so2827349a34.0;
        Fri, 19 May 2023 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684529501; x=1687121501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6FBL0T/AL5bdBl7DQtsHy/p4+t/gO/jdIeo337Z6Vg=;
        b=TM/fdYCbvYb349FIIKYN7wF581qiDGLt+dliybFnMvjZhkNsCCyR4A0JmQLGvC5gjY
         /37a+A6RkEnlTUiK3yHE8UNJ5UmpjuOsjZzX9CvqKuJLvfufoQ1t8uih+pt4dfYXCZK5
         7aZhQaIQEf02oDTBVKUh5THWae6kp1+fo59ZZ23VDzHZsRVv1HmEgxqgRKvASQh/wrZf
         9iHAUB76fotkqjhpOJw+CJ6hTeyr1a7ks2CP9jL+R5Jf9RXw9NTEwZdkEd6f69Mj5Yy1
         3Y+cGzl78bqC9Qv9SkLlLui14evvMlwpJbD8fQELdN5c8E/4VR2EiCwjJlmFS/EuraFC
         o7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529501; x=1687121501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6FBL0T/AL5bdBl7DQtsHy/p4+t/gO/jdIeo337Z6Vg=;
        b=cEV7+WzKElJi5M5pd7vuFt+0ex+B1ZCEdLUVgiJknzpjNxgQPJZp+UXajh6E/5vPLf
         AzQtFopUVotLaF2iJO1Hshju8iUl0z6FP+jhQqcGTWtw2KQ1sLQrzNH/xD9wc5rYbmP7
         AxD45Z3QugINXgZKwGe0/cAWR59C0ueI5ZMZl5lqhJw+ph4dPsbFp6h3YKuWvezH7d35
         ZAJq2/675j/pT2fQ7LmyNJ2aCQ1b3XX5XTwj4nPsAUatrtNHYzQMnadzQ8zprL747c1D
         xIWcYYSmLRmW/VhM9citmBatj8p1bhLWXjVEi4pIsnowkMpWZU6MAYi9UmzWtr24s2uP
         MG/w==
X-Gm-Message-State: AC+VfDyoDPXpGi8v319iGQwMJ3Or7azhvgEhZQrddv300BPem5o4R5GY
        yqABUA0CKUC8R0OgS3qj1D4v+pJKN3cewliRZFw=
X-Google-Smtp-Source: ACHHUZ4+RtZRxT6QU64DW9G2VBXEm7UYUaqTKdOZAkGLVx7tuaGw4zG1I0i89Xq0r55xPMyPX6AHKv545XuEy83yRHk=
X-Received: by 2002:a05:6830:114f:b0:6ab:1447:8817 with SMTP id
 x15-20020a056830114f00b006ab14478817mr1579179otq.17.1684529501706; Fri, 19
 May 2023 13:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com> <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20230517152654.7193-2-mathieu.desnoyers@efficios.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Fri, 19 May 2023 15:51:30 -0500
Message-ID: <CAFUsyfJ49mE+7p1ywEHetRHqr=DWY7aiFYzfva9Mtqp3_XYncg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] rseq: Add sched_state field to struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:28=E2=80=AFAM Mathieu Desnoyers via Libc-alpha
<libc-alpha@sourceware.org> wrote:
>
> Expose the "on-cpu" state for each thread through struct rseq to allow
> adaptative mutexes to decide more accurately between busy-waiting and
> calling sys_futex() to release the CPU, based on the on-cpu state of the
> mutex owner.
>
> It is only provided as an optimization hint, because there is no
> guarantee that the page containing this field is in the page cache, and
> therefore the scheduler may very well fail to clear the on-cpu state on
> preemption. This is expected to be rare though, and is resolved as soon
> as the task returns to user-space.
>
> The goal is to improve use-cases where the duration of the critical
> sections for a given lock follows a multi-modal distribution, preventing
> statistical guesses from doing a good job at choosing between busy-wait
> and futex wait behavior.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Carlos O'Donell <carlos@redhat.com>
> Cc: Florian Weimer <fweimer@redhat.com>
> Cc: libc-alpha@sourceware.org
> ---
>  include/linux/sched.h     | 12 ++++++++++++
>  include/uapi/linux/rseq.h | 17 +++++++++++++++++
>  kernel/rseq.c             | 14 ++++++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index eed5d65b8d1f..c7e9248134c1 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struct ksi=
gnal *ksig,
>         rseq_handle_notify_resume(ksig, regs);
>  }
>
> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state);
> +
> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned =
int state)
> +{
> +       if (t->rseq)
> +               __rseq_set_sched_state(t, state);
> +}
> +
>  /* rseq_preempt() requires preemption to be disabled. */
>  static inline void rseq_preempt(struct task_struct *t)
>  {
>         __set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
>         rseq_set_notify_resume(t);
> +       rseq_set_sched_state(t, 0);

Should rseq_migrate also be made to update the cpu_id of the new core?
I imagine the usage of this will be something along the lines of:

if(!on_cpu(mutex->owner_rseq_struct) &&
   cpu(mutex->owner_rseq_struct) =3D=3D this_threads_cpu)
   // goto futex

So I would think updating on migrate would be useful as well.


>  }
>
>  /* rseq_migrate() requires preemption to be disabled. */
> @@ -2405,6 +2414,9 @@ static inline void rseq_signal_deliver(struct ksign=
al *ksig,
>                                        struct pt_regs *regs)
>  {
>  }
> +static inline void rseq_set_sched_state(struct task_struct *t, unsigned =
int state)
> +{
> +}
>  static inline void rseq_preempt(struct task_struct *t)
>  {
>  }
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index c233aae5eac9..c6d8537e23ca 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -37,6 +37,13 @@ enum rseq_cs_flags {
>                 (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>  };
>
> +enum rseq_sched_state {
> +       /*
> +        * Task is currently running on a CPU if bit is set.
> +        */
> +       RSEQ_SCHED_STATE_ON_CPU         =3D (1U << 0),
> +};
> +
>  /*
>   * struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>   * contained within a single cache-line. It is usually declared as
> @@ -148,6 +155,16 @@ struct rseq {
>          */
>         __u32 mm_cid;
>
> +       /*
> +        * Restartable sequences sched_state field. Updated by the kernel=
. Read
> +        * by user-space with single-copy atomicity semantics. This field=
s can
> +        * be read by any userspace thread. Aligned on 32-bit. Contains a
> +        * bitmask of enum rseq_sched_state. This field is provided as a =
hint
> +        * by the scheduler, and requires that the page holding struct rs=
eq is
> +        * faulted-in for the state update to be performed by the schedul=
er.
> +        */
> +       __u32 sched_state;
> +
>         /*
>          * Flexible array member at end of structure, after last feature =
field.
>          */
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 9de6e35fe679..b2eb3bbaa9ef 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -91,6 +91,7 @@ static int rseq_update_cpu_node_id(struct task_struct *=
t)
>         u32 cpu_id =3D raw_smp_processor_id();
>         u32 node_id =3D cpu_to_node(cpu_id);
>         u32 mm_cid =3D task_mm_cid(t);
> +       u32 sched_state =3D RSEQ_SCHED_STATE_ON_CPU;
>
>         WARN_ON_ONCE((int) mm_cid < 0);
>         if (!user_write_access_begin(rseq, t->rseq_len))
> @@ -99,6 +100,7 @@ static int rseq_update_cpu_node_id(struct task_struct =
*t)
>         unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
>         unsafe_put_user(node_id, &rseq->node_id, efault_end);
>         unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
> +       unsafe_put_user(sched_state, &rseq->sched_state, efault_end);
>         /*
>          * Additional feature fields added after ORIG_RSEQ_SIZE
>          * need to be conditionally updated only if
> @@ -339,6 +341,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksi=
g, struct pt_regs *regs)
>         force_sigsegv(sig);
>  }
>
> +/*
> + * Attempt to update rseq scheduler state.
> + */
> +void __rseq_set_sched_state(struct task_struct *t, unsigned int state)
> +{
> +       if (unlikely(t->flags & PF_EXITING))
> +               return;
> +       pagefault_disable();
> +       (void) put_user(state, &t->rseq->sched_state);
> +       pagefault_enable();
> +}
> +
>  #ifdef CONFIG_DEBUG_RSEQ
>
>  /*
> --
> 2.25.1
>
