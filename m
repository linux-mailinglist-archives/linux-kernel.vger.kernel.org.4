Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C86D55BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjDDBMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDDBL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:11:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40E230C1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:11:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j24so31171131wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680570709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZGQpR68UsPnhM4fAUplnckxD+fkEKX1UKjNbN3U7sw=;
        b=aoOrU3Y5gM78YRfd059Gm2deG2VD9BZs6vpwDO1R6vxZuhQXeKkVFMfYYqRpYe6HYL
         MZ2Nr0sxYRVJ5x/rqjioU8prZF5x7X4IbFK2mYhk+FnD1dNoXhvgewXyNjhC3hlXENIb
         GxgJ1R+sMF9FUbaym9QntPxHodw/QDk33cVDQIKDqDZUN4z7WysgnIZUzjKp6RxyjFJD
         E8BugMtZS99TqbmdyHbVOo2nxlYcOeVKQAbzJR22PiQumDbE3tzyHI6UeeaQ1pTvAsL2
         NHtX8/PDyMx1Lq+QtHMDtRBCud6MYtSKif3NNRi+Yd9J7E39a2zc2g1dwIygWi62sCu5
         sO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680570709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZGQpR68UsPnhM4fAUplnckxD+fkEKX1UKjNbN3U7sw=;
        b=u7hVW0HkjxEscbXnNeqZb8lP/fLphmVvBOOjtC/MB+MWdpeZzOpj68HcLcN7qEnU/B
         D6666zc5420KzD4RaHojfactsuElnScIZCwFlQfSoUqaIMA/XetTIP/HDCsPKSd/tReE
         kKkrUIlBD1VsNkT5sPqvL/qk6Qfw9TCpvrIl62Fy+hNrrtXVRmrhNKuDbkP59hikT+l7
         sGv1V0+gJHfyinIMDkBH0MNPob9T7YK0Pmuc0gZlZZsHubSsnyRaDVIwm9F7KSwEIepl
         QfLkSKxmJN8p2vKrIta7VtlHZP4FjQid0MduuGnLlazGsQAIic+xOA/dESsNhlR6LXeT
         nlcg==
X-Gm-Message-State: AAQBX9fVLCHG4bjDX21btTzlU9yCRE5Q6nJJyeCzTraUXHJpLgNSK1m1
        liNcaV0Hq8LnCunIxdAPpI7oaOysJywWj4Igyiyevg==
X-Google-Smtp-Source: AKy350YpVVFX1GYSlRQMN8ddXtICVtd35IzM2lUIpgMtQ4Gq1kT181hFHYInmSqjlaQEiU8FeOU14Ud3ljpjFgQWCJk=
X-Received: by 2002:adf:e88e:0:b0:2d2:b423:afcb with SMTP id
 d14-20020adfe88e000000b002d2b423afcbmr92845wrm.6.1680570709001; Mon, 03 Apr
 2023 18:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com> <20230330224348.1006691-2-davidai@google.com>
 <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com>
In-Reply-To: <e3aa7e66-27d0-034b-7bdf-f4fab1c2df25@arm.com>
From:   David Dai <davidai@google.com>
Date:   Mon, 3 Apr 2023 18:11:37 -0700
Message-ID: <CABN1KC+E5tdCBTDu8x_mNzk6L0=Yu8DfpyV-9rMddiRigOFrCQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] sched/fair: Add util_guest for tasks
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
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

On Mon, Apr 3, 2023 at 4:40=E2=80=AFAM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Hi David,
Hi Dietmar, thanks for your comments.
>
> On 31/03/2023 00:43, David Dai wrote:
> > For virtualization usecases, util_est and util_avg currently tracked
> > on the host aren't sufficient to accurately represent the workload on
> > vCPU threads, which results in poor frequency selection and performance=
.
> > For example, when a large workload migrates from a busy vCPU thread to
> > an idle vCPU thread, it incurs additional DVFS ramp-up latencies
> > as util accumulates.
> >
> > Introduce a new "util_guest" member as an additional PELT signal that's
> > independently updated by the guest. When used, it's max aggregated to
> > provide a boost to both task_util and task_util_est.
> >
> > Updating task_util and task_util_est will ensure:
> > -Better task placement decisions for vCPU threads on the host
> > -Correctly updating util_est.ewma during dequeue
> > -Additive util with other threads on the same runqueue for more
> > accurate frequency responses
> >
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: David Dai <davidai@google.com>
> > ---
>
> [...]
>
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 6986ea31c984..998649554344 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4276,14 +4276,16 @@ static int newidle_balance(struct rq *this_rq, =
struct rq_flags *rf);
> >
> >  static inline unsigned long task_util(struct task_struct *p)
> >  {
> > -     return READ_ONCE(p->se.avg.util_avg);
> > +     return max(READ_ONCE(p->se.avg.util_avg),
> > +                     READ_ONCE(p->se.avg.util_guest));
> >  }
> >
> >  static inline unsigned long _task_util_est(struct task_struct *p)
> >  {
> >       struct util_est ue =3D READ_ONCE(p->se.avg.util_est);
> >
> > -     return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
> > +     return max_t(unsigned long, READ_ONCE(p->se.avg.util_guest),
> > +                     max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED))=
);
> >  }
>
> I can't see why the existing p->uclamp_req[UCLAMP_MIN].value can't be
> used here instead p->se.avg.util_guest.
Using p->uclamp_req[UCLAMP_MIN].value would result in folding in
uclamp values into task_util and task_util_est for all tasks that have
uclamp values set. The intent of these patches isn=E2=80=99t to modify
existing uclamp behaviour. Users would also override util values from
the guest when they set uclamp values.
>
> I do understand the issue of inheriting uclamp values at fork but don't
> get the not being `additive` thing. We are at task level here.
Uclamp values are max aggregated with other tasks at the runqueue
level when deciding CPU frequency. For example, a vCPU runqueue may
have an util of 512 that results in setting 512 to uclamp_min on the
vCPU task. This is insufficient to drive a frequency response if it
shares the runqueue with another host task running with util of 512 as
it would result in a clamped util value of 512 at the runqueue(Ex. If
a guest thread had just migrated onto this vCPU).
>
> The fact that you have to max util_avg and util_est directly in
> task_util() and _task_util_est() tells me that there are places where
> this helps and uclamp_task_util() is not called there.
Can you clarify on this point a bit more?
>
> When you say in the cover letter that you tried uclamp_min, how exactly
> did you use it? Did you run the existing mainline or did you use
> uclamp_min as a replacement for util_guest in this patch here?
I called sched_setattr_nocheck() with .sched_flags =3D
SCHED_FLAG_UTIL_CLAMP when updating uclamp_min and clamp_max is left
at 1024. Uclamp_min was not aggregated with task_util and
task_util_est during my testing. The only caveat there is that I added
a change to only reset uclamp on fork when testing(I realize there is
specifically a SCHED_FLAG_RESET_ON_FORK, but I didn=E2=80=99t want to reset
other sched attributes).
>
> >  static inline unsigned long task_util_est(struct task_struct *p)
> > @@ -6242,6 +6244,15 @@ enqueue_task_fair(struct rq *rq, struct task_str=
uct *p, int flags)
> >        */
> >       util_est_enqueue(&rq->cfs, p);
> >
> > +     /*
> > +      * The normal code path for host thread enqueue doesn't take into
> > +      * account guest task migrations when updating cpufreq util.
> > +      * So, always update the cpufreq when a vCPU thread has a
> > +      * non-zero util_guest value.
> > +      */
> > +     if (READ_ONCE(p->se.avg.util_guest))
> > +             cpufreq_update_util(rq, 0);
>
>
> This is because enqueue_entity() -> update_load_avg() ->
> attach_entity_load_avg() -> cfs_rq_util_change() requires root run-queue
> (&rq->cfs =3D=3D cfs_rq) to call cpufreq_update_util()?
The enqueue_entity() would not call into update_load_avg() due to the
check for !se->avg.last_update_time. se->avg.last_update_time is
non-zero because the vCPU task did not migrate before this enqueue.
This enqueue path is reached when util_guest is updated for the vCPU
task through the sched_setattr_nocheck call where we want to ensure a
frequency update occurs.
>
> [...]
