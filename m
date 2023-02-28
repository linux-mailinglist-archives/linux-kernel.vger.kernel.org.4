Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE06A552A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjB1JHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1JHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:07:43 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E7168B2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:07:41 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id bd34so5246737pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k+ZNkX1kcQ6GgSlRwPux2sQyIByKnC/CxsWIGexr64=;
        b=tukSIT/bo95pttzgxPyg7KI0CjTGxGbc2JmKO6rws8CfAHISwDDQMgPQ5X/SnMFuGN
         IYDY//yVT66tgwRij1AL+SHWcKTZGHqR4eFmdXUejXi8UDcIdFs3kE4tBCQZTYYDY/e8
         zWaZ3Y8RNy+cuD4nkADnLJcBUHFdmIVlwtAt7yqcRW9cqBjOysGRGIOdl3GkfDv121Fa
         8AMQmp8Uqj3QAXKl5WuSSxS85K4NyE+ZybmHdinxNxyl4qRqbmKzHUqyZ87ejm6t3yOg
         1OQ91y2Hat/OMZidizZiiATrlBWzFPcIH4tQBbN/apVrwzPvCUjroAg9CU/IAMOOYLrY
         U6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k+ZNkX1kcQ6GgSlRwPux2sQyIByKnC/CxsWIGexr64=;
        b=QOjVrbwQFOTQtKPpN59z01monh9bW4BU1FyoIKG/Q05JE1xiAvWapgNmn8rJPgaJ89
         qhf105HXjP8rTKaTtT5JQUdoKQcNVqnE4nS2epCBS20vFXUr2PmZTdR/Nlde/6pGrJlB
         4Sa+nsQjdMGFZXjPRwQ8mNvj5wMFOQ9gjdiQrGiZWIGOoyDRD12M8c1MDPLZv42ZXGBY
         +gDA6gK7CDd2+qrSPYtInQqjcV/orb8ZFstdJlJwUNhVK5Vqviz5WgDQm+HFwAG4QxMC
         kYzPQV6JG9YeeVCCLeBfqZqIiwZ1n0o20hj35w7vjxDQ4aPgA37s7kgH+NVwT9XuRz/n
         pHhQ==
X-Gm-Message-State: AO0yUKWNmaHVDqbFy9r8Cyco1DkJue2CILWAa5blxsXT2I07mEx3KDQ4
        glD4p8AW/5ehTbHqQQ+u/aN3fKFlGBCDzNUV+y4lEw==
X-Google-Smtp-Source: AK7set/32ZRZETHlILM1xCNJIkduqRXl24oMYb/h25BmLgL1jhnc+qeUqiWNLtBCUszDPSTNbFoHjD+YKnAHXJXzfwA=
X-Received: by 2002:a63:a74a:0:b0:503:8225:44ac with SMTP id
 w10-20020a63a74a000000b00503822544acmr2183pgo.3.1677575260757; Tue, 28 Feb
 2023 01:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com> <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
In-Reply-To: <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Feb 2023 10:07:29 +0100
Message-ID: <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 at 09:21, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>
> Hi Vincent
>
> On Tue, Feb 28, 2023 at 3:53=E2=80=AFPM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.com> wrote=
:
> > >
> > > Hi
> > >
> > > Thanks very much for comments!
> > >
> > > On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Qais Yousef <qyousef@layalina=
.io> wrote:
> > > >
> > > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > > > > > When task call the sched_yield, cfs would set the cfs's skip bu=
ddy.
> > > > > > If there is no other task call the sched_yield syscall, the tas=
k would
> > > > > > always be skiped when there are tasks in rq.
> > > > >
> > > > > So you have two tasks A) which does sched_yield() and becomes ->s=
kip,
> > > > > and B) which is while(1). And you're saying that once A does it's=
 thing,
> > > > > B runs forever and starves A?
> > > >
> > > > I read it differently.
> > > >
> > > > I understood that there are multiple tasks.
> > > >
> > > > If Task A becomes ->skip; then it seems other tasks will continue t=
o be picked
> > > > instead. Until another task B calls sched_yield() and become ->skip=
, then Task
> > > > A is picked but with wrong vruntime causing it to run for multiple =
ticks (my
> > > > interpretation of 'always run' below).
> > > >
> > > > There are no while(1) task running IIUC.
> > > >
> > > > >
> > > > > > As a result, the task's
> > > > > > vruntime would not be updated for long time, and the cfs's min_=
vruntime
> > > > > > is almost not updated.
> > > > >
> > > > > But the condition in pick_next_entity() should ensure that we sti=
ll pick
> > > > > ->skip when it becomes too old. Specifically, when it gets more t=
han
> > > > > wakeup_gran() behind.
> > > >
> > > > I am not sure I can see it either. Maybe __pick_first_entity() does=
n't return
> > > > the skipped one, or for some reason vdiff for second is almost alwa=
ys
> > > > < wakeup_gran()?
> > > >
> > > > >
> > > > > > When this scenario happens, when the yield task had wait for a =
long time,
> > > > > > and other tasks run a long time, once there is other task call =
the sched_yield,
> > > > > > the cfs's skip_buddy is covered, at this time, the first task c=
an run normally,
> > > > > > but the task's vruntime is small, as a result, the task would a=
lways run,
> > > > > > because other task's vruntime is big. This would lead to other =
tasks can not
> > > > > > run for a long time.
> > > >
> > > > The error seems that when Task A finally runs - it consumes more th=
an its fair
> > > > bit of sched_slice() as it looks it was starved.
> > > >
> > > > I think the question is why it was starved? Can you shed some light=
 Xuewen?
> > > >
> > > > My attempt to help to clarify :) I have read this just like you.
> > >
> > > Thanks for Qais's clarify. And that's exactly what I want to say:)
> > >
> > > >
> > > > FWIW I have seen a report of something similar, but I didn't manage=
d to
> > > > reproduce and debug (mostly due to ENOBANDWIDTH); and not sure if t=
he details
> > > > are similar to what Xuewen is seeing. But there was a task starving=
 for
> > > > multiple ticks - RUNNABLE but never RUNNING in spite of other tasks=
 getting
> > > > scheduled in instead multiple times. ie: there was a task RUNNING f=
or most of
> > > > the time, and I could see it preempted by other tasks multiple time=
, but not by
> > > > the starving RUNNABLE task that is hung on the rq. It seems to be v=
runtime
> > > > related too but speculating here.
> > >
> > > Yes, now we met the similar scenario when running a monkey test on th=
e
> > > android phone.
> > > There are multiple tasks on cpu, but the runnable task could not be
> > > got scheduled for a long time,
> > > there is task running and we could see the task preempted by other
> > > tasks multiple times.
> > > Then we dump the tasks, and find the vruntime of each task varies
> > > greatly, and the task which running call the sched_yield frequently.
> >
> > If I'm not wrong you are using cgroups and as a result you can't
> > compare the vruntime of tasks that belongs to different group, you
> > must compare the vruntime of entities at the same level. We might have
> > to look the side because I can't see why the task would not be
> > schedule if other tasks in the same group move forward their vruntime
>
> All the tasks belong to the same cgroup.

ok.
I have tried to reproduce your problem but can't see it so far. I'm
probably missing something.

With rt-app, I start:
- 3 tasks A, B, C which are always running
- 1 task D which always runs but yields every 1ms for 1000 times and
then stops yielding and always run

All tasks are pinned on the same cpu in the same cgroup.

I don't see anything wrong.
task A, B, C runs their slices
task D is preempted by others after 1ms for a couple of times when it
calls yield. Then the yield doesn't have effect and task D runs a few
consecutive ms although the yield. Then task D restart to be preempted
by others when it calls yield when its vruntime is close to others

Once task D stop calling yield, the 4 tasks runs normally

Vincent
>
> Thanks=EF=BC=81
>
> >
> > > So we suspect that sched_yield affects the task's vruntime, as
> > > previously described=EF=BC=8Cthe yield's task's vruntime is too small=
.
> > >
> > > There are some tasks's vruntime as follow:
> > >
> > > [status: curr] pid: 25501 prio: 116 vrun: 16426426403395799812
> > > [status: skip] pid: 25496 prio: 116 vrun: 16426426403395800756
> > > exec_start: 326203047009312 sum_ex: 29110005599
> > > [status: pend] pid: 25497 prio: 116 vrun: 16426426403395800705
> > > exec_start: 326203047002235 sum_ex: 29110508751
> > > [status: pend] pid: 25496 prio: 116 vrun: 16426426403395800756
> > > exec_start: 326203047009312 sum_ex: 29110005599
> > > [status: pend] pid: 25498 prio: 116 vrun: 16426426403395803053
> > > exec_start: 326203046944427 sum_ex: 28759519211
> > > [status: pend] pid: 25321 prio: 130 vrun: 16668783152248554223
> > > exec_start: 0 sum_ex: 16198728
> > > [status: pend] pid: 25798 prio: 112 vrun: 17467381818375696015
> > > exec_start: 0 sum_ex: 9574265
> > > [status: pend] pid: 24650 prio: 120 vrun: 17811488667922679996
> > > exec_start: 0 sum_ex: 4069384
> > > [status: pend] pid: 26082 prio: 120 vrun: 17876565509001103803
> > > exec_start: 0 sum_ex: 1184039
> > > [status: pend] pid: 22282 prio: 120 vrun: 18010356387391134435
> > > exec_start: 0 sum_ex: 53192
> > > [status: pend] pid: 16714 prio: 120 vrun: 18136518279692783235
> > > exec_start: 0 sum_ex: 53844952
> > > [status: pend] pid: 26188 prio: 120 vrun: 18230794395956633597
> > > exec_start: 0 sum_ex: 13248612
> > > [status: pend] pid: 17645 prio: 120 vrun: 18348420256270370795
> > > exec_start: 0 sum_ex: 4774925
> > > [status: pend] pid: 24259 prio: 120 vrun: 359915144918430571
> > > exec_start: 0 sum_ex: 20508197
> > > [status: pend] pid: 25988 prio: 120 vrun: 558552749871164416
> > > exec_start: 0 sum_ex: 2099153
> > > [status: pend] pid: 21857 prio: 124 vrun: 596088822758688878
> > > exec_start: 0 sum_ex: 246057024
> > > [status: pend] pid: 26614 prio: 130 vrun: 688210016831095807
> > > exec_start: 0 sum_ex: 968307
> > > [status: pend] pid: 14229 prio: 120 vrun: 816756964596474655
> > > exec_start: 0 sum_ex: 793001
> > > [status: pend] pid: 23866 prio: 120 vrun: 1313723379399791578
> > > exec_start: 0 sum_ex: 1507038
> > > [status: pend] pid: 23389 prio: 120 vrun: 1351598627096913799
> > > exec_start: 0 sum_ex: 1648576
> > > [status: pend] pid: 25118 prio: 124 vrun: 2516103258334576715
> > > exec_start: 0 sum_ex: 270423
> > > [status: pend] pid: 26412 prio: 120 vrun: 2674093729417543719
> > > exec_start: 0 sum_ex: 1851229
> > > [status: pend] pid: 26271 prio: 112 vrun: 2728945479807426354
> > > exec_start: 0 sum_ex: 3347695
> > > [status: pend] pid: 24236 prio: 120 vrun: 2919301292085993527
> > > exec_start: 0 sum_ex: 5425846
> > > [status: pend] pid: 22077 prio: 120 vrun: 3262582494560783155
> > > exec_start: 325875071065811 sum_ex: 177555259
> > > [status: pend] pid: 18951 prio: 120 vrun: 3532786464053787829
> > > exec_start: 0 sum_ex: 2634964
> > > [status: pend] pid: 18957 prio: 120 vrun: 3532786464053920593
> > > exec_start: 0 sum_ex: 95538
> > > [status: pend] pid: 18914 prio: 131 vrun: 3532786465880282335
> > > exec_start: 0 sum_ex: 6374535
> > > [status: pend] pid: 17595 prio: 120 vrun: 4839728055620845452
> > > exec_start: 0 sum_ex: 29559732
> > > [status: pend] pid: 32520 prio: 120 vrun: 5701873672841711178
> > > exec_start: 0 sum_ex: 21486313
> > > [status: pend] pid: 24287 prio: 120 vrun: 5701873673743456663
> > > exec_start: 0 sum_ex: 757778741
> > > [status: pend] pid: 25544 prio: 120 vrun: 6050206507780284054
> > > exec_start: 0 sum_ex: 13624309
> > > [status: pend] pid: 26049 prio: 130 vrun: 6144859778903604771
> > > exec_start: 0 sum_ex: 20931577
> > > [status: pend] pid: 26848 prio: 130 vrun: 6144859796032488859
> > > exec_start: 0 sum_ex: 2541963
> > > [status: pend] pid: 21450 prio: 120 vrun: 6451880484497196814
> > > exec_start: 0 sum_ex: 83490289
> > > [status: pend] pid: 15765 prio: 120 vrun: 6479239764142283860
> > > exec_start: 0 sum_ex: 1481737271
> > > [status: pend] pid: 16366 prio: 120 vrun: 6479239764269019562
> > > exec_start: 0 sum_ex: 952608921
> > > [status: pend] pid: 16086 prio: 120 vrun: 6479239764301244958
> > > exec_start: 0 sum_ex: 37393777
> > > [status: pend] pid: 25970 prio: 120 vrun: 6830180148220001175
> > > exec_start: 0 sum_ex: 2531884
> > > [status: pend] pid: 25965 prio: 120 vrun: 6830180150700833203
> > > exec_start: 0 sum_ex: 8031809
> > > [status: pend] pid: 14098 prio: 120 vrun: 7018832854764682872
> > > exec_start: 0 sum_ex: 32975920
> > > [status: pend] pid: 26860 prio: 116 vrun: 7086059821707649029
> > > exec_start: 0 sum_ex: 246173830
> > >
> > >
> > > Thanks=EF=BC=81
> > > BR
> > > >
> > > >
> > > > Cheers
> > > >
> > > > --
> > > > Qais Yousef
> > > >
> > > > >
> > > > > I'm not seeing how this could happen, it should never get behind =
that
> > > > > far.
> > > > >
> > > > > Additionally, check_preempt_tick() will explicitly clear the budd=
ies
> > > > > when it finds the current task has consumed it's ideal slice.
> > > > >
> > > > > I really cannot see how your scenario can happen.
> > > > >
> > > > > > In order to mitigate this, update the yield_task's vruntime to =
be cfs's max vruntime.
> > > > > > This way, the cfs's min vruntime can be updated as the process =
running.
> > > > >
> > > > > This is a bad solution, SCHED_IDLE tasks have very low weight and=
 can be
> > > > > shot really far to the right, leading to other trouble.
> > > > >
