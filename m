Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D3746032
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGCP6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjGCP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:58:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E6F3C2;
        Mon,  3 Jul 2023 08:58:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68E92F4;
        Mon,  3 Jul 2023 08:58:46 -0700 (PDT)
Received: from [10.57.27.93] (unknown [10.57.27.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 745263F663;
        Mon,  3 Jul 2023 08:58:01 -0700 (PDT)
Message-ID: <bcf297db-4878-84e2-842d-178b79d7abbe@arm.com>
Date:   Mon, 3 Jul 2023 16:58:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 08/17] PM: EM: Introduce runtime modifiable table
Content-Language: en-US
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230512095743.3393563-1-lukasz.luba@arm.com>
 <20230512095743.3393563-9-lukasz.luba@arm.com>
 <c4052a3d-ab24-6c20-ed07-d752098e6286@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <c4052a3d-ab24-6c20-ed07-d752098e6286@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/23 11:18, Dietmar Eggemann wrote:
> On 12/05/2023 11:57, Lukasz Luba wrote:
>> This patch introduces the new feature: modifiable EM perf_state table.
>> The new runtime table would be populated with a new power data to better
>> reflect the actual power. The power can vary over time e.g. due to the
>> SoC temperature change. Higher temperature can increase power values.
>> For longer running scenarios, such as game or camera, when also other
>> devices are used (e.g. GPU, ISP) the CPU power can change. The new
>> EM framework is able to addresses this issue and change the data
>> at runtime safely. The runtime modifiable EM data is used by the Energy
>> Aware Scheduler (EAS) for the task placement.
> 
> It's important to say that EAS is the _only_user of the `runtime
> modifiable EM`. All the other users (thermal, etc.) are still using the
> default (basic) EM. IMHO, this fact drove the design here.

OK, I'll add that information in the header.

> 
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h | 13 +++++++++++++
>>   kernel/power/energy_model.c  | 24 ++++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index cc2bf607191e..a616006a8130 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -36,9 +36,21 @@ struct em_perf_state {
>>    */
>>   #define EM_PERF_STATE_INEFFICIENT BIT(0)
>>   
>> +/**
>> + * struct em_perf_table - Performance states table, which can be
>> + *		runtime modifiable and protected with RCU
> 
> which is `runtime modifiable` ? So `runtime modifiable performance state
> table`? RCU is obvious since we have `struct rcu_head rcu`.

Thanks, 'Runtime modifiable performance state table' sounds better.

> 
>> + * @state:	List of performance states, in ascending order
>> + * @rcu:	RCU used for safe access and destruction
>> + */
>> +struct em_perf_table {
>> +	struct em_perf_state *state;
>> +	struct rcu_head rcu;
>> +};
>> +
>>   /**
>>    * struct em_perf_domain - Performance domain
>>    * @table:		List of performance states, in ascending order
>> + * @runtime_table:	Pointer to the runtime modified em_perf_table
> 
> s/modified/modifiable
> 
> [...]
> 
>> @@ -237,12 +238,23 @@ static int em_create_pd(struct device *dev, int nr_states,
>>   			return -ENOMEM;
>>   	}
>>   
>> +	runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
>> +	if (!runtime_table) {
>> +		kfree(pd);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	ret = em_create_perf_table(dev, pd, nr_states, cb, flags);
>>   	if (ret) {
>>   		kfree(pd);
>> +		kfree(runtime_table);
>>   		return ret;
>>   	}
>>   
>> +	/* Re-use temporally (till 1st modification) the memory */
> 
> So this means that the runtime (modifiable) table
> (pd->runtime_table>state) is mapped to the default (basic) table
> (pd->default_table->state) until the first call to
> em_dev_update_perf_domain() (here mentioned as the 1st modification)?

correct

> 
> IMHO, not easy to understand since neither the cover letter, nor
> documentation patch 15/17 describes this in a consistent story.

I'll add that to the patch header and also to the documentation patch
which is later in the series.

