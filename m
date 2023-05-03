Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE696F5CC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjECRNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjECRNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:13:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D91C420B
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:13:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48A9A2F4;
        Wed,  3 May 2023 10:14:04 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 879DB3F64C;
        Wed,  3 May 2023 10:13:18 -0700 (PDT)
Message-ID: <4c77a01e-8ff3-f415-ffff-01c8d79a8bc7@arm.com>
Date:   Wed, 3 May 2023 19:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] sched: Consider CPU contention in frequency &
 load-balance busiest CPU selection
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
References: <20230406155030.1989554-1-dietmar.eggemann@arm.com>
 <20230406155030.1989554-2-dietmar.eggemann@arm.com>
 <20230429145829.GB1495785@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230429145829.GB1495785@hirez.programming.kicks-ass.net>
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

On 29/04/2023 16:58, Peter Zijlstra wrote:
> On Thu, Apr 06, 2023 at 05:50:30PM +0200, Dietmar Eggemann wrote:
>> Use new cpu_boosted_util_cfs() instead of cpu_util_cfs().
>>
>> The former returns max(util_avg, runnable_avg) capped by max CPU
>> capacity. CPU contention is thereby considered through runnable_avg.
>>
>> The change in load-balance only affects migration type `migrate_util`.
> 
> But why, and how does it affect? That is, isn't this Changelog a wee bit
> sparse?

Absolutely. 

I have compelling test data based on JankbenchX on Pixel6 for 
sugov_get_util() case I will share with v2.

But for the find_busiest_queue() (lb migration_type = migrate_util) case 
it is tricky to create a test env.

`migrate_util` only operates in DIE or NUMA SD (!SD_SHARE_PKG_RESOURCES) 
and the system should not be overloaded (spare capacity on the local 
group).

perf bench sched messaging with a small number of tasks compared to CPU 
number shows some improvement.

E.g. Ampere Altra with 160 CPUs, SDs = {MC, DIE, NUMA} and 1 group = 40 
tasks shows some improvement:

perf stat --null --repeat 10 -- perf bench sched messaging -t -g 1 -l 2000

0.4869 +- 0.0173 seconds time elapsed  ( +-  3.55% ) -> 0.4377 +- 0.0147 seconds time elapsed  ( +-  3.36% )

If I put more tasks onto the machine, the conditions to go into 
`migrate_util` lb vanish so there is no difference.

Also if I test on an 8 CPUs system, SDs = {MC, DIE} and 1 group = 40 
tasks the conditions to do migrate_util lb are only true for a short
moment of the beginning of the test so it does not have much implication
on the score.

[...]
