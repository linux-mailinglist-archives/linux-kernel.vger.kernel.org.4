Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C60D62D0E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbiKQB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKQB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:57:23 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ADF60EB1;
        Wed, 16 Nov 2022 17:57:21 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NCNMF2YpRz15Mb6;
        Thu, 17 Nov 2022 09:56:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:57:19 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 09:57:19 +0800
Subject: Re: [PATCH v7 4/6] rcu: Add RCU stall diagnosis information
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-5-thunder.leizhen@huawei.com>
 <20221116223942.GA838972@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <d4f7f41c-e1ef-606f-d700-3e67059bb06d@huawei.com>
Date:   Thu, 17 Nov 2022 09:57:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221116223942.GA838972@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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



On 2022/11/17 6:39, Frederic Weisbecker wrote:
> On Fri, Nov 11, 2022 at 09:07:07PM +0800, Zhen Lei wrote:
>> @@ -262,6 +279,8 @@ struct rcu_data {
>>  	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
>>  	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
>>  	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
>> +	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
>> +					    /* the first RCU stall timeout */
> 
> This should be under #ifdef CONFIG_RCU_CPU_STALL_CPUTIME

This will not work for now because we also support boot option rcupdate.rcu_cpu_stall_cputime.

> 
>> +static void print_cpu_stat_info(int cpu)
>> +{
>> +	struct rcu_snap_record rsr, *rsrp;
>> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>> +	struct kernel_cpustat *kcsp = &kcpustat_cpu(cpu);
>> +
>> +	if (!rcu_cpu_stall_cputime)
>> +		return;
>> +
>> +	rsrp = &rdp->snap_record;
>> +	if (rsrp->gp_seq != rdp->gp_seq)
>> +		return;
>> +
>> +	rsr.cputime_irq     = kcpustat_field(kcsp, CPUTIME_IRQ, cpu);
>> +	rsr.cputime_softirq = kcpustat_field(kcsp, CPUTIME_SOFTIRQ, cpu);
>> +	rsr.cputime_system  = kcpustat_field(kcsp, CPUTIME_SYSTEM, cpu);
>> +
>> +	pr_err("\t         hardirqs   softirqs   csw/system\n");
>> +	pr_err("\t number: %8ld %10d %12lld\n",
>> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
>> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
>> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
>> +	pr_err("\tcputime: %8lld %10lld %12lld   ==> %lld(ms)\n",
>> +		div_u64(rsr.cputime_irq - rsrp->cputime_irq, NSEC_PER_MSEC),
>> +		div_u64(rsr.cputime_softirq - rsrp->cputime_softirq, NSEC_PER_MSEC),
>> +		div_u64(rsr.cputime_system - rsrp->cputime_system, NSEC_PER_MSEC),
>> +		jiffies64_to_msecs(jiffies - rsrp->jiffies));
> 
> jiffies_to_msecs() should be enough.

OK, thanks.

> 
> Thanks.
> 
> .
> 

-- 
Regards,
  Zhen Lei
