Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E826E50C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjDQTZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjDQTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:25:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A6F4ECA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:25:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f0aabd1040so49682425e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681759510; x=1684351510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DypQbI9Beea3vxOJ/g/r8fFpYlaEHvGGbDv4nzRNF4M=;
        b=ktVxsgrTxwOwwhRuVlM2cJco0jyMIpc7nNwxbcXOCBBT3QJrkNwjgAPQ8bbNGPfjNQ
         TUCvnN0f6+3bZM5XlSCs76P3ebkh5Q6OW/BtWMs7lafviq/qk3oKyMiTlCjcIhbfIwX6
         DxfXQQNoWx2KK560GPGkFSeVrm8uT5OjBeknL2XfuFuq0A4sgzJ5ZX9Oq6yG+UjUie0P
         EywFU/jctoKVOBUZQauGNc568zaJu7IyxyRaFvkE4nNwX0j7nDO3j6V+NquZegGIfRdA
         lYlRIR4wyDqRe0Vf7j69ggFG+GxB5ZboOfmTKGKdxgr+jAAWNU8S1sGMWukq3a4JY3Lr
         xLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759510; x=1684351510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DypQbI9Beea3vxOJ/g/r8fFpYlaEHvGGbDv4nzRNF4M=;
        b=UyxaK37/pWSVFSRdIMGia4Fd8s4nFTRf0TAJ8naK2JLwTifAnTzDVfi91P7WCdu4t9
         vkA/sZnKnhay7NHTTIm3bOZ+8Z6Qu4/3+iYbNuR1y7qVnzvt6Qd5LaPD3m6iu2u3uC4g
         stas0TnC0zfqyaADKpHNqS2zT1vif/3lzyRBML0cPV2dikpC3IW9fI3ulzZQVwIu/WuY
         8317jfgkL9BbxqjbU+fW/zUDglFvhnxSWiuJNWears7KsHSgPOulbs1LE7gcznXM42kd
         85/bwi4wSLUcDR45OHpCDhfxmZo1jUgfIL3rN+v6zACfytZoSU0xe3SB0FRpVrJNDbiW
         Z5VQ==
X-Gm-Message-State: AAQBX9fTwaseGM+nDp1vrqYN1YLQ+sNo49j5RcbzZIAhonBdZgb/fKgN
        7jeceybhOuq/keuCWMJSrarM4DkqUD+w96Zrcm1+ug==
X-Google-Smtp-Source: AKy350bZetBnZjRbeR+rtUXIhg2WAzc4pxAs/e4rOaUGGFu6OByLaV+45K2E5u6YU6NQ6FYz4FGylytxxpd6NBAmjRk=
X-Received: by 2002:a5d:6a11:0:b0:2fa:7308:47a1 with SMTP id
 m17-20020a5d6a11000000b002fa730847a1mr25892wru.20.1681759510025; Mon, 17 Apr
 2023 12:25:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230308073201.3102738-1-avagin@google.com> <20230308073201.3102738-3-avagin@google.com>
 <ZDDddj50KZInqa84@chenyu5-mobl1> <CANaxB-y0eDExPB0v=LRPyoz1e-3tJ2VuuCmYJ3qkAERpnbz+aQ@mail.gmail.com>
 <ZDRSmC5tJiKZfMnE@chenyu5-mobl1>
In-Reply-To: <ZDRSmC5tJiKZfMnE@chenyu5-mobl1>
From:   Andrei Vagin <avagin@google.com>
Date:   Mon, 17 Apr 2023 12:24:59 -0700
Message-ID: <CAEWA0a5jP+pigtqa9uS4mA0TpiDb5+pubhcPU+D1CyDuW4vhSw@mail.gmail.com>
Subject: Re: [PATCH 2/6] sched: add WF_CURRENT_CPU and externise ttwu
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
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

On Mon, Apr 10, 2023 at 11:17=E2=80=AFAM Chen Yu <yu.c.chen@intel.com> wrot=
e:
>
> On 2023-04-09 at 21:56:26 -0700, Andrei Vagin wrote:
> > On Fri, Apr 7, 2023 at 8:20=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wr=
ote:
> > >
> > > On 2023-03-07 at 23:31:57 -0800, Andrei Vagin wrote:
> > > > From: Peter Oskolkov <posk@google.com>
> > > >
> > > > Add WF_CURRENT_CPU wake flag that advices the scheduler to
> > > > move the wakee to the current CPU. This is useful for fast on-CPU
> > > > context switching use cases.
> > > >
> > > > In addition, make ttwu external rather than static so that
> > > > the flag could be passed to it from outside of sched/core.c.
> > > >
> > > > Signed-off-by: Peter Oskolkov <posk@google.com>
> > > > Signed-off-by: Andrei Vagin <avagin@google.com>
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -7569,6 +7569,10 @@ select_task_rq_fair(struct task_struct *p, i=
nt prev_cpu, int wake_flags)
> > > >       if (wake_flags & WF_TTWU) {
> > > >               record_wakee(p);
> > > >
> > > > +             if ((wake_flags & WF_CURRENT_CPU) &&
> > > > +                 cpumask_test_cpu(cpu, p->cpus_ptr))
> > > > +                     return cpu;
> > > > +
> > > I tried to reuse WF_CURRENT_CPU to mitigate the cross-cpu wakeup, how=
ever there
> > > are regressions when running some workloads, and these workloads want=
 to be
> > > spreaded on idle CPUs whenever possible.
> > > The reason for the regression is that, above change chooses current C=
PU no matter
> > > what the load/utilization of this CPU is. So task are stacked on 1 CP=
U and hurts
> > > throughput/latency. And I believe this issue would be more severe on =
system with
> > > smaller number of CPU within 1 LLC(when compared to Intel platforms),=
 such as AMD,
> > > Arm64.
> >
> > WF_CURRENT_CPU works only in certain conditions. Maybe you saw my
> > attempt to change how WF_SYNC works:
> >
> > https://www.spinics.net/lists/kernel/msg4567650.html
> >
> > Then we've found that this idea doesn't work well, and it is a reason
> > why we have the separate WF_CURRENT_CPU flag.
> >
> I see, in seccomp case, even the idle CPU is not a better choice.
> > >
> > > I know WF_CURRENT_CPU benefits seccomp, and can we make this change m=
ore genefic
> > > to benefit other workloads, by making the condition to trigger WF_CUR=
RENT_CPU stricter?
> > > Say, only current CPU has 1 runnable task, and treat current CPU as t=
he last resort by
> > > checking if the wakee's previous CPU is not idle. In this way, we can=
 enable WF_CURRENT_CPU flag
> > > dynamically when some condition is met(a short task for example).
> >
> > We discussed all of these here and here:
> >
> > https://www.spinics.net/lists/kernel/msg4657545.html
> >
> > https://lore.kernel.org/lkml/CANaxB-yWkKzhhPMGXCQbtjntJbqZ40FL2qtM2hk7L=
LWE-ZpbAg@mail.gmail.com/
> >
> > I like your idea about short-duration tasks, but I think it is a
> > separate task and it has to be done in a separate patch set. Here, I
> > solve the problem of optimizing synchronous switches when one task wake=
s
> > up another one and falls asleep immediately after that. Waking up the
> > target task on the current CPU looks reasonable for a few reasons in
> > this case. First, waking up a task on the current CPU is cheaper than o=
n
> > another one and it is much cheaper than waking on an idle cpu.
> It depends. For waker and wakee that compete for cache resource and do
> not have share data, sometimes an idle target would be better.
> > Second,
> > when tasks want to do synchronous switches, they often exchange some
> > data, so memory caches can play on us.
> I like the name of 'WF_CURRENT_CPU' too : ) and I was thinking that if th=
is could
> become a auto-detect behavior so others can benefit from this.
>
> If I understand correctly, the scenario this patch deals with is:
> task A wakeups task B, task A and taks B have close relationship with eac=
h
> other(cache sharing eg), when task A fall asleep, choose A's CPU, rather =
than an
> idle CPU.
>
> I'm thinking if the following logic would cover your case:
> 1. the waker A is a short duration one (waker will fall asleep soon)
> 2. the waker B is a short duration one (impact of B is minor)

In the seccomp case, A or B can be a non-short-duration but if they do
synchronous
switches they get all the benefits of WF_CURRENT_CPU.

> 3. the A->wakee_flips is 0 and A->last_wakee =3D B

In our case, a "supervisor" is written in golang and there are
goroutines that can be
executed from different system threads, so this condition will fail often t=
oo.

> 4. the A->wakee_flips is 0 and B->last_wakee =3D A
> 5, cpu(A)->nr_running =3D 1
>
> (3 and 4 mean that, A and B wake up each other, so it is likely that
> they share cache data, and they are good firends to be put together)
>
> If above conditions are met, choose current CPU. In this way, WF_CURRENT_=
CPU
> can be set dynamically.
>
> thanks,
> Chenyu
