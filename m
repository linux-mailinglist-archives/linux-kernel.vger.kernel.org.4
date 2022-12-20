Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9914652297
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiLTObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiLTOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:30:41 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB41E1C125;
        Tue, 20 Dec 2022 06:29:45 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NbzQG6fCnzHqST;
        Tue, 20 Dec 2022 22:25:58 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 20 Dec 2022 22:29:43 +0800
Subject: Re: [PATCH] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
To:     Petr Mladek <pmladek@suse.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20221220063923.1937-1-thunder.leizhen@huawei.com>
 <df75bb4e-6cf8-7f41-b053-9619c13d1c72@csgroup.eu> <Y6GWInExu2m48K/C@alley>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c5a04eaa-2b8d-647a-7c70-9262e6147394@huawei.com>
Date:   Tue, 20 Dec 2022 22:29:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <Y6GWInExu2m48K/C@alley>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/20 19:01, Petr Mladek wrote:
> On Tue 2022-12-20 08:15:40, Christophe Leroy wrote:
>>
>>
>> Le 20/12/2022 à 07:39, Zhen Lei a écrit :
>>> [T58] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
>>> [T58] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 58, name: kallsyms_test
>>> [T58] preempt_count: 0, expected: 0
>>> [T58] RCU nest depth: 0, expected: 0
>>> [T58] no locks held by kallsyms_test/58.
>>> [T58] irq event stamp: 18899904
>>> [T58] hardirqs last enabled at (18899903): finish_task_switch.isra.0 (core.c:?)
>>> [T58] hardirqs last disabled at (18899904): test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
>>> [T58] softirqs last enabled at (18899886): __do_softirq (??:?)
>>> [T58] softirqs last disabled at (18899879): ____do_softirq (irq.c:?)
>>> [T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G T  6.1.0-next-20221215 #2
>>> [T58] Hardware name: linux,dummy-virt (DT)
>>> [T58] Call trace:
>>> [T58] dump_backtrace (??:?)
>>> [T58] show_stack (??:?)
>>> [T58] dump_stack_lvl (??:?)
>>> [T58] dump_stack (??:?)
>>> [T58] __might_resched (??:?)
>>> [T58] kallsyms_on_each_symbol (??:?)
>>> [T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
>>> [T58] test_entry (kallsyms_selftest.c:?)
>>> [T58] kthread (kthread.c:?)
>>> [T58] ret_from_fork (??:?)
>>> [T58] kallsyms_selftest: kallsyms_on_each_symbol() traverse all: 5744310840 ns
>>> [T58] kallsyms_selftest: kallsyms_on_each_match_symbol() traverse all: 1164580 ns
>>> [T58] kallsyms_selftest: finish
>>>
>>> Functions kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol()
>>> call the user-registered hook function for each symbol that meets the
>>> requirements. Because it is uncertain how long that hook function will
>>> execute, they call cond_resched() to avoid consuming CPU resources for a
>>> long time. However, irqs need to be disabled during the performance test
>>> to ensure the accuracy of test data. Because the performance test hook is
>>> very clear, very simple function, let's do not call cond_resched() when
>>> CONFIG_KALLSYMS_SELFTEST=y.
>>
>> I don't think it is appropriate to change the behaviour of a core 
>> function based on whether a compile time option related to tests is 
>> selected or not, because you will change the behaviour for all users, 
>> not only for the tests.
> 
> I agree. This is very bad idea. It would change the behavior for
> the entire system.

It just doesn't look so good, but it doesn't affect the entire system,
and the proposed changes below will.

> 
>> If the problem is that IRQs are disabled, maybe the solution is
>>
>> 	if (!irqs_disabled())
>> 		cond_resched();

If irqs is disabled by the upper layer, this error cannot be easily detected.

>>
>> Or try to disable the call to cond_resched() in a way or another during 
>> the run of selftests.
> 
> If I get it correctly, the problem is this code in kernel/kallsyms_selftest.c:

Yes, another method is to remove the interrupt protection.

> 
> static int lookup_name(void *data, const char *name, struct module *mod, unsigned long addr)
> {
> [...]
> 	local_irq_save(flags);
> 	t0 = sched_clock();
> 	(void)kallsyms_lookup_name(name);
> 	t1 = sched_clock();
> 	local_irq_restore(flags);
> [...]
> 
> and IRQs are disabled to measure the time spent in this function
> without interruption and rescheduling.
> 
> I am sure that there are better ways how to measure the time.
> Even the "time" command in userspace is able to show time how much CPU
> time a command used.

I've got an idea:

local_irq_save(flags);
//get the count and cputime of interrupts
t0 = sched_clock();
local_irq_restore(flags);

(void)kallsyms_lookup_name(name);

local_irq_save(flags);
t1 = sched_clock();
//get the count and cputime of interrupts
local_irq_restore(flags);

minus the cputime of local_irq_save(flags)/local_irq_restore(flags)

if count changed, minus the cputime of interrupts

> 
> I am not familiar with it. But task_cputime() in
> kernel/sched/cputime.c looks promising. And there must be
> the interface how the user space get this information.
> Some is available via /proc/<PID>/... I am not sure
> if there is a syscall.
> 
> Best Regards,
> Petr
> .
> 

-- 
Regards,
  Zhen Lei
