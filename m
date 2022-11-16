Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076A862C6AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbiKPRqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiKPRqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:46:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D31B55F862
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:46:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37CEED6E;
        Wed, 16 Nov 2022 09:46:07 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E0D53F587;
        Wed, 16 Nov 2022 09:45:58 -0800 (PST)
Message-ID: <5ec773d4-0a19-cc04-e3bc-4cb57cf55b09@arm.com>
Date:   Wed, 16 Nov 2022 18:45:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 8/9] sched/fair: Detect capacity inversion
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-9-qais.yousef@arm.com>
 <68f22089-b3bb-f1da-1fd8-d8a1be34654a@arm.com>
 <20221112193522.g4hhpdlywndvik7r@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221112193522.g4hhpdlywndvik7r@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/2022 20:35, Qais Yousef wrote:
> On 11/09/22 11:42, Dietmar Eggemann wrote:
> 

[...]

>>> +			 * thermal pressure. We record it as capacity
>>> +			 * inversion.
>>> +			 */
>>> +			if (capacity_orig == pd_cap_orig) {
>>> +				pd_cap = pd_cap_orig - thermal_load_avg(cpu_rq(cpu));
>>> +
>>> +				if (pd_cap > inv_cap) {
>>> +					rq->cpu_capacity_inverted = inv_cap;
>>> +					break;
>>> +				}
>>
>> In case `capacity_orig == pd_cap_orig` and cpumask_test_cpu(cpu_of(rq),
>> pd_span) the code can set rq->cpu_capacity_inverted = inv_cap
>> erroneously since thermal_load_avg(rq) can return different values for
>> inv_cap and pd_cap.
> 
> Good catch!
> 
>>
>> So even on a classical big little system, this condition can set
>> rq->cpu_capacity_inverted for a CPU in the little or big cluster.
>>
>> thermal_load_avg(rq) would have to stay constant for all CPUs within the
>> PD to avoid this.
>>
>> This is one example of the `thermal pressure` is per PD (or Frequency
>> Domain) in Thermal but per-CPU in the task scheduler.
> 
> Only compile tested so far, does this patch address all your points? I should
> get hardware soon to run some tests and send the patch. I might re-write it to
> avoid using pds; though it seems cleaner this way but we miss CAS support.
> 
> Thoughts?

I still don't think that the `CPU capacity inversion` implementation
which uses `cap_orig' = cap_orig - thermal load avg (2)` instead of
`cap_orig'' = cap_orig - thermal pressure (1)` for inverted CPUs (i.e.
other PD exists w/ cap_orig > cap_orig') is the right answer, besides
the EAS vs. CAS coverage.

The basic question for me is why do we have to switch between (1) and
(2)? IIRC we introduced (1) in feec() to cater for the CPUfreq policy
min/max capping between schedutil and the CPUfreq driver
__resolve_freq() [drivers/cpufreq/cpufreq.c] (3).

The policy caps are set together with thermal pressure in
cpufreq_set_cur_state() [drivers/thermal/cpufreq_cooling.c] via
freq_qos_update_request().

I think we should only use (2) in the task scheduler even though the
EAS-schedutil machinery would be not 100% in sync in some cases due to (3).
Thermal load avg has similar properties like all the other EWMA-based
signals we use and we have to live with a certain degree of inaccuracy
anyway (e.g. also because of lock-less CPU statistic fetching when
selecting CPU).

And in this case we wouldn't have to have infrastructure to switch
between (1) and (2) at all.

To illustrate the problem I ran 2 workloads (hackbench/sleep) on a H960
board with step-wise thermal governor tracing thermal load_avg
(sched_pelt_thermal), thermal pressure (thermal_pressure_update) and CPU
capacity (sched_cpu_capacity). Would we really gain something
substantial reliably when we would know the diff between (1) and (2)?

https://nbviewer.org/github/deggeman/lisa/blob/ipynbs/ipynb/scratchpad/thermal_pressure.ipynb

