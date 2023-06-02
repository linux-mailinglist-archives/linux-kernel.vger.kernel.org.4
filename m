Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85307720945
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjFBSkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbjFBSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:40:21 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BC1BF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:40:14 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-565eb83efe4so24957297b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685731213; x=1688323213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOyqbYm5JIiSey/I//epzKoQih0Jy0CZ0Tynt4l4udI=;
        b=afYQF6hDvUKT/KZCJitNGlX0CICrd1MGAWQP83IvUZwBUhEFWpPClxqpGY3fD866k2
         MlMoGc9M2dI9LVZhWlyfhE0MTONNw/himiI14RCqBuHqlr5bCJXXnwZ8yGoqTpVQ3VMY
         gDiqnt3Z7hJ/ouQN/0mNUVe/6gOdSfz7vJOho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685731213; x=1688323213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOyqbYm5JIiSey/I//epzKoQih0Jy0CZ0Tynt4l4udI=;
        b=RKcdyxaVpiA9Kits/VV31ohxG7bIt35boE4YmjmLDHrez7zqrwx2/HK1GCPkWc9QiW
         o6zYcO3R6CCJKb0gPv3R2PAoZidMXUKw/XWtrd2+wE6Esbf+2IfSLsN4sZnyzjo7Vq4d
         DJkOvlabjp0UZz/HhgTCpIa1tkl78muS+7ApY45+ygtGSbSRMBy8hrI6gCcc1n+kn7Bd
         PREeBI2XvPAIF0Q6CXmjwOwSD37mKyOXN+Nz5IAPnAa0EVP4bXxvSNdi8jw5fkJhuL+G
         IV13qbP91EbcuNgdMnkRlvZ6Tx/X20yAyn9aGwQ71pRB4kvdSiMIwF0yEXP56psvEVyg
         CxyA==
X-Gm-Message-State: AC+VfDx2RbpfeAjX666lySoAs106qG38kN5udTCkj8X76Nxj46G8qUVe
        0Q4g21WrCzvDgM+pX8BIoy/KSmk7akEvdJNmSVVrtQ==
X-Google-Smtp-Source: ACHHUZ4XOpazL8pfZpW12DmNDB8tSYO9PTRJsv0yMMAWvdoZv2Md/nJCtTS2fUCyaefccp74PGJD/uaCdeiRFeg8sHQ=
X-Received: by 2002:a81:9286:0:b0:565:edf7:69c1 with SMTP id
 j128-20020a819286000000b00565edf769c1mr920545ywg.36.1685731213291; Fri, 02
 Jun 2023 11:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
In-Reply-To: <20230526145519.2282062-1-vineeth@bitbyteword.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 2 Jun 2023 14:40:02 -0400
Message-ID: <CAEXW_YStTp9KRQJDbRpL-19eTqFjo+=B80K35K=ppF4rRo67Sg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in GRUB
To:     Vineeth Pillai <vineeth@bitbyteword.org>
Cc:     luca.abeni@santannapisa.it, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 10:55=E2=80=AFAM Vineeth Pillai <vineeth@bitbytewor=
d.org> wrote:
>
> According to the GRUB[1] rule, the runtime is depreciated as:
>   "dq =3D -max{u, (1 - Uinact - Uextra)} dt" (1)
>
> To guarantee that deadline tasks doesn't starve lower class tasks,
> we do not allocate the full bandwidth of the cpu to deadline tasks.
> Maximum bandwidth usable by deadline tasks is denoted by "Umax".
> Considering Umax, equation (1) becomes:
>   "dq =3D -(max{u, (Umax - Uinact - Uextra)} / Umax) dt" (2)

Makes sense, your patch fixes the issue where we need the depreciation
ratio to factor in the throttling limits as well.

The code looks sane to me too.

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>
> Current implementation has a minor bug in equation (2), which this
> patch fixes.
>
> The reclamation logic is verified by a sample program which creates
> multiple deadline threads and observing their utilization. The tests
> were run on an isolated cpu(isolcpus=3D3) on a 4 cpu system.
>
> Tests on 6.3.0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> RUN 1: runtime=3D7ms, deadline=3Dperiod=3D10ms, RT capacity =3D 95%
> TID[693]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 93.33
> TID[693]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 93.35
>
> RUN 2: runtime=3D1ms, deadline=3Dperiod=3D100ms, RT capacity =3D 95%
> TID[708]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 16.69
> TID[708]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 16.69
>
> RUN 3: 2 tasks
>   Task 1: runtime=3D1ms, deadline=3Dperiod=3D10ms
>   Task 2: runtime=3D1ms, deadline=3Dperiod=3D100ms
> TID[631]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 62.67
> TID[632]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 6.37
> TID[631]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 62.38
> TID[632]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 6.23
>
> As seen above, the reclamation doesn't reclaim the maximum allowed
> bandwidth and as the bandwidth of tasks gets smaller, the reclaimed
> bandwidth also comes down.
>
> Tests with this patch applied
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> RUN 1: runtime=3D7ms, deadline=3Dperiod=3D10ms, RT capacity =3D 95%
> TID[608]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.19
> TID[608]: RECLAIM=3D1, (r=3D7ms, d=3D10ms, p=3D10ms), Util: 95.16
>
> RUN 2: runtime=3D1ms, deadline=3Dperiod=3D100ms, RT capacity =3D 95%
> TID[616]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 95.27
> TID[616]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 95.21
>
> RUN 3: 2 tasks
>   Task 1: runtime=3D1ms, deadline=3Dperiod=3D10ms
>   Task 2: runtime=3D1ms, deadline=3Dperiod=3D100ms
> TID[620]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 86.64
> TID[621]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 8.66
> TID[620]: RECLAIM=3D1, (r=3D1ms, d=3D10ms, p=3D10ms), Util: 86.45
> TID[621]: RECLAIM=3D1, (r=3D1ms, d=3D100ms, p=3D100ms), Util: 8.73
>
> Running tasks on all cpus allowing for migration also showed that
> the utilization is reclaimed to the maximum. Running 10 tasks on
> 3 cpus SCHED_FLAG_RECLAIM - top shows:
> %Cpu0  : 94.6 us,  0.0 sy,  0.0 ni,  5.4 id,  0.0 wa
> %Cpu1  : 95.2 us,  0.0 sy,  0.0 ni,  4.8 id,  0.0 wa
> %Cpu2  : 95.8 us,  0.0 sy,  0.0 ni,  4.2 id,  0.0 wa
>
> [1]: Abeni, Luca & Lipari, Giuseppe & Parri, Andrea & Sun, Youcheng.
>      (2015). Parallel and sequential reclaiming in multicore
>      real-time global scheduling.
>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---
>  kernel/sched/deadline.c | 56 +++++++++++++++++++----------------------
>  kernel/sched/sched.h    |  6 +++++
>  2 files changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b24371a6f7..ea5db080f008 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1260,43 +1260,39 @@ int dl_runtime_exceeded(struct sched_dl_entity *d=
l_se)
>  }
>
>  /*
> - * This function implements the GRUB accounting rule:
> - * according to the GRUB reclaiming algorithm, the runtime is
> - * not decreased as "dq =3D -dt", but as
> - * "dq =3D -max{u / Umax, (1 - Uinact - Uextra)} dt",
> + * This function implements the GRUB accounting rule. According to the
> + * GRUB reclaiming algorithm, the runtime is not decreased as "dq =3D -d=
t",
> + * but as "dq =3D -(max{u, (1 - Uinact - Uextra)} / Umax) dt",
>   * where u is the utilization of the task, Umax is the maximum reclaimab=
le
> - * utilization, Uinact is the (per-runqueue) inactive utilization, compu=
ted
> - * as the difference between the "total runqueue utilization" and the
> - * runqueue active utilization, and Uextra is the (per runqueue) extra
> - * reclaimable utilization.
> - * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations
> - * multiplied by 2^BW_SHIFT, the result has to be shifted right by
> - * BW_SHIFT.
> - * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT,
> - * dl_bw is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT=
.
> - * Since delta is a 64 bit variable, to have an overflow its value
> - * should be larger than 2^(64 - 20 - 8), which is more than 64 seconds.
> - * So, overflow is not an issue here.
> + * bandwidth, Uinact is the (per-runqueue) inactive utilization, compute=
d as
> + * the difference between the "total runqueue utilization" and the runqu=
eue
> + * active utilization, and Uextra is the (per runqueue) extra reclaimabl=
e
> + * utilization.
> + * Since rq->dl.running_bw and rq->dl.this_bw contain utilizations multi=
plied
> + * by 2^BW_SHIFT, the result has to be shifted right by BW_SHIFT.
> + * Since rq->dl.bw_ratio contains 1 / Umax multiplied by 2^RATIO_SHIFT, =
dl_bw
> + * is multiped by rq->dl.bw_ratio and shifted right by RATIO_SHIFT.i
> + * Since delta is a 64 bit variable, to have an overflow its value shoul=
d be
> + * larger than 2^(64 - 20 - 8), which is more than 64 seconds. So, overf=
low is
> + * not an issue here.
>   */
>  static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity=
 *dl_se)
>  {
> -       u64 u_inact =3D rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uac=
t */
>         u64 u_act;
> -       u64 u_act_min =3D (dl_se->dl_bw * rq->dl.bw_ratio) >> RATIO_SHIFT=
;
> +       u64 u_inact =3D rq->dl.this_bw - rq->dl.running_bw; /* Utot - Uac=
t */
>
>         /*
> -        * Instead of computing max{u * bw_ratio, (1 - u_inact - u_extra)=
},
> -        * we compare u_inact + rq->dl.extra_bw with
> -        * 1 - (u * rq->dl.bw_ratio >> RATIO_SHIFT), because
> -        * u_inact + rq->dl.extra_bw can be larger than
> -        * 1 * (so, 1 - u_inact - rq->dl.extra_bw would be negative
> -        * leading to wrong results)
> +        * Instead of computing max{u, (u_max - u_inact - u_extra)}, we
> +        * compare u_inact + u_extra with u_max - u, because u_inact + u_=
extra
> +        * can be larger than u_max. So, u_max - u_inact - u_extra would =
be
> +        * negative leading to wrong results.
>          */
> -       if (u_inact + rq->dl.extra_bw > BW_UNIT - u_act_min)
> -               u_act =3D u_act_min;
> +       if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
> +               u_act =3D dl_se->dl_bw;
>         else
> -               u_act =3D BW_UNIT - u_inact - rq->dl.extra_bw;
> +               u_act =3D rq->dl.max_bw - u_inact - rq->dl.extra_bw;
>
> +       u_act =3D (u_act * rq->dl.bw_ratio) >> RATIO_SHIFT;
>         return (delta * u_act) >> BW_SHIFT;
>  }
>
> @@ -2784,12 +2780,12 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_=
rq)
>  {
>         if (global_rt_runtime() =3D=3D RUNTIME_INF) {
>                 dl_rq->bw_ratio =3D 1 << RATIO_SHIFT;
> -               dl_rq->extra_bw =3D 1 << BW_SHIFT;
> +               dl_rq->max_bw =3D dl_rq->extra_bw =3D 1 << BW_SHIFT;
>         } else {
>                 dl_rq->bw_ratio =3D to_ratio(global_rt_runtime(),
>                           global_rt_period()) >> (BW_SHIFT - RATIO_SHIFT)=
;
> -               dl_rq->extra_bw =3D to_ratio(global_rt_period(),
> -                                                   global_rt_runtime());
> +               dl_rq->max_bw =3D dl_rq->extra_bw =3D
> +                       to_ratio(global_rt_period(), global_rt_runtime())=
;
>         }
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 3e8df6d31c1e..73027c2806dc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -753,6 +753,12 @@ struct dl_rq {
>         u64                     this_bw;
>         u64                     extra_bw;
>
> +       /*
> +        * Maximum available bandwidth for reclaiming by SCHED_FLAG_RECLA=
IM
> +        * tasks of this rq. Used in calculation of reclaimable bandwidth=
(GRUB).
> +        */
> +       u64                     max_bw;
> +
>         /*
>          * Inverse of the fraction of CPU utilization that can be reclaim=
ed
>          * by the GRUB algorithm.
> --
> 2.40.1
>
