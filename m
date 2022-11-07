Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F5D61E984
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiKGDVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKGDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:21:13 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAD16448;
        Sun,  6 Nov 2022 19:20:49 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5GhV2HZJzRp2w;
        Mon,  7 Nov 2022 11:20:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:20:48 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:20:47 +0800
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
To:     <paulmck@kernel.org>
CC:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <14e3aa38-98e6-01be-8cde-68fd1f85edf4@huawei.com>
 <20221105203220.GD28461@paulmck-ThinkPad-P17-Gen-1>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e9105d62-4a13-9b94-df60-3d3048fe1ae4@huawei.com>
Date:   Mon, 7 Nov 2022 11:20:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20221105203220.GD28461@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/11/6 4:32, Paul E. McKenney wrote:
> On Sat, Nov 05, 2022 at 03:03:14PM +0800, Leizhen (ThunderTown) wrote:
>> On 2022/11/5 9:58, Elliott, Robert (Servers) wrote:
> 
> [ . . . ]
> 
>>>> +int rcu_cpu_stall_cputime __read_mostly =
>>>> IS_ENABLED(CONFIG_RCU_CPU_STALL_CPUTIME);
>>>
>>> As a config option and module parameter, adding some more
>>> instrumentation overhead might be worthwhile for other
>>> likely causes of rcu stalls.
>>>
>>> For example, if enabled, have these functions (if available
>>> on the architecture) maintain a per-CPU running count of
>>> their invocations, which also cause the CPU to be unavailable
>>> for rcu: 
>>> - kernel_fpu_begin() calls - FPU/SIMD context preservation,
>>>   which also calls preempt_disable()
>>> - preempt_disable() calls - scheduler context switches disabled
>>> - local_irq_save() calls - interrupts disabled
>>> - cond_resched() calls - lack of these is a problem
>>>
>>> For kernel_fpu_begin and preempt_disable, knowing if it is
>>> currently blocked for those reasons is probably the most
>>> helpful.
>>
>> These instructions is already in Documentation/RCU/stallwarn.rst
> 
> Excellent point -- this document also needs to be updated with this
> new information.  I have pulled in your four patches as noted in my
> previous email.  They are on the -rcu tree's "dev" branch.

OK, thanks.

> 
> Could you please send a patch containing an initial update to
> stallwarn.rst?  The main thing I need is your perspective on how each
> field is used.

Okay, I'll add some descriptions to illustrate how to use this function
to identify each RCU stall cases.

> 
> 							Thanx, Paul
> .
> 

-- 
Regards,
  Zhen Lei
