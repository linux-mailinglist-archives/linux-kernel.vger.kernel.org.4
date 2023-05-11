Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960836FF5DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjEKPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjEKPZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:25:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C90619A3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:25:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BE28113E;
        Thu, 11 May 2023 08:25:57 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8E43F67D;
        Thu, 11 May 2023 08:25:11 -0700 (PDT)
Message-ID: <8d229f8c-ebdf-f12f-ebec-27c2d1c9e900@arm.com>
Date:   Thu, 11 May 2023 17:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <20230429145829.GB1495785@hirez.programming.kicks-ass.net>
 <4c77a01e-8ff3-f415-ffff-01c8d79a8bc7@arm.com>
 <20230504152328.twh3rqgq2o2gvd4u@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230504152328.twh3rqgq2o2gvd4u@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 17:23, Qais Yousef wrote:
> On 05/03/23 19:13, Dietmar Eggemann wrote:
>> On 29/04/2023 16:58, Peter Zijlstra wrote:
>>> On Thu, Apr 06, 2023 at 05:50:30PM +0200, Dietmar Eggemann wrote:

[...]

>>> But why, and how does it affect? That is, isn't this Changelog a wee bit
>>> sparse?
>>
>> Absolutely. 
>>
>> I have compelling test data based on JankbenchX on Pixel6 for 
>> sugov_get_util() case I will share with v2.
> 
> I am actually still concerned this is a global win. This higher contention can
> potentially lead to higher power usage. Not every high contention worth
> reacting to faster. The blanket 25% headroom in map_util_perf() is already
> problematic. And Jankbench is not a true representative of a gaming workload
> which is what started this whole discussion. It'd be good if mediatek can
> confirm this helps their case. Or for us to find a way to run something more
> representative. The original ask was to be selective about being more reactive
> for specific scenarios/workloads. 

I contacted MTK beginning of March this year and specifically asked them
to see whether this patch helps their gaming use-cases or not.
Unfortunately I haven't heard back from them.

I'm actually happy to have compelling Jankbench (which _the_ UI
benchmark app) numbers on a recent mobile device (Pixel6) with v5.18
mainline based kernel including schedutil. And I'm able to remove a lot
of extra product-oriented features, like up/down frequency transition
rate-limits or ADPF (Android Dynamic Performance Framework) 'CPU
performance hints' feature. Bridging product and mainline world for
mobile isn't easy as we all know.

---

Testcase is Jankbench (all subtests, 10 iterations) on Pixel6 (Android
12) with mainline v5.18 kernel and forward ported task scheduler
patches, uclamp has been deactivated to disable ADPF's 'CPU performance
hints'.

Max_frame_duration:
+-----------------+------------+
|     kernel      | value [ms] |
+-----------------+------------+
|      base       | 163.061513 |
|    runnable     | 157.821346 |
+-----------------+------------+

Mean_frame_duration:
+-----------------+------------+----------+
|     kernel      | value [ms] | diff [%] |
+-----------------+------------+----------+
|      base       |    18.0    |    0.0   |
|    runnable     |    12.5    |  -30.64  |
+-----------------+------------+----------+

Jank percentage (Jank deadline 16ms):
+-----------------+------------+----------+
|     kernel      | value [%]  | diff [%] |
+-----------------+------------+----------+
|      base       |     3.6    |    0.0   |
|    runnable     |     0.8    |  -76.59  |
+-----------------+------------+----------+

Power usage [mW] (total - all CPUs):
+-----------------+------------+----------+
|     kernel      | value [mW] | diff [%] |
+-----------------+------------+----------+
|      base       |    129.5   |    0.0   |
|    runnable     |    129.3   |   -0.15  |
+-----------------+------------+----------+

---

I assume that the MTK folks will also profit from the fact that CPU
frequency can ramp up faster with this 'runnable boosting', especially
when activity starts from an (almost) idle little CPU. Seeing their test
results here would be nice though.

If we can't make this selective we need more
> data it won't hurt general power consumption. I plan to help with that, but my
> focus now is on other areas first, namely getting uclamp_max usable in
> production.

This is the stalled discussion under
https://lkml.kernel.org/r/20230205224318.2035646-1-qyousef@layalina.io I
assume?

IIRC, the open question was should EAS CPU selection be performed in
case there is no CPU spare capacity (due to uclamp capping) left.

[...]


