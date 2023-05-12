Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B37700A75
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbjELOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbjELOkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:40:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12A041BF4
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:40:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5EAD75;
        Fri, 12 May 2023 07:40:47 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AB713F663;
        Fri, 12 May 2023 07:40:01 -0700 (PDT)
Message-ID: <968bf17a-0926-0b21-031b-bca869e41888@arm.com>
Date:   Fri, 12 May 2023 16:39:59 +0200
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
 <20230512113232.GX4253@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230512113232.GX4253@hirez.programming.kicks-ass.net>
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

On 12/05/2023 13:32, Peter Zijlstra wrote:
> On Fri, May 12, 2023 at 12:10:29PM +0200, Dietmar Eggemann wrote:

[...]

>> @@ -10561,7 +10568,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
>>  			break;
>>  
>>  		case migrate_util:
>> -			util = cpu_util_cfs(i);
>> +			util = cpu_util_cfs(i, 1);
>>  
>>  			/*
>>  			 * Don't try to pull utilization from a CPU with one
> 
> When you move that comment from cpu_util_cfs() to cpu_util() please also
> add a paragraph about why boost=1 and why these locations, because I'm
> sure we're going to be asking ouselves that at some point.

Will do.

