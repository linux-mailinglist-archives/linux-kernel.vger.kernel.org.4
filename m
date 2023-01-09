Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87164662777
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbjAINmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbjAINlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:41:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35453271B0;
        Mon,  9 Jan 2023 05:40:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73A0175BD5;
        Mon,  9 Jan 2023 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673271630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZIh1mGADQOMi8JgdiZ4LhP9Cd71hCNn0DllffPOEAI=;
        b=imcwR1BBHpKuGLCnsp0AnTJZrGwOhJiO9rZ9ckM/vvsEABuBKLZtPVJ4Hep5SsC/hnTWq1
        Tn2eeAqAx1Q4Nd4i1NI46vUswapom9oqGYOoOellzJai48fOvzannAybWg6fMvL3vqscf8
        44awmnYpwxNe5l8ncJso/us4yi4x25Q=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FE662C141;
        Mon,  9 Jan 2023 13:40:30 +0000 (UTC)
Date:   Mon, 9 Jan 2023 14:40:27 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y7wZSxw+Ys5MNf8g@alley>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014511.328-1-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-12-28 09:45:11, Zhen Lei wrote:
> [T58] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
> [T58] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 58, name: kallsyms_test
> [T58] preempt_count: 0, expected: 0
> [T58] RCU nest depth: 0, expected: 0
> [T58] no locks held by kallsyms_test/58.
> [T58] irq event stamp: 18899904
> [T58] hardirqs last enabled at (18899903): finish_task_switch.isra.0 (core.c:?)
> [T58] hardirqs last disabled at (18899904): test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> [T58] softirqs last enabled at (18899886): __do_softirq (??:?)
> [T58] softirqs last disabled at (18899879): ____do_softirq (irq.c:?)
> [T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G T  6.1.0-next-20221215 #2
> [T58] Hardware name: linux,dummy-virt (DT)
> [T58] Call trace:
> [T58] dump_backtrace (??:?)
> [T58] show_stack (??:?)
> [T58] dump_stack_lvl (??:?)
> [T58] dump_stack (??:?)
> [T58] __might_resched (??:?)
> [T58] kallsyms_on_each_symbol (??:?)
> [T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> [T58] test_entry (kallsyms_selftest.c:?)
> [T58] kthread (kthread.c:?)
> [T58] ret_from_fork (??:?)
> [T58] kallsyms_selftest: kallsyms_on_each_symbol() traverse all: 5744310840 ns
> [T58] kallsyms_selftest: kallsyms_on_each_match_symbol() traverse all: 1164580 ns
> [T58] kallsyms_selftest: finish
> 
> The execution time of function kallsyms_on_each_match_symbol() is very
> short, about ten microseconds, the probability of this process being
> interrupted is very small. And even if it happens, we just have to try
> again.
> 
> The execution time of function kallsyms_on_each_symbol() is very long,
> it takes tens of milliseconds, context switches is likely occur during
> this period. If the time obtained by task_cputime() is accurate, it is
> preferred. Otherwise, use local_clock() directly, and the time taken by
> irqs and high-priority tasks is not deducted because they are always
> running for a short time.
> 
> Fixes: 30f3bb09778d ("kallsyms: Add self-test facility")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  kernel/kallsyms_selftest.c | 52 +++++++++++++++++++++++++++-----------
>  1 file changed, 37 insertions(+), 15 deletions(-)
> 
> v1 --> v2:
> 1. Keep calling cond_resched() when CONFIG_KALLSYMS_SELFTEST=y. Instead,
>    function kallsyms_on_each_match_symbol() and kallsyms_on_each_symbol()
>    are not protected by local_irq_save() in kallsyms_selftest.c.
> 
> diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
> index f35d9cc1aab1544..9c94f06aa951971 100644
> --- a/kernel/kallsyms_selftest.c
> +++ b/kernel/kallsyms_selftest.c
> @@ -12,9 +12,11 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/kallsyms.h>
> +#include <linux/kernel_stat.h>
> +#include <linux/kthread.h>
>  #include <linux/random.h>
>  #include <linux/sched/clock.h>
> -#include <linux/kthread.h>
> +#include <linux/sched/cputime.h>
>  #include <linux/vmalloc.h>
>  
>  #include "kallsyms_internal.h"
> @@ -161,9 +163,9 @@ static int lookup_name(void *data, const char *name, struct module *mod, unsigne
>  	struct test_stat *stat = (struct test_stat *)data;
>  
>  	local_irq_save(flags);
> -	t0 = sched_clock();
> +	t0 = local_clock();
>  	(void)kallsyms_lookup_name(name);
> -	t1 = sched_clock();
> +	t1 = local_clock();
>  	local_irq_restore(flags);
>  
>  	t = t1 - t0;
> @@ -233,19 +235,30 @@ static int find_symbol(void *data, const char *name, struct module *mod, unsigne
>  
>  static void test_perf_kallsyms_on_each_symbol(void)
>  {
> -	u64 t0, t1;
> -	unsigned long flags;
> +	bool accurate;
> +	u64 utime, t0, t1;
>  	struct test_stat stat;
>  
>  	memset(&stat, 0, sizeof(stat));
>  	stat.max = INT_MAX;
>  	stat.name = stub_name;
>  	stat.perf = 1;
> -	local_irq_save(flags);
> -	t0 = sched_clock();
> +
> +	/*
> +	 * This test process takes tens of milliseconds, context switches may
> +	 * occur during this period. If task_cputime() returns true, it is
> +	 * accurate enough. Otherwise, use local_clock() directly. This is
> +	 * based on the assumption that irqs and high-priority tasks are always
> +	 * running for a short time, they may cause less error.
> +	 */
> +	accurate = task_cputime(current, &utime, &t0);
> +	if (!accurate)
> +		t0 = local_clock();
>  	kallsyms_on_each_symbol(find_symbol, &stat);
> -	t1 = sched_clock();
> -	local_irq_restore(flags);
> +	if (accurate)
> +		task_cputime(current, &utime, &t1);
> +	else
> +		t1 = local_clock();
>  	pr_info("kallsyms_on_each_symbol() traverse all: %lld ns\n", t1 - t0);
>  }
>  
> @@ -270,17 +283,26 @@ static int match_symbol(void *data, unsigned long addr)
>  static void test_perf_kallsyms_on_each_match_symbol(void)
>  {
>  	u64 t0, t1;
> -	unsigned long flags;
> +	int cpu = smp_processor_id();
> +	unsigned long nr_irqs;
>  	struct test_stat stat;
>  
>  	memset(&stat, 0, sizeof(stat));
>  	stat.max = INT_MAX;
>  	stat.name = stub_name;
> -	local_irq_save(flags);
> -	t0 = sched_clock();
> -	kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
> -	t1 = sched_clock();
> -	local_irq_restore(flags);
> +
> +	/*
> +	 * The test thread has been bound to a fixed CPU in advance. If the
> +	 * number of irqs does not change, no new scheduling request will be
> +	 * generated. That is, the performance test process is atomic.
> +	 */
> +	do {
> +		nr_irqs = kstat_cpu_irqs_sum(cpu);
> +		cond_resched();
> +		t0 = local_clock();
> +		kallsyms_on_each_match_symbol(match_symbol, stat.name, &stat);
> +		t1 = local_clock();
> +	} while (nr_irqs != kstat_cpu_irqs_sum(cpu));

Huh, is this guaranteed to ever finish?

What if there is a regression and kallsyms_on_each_match_symbol()
never finishes without rescheduling?

This is yet another unreliable hack.


Use standard solution:

I did the homework for you and checked how the "time" command
measures the time spend in the system. It actually uses more methods.

One is times() syscall. It uses thread_group_cputime_adjusted(), see
do_sys_times() in kernel/sys.c

Or it uses wait4() syscall to get struct rusage that provides this
information.

Please, stop inventing crazy hacks, and use these standard methods.
If the "time" tool is enough for userspace performance tests
then it must be enough in this case as well.


Or remove this test:

Seriously, what is the value of this test?
Is anyone going to use it at all in the future?

The code was useful when developing the optimization.
But it is really questionable as a selftest.

Selftests usually check if the code works as expected.
This test provides some number that is hardly comparable.


Why are try hardly comparable?

1. The speed depends on the number of loaded modules
   and number of symbols. It highly depends on the configuration
   that was used to build the kernel.

2. The test runs only once. As a result it is hard to judge
   how big is the noise.

3. The noise might depend on the size and state of CPU caches.


I personally vote for removing this selftest!

Best Regards,
Petr
