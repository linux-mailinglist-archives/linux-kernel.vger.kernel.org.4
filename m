Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144505EF3FC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiI2LKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiI2LKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:10:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87BD929825
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 04:10:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B016B15BF;
        Thu, 29 Sep 2022 04:10:38 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.64.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962983F73B;
        Thu, 29 Sep 2022 04:10:28 -0700 (PDT)
Date:   Thu, 29 Sep 2022 12:10:17 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:47:23AM +0200, Peter Zijlstra wrote:

[...]

> Mostly I think you've demonstrated that none of this is worth it.
> 
> > -----------------------------------------------------------------------
> > 
> > HOK ... Honour Of Kings, Video game
> > FHD ... Full High Definition
> > fps ... frame per second
> > pwr ... power consumption
> > 
> > table values are in %
> 
> Oh... that's bloody insane; that's why none of it makes sense.

Hi,

We have seen similar results to the ones provided by MTK while running
Jankbench, a UI performance benchmark.

For the following tables, the pelt numbers refer to multiplier values so
pelt_1 -> 32ms, pelt_2 -> 16ms, pelt_4 -> 8ms.

We can see the max frame durations decreasing significantly in line with
changing the pelt multiplier. Having a faster-responding pelt lets us
improve the worst-case scenario by a large margin which is why it can be
useful in some cases where that worst-case scenario is important.

Max frame duration (ms)

+------------------+----------+
| kernel          |    value  |
|------------------+----------|
| pelt_1           | 157.426  |
| pelt_2           | 111.975  |
| pelt_4           | 85.2713  |
+------------------+----------+

However, it is accompanied by a very noticeable increase in power usage.
We have seen even bigger power usage increases for different workloads.
This is why we think it makes much more sense as something that can be
changed at runtime - if set at boot time the energy consumption increase
would nullify any of the potential benefits. For limited workloads or
scenarios, the tradeoff might be worth it.

Power usage [mW]

+------------------+---------+-------------+
| kernel           |   value | perc_diff   |
|------------------+---------+-------------|
| pelt_1           |   139.9 | 0.0%        |
| pelt_2           |   146.4 | 4.62%       |
| pelt_4           |   158.5 | 13.25%      |
+------------------+---------+-------------+

At the same time we see that the average-case can improve slightly as
well in the process and the consistency either doesn't get worse or
improves a bit too.

Mean frame duration (ms)

+---------------+------------------+---------+-------------+
| variable      | kernel           |   value | perc_diff   |
|---------------+------------------+---------+-------------|
| mean_duration | pelt_1           |    14.6 | 0.0%        |
| mean_duration | pelt_2           |    13.8 | -5.43%      |
| mean_duration | pelt_4           |    14.5 | -0.58%      |
+---------------+------------------+---------+-------------+

Jank percentage

+------------+------------------+---------+-------------+
| variable   | kernel           |   value | perc_diff   |
|------------+------------------+---------+-------------|
| jank_perc  | pelt_1           |     2.1 | 0.0%        |
| jank_perc  | pelt_2           |     2.1 | 0.11%       |
| jank_perc  | pelt_4           |     2   | -3.46%      |
+------------+------------------+---------+-------------+

> How is any of that an answer to:
>
>   "They want; I want an explanation of what exact problem is fixed how ;-)"
>
> This is just random numbers showing poking the number has some effect;
> it has zero explaination of why poking the number changes the workload
> and if that is in fact the right way to go about solving that particular
> issue.

Overall, the problem being solved here is that based on our testing the
PELT half life can occasionally be too slow to keep up in scenarios
where many frames need to be rendered quickly, especially on high-refresh
rate phones and similar devices. While it's not a problem most of the
time and so it doesn't warrant changing the default or having it set at
boot time, introducing this pelt multiplier would be very useful as a
tool to be able to avoid the worst-case in limited scenarios.

----
Kajetan
