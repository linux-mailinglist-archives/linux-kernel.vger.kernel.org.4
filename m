Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D856718CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjARKS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjARKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:17:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD6597856B;
        Wed, 18 Jan 2023 01:24:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F78E14BF;
        Wed, 18 Jan 2023 01:24:48 -0800 (PST)
Received: from [10.57.15.75] (unknown [10.57.15.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085B63F445;
        Wed, 18 Jan 2023 01:24:04 -0800 (PST)
Message-ID: <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
Date:   Wed, 18 Jan 2023 09:24:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] cpufreq: Register with perf domain before
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Wang <bhuwz@163.com>,
        Vincent Wang <vincentwang3@lenovo.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230118044733.29391-1-bhuwz@163.com>
 <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh, Vincent

I'm surprised seeing this thread and thanks that you Viresh have
answered, so it could go through my spam/junk filters.
(I hope when answer to that domain it would change something).

On 1/18/23 08:49, Viresh Kumar wrote:
> On 18-01-23, 12:47, Vincent Wang wrote:
>> From: Vincent Wang <vincentwang3@lenovo.com>
>>
>> We found the following issue during kernel boot on android phone:
>>
>> [    1.325272][    T1] cpu cpu0: EM: created perf domain
>> [    1.329317][    T1] cpu cpu4: EM: created perf domain
>> [    1.337597][   T76] pd_init: no EM found for CPU7
>> [    1.350849][    T1] cpu cpu7: EM: created perf domain
>>
>> pd init for cluster2 is executed in a kworker thread and
>> is earlier than the perf domain creation for cluster2.
> 
> Can you please give detail of the exact code path, for mainline kernel
> ? I am not sure which kworker thread are you talking about here.

Please also tell us your cpufreq governor. The schedutil governor
at mainline can handle those situations and we rebuild the perf domains
here [1].

> 
>> pd_init() is called from the cpufreq notification of
>> CPUFREQ_CREATE_POLICY in cpufreq_online(), which is earlier
>> than that cpufreq_driver->register_em() is called.

Viresh, If that's an issue for other governors, than maybe
we should address that. IMO the patch just relies on side-effect
in arch_topology.c update_topology_flags_workfn(). That would be
a workaround and dangerous if someone would change that arch_topology.c
design. Shouldn't we come up with something reliable inside the
cpufreq.c if there is a real issue?
Even now, these two mechanisms:
1. in the schedutil [1]
2. in the update_topology_flags_workfn()
are a bit leaky (in terms of design holes).

Regards,
Lukasz

[1] 
https://elixir.bootlin.com/linux/latest/source/kernel/sched/cpufreq_schedutil.c#L858

