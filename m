Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F965313A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbiLUNDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232695AbiLUNDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:03:30 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E41A164E8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:03:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BA432F4;
        Wed, 21 Dec 2022 05:04:09 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFE7D3F703;
        Wed, 21 Dec 2022 05:03:25 -0800 (PST)
Message-ID: <4f9aecf7-062e-8e85-1d3e-c010a85a010a@arm.com>
Date:   Wed, 21 Dec 2022 14:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT
 local sched group
Content-Language: en-US
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
 <76e23104-a8c0-a5fc-b8c6-27de79df2372@arm.com>
 <20221212175345.GA27353@ranerica-svr.sc.intel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20221212175345.GA27353@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2022 18:53, Ricardo Neri wrote:
> On Tue, Dec 06, 2022 at 06:22:41PM +0100, Dietmar Eggemann wrote:
>> On 22/11/2022 21:35, Ricardo Neri wrote:

[...]

>> I'm not sure why you change asym_smt_can_pull_tasks() together with
>> removing SD_ASYM_PACKING from SMT level (patch 5/7)?
> 
> In x86 we have SD_ASYM_PACKING at the MC, CLS* and, before my patches, SMT
> sched domains.
> 
>>
>> update_sg_lb_stats()
>>
>>   ... && env->sd->flags & SD_ASYM_PACKING && .. && sched_asym()
>>                                                    ^^^^^^^^^^^^
>>     sched_asym()
>>
>>       if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
>>           (group->flags & SD_SHARE_CPUCAPACITY))
>>         return asym_smt_can_pull_tasks()
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> So x86 won't have a sched domain with SD_SHARE_CPUCAPACITY and
>> SD_ASYM_PACKING anymore. So sched_asym() would call sched_asym_prefer()
>> directly on MC. What do I miss here?
> 
> asym_smt_can_pull_tasks() is used above the SMT level *and* when either the
> local or sg sched groups are composed of CPUs that are SMT siblings.

OK.

> In fact, asym_smt_can_pull_tasks() can only be called above the SMT level.
> This is because the flags of a sched_group in a sched_domain are equal to
> the flags of the child sched_domain. Since SMT is the lowest sched_domain,
> its groups' flags are 0.

I see. I forgot about `[PATCH v5 0/6] sched/fair: Fix load balancing of
SMT siblings with ASYM_PACKING` from Sept 21 (specifically [PATCH v5
2/6] sched/topology: Introduce sched_group::flags).

> sched_asym() calls sched_asym_prefer() directly if balancing at the
> SMT level and, at higher domains, if the child domain is not SMT.

OK.

> This meets the requirement of Power7, where SMT siblings have different
> priorities; and of x86, where physical cores have different priorities.
> 
> Thanks and BR,
> Ricardo
> 
> * The target of these patches is Intel hybrid processors, on which cluster
>   scheduling is disabled - cabdc3a8475b ("sched,x86: Don't use cluster
>   topology for x86 hybrid CPUs"). Also, I have not observed topologies in
>   which CPUs of the same cluster have different priorities.

OK.

IMHO, the function header of asym_smt_can_pull_tasks() (3rd and 4th
paragraph ...  `If both @dst_cpu and @sg have SMT siblings` and `If @sg
does not have SMT siblings` still reflect the old code layout.
