Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FA69DFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjBUMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjBUMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:07:40 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42E28D21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:07:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so1034752wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMkdALh35z/ij5zQ7pxNWFteAB5MLL8h2srMSC2gx9g=;
        b=yM0yJcK+JzIqpRJSdKA1bZM0f6SJYj0gJ/2Noe6CLGSSAsin5yYQ7X20TLNoaFn70Z
         FMpgSlLwjMSOlVmj4hKftu7vhWJzM95w8Lm+7t5ohJz2t7Pes5JWqeSNZnzCG4TLFv0g
         7OE1FP5915+kXd9G9V10b82q5J2zkEp0KjpkNK22j50GuAlWG/cNAunrqVfZU8bghcWY
         FaZnhm0bz0Efmh9g9BEqo2vE6WuM9SGNHmrkwMlCBuFrnPpvLJFQHfqdyosF2PAEZvXP
         izcfGRZ5LSjSkANgQ/Mp6FZTIqp37gELyQHzlySkcfsCQEwxUNcgqby1VJlUCrlXZ/U3
         WSkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMkdALh35z/ij5zQ7pxNWFteAB5MLL8h2srMSC2gx9g=;
        b=GH8uuIR0yD1Lmh2nSHhlU8gTizLS1sDN1GqzmqIn08rbFCOmWbnIZIUzIY36+12zjT
         +4qx/i6kk036p2RO7QlKyZuTcEq3w9eghgZa+qxCeIGqBLm7DfTAvN86AT9EHYMfPoP5
         2KGQolMooef/SZaMUe5kbVjXAkVxuUzNvZTJuuTOVNysQ6m9z2UOnFN7SYrb4IM0yo6j
         lYtbVDX9m4yf3pBVh+0dVdh+4RwNkmmjztonPWCbCtelVhwvZ6OP8orseKUBL2HIQoSN
         sbLuwqkW2vi10MoUWp1UN11kIfFISqBoKeYXDfhVoDd/gOLM4tTFuj2Z93E428SULQ0J
         J/FA==
X-Gm-Message-State: AO0yUKU21CR+pgy+UqSKC2eCkJf4otFm0jYlufIqTHMmvGbiiYYQdKLD
        O1c+OzZXtAsrVrWv7GEYmQa24g==
X-Google-Smtp-Source: AK7set8+Qw77JdSSt8eh1sfTkE3i0Yx1pKsDJ+Ow6sY1i42CrRPEi/5+M4413zFcZLxreXgEjEX6/w==
X-Received: by 2002:a05:600c:328a:b0:3e1:f8af:7941 with SMTP id t10-20020a05600c328a00b003e1f8af7941mr2836317wmp.20.1676981147450;
        Tue, 21 Feb 2023 04:05:47 -0800 (PST)
Received: from airbuntu ([104.132.45.105])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b003e2243cfe15sm14116250wmm.39.2023.02.21.04.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:05:46 -0800 (PST)
Date:   Tue, 21 Feb 2023 12:05:45 +0000
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
Message-ID: <20230221120545.iki7giafykvht3fp@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <20230211172829.f2igueizqpwijjjz@airbuntu>
 <CAKfTPtCGjRR3k_m9OAra6XZP83dBxbiDPnGr7B52M_o=D=Oqng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGjRR3k_m9OAra6XZP83dBxbiDPnGr7B52M_o=D=Oqng@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/23 18:02, Vincent Guittot wrote:
> On Sat, 11 Feb 2023 at 18:28, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 02/07/23 10:45, Vincent Guittot wrote:
> > > On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > When uclamp_max is being used, the util of the task could be higher than
> > > > the spare capacity of the CPU, but due to uclamp_max value we force fit
> > > > it there.
> > > >
> > > > The way the condition for checking for max_spare_cap in
> > > > find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> > > > its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> > > > max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> > > > hence ending up never performing compute_energy() for this cluster and
> > > > missing an opportunity for a better energy efficient placement to honour
> > > > uclamp_max setting.
> > > >
> > > >         max_spare_cap = 0;
> > > >         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
> > > >
> > > >         ...
> > > >
> > > >         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
> > > >
> > > >         ...
> > > >
> > > >         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> > > >         if (cpu_cap > max_spare_cap) {
> > > >                 max_spare_cap = cpu_cap;
> > > >                 max_spare_cap_cpu = cpu;
> > > >         }
> > > >
> > > > prev_spare_cap suffers from a similar problem.
> > > >
> > > > Fix the logic by converting the variables into long and treating -1
> > > > value as 'not populated' instead of 0 which is a viable and correct
> > > > spare capacity value.
> > > >
> > > > Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> > > > Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> > > > ---
> > > >  kernel/sched/fair.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > index c6c8e7f52935..7a21ee74139f 100644
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -7382,11 +7382,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >         for (; pd; pd = pd->next) {
> > > >                 unsigned long util_min = p_util_min, util_max = p_util_max;
> > > >                 unsigned long cpu_cap, cpu_thermal_cap, util;
> > > > -               unsigned long cur_delta, max_spare_cap = 0;
> > > > +               long prev_spare_cap = -1, max_spare_cap = -1;
> > > >                 unsigned long rq_util_min, rq_util_max;
> > > > -               unsigned long prev_spare_cap = 0;
> > > > +               unsigned long cur_delta, base_energy;
> > > >                 int max_spare_cap_cpu = -1;
> > > > -               unsigned long base_energy;
> > > >                 int fits, max_fits = -1;
> > > >
> > > >                 cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
> > > > @@ -7461,7 +7460,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                         }
> > > >                 }
> > > >
> > > > -               if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
> > > > +               if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
> > > >                         continue;
> > > >
> > > >                 eenv_pd_busy_time(&eenv, cpus, p);
> > > > @@ -7469,7 +7468,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> > > >                 base_energy = compute_energy(&eenv, pd, cpus, p, -1);
> > > >
> > > >                 /* Evaluate the energy impact of using prev_cpu. */
> > > > -               if (prev_spare_cap > 0) {
> > > > +               if (prev_spare_cap > -1) {
> > > >                         prev_delta = compute_energy(&eenv, pd, cpus, p,
> > > >                                                     prev_cpu);
> > > >                         /* CPU utilization has changed */
> > >
> > > I think that you also need the change below to make sure that the
> > > signed comparison will be used. I have quickly checked the assembly
> > > code for aarch64 and your patch keeps using unsigned comparison (b.ls)
> > >    ((fits == max_fits) && (cpu_cap > max_spare_cap))) {
> > > ffff8000080e4c94: f94067e0 ldr x0, [sp, #200]
> > > ffff8000080e4c98: eb00003f cmp x1, x0
> > > ffff8000080e4c9c: 54ff98a9 b.ls ffff8000080e3fb0
> > > <select_task_rq_fair+0x570>  // b.plast
> > >
> > > Whereas the change below make it to use the signed version (b.le)
> > >    ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
> > > ffff8000080e4c94: f94067e0 ldr x0, [sp, #200]
> > > ffff8000080e4c98: eb00003f cmp x1, x0
> > > ffff8000080e4c9c: 54ff98ad b.le ffff8000080e3fb0 <select_task_rq_fair+0x570>
> > >
> > > -- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -7522,7 +7522,7 @@ static int find_energy_efficient_cpu(struct
> > > task_struct *p, int prev_cpu)
> > >                                 prev_spare_cap = cpu_cap;
> > >                                 prev_fits = fits;
> > >                         } else if ((fits > max_fits) ||
> > > -                                  ((fits == max_fits) && (cpu_cap >
> > > max_spare_cap))) {
> > > +                                  ((fits == max_fits) &&
> > > ((long)cpu_cap > max_spare_cap))) {
> > >                                 /*
> > >                                  * Find the CPU with the maximum spare capacity
> > >                                  * among the remaining CPUs in the performance
> >
> > Isn't it better to go back to v1 form then? The inconsistent type paired with
> > the cast isn't getting too ugly for me :(
> 
> the cast into a long of the cpu capacity in the condition was a good
> way to fix this unsigned/signed comparison and make is consistent with
> the use of -1 as default value IMO
>     ((long)cpu_cap > max_spare_cap)

Fair enough. Our boolean brains differ :-) I'll add the cast.

Do you see the energy calculation issue Dietmar was trying to highlight? As it
stands I only have boolean tweaks to do for v3.


Cheers

--
Qais Yousef

> >
> > I don't think we can convert cpu_cap to long without having to do more work as
> > it is used with 'util'.
> >
> >
> > Cheers
> >
> > --
> > Qais Yousef
