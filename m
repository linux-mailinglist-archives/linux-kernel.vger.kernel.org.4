Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB336681A53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjA3TZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjA3TZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:25:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52D15548
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:24:58 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so12054917ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0GBVXlF6AKiZTyNS4sARHEHNtZZQ3Cs73WzNr0/VSs=;
        b=7JWtwh9VAZ1RnVYQtd5BY4DOcu4JAz7SifByGFUmET7rD/+my2nyfMrR7oCTkP1jf+
         4DGgpCbyQPrlo7Si9M7mjA76g009Ddrv174FBiKKOEq9TwZ5cm5gJC/Wo6U2mbRSkSWG
         3G1ZOgcWzjI9Ks0pU1EsKz8dd2Rpnsc/QS4ReWNfW6/Ns25DxLxI0n3PSn2ZmBwMWz6S
         xPnP/Nb0YYDEXpNY575kSYyOoK4Jq+ooIM/Nyc7CIv/QaZYUODtuMOuLapEzjjSQ66QO
         3wQtVsuQNL9r5X7SBRFKAd8K8YrttvFnlaaxw525qoduDFXccY/itmxzFjEF1dUGqFQb
         GeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0GBVXlF6AKiZTyNS4sARHEHNtZZQ3Cs73WzNr0/VSs=;
        b=mUOz+AkkvNQQ8z1po3xzCklXacvU3sBOwxtcTbs9waKttaptIodrMvxCSMDtz5ymdZ
         78A+Eqwr1lMR+gde13421/5Lc6gKhuioTqnMfmslSPreqE0eTv0mGh5PTUviS5vpE0bt
         v+K98PNtMI30+3KkEAleHWDXo/B/akJ7e0fwGqcl0GH9xMuyyqnCDdfH6Hy/xowa29XB
         Q0gBFqkP1604/KdIjYzIQgrikc+iLAmclnqjmnQjfYEsvFli3zGSR+E0OVuuIqD31HV/
         zDzWlfR706iCCDjsnA5GKtJkQNuwmz7rPjnS8DqhxdH5fug7ld809mwpL4CNmABFN9/m
         Qptw==
X-Gm-Message-State: AO0yUKWFQ6qQ5r083uL4MvQwmlfSQ0e6+bugTqp5l1Q9WK8OkCAt2BsU
        BXdmqPWuPZ40sg6rYcgidfUVsw==
X-Google-Smtp-Source: AK7set+TrLBlUXkOcES0STjoQK4g6+IypkXYAP0xFap0BvJd6X5eJafw5LctEbFtO/btDCIDiAto+g==
X-Received: by 2002:a05:6402:28cf:b0:499:b320:fc2d with SMTP id ef15-20020a05640228cf00b00499b320fc2dmr3737678edb.33.1675106696881;
        Mon, 30 Jan 2023 11:24:56 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7d299000000b0048789661fa2sm7174994edq.66.2023.01.30.11.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:24:56 -0800 (PST)
Date:   Mon, 30 Jan 2023 19:24:54 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230130192454.ohau23v74agz7nol@airbuntu>
References: <20230129161444.1674958-1-qyousef@layalina.io>
 <20230129161444.1674958-2-qyousef@layalina.io>
 <CAKfTPtCstN-oJ=UsDJrwacj8fm_cq-5N3LAWc_zz32E2FCJgBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCstN-oJ=UsDJrwacj8fm_cq-5N3LAWc_zz32E2FCJgBg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/30/23 15:44, Vincent Guittot wrote:
> On Sun, 29 Jan 2023 at 17:14, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > When uclamp_max is being used, the util of the task could be higher than
> > the spare capacity of the CPU, but due to uclamp_max value we force fit
> > it there.
> >
> > The way the condition for checking for max_spare_cap in
> > find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> > its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> > max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> > hence ending up never performing compute_energy() for this cluster and
> > missing an opportunity for a better energy efficient placement to honour
> > uclamp_max setting.
> >
> >         max_spare_cap = 0;
> >         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
> >
> >         ...
> >
> >         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
> >
> >         ...
> >
> >         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> >         if (cpu_cap > max_spare_cap) {
> >                 max_spare_cap = cpu_cap;
> >                 max_spare_cap_cpu = cpu;
> >         }
> >
> > prev_spare_cap suffers from a similar problem.
> >
> > Fix the logic by treating -1UL value as 'not populated' instead of
> > 0 which is a viable and correct spare capacity value.
> >
> > Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e29e9ea4cde8..ca2c389d3180 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7390,9 +7390,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >         for (; pd; pd = pd->next) {
> >                 unsigned long util_min = p_util_min, util_max = p_util_max;
> >                 unsigned long cpu_cap, cpu_thermal_cap, util;
> > -               unsigned long cur_delta, max_spare_cap = 0;
> > +               unsigned long cur_delta, max_spare_cap = -1UL;
> >                 unsigned long rq_util_min, rq_util_max;
> > -               unsigned long prev_spare_cap = 0;
> > +               unsigned long prev_spare_cap = -1UL;
> >                 int max_spare_cap_cpu = -1;
> >                 unsigned long base_energy;
> >                 int fits, max_fits = -1;
> > @@ -7457,7 +7457,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                                 prev_spare_cap = cpu_cap;
> >                                 prev_fits = fits;
> >                         } else if ((fits > max_fits) ||
> > -                                  ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > +                                  ((fits == max_fits) &&
> > +                                  (cpu_cap > max_spare_cap || max_spare_cap == -1UL) {
> 
> Can't we use a signed comparison to include the case of max_spare_cap
> == -1 in cpu_cap > max_spare_cap ?

By converting max_spare_cap to long, right?

My memory could be failing me, but I seem to remember we had mixed usage and
consolidated into unsigned long. That's why I didn't want to break the trend.

Anyway. If no one shouts against that, I don't mind going for that.


Thanks

--
Qais Yousef

> 
> >                                 /*
> >                                  * Find the CPU with the maximum spare capacity
> >                                  * among the remaining CPUs in the performance
> > @@ -7469,7 +7470,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                         }
> >                 }
> >
> > -               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> > +               if (max_spare_cap_cpu < 0 && prev_spare_cap == -1UL)
> >                         continue;
> >
> >                 eenv_pd_busy_time(&eenv, cpus, p);
> > @@ -7477,7 +7478,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
> >
> >                 /* Evaluate the energy impact of using prev_cpu. */
> > -               if (prev_spare_cap > 0) {
> > +               if (prev_spare_cap != -1UL) {
> >                         prev_delta = compute_energy(&eenv, pd, cpus, p,
> >                                                     prev_cpu);
> >                         /* CPU utilization has changed */
> > @@ -7489,7 +7490,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                 }
> >
> >                 /* Evaluate the energy impact of using max_spare_cap_cpu. */
> > -               if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
> > +               if (max_spare_cap_cpu >= 0 &&
> > +                   (max_spare_cap > prev_spare_cap || prev_spare_cap == -1UL)) {
> >                         /* Current best energy cpu fits better */
> >                         if (max_fits < best_fits)
> >                                 continue;
> > --
> > 2.25.1
> >
