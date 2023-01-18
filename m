Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2092E671C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjARMef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjARMdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:33:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46483656CA;
        Wed, 18 Jan 2023 03:55:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 407611477;
        Wed, 18 Jan 2023 03:55:47 -0800 (PST)
Received: from [10.57.15.75] (unknown [10.57.15.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D8FA3F71A;
        Wed, 18 Jan 2023 03:55:03 -0800 (PST)
Message-ID: <8b1bdb9f-3942-8af2-3d7c-c6e53a6392d4@arm.com>
Date:   Wed, 18 Jan 2023 11:55:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] cpufreq: Register with perf domain before
Content-Language: en-US
To:     Vincent Wang3 <vincentwang3@lenovo.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Wang <bhuwz@163.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "qperret@google.com" <qperret@google.com>,
        Todd Kjos <tkjos@google.com>
References: <20230118044733.29391-1-bhuwz@163.com>
 <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
 <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
 <SG2PR03MB6456E1E22B9D26317B1BE9AFE5C79@SG2PR03MB6456.apcprd03.prod.outlook.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <SG2PR03MB6456E1E22B9D26317B1BE9AFE5C79@SG2PR03MB6456.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+Quentin and Todd

On 1/18/23 10:00, Vincent Wang3 wrote:
> Hi, Lukasz, Viresh
> 
> I found this issue on Android phone with kernel 5.15, and the governor is schedutil.
> With the pd_init issue, the rd->pd will be NULL and EAS doesn't work since rd->pd will be checked in function find_energy_efficient_cpu( ).

That's true, but that's not mainline issue. This discussion should
be moved to Android kernel bug tracking system.
I've seen probably similar issue in Android.

I have added Quentin and Todd who are more familiar with this design in
Android kernel.

> 
> I didn't notice the modification in schedutil at mainline, so I submitted this patch to fix the problem, sorry!
> 
> However, besides EAS will check rd->pd, I noticed that it's also used in the find_busiest_group() and update_cpu_capacity() functions at mainline, so I'm worried that may not be enough to circumvent it only in schedutil.

Those function indeed use the perf domain, but they don't use the
Energy Model pointer: rd->pd->em_pd, so they don't suffer.

> 
> 
> detail of the exact code path:
> in function register_cpufreq_notifier( ), the notifier_block init_cpu_capacity_notifier is registered with CPUFREQ_POLICY_NOTIFIER.
> During the initialization of a new policy, the notifier_call function init_cpu_capacity_callback( ) will be called，in which the work update_topology_flags_work will be scheduled.
> 
> for the kwork function update_topology_flags_workfn( )：
> update_topology_flags_workfn( ) -> rebuild_sched_domains( ) -> rebuild_sched_domains_locked( ) -> partition_sched_domains_locked( ) -> build_perf_domains( ) -> pd_init( )
> 
> 
> BRs
> Vincent
> 
> -----邮件原件-----
> 发件人: Lukasz Luba <lukasz.luba@arm.com>
> 发送时间: 2023年1月18日 17:24
> 收件人: Viresh Kumar <viresh.kumar@linaro.org>; Vincent Wang <bhuwz@163.com>; Vincent Wang3 <vincentwang3@lenovo.com>
> 抄送: rafael@kernel.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> 主题: [External] Re: [PATCH v2] cpufreq: Register with perf domain before
> 
> Hi Viresh, Vincent
> 
> I'm surprised seeing this thread and thanks that you Viresh have answered, so it could go through my spam/junk filters.
> (I hope when answer to that domain it would change something).
> 
> On 1/18/23 08:49, Viresh Kumar wrote:
>> On 18-01-23, 12:47, Vincent Wang wrote:
>>> From: Vincent Wang <vincentwang3@lenovo.com>
>>>
>>> We found the following issue during kernel boot on android phone:
>>>
>>> [    1.325272][    T1] cpu cpu0: EM: created perf domain
>>> [    1.329317][    T1] cpu cpu4: EM: created perf domain
>>> [    1.337597][   T76] pd_init: no EM found for CPU7
>>> [    1.350849][    T1] cpu cpu7: EM: created perf domain
>>>
>>> pd init for cluster2 is executed in a kworker thread and is earlier
>>> than the perf domain creation for cluster2.
>>
>> Can you please give detail of the exact code path, for mainline kernel
>> ? I am not sure which kworker thread are you talking about here.
> 
> Please also tell us your cpufreq governor. The schedutil governor at mainline can handle those situations and we rebuild the perf domains here [1].
> 
>>
>>> pd_init() is called from the cpufreq notification of
>>> CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier than that
>>> cpufreq_driver->register_em() is called.
> 
> Viresh, If that's an issue for other governors, than maybe we should address that. IMO the patch just relies on side-effect in arch_topology.c update_topology_flags_workfn(). That would be a workaround and dangerous if someone would change that arch_topology.c design. Shouldn't we come up with something reliable inside the cpufreq.c if there is a real issue?
> Even now, these two mechanisms:
> 1. in the schedutil [1]
> 2. in the update_topology_flags_workfn() are a bit leaky (in terms of design holes).
> 
> Regards,
> Lukasz
> 
> [1]
> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fkernel%2Fsched%2Fcpufreq_schedutil.c%23L858&data=05%7C01%7Cvincentwang3%40lenovo.com%7Cc69b7dca4401474bd23808daf935bfd5%7C5c7d0b28bdf8410caa934df372b16203%7C0%7C0%7C638096306507392144%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=WTPpWDytIsbfdW920cGNiHhEs7udgrX0O78sAh8JV7I%3D&reserved=0
> 
