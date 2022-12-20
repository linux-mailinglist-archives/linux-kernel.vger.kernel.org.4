Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C914A6523D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiLTPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiLTPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:43:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265C12D1C;
        Tue, 20 Dec 2022 07:43:09 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C324276182;
        Tue, 20 Dec 2022 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1671550987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzIgBLveMPShKkEMpEqjCmFU1rbEDYavYpnoHRKIMvs=;
        b=siK6arjnqPRato0rvZBjhDxET8f4VsLmursyBz5ChqQpzjv+2UEOy4grf23UYNslQxW2fd
        f2TjgKn5WcYDb/OsLYRNHroFOV7hduJsZLHDePfgsTyInMVOdRqLI7rMGs/xxnAjfE8ElD
        7r3vN998kJuSWwyqeNnPf39v7GqG5vc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 693532C141;
        Tue, 20 Dec 2022 15:43:07 +0000 (UTC)
Date:   Tue, 20 Dec 2022 16:43:06 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] kallsyms: Fix sleeping function called from invalid
 context when CONFIG_KALLSYMS_SELFTEST=y
Message-ID: <Y6HYChz6pa9Aw0Sa@alley>
References: <20221220063923.1937-1-thunder.leizhen@huawei.com>
 <df75bb4e-6cf8-7f41-b053-9619c13d1c72@csgroup.eu>
 <Y6GWInExu2m48K/C@alley>
 <c5a04eaa-2b8d-647a-7c70-9262e6147394@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5a04eaa-2b8d-647a-7c70-9262e6147394@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-12-20 22:29:31, Leizhen (ThunderTown) wrote:
> On 2022/12/20 19:01, Petr Mladek wrote:
> > On Tue 2022-12-20 08:15:40, Christophe Leroy wrote:
> >>
> >>
> >> Le 20/12/2022 à 07:39, Zhen Lei a écrit :
> >>> [T58] BUG: sleeping function called from invalid context at kernel/kallsyms.c:305
> >>> [T58] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 58, name: kallsyms_test
> >>> [T58] preempt_count: 0, expected: 0
> >>> [T58] RCU nest depth: 0, expected: 0
> >>> [T58] no locks held by kallsyms_test/58.
> >>> [T58] irq event stamp: 18899904
> >>> [T58] hardirqs last enabled at (18899903): finish_task_switch.isra.0 (core.c:?)
> >>> [T58] hardirqs last disabled at (18899904): test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> >>> [T58] softirqs last enabled at (18899886): __do_softirq (??:?)
> >>> [T58] softirqs last disabled at (18899879): ____do_softirq (irq.c:?)
> >>> [T58] CPU: 0 PID: 58 Comm: kallsyms_test Tainted: G T  6.1.0-next-20221215 #2
> >>> [T58] Hardware name: linux,dummy-virt (DT)
> >>> [T58] Call trace:
> >>> [T58] dump_backtrace (??:?)
> >>> [T58] show_stack (??:?)
> >>> [T58] dump_stack_lvl (??:?)
> >>> [T58] dump_stack (??:?)
> >>> [T58] __might_resched (??:?)
> >>> [T58] kallsyms_on_each_symbol (??:?)
> >>> [T58] test_perf_kallsyms_on_each_symbol (kallsyms_selftest.c:?)
> >>> [T58] test_entry (kallsyms_selftest.c:?)
> >>> [T58] kthread (kthread.c:?)
> >>> [T58] ret_from_fork (??:?)
> >>> [T58] kallsyms_selftest: kallsyms_on_each_symbol() traverse all: 5744310840 ns
> >>> [T58] kallsyms_selftest: kallsyms_on_each_match_symbol() traverse all: 1164580 ns
> >>> [T58] kallsyms_selftest: finish
> >>>
> >>> Functions kallsyms_on_each_symbol() and kallsyms_on_each_match_symbol()
> >>> call the user-registered hook function for each symbol that meets the
> >>> requirements. Because it is uncertain how long that hook function will
> >>> execute, they call cond_resched() to avoid consuming CPU resources for a
> >>> long time. However, irqs need to be disabled during the performance test
> >>> to ensure the accuracy of test data. Because the performance test hook is
> >>> very clear, very simple function, let's do not call cond_resched() when
> >>> CONFIG_KALLSYMS_SELFTEST=y.
> >>
> >> I don't think it is appropriate to change the behaviour of a core 
> >> function based on whether a compile time option related to tests is 
> >> selected or not, because you will change the behaviour for all users, 
> >> not only for the tests.
> > 
> > I agree. This is very bad idea. It would change the behavior for
> > the entire system.
> 
> It just doesn't look so good, but it doesn't affect the entire system,
> and the proposed changes below will.

I do not understand this. The proposed patch did:

--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -302,7 +302,8 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
 		ret = fn(data, namebuf, NULL, kallsyms_sym_address(i));
 		if (ret != 0)
 			return ret;
-		cond_resched();
+		if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
+			cond_resched();
 	}
 	return 0;
 }
@@ -319,7 +320,8 @@ int kallsyms_on_each_match_symbol(int (*fn)(void *, unsigned long),
 
 	for (i = start; !ret && i <= end; i++) {
 		ret = fn(data, kallsyms_sym_address(get_symbol_seq(i)));
-		cond_resched();
+		if (!IS_ENABLED(CONFIG_KALLSYMS_SELFTEST))
+			cond_resched();
 	}
 
 	return ret;

It changes the behavior for any kallsyms_on_each_symbol()
and kallsyms_on_each_match_symbol() caller. And this _is_ the problem!

The cond_resched() is there for a reason. See the commit
f5bdb34bf0c9314548f2 ("livepatch: Avoid CPU hogging with
cond_resched").

If a function explicitely includes cond_resched() because it
delayed something by >1s that it must never be called with
interrupts enabled except when there is a good reason to
do so, e.g. for debugging. And measuring CPU time
in a selftest is not a good reason, definitely!

> > If I get it correctly, the problem is this code in kernel/kallsyms_selftest.c:
> 
> Yes, another method is to remove the interrupt protection.
> > 
> > static int lookup_name(void *data, const char *name, struct module *mod, unsigned long addr)
> > {
> > [...]
> > 	local_irq_save(flags);
> > 	t0 = sched_clock();
> > 	(void)kallsyms_lookup_name(name);
> > 	t1 = sched_clock();
> > 	local_irq_restore(flags);
> > [...]
> > 
> > and IRQs are disabled to measure the time spent in this function
> > without interruption and rescheduling.
> > 
> > I am sure that there are better ways how to measure the time.
> > Even the "time" command in userspace is able to show time how much CPU
> > time a command used.
> 
> I've got an idea:
> 
> local_irq_save(flags);
> //get the count and cputime of interrupts
> t0 = sched_clock();
> local_irq_restore(flags);
> 
> (void)kallsyms_lookup_name(name);
> 
> local_irq_save(flags);
> t1 = sched_clock();
> //get the count and cputime of interrupts
> local_irq_restore(flags);

Why do you need to disable IRQs around sched_clock(), please?
It works well in any context.

Is sched_clock() needed at all?
Honestly, I do not understand why you are using sched_clock() for
this.

> > I am not familiar with it. But task_cputime() in
> > kernel/sched/cputime.c looks promising. And there must be
> > the interface how the user space get this information.
> > Some is available via /proc/<PID>/... I am not sure
> > if there is a syscall.

Please, try to investigate the above hints.

Honestly, it looks like you do not know what you are doing.

I NACK this patch.

Best Regards,
Petr
