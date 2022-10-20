Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495C606599
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJTQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:21:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A58F716551A;
        Thu, 20 Oct 2022 09:21:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EDD5D23A;
        Thu, 20 Oct 2022 09:21:11 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.67.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B84FF3F792;
        Thu, 20 Oct 2022 09:21:03 -0700 (PDT)
Date:   Thu, 20 Oct 2022 17:20:45 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Message-ID: <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

> The avg_util value tells us nothing about how much the CPU is going to
> be idle this time and it also tells us nothing about the
> latency-sensitivity of the workload.
>
> Yes, it tells us how much idle time there was on the given CPU in the
> past, on the average, but there is zero information about the
> distribution of that idle time in it.
>
> So in the first place please tell me why it fundamentally makes sense
> to use avg_util in CPU idle time management at all.

I have an alternative suggestion that could be a reasonable way forward
here. Instead of applying util-awareness on top of TEO where it would
have to be reconciled with how TEO is currently expected to work, I just
wrote a simple completely new governor which operates only on timer
events alongside util values.

The idea is this:
1. Find the deepest state based on residency and time until the next timer event
2. If sched_cpu_util() is above the threshold, select a shallower non-polling state

There's no other metrics or anything else under the current
implementation. I can't say how it would work on Intel systems and in
the presence of more idle states but having a completely separate
governor would be very useful for us to tune it specifically for our use
cases and types of systems (ie. ones with 2 idle states and no polling
states).

As it stands it performs quite well and achieves better results
(especially in terms of latency) than both menu & TEO but slightly worse
than the previously suggested TEO + util. As far as we're concerned
that's okay, we can work from there to try to find a way of doing
metrics or improving the algorithm that would be more tailored to using
the util approach. I think it's much cleaner than what we were
discussing previously since that was effectively overriding most of what
TEO was doing.

Here are some numbers to visualize the results. They were all obtained
in the same way as the ones in the cover letter so you can refer to that
in case something isn't clear.

'teo_util' is of course TEO + util as in the patchset.
'idleutil' is this entirely new proposed minimal governor.

1. Geekbench 5 (latency-sensitive, heavy load test)

+-----------------+----------+---------+-------------+
| metric          | kernel   |   value | perc_diff   |
|-----------------+----------+---------+-------------|
| multicore_score | menu     |  2832.3 | 0.0%        |
| multicore_score | teo      |  2815.3 | -0.6%       |
| multicore_score | teo_util |  2880.6 | 1.7%        |
| multicore_score | idleutil |  2859.3 | 0.95%       |
+-----------------+----------+---------+-------------+

Percentages & types of idle misses

+-----------+-------------+--------------+
| kernel    | type        |   percentage |
|-----------+-------------+--------------|
| menu      | too deep    |      15.613% |
| teo       | too deep    |       9.376% |
| teo_util  | too deep    |       4.581% |
| idleutil  | too deep    |       5.464% |
| menu      | too shallow |       2.611% |
| teo       | too shallow |       6.099% |
| teo_util  | too shallow |      14.141% |
| idleutil  | too shallow |      13.282% |
+-----------+-------------+--------------+

Power usage [mW]

+--------------+----------+----------+---------+-------------+
| chan_name    | metric   | kernel   |   value | perc_diff   |
|--------------+----------+----------+---------+-------------|
| total_power  | gmean    | menu     |  2705.9 | 0.0%        |
| total_power  | gmean    | teo      |  2668.2 | -1.39%      |
| total_power  | gmean    | teo_util |  2710.2 | 0.16%       |
| total_power  | gmean    | idleutil |  2657.9 | -1.78%      |
+--------------+----------+----------+---------+-------------+

Wakeup latency

+-----------------+----------+----------+-------------+-------------+
| comm            | metric   | kernel   |       value | perc_diff   |
|-----------------+----------+----------+-------------+-------------|
| AsyncTask #1    | gmean    | menu     | 66.85μs     | 0.0%        |
| AsyncTask #1    | gmean    | teo      | 66.79μs     | -0.09%      |
| AsyncTask #1    | gmean    | teo_util | 57.84μs     | -13.47%     |
| AsyncTask #1    | gmean    | idleutil | 62.61μs     | -6.35%      |
| labs.geekbench5 | gmean    | menu     | 80.62μs     | 0.0%        |
| labs.geekbench5 | gmean    | teo      | 94.75μs     | 17.52%      |
| labs.geekbench5 | gmean    | teo_util | 52.98μs     | -34.28%     |
| labs.geekbench5 | gmean    | idleutil | 68.58μs     | -14.93%     |
+-----------------+----------+----------+-------------+-------------+

2. PCMark Web Browsing (non latency-sensitive, normal usage test)

+----------------+----------+---------+-------------+
| metric         | kernel   |   value | perc_diff   |
|----------------+----------+---------+-------------|
| PcmaWebV2Score | menu     |  5232   | 0.0%        |
| PcmaWebV2Score | teo      |  5219.8 | -0.23%      |
| PcmaWebV2Score | teo_util |  5249.7 | 0.34%       |
| PcmaWebV2Score | idleutil |  5215.7 | -0.31%      |
+----------------+----------+---------+-------------+

Percentages & types of idle misses

+-----------+-------------+--------------+
| kernel    | type        |   percentage |
|-----------+-------------+--------------|
| menu      | too deep    |      24.814% |
| teo       | too deep    |       11.65% |
| teo_util  | too deep    |       3.753% |
| idleutil  | too deep    |       4.304% |
| menu      | too shallow |       3.101% |
| teo       | too shallow |       8.578% |
| teo_util  | too shallow |      18.309% |
| idleutil  | too shallow |      17.638% |
+-----------+-------------+--------------+

Power usage [mW]

+--------------+----------+----------+---------+-------------+
| chan_name    | metric   | kernel   |   value | perc_diff   |
|--------------+----------+----------+---------+-------------|
| total_power  | gmean    | menu     |   179.2 | 0.0%        |
| total_power  | gmean    | teo      |   184.8 | 3.1%        |
| total_power  | gmean    | teo_util |   180.5 | 0.71%       |
| total_power  | gmean    | idleutil |   185   | 3.24%       |
+--------------+----------+----------+---------+-------------+

Wakeup latency

+-----------------+----------+----------+-------------+-------------+
| comm            | metric   | kernel   |       value | perc_diff   |
|-----------------+----------+----------+-------------+-------------|
| CrRendererMain  | gmean    | menu     | 236.63μs    | 0.0%        |
| CrRendererMain  | gmean    | teo      | 201.85μs    | -14.7%      |
| CrRendererMain  | gmean    | teo_util | 111.76μs    | -52.77%     |
| CrRendererMain  | gmean    | idleutil | 105.55μs    | -55.39%     |
| chmark:workload | gmean    | menu     | 100.30μs    | 0.0%        |
| chmark:workload | gmean    | teo      | 80.20μs     | -20.04%     |
| chmark:workload | gmean    | teo_util | 53.81μs     | -46.35%     |
| chmark:workload | gmean    | idleutil | 71.29μs     | -28.92%     |
| RenderThread    | gmean    | menu     | 37.97μs     | 0.0%        |
| RenderThread    | gmean    | teo      | 31.69μs     | -16.54%     |
| RenderThread    | gmean    | teo_util | 34.32μs     | -9.63%      |
| RenderThread    | gmean    | idleutil | 35.78μs     | -5.77%      |
| surfaceflinger  | gmean    | menu     | 97.57μs     | 0.0%        |
| surfaceflinger  | gmean    | teo      | 98.86μs     | 1.31%       |
| surfaceflinger  | gmean    | teo_util | 72.59μs     | -25.6%      |
| surfaceflinger  | gmean    | idleutil | 56.23μs     | -42.37%     |
+-----------------+----------+----------+-------------+-------------+

I also have similar data for Jankbench & Speedometer with right about
the same results, I'll skip those for now for brevity.
Would you like me to send a patch with this new governor instead? What
would you think about this instead of the previously suggested approach?

Thanks,
Kajetan
