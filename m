Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9D616624
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKBP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiKBP27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:28:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1031C9;
        Wed,  2 Nov 2022 08:28:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70D411FB;
        Wed,  2 Nov 2022 08:28:53 -0700 (PDT)
Received: from e126311.arm.com (unknown [10.57.67.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC9A73F534;
        Wed,  2 Nov 2022 08:28:44 -0700 (PDT)
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 0/2] cpuidle: teo: Introduce util-awareness
Date:   Wed,  2 Nov 2022 15:28:06 +0000
Message-Id: <20221102152808.2978590-1-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At the moment, all the available idle governors operate mainly based on their own past correctness
metrics along with timer events without taking into account any scheduling information. Especially
on interactive systems, this results in them frequently selecting a deeper idle state and then
waking up before its target residency is hit, thus leading to increased wakeup latency and lower
performance with no power saving. For 'menu' while web browsing on Android for instance, those types
of wakeups ('too deep') account for over 24% of all wakeups.

At the same time, on some platforms C0 can be power efficient enough to warrant wanting to prefer
it over C1. This is because the power usage of the two states can be so close that sufficient
amounts of too deep C1 sleeps can completely offset the C1 power saving to the point where it
would've been more power efficient to just use C0 instead.

Sleeps that happened in C0 while they could have used C1 ('too shallow') only save
less power than they otherwise could have. Too deep sleeps, on the other hand, harm performance
and nullify the potential power saving from using C1 in the first place. While taking this into
account, it is clear that on balance it is preferable for an idle governor to have more too shallow
sleeps instead of more too deep sleeps on those kinds of platforms.

Currently the best available governor under this metric is TEO which on average results in less than
half the percentage of too deep sleeps compared to 'menu', getting much better wakeup latencies and
increased performance in the process.

This proposed optional extension to TEO would specifically tune it for minimising too deep
sleeps and minimising latency to achieve better performance. To this end, before selecting the next
idle state it uses the avg_util signal of a CPU's runqueue in order to determine to what extent the
CPU is being utilized. This util value is then compared to a threshold defined as a percentage of
the cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation). If the util is above the
threshold, the idle state selected by TEO metrics will be reduced by 1, thus selecting a shallower
state. If the util is below the threshold, the governor defaults to the TEO metrics mechanism to try
to select the deepest available idle state based on the closest timer event and its own correctness.

As of v2 the patch includes a 'fast exit' path for arm-based and similar systems where only 2 idle
states are present. If there's just 2 idle states and the CPU is utilized, we can directly select
the shallowest state and save cycles by skipping the entire metrics mechanism.

As of v3 it also includes an adjustment where on systems with more than 2 idle states the state will
only be reduced if the selected candidate is C1 and C0 is not a polling state. This will effectively
make the patch have no effect on most Intel systems.

This approach can outperform all the other currently available governors, at least on mobile device
workloads, which is why I think it is worth keeping as an option.

There is no particular attachment or reliance on TEO for this mechanism, I simply chose to base
it on TEO because it performs the best out of all the available options and I didn't think there was
any point in reinventing the wheel on the side of computing governor metrics. If a
better approach comes along at some point, there's no reason why the same idle aware mechanism
couldn't be used with any other metrics algorithm. That would, however, require implemeting it as
a separate governor rather than a TEO add-on.

As for how the extension performs in practice, below I'll add some benchmark results I got while
testing this patchset. All the benchmarks were run after holding the phone in the fridge for exactly
an hour each time to minimise the impact of thermal issues.

Pixel 6 (Android 12, mainline kernel 5.18, with newer mainline CFS patches):

1. Geekbench 5 (latency-sensitive, heavy load test)

The values below are gmean values across 3 back to back iteration of Geekbench 5.
As GB5 is a heavy benchmark, after more than 3 iterations intense throttling kicks in on mobile devices
resulting in skewed benchmark scores, which makes it difficult to collect reliable results. The actual
values for all of the governors can change between runs as the benchmark might be affected by factors
other than just latency. Nevertheless, on the runs I've seen, util-aware TEO frequently achieved better
scores than all the other governors.

Benchmark scores

+-----------------+-------------+---------+-------------+
| metric          | kernel      |   value | perc_diff   |
|-----------------+-------------+---------+-------------|
| multicore_score | menu        |  2826.5 | 0.0%        |
| multicore_score | teo         |  2764.8 | -2.18%      |
| multicore_score | teo_util_v3 |  2849   | 0.8%        |
| multicore_score | teo_util_v4 |  2865   | 1.36%       |
| score           | menu        |  1053   | 0.0%        |
| score           | teo         |  1050.7 | -0.22%      |
| score           | teo_util_v3 |  1059.6 | 0.63%       |
| score           | teo_util_v4 |  1057.6 | 0.44%       |
+-----------------+-------------+---------+-------------+

Idle misses

The numbers are percentages of too deep and too shallow sleeps computed using the new trace
event - cpu_idle_miss. The percentage is obtained by counting the two types of misses over
the course of a run and then dividing them by the total number of wakeups in that run.

+-------------+-------------+--------------+
| wa_path     | type        |   count_perc |
|-------------+-------------+--------------|
| menu        | too deep    |      14.994% |
| teo         | too deep    |       9.649% |
| teo_util_v3 | too deep    |       4.298% |
| teo_util_v4 | too deep    |       4.02 % |
| menu        | too shallow |       2.497% |
| teo         | too shallow |       5.963% |
| teo_util_v3 | too shallow |      13.773% |
| teo_util_v4 | too shallow |      14.598% |
+-------------+-------------+--------------+

Power usage [mW]

+--------------+----------+-------------+---------+-------------+
| chan_name    | metric   | kernel      |   value | perc_diff   |
|--------------+----------+-------------+---------+-------------|
| total_power  | gmean    | menu        |  2551.4 | 0.0%        |
| total_power  | gmean    | teo         |  2606.8 | 2.17%       |
| total_power  | gmean    | teo_util_v3 |  2670.1 | 4.65%       |
| total_power  | gmean    | teo_util_v4 |  2722.3 | 6.7%        |
+--------------+----------+-------------+---------+-------------+

Task wakeup latency

+-----------------+----------+-------------+-------------+-------------+
| comm            | metric   | kernel      |       value | perc_diff   |
|-----------------+----------+-------------+-------------+-------------|
| AsyncTask #1    | gmean    | menu        | 78.16μs     | 0.0%        |
| AsyncTask #1    | gmean    | teo         | 61.60μs     | -21.19%     |
| AsyncTask #1    | gmean    | teo_util_v3 | 74.34μs     | -4.89%      |
| AsyncTask #1    | gmean    | teo_util_v4 | 54.45μs     | -30.34%     |
| labs.geekbench5 | gmean    | menu        | 88.55μs     | 0.0%        |
| labs.geekbench5 | gmean    | teo         | 100.97μs    | 14.02%      |
| labs.geekbench5 | gmean    | teo_util_v3 | 53.57μs     | -39.5%      |
| labs.geekbench5 | gmean    | teo_util_v4 | 59.60μs     | -32.7%      |
+-----------------+----------+-------------+-------------+-------------+

In case of this benchmark, the difference in latency does seem to translate into better scores.

2. PCMark Web Browsing (non latency-sensitive, normal usage web browsing test)

The table below contains gmean values across 20 back to back iterations of PCMark 2 Web Browsing.

Benchmark scores

+----------------+-------------+---------+-------------+
| metric         | kernel      |   value | perc_diff   |
|----------------+-------------+---------+-------------|
| PcmaWebV2Score | menu        |  5232   | 0.0%        |
| PcmaWebV2Score | teo         |  5219.8 | -0.23%      |
| PcmaWebV2Score | teo_util_v3 |  5273.5 | 0.79%       |
| PcmaWebV2Score | teo_util_v4 |  5239.9 | 0.15%       |
+----------------+-------------+---------+-------------+

Idle misses

+-------------+-------------+--------------+
| wa_path     | type        |   count_perc |
|-------------+-------------+--------------|
| menu        | too deep    |      24.814% |
| teo         | too deep    |       11.65% |
| teo_util_v3 | too deep    |       3.481% |
| teo_util_v4 | too deep    |       3.662% |
| menu        | too shallow |       3.101% |
| teo         | too shallow |       8.578% |
| teo_util_v3 | too shallow |      18.326% |
| teo_util_v4 | too shallow |      18.692% |
+-------------+-------------+--------------+

Power usage [mW]

+--------------+----------+-------------+---------+-------------+
| chan_name    | metric   | kernel      |   value | perc_diff   |
|--------------+----------+-------------+---------+-------------|
| total_power  | gmean    | menu        |   179.2 | 0.0%        |
| total_power  | gmean    | teo         |   184.8 | 3.1%        |
| total_power  | gmean    | teo_util_v3 |   177.4 | -1.02%      |
| total_power  | gmean    | teo_util_v4 |   184.1 | 2.71%       |
+--------------+----------+-------------+---------+-------------+

Task wakeup latency

+-----------------+----------+-------------+-------------+-------------+
| comm            | metric   | kernel      |       value | perc_diff   |
|-----------------+----------+-------------+-------------+-------------|
| CrRendererMain  | gmean    | menu        | 236.63μs    | 0.0%        |
| CrRendererMain  | gmean    | teo         | 201.85μs    | -14.7%      |
| CrRendererMain  | gmean    | teo_util_v3 | 106.46μs    | -55.01%     |
| CrRendererMain  | gmean    | teo_util_v4 | 106.72μs    | -54.9%      |
| chmark:workload | gmean    | menu        | 100.30μs    | 0.0%        |
| chmark:workload | gmean    | teo         | 80.20μs     | -20.04%     |
| chmark:workload | gmean    | teo_util_v3 | 65.88μs     | -34.32%     |
| chmark:workload | gmean    | teo_util_v4 | 57.90μs     | -42.28%     |
| surfaceflinger  | gmean    | menu        | 97.57μs     | 0.0%        |
| surfaceflinger  | gmean    | teo         | 98.86μs     | 1.31%       |
| surfaceflinger  | gmean    | teo_util_v3 | 56.49μs     | -42.1%      |
| surfaceflinger  | gmean    | teo_util_v4 | 72.68μs     | -25.52%     |
+-----------------+----------+-------------+-------------+-------------+

In this case the large latency improvement does not translate into a notable increase in benchmark score as
this particular benchmark mainly responds to changes in operating frequency.

3. Jankbench (locked 60hz screen) (normal usage UI test)

Frame durations

+---------------+------------------+---------+-------------+
| variable      | kernel           |   value | perc_diff   |
|---------------+------------------+---------+-------------|
| mean_duration | menu_60hz        |    13.9 | 0.0%        |
| mean_duration | teo_60hz         |    14.7 | 6.0%        |
| mean_duration | teo_util_v3_60hz |    13.8 | -0.87%      |
| mean_duration | teo_util_v4_60hz |    12.6 | -9.0%       |
+---------------+------------------+---------+-------------+

Jank percentage

+------------+------------------+---------+-------------+
| variable   | kernel           |   value | perc_diff   |
|------------+------------------+---------+-------------|
| jank_perc  | menu_60hz        |     1.5 | 0.0%        |
| jank_perc  | teo_60hz         |     2.1 | 36.99%      |
| jank_perc  | teo_util_v3_60hz |     1.3 | -13.95%     |
| jank_perc  | teo_util_v4_60hz |     1.3 | -17.37%     |
+------------+------------------+---------+-------------+

Idle misses

+------------------+-------------+--------------+
| wa_path          | type        |   count_perc |
|------------------+-------------+--------------|
| menu_60hz        | too deep    |       26.00% |
| teo_60hz         | too deep    |       11.00% |
| teo_util_v3_60hz | too deep    |        2.33% |
| teo_util_v4_60hz | too deep    |        2.54% |
| menu_60hz        | too shallow |        4.74% |
| teo_60hz         | too shallow |       11.89% |
| teo_util_v3_60hz | too shallow |       21.78% |
| teo_util_v4_60hz | too shallow |       21.93% |
+------------------+-------------+--------------+

Power usage [mW]

+--------------+------------------+---------+-------------+
| chan_name    | kernel           |   value | perc_diff   |
|--------------+------------------+---------+-------------|
| total_power  | menu_60hz        |   144.6 | 0.0%        |
| total_power  | teo_60hz         |   136.9 | -5.27%      |
| total_power  | teo_util_v3_60hz |   134.2 | -7.19%      |
| total_power  | teo_util_v4_60hz |   121.3 | -16.08%     |
+--------------+------------------+---------+-------------+

Task wakeup latency

+-----------------+------------------+-------------+-------------+
| comm            | kernel           |       value | perc_diff   |
|-----------------+------------------+-------------+-------------|
| RenderThread    | menu_60hz        | 139.52μs    | 0.0%        |
| RenderThread    | teo_60hz         | 116.51μs    | -16.49%     |
| RenderThread    | teo_util_v3_60hz | 86.76μs     | -37.82%     |
| RenderThread    | teo_util_v4_60hz | 91.11μs     | -34.7%      |
| droid.benchmark | menu_60hz        | 135.88μs    | 0.0%        |
| droid.benchmark | teo_60hz         | 105.21μs    | -22.57%     |
| droid.benchmark | teo_util_v3_60hz | 83.92μs     | -38.24%     |
| droid.benchmark | teo_util_v4_60hz | 83.18μs     | -38.79%     |
| surfaceflinger  | menu_60hz        | 124.03μs    | 0.0%        |
| surfaceflinger  | teo_60hz         | 151.90μs    | 22.47%      |
| surfaceflinger  | teo_util_v3_60hz | 100.19μs    | -19.22%     |
| surfaceflinger  | teo_util_v4_60hz | 87.65μs     | -29.33%     |
+-----------------+------------------+-------------+-------------+

4. Speedometer 2 (heavy load web browsing test)

Benchmark scores

+-------------------+-------------+---------+-------------+
| metric            | kernel      |   value | perc_diff   |
|-------------------+-------------+---------+-------------|
| Speedometer Score | menu        |   102   | 0.0%        |
| Speedometer Score | teo         |   104.9 | 2.88%       |
| Speedometer Score | teo_util_v3 |   102.1 | 0.16%       |
| Speedometer Score | teo_util_v4 |   103.8 | 1.83%       |
+-------------------+-------------+---------+-------------+

Idle misses

+-------------+-------------+--------------+
| wa_path     | type        |   count_perc |
|-------------+-------------+--------------|
| menu        | too deep    |       17.95% |
| teo         | too deep    |        6.46% |
| teo_util_v3 | too deep    |        0.63% |
| teo_util_v4 | too deep    |        0.64% |
| menu        | too shallow |        3.86% |
| teo         | too shallow |        8.21% |
| teo_util_v3 | too shallow |       14.72% |
| teo_util_v4 | too shallow |       14.43% |
+-------------+-------------+--------------+

Power usage [mW]

+--------------+----------+-------------+---------+-------------+
| chan_name    | metric   | kernel      |   value | perc_diff   |
|--------------+----------+-------------+---------+-------------|
| total_power  | gmean    | menu        |  2059   | 0.0%        |
| total_power  | gmean    | teo         |  2187.8 | 6.26%       |
| total_power  | gmean    | teo_util_v3 |  2212.9 | 7.47%       |
| total_power  | gmean    | teo_util_v4 |  2121.8 | 3.05%       |
+--------------+----------+-------------+---------+-------------+

Task wakeup latency

+-----------------+----------+-------------+-------------+-------------+
| comm            | metric   | kernel      |       value | perc_diff   |
|-----------------+----------+-------------+-------------+-------------|
| CrRendererMain  | gmean    | menu        | 17.18μs     | 0.0%        |
| CrRendererMain  | gmean    | teo         | 16.18μs     | -5.82%      |
| CrRendererMain  | gmean    | teo_util_v3 | 18.04μs     | 5.05%       |
| CrRendererMain  | gmean    | teo_util_v4 | 18.25μs     | 6.27%       |
| RenderThread    | gmean    | menu        | 68.60μs     | 0.0%        |
| RenderThread    | gmean    | teo         | 48.44μs     | -29.39%     |
| RenderThread    | gmean    | teo_util_v3 | 48.01μs     | -30.02%     |
| RenderThread    | gmean    | teo_util_v4 | 51.24μs     | -25.3%      |
| surfaceflinger  | gmean    | menu        | 42.23μs     | 0.0%        |
| surfaceflinger  | gmean    | teo         | 29.84μs     | -29.33%     |
| surfaceflinger  | gmean    | teo_util_v3 | 24.51μs     | -41.95%     |
| surfaceflinger  | gmean    | teo_util_v4 | 29.64μs     | -29.8%      |
+-----------------+----------+-------------+-------------+-------------+

At the very least this approach seems promising so I wanted to discuss it in RFC form first.
Thank you for taking your time to read this!

--
Kajetan

v3 -> v4:
- remove the chunk of code skipping metrics updates when the CPU was utilized
- include new test results and more benchmarks in the cover letter

v2 -> v3:
- add a patch adding an option to skip polling states in teo_find_shallower_state()
- only reduce the state if the candidate state is C1 and C0 is not a polling state
- add a check for polling states in the 2-states fast-exit path
- remove the ifdefs and Kconfig option

v1 -> v2:
- rework the mechanism to reduce selected state by 1 instead of directly selecting C0 (suggested by Doug Smythies)
- add a fast-exit path for systems with 2 idle states to not waste cycles on metrics when utilized
- fix typos in comments
- include a missing header

Kajetan Puchalski (2):
  cpuidle: teo: Optionally skip polling states in teo_find_shallower_state()
  cpuidle: teo: Introduce util-awareness

 drivers/cpuidle/governors/teo.c | 88 +++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

-- 
2.37.1

