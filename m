Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1916762075C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbiKHDTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiKHDS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:18:58 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8A27919;
        Mon,  7 Nov 2022 19:18:56 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5tbW0PQ7zHvgV;
        Tue,  8 Nov 2022 11:18:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:18:54 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:18:54 +0800
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3adb6360-ac90-2ef7-5dcb-e2013f19dd13@huawei.com>
Date:   Tue, 8 Nov 2022 11:18:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB18427CB2FF17CE0D91BE9944AB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
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



On 2022/11/8 4:38, Elliott, Robert (Servers) wrote:
> 
> 
>>> Maybe this shouldn't be a table? Make it grep-friendly:
>>> [ 1816.719922] rcu: half-timeout counts: hardirq =5 softirq=10 csw=0
>>> [ 1816.725643] rcu: half_timeout cputimes (ms): time=1500 hardirq=3
>> softirq=0 system=1492
>>
>> I prefer the table. Table look clearer and easier to compare.
> 
> Here's an example where it also triggers expedited stalls. The 
> self-detected stall prints including the new table can end up
> interleaved with the expedited stall prints.

But even if use your format, it won't solve the printing
interleaving problem. We should use lock.

> 
> (the table is expanded a bit here to experiment with adding more info, 
> and I included the \t prefixes)
> 
> [  933.728032] tcrypt: rcu testing - kernel_fpu_disable for rude 6 s
> [  938.038278] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 46-.... } 4 jiffies s: 521 root: 0x8/.
> [  938.049151] rcu: blocking rcu_node structures (internal RCU debug): l=1:42-55:0x10/.
> [  938.057236] Sending NMI from CPU 35 to CPUs 46:
> [  938.062048] NMI backtrace for cpu 46
> [  938.062050] CPU: 46 PID: 44184 Comm: modprobe Not tainted 6.0.0+ #11
> [  938.062052] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [  938.062053] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [  938.062151]  </TASK>
> [  938.073277] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 46-.... } 289 jiffies s: 521 root: 0x8/.
> [  938.334292] rcu: blocking rcu_node structures (internal RCU debug): l=1:42-55:0x10/.
> [  938.342289] Sending NMI from CPU 35 to CPUs 46:
> [  938.347049] NMI backtrace for cpu 46
> [  938.347050] CPU: 46 PID: 44184 Comm: modprobe Not tainted 6.0.0+ #11
> [  938.347051] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [  938.347052] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [  938.347121]  </TASK>
> [  938.358275] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 46-.... } 573 jiffies s: 521 root: 0x8/.
> [  938.619182] rcu: blocking rcu_node structures (internal RCU debug): l=1:42-55:0x10/.
> [  938.627179] Sending NMI from CPU 35 to CPUs 46:
> [  938.631939] NMI backtrace for cpu 46
> [  938.631939] CPU: 46 PID: 44184 Comm: modprobe Not tainted 6.0.0+ #11
> [  938.631941] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [  938.631942] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [  938.631997]  </TASK>
> [  938.643272] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> [  938.734267] rcu: INFO: rcu_preempt self-detected stall on CPU
> [  938.740111]  46-....
> [  938.747282] rcu:     46-....: (4948 ticks this GP) idle=a9cc/1/0x4000000000000000 softirq=7598/7598 fqs=1253
> [  938.747285] rcu:               hardirqs   softirqs          csw     system cond_resched
> [  938.747286] rcu:      number:        0          0            0                      0
> [  938.754461]  } 720 jiffies s: 521 root: 0x8/.
> [  938.757178] rcu:     cputime:       62          0                     2436              ==> 2500 (ms)
> [  938.757179] rcu:     current: in_kernel_fpu_begin=1 this_cpu_preemptible=0
> [  938.757181]  (t=5023 jiffies g=61053 q=704 ncpus=56)
> [  938.759640] rcu: blocking rcu_node structures (internal RCU debug):
> 
> The first "46-" line is from the expedited stall.
> The second "46-" line is from the self-detected stall.
> The table lines are from the self-detected stall.
> The "} 720" line is from the expedited stall.
> The "(t=5023" line is from the self-detected stall.
> The "blocking" line is from the expedited stall.
> 
> [  938.761745] CPU: 46 PID: 44184 Comm: modprobe Not tainted 6.0.0+ #11
> [  938.761747] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [  938.982118] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [  939.221833]  </TASK>
> [  939.224239]  l=1:42-55:0x10/.
> [  939.227440] Sending NMI from CPU 35 to CPUs 46:
> [  939.232204] NMI backtrace for cpu 46
> [  939.232205] CPU: 46 PID: 44184 Comm: modprobe Not tainted 6.0.0+ #11
> [  939.232206] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [  939.232207] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [  939.232262]  </TASK>
> [  939.243264] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { 46-.... } 1458 jiffies s: 521 root: 0x8/.
> [  939.503926] rcu: blocking rcu_node structures (internal RCU debug): l=1:42-55:0x10/.
> [  939.511920] Sending NMI from CPU 35 to CPUs 46:
> [  939.516678] NMI backtrace for cpu 46
> [  939.516679] CPU: 46 PID: 44184 Comm: modprobe Not tainted 6.0.0+ #11
> [  939.516680] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [  939.516680] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [  939.516732]  </TASK>
> [  939.528263] rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
> [  939.748586] initcall tcrypt_mod_init+0x0/0x1000 [tcrypt] returned -11 after 6020623 usecs
> [  939.753200]  46-.... } 1718 jiffies s: 521 root: 0x8/.
> [  939.791580] rcu: blocking rcu_node structures (internal RCU debug):
> 
> 

-- 
Regards,
  Zhen Lei
