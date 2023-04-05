Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E016D89C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjDEVnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDEVnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:43:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23513C0B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:43:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7-20020a17090b050700b002404be7920aso36875357pjz.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680730991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRRTEGyyl+7S7FxKyYmaTJbEbOXZyrO8bzcQsPsiqmA=;
        b=jlqQ4aisI05931c2xJI388gyT+sK+bISi9DMtbt31MQB6WfhHaepOSQnP01pU7nY/J
         qIBNzdW0o2Tjg/ExHLzI9jVGqiq1ePAMUkmnxRBtpryTopCch/8++yKJy68r0joe/mJC
         NodVQAWXhXVa491pN406VxxZvQKjJvHm8xG3YXNKwqS6KA++5ke1moY2Ta9K2kKN0t1V
         VPp2FRNmjXVX4FB72sT77BVatzoOnW5d2/X/MWvVga4zY+qaIHpHnX+2LSXDpaBFFnnp
         +Qcdv89b6rb7syS55H6IsxV1IKyZT7uesjuvNEap9CnV6S83WFlAuwHwroLFyW55w79Y
         pysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680730991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRRTEGyyl+7S7FxKyYmaTJbEbOXZyrO8bzcQsPsiqmA=;
        b=WjFFqvyeY+FYsEtSYp/C5qkUiwVYv0jSvD3UcEE/dTsW0nTPImKxh5hH3ghUcM5WBx
         a9SCtzn9d6Ezd0QOKZTkDMmx2WRKcRH1liOR9S0LCOUrF6pLGCekY6H0QUZLoCKu8WVz
         1xhbo6++usNW4iIkugRn5BmTH/LDs0pL9Jh2pIWXMdhW10zfpnr+FQn2+OirwILCyFl6
         MSkv3S9hEWT8JV3/Hn/C8arxxqyxivWTuKxcAb/1rv5oVtjEdci8U6ydZat+uIMOX3CT
         5k7NyU36O4XfmkjyH2fuddXFelQA3Skwt+YYiIJUhLOyn2gcBi+9aO3g+z0cK3wySq9M
         PcQg==
X-Gm-Message-State: AAQBX9ds39QqE3VJPTiRQ2oO3q8wwu2JoVlKCDcx1q0Mbyx9W2SF8OgV
        zYU5xYNUfnV2FzPN+Q5nbajRTHAJMZgQCqY5TVkpXA==
X-Google-Smtp-Source: AKy350ZGL416cbZpLOQZiU+UjNRZTCGHr15bxSFZvGfAjRwHfYoB+nae2/l4IZ9LdAAwXnBd8eIbV5QOotL473bZDhg=
X-Received: by 2002:a17:90a:4886:b0:23b:5155:309f with SMTP id
 b6-20020a17090a488600b0023b5155309fmr1701858pjh.0.1680730990954; Wed, 05 Apr
 2023 14:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com> <20230330224348.1006691-2-davidai@google.com>
 <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com> <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
 <0da58608-2958-fc6c-effb-2f73013c609f@arm.com>
In-Reply-To: <0da58608-2958-fc6c-effb-2f73013c609f@arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 5 Apr 2023 14:42:34 -0700
Message-ID: <CAGETcx_3h9_+y91EfhDMk-gPdRLA3mhdiX2AksN6xHZha7U_mw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     David Dai <davidai@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Apr 5, 2023 at 3:50=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 04/04/2023 03:11, David Dai wrote:
> > On Mon, Apr 3, 2023 at 4:40=E2=80=AFAM Dietmar Eggemann
> > <dietmar.eggemann@arm.com> wrote:
> >>
> >> Hi David,
> > Hi Dietmar, thanks for your comments.
> >>
> >> On 31/03/2023 00:43, David Dai wrote:
>
> [...]
>
> >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>> index 6986ea31c984..998649554344 100644
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@ -4276,14 +4276,16 @@ static int newidle_balance(struct rq *this_rq=
, struct rq_flags *rf);
> >>>
> >>>  static inline unsigned long task_util(struct task_struct *p)
> >>>  {
> >>> -     return READ_ONCE(p->se.avg.util_avg);
> >>> +     return max(READ_ONCE(p->se.avg.util_avg),
> >>> +                     READ_ONCE(p->se.avg.util_guest));
> >>>  }
> >>>
> >>>  static inline unsigned long _task_util_est(struct task_struct *p)
> >>>  {
> >>>       struct util_est ue =3D READ_ONCE(p->se.avg.util_est);
> >>>
> >>> -     return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> >>> +     return max_t(unsigned long, READ_ONCE(p->se.avg.util_guest),
> >>> +                     max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED=
)));
> >>>  }
> >>
> >> I can't see why the existing p->uclamp_req[UCLAMP_MIN].value can't be
> >> used here instead p->se.avg.util_guest.
> > Using p->uclamp_req[UCLAMP_MIN].value would result in folding in
> > uclamp values into task_util and task_util_est for all tasks that have
> > uclamp values set. The intent of these patches isn=E2=80=99t to modify
> > existing uclamp behaviour. Users would also override util values from
> > the guest when they set uclamp values.
> >>
> >> I do understand the issue of inheriting uclamp values at fork but don'=
t
> >> get the not being `additive` thing. We are at task level here.
>
> > Uclamp values are max aggregated with other tasks at the runqueue
> > level when deciding CPU frequency. For example, a vCPU runqueue may
> > have an util of 512 that results in setting 512 to uclamp_min on the
> > vCPU task. This is insufficient to drive a frequency response if it
> > shares the runqueue with another host task running with util of 512 as
> > it would result in a clamped util value of 512 at the runqueue(Ex. If
> > a guest thread had just migrated onto this vCPU).
>
> OK, see your point now. You want an accurate per-task boost for this
> vCPU task on the host run-queue.
> And a scenario in which a vCPU can ask for 100% in these moments is not
> sufficient I guess? In this case uclamp_min could work.

Right. vCPU can have whatever utilization and there can be random host
threads completely unrelated to the VM. And we need to aggregate both
of their util when deciding CPU freq.

>
> >> The fact that you have to max util_avg and util_est directly in
> >> task_util() and _task_util_est() tells me that there are places where
> >> this helps and uclamp_task_util() is not called there.
> > Can you clarify on this point a bit more?
>
> Sorry, I meant s/util_est/util_guest/.
>
> The effect of the change in _task_util_est() you see via:
>
> enqueue_task_fair()
>   util_est_enqueue()
>     cfs_rq->avg.util_est.enqueued +=3D _task_util_est(p)
>
> so that `sugov_get_util() -> cpu_util_cfs() ->
> cfs_rq->avg.util_est.enqueued` can see the effect of util_guest?
>
> Not sure about the change in task_util() yet.
>
> >> When you say in the cover letter that you tried uclamp_min, how exactl=
y
> >> did you use it? Did you run the existing mainline or did you use
> >> uclamp_min as a replacement for util_guest in this patch here?
>
> > I called sched_setattr_nocheck() with .sched_flags =3D
> > SCHED_FLAG_UTIL_CLAMP when updating uclamp_min and clamp_max is left
> > at 1024. Uclamp_min was not aggregated with task_util and
> > task_util_est during my testing. The only caveat there is that I added
> > a change to only reset uclamp on fork when testing(I realize there is
> > specifically a SCHED_FLAG_RESET_ON_FORK, but I didn=E2=80=99t want to r=
eset
> > other sched attributes).
>
> OK, understood. It's essentially a util_est v2 for vCPU tasks on host.

Yup. We initially looked into just overwriting util_est, but didn't
think that'll land well with the community :) as it was a bit messier
because we needed to make sure the current util_est update paths don't
run for vCPU tasks on host (because those values would be wrong).

> >>>  static inline unsigned long task_util_est(struct task_struct *p)
> >>> @@ -6242,6 +6244,15 @@ enqueue_task_fair(struct rq *rq, struct task_s=
truct *p, int flags)
> >>>        */
> >>>       util_est_enqueue(&rq->cfs, p);
> >>>
> >>> +     /*
> >>> +      * The normal code path for host thread enqueue doesn't take in=
to
> >>> +      * account guest task migrations when updating cpufreq util.
> >>> +      * So, always update the cpufreq when a vCPU thread has a
> >>> +      * non-zero util_guest value.
> >>> +      */
> >>> +     if (READ_ONCE(p->se.avg.util_guest))
> >>> +             cpufreq_update_util(rq, 0);
> >>
> >>
> >> This is because enqueue_entity() -> update_load_avg() ->
> >> attach_entity_load_avg() -> cfs_rq_util_change() requires root run-que=
ue
> >> (&rq->cfs =3D=3D cfs_rq) to call cpufreq_update_util()?
> > The enqueue_entity() would not call into update_load_avg() due to the
> > check for !se->avg.last_update_time. se->avg.last_update_time is
> > non-zero because the vCPU task did not migrate before this enqueue.
> > This enqueue path is reached when util_guest is updated for the vCPU
> > task through the sched_setattr_nocheck call where we want to ensure a
> > frequency update occurs.
>
> OK, vCPU tasks are pinned so always !WF_MIGRATED wakeup I guess?

Even if say little-vCPU threads are allowed to migrate within little
CPUs, this will still be an issue. While a vCPU thread is continuously
running on a single CPU, a guest thread can migrate into that vCPU and
cause a huge increase in util_guest. But that won't trigger an cpufreq
update on the host side because the host doesn't see a task migration.
That's what David is trying to address.

-Saravana
