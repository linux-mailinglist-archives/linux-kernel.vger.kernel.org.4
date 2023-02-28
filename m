Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501656A5A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjB1NrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjB1NrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:47:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6B62FCE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:46:35 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so13756160pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 05:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zlc1mADyb2gJA0Cw8yGLqvsuAJJQSseXYNYd/pG/Xzw=;
        b=y9qS8oh39+WbqTE7BuEYkb64gM398LyJ7EyVm/X7AAgllrkEDY3ZDUxN/P8+Wezr5G
         Ao+SfGQavZvXHVpCp8CC8GFfPq2n3JUStcQ7KiTDvDq6tITt0GCGfaQsQ1qF+cV6qGAX
         M3kaImCUAC6OG726SWjDFv4DWsVUT3fEd3JydLd0X0TtYltVo8gKWGDclB9Y34HDFTdt
         5LzN1EI2meXNLrblM7DT/ePv6z13+zlyX639wZrGAwP7KkNN8i126FI75ES0AJ6B5zoJ
         QL9fJAbWxBo/lz/epNQpblM1NQIsr7cnKYzS6tK398zAfCC6Jfr9y5WTIJrxOz8JUh54
         t7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlc1mADyb2gJA0Cw8yGLqvsuAJJQSseXYNYd/pG/Xzw=;
        b=3HCGRuNzcKX+JvHE3tnhrRh2LC7lnyLayakvxXn8q7lDnkDm0WXWiMnwN1xTOvvp2T
         Bc001RAHU+hfXKq1KvncXjuzcU+BfcHNqH+tWuhinmzdKw8IcTT5lp0H+V/LgdOo4wYI
         SONX6njFGuyec7i10e4R6aBqmmu+b8XuMU/SM8L+G65ES7f7+TpC51ejpVxGa3sjuh1O
         iOwPVYxc2ms3YLqlLENmnISEMLPzx+NR3w/u2AgQpvcEbJ/jF/WUVFPNxk8G4WtlZji3
         yOABRz9Bud615gJpYgxtsXW9Uj2ZF/6k6pdAExPZw6Iyyc1vPPOfosOgHr75f4gzZ1fL
         t+Lg==
X-Gm-Message-State: AO0yUKVFllDTlU0M6WhBJsENv2KiVXduTuI0pJLyS5Xx9BF40+H/ntbG
        +HXYda001cTgdQZinPFhweWVJOnmsyFMJVKQHNN2Yw==
X-Google-Smtp-Source: AK7set+dLsLozTjKN+7zdrEMJxmYHh8XNHnkDDqlLoV3B+Fiqu++uoM9VeCmmw4EuVCMFnEQ4cYMP2bdFjDYCAW/Txs=
X-Received: by 2002:a17:903:2792:b0:194:6fc1:801f with SMTP id
 jw18-20020a170903279200b001946fc1801fmr994098plb.6.1677591947666; Tue, 28 Feb
 2023 05:45:47 -0800 (PST)
MIME-Version: 1.0
References: <20230222080314.2146-1-xuewen.yan@unisoc.com> <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
 <20230227220735.3kaytmtt53uoegq7@airbuntu> <CAB8ipk--trBk-Acsjz7YDb5szPLc93ejPXVXQBJdomZO4OrpGQ@mail.gmail.com>
 <CAKfTPtBdMO6_APib1OBxW+fdAORX8vXdT-W3fWTRffa5-8bGxQ@mail.gmail.com>
 <CAB8ipk96OXJcmp_H5EcagrMUigSFdW_gd4wwGjfjBpyP6hqaTg@mail.gmail.com>
 <CAKfTPtAvuz0SEDX3izcOhZkC+pFddqrSwY+iYO2p7U6N3Z2hRA@mail.gmail.com> <20230228133111.6i5tlhvthnfljvmf@airbuntu>
In-Reply-To: <20230228133111.6i5tlhvthnfljvmf@airbuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 28 Feb 2023 14:45:36 +0100
Message-ID: <CAKfTPtAsxz7s6W2peoVj+EcNVQp6bpO6qhPPTXgfJxVtXHbaKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>,
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

On Tue, 28 Feb 2023 at 14:31, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 02/28/23 10:07, Vincent Guittot wrote:
> > On Tue, 28 Feb 2023 at 09:21, Xuewen Yan <xuewen.yan94@gmail.com> wrote=
:
> > >
> > > Hi Vincent
> > >
> > > On Tue, Feb 28, 2023 at 3:53=E2=80=AFPM Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > > >
> > > > On Tue, 28 Feb 2023 at 08:42, Xuewen Yan <xuewen.yan94@gmail.com> w=
rote:
> > > > >
> > > > > Hi
> > > > >
> > > > > Thanks very much for comments!
> > > > >
> > > > > On Tue, Feb 28, 2023 at 6:33=E2=80=AFAM Qais Yousef <qyousef@laya=
lina.io> wrote:
> > > > > >
> > > > > > On 02/27/23 16:40, Peter Zijlstra wrote:
> > > > > > > On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > > > > > > > When task call the sched_yield, cfs would set the cfs's ski=
p buddy.
> > > > > > > > If there is no other task call the sched_yield syscall, the=
 task would
> > > > > > > > always be skiped when there are tasks in rq.
> > > > > > >
> > > > > > > So you have two tasks A) which does sched_yield() and becomes=
 ->skip,
> > > > > > > and B) which is while(1). And you're saying that once A does =
it's thing,
> > > > > > > B runs forever and starves A?
> > > > > >
> > > > > > I read it differently.
> > > > > >
> > > > > > I understood that there are multiple tasks.
> > > > > >
> > > > > > If Task A becomes ->skip; then it seems other tasks will contin=
ue to be picked
> > > > > > instead. Until another task B calls sched_yield() and become ->=
skip, then Task
> > > > > > A is picked but with wrong vruntime causing it to run for multi=
ple ticks (my
> > > > > > interpretation of 'always run' below).
> > > > > >
> > > > > > There are no while(1) task running IIUC.
> > > > > >
> > > > > > >
> > > > > > > > As a result, the task's
> > > > > > > > vruntime would not be updated for long time, and the cfs's =
min_vruntime
> > > > > > > > is almost not updated.
> > > > > > >
> > > > > > > But the condition in pick_next_entity() should ensure that we=
 still pick
> > > > > > > ->skip when it becomes too old. Specifically, when it gets mo=
re than
> > > > > > > wakeup_gran() behind.
> > > > > >
> > > > > > I am not sure I can see it either. Maybe __pick_first_entity() =
doesn't return
> > > > > > the skipped one, or for some reason vdiff for second is almost =
always
> > > > > > < wakeup_gran()?
> > > > > >
> > > > > > >
> > > > > > > > When this scenario happens, when the yield task had wait fo=
r a long time,
> > > > > > > > and other tasks run a long time, once there is other task c=
all the sched_yield,
> > > > > > > > the cfs's skip_buddy is covered, at this time, the first ta=
sk can run normally,
> > > > > > > > but the task's vruntime is small, as a result, the task wou=
ld always run,
> > > > > > > > because other task's vruntime is big. This would lead to ot=
her tasks can not
> > > > > > > > run for a long time.
> > > > > >
> > > > > > The error seems that when Task A finally runs - it consumes mor=
e than its fair
> > > > > > bit of sched_slice() as it looks it was starved.
> > > > > >
> > > > > > I think the question is why it was starved? Can you shed some l=
ight Xuewen?
> > > > > >
> > > > > > My attempt to help to clarify :) I have read this just like you=
.
> > > > >
> > > > > Thanks for Qais's clarify. And that's exactly what I want to say:=
)
> > > > >
> > > > > >
> > > > > > FWIW I have seen a report of something similar, but I didn't ma=
naged to
> > > > > > reproduce and debug (mostly due to ENOBANDWIDTH); and not sure =
if the details
> > > > > > are similar to what Xuewen is seeing. But there was a task star=
ving for
> > > > > > multiple ticks - RUNNABLE but never RUNNING in spite of other t=
asks getting
> > > > > > scheduled in instead multiple times. ie: there was a task RUNNI=
NG for most of
> > > > > > the time, and I could see it preempted by other tasks multiple =
time, but not by
> > > > > > the starving RUNNABLE task that is hung on the rq. It seems to =
be vruntime
> > > > > > related too but speculating here.
> > > > >
> > > > > Yes, now we met the similar scenario when running a monkey test o=
n the
> > > > > android phone.
> > > > > There are multiple tasks on cpu, but the runnable task could not =
be
> > > > > got scheduled for a long time,
> > > > > there is task running and we could see the task preempted by othe=
r
> > > > > tasks multiple times.
> > > > > Then we dump the tasks, and find the vruntime of each task varies
> > > > > greatly, and the task which running call the sched_yield frequent=
ly.
> > > >
> > > > If I'm not wrong you are using cgroups and as a result you can't
> > > > compare the vruntime of tasks that belongs to different group, you
> > > > must compare the vruntime of entities at the same level. We might h=
ave
> > > > to look the side because I can't see why the task would not be
> > > > schedule if other tasks in the same group move forward their vrunti=
me
> > >
> > > All the tasks belong to the same cgroup.
>
> Could they move between cpusets though?

I have pinned them on same  CPU to force the contention

>
> >
> > ok.
> > I have tried to reproduce your problem but can't see it so far. I'm
> > probably missing something.
> >
> > With rt-app, I start:
> > - 3 tasks A, B, C which are always running
> > - 1 task D which always runs but yields every 1ms for 1000 times and
> > then stops yielding and always run
> >
> > All tasks are pinned on the same cpu in the same cgroup.
> >
> > I don't see anything wrong.
> > task A, B, C runs their slices
> > task D is preempted by others after 1ms for a couple of times when it
> > calls yield. Then the yield doesn't have effect and task D runs a few
> > consecutive ms although the yield. Then task D restart to be preempted
> > by others when it calls yield when its vruntime is close to others
> >
> > Once task D stop calling yield, the 4 tasks runs normally
>
> Could vruntime be inflated if a task gets stuck on a little core for a wh=
ile
> (where it'll run slower) then compared to another task running on a bigge=
r core
> the vruntime will appear smaller for the latter?

vruntime is not scaled by cpu capacity and is "normalized" before the
task migrates to another cpu so there is no reason to see an impact
because on running on little or migrating

>
>
> Cheers
>
> --
> Qais Yousef
