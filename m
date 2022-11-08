Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AC0620743
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiKHDHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiKHDGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:06:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6840303D8;
        Mon,  7 Nov 2022 19:06:40 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N5tKg56pyzRp5C;
        Tue,  8 Nov 2022 11:06:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:06:39 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:06:38 +0800
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ac89012c-c9c8-aed1-2007-d5cc93433db7@huawei.com>
Date:   Tue, 8 Nov 2022 11:06:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MW5PR84MB1842199BE77619EFB93AB1DAAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
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



On 2022/11/8 5:57, Elliott, Robert (Servers) wrote:
> I created a 22 second stall, which triggered two self-detected stall
> messages. The second one covers 18 seconds (and reports 17444 ms
> of system cputime), but still reports the half_timeout of 2.5 s on

Because I have not updated rsrp->gp_seq in print_cpu_stat_info().

Please add rsrp->gp_seq-- at the bottom of print_cpu_stat_info()
and try again.

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 2e560a70d88fd87..6f6c95d599e6436 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -455,6 +455,7 @@ static void print_cpu_stat_info(int cpu)
                div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSEC),
                div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system, NSEC_PER_MSEC),
                jiffies64_to_msecs(half_timeout));
+       rsrp->gp_seq--;
 }

 /*

> the right. The duration since the snapshot was taken would be
> more meaningful.
> 
> [ 3428.422726] tcrypt: rcu testing - preempt_disable for rude 22 s
> [ 3433.419012] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 3433.425145] rcu:     52-....: (4993 ticks this GP) idle=7704/1/0x4000000000000000 softirq=8448/8448 fqs=1247
> [ 3433.435073] rcu:               hardirqs   softirqs          csw     system cond_resched
> [ 3433.443096] rcu:      number:        0          5            0                      0
> [ 3433.450930] rcu:     cputime:        8          0                     2489              ==> 2500 (ms)
> [ 3433.460151] rcu:     current: in_kernel_fpu_begin=0 this_cpu_preemptible=0
> [ 3433.467006]  (t=5044 jiffies g=127261 q=179 ncpus=56)
> [ 3433.472285] CPU: 52 PID: 44429 Comm: modprobe Not tainted 6.0.0+ #11
> [ 3433.478879] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [ 3433.487664] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> [ 3433.717818]  </TASK>
> [ 3448.719827] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 3448.725816] rcu:     52-....: (19994 ticks this GP) idle=7704/1/0x4000000000000000 softirq=8448/8448 fqs=5002
> [ 3448.735736] rcu:               hardirqs   softirqs          csw     system cond_resched
> [ 3448.743735] rcu:      number:        0         38            0                      0
> [ 3448.751560] rcu:     cputime:      354          0                    17444              ==> 2500 (ms)
> [ 3448.760780] rcu:     current: in_kernel_fpu_begin=0 this_cpu_preemptible=0
> [ 3448.767643]  (t=20348 jiffies g=127261 q=1019 ncpus=56)
> [ 3448.773106] CPU: 52 PID: 44429 Comm: modprobe Not tainted 6.0.0+ #11
> [ 3448.779704] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 03/08/2022
> [ 3448.788488] RIP: 0010:rude_sleep_cycles+0x13/0x27 [tcrypt]
> ...
> 
> 
> 

-- 
Regards,
  Zhen Lei
