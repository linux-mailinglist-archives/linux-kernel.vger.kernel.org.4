Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E888064263E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiLEJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbiLEJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:59:20 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F88BDF8D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:59:19 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m15so4870432ilq.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd5qIitc5st6tCQXO3G+rJW6Qfu7Fi9EIJWTKkLH8RE=;
        b=Zzfuv0eVoa4L46mknEqr92eiI6b21awhnrd4/xYvwHIBeNl7dG9cl3d7LVFZDe3Isk
         XCeB//P8QMVAIBDOpdse77S3JiHccKt/iMCaeWLMzOsygHwK+MbO7RanTS/sBDoD/3Mm
         xvYnflmpLahL/w1mNl/rmKCbaIW1prnvJjS5L+HJqirKNhdH4uD+JCxlcTcTuYvsXSLu
         2dhzNGGttxz8JKdMGQtpkl3GZyqLUyvEnRxoog9v5szmCvUPhh81ivFH1zHqeZOv0lTV
         zjqiQSr7ifq+w5tQf2gnVYUMxsPQdcFlbl9wIam9TCsHG7HbcowZ3D66zqeLUW89hH53
         OOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hd5qIitc5st6tCQXO3G+rJW6Qfu7Fi9EIJWTKkLH8RE=;
        b=EIY3DJIWJ8SCoXuU0TlxVXUAHoLnYJ4hRtSkkK4rrqOKAaelmKnFRvoWgYVkyB48kh
         7sZJEd8MBxI4HyOWlg3XsbHKnKdFQO2oAujpuul6ztBt3WK5IevwNyUMFmMTuE8ZQoAr
         /yHUQC4cBZqTcNvBRvUZ7oSS9XA6X+VA3/EVWvA+PYEqy69vl4lqeYtw1szPacHQcbYM
         KWAlqiGJ/zOJnKjpnHLw7wN7VZprPwKj1qjx6sU9XLr/0pMUwxpO4rEwJfcfcClMkQv0
         wiFle92xGqphWo8aOfKR6FI+tnsHIsmR4C+fpqB5P1j2vUoI5ZLth1Izqcmtkc8DQr4U
         Mefw==
X-Gm-Message-State: ANoB5pnLRMN0oFgVzFMJDTqt1ZoJti1VjOPszTqBYHeuJYFUwnBuBrxs
        UbGwiQYFodsDPDCOdsw56HEvsSW19wSFo2s9D+LtfQ==
X-Google-Smtp-Source: AA0mqf4H1FTCBXaIdXoWC3Kb05zNscm77tZVkutERd4JAlVAn05gzLflduIHcXtakRyh//5jW6R4DJwQkO6YD698sIo=
X-Received: by 2002:a05:6e02:5c6:b0:303:22ca:60ca with SMTP id
 l6-20020a056e0205c600b0030322ca60camr13358679ils.22.1670234358271; Mon, 05
 Dec 2022 01:59:18 -0800 (PST)
MIME-Version: 1.0
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1> <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1>
In-Reply-To: <Y42uH5fglluWYOm7@chenyu5-mobl1>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 5 Dec 2022 10:59:06 +0100
Message-ID: <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
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

On Mon, 5 Dec 2022 at 09:39, Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Joel,
> On 2022-12-03 at 10:35:46 -0500, Joel Fernandes wrote:
> >
> >
> > > On Dec 3, 2022, at 2:50 AM, Chen Yu <yu.c.chen@intel.com> wrote:
> > >
> > > =EF=BB=BFHi Honglei,
> > >> On 2022-12-02 at 15:44:18 +0800, Honglei Wang wrote:
> > >>
> > >>
> > >>> On 2022/12/1 16:44, Chen Yu wrote:
> > >>> Introduce short-duration task checks, as there is requirement
> > >>> to leverage this attribute for better task placement.
> > >>>
> > >>> There are several choices of metrics that could be used to
> > >>> indicate if a task is a short-duration task.
> > >>>
> > >>> At first thought the (p->se.sum_exec_runtime / p->nvcsw)
> > >>> could be used to measure the task duration. However, the
> > >>> history long past was factored too heavily in such a formula.
> > >>> Ideally, the old activity should decay and not affect
> > >>> the current status too much.
> > >>>
> > >>> Although something based on PELT could be used, se.util_avg might
> > >>> not be appropriate to describe the task duration:
> > >>> 1. Task p1 and task p2 are doing frequent ping-pong scheduling on
> > >>>    one CPU, both p1 and p2 have a short duration, but the util_avg
> > >>>    can be up to 50%.
> > >>> 2. Suppose a task lasting less than 4ms is regarded as a short task=
.
> > >>>    If task p3 runs for 6ms and sleeps for 32ms, p3 should not be a
> > >>>    short-duration task. However, PELT would decay p3's accumulated
> > >>>    running time from 6ms to 3ms, because 32ms is the half-life in P=
ELT.
> > >>>    As a result, p3 would be incorrectly treated as a short task.
> > >>>
> > >>> It was found that there was once a similar feature to track the
> > >>> duration of a task, which is in Commit ad4b78bbcbab ("sched: Add
> > >>> new wakeup preemption mode: WAKEUP_RUNNING"). Unfortunately, it
> > >>> was reverted because it was an experiment. So pick the patch up
> > >>> again, by recording the average duration when a task voluntarily
> > >>> switches out. Introduce SIS_SHORT to control this strategy.
> > >>>
> > >>> The threshold of short duration reuses sysctl_sched_min_granularity=
,
> > >>> so it can be tuned by the user. Ideally there should be a dedicated
> > >>> parameter for the threshold, but that might introduce complexity.
> > >>>
> > >>> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > >>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > >>> ---
> > >>>  include/linux/sched.h   |  4 ++++
> > >>>  kernel/sched/core.c     |  2 ++
> > >>>  kernel/sched/fair.c     | 17 +++++++++++++++++
> > >>>  kernel/sched/features.h |  1 +
> > >>>  4 files changed, 24 insertions(+)
> > >>>
> > >>> diff --git a/include/linux/sched.h b/include/linux/sched.h
> > >>> index ffb6eb55cd13..64b7acb77a11 100644
> > >>> --- a/include/linux/sched.h
> > >>> +++ b/include/linux/sched.h
> > >>> @@ -558,6 +558,10 @@ struct sched_entity {
> > >>>      u64                nr_migrations;
> > >>> +    u64                prev_sum_exec_runtime_vol;
> > >>> +    /* average duration of a task */
> > >>> +    u64                dur_avg;
> > >>> +
> > >>>  #ifdef CONFIG_FAIR_GROUP_SCHED
> > >>>      int                depth;
> > >>>      struct sched_entity        *parent;
> > >>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > >>> index daff72f00385..c5202f1be3f7 100644
> > >>> --- a/kernel/sched/core.c
> > >>> +++ b/kernel/sched/core.c
> > >>> @@ -4348,6 +4348,8 @@ static void __sched_fork(unsigned long clone_=
flags, struct task_struct *p)
> > >>>      p->se.prev_sum_exec_runtime    =3D 0;
> > >>>      p->se.nr_migrations        =3D 0;
> > >>>      p->se.vruntime            =3D 0;
> > >>> +    p->se.dur_avg            =3D 0;
> > >>> +    p->se.prev_sum_exec_runtime_vol    =3D 0;
> > >>>      INIT_LIST_HEAD(&p->se.group_node);
> > >>>  #ifdef CONFIG_FAIR_GROUP_SCHED
> > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> index e4a0b8bd941c..a4b314b664f8 100644
> > >>> --- a/kernel/sched/fair.c
> > >>> +++ b/kernel/sched/fair.c
> > >>> @@ -6200,6 +6200,16 @@ static int wake_wide(struct task_struct *p)
> > >>>      return 1;
> > >>>  }
> > >>> +/*
> > >>> + * If a task switches in and then voluntarily relinquishes the
> > >>> + * CPU quickly, it is regarded as a short duration task.
> > >>> + */
> > >>> +static inline int is_short_task(struct task_struct *p)
> > >>> +{
> > >>> +    return sched_feat(SIS_SHORT) &&
> > >>> +        (p->se.dur_avg <=3D sysctl_sched_min_granularity);
> > >>> +}
> > >>> +
> > >>
> > >> Hi Yu,
> > >>
> > >> I still have a bit concern about the sysctl_sched_min_granularity st=
uff..
> > >> This grab can be set to different value which will impact the action=
 of this
> > >> patch and make things not totally under control.
> >
> > There are already ways to misconfigure sched sysctl to make bad/weird t=
hings happen.
> >
> > >> Not sure if we can add a new grab for this.. The test result shows g=
ood
> > >> improvement for short task, and with this grab, admins will be able =
to
> > >> custom the system base on their own 'short task' view.
> > >>
> > > It would be ideal to have a dedicated parameter to tweak this. For ex=
ample,
> > > something under /sys/kernel/debug/sched/, and initilized to sysctl_sc=
hed_min_granularity
> > > by default.
> >
> > It would be nice to not have to introduce a new knob for this. IMO, min=
_granularity is reasonable.
> >
> OK, got it, thanks for the suggestion.

Sorry for the late answer.
We don't want to add more dedicated knobs. So using
sysctl_sched_min_granularity as you are doing in this patch looks ok

>
> thanks,
> Chenyu
