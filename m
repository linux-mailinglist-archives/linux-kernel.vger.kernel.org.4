Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C036DC9FD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjDJR12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 13:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDJR10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 13:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F22114
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:27:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A6761DFB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2249C433AF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681147644;
        bh=Nxyw5zvIvf2NKnO4JOdVNchaMz+8oiVXvZhhwRDHj9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lf38t2+JTfK8QGByRYzQs5kmYz4wjUE4yAxptBtEmmom98uMwWm4hO7bAdvml8m2K
         bPLZU9dr2kF24FbfiJNOEghc3yB/VJxQxIa7c2WezR9rxZjnRKufuAUS4lVNCL5Pqh
         RTlAo5cflvA9NT77qsYpuMdRv8jsZbaof/OoFtQtaFLg766MGWkZuyU3J4UhHSAJiY
         xhiyT5p5qkcDxgYlnnBHZMzHydxTgKHbCbOrV+oNYVJM0a4ZX6/LC9eqGEpwlilvOZ
         WULafu+90t2+xpcLSTkB+anNeyelSC/AbyA+vCyAq1nXWqrpyA7lL3aDkaxgq5Bloj
         /4guKsCNIRDew==
Received: by mail-ej1-f52.google.com with SMTP id kt17so1870125ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 10:27:24 -0700 (PDT)
X-Gm-Message-State: AAQBX9dfSFpCoZ7/YANxCexfB7G9pnnZW5tRoYuKt4+P5c10tul09INt
        cwp7rvMpQmS6BolJ26+jySXLFO2zwK/eC/uZiZMV0Q==
X-Google-Smtp-Source: AKy350YXLeIcOBPTgzinX4kAkaHfEK04D3VhIlVixKS5qQj/f8lgUmQV3CEoVMiYtH/ujRuLTWnubX1ZcPlMgh14rdE=
X-Received: by 2002:a17:907:742:b0:930:310:abc9 with SMTP id
 xc2-20020a170907074200b009300310abc9mr4166533ejb.9.1681147642884; Mon, 10 Apr
 2023 10:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230308073201.3102738-3-avagin@google.com>
 <ZDDddj50KZInqa84@chenyu5-mobl1> <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
In-Reply-To: <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 10 Apr 2023 10:27:10 -0700
X-Gmail-Original-Message-ID: <CALCETrVBVTDxUdKtPuaD35KVfUWihxNbTY2Ks65oGbzf8Yfm=w@mail.gmail.com>
Message-ID: <CALCETrVBVTDxUdKtPuaD35KVfUWihxNbTY2Ks65oGbzf8Yfm=w@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Chen Yu <yu.c.chen@intel.com>, Andrei Vagin <avagin@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 9, 2023 at 9:56=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wrot=
e:
>
> On Fri, Apr 7, 2023 at 8:20=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrot=
e:
> >
> > On 2023-03-07 at 23:31:57 -0800, Andrei Vagin wrote:
> > > From: Peter Oskolkov <posk@google.com>
> > >
> > > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > > move the wakee to the current CPU. This is useful for fast on-CPU
> > > context switching use cases.
> > >
> > > In addition, make ttwu external rather than static so that
> > > the flag could be passed to it from outside of sched/core.c.
> > >
> > > Signed-off-by: Peter Oskolkov <posk@google.com>
> > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, int=
 prev_cpu, int wake_flags)
> > >       if (wake_flags & WF_TTWU) {
> > >               record_wakee(p);
> > >
> > > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > > +                     return cpu;
> > > +
> > I tried to reuse WF_CURRENT_CPU to mitigate the cross-cpu wakeup, howev=
er there
> > are regressions when running some workloads, and these workloads want t=
o be
> > spreaded on idle CPUs whenever possible.
> > The reason for the regression is that, above change chooses current CPU=
 no matter
> > what the load/utilization of this CPU is. So task are stacked on 1 CPU =
and hurts
> > throughput/latency. And I believe this issue would be more severe on sy=
stem with
> > smaller number of CPU within 1 LLC(when compared to Intel platforms), s=
uch as AMD,
> > Arm64.
>
> WF_CURRENT_CPU works only in certain conditions. Maybe you saw my
> attempt to change how WF_SYNC works:
>
> https://www.spinics.net/lists/kernel/msg4567650.html
>
> Then we've found that this idea doesn't work well, and it is a reason
> why we have the separate WF_CURRENT_CPU flag.
>
> >
> > I know WF_CURRENT_CPU benefits seccomp, and can we make this change mor=
e genefic
> > to benefit other workloads, by making the condition to trigger WF_CURRE=
NT_CPU stricter?
> > Say, only current CPU has 1 runnable task, and treat current CPU as the=
 last resort by
> > checking if the wakee's previous CPU is not idle. In this way, we can e=
nable WF_CURRENT_CPU flag
> > dynamically when some condition is met(a short task for example).
>
> We discussed all of these here and here:
>
> https://www.spinics.net/lists/kernel/msg4657545.html
>
> https://lore.kernel.org/lkml/CANaxB-yWkKzhhPMGXCQbtjntJbqZ40FL2qtM2hk7LLW=
E-ZpbAg@mail.gmail.com/
>
> I like your idea about short-duration tasks, but I think it is a
> separate task and it has to be done in a separate patch set. Here, I
> solve the problem of optimizing synchronous switches when one task wakes
> up another one and falls asleep immediately after that. Waking up the
> target task on the current CPU looks reasonable for a few reasons in
> this case. First, waking up a task on the current CPU is cheaper than on
> another one and it is much cheaper than waking on an idle cpu.  Second,
> when tasks want to do synchronous switches, they often exchange some
> data, so memory caches can play on us.

I've contemplated this on occasion for quite a few years, and I think
that part of our issue is that the userspace ABI part doesn't exist
widely.  In particular, most of the common ways that user tasks talk
to each other don't have a single system call that can do the
send-a-message-and-start-waiting part all at once.  For example, if
task A is running and it wants to wake task B and then sleep:

UNIX sockets (or other sockets): A calls send() or write() or
sendmsg() then recv() or read() or recvmsg() or epoll_wait() or poll()
or select().

Pipes: Same as sockets except no send/recv.

Shared memory: no wakeup or sleep mechanism at all. UMONITOR doesn't count =
:)

I think io_uring can kind of do a write-and-wait operation, but I
doubt it's wired up for this purpose.


seccomp seems like it should be able to do this straightforwardly on
the transition from the seccomp-sandboxed task to the monitor, but the
reverse direction is tricky.



Anyway, short of a massive API project, I don't see a totally
brilliant solution.  But maybe we could take a baby step toward a
general solution by deferring all the hard work of a wakeup a bit so
that, as we grow syscalls and other mechanisms that do wake-and-wait,
we can optimize them automatically.  For example, we could perhaps add
a pending wakeup to task_struct, kind of like:

struct task_struct *task_to_wake;

and then, the next time we sleep or return to usermode, we handle the
wakeup.  And if we're going to sleep, we can do it as an optimized
synchronous wakeup.  And if we try to wake a task while task_to_wake
is set, we just wake everything normally.

(There are refcounting issues here, and maybe this wants to be percpu,
not per task.)

I think it would be really nifty if Linux could somewhat reliably do
this style of synchronous con

PeterZ, is this at all sensible or am I nuts?

--Andy
