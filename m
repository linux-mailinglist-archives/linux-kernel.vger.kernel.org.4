Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0D6DDFD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDKPkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDKPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:40:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1EFC469F;
        Tue, 11 Apr 2023 08:40:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0396D75;
        Tue, 11 Apr 2023 08:41:09 -0700 (PDT)
Received: from [10.57.20.231] (unknown [10.57.20.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693DC3F73F;
        Tue, 11 Apr 2023 08:40:22 -0700 (PDT)
Message-ID: <e7d7d337-b9bd-ad7f-ab5e-adb7e8236c19@arm.com>
Date:   Tue, 11 Apr 2023 17:40:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/17] PM: EM: Add runtime update interface to modify EM
 power
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, ionela.voinescu@arm.com,
        rostedt@goodmis.org, mhiramat@kernel.org
References: <20230314103357.26010-1-lukasz.luba@arm.com>
 <20230314103357.26010-11-lukasz.luba@arm.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <20230314103357.26010-11-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lukasz,

On 3/14/23 11:33, Lukasz Luba wrote:
> Add an interface which allows to modify EM power data at runtime.
> The new power information is populated by the provided callback, which
> is called for each performance state. The CPU frequencies' efficiency is
> re-calculated since that might be affected as well. The old EM memory
> is going to be freed later using RCU mechanism.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>   include/linux/energy_model.h |   8 +++
>   kernel/power/energy_model.c  | 109 +++++++++++++++++++++++++++++++++++
>   2 files changed, 117 insertions(+)
> 
> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
> index a616006a8130..e1772aa6c843 100644
> --- a/include/linux/energy_model.h
> +++ b/include/linux/energy_model.h
> @@ -202,6 +202,8 @@ struct em_data_callback {
>   
>   struct em_perf_domain *em_cpu_get(int cpu);
>   struct em_perf_domain *em_pd_get(struct device *dev);
> +int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
> +			      void *priv);
>   int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
>   				struct em_data_callback *cb, cpumask_t *span,
>   				bool microwatts);
> @@ -382,6 +384,12 @@ static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
>   {
>   	return 0;
>   }
> +static inline
> +int em_dev_update_perf_domain(struct device *dev, struct em_data_callback *cb,
> +			      void *priv)
> +{
> +	return -EINVAL;
> +}
>   #endif
>   
>   #endif
> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
> index 87962b877376..e0e8fba3d02b 100644
> --- a/kernel/power/energy_model.c
> +++ b/kernel/power/energy_model.c

[snip]

> @@ -531,9 +628,21 @@ void em_dev_unregister_perf_domain(struct device *dev)
>   
>   	tmp = pd->runtime_table;
>   
> +	/*
> +	 * Safely destroy runtime modifiable EM. By using the call
> +	 * synchronize_rcu() we make sure we don't progress till last user
> +	 * finished the RCU section and our update got applied.
> +	 */
>   	rcu_assign_pointer(pd->runtime_table, NULL);
>   	synchronize_rcu();
>   
> +	/*
> +	 * After the sync no updates will be in-flight, so free the old
> +	 * memory.
> +	 */
> +	if (tmp->state != pd->table)
> +		kfree(tmp->state);
> +

NIT: I think that the call 'kfree(pd->default_table->state)' which is done in
the patch:
   PM: EM: Refactor struct em_perf_domain and add default_table
should be done here, otherwise this bit of memory is not freed.

Regards,
Pierre


>   	kfree(tmp);
>   
>   	kfree(dev->em_pd->table);
