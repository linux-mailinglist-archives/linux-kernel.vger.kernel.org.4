Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A3970E648
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238503AbjEWULG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjEWULD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:11:03 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9AC119;
        Tue, 23 May 2023 13:11:01 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-555536b85a0so118741eaf.2;
        Tue, 23 May 2023 13:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684872661; x=1687464661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Umub7OYsenM2QqTNXDUnUaiGuw7XGpqgYK5jUSDqo=;
        b=ECAzAWSBy3PXCV9C3WGYehqe2qEAfQ2/cpN65yNk5LMiH/SlpvkFbF1f3YbS7PWFn0
         kvavDPXPuVe8At0qrgy5R05aaJTgy0U12H+J3Xg8CzyZ++xzAXAGvlkFX1OuXfxgaGIJ
         KDObSSUBZUR2AqgQpdmmd6+fAyGFmv6Z8Fp1T43FnEGbHjo+LNYbowVIxCg328wapydm
         /p+cxne15pFdtN5oiKGlsnIcmbXdWXluSb8hrSja042nJZD9QhD8WrN3o28FhrGz8Ebq
         nJjPX2CHhSkHs3Rq/50D+pBwa3jXtVWIq1SWVGVGxqcznN7OtvhuLilRgQTERmViWgPb
         EO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684872661; x=1687464661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Umub7OYsenM2QqTNXDUnUaiGuw7XGpqgYK5jUSDqo=;
        b=HcW7FXvmsxgNsuUby0IQf0XRo1BpYQp4ZvmjfaG/eMGQsGmF0Fi6SwqrFjIWxoV1oD
         JNNaMDAAdad2Z3AnOTYhDMnB+0BqjKMYrMPrl/Kwqeqo2A4XagLQlo/1txm3nDuWBgys
         cCAqdR/NFSyexbxqmnaFjVmTRueT5ieYd2HoZTQSeOpPz9Xjp5OeGSu1O63n+0XRSl4g
         kiPXzvSsPx05HJU8nqlg/4Qafn7youv6c6esFSrcqEb6EdECI6ULj8V/1wL7Fg+/UboE
         lzKIPDSr36qAxQFrZXhG5saZUO1wZFSW11wLiOdAGrDeW6bwz25ns2CJGSdmpRqpMVp4
         OGkQ==
X-Gm-Message-State: AC+VfDy42e/YCZt0fkk56RQz73acOHZYXT28i0hoU5hP+imgk/IsIscb
        rzyd8ERYCIKG0GDbKxsRDYRQqz4IACBOwVvVOCKpMRL4kOM=
X-Google-Smtp-Source: ACHHUZ6y+dI4eJ8WHxUiEF+QkKISxI6u5e192G7y0zx1Ui97tem20fMvj3PauaWZX68MoP39Jp9Nf1esu/JVYgNEV/8=
X-Received: by 2002:a4a:9ccd:0:b0:54f:9fc0:63c2 with SMTP id
 d13-20020a4a9ccd000000b0054f9fc063c2mr7031144ook.3.1684872660792; Tue, 23 May
 2023 13:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230517152654.7193-1-mathieu.desnoyers@efficios.com>
 <20230517152654.7193-2-mathieu.desnoyers@efficios.com> <CAFUsyfJ49mE+7p1ywEHetRHqr=DWY7aiFYzfva9Mtqp3_XYncg@mail.gmail.com>
 <cdac8821-a298-aced-8084-8da3ba64a1be@efficios.com> <CAFUsyf+L6JF=pZ6QstQhdGGPVM7e7ML2a5LEbzmP6sTs3cwJng@mail.gmail.com>
 <21f3d5e4-44ba-65de-5180-f059c145deef@efficios.com>
In-Reply-To: <21f3d5e4-44ba-65de-5180-f059c145deef@efficios.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Tue, 23 May 2023 15:10:48 -0500
Message-ID: <CAFUsyfKqxiYt3+G0-wHm05nwUZQ6b_i_998YvkSnnvKmFH9=XA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:30=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2023-05-23 12:32, Noah Goldstein wrote:
> > On Tue, May 23, 2023 at 7:49=E2=80=AFAM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> On 2023-05-19 16:51, Noah Goldstein wrote:
> >>> On Wed, May 17, 2023 at 10:28=E2=80=AFAM Mathieu Desnoyers via Libc-a=
lpha
> >>> <libc-alpha@sourceware.org> wrote:
> >>>>
> >>>> Expose the "on-cpu" state for each thread through struct rseq to all=
ow
> >>>> adaptative mutexes to decide more accurately between busy-waiting an=
d
> >>>> calling sys_futex() to release the CPU, based on the on-cpu state of=
 the
> >>>> mutex owner.
> >>>>
> >>>> It is only provided as an optimization hint, because there is no
> >>>> guarantee that the page containing this field is in the page cache, =
and
> >>>> therefore the scheduler may very well fail to clear the on-cpu state=
 on
> >>>> preemption. This is expected to be rare though, and is resolved as s=
oon
> >>>> as the task returns to user-space.
> >>>>
> >>>> The goal is to improve use-cases where the duration of the critical
> >>>> sections for a given lock follows a multi-modal distribution, preven=
ting
> >>>> statistical guesses from doing a good job at choosing between busy-w=
ait
> >>>> and futex wait behavior.
> >>>>
> >>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >>>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>>> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> >>>> Cc: Carlos O'Donell <carlos@redhat.com>
> >>>> Cc: Florian Weimer <fweimer@redhat.com>
> >>>> Cc: libc-alpha@sourceware.org
> >>>> ---
> >>>>    include/linux/sched.h     | 12 ++++++++++++
> >>>>    include/uapi/linux/rseq.h | 17 +++++++++++++++++
> >>>>    kernel/rseq.c             | 14 ++++++++++++++
> >>>>    3 files changed, 43 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> >>>> index eed5d65b8d1f..c7e9248134c1 100644
> >>>> --- a/include/linux/sched.h
> >>>> +++ b/include/linux/sched.h
> >>>> @@ -2351,11 +2351,20 @@ static inline void rseq_signal_deliver(struc=
t ksignal *ksig,
> >>>>           rseq_handle_notify_resume(ksig, regs);
> >>>>    }
> >>>>
> >>>> +void __rseq_set_sched_state(struct task_struct *t, unsigned int sta=
te);
> >>>> +
> >>>> +static inline void rseq_set_sched_state(struct task_struct *t, unsi=
gned int state)
> >>>> +{
> >>>> +       if (t->rseq)
> >>>> +               __rseq_set_sched_state(t, state);
> >>>> +}
> >>>> +
> >>>>    /* rseq_preempt() requires preemption to be disabled. */
> >>>>    static inline void rseq_preempt(struct task_struct *t)
> >>>>    {
> >>>>           __set_bit(RSEQ_EVENT_PREEMPT_BIT, &t->rseq_event_mask);
> >>>>           rseq_set_notify_resume(t);
> >>>> +       rseq_set_sched_state(t, 0);
> >>>
> >>> Should rseq_migrate also be made to update the cpu_id of the new core=
?
> >>> I imagine the usage of this will be something along the lines of:
> >>>
> >>> if(!on_cpu(mutex->owner_rseq_struct) &&
> >>>      cpu(mutex->owner_rseq_struct) =3D=3D this_threads_cpu)
> >>>      // goto futex
> >>>
> >>> So I would think updating on migrate would be useful as well.
> >>
> >> I don't think we want to act differently based on the cpu on which the
> >> owner is queued.
> >>
> >> If the mutex owner is not on-cpu, and queued on the same cpu as the
> >> current thread, we indeed want to call sys_futex WAIT.
> >>
> >> If the mutex owner is not on-cpu, but queued on a different cpu than t=
he
> >> current thread, we *still* want to call sys_futex WAIT, because
> >> busy-waiting for a thread which is queued but not currently running is
> >> wasteful.
> >>
> > I think this is less clear. In some cases sure but not always. Going
> > to the futex
> > has more latency that userland waits, and if the system is not busy (ot=
her than
> > the one process) most likely less latency that yield. Also going to the=
 futex
> > requires a syscall on unlock.
> >
> > For example if the critical section is expected to be very small, it
> > would be easy
> > to imagine the lock be better implemented with:
> > while(is_locked)
> >    if (owner->on_cpu || owner->cpu !=3D my_cpu)
> >      exponential backoff
> >    else
> >      yield
> >
> > Its not that "just go to futex" doesn't ever make sense, but I don't
> > think its fair
> > to say that *always* the case.
> >
> > Looking at the kernel code, it doesn't seem to be a particularly high c=
ost to
> > keep the CPU field updated during migration so seems like a why not
> > kind of question.
>
> We already have the owner rseq_abi cpu_id field populated on every
> return-to-userspace. I wonder if it's really relevant that migration
> populates an updated value in this field immediately ? It's another case
> where this would be provided as a hint updated only if the struct rseq
> is in the page cache, because AFAIU the scheduler migration path cannot
> take a page fault.
>

Ah, thats a good point. And probably as probability the page is in the cach=
e
goes down a fair bit as the task is idle / bounced around for longer.

> Also, if a thread bounces around many runqueues before being scheduled
> again, we would be adding those useless stores to the rseq_abi structure
> at each migration between runqueues.
>
> Given this would add some complexity to the scheduler migration code, I
> would want to see metrics/benchmarks showing that it indeed improves
> real-world use-cases before adding this to the rseq ABI.
>
> It's not only a question of added lines of code as of today, but also a
> question of added userspace ABI guarantees which can prevent future
> scheduler optimizations. I'm *very* careful about keeping those to a
> strict minimum, which I hope Peter Zijlstra appreciates.

Well, this entire thing is moreso a hint than a guarantee. Even on_cpu
is only updated if the page happens to be in the pagecache so I don't
see how you could ever be *having* to do anything.

But fair enough, thought I'd throw the idea out there, but enough valid
concerns seem to make it not such a good idea.
>
> Thanks,
>
> Mathieu
>
>
> >> Or am I missing something ?
> >>
> >> Thanks,
> >>
> >> Mathieu
> >>
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> https://www.efficios.com
> >>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
