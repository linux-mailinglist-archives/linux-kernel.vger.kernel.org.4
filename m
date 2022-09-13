Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FBE5B652E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 03:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiIMBrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 21:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIMBrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 21:47:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720764F661;
        Mon, 12 Sep 2022 18:47:03 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MRR7F47HRz14QYc;
        Tue, 13 Sep 2022 09:43:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 09:47:01 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 13 Sep 2022 09:47:00 +0800
Subject: Re: [PATCH v6 1/2] rcu: Simplify rcu_init_nohz() cpumask handling
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220901131436.986-1-thunder.leizhen@huawei.com>
 <20220901131436.986-2-thunder.leizhen@huawei.com>
 <20220907110452.GA195440@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <25ee2afb-075d-77f9-d7f7-bde042feec0c@huawei.com>
Date:   Tue, 13 Sep 2022 09:46:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20220907110452.GA195440@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/7 19:04, Frederic Weisbecker wrote:
> On Thu, Sep 01, 2022 at 09:14:35PM +0800, Zhen Lei wrote:
>> In kernels built with either CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y or
>> CONFIG_NO_HZ_FULL=y, additional CPUs must be added to rcu_nocb_mask.
>> Except that kernels booted without the rcu_nocbs= will not have
>> allocated rcu_nocb_mask.  And the current rcu_init_nohz() function uses
>> its need_rcu_nocb_mask and offload_all local variables to track the
>> rcu_nocb and nohz_full state.
>>
>> But there is a much simpler approach, namely creating a cpumask pointer
>> to track the default and then using cpumask_available() to check the
>> rcu_nocb_mask state.  This commit takes this approach, thereby simplifying
>> and shortening the rcu_init_nohz() function.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>>  kernel/rcu/tree_nocb.h | 35 ++++++++++++-----------------------
>>  1 file changed, 12 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
>> index 0a5f0ef41484518..8b6dceeabde0b4d 100644
>> --- a/kernel/rcu/tree_nocb.h
>> +++ b/kernel/rcu/tree_nocb.h
>> @@ -1210,45 +1210,34 @@ EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
>>  void __init rcu_init_nohz(void)
>>  {
>>  	int cpu;
>> -	bool need_rcu_nocb_mask = false;
>> -	bool offload_all = false;
>>  	struct rcu_data *rdp;
>> -
>> -#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
>> -	if (!rcu_state.nocb_is_setup) {
>> -		need_rcu_nocb_mask = true;
>> -		offload_all = true;
>> -	}
>> -#endif /* #if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) */
>> +	const struct cpumask *cpumask = NULL;
>>  
>>  #if defined(CONFIG_NO_HZ_FULL)
>> -	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)) {
>> -		need_rcu_nocb_mask = true;
>> -		offload_all = false; /* NO_HZ_FULL has its own mask. */
>> -	}
>> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>> +	if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask))
>> +		cpumask = tick_nohz_full_mask;
>> +#endif
>> +
>> +#if defined(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL)
>> +	if (!rcu_state.nocb_is_setup && !cpumask)
>> +		cpumask = cpu_possible_mask;
>> +#endif
> 
> Good, and it can even use a simple condition:
> 
> if (IS_ENABLED(CONFIG_RCU_NOCB_CPU_DEFAULT_ALL) &&
>     !rcu_state.nocb_is_setup && !cpumask)
>     cpumask = cpu_possible_mask;

Okay, I'll revise it in v7.

> 
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> 
>>  
>> -	if (need_rcu_nocb_mask) {
>> +	if (cpumask) {
>>  		if (!cpumask_available(rcu_nocb_mask)) {
>>  			if (!zalloc_cpumask_var(&rcu_nocb_mask, GFP_KERNEL)) {
>>  				pr_info("rcu_nocb_mask allocation failed, callback offloading disabled.\n");
>>  				return;
>>  			}
>>  		}
>> +
>> +		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, cpumask);
>>  		rcu_state.nocb_is_setup = true;
>>  	}
>>  
>>  	if (!rcu_state.nocb_is_setup)
>>  		return;
>>  
>> -#if defined(CONFIG_NO_HZ_FULL)
>> -	if (tick_nohz_full_running)
>> -		cpumask_or(rcu_nocb_mask, rcu_nocb_mask, tick_nohz_full_mask);
>> -#endif /* #if defined(CONFIG_NO_HZ_FULL) */
>> -
>> -	if (offload_all)
>> -		cpumask_setall(rcu_nocb_mask);
>> -
>>  	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
>>  		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
>>  		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
