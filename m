Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031965F02B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjAEPfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjAEPe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:34:56 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B1DB1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:34:55 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 78so24727173pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VEMAC3NaeiDfoUJ4ew1SIYSbeVOSwvAQ23q2tsTXWc=;
        b=MZ2YNWrCTxTyH3VMUeMfoAhPyzDReSz++LhUk66y72J4YoPUEX+/ClanaLCku7F6wL
         17Yor7nsLZnq7hyDeDRFlmnC7eErrDkT5eGULMM96E5mi7QfRDwXutR1/hY7UqM4gKCh
         hnoQ+KuTS4B6pnspY4V710AKEvcWFDpthjTm0pnH+rPP+PiSKp2mc1wouFHupLMm7Vrm
         iGEJd0+wrMyWA6euY3c5HDA/pqBRu87IGFt8YfPaY8Qy7F7S37XljjAgcoomWgHOLInR
         ZSvO8/L+NE3tNPoctaPLvzUY2VhS/ly481W6/Uc1zkUjVj8tctuLKP6YoYfa8bH+Hzru
         /BKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VEMAC3NaeiDfoUJ4ew1SIYSbeVOSwvAQ23q2tsTXWc=;
        b=qvFXIqJ0GXWiq0hL6mLbdiu/wuhFHvRnDkbam1tMuqtPt+LSlJpWZjJukWrXQoCsOE
         ysAbVJ3EU4mLn9G566W0GNusaynbB/xbfdNVSxToOOkeFFzEl8COzO01I2tm4J0Z1NNX
         3IpcwynPynR9rcaPQqA3CpDlAxAg5YKmizQs/iHGfUpfjJNKvR4uRqrO/s1TxQLH6wkv
         F/bOz3CMVxt+4+f+GkWakEBo99limlvoRI73O3v2HNNuV32hBazByS0E403VDqXBI3SB
         ZggVm/Jzs/lOY6Vst87GqCe3AqOtrRQHjDxZAMDecy0jifSzvVFHfx54yA8aYhFxYUWw
         DigQ==
X-Gm-Message-State: AFqh2kptcJ5XqDvMBN2Kvaf7AoghCAjHbB5fvhLbmcogm/WuMGt9lBtm
        o4WQ2v2Or9HQ7XitIkIuTnzDI3TvYGulpOclMJyF2w==
X-Google-Smtp-Source: AMrXdXt1ss27xPtcb/OAWEC6RSCPy7QySfCwU41hcKVi+0ofcROdYF4BvtJ5BM7WTqOgLN2BACrZ0nUBnqrOnBGBdVs=
X-Received: by 2002:a63:353:0:b0:4a4:6963:e2b3 with SMTP id
 80-20020a630353000000b004a46963e2b3mr570663pgd.545.1672932894999; Thu, 05 Jan
 2023 07:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com> <CAJZ5v0i1MrgkRPiMEPeZBuFmx24D-JaWTwmdCTeBVPmretL7VA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i1MrgkRPiMEPeZBuFmx24D-JaWTwmdCTeBVPmretL7VA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 Jan 2023 16:34:43 +0100
Message-ID: <CAKfTPtBw0hNes6HFQaG00exRZa1Wpsrmh1oYf93hjtvzGcr7Wg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, 5 Jan 2023 at 16:07, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 5, 2023 at 3:52 PM Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
> >
> > Modern interactive systems, such as recent Android phones, tend to have=
 power
> > efficient shallow idle states. Selecting deeper idle states on a device=
 while a
> > latency-sensitive workload is running can adversely impact performance =
due to
> > increased latency. Additionally, if the CPU wakes up from a deeper slee=
p before
> > its target residency as is often the case, it results in a waste of ene=
rgy on
> > top of that.
> >
> > At the moment, none of the available idle governors take any scheduling
> > information into account. They also tend to overestimate the idle
> > duration quite often, which causes them to select excessively deep idle
> > states, thus leading to increased wakeup latency and lower performance =
with no
> > power saving. For 'menu' while web browsing on Android for instance, th=
ose
> > types of wakeups ('too deep') account for over 24% of all wakeups.
> >
> > At the same time, on some platforms idle state 0 can be power efficient
> > enough to warrant wanting to prefer it over idle state 1. This is becau=
se
> > the power usage of the two states can be so close that sufficient amoun=
ts
> > of too deep state 1 sleeps can completely offset the state 1 power savi=
ng to the
> > point where it would've been more power efficient to just use state 0 i=
nstead.
> > This is of course for systems where state 0 is not a polling state, suc=
h as
> > arm-based devices.
> >
> > Sleeps that happened in state 0 while they could have used state 1 ('to=
o shallow') only
> > save less power than they otherwise could have. Too deep sleeps, on the=
 other
> > hand, harm performance and nullify the potential power saving from usin=
g state 1 in
> > the first place. While taking this into account, it is clear that on ba=
lance it
> > is preferable for an idle governor to have more too shallow sleeps inst=
ead of
> > more too deep sleeps on those kinds of platforms.
> >
> > This patch specifically tunes TEO to prefer shallower idle states in
> > order to reduce wakeup latency and achieve better performance.
> > To this end, before selecting the next idle state it uses the avg_util =
signal
> > of a CPU's runqueue in order to determine to what extent the CPU is bei=
ng utilized.
> > This util value is then compared to a threshold defined as a percentage=
 of the
> > cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation).=
 If the
> > util is above the threshold, the idle state selected by TEO metrics wil=
l be
> > reduced by 1, thus selecting a shallower state. If the util is below th=
e threshold,
> > the governor defaults to the TEO metrics mechanism to try to select the=
 deepest
> > available idle state based on the closest timer event and its own corre=
ctness.
> >
> > The main goal of this is to reduce latency and increase performance for=
 some
> > workloads. Under some workloads it will result in an increase in power =
usage
> > (Geekbench 5) while for other workloads it will also result in a decrea=
se in
> > power usage compared to TEO (PCMark Web, Jankbench, Speedometer).
> >
> > It can provide drastically decreased latency and performance benefits i=
n certain
> > types of workloads that are sensitive to latency.
> >
> > Example test results:
> >
> > 1. GB5 (better score, latency & more power usage)
> >
> > | metric                                | menu           | teo         =
      | teo-util-aware    |
> > | ------------------------------------- | -------------- | ------------=
----- | ----------------- |
> > | gmean score                           | 2826.5 (0.0%)  | 2764.8 (-2.1=
8%)   | 2865 (1.36%)      |
> > | gmean power usage [mW]                | 2551.4 (0.0%)  | 2606.8 (2.17=
%)    | 2722.3 (6.7%)     |
> > | gmean too deep %                      | 14.99%         | 9.65%       =
      | 4.02%             |
> > | gmean too shallow %                   | 2.5%           | 5.96%       =
      | 14.59%            |
> > | gmean task wakeup latency (asynctask) | 78.16=CE=BCs (0.0%) | 61.60=
=CE=BCs (-21.19%) | 54.45=CE=BCs (-30.34%) |
> >
> > 2. Jankbench (better score, latency & less power usage)
> >
> > | metric                                | menu           | teo         =
      | teo-util-aware    |
> > | ------------------------------------- | -------------- | ------------=
----- | ----------------- |
> > | gmean frame duration                  | 13.9 (0.0%)    | 14.7 (6.0%) =
      | 12.6 (-9.0%)      |
> > | gmean jank percentage                 | 1.5 (0.0%)     | 2.1 (36.99%)=
      | 1.3 (-17.37%)     |
> > | gmean power usage [mW]                | 144.6 (0.0%)   | 136.9 (-5.27=
%)    | 121.3 (-16.08%)   |
> > | gmean too deep %                      | 26.00%         | 11.00%      =
      | 2.54%             |
> > | gmean too shallow %                   | 4.74%          | 11.89%      =
      | 21.93%            |
> > | gmean wakeup latency (RenderThread)   | 139.5=CE=BCs (0.0%) | 116.5=
=CE=BCs (-16.49%) | 91.11=CE=BCs (-34.7%)  |
> > | gmean wakeup latency (surfaceflinger) | 124.0=CE=BCs (0.0%) | 151.9=
=CE=BCs (22.47%)  | 87.65=CE=BCs (-29.33%) |
> >
> > Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
>
> This looks good enough for me.
>
> There are still a couple of things I would change in it, but I may as
> well do that when applying it, so never mind.
>
> The most important question for now is what the scheduler people think
> about calling sched_cpu_util() from a CPU idle governor.  Peter,
> Vincent?

I don't see a problem with using sched_cpu_util() outside the
scheduler as it's already used in thermal and dtpm to get cpu
utilization.

>
> > ---
> >  drivers/cpuidle/governors/teo.c | 92 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governor=
s/teo.c
> > index e2864474a98d..2a2be4f45b70 100644
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -2,8 +2,13 @@
> >  /*
> >   * Timer events oriented CPU idle governor
> >   *
> > + * TEO governor:
> >   * Copyright (C) 2018 - 2021 Intel Corporation
> >   * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > + *
> > + * Util-awareness mechanism:
> > + * Copyright (C) 2022 Arm Ltd.
> > + * Author: Kajetan Puchalski <kajetan.puchalski@arm.com>
> >   */
> >
> >  /**
> > @@ -99,14 +104,55 @@
> >   *      select the given idle state instead of the candidate one.
> >   *
> >   * 3. By default, select the candidate state.
> > + *
> > + * Util-awareness mechanism:
> > + *
> > + * The idea behind the util-awareness extension is that there are two =
distinct
> > + * scenarios for the CPU which should result in two different approach=
es to idle
> > + * state selection - utilized and not utilized.
> > + *
> > + * In this case, 'utilized' means that the average runqueue util of th=
e CPU is
> > + * above a certain threshold.
> > + *
> > + * When the CPU is utilized while going into idle, more likely than no=
t it will
> > + * be woken up to do more work soon and so a shallower idle state shou=
ld be
> > + * selected to minimise latency and maximise performance. When the CPU=
 is not
> > + * being utilized, the usual metrics-based approach to selecting the d=
eepest
> > + * available idle state should be preferred to take advantage of the p=
ower
> > + * saving.
> > + *
> > + * In order to achieve this, the governor uses a utilization threshold=
.
> > + * The threshold is computed per-cpu as a percentage of the CPU's capa=
city
> > + * by bit shifting the capacity value. Based on testing, the shift of =
6 (~1.56%)
> > + * seems to be getting the best results.
> > + *
> > + * Before selecting the next idle state, the governor compares the cur=
rent CPU
> > + * util to the precomputed util threshold. If it's below, it defaults =
to the
> > + * TEO metrics mechanism. If it's above, the idle state will be reduce=
d to C0
> > + * as long as C0 is not a polling state.
> >   */
> >
> >  #include <linux/cpuidle.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/kernel.h>
> > +#include <linux/sched.h>
> >  #include <linux/sched/clock.h>
> > +#include <linux/sched/topology.h>
> >  #include <linux/tick.h>
> >
> > +/*
> > + * The number of bits to shift the cpu's capacity by in order to deter=
mine
> > + * the utilized threshold.
> > + *
> > + * 6 was chosen based on testing as the number that achieved the best =
balance
> > + * of power and performance on average.
> > + *
> > + * The resulting threshold is high enough to not be triggered by backg=
round
> > + * noise and low enough to react quickly when activity starts to ramp =
up.
> > + */
> > +#define UTIL_THRESHOLD_SHIFT 6
> > +
> > +
> >  /*
> >   * The PULSE value is added to metrics when they grow and the DECAY_SH=
IFT value
> >   * is used for decreasing metrics on a regular basis.
> > @@ -137,9 +183,11 @@ struct teo_bin {
> >   * @time_span_ns: Time between idle state selection and post-wakeup up=
date.
> >   * @sleep_length_ns: Time till the closest timer event (at the selecti=
on time).
> >   * @state_bins: Idle state data bins for this CPU.
> > - * @total: Grand total of the "intercepts" and "hits" mertics for all =
bins.
> > + * @total: Grand total of the "intercepts" and "hits" metrics for all =
bins.
> >   * @next_recent_idx: Index of the next @recent_idx entry to update.
> >   * @recent_idx: Indices of bins corresponding to recent "intercepts".
> > + * @util_threshold: Threshold above which the CPU is considered utiliz=
ed
> > + * @utilized: Whether the last sleep on the CPU happened while utilize=
d
> >   */
> >  struct teo_cpu {
> >         s64 time_span_ns;
> > @@ -148,10 +196,29 @@ struct teo_cpu {
> >         unsigned int total;
> >         int next_recent_idx;
> >         int recent_idx[NR_RECENT];
> > +       unsigned long util_threshold;
> > +       bool utilized;
> >  };
> >
> >  static DEFINE_PER_CPU(struct teo_cpu, teo_cpus);
> >
> > +/**
> > + * teo_cpu_is_utilized - Check if the CPU's util is above the threshol=
d
> > + * @cpu: Target CPU
> > + * @cpu_data: Governor CPU data for the target CPU
> > + */
> > +#ifdef CONFIG_SMP
> > +static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> > +{
> > +       return sched_cpu_util(cpu) > cpu_data->util_threshold;
> > +}
> > +#else
> > +static bool teo_cpu_is_utilized(int cpu, struct teo_cpu *cpu_data)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> >  /**
> >   * teo_update - Update CPU metrics after wakeup.
> >   * @drv: cpuidle driver containing state data.
> > @@ -323,6 +390,20 @@ static int teo_select(struct cpuidle_driver *drv, =
struct cpuidle_device *dev,
> >                         goto end;
> >         }
> >
> > +       cpu_data->utilized =3D teo_cpu_is_utilized(dev->cpu, cpu_data);
> > +       /*
> > +        * The cpu is being utilized over the threshold there are only =
2 states to choose from.
> > +        * No need to consider metrics, choose the shallowest non-polli=
ng state and exit.
> > +        */
> > +       if (drv->state_count < 3 && cpu_data->utilized) {
> > +               for (i =3D 0; i < drv->state_count; ++i) {
> > +                       if (!dev->states_usage[i].disable && !(drv->sta=
tes[i].flags & CPUIDLE_FLAG_POLLING)) {
> > +                               idx =3D i;
> > +                               goto end;
> > +                       }
> > +               }
> > +       }
> > +
> >         /*
> >          * Find the deepest idle state whose target residency does not =
exceed
> >          * the current sleep length and the deepest idle state not deep=
er than
> > @@ -454,6 +535,13 @@ static int teo_select(struct cpuidle_driver *drv, =
struct cpuidle_device *dev,
> >         if (idx > constraint_idx)
> >                 idx =3D constraint_idx;
> >
> > +       /*
> > +        * If the CPU is being utilized over the threshold,
> > +        * choose a shallower non-polling state to improve latency
> > +        */
> > +       if (cpu_data->utilized)
> > +               idx =3D teo_find_shallower_state(drv, dev, idx, duratio=
n_ns, true);
> > +
> >  end:
> >         /*
> >          * Don't stop the tick if the selected state is a polling one o=
r if the
> > @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver=
 *drv,
> >                              struct cpuidle_device *dev)
> >  {
> >         struct teo_cpu *cpu_data =3D per_cpu_ptr(&teo_cpus, dev->cpu);
> > +       unsigned long max_capacity =3D arch_scale_cpu_capacity(dev->cpu=
);
> >         int i;
> >
> >         memset(cpu_data, 0, sizeof(*cpu_data));
> > +       cpu_data->util_threshold =3D max_capacity >> UTIL_THRESHOLD_SHI=
FT;
> >
> >         for (i =3D 0; i < NR_RECENT; i++)
> >                 cpu_data->recent_idx[i] =3D -1;
> > --
> > 2.37.1
> >
