Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1D06932D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBKR2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBKR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:28:34 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30B6105
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:28:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so6176831wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Np4kuJWs/zx9FaMvum0wspWo2Gkd4utoKdBLjJ5zvug=;
        b=ipsOzbT5DmzszZ8UzNrMuK1jxc7KXSaJEdY/+Bt/s5NWUQc/m5iJxT2Dj9qy234Ig3
         gAaGc6nTwnbUGuTJkBr0aaMEuoSPRhd7MCGqSLcstOWQ5Lp/wv3PQTjxqUyjz/vK5Qq2
         rPfXjy6ep/ebmAQdqAa7SgFhuQiAv7VQ0KuDAvnWWmwO1PXqaj9RJw6yDCvNhs3+Pu21
         bcMpcW6EmDmt84UrGQ3qqKESneFERGrPkmrzbn6ViB0u39R7wrBtCCq61Zw3nu5UuoZP
         FA3PIAKli0EsBP/iN2hhvr/FEpZz7BPdkHGxjcBzrFWUIrtvmU0176isKwy/uIo3QInV
         /KkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np4kuJWs/zx9FaMvum0wspWo2Gkd4utoKdBLjJ5zvug=;
        b=oAmTRQ46BllGGsfV4Pok5VzCApUMYRU3Mvww9sB71tQBsiB+AjgCoarJgr91tYebCQ
         CLzs9obEi8rOaiGXdso07PLt3SZajiysvAIv5FOhjBUF+XU+t0zjMre4cyIDrLCNyS6E
         M2IkQvB931M6KsAfrg7jNM6Px/mOeys0sNiVuYP/rUzUDMa+Xs4VkkyHAezstMJ2gx2z
         M2OVp7AACD4XC3BO3XtqvwQ7/bCwBEuHgAkE2e+AMgopnfnbirSVcyDubB8lRCiixA54
         n645wV5EmFZLOwIyHedj2ZkSvunzk4Ln3kGqxljnggtWtYBEDhmZMpbQBTYYzVVyNZab
         HukA==
X-Gm-Message-State: AO0yUKV3gZLGnGqM92C2JFi8nbfdcmaTodhiqc/s/O7QEMJWngE5xIx4
        4p05dv9jmcPcv0YxxMyFOP8quw==
X-Google-Smtp-Source: AK7set/kmTZewNgyW2AAVbjwvBGh84S8q+fKCpMlBqPtq2RsfVhmQ2OFyFWcj07vBG7u40OG/pyfcQ==
X-Received: by 2002:a05:600c:4496:b0:3dc:de85:5007 with SMTP id e22-20020a05600c449600b003dcde855007mr15361856wmo.21.1676136511360;
        Sat, 11 Feb 2023 09:28:31 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id j7-20020a5d6047000000b002c53a89f042sm6379640wrt.30.2023.02.11.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 09:28:30 -0800 (PST)
Date:   Sat, 11 Feb 2023 17:28:29 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230211172829.f2igueizqpwijjjz@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/23 10:45, Vincent Guittot wrote:
> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
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
> > Fix the logic by converting the variables into long and treating -1
> > value as 'not populated' instead of 0 which is a viable and correct
> > spare capacity value.
> >
> > Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > ---
> >  kernel/sched/fair.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index c6c8e7f52935..7a21ee74139f 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7382,11 +7382,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >         for (; pd; pd = pd->next) {
> >                 unsigned long util_min = p_util_min, util_max = p_util_max;
> >                 unsigned long cpu_cap, cpu_thermal_cap, util;
> > -               unsigned long cur_delta, max_spare_cap = 0;
> > +               long prev_spare_cap = -1, max_spare_cap = -1;
> >                 unsigned long rq_util_min, rq_util_max;
> > -               unsigned long prev_spare_cap = 0;
> > +               unsigned long cur_delta, base_energy;
> >                 int max_spare_cap_cpu = -1;
> > -               unsigned long base_energy;
> >                 int fits, max_fits = -1;
> >
> >                 cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > @@ -7461,7 +7460,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                         }
> >                 }
> >
> > -               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> > +               if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
> >                         continue;
> >
> >                 eenv_pd_busy_time(&eenv, cpus, p);
> > @@ -7469,7 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
> >
> >                 /* Evaluate the energy impact of using prev_cpu. */
> > -               if (prev_spare_cap > 0) {
> > +               if (prev_spare_cap > -1) {
> >                         prev_delta = compute_energy(&eenv, pd, cpus, p,
> >                                                     prev_cpu);
> >                         /* CPU utilization has changed */
> 
> I think that you also need the change below to make sure that the
> signed comparison will be used. I have quickly checked the assembly
> code for aarch64 and your patch keeps using unsigned comparison (b.ls)
>    ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> ffff8000080e4c94: f94067e0 ldr x0, [sp, #200]
> ffff8000080e4c98: eb00003f cmp x1, x0
> ffff8000080e4c9c: 54ff98a9 b.ls ffff8000080e3fb0
> <select_task_rq_fair+0x570>  // b.plast
> 
> Whereas the change below make it to use the signed version (b.le)
>    ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
> ffff8000080e4c94: f94067e0 ldr x0, [sp, #200]
> ffff8000080e4c98: eb00003f cmp x1, x0
> ffff8000080e4c9c: 54ff98ad b.le ffff8000080e3fb0 <select_task_rq_fair+0x570>
> 
> -- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7522,7 +7522,7 @@ static int find_energy_efficient_cpu(struct
> task_struct *p, int prev_cpu)
>                                 prev_spare_cap = cpu_cap;
>                                 prev_fits = fits;
>                         } else if ((fits > max_fits) ||
> -                                  ((fits == max_fits) && (cpu_cap >
> max_spare_cap))) {
> +                                  ((fits == max_fits) &&
> ((long)cpu_cap > max_spare_cap))) {
>                                 /*
>                                  * Find the CPU with the maximum spare capacity
>                                  * among the remaining CPUs in the performance

Isn't it better to go back to v1 form then? The inconsistent type paired with
the cast isn't getting too ugly for me :(

I don't think we can convert cpu_cap to long without having to do more work as
it is used with 'util'.


Cheers

--
Qais Yousef
