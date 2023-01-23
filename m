Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6218677A92
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjAWMKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjAWMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:10:32 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACB4D1F5CC;
        Mon, 23 Jan 2023 04:10:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB63AD7;
        Mon, 23 Jan 2023 04:11:12 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0D313F64C;
        Mon, 23 Jan 2023 04:10:27 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:10:22 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com, kajetan.puchalski@arm.com
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <Y855HxG8hK78+NtQ@e126311.manchester.arm.com>
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
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> Change since v3:
> - Keep current condition for uclamp_max_fits in util_fits_cpu()
> - Update some comments

That one condition change from v3 did fix the overutilization issues so
good news on that front :)

1. GB5

+-----------------+-------------------------+--------+-----------+
|     metric      |         kernel          | value  | perc_diff |
+-----------------+-------------------------+--------+-----------+
| multicore_score |        baseline         | 2765.4 |   0.0%    |
| multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   | <-- current mainline regression
| multicore_score |     ufc_patched_v4      | 2839.8 |   2.69%   | <-- new score improvement
+-----------------+-------------------------+--------+-----------+

+--------------+--------+-------------------------+--------+-----------+
|  chan_name   | metric |         kernel          | value  | perc_diff |
+--------------+--------+-------------------------+--------+-----------+
| total_power  | gmean  |        baseline         | 2664.0 |   0.0%    |
| total_power  | gmean  |      baseline_ufc       | 2621.5 |   -1.6%   |
| total_power  | gmean  |     ufc_patched_v4      | 2729.0 |   2.44%   |
+--------------+--------+-------------------------+--------+-----------+

2. Jankbench

+--------+---------------+------------------------------+-------+-----------+
| metric |   variable    |            kernel            | value | perc_diff |
+--------+---------------+------------------------------+-------+-----------+
| gmean  | mean_duration |        baseline_60hz         | 14.6  |   0.0%    |
| gmean  | mean_duration |      baseline_ufc_60hz       | 15.2  |   3.83%   |
| gmean  | mean_duration |     ufc_patched_v4_60hz      | 14.0  |  -3.98%   |
+--------+---------------+------------------------------+-------+-----------+

+--------+-----------+------------------------------+-------+-----------+
| metric | variable  |            kernel            | value | perc_diff |
+--------+-----------+------------------------------+-------+-----------+
| gmean  | jank_perc |        baseline_60hz         |  1.9  |   0.0%    |
| gmean  | jank_perc |      baseline_ufc_60hz       |  2.2  |  15.39%   |
| gmean  | jank_perc |     ufc_patched_v4_60hz      |  1.8  |  -5.67%   |
+--------+-----------+------------------------------+-------+-----------+

+--------------+--------+------------------------------+-------+-----------+
|  chan_name   | metric |            kernel            | value | perc_diff |
+--------------+--------+------------------------------+-------+-----------+
| total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
| total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   | <-- current mainline regression
| total_power  | gmean  |     ufc_patched_v4_60hz      | 131.4 |  -3.26%   | <-- new power saving
+--------------+--------+------------------------------+-------+-----------+

All in all this comes out better on every metric than the previous
baseline and way better than current mainline. At least from an Android
perspective as far as the impacts go I'd say it's probably fine to go
ahead and apply this.

Feel free to add this if you'd like:
Tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>

> -- 
> 2.34.1
> 
> 
