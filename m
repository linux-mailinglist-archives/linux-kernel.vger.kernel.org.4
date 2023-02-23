Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30166A05AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjBWKKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjBWKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:10:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 755B04DE25
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:10:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C220DC14;
        Thu, 23 Feb 2023 02:10:42 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D58D3F587;
        Thu, 23 Feb 2023 02:09:56 -0800 (PST)
Message-ID: <183aec1b-5626-e972-bbed-aca038280828@arm.com>
Date:   Thu, 23 Feb 2023 11:09:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the
 current sched domain
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
 <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
 <Y+YXrk5NRuWaSOGR@hirez.programming.kicks-ass.net>
 <xhsmhmt5lr2nz.mognet@vschneid.remote.csb>
 <Y+Z2b/OtZDk9cT53@hirez.programming.kicks-ass.net>
 <xhsmhk00pqwap.mognet@vschneid.remote.csb>
 <20230210183155.GA11997@ranerica-svr.sc.intel.com>
 <8300f288-7157-5e2d-3bb3-badcffd15d34@arm.com>
 <20230214064328.GA11859@ranerica-svr.sc.intel.com>
 <20230216052105.GA20785@ranerica-svr.sc.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230216052105.GA20785@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 06:21, Ricardo Neri wrote:
> On Mon, Feb 13, 2023 at 10:43:28PM -0800, Ricardo Neri wrote:
>> On Mon, Feb 13, 2023 at 01:17:09PM +0100, Dietmar Eggemann wrote:
>>> On 10/02/2023 19:31, Ricardo Neri wrote:
>>>> On Fri, Feb 10, 2023 at 05:12:30PM +0000, Valentin Schneider wrote:
>>>>> On 10/02/23 17:53, Peter Zijlstra wrote:
>>>>>> On Fri, Feb 10, 2023 at 02:54:56PM +0000, Valentin Schneider wrote:

[...]

>>> Can you not detect the E-core dst_cpu case on MC with:
>>>
>>> +       if (child)
>>> +               sds->prefer_sibling = child->flags & SD_PREFER_SIBLING;
>>> +       else if (sds->busiest)
>>> +               sds->prefer_sibling = sds->busiest->group_weight > 1;
>>
>> Whose child wants the prefer_sibling setting? In update_sd_lb_stats(), it
>> is set based on the flags of the destination CPU's sched domain. But when
>> used in find_busiest_group() tasks are spread from the busiest group's
>> child domain.
>>
>> Your proposed code, also needs a check for SD_PREFER_SIBLING, no?
> 
> I tweaked the solution that Dietmar proposed:
> 
> -	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
> +	if (sds->busiest)
> +		sds->prefer_sibling = sds->busiest->flags & SD_PREFER_SIBLING;

Maybe:

sds->prefer_sibling = !!(sds->busiest->flags & SD_PREFER_SIBLING);

1 vs 2048 ?

> This comes from the observation that the prefer_sibling setting acts on
> busiest group. It then depends on whether the busiest group, not the local
> group, has child sched sched domains. Today it works because in most cases
> both the local and the busiest groups have child domains with the SD_
> PREFER_SIBLING flag.
> 
> This would also satisfy sched domains with the SD_ASYM_CPUCAPACITY flag as
> prefer_sibling would not be set in that case.
> 
> It would also conserve the current behavior at the NUMA level. We would
> not need to implement SD_SPREAD_TASKS.
> 
> This would both fix the SMT vs non-SMT bug and be less invasive.

Yeah, much better! I always forget that we have those flags on SGs now
as well. Luckily, we just need to check busiest sg to cover all cases.

