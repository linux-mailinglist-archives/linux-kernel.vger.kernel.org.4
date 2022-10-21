Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B907B6071B5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJUIIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJUIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:08:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A339249D0C;
        Fri, 21 Oct 2022 01:08:17 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mtxq20JzbzJn5k;
        Fri, 21 Oct 2022 16:05:34 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:07:55 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:07:54 +0800
Subject: Re: [PATCH 0/3] rcu: Add RCU stall diagnosis information
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221017100108.2063-1-thunder.leizhen@huawei.com>
 <20221020231353.GC5600@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f71fa16b-10c8-58a8-4646-9b5efc44a429@huawei.com>
Date:   Fri, 21 Oct 2022 16:07:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221020231353.GC5600@paulmck-ThinkPad-P17-Gen-1>
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



On 2022/10/21 7:13, Paul E. McKenney wrote:
> On Mon, Oct 17, 2022 at 06:01:05PM +0800, Zhen Lei wrote:
>> In some extreme cases, such as the I/O pressure test, the CPU usage may
>> be 100%, causing RCU stall. In this case, the printed information about
>> current is not useful. Displays the number and usage of hard interrupts,
>> soft interrupts, and context switches that are generated within half of
>> the CPU stall timeout, can help us make a general judgment. In other
>> cases, we can preliminarily determine whether an infinite loop occurs
>> when local_irq, local_bh or preempt is disabled.
>>
>> Zhen Lei (3):
>>   sched: Add helper kstat_cpu_softirqs_sum()
>>   sched: Add helper nr_context_switches_cpu()
>>   rcu: Add RCU stall diagnosis information
> 
> Interesting approach, thank you!
> 
> I have pulled this in for testing and review, having rescued it from my
> spam folder.

Thanks. My company's mail system has been having some problems lately.

Also, I need to apologize that yesterday I found out there was a mistake
in patch 3/3. Yesterday, I finally got to print_other_cpu_stall() by forcing
a stub.

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 08cfcf526f7d245..caaee5f4ee091df 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -451,7 +451,7 @@ static void print_cpu_stat_info(int cpu)
        if (r->gp_seq != rdp->gp_seq)
                return;

-       cpustat = kcpustat_this_cpu->cpustat;
+       cpustat = kcpustat_cpu(cpu).cpustat;
        half_timeout = rcu_jiffies_till_stall_check() / 2;

        pr_err("         hardirqs   softirqs   csw/system\n");

> 
> Some questions that might come up include:  (1) Can the addition of
> things like cond_resched() make RCU happier with the I/O pressure test?
> (2) Should there be a way to turn this off for environments with slow
> consoles?  (3) If this information shows heavy CPU usage, what debug
> and fix approach should be used?

If the CPU usage is high due to busy services, I think it is excusable
to report RCU stall warning. When users see RCU stall, they are most
worried about whether there are unrecoverable errors, such as dead loop.
If the cause is known to be the CPU usage, the I/O performance has
reached its peak, this is probably what people want to see.

(1) This needs to be considered by the business task itself. As far as I
    know some drivers' data processing is done in an interrupt context.
(2) Do you mean to suppress such new debugging information that I added?
    or the whole RCU stall information?
(3) The statistics can be accurate to a single hard interrupt, software
    interrupt, or task. However, the price will be higher. Users can
    recall what they did at the time, then reproduce it. Maybe we can get
    this code ready, add a new debugging option, and turn it on when needed.

> 
> For an example of #1, if a CPU is flooded with softirq activity, one
> might hope that the call to rcu_softirq_qs() would prevent the RCU CPU
> stall warning, at least for kernels built with CONFIG_PREEMPT_RT=n.
> Similarly, if there are huge numbers of context switches, one might hope
> that the rcu_note_context_switch() would report a quiescent state sooner
> rather than later.

Good idea. I'm going to dig deeper.

How about dynamically extending the stall timeout if the CPU usage is too high?

> 
> Thoughts?
> 
> 							Thanx, Paul
> 
>>  include/linux/kernel_stat.h | 12 +++++++++++
>>  kernel/rcu/tree.h           | 11 ++++++++++
>>  kernel/rcu/tree_stall.h     | 40 +++++++++++++++++++++++++++++++++++++
>>  kernel/sched/core.c         |  5 +++++
>>  4 files changed, 68 insertions(+)
>>
>> -- 
>> 2.25.1
>>
> .
> 

-- 
Regards,
  Zhen Lei
