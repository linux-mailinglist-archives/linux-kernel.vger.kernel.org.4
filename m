Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C520E6F8857
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjEESCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjEESCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 14:02:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A5C3160BD
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 11:02:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C001FB;
        Fri,  5 May 2023 11:03:24 -0700 (PDT)
Received: from [192.168.178.92] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 651A23F67D;
        Fri,  5 May 2023 11:02:38 -0700 (PDT)
Message-ID: <8276e5ce-b1f6-19e2-095b-abc6952bd1c7@arm.com>
Date:   Fri, 5 May 2023 20:02:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <ZFSr4Adtx1ZI8hoc@chenyu5-mobl1>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <ZFSr4Adtx1ZI8hoc@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chenyu,

On 05/05/2023 09:10, Chen Yu wrote:
> On 2023-04-06 at 17:50:30 +0200, Dietmar Eggemann wrote:
>> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
>>
>> The former returns max(util_avg, runnable_avg) capped by max CPU
>> capacity. CPU contention is thereby considered through runnable_avg.
>>
>> The change in load-balance only affects migration type `migrate_util`.
>>
>> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>
> Tested on Intel Sapphire Rapids which has 2x56C/112T = 224 CPUs.
> The test tries to check if this is any impact on find_busiest_queue()
> so it was tested with cpufreq governor performance.
> The baseline is the 6.3 sched/core branch on top of
> Commit 67fff302fc445a ("sched/fair: Introduce SIS_CURRENT to wake up"),
> and compared to the code with current patch applied.
> 
> In summary no obvious difference and some small improvements on tbench
> were observed so far:

many thanks for the test results!

Could you share the parameter lists you use for the individual tests?
This would make it easier to understand the results and rerun the tests
on similar machines.

[...]
