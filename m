Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D086FD783
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbjEJGzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 02:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjEJGzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 02:55:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F3B235A5;
        Tue,  9 May 2023 23:55:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F9151063;
        Tue,  9 May 2023 23:56:09 -0700 (PDT)
Received: from [10.57.22.157] (unknown [10.57.22.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B3593F663;
        Tue,  9 May 2023 23:55:22 -0700 (PDT)
Message-ID: <94e7bbaa-3a25-6634-f5af-fff4932a44b9@arm.com>
Date:   Wed, 10 May 2023 07:55:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 10/17] PM: EM: Add runtime update interface to modify EM
 power
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        mhiramat@kernel.org
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-11-lukasz.luba@arm.com>
 <e7d7d337-b9bd-ad7f-ab5e-adb7e8236c19@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <e7d7d337-b9bd-ad7f-ab5e-adb7e8236c19@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 4/11/23 16:40, Pierre Gondois wrote:
> Hello Lukasz,
> 
> On 3/14/23 11:33, Lukasz Luba wrote:
>> Add an interface which allows to modify EM power data at runtime.
>> The new power information is populated by the provided callback, which
>> is called for each performance state. The CPU frequencies' efficiency is
>> re-calculated since that might be affected as well. The old EM memory
>> is going to be freed later using RCU mechanism.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   include/linux/energy_model.h |   8 +++
>>   kernel/power/energy_model.c  | 109 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>
>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index a616006a8130..e1772aa6c843 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -202,6 +202,8 @@ struct em_data_callback {
>>   struct em_perf_domain *em_cpu_get(int cpu);
>>   struct em_perf_domain *em_pd_get(struct device *dev);
>> +int em_dev_update_perf_domain(struct device *dev, struct 
>> em_data_callback *cb,
>> +                  void *priv);
>>   int em_dev_register_perf_domain(struct device *dev, unsigned int 
>> nr_states,
>>                   struct em_data_callback *cb, cpumask_t *span,
>>                   bool microwatts);
>> @@ -382,6 +384,12 @@ static inline int em_pd_nr_perf_states(struct 
>> em_perf_domain *pd)
>>   {
>>       return 0;
>>   }
>> +static inline
>> +int em_dev_update_perf_domain(struct device *dev, struct 
>> em_data_callback *cb,
>> +                  void *priv)
>> +{
>> +    return -EINVAL;
>> +}
>>   #endif
>>   #endif
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 87962b877376..e0e8fba3d02b 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
> 
> [snip]
> 
>> @@ -531,9 +628,21 @@ void em_dev_unregister_perf_domain(struct device 
>> *dev)
>>       tmp = pd->runtime_table;
>> +    /*
>> +     * Safely destroy runtime modifiable EM. By using the call
>> +     * synchronize_rcu() we make sure we don't progress till last user
>> +     * finished the RCU section and our update got applied.
>> +     */
>>       rcu_assign_pointer(pd->runtime_table, NULL);
>>       synchronize_rcu();
>> +    /*
>> +     * After the sync no updates will be in-flight, so free the old
>> +     * memory.
>> +     */
>> +    if (tmp->state != pd->table)
>> +        kfree(tmp->state);
>> +
> 
> NIT: I think that the call 'kfree(pd->default_table->state)' which is 
> done in
> the patch:
>    PM: EM: Refactor struct em_perf_domain and add default_table
> should be done here, otherwise this bit of memory is not freed.

In this patch 10/17 there is no 'default_table' field yet, so cannot
be freed in this patch's code.


> 
> Regards,
> Pierre
> 
> 
>>       kfree(tmp);
>>       kfree(dev->em_pd->table);

^^^^ in this current code we have the clean-up.
Here we clean the dev->em_pd->table, which is our conceptual
'default_table' in current code (before refactoring in 13/17)


In the patch 13/17 that you was referring to, there is also similar
but new cleaning process:
------------------->8---------------------------
-	kfree(dev->em_pd->table);
+	kfree(pd->default_table->state);
+	kfree(pd->default_table);
------------------8<----------------------------

So, it should be good.

Regards,
Lukasz
