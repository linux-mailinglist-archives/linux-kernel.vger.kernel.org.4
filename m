Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781A85EF7DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiI2OmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiI2OmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:42:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B0611332F3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:42:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8912D1650;
        Thu, 29 Sep 2022 07:42:07 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.64.220])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7D03F792;
        Thu, 29 Sep 2022 07:41:57 -0700 (PDT)
Date:   Thu, 29 Sep 2022 15:41:47 +0100
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
Message-ID: <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 01:21:45PM +0200, Peter Zijlstra wrote:
> On Thu, Sep 29, 2022 at 12:10:17PM +0100, Kajetan Puchalski wrote:
> 
> > Overall, the problem being solved here is that based on our testing the
> > PELT half life can occasionally be too slow to keep up in scenarios
> > where many frames need to be rendered quickly, especially on high-refresh
> > rate phones and similar devices.
> 
> But it is a problem of DVFS not ramping up quick enough; or of the
> load-balancer not reacting to the increase in load, or what aspect
> controlled by PELT is responsible for the improvement seen?

Based on all the tests we've seen, jankbench or otherwise, the
improvement can mainly be attributed to the faster ramp up of frequency
caused by the shorter PELT window while using schedutil. Alongside that
the signals rising faster also mean that the task would get migrated
faster to bigger CPUs on big.LITTLE systems which improves things too
but it's mostly the frequency aspect of it.

To establish that this benchmark is sensitive to frequency I ran some
tests using the 'performance' cpufreq governor.

Max frame duration (ms)

+------------------+-------------+----------+
| kernel           |   iteration |    value |
|------------------+-------------+----------|
| pelt_1           |          10 | 157.426  |
| pelt_4           |          10 |  85.2713 |
| performance      |          10 |  40.9308 |
+------------------+-------------+----------+

Mean frame duration (ms)

+---------------+------------------+---------+-------------+
| variable      | kernel           |   value | perc_diff   |
|---------------+------------------+---------+-------------|
| mean_duration | pelt_1           |    14.6 | 0.0%        |
| mean_duration | pelt_4           |    14.5 | -0.58%      |
| mean_duration | performance      |     4.4 | -69.75%     |
+---------------+------------------+---------+-------------+

Jank percentage

+------------+------------------+---------+-------------+
| variable   | kernel           |   value | perc_diff   |
|------------+------------------+---------+-------------|
| jank_perc  | pelt_1           |     2.1 | 0.0%        |
| jank_perc  | pelt_4           |     2   | -3.46%      |
| jank_perc  | performance      |     0.1 | -97.25%     |
+------------+------------------+---------+-------------+

As you can see, bumping up frequency can hugely improve the results
here. This is what's happening when we decrease the PELT window, just on
a much smaller and not as drastic scale. It also explains specifically
where the increased power usage is coming from.
