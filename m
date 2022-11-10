Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD3E623A15
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiKJCy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiKJCyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:54:23 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE4024BF3;
        Wed,  9 Nov 2022 18:54:20 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N75yS2CWKzRp3j;
        Thu, 10 Nov 2022 10:54:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:54:14 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:54:14 +0800
Subject: Re: [PATCH v6 2/2] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall
 information
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
 <20221109093739.187-3-thunder.leizhen@huawei.com>
 <20221109150834.GA127536@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <54d3262f-3f5f-12af-e965-d56166724bcc@huawei.com>
Date:   Thu, 10 Nov 2022 10:54:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221109150834.GA127536@lothringen>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2022/11/9 23:08, Frederic Weisbecker wrote:
> On Wed, Nov 09, 2022 at 05:37:38PM +0800, Zhen Lei wrote:
>> This commit doucments how to quickly determine the bug causing a given
>> RCU CPU stall fault warning based on the output information provided
>> by CONFIG_RCU_CPU_STALL_CPUTIME=y.
>>
>> [ paulmck: Apply wordsmithing. ]
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>> ---
>>  Documentation/RCU/stallwarn.rst | 88 +++++++++++++++++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>
>> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
>> index dfa4db8c0931eaf..5e24e849290a286 100644
>> --- a/Documentation/RCU/stallwarn.rst
>> +++ b/Documentation/RCU/stallwarn.rst
>> @@ -390,3 +390,91 @@ for example, "P3421".
>>  
>>  It is entirely possible to see stall warnings from normal and from
>>  expedited grace periods at about the same time during the same run.
>> +
>> +RCU_CPU_STALL_CPUTIME
>> +=====================
>> +
>> +In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
>> +rcupdate.rcu_cpu_stall_cputime=1, the following additional information
>> +is supplied with each RCU CPU stall warning::
>> +
>> +rcu:          hardirqs   softirqs   csw/system
>> +rcu:  number:      624         45            0
>> +rcu: cputime:       69          1         2425   ==> 2500(ms)
>> +
>> +These statistics are collected during the sampling period. The values
>> +in row "number:" are the number of hard interrupts, number of soft
>> +interrupts, and number of context switches on the stalled CPU. The
>> +first three values in row "cputime:" indicate the CPU time in
>> +milliseconds consumed by hard interrupts, soft interrupts, and tasks
>> +on the stalled CPU.
> 
> Is that since the boot or since the last snapshot?

Since the last snapshot. See the diagram below:

+The sampling period is shown as follows:
+|<------------first timeout---------->|<-----second timeout----->|
+|<--half timeout-->|<--half timeout-->|                          |
+|                  |<--first period-->|                          |
+|                  |<-----------second sampling period---------->|
+|                  |                  |                          |
+|          sampling time point    1st-stall                  2nd-stall
                    |
                    |
                    Take the snapshot at this time

> 
>> The last number is the measurement interval, again
>> +in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
>> +stalls, these tasks are typically kernel tasks, which is why only the
>> +system CPU time are considered.
>> +
>> +The sampling period is shown as follows:
>> +|<------------first timeout---------->|<-----second timeout----->|
>> +|<--half timeout-->|<--half timeout-->|                          |
>> +|                  |<--first period-->|                          |
>> +|                  |<-----------second sampling period---------->|
>> +|                  |                  |                          |
>> +|          sampling time point    1st-stall                  2nd-stall
>> +
>> +
>> +The following describes four typical scenarios:
>> +
>> +1. A CPU looping with interrupts disabled.::
>> +
>> +   rcu:          hardirqs   softirqs   csw/system
>> +   rcu:  number:        0          0            0
>> +   rcu: cputime:        0          0            0   ==> 2500(ms)
>> +
>> +   Because interrupts have been disabled throughout the measurement
>> +   interval, there are no interrupts and no context switches.
>> +   Furthermore, because CPU time consumption was measured using interrupt
>> +   handlers, the system CPU consumption is misleadingly measured as zero.
>> +   This scenario will normally also have "(0 ticks this GP)" printed on
>> +   this CPU's summary line.
> 
> Right, unless you're running with CONFIG_NO_HZ_FULL=y and the target CPU
> is nohz_full=, in that case you should see a delta in stime because the
> cputime is measured with the CPU clock.
> 
> Thanks.
> .
> 

-- 
Regards,
  Zhen Lei
