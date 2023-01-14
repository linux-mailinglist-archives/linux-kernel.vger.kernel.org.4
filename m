Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3BF66AE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjANVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjANVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:19:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725FD9EC3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:18:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g10so17433694wmo.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 13:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0nt0fJbwh8+Kc6chnTKA90NJ5v+OamoOFN+VwnbxMw=;
        b=XyEJ8LWwdP5LmhpF1KWG6ICnX/3b0JzPUmBlqGVkdY5mOMS9UeZarBnssBsr/hCOvr
         Ucap1gTyd1Xcwfx+kJYvfp6Cw8Xu0GONQVxAswz7zlDINZSj5nl1AuJbeF4fa0+KYzvZ
         2wxOWWp1J/9US0dMWCIj1G8sUOLp7XHiQxrI8Be68siPZH/EtDTsCZzOQNNYcic+8H5L
         fXoisTlM51LMKApVCUKId2VpFk+HldhEs0NSYZLfXhU4UvVtrlDCItmeI6C3Bdw/noPh
         34nD9W4TCNMOwSF2S15mFkJtHDCnuJfcw9OkguOwA+73y7xBFlGHsoCxKiydtjgvC1Q1
         q+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0nt0fJbwh8+Kc6chnTKA90NJ5v+OamoOFN+VwnbxMw=;
        b=V0yVI0FUXGI4LqsYDBah9m/gTYG4hbWMZurGQgXhecg8DOZj7WTfDx0hNfWbSXjTWe
         0XN9DEsb6DvyHs1o0aVYL2vhjApduZq0mL3d0OxG+3pvuRfEQYFe6CWySrZDwHx6QXoj
         tBL6a8pOkt2d/J3OJYQ0pdB+YrgpVwHPZZF2YU3t4Lynto7XLKEAvle5pAczlmCpXhpB
         7sfeYpHKSbeA4iV7Iosiw258glHJPhZRJuCu772+Cx0PeoH578s8GsTTi7emo9L4w7Q/
         vG8M48ePMYCPyzkbKuu+KE6dRnNVwI97iI0PzVgzQLzZrnirV5I56TXh9lB739CYNO/4
         gMyQ==
X-Gm-Message-State: AFqh2kr6cRhCUq1xWMV1VciyPk7ALY5GSa4fomc5T4YrYnBdiNMjfQvP
        OGg/Y5MOzKkVP8YkcAhMBfMbGpbc7pBbZQD2
X-Google-Smtp-Source: AMrXdXtgvJu/peSFfRxI4bdykgHpoA4IGfBlVbiMUR02qFKSDRy7joluofZaQFkXfZihfyixnMWyqw==
X-Received: by 2002:a05:600c:4aa8:b0:3d1:cee0:46d0 with SMTP id b40-20020a05600c4aa800b003d1cee046d0mr61693343wmp.25.1673731136909;
        Sat, 14 Jan 2023 13:18:56 -0800 (PST)
Received: from airbuntu (host86-130-134-87.range86-130.btcentralplus.com. [86.130.134.87])
        by smtp.gmail.com with ESMTPSA id k30-20020a05600c1c9e00b003d9b89a39b2sm32270316wms.10.2023.01.14.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 13:18:56 -0800 (PST)
Date:   Sat, 14 Jan 2023 21:18:54 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230114211854.nmvmhtd5yz5wgh2a@airbuntu>
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
 <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/13/23 15:28, Vincent Guittot wrote:
> Hi Kajetan,
> 
> On Fri, 13 Jan 2023 at 14:50, Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
> >
> > Hi,
> >
> > > By taking into account uclamp_min, the 1:1 relation between task misfit
> > > and cpu overutilized is no more true as a task with a small util_avg of
> > > may not may not fit a high capacity cpu because of uclamp_min constraint.
> > >
> > > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > > a CPU except for the uclamp_min hint which is a performance requirement.
> > >
> > > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > > can use this new value to take additional action to select the best CPU
> > > that doesn't match uclamp_min hint.
> >
> > I just wanted to flag some issues I noticed with this patch and the
> > entire topic.
> >
> > I was testing this on a Pixel 6 with a 5.18 android-mainline kernel with
> 
> Do you have more details to share on your setup ?
> Android kernel has some hack on top of the mainline. Do you use some ?
> Then, the perf and the power can be largely impacted by the cgroup
> configuration. Have you got details on your setup ?
> 
> I'm going to try to reproduce the behavior
> 
> > all the relevant uclamp and CFS scheduling patches backported to it from
> > mainline. From what I can see, the 'uclamp fits capacity' patchset
> > introduced some alarming power usage & performance issues that this
> > patch makes even worse.
> >
> > The patch stack for the following tables is as follows:
> >
> > (ufc_patched) sched/fair: unlink misfit task from cpu overutilized
> 
> I just sent a v3 which fixes a condition. Wonder if this could have an
> impact on the results both perf and power
> 
> > sched/uclamp: Fix a uninitialized variable warnings
> > (baseline_ufc) sched/fair: Check if prev_cpu has highest spare cap in feec()
> > sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
> > sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
> > sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
> > sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
> > sched/uclamp: Fix fits_capacity() check in feec()
> > sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
> > sched/uclamp: Fix relationship between uclamp and migration margin
> > (previous 'baseline' was here)
> >
> > I omitted the 3 patches relating directly to capacity_inversion but in

This could lead to confusion. Was there a specific reason for this omission?
Did you hit some problem?

> > the other tests I did with those there were similar issues. It's
> > probably easier to consider the uclamp parts and their effects in
> > isolation.
> >
> > 1. Geekbench 5 (performance regression)
> >
> > +-----------------+----------------------------+--------+-----------+
> > |     metric      |           kernel           | value  | perc_diff |
> > +-----------------+----------------------------+--------+-----------+
> > | multicore_score |          baseline          | 2765.4 |   0.0%    |
> > | multicore_score |        baseline_ufc        | 2704.3 |  -2.21%   | <-- a noticeable score decrease already
> > | multicore_score |        ufc_patched         | 2443.2 |  -11.65%  | <-- a massive score decrease
> > +-----------------+----------------------------+--------+-----------+
> >
> > +--------------+--------+----------------------------+--------+-----------+
> > |  chan_name   | metric |           kernel           | value  | perc_diff |
> > +--------------+--------+----------------------------+--------+-----------+
> > | total_power  | gmean  |          baseline          | 2664.0 |   0.0%    |
> > | total_power  | gmean  |        baseline_ufc        | 2621.5 |   -1.6%   | <-- worse performance per watt
> > | total_power  | gmean  |        ufc_patched         | 2601.2 |  -2.36%   | <-- much worse performance per watt
> > +--------------+--------+----------------------------+--------+-----------+

Hmm I think I've seen a better score but at the cost of more energy in my
testing in the past.

> >
> > The most likely cause for the regression seen above is the decrease in the amount of
> > time spent while overutilized with these patches. Maximising
> > overutilization for GB5 is the desired outcome as the benchmark for
> > almost its entire duration keeps either 1 core or all the cores
> > completely saturated so EAS cannot be effective. These patches have the
> > opposite from the desired effect in this area.
> >
> > +----------------------------+--------------------+--------------------+------------+
> > |          kernel            |        time        |     total_time     | percentage |
> > +----------------------------+--------------------+--------------------+------------+
> > |          baseline          |      121.979       |      181.065       |   67.46    |
> > |        baseline_ufc        |      120.355       |      184.255       |   65.32    |
> > |        ufc_patched         |       60.715       |      196.135       |   30.98    | <-- !!!
> > +----------------------------+--------------------+--------------------+------------+
> 
> I'm not surprised because some use cases which were not overutilized
> were wrongly triggered as overutilized so switching back to
> performance mode. You might have to tune the uclamp value

I remember there were tasks with uclamp_min=512 or something like that in the
system. I wonder if they're making the difference here - they will steal time
from bigger cores and increase energy too.

The big jump with Vincent patches is strange though. How many iterations do you
run? How long do you wait between each iteration?

The original behavior of overutilized in regards to util_avg shouldn't have
changed. It's worth digging a bit more into it.

I looked at my previous results and I was seeing ~57% on android12-5.10 kernel
for both with and without the patch.

> 
> >
> > 2. Jankbench (power usage regression)
> >
> > +--------+---------------+---------------------------------+-------+-----------+
> > | metric |   variable    |             kernel              | value | perc_diff |
> > +--------+---------------+---------------------------------+-------+-----------+
> > | gmean  | mean_duration |          baseline_60hz          | 14.6  |   0.0%    |
> > | gmean  | mean_duration |        baseline_ufc_60hz        | 15.2  |   3.83%   |
> > | gmean  | mean_duration |        ufc_patched_60hz         | 14.0  |  -4.12%   |
> > +--------+---------------+---------------------------------+-------+-----------+
> >
> > +--------+-----------+---------------------------------+-------+-----------+
> > | metric | variable  |             kernel              | value | perc_diff |
> > +--------+-----------+---------------------------------+-------+-----------+
> > | gmean  | jank_perc |          baseline_60hz          |  1.9  |   0.0%    |
> > | gmean  | jank_perc |        baseline_ufc_60hz        |  2.2  |  15.39%   |
> > | gmean  | jank_perc |        ufc_patched_60hz         |  2.0  |   3.61%   |
> > +--------+-----------+---------------------------------+-------+-----------+

How many iterations did you run? Do you think they could be within the noise
region?

> >
> > +--------------+--------+---------------------------------+-------+-----------+
> > |  chan_name   | metric |             kernel              | value | perc_diff |
> > +--------------+--------+---------------------------------+-------+-----------+
> > | total_power  | gmean  |          baseline_60hz          | 135.9 |   0.0%    |
> > | total_power  | gmean  |        baseline_ufc_60hz        | 155.7 |  14.61%   | <-- !!!
> > | total_power  | gmean  |        ufc_patched_60hz         | 157.1 |  15.63%   | <-- !!!
> > +--------------+--------+---------------------------------+-------+-----------+
> >
> > With these patches while running Jankbench we use up ~15% more power
> > just to achieve roughly the same results. Here I'm not sure where this
> > issue is coming from exactly but all the results above are very consistent
> > across different runs.

Have you tried to look at uclamp_min/max values of the tasks/cpus?

Do you know which cluster ended up using more energy? Have you looked at freq
residency between the runs?

I think the system could dynamically boost some UI tasks. I'd expect their
residency to increase on the medium/big cores compared to before the patch.
Which could explain what you see.

Did you check your schedutil/rate_limit_us is not using the default 10ms? It
should be 500us.

I had another patch to set transition latency of the cpufreq driver to 500us
instead of 5ms - but I doubt this actually was making any difference.

FWIW, I did compare my series against vanilla Pixel 6 kernel where I used
geekbench, speedometer, pcmark all with and without heavy background activities
to measure the impact of uclamp_max and nothing stood out then.

I sadly lost my original setup now. I doubt I'll be able to recreate it to
re-run these tests again anytime soon :/

Could you try removing all thermal handling from util_fits_cpu() so that my
series behaves like v1 again and see if this makes a difference? It's highlight
if subtle issues with thermal pressure handling are the culprit. Most obvious
is using instantaneous thermal pressure in ufc().


Thanks!

--
Qais Yousef
