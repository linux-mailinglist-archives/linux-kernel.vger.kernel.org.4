Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6102F63F1D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiLANiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiLANin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:38:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54538AD98A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:38:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F48D6E;
        Thu,  1 Dec 2022 05:38:45 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [10.57.73.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BB9D3F73D;
        Thu,  1 Dec 2022 05:38:36 -0800 (PST)
Date:   Thu, 1 Dec 2022 13:37:25 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
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
Message-ID: <Y4iuFVby+prcBSVw@e126311.manchester.arm.com>
References: <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <d2789d23-816b-11f1-d654-a7989f323ac8@arm.com>
 <Y2z2/nhGfud7NIM8@hirez.programming.kicks-ass.net>
 <48c178fc-108f-382b-e054-83e88ef9b01b@arm.com>
 <Y206GnmFDU9QcgN5@hirez.programming.kicks-ass.net>
 <2eb769e6-0749-0cd2-3c1c-44262b3a8110@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb769e6-0749-0cd2-3c1c-44262b3a8110@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 07:14:51PM +0100, Dietmar Eggemann wrote:

> By `runtime of the activation` you refer to `curr->sum_exec_runtime -
> time(a)` ? And the latter we don't have?
> 
> And `runtime = curr->se.sum_exec_runtime - curr->se.prev_sum_exec_run`
> is only covering the time since we got onto the cpu, right?
> 
> With a missing `runtime >>= 10` (from __update_load_sum()) and using
> `runtime = curr->se.sum_exec_runtime - curr->se.prev_sum_exec_runtime`
> for a 1 task-workload (so no preemption) with factor 2 or 4 I get at
> least close to the original rq->cfs.avg.util_avg and util_est.enqueued
> signals (cells (5)-(8) in the notebook below).

> https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/UTIL_EST_FASTER.ipynb?flush_cache=true
> 

With those two changes as described above the comparative results are as
follows:

Max frame durations (worst case scenario)

+--------------------------------+-----------+------------+
|            kernel              | iteration |   value    |
+--------------------------------+-----------+------------+
|         baseline_60hz          |    10     | 149.935514 |
| pelt_rampup_runtime_shift_60hz |    10     | 108.126862 |
+--------------------------------+-----------+------------+

Power usage [mW]

+--------------+--------------------------------+-------+-----------+
|  chan_name   |             kernel             | value | perc_diff |
+--------------+--------------------------------+-------+-----------+
| total_power  |         baseline_60hz          | 141.6 |   0.0%    |
| total_power  | pelt_rampup_runtime_shift_60hz | 168.0 |  18.61%   |
+--------------+--------------------------------+-------+-----------+

Mean frame duration (average case)

+---------------+--------------------------------+-------+-----------+
|   variable    |             kernel             | value | perc_diff |
+---------------+--------------------------------+-------+-----------+
| mean_duration |         baseline_60hz          | 16.7  |   0.0%    |
| mean_duration | pelt_rampup_runtime_shift_60hz | 13.6  |  -18.9%   |
+---------------+--------------------------------+-------+-----------+

Jank percentage

+-----------+--------------------------------+-------+-----------+
| variable  |             kernel             | value | perc_diff |
+-----------+--------------------------------+-------+-----------+
| jank_perc |         baseline_60hz          |  4.0  |   0.0%    |
| jank_perc | pelt_rampup_runtime_shift_60hz |  1.5  |  -64.04%  |
+-----------+--------------------------------+-------+-----------+

Meaning it's a middle ground of sorts - instead of a 90% increase in
power usage it's 'just' 19%. At the same time though the fastest PELT
multiplier (pelt_4) was getting better max frame durations (85ms vs
108ms) for about half the power increase (9.6% vs 18.6%).
