Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34D623D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbiKJI1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiKJI1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:27:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29D1EEF5;
        Thu, 10 Nov 2022 00:27:38 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7FLy11jLzmVYx;
        Thu, 10 Nov 2022 16:27:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:27:36 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 16:27:35 +0800
Subject: Re: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109093739.187-2-thunder.leizhen@huawei.com>
 <MW5PR84MB18423CA291ABCD3DCCE3D416AB3E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4e93b955-28bf-7b9d-14af-7681b47fada7@huawei.com>
Date:   Thu, 10 Nov 2022 16:27:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB18423CA291ABCD3DCCE3D416AB3E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/10 0:55, Elliott, Robert (Servers) wrote:
> 
> 
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index a465d5242774af8..2729f3ad11d108b 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5082,6 +5082,12 @@
>>  			rcupdate.rcu_cpu_stall_timeout to be used (after
>>  			conversion from seconds to milliseconds).
>>
>> +	rcupdate.rcu_cpu_stall_cputime= [KNL]
>> +			Provide statistics on the cputime and count of
>> +			interrupts and tasks during the sampling period. For
>> +			multiple continuous RCU stalls, all sampling periods
>> +			begin at half of the first RCU stall timeout.
> 
> This description should start with:
>     "In kernels built with CONFIG_RCU_CPU_STALL_TIME=y, "
> 
> Also, that parameter name seems like it contains a time value, but
> it's really just treated as zero vs. anything else. Consider renaming
> it to rcu_cpu_stall_cputime_en or describing the values in the
> description ("0 disables, all other values enable").
> 
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> +struct rcu_snap_record {
>> +	unsigned long	gp_seq;		/* Track rdp->gp_seq counter */
>> +	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
>> +	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
>> +	u64		cputime_system; /* Accumulated cputime of kernel tasks
>> */
>> +	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
>> +	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */
> 
> That should be "unsigned long" to match the other patch

We have discussed this before. And you mentioned:

irqs_sumstruct kernel_stat {
        unsigned long irqs_sum;
        unsigned int softirqs[NR_SOFTIRQS];
};

The softirqs field is an unsigned int, so the new function doesn't have
this inconsistency.

> 
> 
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> +static void print_cpu_stat_info(int cpu)
>> +{
> ...
>> +	pr_err("         hardirqs   softirqs   csw/system\n");
>> +	pr_err(" number: %8ld %10d %12lld\n",
>> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
>> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
>> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
>> +	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
> 
> Those should all start with "\t" to match other related prints.

Right, thanks.

> 
> 
> .
> 

-- 
Regards,
  Zhen Lei
