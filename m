Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4B46C30DD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCULvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCULvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:51:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2584B804
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:51:12 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f14so6776387iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679399471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fI+AXTu2B4w6Gzjjcv5wbp8i3ng5c1xPrHTiQRbEHoo=;
        b=hE6PMpwE0doGqXf85DHUg2KP3+aD6lbQ67QRGwIVTqpBXo/CfJWOMKhFFbx0a84Fqq
         t3h++1nvhS59l7HolhIYO271IY2oYvhyYpPu9rxm1pU7lNM8gHb0JSXsaz0UUEaNT2DS
         GKBoftTQmBM1Pq/lMfVtEZeew1thLmMsKEIbLP2jX8mPWcwERv3swftiCU5RcskLgyXs
         nzxzyOERQ5wA5kCQTfyKTpA4zG8wlckSlHrLrlsyKhtNRZdiQmNz2TbSYiSAuocRGOUe
         rv7/y6q7ZDXemDNbkneLzhO4/t7r9bEab+/SadchQqvzTr/fX9+t4sCkiIA7jiF/AOeX
         +kAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679399471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fI+AXTu2B4w6Gzjjcv5wbp8i3ng5c1xPrHTiQRbEHoo=;
        b=YVcpKyopma/q48pA2WhlPwN2aYM1HZbKATriVMn3y/0wNSzDmX2TObl6VMxY7Wzmtk
         B6RtnzLJN/0Aop17qre2txWiqvDUUk0Zg1Jb1hqlBXQ8fqdO0YQ5S62zlk3h81n6fmRM
         NolcyoViJOpwnfAjuDrWE8RS73cBZCGgm5v8FS4X91OJ5ZtqjdC0HL/0fX6ZoYMyhCUi
         yTwpgErbWEkyL3dmSxs8oGjcKbvFO2e/lOaO3/DCQFegTKeFccZegSsR7V2zq3dw2eHx
         W9pUTrVnLK+tGqSs6G/Zn+FValwBr5zk5jvydU4EFdpsUyt2AvDuZnw+wzGQ0f1nphaf
         DCKg==
X-Gm-Message-State: AO0yUKVQjEYx2vAvEzorcgaBMH1+U4fBTAdndjgHSYa9XoSsN5SKJeoy
        n+vF8+p/ug+HufHRel4eJG4wdF1/iD+pEZ+9ZsM=
X-Google-Smtp-Source: AK7set9AVPUZs1btj7i4IeSW/BufydYdWtQGbEzxBq3TqjG4TC1WF/cXAPPcF6876d5gDDLzwftb4XiTrWR9KX2ZOIg=
X-Received: by 2002:a05:6638:2171:b0:3c5:139d:609b with SMTP id
 p17-20020a056638217100b003c5139d609bmr861849jak.1.1679399471391; Tue, 21 Mar
 2023 04:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230321064459.39421-1-wuchi.zero@gmail.com> <20230321093649.GD2234901@hirez.programming.kicks-ass.net>
In-Reply-To: <20230321093649.GD2234901@hirez.programming.kicks-ass.net>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Tue, 21 Mar 2023 19:51:00 +0800
Message-ID: <CA+tQmHD0rM9McyTUV7rATSi=-DmYNbdc5nr8G_hK9KFXvG7kCw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: Reduce cost of sched_move_task when config autogroup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8821=E6=
=97=A5=E5=91=A8=E4=BA=8C 17:36=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Mar 21, 2023 at 02:44:59PM +0800, wuchi wrote:
>
> >  kernel/sched/core.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a380f34789a2..1e7d6a8c3455 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -10330,7 +10330,7 @@ void sched_release_group(struct task_group *tg)
> >       spin_unlock_irqrestore(&task_group_lock, flags);
> >  }
> >
> > -static void sched_change_group(struct task_struct *tsk)
> > +static struct task_group *sched_get_task_group(struct task_struct *tsk=
)
> >  {
> >       struct task_group *tg;
> >
> > @@ -10342,7 +10342,28 @@ static void sched_change_group(struct task_str=
uct *tsk)
> >       tg =3D container_of(task_css_check(tsk, cpu_cgrp_id, true),
> >                         struct task_group, css);
> >       tg =3D autogroup_task_group(tsk, tg);
> > -     tsk->sched_task_group =3D tg;
> > +
> > +     return tg;
> > +}
> > +
> > +static bool sched_task_group_changed(struct task_struct *tsk)
> > +{
> > +     /*
> > +      * Some sched_move_task calls are useless because that
> > +      * task_struct->sched_task_group maybe not changed (equals
> > +      * task_group of cpu_cgroup) when system enable autogroup.
> > +      * So do some checks in sched_move_task.
> > +      */
> > +#ifdef CONFIG_SCHED_AUTOGROUP
> > +     return sched_get_task_group(tsk) !=3D tsk->sched_task_group;
> > +#else
> > +     return true;
> > +#endif /* CONFIG_SCHED_AUTOGROUP */
> > +}
> > +
> > +static void sched_change_group(struct task_struct *tsk)
> > +{
> > +     tsk->sched_task_group =3D sched_get_task_group(tsk);
> >
> >  #ifdef CONFIG_FAIR_GROUP_SCHED
> >       if (tsk->sched_class->task_change_group)
> > @@ -10367,6 +10388,10 @@ void sched_move_task(struct task_struct *tsk)
> >       struct rq *rq;
> >
> >       rq =3D task_rq_lock(tsk, &rf);
> > +
> > +     if (!sched_task_group_changed(tsk))
> > +             goto unlock;
> > +
> >       update_rq_clock(rq);
> >
> >       running =3D task_current(rq, tsk);
> > @@ -10391,6 +10416,7 @@ void sched_move_task(struct task_struct *tsk)
> >               resched_curr(rq);
> >       }
> >
> > +unlock:
> >       task_rq_unlock(rq, tsk, &rf);
> >  }
>
> Would you mind terribly if I change it like so?
>
> ---
> Subject: sched/core: Reduce cost of sched_move_task when config autogroup
> From: wuchi <wuchi.zero@gmail.com>
> Date: Tue, 21 Mar 2023 14:44:59 +0800
>
> From: wuchi <wuchi.zero@gmail.com>
>
> Some sched_move_task calls are useless because that
> task_struct->sched_task_group maybe not changed (equals task_group
> of cpu_cgroup) when system enable autogroup. So do some checks in
> sched_move_task.
>
> sched_move_task eg:
> task A belongs to cpu_cgroup0 and autogroup0, it will always belong
> to cpu_cgroup0 when do_exit. So there is no need to do {de|en}queue.
> The call graph is as follow.
>
>   do_exit
>     sched_autogroup_exit_task
>       sched_move_task
>         dequeue_task
>           sched_change_group
>             A.sched_task_group =3D sched_get_task_group (=3Dcpu_cgroup0)
>         enqueue_task
>
> Performance results:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> 1. env
>         cpu: bogomips=3D4600.00
>      kernel: 6.3.0-rc3
>  cpu_cgroup: 6:cpu,cpuacct:/user.slice
>
> 2. cmds
> do_exit script:
>
>   for i in {0..10000}; do
>       sleep 0 &
>       done
>   wait
>
> Run the above script, then use the following bpftrace cmd to get
> the cost of sched_move_task:
>
>   bpftrace -e 'k:sched_move_task { @ts[tid] =3D nsecs; }
>                kr:sched_move_task /@ts[tid]/
>                   { @ns +=3D nsecs - @ts[tid]; delete(@ts[tid]); }'
>
> 3. cost time(ns):
>   without patch: 43528033
>   with    patch: 18541416
>            diff:-24986617  -57.4%
>
> As the result show, the patch will save 57.4% in the scenario.
>
> Signed-off-by: wuchi <wuchi.zero@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20230321064459.39421-1-wuchi.zero@gmail.c=
om
> ---
>  kernel/sched/core.c |   22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10351,7 +10351,7 @@ void sched_release_group(struct task_gro
>         spin_unlock_irqrestore(&task_group_lock, flags);
>  }
>
> -static void sched_change_group(struct task_struct *tsk)
> +static struct task_group *sched_get_task_group(struct task_struct *tsk)
>  {
>         struct task_group *tg;
>
> @@ -10363,7 +10363,13 @@ static void sched_change_group(struct ta
>         tg =3D container_of(task_css_check(tsk, cpu_cgrp_id, true),
>                           struct task_group, css);
>         tg =3D autogroup_task_group(tsk, tg);
> -       tsk->sched_task_group =3D tg;
> +
> +       return tg;
> +}
> +
> +static void sched_change_group(struct task_struct *tsk, struct task_grou=
p *group)
> +{
> +       tsk->sched_task_group =3D group;
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>         if (tsk->sched_class->task_change_group)
> @@ -10384,10 +10390,19 @@ void sched_move_task(struct task_struct
>  {
>         int queued, running, queue_flags =3D
>                 DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
> +       struct task_group *group;
>         struct rq_flags rf;
>         struct rq *rq;
>
>         rq =3D task_rq_lock(tsk, &rf);
> +       /*
> +        * Esp. with SCHED_AUTOGROUP enabled it is possible to get superf=
luous
> +        * group changes.
> +        */
> +       group =3D sched_get_task_group(tsk);
> +       if (group =3D=3D tsk->sched_task_group)
> +               goto unlock;
> +
>         update_rq_clock(rq);
>
>         running =3D task_current(rq, tsk);
> @@ -10398,7 +10413,7 @@ void sched_move_task(struct task_struct
>         if (running)
>                 put_prev_task(rq, tsk);
>
> -       sched_change_group(tsk);
> +       sched_change_group(tsk, group);
>
>         if (queued)
>                 enqueue_task(rq, tsk, queue_flags);
> @@ -10412,6 +10427,7 @@ void sched_move_task(struct task_struct
>                 resched_curr(rq);
>         }
>
> +unlock:
>         task_rq_unlock(rq, tsk, &rf);
>  }
>

It=E2=80=98s more efficient and concise, I learn more from the code. Thanks=
!
