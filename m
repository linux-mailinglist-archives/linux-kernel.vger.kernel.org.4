Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701096F7ED4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjEEIXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjEEIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:23:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50118848
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:22:45 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1a50cb65c92so10163585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683274965; x=1685866965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RkLCnQBsdwsV1p/4RCtyTOetTchHoF71We8h4kpNZQE=;
        b=wvnRPzVyYEh00K8TkSvvshZzZLhq0QXqxqRjo84wPYC50EB1f7bMz8ZNHWJ8NGXsMf
         0W8n3rfRP9jzW9awdr60Vm73/NkUPbJnU8BPnqn3YZKz2VhgAJr2VGWuhDG5lXGSeFt4
         MUWW5RhcaiLNc5P6UpLJSiQGisUP7yV56/eLax91vytoTwRJEKsa1vrUP2fHWSF1aSWg
         TF2UK+05q14mj2NgNVOh9PUT4SRiqnnhVWAvaPaw3K14i53ibwZEArsjW/Yajqf4M3yL
         eDrwikmr817Z0t0KYo9cMaMtdB5IsjDItGdvItG67e4PhYShnXJhBHXHkhJ7/Csp7dGD
         KwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683274965; x=1685866965;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RkLCnQBsdwsV1p/4RCtyTOetTchHoF71We8h4kpNZQE=;
        b=KX8IdlIMMT3OjHPfoDsf3dGMsNcFQ/j/hvW/HGJd0OB6XwQ7YUw8B6YLp+FCYUF6WO
         mT10+Bd3fIW7kTFNrqhFAdXMYhX22EP4lMblBZpFBzUhJgiNrswoa24fU/tNYYpeFhx6
         0jy766BFg0A7PTRRjtSIBtLKTDPoTZUgdcIIJapwefvoXDYXNqeEQ7/RpYNExi8eL7Sr
         MYnsFmgL7Fw18IbTv2LBdXMaZxJ6rCiLIhs+FRQAzaLCnGxvulQH7KW7xfpfBpnPduc8
         F3NlHs/3KMAUEPETHoxjs6waxrdSFpRU0YYD6Mjji+8Ikr/lJjEgcjH93OcZQYqWVh4r
         1kig==
X-Gm-Message-State: AC+VfDyscMVpbRD7iZlVLeFICLQz0bZiGKv21j/j86KtftMleWqtKQoa
        70QVETkZWFeS6Gsv17FC3xSyNXh38YQWgILZKEtUWw==
X-Google-Smtp-Source: ACHHUZ5vUW6yNwardf3UE9h1ZlYV+inRq1OOrOf6Uikh8up8J9sYqow8eb1q2El9ks7p/kJvrKL7qrQoBVJAZf+QjrM=
X-Received: by 2002:a17:902:ef96:b0:1aa:ce4d:c77d with SMTP id
 iz22-20020a170902ef9600b001aace4dc77dmr669554plb.24.1683274965298; Fri, 05
 May 2023 01:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com> <CAKfTPtDh_aQn15to7E9JypVXarFVcEL+jiWJMV6J7-Gijj9SyQ@mail.gmail.com>
 <f4501e45-3cfc-b605-b065-5693427ab877@arm.com>
In-Reply-To: <f4501e45-3cfc-b605-b065-5693427ab877@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 May 2023 10:22:34 +0200
Message-ID: <CAKfTPtBcT8KbH=r2zCgqBF7V7cp=REceiyWWjjCc8FD2btO-=A@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 at 19:11, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 03/05/2023 18:08, Vincent Guittot wrote:
> > On Thu, 6 Apr 2023 at 17:50, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
> >>
> >> The former returns max(util_avg, runnable_avg) capped by max CPU
> >> capacity. CPU contention is thereby considered through runnable_avg.
> >>
> >> The change in load-balance only affects migration type `migrate_util`.
> >
> > would be good to get some figures to show the benefit
>
> Yes. Will add JankbenchX on Pixel6 for sugov_get_util() and `perf bench
> sched messaging` on Ampere Altra with the next version.
>
> >> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> ---
> >>  kernel/sched/cpufreq_schedutil.c |  3 ++-
> >>  kernel/sched/fair.c              |  2 +-
> >>  kernel/sched/sched.h             | 19 +++++++++++++++++++
> >>  3 files changed, 22 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> index e3211455b203..728b186cd367 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -158,7 +158,8 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >>         struct rq *rq = cpu_rq(sg_cpu->cpu);
> >>
> >>         sg_cpu->bw_dl = cpu_bw_dl(rq);
> >> -       sg_cpu->util = effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_cpu->cpu),
> >> +       sg_cpu->util = effective_cpu_util(sg_cpu->cpu,
> >> +                                         cpu_boosted_util_cfs(sg_cpu->cpu),
> >
> > Shouldn't we have a similar change in feec to estimate correctly which
> > OPP/ freq will be selected by schedutil ?
>
> Yes, this should be more correct. Schedutil and EAS should see the world
> the same way.
>
> But IMHO only for the
>
> find_energy_efficient_cpu()
>   compute_energy()
>     eenv_pd_max_util()
>       util = cpu_util_next(..., p, ...)
>       effective_cpu_util(..., util, FREQUENCY_UTIL, ...)
>                                     ^^^^^^^^^^^^^^
yes only to get same max utilization and as a result the same OPP as schedutil

> case.
>
> Not sure what I do for the task contribution? We use
> task_util(p)/_task_util_est(p) inside cpu_util_next().
> Do I have to consider p->se.avg.runnable_avg as well?

hmm, I would stay with util_avg for now

>
> I don't think that we have a testcase showing any diff for this change
> individually though.
>
> [...]
