Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E296623C20
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiKJGzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKJGzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:55:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6579F1570B;
        Wed,  9 Nov 2022 22:55:16 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N7CJN3305zmVtX;
        Thu, 10 Nov 2022 14:55:00 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 14:55:14 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 14:55:14 +0800
Subject: Re: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109093739.187-2-thunder.leizhen@huawei.com>
 <20221109152017.GA298612@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e7b9843f-e301-0cbd-3b04-9ee6641a3fdd@huawei.com>
Date:   Thu, 10 Nov 2022 14:55:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221109152017.GA298612@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2022/11/9 23:20, Frederic Weisbecker wrote:
> On Wed, Nov 09, 2022 at 05:37:37PM +0800, Zhen Lei wrote:
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index ed93ddb8203d42c..e1ff23b2a14d71d 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -866,6 +866,23 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>>  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
>>  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
>>  		}
>> +
>> +		if (rcu_cpu_stall_cputime && rdp->snap_record.gp_seq != rdp->gp_seq) {
>> +			u64 *cpustat;
>> +			struct rcu_snap_record *rsrp;
>> +
>> +			cpustat = kcpustat_cpu(rdp->cpu).cpustat;
>> +
>> +			rsrp = &rdp->snap_record;
>> +			rsrp->cputime_irq     = cpustat[CPUTIME_IRQ];
>> +			rsrp->cputime_softirq = cpustat[CPUTIME_SOFTIRQ];
>> +			rsrp->cputime_system  = cpustat[CPUTIME_SYSTEM];
> 
> You need to use kcpustat_field(), otherwise you'll get stalled values on nohz_full CPUs.

OK, I'll update it. Thanks.

> 
>> +			rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
>> +			rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
>> +			rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
>> +			rsrp->jiffies = jiffies;
>> +			rsrp->gp_seq = rdp->gp_seq;
>> +		}
>>  	}
>>  
>>  	return 0;
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index 5653560573e22d6..7b6afb9c7b96dbe 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -428,6 +428,33 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
>>  	return j > 2 * HZ;
>>  }
>>  
>> +static void print_cpu_stat_info(int cpu)
>> +{
>> +	u64 *cpustat;
>> +	struct rcu_snap_record *rsrp;
>> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>> +
>> +	if (!rcu_cpu_stall_cputime)
>> +		return;
>> +
>> +	rsrp = &rdp->snap_record;
>> +	if (rsrp->gp_seq != rdp->gp_seq)
>> +		return;
>> +
>> +	cpustat = kcpustat_cpu(cpu).cpustat;
>> +
>> +	pr_err("         hardirqs   softirqs   csw/system\n");
>> +	pr_err(" number: %8ld %10d %12lld\n",
>> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
>> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
>> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
>> +	pr_err("cputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
>> +		div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
>> +		div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
>> +		div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system,
>> NSEC_PER_MSEC),
> 
> Same here.

OK

> 
> Thanks.
> .
> 

-- 
Regards,
  Zhen Lei
