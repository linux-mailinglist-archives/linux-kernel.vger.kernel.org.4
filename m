Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6B61F231
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiKGLtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiKGLtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:49:12 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B591A3B0;
        Mon,  7 Nov 2022 03:49:08 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5Tyg1GpVzHvhN;
        Mon,  7 Nov 2022 19:48:43 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 19:49:06 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 19:49:05 +0800
Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
 <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
Date:   Mon, 7 Nov 2022 19:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
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



On 2022/11/7 10:10, Elliott, Robert (Servers) wrote:
> 
>>>> +config RCU_CPU_STALL_CPUTIME
>>>
>>> Since the information might change and grow over time, consider
>>> calling it "ADDITIONAL_INFO" rather than just "CPUTIME".
>>
>> Except that I already redirected Zhen Lei from a generic description
>> to a more specific one.  The reason for this is that I already get
>> complaints about the large volume of output from RCU CPU stall warnings,
>> which suggests that unless the additional information is quite small,
>> it should get its own Kconfig option and kernel boot parameter.
>>
>> So we well be keeping RCU_CPU_STALL_CPUTIME.
> 
> No problem - CPUTIME is easier to search for, and will likely
> always remain as one of the values reported.
> 
>> But please tie any such patch to an actual use case.  After all, if no
>> one actually uses that additional information, we have irritates untold
>> numbers of electrons for no purpose.
> 
> I've been working on fixing intermittent RCU stalls that turned out to be
> caused by x86-optimized crypto modules holding kernel_fpu_begin()/end()
> too long and crypto tests not calling cond_resched() often enough, so am
> interested in features that will help identify and prevent such
> problems.
> 
>> Also, some of those functions are on fastpaths, so adding unconditional
>> instrumentation overhead might result in an objection or three.
>>
>> As always, choose wisely!  ;-)
>>
>> If I don't see anything from you by this coming Friday, I will fold my
>> usual wordsmithing into the patch.
> 
> I applied the series to a tree not including any crypto module
> fixes, but an overnight run didn't trigger any RCU stalls. So, I
> modified the tcrypt test module to simulate a problem by
> running a lengthy loop after kernel_fpu_begin().  
> Here's an example of how the output looks:
> 
> 
> [ 1816.698380] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 1816.704368] rcu:     0-....: (2999 ticks this GP) idle=1dbc/1/0x4000000000000000 softirq=39683/39683 fqs=751
> [ 1816.714200] rcu:          hardirqs   softirqs   csw/system
> [ 1816.719922] rcu:  number:        5         10            0
> [ 1816.725643] rcu: cputime:        3          0         1492   ==> 1500(ms)
> [ 1816.732669]  (t=3030 jiffies g=89765 q=308 ncpus=56)
> [ 1816.737857] CPU: 0 PID: 46826 Comm: modprobe Tainted: G        W          6.0.0+ #5
> [ 1816.745754] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [ 1816.754523] RIP: 0010:rude_sleep_cycles.constprop.0+0x1c/0x30 [tcrypt]
> [ 1816.761290] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 0f 1f 44 00 00 0f 31 48 c1 e2 20 be ab 90 41 00 48 89 d1 48 c1 e6 0b 48 09 c1 0f 31 <48> c1 e2 20 48 09 c2 48 29 ca 48 39 d6 73 ef c3 cc cc cc cc 48 8b
> ...
> 
> That makes me realize what "csw/switch" means:
> - "csw" context switches applies to the number line
> - "system" applies the cputime line
>  
> Maybe this shouldn't be a table? Make it grep-friendly:
> [ 1816.719922] rcu: half-timeout counts: hardirq =5 softirq=10 csw=0
> [ 1816.725643] rcu: half_timeout cputimes (ms): time=1500 hardirq=3 softirq=0 system=1492

I prefer the table. Table look clearer and easier to compare.

> 
> The new prints interfere with existing prints, pushing the "t=3030" line 
> further away from its context. That's from a pr_cont. Existing prints after
> the "self-detect stall" message all start with \t, so they are roughly
> related to the first line. The new prints should probably do the same.
> 
> Since the first line ends with \n, the pr_cont will never make it on the
> same line, so it might be cleaner to use pr_err instead. That way it'll have
> the "rcu:" prefix of the other lines.
> 
> That's from:
>         pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
>         raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
>         print_cpu_stall_info(smp_processor_id());
> [that's where this patch adds more prints]
>         raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
>         for_each_possible_cpu(cpu)
>                 totqlen += rcu_get_n_cbs_cpu(cpu);
>         pr_cont("\t(t=%lu jiffies g=%ld q=%lu ncpus=%d)\n",
>                 jiffies - gps,
>                 (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
> 
> 
> One other print has similar construction:
>         pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name);
>         ...
>                                         print_cpu_stall_info(cpu);
>         ...
>         pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu ncpus=%d)\n",
>                smp_processor_id(), (long)(jiffies - gps),
>                (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state.n_online_cpus);
> 
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei
