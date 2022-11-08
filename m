Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789006209A0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbiKHGlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiKHGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:41:34 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A3C1A399;
        Mon,  7 Nov 2022 22:41:31 -0800 (PST)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5z5F5QZXzHvkj;
        Tue,  8 Nov 2022 14:41:05 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 14:41:29 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 14:41:28 +0800
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
 <5133bd4b-c17f-f5ed-eae2-fe2d199dc5db@huawei.com>
 <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB1842199BE77619EFB93AB1DAAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <ac89012c-c9c8-aed1-2007-d5cc93433db7@huawei.com>
 <MW5PR84MB1842F64C2019065948048B92AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e6f96a66-59e6-5889-a0f0-6451d8469c24@huawei.com>
Date:   Tue, 8 Nov 2022 14:41:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB1842F64C2019065948048B92AB3F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
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



On 2022/11/8 13:53, Elliott, Robert (Servers) wrote:
> 
> 
>> -----Original Message-----
>> From: Leizhen (ThunderTown) <thunder.leizhen@huawei.com>
>> Sent: Monday, November 7, 2022 9:07 PM
>> Subject: Re: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
>>
>> On 2022/11/8 5:57, Elliott, Robert (Servers) wrote:
>>> I created a 22 second stall, which triggered two self-detected stall
>>> messages. The second one covers 18 seconds (and reports 17444 ms
>>> of system cputime), but still reports the half_timeout of 2.5 s on
>>
>> Because I have not updated rsrp->gp_seq in print_cpu_stat_info().
>>
>> Please add rsrp->gp_seq-- at the bottom of print_cpu_stat_info()
>> and try again.
>>
>> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>> index 2e560a70d88fd87..6f6c95d599e6436 100644
>> --- a/kernel/rcu/tree_stall.h
>> +++ b/kernel/rcu/tree_stall.h
>> @@ -455,6 +455,7 @@ static void print_cpu_stat_info(int cpu)
>>                 div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq,
>> NSEC_PER_MSEC),
>>                 div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system,
>> NSEC_PER_MSEC),
>>                 jiffies64_to_msecs(half_timeout));
>> +       rsrp->gp_seq--;
>>  }
> 
> 
> That causes a lot more expedited stall messages to be printed (52 of them).

There doesn't seem to be a causal relationship. I haven't figured it out yet.

> [   80.709572] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 3 jiffies s: 481 root: 0x2/.
> [   80.743724] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 311 jiffies s: 481 root: 0x2/.
> [   81.028028] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 620 jiffies s: 481 root: 0x2/.
> [   81.313255] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 929 jiffies s: 481 root: 0x2/.
> [   81.598483] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 1238 jiffies s: 481 root: 0x2/.
> [   81.883710] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 1547 jiffies s: 481 root: 0x2/.
> ...
> [   95.077093] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 15840 jiffies s: 481 root: 0x2/.
> [   95.362327] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 22-.... } 16149 jiffies s: 481 root: 0x2/.
> [   95.647549] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> 
> 
> Of the three self-detected prints, the second and third system cputimes 
> of 8809 and 8655 are still greater than 1500.

Maybe we should add another member to record jiffies.

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b33165dba1ea745..6d9c876ea5c85a6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -880,6 +880,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
                        rsrp->nr_hardirqs = kstat_cpu_irqs_sum(rdp->cpu);
                        rsrp->nr_softirqs = kstat_cpu_softirqs_sum(rdp->cpu);
                        rsrp->nr_csw = nr_context_switches_cpu(rdp->cpu);
+                       rsrp->jiffies = jiffies;
                        rsrp->gp_seq = rdp->gp_seq;
                }
        }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index fa159a951ded42e..cbe4f09252dce20 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -172,6 +172,7 @@ struct rcu_snap_record {
        unsigned long   nr_hardirqs;    /* Accumulated number of hard irqs */
        unsigned int    nr_softirqs;    /* Accumulated number of soft irqs */
        unsigned long long nr_csw;      /* Accumulated number of task switches */
+       unsigned long   jiffies;        /* jiffies at the sampling time */
 };

 /* Per-CPU data for read-copy update. */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2e560a70d88fd87..7b6afb9c7b96dbe 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -431,7 +431,6 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
 static void print_cpu_stat_info(int cpu)
 {
        u64 *cpustat;
-       unsigned long half_timeout;
        struct rcu_snap_record *rsrp;
        struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);

@@ -443,7 +442,6 @@ static void print_cpu_stat_info(int cpu)
                return;

        cpustat = kcpustat_cpu(cpu).cpustat;
-       half_timeout = rcu_jiffies_till_stall_check() / 2;

        pr_err("         hardirqs   softirqs   csw/system\n");
        pr_err(" number: %8ld %10d %12lld\n",
@@ -454,7 +452,7 @@ static void print_cpu_stat_info(int cpu)
                div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
                div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
                div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system, NSEC_PER_MSEC),
-               jiffies64_to_msecs(half_timeout));
+               jiffies64_to_msecs(jiffies - rsrp->jiffies));
 }

 /*


> 
> [   73.774167] tcrypt: rcu testing - kernel_fpu_disable for rude 22 s
> [   76.540071] rcu: INFO: rcu_preempt self-detected stall on CPU 22
> [   76.546118] rcu:     22-....: (2994 ticks this GP) idle=716c/1/0x4000000000000000 softirq=2095/2095 fqs=751
> [   76.555661] rcu:     CPU 22          hardirqs   softirqs          csw     system  cond_resched
> [   76.564067] rcu:     CPU 22   count:        0          4             0                        0
> [   76.572560] rcu:     CPU 22 cputime:        3          0                     1493               ==> 1500 (ms)
> [   76.582277] rcu:     CPU 22 current: in_kernel_fpu_begin=1 this_cpu_preemptible=0
> [   76.589546] rcu:     (self-detected stall on CPU 22 t=3054 jiffies g=13897 q=274 ncpus=56)
> ...
> [   85.021211] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> [   85.158741] rcu: INFO: rcu_preempt self-detected stall on CPU 22
> [   85.159351]  22-....
> [   85.163204] rcu:     22-....: (11839 ticks this GP) idle=716c/1/0x4000000000000000 softirq=2095/2095 fqs=2959
> [   85.163207] rcu:     CPU 22          hardirqs   softirqs          csw     system  cond_resched
> [   85.163208] rcu:     CPU 22   count:        0         43             0                        0
> [   85.163210] rcu:     CPU 22 cputime:      491          0                     8809               ==> 1500 (ms)
> [   85.166980]  } 4831 jiffies s: 481 root: 0x2/.
> [   85.170745] rcu:     CPU 22 current: in_kernel_fpu_begin=1 this_cpu_preemptible=0
> [   85.170747] rcu:     (self-detected stall on CPU 22 t=12351 jiffies g=13897 q=2542 ncpus=56)
> ...
> [   93.899261] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> [   93.920482] rcu: INFO: rcu_preempt self-detected stall on CPU 22
> [   93.933812]  22-....
> [   93.939063] rcu:     22-....: (20543 ticks this GP) idle=716c/1/0x4000000000000000 softirq=2095/2095 fqs=5216
> [   93.939066] rcu:     CPU 22          hardirqs   softirqs          csw     system  cond_resched
> [   93.939067] rcu:     CPU 22   count:        0         59             0                        0
> [   93.946245]  } 14342 jiffies s: 481 root: 0x2/.
> [   93.953415] rcu:     CPU 22 cputime:      777          0                     8655               ==> 1500 (ms)
> [   93.953418] rcu:     CPU 22 current: in_kernel_fpu_begin=1 this_cpu_preemptible=0
> [   93.953419] rcu:     (self-detected stall on CPU 22 t=21865 jiffies g=13897 q=6284 ncpus=56)
> [   93.953421] CPU: 22 PID: 2604 Comm: modprobe Not tainted 6.0.0+ #13
> [   93.960598] rcu: blocking rcu_node structures (internal RCU debug):
> 
> (I added "CPU %d" to all the self-detected lines to try to help the interleaving)
> 
> 
> 

-- 
Regards,
  Zhen Lei
