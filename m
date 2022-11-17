Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F329262D0EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 03:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiKQCDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 21:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiKQCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 21:03:21 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10956A745;
        Wed, 16 Nov 2022 18:03:19 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NCNV95hY7zRpNf;
        Thu, 17 Nov 2022 10:02:57 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 10:03:18 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 10:03:17 +0800
Subject: Re: [PATCH v7 5/6] doc: Document CONFIG_RCU_CPU_STALL_CPUTIME=y stall
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
References: <20221111130709.247-1-thunder.leizhen@huawei.com>
 <20221111130709.247-6-thunder.leizhen@huawei.com>
 <20221116225507.GA839220@lothringen>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1d007125-9e1a-8018-d6b4-8838ecc1a873@huawei.com>
Date:   Thu, 17 Nov 2022 10:03:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221116225507.GA839220@lothringen>
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



On 2022/11/17 6:55, Frederic Weisbecker wrote:
> On Fri, Nov 11, 2022 at 09:07:08PM +0800, Zhen Lei wrote:
>> +1. A CPU looping with interrupts disabled.::
>> +
>> +   rcu:          hardirqs   softirqs   csw/system
>> +   rcu:  number:        0          0            0
>> +65;6003;1c   rcu: cputime:        0          0            0   ==> 2500(ms)
>> +
>> +   Because interrupts have been disabled throughout the measurement
>> +   interval, there are no interrupts and no context switches.
>> +   Furthermore, because CPU time consumption was measured using interrupt
>> +   handlers, the system CPU consumption is misleadingly measured as zero.
>> +   This scenario will normally also have "(0 ticks this GP)" printed on
>> +   this CPU's summary line.
>> +
>> +2. A CPU looping with bottom halves disabled.
>> +
>> +   This is similar to the previous example, but with non-zero number of
>> +   and CPU time consumed by hard interrupts, along with non-zero CPU
>> +   time consumed by in-kernel execution.::
>> +
>> +   rcu:          hardirqs   softirqs   csw/system
>> +   rcu:  number:      624          0            0
>> +   rcu: cputime:       49          0         2446   ==> 2500(ms)
>> +
>> +   The fact that there are zero softirqs gives a hint that these were
>> +   disabled, perhaps via local_bh_disable().  It is of course possible
>> +   that there were no softirqs, perhaps because all events that would
>> +   result in softirq execution are confined to other CPUs.  In this case,
>> +   the diagnosis should continue as shown in the next example.
>> +
>> +3. A CPU looping with preemption disabled.
>> +
>> +   Here, only the number of context switches is zero.::
>> +
>> +   rcu:          hardirqs   softirqs   csw/system
>> +   rcu:  number:      624         45            0
>> +   rcu: cputime:       69          1         2425   ==> 2500(ms)
>> +
>> +   This situation hints that the stalled CPU was looping with preemption
>> +   disabled.
>> +
>> +4. No looping, but massive hard and soft interrupts.::
>> +
>> +   rcu:          hardirqs   softirqs   csw/system
>> +   rcu:  number:       xx         xx            0
>> +   rcu: cputime:       xx         xx            0   ==> 2500(ms)
>> +
>> +   Here, the number and CPU time of hard interrupts are all non-zero,
>> +   but the number of context switches and the in-kernel CPU time consumed
>> +   are zero. The number and cputime of soft interrupts will usually be
>> +   non-zero, but could be zero, for example, if the CPU was spinning
>> +   within a single hard interrupt handler.
>> +
>> +   If this type of RCU CPU stall warning can be reproduced, you can
>> +   narrow it down by looking at /proc/interrupts or by writing code to
>> +   trace each interrupt, for example, by referring to show_interrupts().
> 
> One last question I have. Usually all these informations can be deduced by
> just looking at the stacktrace that comes along an RCU stall report. So on
> which kind of situation the stacktrace is not enough?

Interrupt storm.

> 
> Thanks.
> .
> 

-- 
Regards,
  Zhen Lei
