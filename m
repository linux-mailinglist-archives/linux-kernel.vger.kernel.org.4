Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF7700A74
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241295AbjELOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbjELOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:39:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B88A1BE2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:39:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DF51D75;
        Fri, 12 May 2023 07:40:39 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79DCB3F663;
        Fri, 12 May 2023 07:39:53 -0700 (PDT)
Message-ID: <251b524a-2c44-3892-1bae-03f879d6a64b@arm.com>
Date:   Fri, 12 May 2023 16:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] sched/fair, cpufreq: Introduce 'runnable boosting'
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qyousef@layalina.io>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        linux-kernel@vger.kernel.org
References: <20230512101029.342823-1-dietmar.eggemann@arm.com>
 <20230512101029.342823-3-dietmar.eggemann@arm.com>
 <20230512112229.GW4253@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512112229.GW4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 13:22, Peter Zijlstra wrote:
> On Fri, May 12, 2023 at 12:10:29PM +0200, Dietmar Eggemann wrote:
> 
>> -static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>> +static unsigned long
>> +cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>>  {
>>  	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>>  	unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
>> +	unsigned long runnable;
>> +
>> +	runnable = boost ? READ_ONCE(cfs_rq->avg.runnable_avg) : 0;
>> +	util = max(util, runnable);
>>  
> 	if (boost)
> 		util = max(util, READ_ONCE(cfs_rq->avg.runnable_avg));

I need the util_est = max(util_est, runnable) further down as well. Just
want to fetch runnable only once.

util = 50, task_util = 5, util_est = 60, task_util_est = 10, runnable = 70

max(70 + 5, 60 + 10) != max (70 + 5, 70 + 10) when dst_cpu == cpu

>> @@ -7239,9 +7246,9 @@ static unsigned long cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>>   *
>>   * Return: (Estimated) utilization for the specified CPU.
>>   */
> 
> Given that cpu_util() is the base function should this comment move
> there?

Yes, will move it.

>> -unsigned long cpu_util_cfs(int cpu)
>> +unsigned long cpu_util_cfs(int cpu, int boost)
>>  {
>> -	return cpu_util(cpu, NULL, -1);
>> +	return cpu_util(cpu, NULL, -1, boost);
>>  }
> 
> AFAICT the @boost argument is always a constant (0 or 1). Would it not
> make more sense to simply add:
> 
> unsigned long cpu_util_cfs_boost(int cpu)
> {
> 	return cpu_util(cpu, NULL, -1, 1);
> }
> 
> and use that in the few sites that actually need it?

Yes, will change it.

