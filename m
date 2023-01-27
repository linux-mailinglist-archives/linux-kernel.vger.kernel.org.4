Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F08067EAB4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjA0QU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjA0QUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:20:45 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB11786251
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:20:36 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id t190so2651163vkb.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FavT9wy4C+VYFYpEqC5ImHWCY/jFscZ6v8NZrWtbFBo=;
        b=zhzpPXNG4kBdHHoKPgbFhAiBHNaZbejr2wcgkhMZs33RgFGvcN0bglQwe44I27ynED
         Qqp9F8VSjrws8f09wnZ4M+WN5KAeBYbpeJsBBN8ifEu7635UOJO7PeFLu17cEL+m9ade
         vqdONH0oPGrTBm0f9iu+wDE8ZT0OgFTJt6mHaByGfFMK40rzevj0zS7fWEmbSZeBuGrI
         oWN2+p+XjU1B3qvEnm9ZLAzkxddhxocYoDwDAmHPpx1lWGZgBU8upORSbrrObGjiSXrA
         N6IPer70YxqCXBJLu/i0tvckDgRJcO8tW7qNF1ZaPT6fURoFBVo5hqBfWWX1DiQGyoK3
         XL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FavT9wy4C+VYFYpEqC5ImHWCY/jFscZ6v8NZrWtbFBo=;
        b=btAUiL+bV49d/Bij12rbskKolxO01A4Wo3aEBBv0tzehpaQMudMAXbgXUt77PaORZx
         KBTyWompZJ8FYHy170LM0CoET5eY/2HaYB0FRzIkTJdFJU/J6DWNTNiLDByXv7FFN7MR
         09oIfBoRYYXQRbc+LvFAyWgUwv6HE23FL62KDwu44aHxP2Uet14AAT/ligjn8yP6WWU3
         YB+B5KDwFUsfiJ3JYf0yaWYkcH8ysMkK2AnC0md7nNkz46kgNrKcJ7/DsKGjnY2o7AWT
         A1WdcETLnSMeFmbahbYd0snmB6GJxr4wB4l4OAfDglnf7Mm4SG3tey7MXENlJDjjzxxo
         2h9A==
X-Gm-Message-State: AO0yUKUnfPXV1GCMK2F/W2i4cGwcXCm9V/ce7IxcCn6vFfnJpkx23/Kp
        HMshenw/zRB3020c0PrJrc7dmhpcZbZr5VOhSNMXLQ==
X-Google-Smtp-Source: AK7set8647W3LhVwSophQNNR8Ky/ykKTQ7rhOQUrsbK9UISPVls75I2Lhk89LDnQRwaRK2D6Djb6TBZ8NDi36HfmvUM=
X-Received: by 2002:a1f:190b:0:b0:3e2:bd87:cdc9 with SMTP id
 11-20020a1f190b000000b003e2bd87cdc9mr1467605vkz.5.1674836435845; Fri, 27 Jan
 2023 08:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20230119174244.2059628-1-vincent.guittot@linaro.org> <d5012cdf-ad5b-adf8-11f6-8ac2c3a89f0b@arm.com>
In-Reply-To: <d5012cdf-ad5b-adf8-11f6-8ac2c3a89f0b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 27 Jan 2023 17:20:23 +0100
Message-ID: <CAKfTPtDH-0FrmYfH-61c+_TSM3DPtz9na47DuLYBxkwr8MmCkQ@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@kernel.org, peterz@infradead.org, qyousef@layalina.io,
        rafael@kernel.org, viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 at 12:42, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 19/01/2023 17:42, Vincent Guittot wrote:
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg may
> > not fit a high capacity cpu because of uclamp_min constraint.
> >
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> >
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > Change since v3:
> > - Keep current condition for uclamp_max_fits in util_fits_cpu()
> > - Update some comments
>
> We had already this discussion whether this patch can also remove
> Capacity Inversion (CapInv).
>
> After studying the code again, I'm not so sure anymore.
>
> This patch:
>
> (1) adds a dedicated return value (-1) to util_fits_cpu() when:
>
> `util fits 80% capacity_of() && util < uclamp_min && uclamp_min >
> capacity_orig_thermal (region c)`
>
> (2) Enhancements to the CPU selection in sic() and feec() to cater for
> this new return value.
>
> IMHO this doesn't make the intention of CapInv in util_fits_cpu()
> obsolete, which is using:
>
> in CapInv:
>
>   capacity_orig         = capacity_orig_of() - thermal_load_avg
>   capacity_orig_thermal = capacity_orig_of() - thermal_load_avg
>
> not in CapInv:
>
>   capacity_orig         = capacity_orig_of()
>   capacity_orig_thermal = capacity_orig_of() - th_pressure
>
> Maybe I still miss a bit of the story?
>
> v3 hints to removing the bits in the next version:
>
> https://lkml.kernel.org/r/20230115001906.v7uq4ddodrbvye7d@airbuntu
>
> >  kernel/sched/fair.c | 105 ++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 82 insertions(+), 23 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d4db72f8f84e..54e14da53274 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4561,8 +4561,8 @@ static inline int util_fits_cpu(unsigned long util,
> >        * handle the case uclamp_min > uclamp_max.
> >        */
> >       uclamp_min = min(uclamp_min, uclamp_max);
> > -     if (util < uclamp_min && capacity_orig != SCHED_CAPACITY_SCALE)
> > -             fits = fits && (uclamp_min <= capacity_orig_thermal);
> > +     if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
> > +             return -1;
>
> Or does the definition 'return -1 if util fits but uclamp doesn't' make
> the distinction between capacity_orig and capacity_orig_thermal obsolete
> and so CapInv?

Yes, that's the key point. When it returns -1, we will continue to
look for a possible cpu with better performance which replaces CapInv
with capacity_orig_of() - thermal_load_avg to detect a capacity
inversion.

>
> [...]
>
> >  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> > @@ -6138,6 +6142,7 @@ static inline bool cpu_overutilized(int cpu)
> >       unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> >       unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> >
> > +     /* Return true only if the utilization doesn't fits CPU's capacity */
>
> small typo: s/doesn't fits/doesn't fit
>
> [...]
>
> > @@ -6946,12 +6952,28 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
> >
> >               if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
> >                       continue;
> > -             if (util_fits_cpu(task_util, util_min, util_max, cpu))
> > +
> > +             fits = util_fits_cpu(task_util, util_min, util_max, cpu);
> > +
> > +             /* This CPU fits with all requirements */
> > +             if (fits > 0)
> >                       return cpu;
> > +             /*
> > +              * Only the min performance hint (i.e. uclamp_min) doesn't fit.
> > +              * Look for the CPU with best capacity.
> > +              */
> > +             else if (fits < 0)
> > +                     cpu_cap = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
>
> Still don't grasp why we use thermal_load_avg() here? Looks to me that
> this would only match the CapInv case in util_fits_cpu().
>
> [...]
>
