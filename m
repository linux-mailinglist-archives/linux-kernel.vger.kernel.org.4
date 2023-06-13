Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023C472EDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbjFMVbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFMVbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:31:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E5319B6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:31:19 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3409d944009so2795ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686691879; x=1689283879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHiplLldqs8StTkBOxaUBgWS+U0FnghVyW4LVhK4+ao=;
        b=7ptynPiofmHtSihnemIuGl8iAKCp+wgVoYQFtx1Yrunyh2vmQYOeStZROmZs87tDnr
         Vi3tyhr6o2XOc0t+o7fH40+p11eRX2z+rwrJHyUdbb8SS/FXjKg6c69b+WIYAbc7uKfh
         OpIDKTfnou9fmKaQw0t1liTb59FQp3O95M6K6RA0VtJh/1ALmnP+fs+88ypG+lKHRgs3
         3QbhzgaZbwZ+kVkNGT4Vowb2Qt1cXrU+rqtTxx7vUj6LY199B0qyLocRkyfIb4ygRbBK
         h6oxSrrvN1VMCIzVG6bmuqgRUSSeB9n7/kAGAb1Z0sg4lTu4o1s2Sje4FQ+grWb5HYea
         6rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686691879; x=1689283879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHiplLldqs8StTkBOxaUBgWS+U0FnghVyW4LVhK4+ao=;
        b=FTodkLpZh5u7ZCxXGnWlo573BfMh1XW4FDDDmPFOOYDL9UJKdc4Hyn7BokO0/rQBDw
         1y1Iob4bFTHka6DE4IV01C0j5lXaT90Enh+tBRF8ewKKxNWJI0NkKg9JU02Vl9v/Leap
         aYuNGrWE69LddviYhmAdpcRDrvc405gWVMo2nTO89CVuIVWmqTs4lZ7HIrgytzUypBCz
         3MEZZBjDxj1MEXnTDkeoKG0wSZNP8T6W1+69OIjMpYc8F5CUVAxbPtBlDpoxkvWhm4ku
         mo8qCQpeXHHYgVZGpP/9Z3I2ixYCedzjIWm7UamzLPJEsQ2hxw6mjwHK/xDF1UP30B8x
         Guww==
X-Gm-Message-State: AC+VfDyxKxFBX6+FGgzoXreaPzBRFQYhZiAJSKPu51n+VMDrt+AY7DcV
        sxhIchq0ORjwCbuBWxEc7o3RpAs01XYJ0w9jmJmj
X-Google-Smtp-Source: ACHHUZ5RpILx8ZmepUai3ca1XkjF3I4umpSz9jXNbJu/gSbqft0PB9qE5MWFrwod/JZLIenVqb9SlJz3T7Xt1IRPusg=
X-Received: by 2002:a05:6e02:1b06:b0:340:502b:1487 with SMTP id
 i6-20020a056e021b0600b00340502b1487mr79874ilv.12.1686691878870; Tue, 13 Jun
 2023 14:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230601055846.2349566-1-jstultz@google.com> <cbcbe3e3-e657-25f2-199d-ce78711545bd@arm.com>
In-Reply-To: <cbcbe3e3-e657-25f2-199d-ce78711545bd@arm.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 13 Jun 2023 14:31:05 -0700
Message-ID: <CANDhNCrUd_eistcitQU4im1H=GZVNh09RLzJZLTQFAZFLbAbCw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Generalized Priority Inheritance via Proxy
 Execution v3
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 13, 2023 at 10:36=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 01/06/2023 07:58, John Stultz wrote:
> > After having to catch up on other work after OSPM[1], I've finally
> > gotten back to focusing on Proxy Execution and wanted to send out this
> > next iteration of the patch series for review, testing, and feedback.
> > (Many thanks to folks who provided feedback on the last revision!)
> >
> > As mentioned previously, this Proxy Execution series has a long history=
:
> > First described in a paper[2] by Watkins, Straub, Niehaus, then from
> > patches from Peter Zijlstra, extended with lots of work by Juri Lelli,
> > Valentin Schneider, and Connor O'Brien. (and thank you to Steven Rosted=
t
> > for providing additional details here!)
> >
> > So again, many thanks to those above, as all the credit for this series
> > really is due to them - while the mistakes are likely mine.
> >
> > Overview:
> > =E2=80=94----------
> > Proxy Execution is a generalized form of priority inheritance. Classic
> > priority inheritance works well for real-time tasks where there is a
> > straight forward priority order to how things are run. But it breaks
> > down when used between CFS or DEADLINE tasks, as there are lots
> > of parameters involved outside of just the task=E2=80=99s nice value wh=
en
> > selecting the next task to run (via pick_next_task()).  So ideally we
> > want to imbue the mutex holder with all the scheduler attributes of
> > the blocked waiting task.
> >
> > Proxy Execution does this via a few changes:
> > * Keeping tasks that are blocked on a mutex *on* the runqueue
> > * Keeping additional tracking of which mutex a task is blocked on, and
> >   which task holds a specific mutex.
> > * Special handling for when we select a blocked task to run, so that we
> >   instead run the mutex holder.
> >
> > The first of these is the most difficult to grasp (I do get the mental
> > friction here: blocked tasks on the *run*queue sounds like nonsense!
> > Personally I like to think of the runqueue in this model more like a
> > =E2=80=9Ctask-selection queue=E2=80=9D).
> >
> > By leaving blocked tasks on the runqueue, we allow pick_next_task() to
> > choose the task that should run next (even if it=E2=80=99s blocked wait=
ing on a
> > mutex). If we do select a blocked task, we look at the task=E2=80=99s b=
locked_on
> > mutex and from there look at the mutex=E2=80=99s owner task. And in the=
 simple
> > case, the task which owns the mutex is what we then choose to run,
> > allowing it to release the mutex.
> >
> > This means that instead of just tracking =E2=80=9Ccurr=E2=80=9D, the sc=
heduler needs to
> > track both the scheduler context (what was picked and all the state use=
d
> > for scheduling decisions), and the execution context (what we=E2=80=99r=
e
> > running)
> >
> > In this way, the mutex owner is run =E2=80=9Con behalf=E2=80=9D of the =
blocked task
> > that was picked to run, essentially inheriting the scheduler context of
> > the blocked task.
> >
> > As Connor outlined in a previous submission of this patch series,  this
> > raises a number of complicated situations:  The mutex owner might itsel=
f
> > be blocked on another mutex, or it could be sleeping, running on a
> > different CPU, in the process of migrating between CPUs, etc.
> >
> > But the functionality provided by Proxy Execution is useful, as in
> > Android we have a number of cases where we are seeing priority inversio=
n
> > (not unbounded, but longer than we=E2=80=99d like) between =E2=80=9Cfor=
eground=E2=80=9D and
> > =E2=80=9Cbackground=E2=80=9D SCHED_NORMAL applications, so having a gen=
eralized solution
> > would be very useful.
> >
> > New in v4:
> > =E2=80=94------
> > * Fixed deadlock that was caused by wait/wound mutexes having circular
> >   blocked_on references by clearing the blocked_on pointer on the task
> >   we are waking to wound/die.
>
> I always get this when running `insmod ./test-ww_mutex.ko` with default
> SCHED_FEAT(TTWU_QUEUE, true) with this fix. Don't understand the issue
> fully yet:
>
> qemu-system-x86_64 ... -smp cores=3D64 -enable-kvm ...
>
> [   21.109134] Beginning ww mutex selftests
> [   26.397545] ------------[ cut here ]------------
> [   26.397951] WARNING: CPU: 41 PID: 0 at kernel/sched/core.c:4126 sched_=
ttwu_pending+0xc5/0x120

Thanks for testing it out and sharing this!

Yeah. I've seen this as well, and I suspect this is tied to the
runqueue accounting issues that are causing the null sched entity
issue I've been chasing.

One issue seems to be the blocked_on manipulation done in the
try_to_wakeup() path. For mutex blocked tasks, try_to_wakeup() needs
to clear blocked_on so the task can actually run and try to acquire
the mutex. This is why __mutex_lock_slowpath_common() sets blocked_on
twice.  I'm seeing some trouble where try_to_wakeup() ends up
migrating the still technically blocked task (as it's not yet acquired
the mutex, just waking to try to take it) back to the p->wake_cpu -
but the issue is that the task has not been deactivated from the
current runqueue.

The "fix" for ww_mutex circular dependencies resolution in
__ww_mutex_die() is similar, as it clears the blocked_on value and
tries to wake the task, but then ttwu often migrates the task without
deactivating it from the current rq.

Unfortunately once the rq accounting is gone wrong, the failures seem
multi-modal, so trying to get enough tracing logs in place to get your
head around what's going wrong in one case is hard because run-to-run
it will fail differently.

In my current tree I've extended this so we have a separate
task->blocked_on_waking flag, so we don't mess with the
task->blocked_on state in ttwu & __wwmutex_die and can distinguish
between waking a blocked task and waking an unblocked task.  However
that in itself isn't working yet, so I'm currently deconstructing the
patch series a bit to try to understand that logic better and if we
can avoid special casing as much in the ttwu path (I'd like to be able
to take mutex blocked tasks and also just drop them from the runqueue
- as we do now - and have things work so we have fallback options if
proxy() migrations are taking too long to resolve).

thanks
-john
