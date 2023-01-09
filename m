Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD80B661C8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjAIDIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjAIDIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:08:16 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A3BC92;
        Sun,  8 Jan 2023 19:08:15 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NqzLH2WKXzJn1g;
        Mon,  9 Jan 2023 11:04:07 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 11:07:37 +0800
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        <linux-modules@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
 <Y7hnjVftrszW8V2E@bombadil.infradead.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <6f4bc106-2961-254c-717f-d989fca1e94a@huawei.com>
Date:   Mon, 9 Jan 2023 11:07:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y7hnjVftrszW8V2E@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/1/7 2:25, Luis Chamberlain wrote:
> On Wed, Dec 28, 2022 at 09:45:11AM +0800, Zhen Lei wrote:
>> [T58] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
>> [T58] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 58, name: kallsyms_test
>> [T58] preempt_count: 0, expected: 0
>> [T58] RCU nest depth: 0, expected: 0
>> [T58] no locks held by kallsyms_test/58.
>> [T58] irq event stamp: 18899904
>> [T58] hardirqs last enabled at (18899903): finish_task_switch.isra.0 (core.c:?)
>> [T58] hardirqs last disabled at (18899904): test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
>> [T58] softirqs last enabled at (18899886): __do_softirq (??:?)
>> [T58] softirqs last disabled at (18899879): ____do_softirq (irq.c:?)
>> [T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G T  6.1.0-next-20221215 #2
>> [T58] Hardware name: linux,dummy-virt (DT)
>> [T58] Call trace:
>> [T58] dump_backtrace (??:?)
>> [T58] show_stack (??:?)
>> [T58] dump_stack_lvl (??:?)
>> [T58] dump_stack (??:?)
>> [T58] __might_resched (??:?)
>> [T58] kallsyms_on_each_symbol (??:?)
>> [T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
>> [T58] test_entry (kallsyms_selftest.c:?)
>> [T58] kthread (kthread.c:?)
>> [T58] ret_from_fork (??:?)
>> [T58] kallsyms_selftest: kallsyms_on_each_symbol() traverse all: 5744310840 ns
>> [T58] kallsyms_selftest: kallsyms_on_each_match_symbol() traverse all: 1164580 ns
>> [T58] kallsyms_selftest: finish
>>
>> The execution time of function kallsyms_on_each_match_symbol() is very
>> short, about ten microseconds, the probability of this process being
>> interrupted is very small. And even if it happens, we just have to try
>> again.
>>
>> The execution time of function kallsyms_on_each_symbol() is very long,
>> it takes tens of milliseconds, context switches is likely occur during
>> this period. If the time obtained by task_cputime() is accurate, it is
>> preferred. Otherwise, use local_clock() directly, and the time taken by
>> irqs and high-priority tasks is not deducted because they are always
>> running for a short time.
>>
>> Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
>> Reported-by: Anders Roxell <anders.roxell@linaro.org>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  kernel/kallsyms_selftest.c | 52 +++++++++++++++++++++++++++-----------
>>  1 file changed, 37 insertions(+), 15 deletions(-)
>>
>> v1 --> v2:
>> 1. Keep calling cond_resched() when CONFIG_KALLSYMS_SELFTEST=y. Instead,
>>    function kallsyms_on_each_match_symbol() and kallsyms_on_each_symbol()
>>    are not protected by local_irq_save() in kallsyms_selftest.c.
>>
>> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
>> @@ -270,17 +283,26 @@ static int match_symbol(void *data, unsigned long addr)
>>  static void test_perf_kallsyms_on_each_match_symbol(void)
>>  {
>>  	u64 t0, t1;
>> -	unsigned long flags;
>> +	int cpu = smp_processor_id();
>> +	unsigned long nr_irqs;
>>  	struct test_stat stat;
>>  
>>  	memset(&stat, 0, sizeof(stat));
>>  	stat.max = INT_MAX;
>>  	stat.name = stub_name;
>> -	local_irq_save(flags);
>> -	t0 = sched_clock();
>> -	kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
>> -	t1 = sched_clock();
>> -	local_irq_restore(flags);
>> +
>> +	/*
>> +	 * The test thread has been bound to a fixed CPU in advance. If the
>> +	 * number of irqs does not change, no new scheduling request will be
>> +	 * generated. That is, the performance test process is atomic.
>> +	 */
>> +	do {
>> +		nr_irqs = kstat_cpu_irqs_sum(cpu);
>> +		cond_resched();
>> +		t0 = local_clock();
>> +		kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
>> +		t1 = local_clock();
>> +	} while (nr_irqs != kstat_cpu_irqs_sum(cpu));
>>  	pr_info("kallsyms_on_each_match_symbol() traverse all: %lld ns\n", t1 - t0);
> 
> But can't we bump the number of IRQs, preempt, handle the IRQ and come
> back to the same CPU with the same IRQ count and end up with a very very
> false positive on delta?

Do you mean the total time minus the processing time of interrupts? It seems
to be a little more complicated to implement. Because soft interrupts and task
switches may also be happened. Although the current implementation contains a
while loop, it actually retries at most one more time. And I think it's easier
to understand, without worrying about the side effects of the corners.

> 
>   Luis
> .
> 

-- 
Regards,
  Zhen Lei
