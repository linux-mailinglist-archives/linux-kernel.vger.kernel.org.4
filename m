Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FA8669924
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbjAMNxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbjAMNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:52:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7782958F8A;
        Fri, 13 Jan 2023 05:50:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6607BFEC;
        Fri, 13 Jan 2023 05:50:46 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0CE73F8D6;
        Fri, 13 Jan 2023 05:50:00 -0800 (PST)
Date:   Fri, 13 Jan 2023 13:49:51 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com, kajetan.puchalski@arm.com
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228165415.3436-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> By taking into account uclamp_min, the 1:1 relation between task misfit
> and cpu overutilized is no more true as a task with a small util_avg of
> may not may not fit a high capacity cpu because of uclamp_min constraint.
> 
> Add a new state in util_fits_cpu() to reflect the case that task would fit
> a CPU except for the uclamp_min hint which is a performance requirement.
> 
> Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> can use this new value to take additional action to select the best CPU
> that doesn't match uclamp_min hint.

I just wanted to flag some issues I noticed with this patch and the
entire topic.

I was testing this on a Pixel 6 with a 5.18 android-mainline kernel with
all the relevant uclamp and CFS scheduling patches backported to it from
mainline. From what I can see, the 'uclamp fits capacity' patchset
introduced some alarming power usage & performance issues that this
patch makes even worse.

The patch stack for the following tables is as follows:

(ufc_patched) sched/fair: unlink misfit task from cpu overutilized
sched/uclamp: Fix a uninitialized variable warnings
(baseline_ufc) sched/fair: Check if prev_cpu has highest spare cap in feec()
sched/uclamp: Cater for uclamp in find_energy_efficient_cpu()'s early exit condition
sched/uclamp: Make cpu_overutilized() use util_fits_cpu()
sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
sched/uclamp: Make select_idle_capacity() use util_fits_cpu()
sched/uclamp: Fix fits_capacity() check in feec()
sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
sched/uclamp: Fix relationship between uclamp and migration margin
(previous 'baseline' was here)

I omitted the 3 patches relating directly to capacity_inversion but in
the other tests I did with those there were similar issues. It's
probably easier to consider the uclamp parts and their effects in
isolation.

1. Geekbench 5 (performance regression)

+-----------------+----------------------------+--------+-----------+
|     metric      |           kernel           | value  | perc_diff |
+-----------------+----------------------------+--------+-----------+
| multicore_score |          baseline          | 2765.4 |   0.0%    |
| multicore_score |        baseline_ufc        | 2704.3 |  -2.21%   | <-- a noticeable score decrease already
| multicore_score |        ufc_patched         | 2443.2 |  -11.65%  | <-- a massive score decrease
+-----------------+----------------------------+--------+-----------+

+--------------+--------+----------------------------+--------+-----------+
|  chan_name   | metric |           kernel           | value  | perc_diff |
+--------------+--------+----------------------------+--------+-----------+
| total_power  | gmean  |          baseline          | 2664.0 |   0.0%    |
| total_power  | gmean  |        baseline_ufc        | 2621.5 |   -1.6%   | <-- worse performance per watt
| total_power  | gmean  |        ufc_patched         | 2601.2 |  -2.36%   | <-- much worse performance per watt
+--------------+--------+----------------------------+--------+-----------+

The most likely cause for the regression seen above is the decrease in the amount of
time spent while overutilized with these patches. Maximising
overutilization for GB5 is the desired outcome as the benchmark for
almost its entire duration keeps either 1 core or all the cores
completely saturated so EAS cannot be effective. These patches have the
opposite from the desired effect in this area.

+----------------------------+--------------------+--------------------+------------+
|          kernel            |        time        |     total_time     | percentage |
+----------------------------+--------------------+--------------------+------------+
|          baseline          |      121.979       |      181.065       |   67.46    |
|        baseline_ufc        |      120.355       |      184.255       |   65.32    |
|        ufc_patched         |       60.715       |      196.135       |   30.98    | <-- !!!
+----------------------------+--------------------+--------------------+------------+

2. Jankbench (power usage regression)

+--------+---------------+---------------------------------+-------+-----------+
| metric |   variable    |             kernel              | value | perc_diff |
+--------+---------------+---------------------------------+-------+-----------+
| gmean  | mean_duration |          baseline_60hz          | 14.6  |   0.0%    |
| gmean  | mean_duration |        baseline_ufc_60hz        | 15.2  |   3.83%   |
| gmean  | mean_duration |        ufc_patched_60hz         | 14.0  |  -4.12%   |
+--------+---------------+---------------------------------+-------+-----------+

+--------+-----------+---------------------------------+-------+-----------+
| metric | variable  |             kernel              | value | perc_diff |
+--------+-----------+---------------------------------+-------+-----------+
| gmean  | jank_perc |          baseline_60hz          |  1.9  |   0.0%    |
| gmean  | jank_perc |        baseline_ufc_60hz        |  2.2  |  15.39%   |
| gmean  | jank_perc |        ufc_patched_60hz         |  2.0  |   3.61%   |
+--------+-----------+---------------------------------+-------+-----------+

+--------------+--------+---------------------------------+-------+-----------+
|  chan_name   | metric |             kernel              | value | perc_diff |
+--------------+--------+---------------------------------+-------+-----------+
| total_power  | gmean  |          baseline_60hz          | 135.9 |   0.0%    |
| total_power  | gmean  |        baseline_ufc_60hz        | 155.7 |  14.61%   | <-- !!!
| total_power  | gmean  |        ufc_patched_60hz         | 157.1 |  15.63%   | <-- !!!
+--------------+--------+---------------------------------+-------+-----------+

With these patches while running Jankbench we use up ~15% more power
just to achieve roughly the same results. Here I'm not sure where this
issue is coming from exactly but all the results above are very consistent
across different runs.

> -- 
> 2.17.1
> 
> 
