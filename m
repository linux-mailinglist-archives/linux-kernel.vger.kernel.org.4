Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0714867A87B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 02:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjAYBqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 20:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjAYBqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 20:46:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B26F29157;
        Tue, 24 Jan 2023 17:46:16 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D384B3;
        Tue, 24 Jan 2023 17:46:57 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [10.57.78.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 007533F64C;
        Tue, 24 Jan 2023 17:46:12 -0800 (PST)
Date:   Wed, 25 Jan 2023 01:46:07 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <Y9CJ3w4q/NCw5RcK@e126311.manchester.arm.com>
References: <20230119174244.2059628-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119174244.2059628-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> By taking into account uclamp_min, the 1:1 relation between task misfit
> and cpu overutilized is no more true as a task with a small util_avg may
> not fit a high capacity cpu because of uclamp_min constraint.
> 
> Add a new state in util_fits_cpu() to reflect the case that task would fit
> a CPU except for the uclamp_min hint which is a performance requirement.
> 
> Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> can use this new value to take additional action to select the best CPU
> that doesn't match uclamp_min hint.
> 

Just wanted to include some more test data here to flag potential issues
with how all these changes use thermal pressure in the scheduler.

For the tables below, 'baseline' is pre the already merged "uclamp fits
capacity" patchset.
'baseline_ufc' is the current mainline with said patchset applied.
The 'no_thermal' variants are variants with thermal handling taken out
of util_fits_cpu akin to the v1 variant of the patchset.
The 'patched' variants are the above but with the v4 of the 'unlink misfit
task' patch applied as well.

Geekbench 5:

+-----------------+-------------------------+--------+-----------+
|     metric      |         kernel          | value  | perc_diff |
+-----------------+-------------------------+--------+-----------+
| multicore_score |        baseline         | 2765.4 |   0.0%    |
| multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   | <-- mainline score regression
| multicore_score | baseline_ufc_no_thermal | 2870.8 |   3.81%   | <-- ~170 pts better without thermal
| multicore_score |     ufc_patched_v4      | 2839.8 |   2.69%   | <-- no more regression but worse than above
| multicore_score | ufc_patched_no_thermal  | 2891.0 |   4.54%   | <-- best score
+-----------------+-------------------------+--------+-----------+

+--------------+--------+-------------------------+--------+-----------+
|  chan_name   | metric |         kernel          | value  | perc_diff |
+--------------+--------+-------------------------+--------+-----------+
| total_power  | gmean  |        baseline         | 2664.0 |   0.0%    |
| total_power  | gmean  |      baseline_ufc       | 2621.5 |   -1.6%   |
| total_power  | gmean  | baseline_ufc_no_thermal | 2710.0 |   1.73%   |
| total_power  | gmean  |     ufc_patched_v4      | 2729.0 |   2.44%   |
| total_power  | gmean  | ufc_patched_no_thermal  | 2778.1 |   4.28%   |
+--------------+--------+-------------------------+--------+-----------+

(Jankbench scores show more or less no change, Jankbench power below)

+--------------+--------+------------------------------+-------+-----------+
|  chan_name   | metric |            kernel            | value | perc_diff |
+--------------+--------+------------------------------+-------+-----------+
| total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
| total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   | <-- mainline power usage regression
| total_power  | gmean  | baseline_ufc_no_thermal_60hz | 134.5 |  -1.01%   | <-- no more regression without the thermal bit
| total_power  | gmean  |     ufc_patched_v4_60hz      | 131.4 |  -3.26%   | <-- no more regression with the patch either
| total_power  | gmean  | ufc_patched_no_thermal_60hz  | 140.4 |   3.37%   | <-- both combined increase power usage
+--------------+--------+------------------------------+-------+-----------+

Specifically the swing of +15% power to -1% power by taking out thermal
handling from util_fits_cpu on the original patchset is noteworthy. It
shows that there's some subtle thermal-related interaction there taking
place that can have adverse effects on power usage.

Even more interestingly, the 'unlink misfit task' patch appears to be
preventing said interaction from happening down the line as it has a
similar effect to that of just taking out the thermal bits.

My only concern here is that without taking a closer look at the thermal
parts this power issue shown above could easily accidentally be
reintroduced at some point in the future.

> -- 
> 2.34.1
> 
