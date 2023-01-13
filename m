Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4E6669AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjAMOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjAMOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:37:00 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A563F76
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:29:02 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl4so23588197plb.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 06:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1mGF4lsVKLm/eDxz74sh69kCRVBYQn+CwprK0yc4u+Q=;
        b=GmUarweIy7GVBjeKLQkudWYCZQMAATfasa7tivR+9HNv34zVcO5pVXyOgc6AfPmGN6
         /8s0VniqivbBf1U6U6sLKWzbRPyYwqPzxGbJzJbsL2HhaOuavlInpuADZu4euneZjJ6S
         QI0jADkhtvQbUcPXLFFkUqa4alkLkhIBOrKASc83ZCHDf6zH8T79s6KZtXiLHSPZInFU
         nOkDCOdUPM6B86n96q1P59SG3aYE10fBIur7h2UdLwg0Hz3qidBXPc3UmIE/Sf0I5cLJ
         Ipd2wDQc2n4qhG/+MXiUaYzMAuc1N4fj71o2ZxHW69ej8KoI/xrI7gw/TQvP45Fw86IF
         az/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1mGF4lsVKLm/eDxz74sh69kCRVBYQn+CwprK0yc4u+Q=;
        b=Q74x0n5o+z7HRn8reI2Owmo2Ads9mBNep9durtJAF22MibWKsq/psyNSGpeLfLwtMw
         eYKvS051hDRboCRdTjexRgQ7scVRWPMW7vER5IxZwNqr/jgXnHHTjT28MlGus6Ym2UId
         wfoPrpkNdDMndR17hXp1lk46aYAqdL+yx2/rVHhXvbioApe6E5w0HXfzOREB6IN24BVv
         6p5OINknTGDnvbK/y6So/VC7l2zRqCrNoXo0ZRY7pWbRs26TYgKp/ydA0jwLI+Uf0o5L
         oY0Dsi51N7HDJSocdSWqjwWsVOZpApVr3km5VM25Pibl4VPbsVR2xjy3RdymJTEoL/zr
         UhfQ==
X-Gm-Message-State: AFqh2kpQ2g7Ks6DeUJDPEFNQomNA9EDbRT6SgM2Pcy2R0HgHu1z+wqPp
        VEcaozrsoRJats9isYhiMSfwwUaQj5YLWsI/XD19Oi1/FDIttYPQ
X-Google-Smtp-Source: AMrXdXt8iwarO9Phh6o0XtiRz31AjrNGA9akG6qhxQwr041CsW69OQYMLuQczKptQMgNLdkGRDa4Z7BhQGPt/I9Yeyc=
X-Received: by 2002:a17:90b:110d:b0:215:f80c:18e6 with SMTP id
 gi13-20020a17090b110d00b00215f80c18e6mr8012996pjb.45.1673620141513; Fri, 13
 Jan 2023 06:29:01 -0800 (PST)
MIME-Version: 1.0
References: <20221228165415.3436-1-vincent.guittot@linaro.org> <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
In-Reply-To: <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Jan 2023 15:28:49 +0100
Message-ID: <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajetan,

On Fri, 13 Jan 2023 at 14:50, Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi,
>
> > By taking into account uclamp_min, the 1:1 relation between task misfit
> > and cpu overutilized is no more true as a task with a small util_avg of
> > may not may not fit a high capacity cpu because of uclamp_min constraint.
> >
> > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > a CPU except for the uclamp_min hint which is a performance requirement.
> >
> > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > can use this new value to take additional action to select the best CPU
> > that doesn't match uclamp_min hint.
>
> I just wanted to flag some issues I noticed with this patch and the
> entire topic.
>
> I was testing this on a Pixel 6 with a 5.18 android-mainline kernel with

Do you have more details to share on your setup ?
Android kernel has some hack on top of the mainline. Do you use some ?
Then, the perf and the power can be largely impacted by the cgroup
configuration. Have you got details on your setup ?

I'm going to try to reproduce the behavior

> all the relevant uclamp and CFS scheduling patches backported to it from
> mainline. From what I can see, the 'uclamp fits capacity' patchset
> introduced some alarming power usage & performance issues that this
> patch makes even worse.
>
> The patch stack for the following tables is as follows:
>
> (ufc_patched) sched/fair: unlink misfit task from cpu overutilized

I just sent a v3 which fixes a condition. Wonder if this could have an
impact on the results both perf and power

> sched/uclamp: Fix a uninitialized variable warnings
> (baseline_ufc) sched/fair: Check if prev_cpu has highest spare cap in feec()
> sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
> sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
> sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
> sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
> sched/uclamp: Fix fits_capacity() check in feec()
> sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
> sched/uclamp: Fix relationship between uclamp and migration margin
> (previous 'baseline' was here)
>
> I omitted the 3 patches relating directly to capacity_inversion but in
> the other tests I did with those there were similar issues. It's
> probably easier to consider the uclamp parts and their effects in
> isolation.
>
> 1. Geekbench 5 (performance regression)
>
> +-----------------+----------------------------+--------+-----------+
> |     metric      |           kernel           | value  | perc_diff |
> +-----------------+----------------------------+--------+-----------+
> | multicore_score |          baseline          | 2765.4 |   0.0%    |
> | multicore_score |        baseline_ufc        | 2704.3 |  -2.21%   | <-- a noticeable score decrease already
> | multicore_score |        ufc_patched         | 2443.2 |  -11.65%  | <-- a massive score decrease
> +-----------------+----------------------------+--------+-----------+
>
> +--------------+--------+----------------------------+--------+-----------+
> |  chan_name   | metric |           kernel           | value  | perc_diff |
> +--------------+--------+----------------------------+--------+-----------+
> | total_power  | gmean  |          baseline          | 2664.0 |   0.0%    |
> | total_power  | gmean  |        baseline_ufc        | 2621.5 |   -1.6%   | <-- worse performance per watt
> | total_power  | gmean  |        ufc_patched         | 2601.2 |  -2.36%   | <-- much worse performance per watt
> +--------------+--------+----------------------------+--------+-----------+
>
> The most likely cause for the regression seen above is the decrease in the amount of
> time spent while overutilized with these patches. Maximising
> overutilization for GB5 is the desired outcome as the benchmark for
> almost its entire duration keeps either 1 core or all the cores
> completely saturated so EAS cannot be effective. These patches have the
> opposite from the desired effect in this area.
>
> +----------------------------+--------------------+--------------------+------------+
> |          kernel            |        time        |     total_time     | percentage |
> +----------------------------+--------------------+--------------------+------------+
> |          baseline          |      121.979       |      181.065       |   67.46    |
> |        baseline_ufc        |      120.355       |      184.255       |   65.32    |
> |        ufc_patched         |       60.715       |      196.135       |   30.98    | <-- !!!
> +----------------------------+--------------------+--------------------+------------+

I'm not surprised because some use cases which were not overutilized
were wrongly triggered as overutilized so switching back to
performance mode. You might have to tune the uclamp value

>
> 2. Jankbench (power usage regression)
>
> +--------+---------------+---------------------------------+-------+-----------+
> | metric |   variable    |             kernel              | value | perc_diff |
> +--------+---------------+---------------------------------+-------+-----------+
> | gmean  | mean_duration |          baseline_60hz          | 14.6  |   0.0%    |
> | gmean  | mean_duration |        baseline_ufc_60hz        | 15.2  |   3.83%   |
> | gmean  | mean_duration |        ufc_patched_60hz         | 14.0  |  -4.12%   |
> +--------+---------------+---------------------------------+-------+-----------+
>
> +--------+-----------+---------------------------------+-------+-----------+
> | metric | variable  |             kernel              | value | perc_diff |
> +--------+-----------+---------------------------------+-------+-----------+
> | gmean  | jank_perc |          baseline_60hz          |  1.9  |   0.0%    |
> | gmean  | jank_perc |        baseline_ufc_60hz        |  2.2  |  15.39%   |
> | gmean  | jank_perc |        ufc_patched_60hz         |  2.0  |   3.61%   |
> +--------+-----------+---------------------------------+-------+-----------+
>
> +--------------+--------+---------------------------------+-------+-----------+
> |  chan_name   | metric |             kernel              | value | perc_diff |
> +--------------+--------+---------------------------------+-------+-----------+
> | total_power  | gmean  |          baseline_60hz          | 135.9 |   0.0%    |
> | total_power  | gmean  |        baseline_ufc_60hz        | 155.7 |  14.61%   | <-- !!!
> | total_power  | gmean  |        ufc_patched_60hz         | 157.1 |  15.63%   | <-- !!!
> +--------------+--------+---------------------------------+-------+-----------+
>
> With these patches while running Jankbench we use up ~15% more power
> just to achieve roughly the same results. Here I'm not sure where this
> issue is coming from exactly but all the results above are very consistent
> across different runs.
>
> > --
> > 2.17.1
> >
> >
