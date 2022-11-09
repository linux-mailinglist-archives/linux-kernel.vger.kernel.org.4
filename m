Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB7B6221C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 03:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKICJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 21:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKICJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 21:09:52 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB83C5D697;
        Tue,  8 Nov 2022 18:09:50 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6T1c1VPqzRp6V;
        Wed,  9 Nov 2022 10:09:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:09:48 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 10:09:48 +0800
Subject: Re: [PATCH] rcu: Illustrate the stall information of
 CONFIG_RCU_CPU_STALL_CPUTIME=y
To:     <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Robert Elliott <elliott@hpe.com>
References: <20221107152935.167-1-thunder.leizhen@huawei.com>
 <20221108204640.GJ3907045@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <61c45ec1-69ec-0e65-6a48-1329e66ec30f@huawei.com>
Date:   Wed, 9 Nov 2022 10:09:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221108204640.GJ3907045@paulmck-ThinkPad-P17-Gen-1>
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



On 2022/11/9 4:46, Paul E. McKenney wrote:
> On Mon, Nov 07, 2022 at 11:29:35PM +0800, Zhen Lei wrote:
>> Describes how to quickly determine the RCU stall fault type based on the
>> extra output information during CONFIG_RCU_CPU_STALL_CPUTIME=y.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Hearing no objections, I queued the following for further review.
> 
> This commit might of course need to change based on your ongoing
> discussion with Robert.  I that case, please feel free to send me a
> replacment patch or to send me an incremental patch that I can fold into
> this patch.  Either way works.

I'll issue incremental patches on the basis of your adjustment! This will
make it clearer and save your time in reviewing.

Thanks for your help. I really admire your verbal skills. Your improved
description is much better than mine.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit b05c2a06ff8a1267b7e8dc812e3944119535d6b6
> Author: Zhen Lei <thunder.leizhen@huawei.com>
> Date:   Mon Nov 7 23:29:35 2022 +0800
> 
>     doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall information
>     
>     This commit doucments how to quickly determine the bug causing a given
>     RCU CPU stall fault warning based on the output information provided
>     by CONFIG_RCU_CPU_STALL_CPUTIME=y.
>     
>     [ paulmck: Apply wordsmithing. ]
>     
>     Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
> index dfa4db8c0931e..bd8cf6c640984 100644
> --- a/Documentation/RCU/stallwarn.rst
> +++ b/Documentation/RCU/stallwarn.rst
> @@ -390,3 +390,82 @@ for example, "P3421".
>  
>  It is entirely possible to see stall warnings from normal and from
>  expedited grace periods at about the same time during the same run.
> +
> +RCU_CPU_STALL_CPUTIME
> +=====================
> +
> +In kernels built with CONFIG_RCU_CPU_STALL_CPUTIME=y or booted with
> +rcupdate.rcu_cpu_stall_cputime=1, the following additional information
> +is supplied with each RCU CPU stall warning::
> +
> +rcu:          hardirqs   softirqs   csw/system
> +rcu:  number:      624         45            0
> +rcu: cputime:       69          1         2425   ==> 2500(ms)
> +
> +These statistics are collected during the second half of the rcu stall
> +timeout. The values in row "number:" are the number of hard interrupts,
> +number of soft interrupts, and number of context switches on the stalled
> +CPU. The first three values in row "cputime:" indicate the CPU time in
> +milliseconds consumed by hard interrupts, soft interrupts, and tasks
> +on the stalled CPU.  The last number is the measurement interval, again
> +in milliseconds.  Because user-mode tasks normally do not cause RCU CPU
> +stalls, these tasks are typically kernel tasks, which is why only the
> +system CPU time are considered.
> +
> +The following describes four typical scenarios:
> +
> +1. A CPU looping with interrupts disabled.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:        0          0            0
> +   rcu: cputime:        0          0            0   ==> 2500(ms)
> +
> +   Because interrupts have been disabled throughout the measurement
> +   interval, there are no interrupts and no context switches.
> +   Furthermore, because CPU time consumption was measured using interrupt
> +   handlers, the system CPU consumption is misleadingly measured as zero.
> +   This scenario will normally also have "(0 ticks this GP)" printed on
> +   this CPU's summary line.
> +
> +2. A CPU looping with bottom halves disabled.
> +
> +   This is similar to the previous example, but with non-zero number of
> +   and CPU time consumed by hard interrupts, along with non-zero CPU
> +   time consumed by in-kernel execution.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:      624          0            0
> +   rcu: cputime:       49          0         2446   ==> 2500(ms)
> +
> +   The fact that there are zero softirqs gives a hint that these were
> +   disabled, perhaps via local_bh_disable().  It is of course possible
> +   that there were no softirqs, perhaps because all events that would
> +   result in softirq execution are confined to other CPUs.  In this case,
> +   the diagnosis should continue as shown in the next example.
> +
> +3. A CPU looping with preemption disabled.
> +
> +   Here, only the number of context switches is zero.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:      624         45            0
> +   rcu: cputime:       69          1         2425   ==> 2500(ms)
> +
> +   This situation hints that the stalled CPU was looping with preemption
> +   disabled.
> +
> +4. No looping, but massive hard and soft interrupts.::
> +
> +   rcu:          hardirqs   softirqs   csw/system
> +   rcu:  number:       xx         xx            0
> +   rcu: cputime:       xx         xx            0   ==> 2500(ms)
> +
> +   Here, the number and CPU time of hard interrupts are all non-zero,
> +   but the number of context switches and the in-kernel CPU time consumed
> +   are zero. The number and cputime of soft interrupts will usually be
> +   non-zero, but could be zero, for example, if the CPU was spinning
> +   within a single hard interrupt handler.
> +
> +   If this type of RCU CPU stall warning can be reproduced, you can
> +   narrow it down by looking at /proc/interrupts or by writing code to
> +   trace each interrupt, for example, by referring to show_interrupts().
> .
> 

-- 
Regards,
  Zhen Lei
