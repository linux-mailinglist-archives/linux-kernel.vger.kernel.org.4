Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC91694646
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBMMtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjBMMtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:49:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8FC3C21
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 04:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=608dizr75uPBUsKJ/0W0QtAph9stnK2E4frkEXs4nGE=; b=E73a0/vcrRiyCWXUDw+b2v+gYY
        3DaNoE8Vu8w0aKzx8ikF4VhtkVYTmg0KhBtLwe7fXKNY/JGtDJeR5i7MNZR6J8yeMyoZ0jE7p1nCu
        dRxZEFjqomcMOzuLv9Soyxwg07st2iK4qJsblVl+URUy+Jv6bC60XChrvK8diKsVSxNNwIQN2GwY+
        9kc7aHaFok7v8Jy2w3sBEN87RuTFyZQq+/Mkh/PugcGbHXq+ErMCaNXEa76HOo1O/wN44ieAeZNNo
        qt5ybJj1wkz7zcYnG87ufvohIuQkvKq8WbEpkdwHw3xGKfUHfgQ+gvYpu8fYDeycco0GYLtZTHfNU
        9wHbcKuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pRYGN-009IgA-19;
        Mon, 13 Feb 2023 12:48:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1070D300033;
        Mon, 13 Feb 2023 13:49:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED5C120C18264; Mon, 13 Feb 2023 13:49:35 +0100 (CET)
Date:   Mon, 13 Feb 2023 13:49:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] locking/lockdep: add debug_show_all_lock_holders()
Message-ID: <Y+ox39WhgY/iaVsG@hirez.programming.kicks-ass.net>
References: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
 <Y+oY3Xd43nNnkDSB@hirez.programming.kicks-ass.net>
 <274adab4-9922-1586-7593-08d9db5479a1@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274adab4-9922-1586-7593-08d9db5479a1@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 08:34:55PM +0900, Tetsuo Handa wrote:
> On 2023/02/13 20:02, Peter Zijlstra wrote:
> >> @@ -213,7 +213,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
> >>   unlock:
> >>  	rcu_read_unlock();
> >>  	if (hung_task_show_lock)
> >> -		debug_show_all_locks();
> >> +		debug_show_all_lock_holders();
> >>  
> >>  	if (hung_task_show_all_bt) {
> >>  		hung_task_show_all_bt = false;
> > 
> > This being the hung-task detector, which is mostly about sleeping locks.
> 
> Yes, the intent of this patch is to report tasks sleeping with locks held,
> for the cause of hung task is sometimes a deadlock.
> 
> >> +	rcu_read_lock();
> >> +	for_each_process_thread(g, p) {
> >> +		if (!p->lockdep_depth)
> >> +			continue;
> >> +		if (p == current && p->lockdep_depth == 1)
> >> +			continue;
> >> +		sched_show_task(p);
> > 
> > And sched_show_task() being an utter piece of crap that will basically
> > print garbage for anything that's running (it doesn't have much
> > options).
> > 
> > Should we try and do better? dump_cpu_task() prefers
> > trigger_single_cpu_backtrace(), which sends an interrupt in order to get
> > active registers for the CPU.
> 
> What is the intent of using trigger_single_cpu_backtrace() here?
> check_hung_uninterruptible_tasks() is calling trigger_all_cpu_backtrace()
> if sysctl_hung_task_all_cpu_backtrace is set.

Then have that also print the held locks for those tasks. And skip over
them again later.

> Locks held and kernel backtrace are helpful for describing deadlock
> situation, but registers values are not.

Register state is required to start the unwind. You can't unwind a
running task out of thin-air.

> What is important is that tasks which are not on CPUs are reported,
> for when a task is reported as hung, that task must be sleeping.
> Therefore, I think sched_show_task() is fine.

The backtraces generated by sched_show_task() for a running task are
absolutely worthless, might as well not print them.

And if I read your Changelog right, you explicitly wanted useful
backtraces for the running tasks -- such that you could see what they
were doing while holding the lock the other tasks were blocked on.

The only way to do that is to send an interrupt, the interrupt will have
the register state for the interrupted task -- including the stack
pointer. By virtue of running the interrupt handler we know the stack
won't shrink, so we can then safely traverse the stack starting from the
given stack pointer.


