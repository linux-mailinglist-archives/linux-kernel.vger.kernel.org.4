Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9139D64F75A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 04:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiLQD3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 22:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLQD3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 22:29:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1B13D26
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 19:29:33 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NYrz06g8JzmWfv;
        Sat, 17 Dec 2022 11:28:28 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 17 Dec 2022 11:29:31 +0800
Subject: Re: BUG: sleeping function called from invalid context at
 kernel/kallsyms.c:305
To:     Anders Roxell <anders.roxell@linaro.org>, <mcgrof@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CADYN=9LfFwNjToc8nhrD1MMZnQptyMNjbEFaMjPXuzzxADMbsA@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c68c4226-6a5b-b3f6-3102-d7c34b576f9d@huawei.com>
Date:   Sat, 17 Dec 2022 11:29:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CADYN=9LfFwNjToc8nhrD1MMZnQptyMNjbEFaMjPXuzzxADMbsA@mail.gmail.com>
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



On 2022/12/16 18:45, Anders Roxell wrote:
> Hi,
> 
> I'm building an arm64 allmodconfig kernel (see the .config [1]) on
> yesterdays next tag 20221215 with KALLSYMS_SELFTEST enabled and I saw
> the following bug when the selftest ran:
> 
> [29725.015182][   T58] BUG: sleeping function called from invalid
> context at kernel/kallsyms.c:305
> [29725.022953][   T58] in_atomic(): 0, irqs_disabled(): 128,
> non_block: 0, pid: 58, name: kallsyms_test
> [29725.031272][   T58] preempt_count: 0, expected: 0
> [29725.035903][   T58] RCU nest depth: 0, expected: 0
> [29725.040574][   T58] no locks held by kallsyms_test/58.
> [29725.045494][   T58] irq event stamp: 18899904
> [29725.049809][ T58] hardirqs last enabled at (18899903):
> finish_task_switch.isra.0 (core.c:?)
> [29725.059608][ T58] hardirqs last disabled at (18899904):
> test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> [29725.069936][ T58] softirqs last enabled at (18899886): __do_softirq (??:?)
> [29725.078670][ T58] softirqs last disabled at (18899879):
> ____do_softirq (irq.c:?)
> [29725.087399][   T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G
>              T  6.1.0-next-20221215 #2
> 0a142be8faea13ac333ed9a1cf4e71b6966ad16e
> [29725.099607][   T58] Hardware name: linux,dummy-virt (DT)
> [29725.104674][   T58] Call trace:
> [29725.107909][ T58] dump_backtrace (??:?)
> [29725.112706][ T58] show_stack (??:?)
> [29725.116883][ T58] dump_stack_lvl (??:?)
> [29725.121666][ T58] dump_stack (??:?)
> [29725.125852][ T58] __might_resched (??:?)
> [29725.130712][ T58] kallsyms_on_each_symbol (??:?)
> [29725.136018][ T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> [29725.142008][ T58] test_entry (kallsyms_selftest.c:?)
> [29725.146312][ T58] kthread (kthread.c:?)
> [29725.150567][ T58] ret_from_fork (??:?)
> [29734.975283][   T58] kallsyms_selftest: kallsyms_on_each_symbol()
> traverse all: 5744310840 ns
> [29734.992268][   T58] kallsyms_selftest:
> kallsyms_on_each_match_symbol() traverse all: 1164580 ns
> [29735.049679][   T58] kallsyms_selftest: finish
> 
> looks like the issue is that test_perf_kallsyms_on_each_symbol() does
> these function calls:
> 
>        local_irq_save(flags);
>        t0 = sched_clock();
>        kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
>        t1 = sched_clock();
>        local_irq_restore(flags);
> 
> and inside kallsyms_on_each_match_symbol(), cond_resched() is called.
> 
> Any ideas how to solve this?

I was initially hoping that the test process would not be interrupted.
It is not a big problem to remove local_irq_save(). From a probabilistic
statistical point of view: it does not affect the horizontal comparison
between kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol(),
and the vertical comparison before and after optimization is also not
affected.

Or do not call cond_resched() during the test. This method seems to be
a little better.

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index e31b4d87a4e1b71..9e07fabaf08e647 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -358,7 +358,8 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
                ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
                if (ret != 0)
                        return ret;
-               cond_resched();
+               if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
+                       cond_resched();
        }
        return 0;
 }
@@ -375,7 +376,8 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),

        for (i = start; !ret && i <= end; i++) {
                ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
-               cond_resched();
+               if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
+                       cond_resched();
        }

        return ret;

> 
> Cheers,
> Anders
> [1] https://people.linaro.org/~anders.roxell/next-20221215.config
> .
> 

-- 
Regards,
  Zhen Lei
