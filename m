Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C266905F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbjAMIO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbjAMIOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:14:18 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF1B55870
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:13:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso1054432pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kWHztmkjMPnm8D9GZ+C8SXA4iuVQMGSeUiMC9pUiqeQ=;
        b=tuxLpXWSa/UH2XWymxtR6kwLkdGK6mXciFApRiha2KyddlT6OU0SKD6USPH2W35dXJ
         M+xM/S//y/W/xG+bqOBCiOxhKHaGQGCHLvyU6880u2ara/A149eAwOsmAPnY/b2ptRUp
         b3xJO7XhBNC3QRkMMA9e5hm+LxvZjZcLuuzxWCtV00zJosoNuWus7kmEDq1f512qv0aS
         jdm6xlhrUDfglOb4xHH5I04xW/dUKo7BQdmD0F0scnVBzKHyCrkP2gnoWHOSm5o70WHf
         5XtMzql7wJ5saN/BNYhOzocsvRklBtgRP3EDsa6+/GaIEicqvy9DPhH1ydOkHn3QsjWp
         8tXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWHztmkjMPnm8D9GZ+C8SXA4iuVQMGSeUiMC9pUiqeQ=;
        b=NrCtn7f9JYRlvnRs5Z5EXC2mwP+QwFYVkbrTrMn2AHyMO4YFRDV0zryaEEP+Is/m6u
         X79oMjETiKMqswyaRh7JOUYb0oTAH9mCZFTZvPQHO126UR8szWC7iFvEX4Hlk0TkEINz
         g9W/uQqjjmJsq/5nJlrl2PVmusinwRVM54bwfvg0zdseH0TM9DoTjQ5cwY+BKPXUH69l
         aUBtd4wWNGbK7bjiJoIF9gfJpwbEdnG/mobffd795vQx5dq4dogdj1yY60Zi/YF7F3xc
         Q3HS9qJ2krwpTExdsYQARwrz4f4thp2HH5m87H+4K3KQ4/IsSPvgznHfNXcVRH9tMyLL
         4FEQ==
X-Gm-Message-State: AFqh2kpIxlV9A/wh3dS/4O1nEw1gCme12hUup5YnqpmR/BvgwFDmWVNC
        0WHCFK7JgA0dw2bsScXtbgocdLCLSVd3iBbf+b9No4NTTWGzIw==
X-Google-Smtp-Source: AMrXdXuECKlVtvs6b/rC4kYyoXwarIB+/1mFRdsuTjnbzpaXVPrs7y52elGNONgqRZWsmWMCxIN+RSwbMVegLq6q72A=
X-Received: by 2002:a17:903:324e:b0:194:5ff8:a3a9 with SMTP id
 ji14-20020a170903324e00b001945ff8a3a9mr500952plb.43.1673597611824; Fri, 13
 Jan 2023 00:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20230112122708.330667-1-qyousef@layalina.io> <20230112122708.330667-2-qyousef@layalina.io>
In-Reply-To: <20230112122708.330667-2-qyousef@layalina.io>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Jan 2023 09:13:20 +0100
Message-ID: <CAKfTPtCotoC4WErb8Jf2G5W=nLTisNkCZkYX-A-ZQ4yypZbFzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/uclamp: Fix a uninitialized variable warnings
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 at 13:27, Qais Yousef <qyousef@layalina.io> wrote:
>
> Addresses the following warnings:
>
> > config: riscv-randconfig-m031-20221111
> > compiler: riscv64-linux-gcc (GCC) 12.1.0
> >
> > smatch warnings:
> > kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_min'.
> > kernel/sched/fair.c:7263 find_energy_efficient_cpu() error: uninitialized symbol 'util_max'.
>
> Fixes: 244226035a1f ("sched/uclamp: Fix fits_capacity() check in feec()")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e9d906a9bba9..5a8e75d4a17b 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7353,10 +7353,10 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>         eenv_task_busy_time(&eenv, p, prev_cpu);
>
>         for (; pd; pd = pd->next) {
> +               unsigned long util_min = p_util_min, util_max = p_util_max;
>                 unsigned long cpu_cap, cpu_thermal_cap, util;
>                 unsigned long cur_delta, max_spare_cap = 0;
>                 unsigned long rq_util_min, rq_util_max;
> -               unsigned long util_min, util_max;
>                 unsigned long prev_spare_cap = 0;
>                 int max_spare_cap_cpu = -1;
>                 unsigned long base_energy;
> @@ -7375,6 +7375,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                 eenv.pd_cap = 0;
>
>                 for_each_cpu(cpu, cpus) {
> +                       struct rq *rq = cpu_rq(cpu);
> +
>                         eenv.pd_cap += cpu_thermal_cap;
>
>                         if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
> @@ -7393,24 +7395,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                          * much capacity we can get out of the CPU; this is
>                          * aligned with sched_cpu_util().
>                          */
> -                       if (uclamp_is_used()) {
> -                               if (uclamp_rq_is_idle(cpu_rq(cpu))) {
> -                                       util_min = p_util_min;
> -                                       util_max = p_util_max;
> -                               } else {
> -                                       /*
> -                                        * Open code uclamp_rq_util_with() except for
> -                                        * the clamp() part. Ie: apply max aggregation
> -                                        * only. util_fits_cpu() logic requires to
> -                                        * operate on non clamped util but must use the
> -                                        * max-aggregated uclamp_{min, max}.
> -                                        */
> -                                       rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> -                                       rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> -
> -                                       util_min = max(rq_util_min, p_util_min);
> -                                       util_max = max(rq_util_max, p_util_max);
> -                               }
> +                       if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
> +                               /*
> +                                * Open code uclamp_rq_util_with() except for
> +                                * the clamp() part. Ie: apply max aggregation
> +                                * only. util_fits_cpu() logic requires to
> +                                * operate on non clamped util but must use the
> +                                * max-aggregated uclamp_{min, max}.
> +                                */
> +                               rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
> +                               rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
> +
> +                               util_min = max(rq_util_min, p_util_min);
> +                               util_max = max(rq_util_max, p_util_max);
>                         }
>                         if (!util_fits_cpu(util, util_min, util_max, cpu))
>                                 continue;
> --
> 2.25.1
>
