Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6EC660653
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbjAFSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjAFSZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 13:25:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9FB2AC0;
        Fri,  6 Jan 2023 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8XVbF/9SeIsWaXsMOVuymck+rAOoWnJ7YhcqpRHsuis=; b=rmKYDQkxQwDxVoecxlNhfU4N5B
        Y0YedWe7zQeVDvZUAseXk8BJctYxpVkSBQ/5reHPtj0pfWgpyHIPr9jc9kNrU0+kG6ml9dwM8M5P7
        9lup9CARv5eN/C/qZTQaj9fG88K+JHDmQ71k7RzfbHGZ0nyc7KROwenyjWruh2Rj5Y5r/7K5l9B/u
        0UhFt7CXKxgGjPzSlpPDSXFo46sZwfVzT1D5IAAB87ZSQ979NSo4nAiFR5EO0WvcViSMqSQ+5gVBG
        Oel9vO2X01LhNHGkgVBjqIJLHdv1rQl/6Z47ux9Y++4AGpB4Wzs5rw21P4TFa3aRdx/x5pwD6kajs
        kZWxi2jA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pDrP3-00EMCV-H2; Fri, 06 Jan 2023 18:25:17 +0000
Date:   Fri, 6 Jan 2023 10:25:17 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y7hnjVftrszW8V2E@bombadil.infradead.org>
References: <20221228014511.328-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228014511.328-1-thunder.leizhen@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 09:45:11AM +0800, Zhen Lei wrote:
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
>  	pr_info("kallsyms_on_each_match_symbol() traverse all: %lld ns\n", t1 - t0);

But can't we bump the number of IRQs, preempt, handle the IRQ and come
back to the same CPU with the same IRQ count and end up with a very very
false positive on delta?

  Luis
