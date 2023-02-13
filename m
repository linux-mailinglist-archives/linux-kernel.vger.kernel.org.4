Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5CA6943BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBMLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBMLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:03:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCAA4ED0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=skcAT8cZav6/mztULim5OvFOZbyH89Dt6Bwu5XbpglI=; b=U9J3X3vFmprbFLgXyleVBB1VP8
        XzpdR9gXrEXwh3UthvVXaPB/ixdFGEakDi03CGQoVMZ+4r7RQKcKsBO3ynxNnOdkqi+YMZitJKUQg
        vGrWXZLPIS84dYYNI/SL+CMZcG/gvoZfzeeJFA0n7tY5TBkITirG9CPoEw0wMbnApNWU3aF4xxLmP
        uYWl4ENxfsy4ekcN28cJjunLgvMP4d1fFXzpjNiq+bqjOSi5aqySzemzvHoVDRGL2I6dTgZN8AMyH
        a5CayMSpXzkhHtwXHY5FVYXzXq3GDAuYHsoG+lykbIhwHgsm6m4oPW9DxpFKkAVOczSLfOr7UXj5o
        WZZBqPOA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRWbm-005g1m-QJ; Mon, 13 Feb 2023 11:02:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6A2E30020C;
        Mon, 13 Feb 2023 12:02:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CFAF021BD1F77; Mon, 13 Feb 2023 12:02:53 +0100 (CET)
Date:   Mon, 13 Feb 2023 12:02:53 +0100
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
Message-ID: <Y+oY3Xd43nNnkDSB@hirez.programming.kicks-ass.net>
References: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed17797b-e732-0dd0-2b4e-dc293653c0ac@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:59:50PM +0900, Tetsuo Handa wrote:
> Currently, check_hung_uninterruptible_tasks() reports details of locks
> held in the system. Also, lockdep_print_held_locks() does not report
> details of locks held by a thread if that thread is in TASK_RUNNING state.
> Several years of experience of debugging without vmcore tells me that
> these limitations have been a barrier for understanding what went wrong
> in syzbot's "INFO: task hung in" reports.
> 
> I initially thought that the cause of "INFO: task hung in" reports is
> due to over-stressing. But I understood that over-stressing is unlikely.
> I now consider that there likely is a deadlock/livelock bug where lockdep
> cannot report as a deadlock when "INFO: task hung in" is reported.
> 
> A typical case is that thread-1 is waiting for something to happen (e.g.
> wait_event_*()) with a lock held. When thread-2 tries to hold that lock
> using e.g. mutex_lock(), check_hung_uninterruptible_tasks() reports that
> thread-2 is hung and thread-1 is holding a lock which thread-2 is trying
> to hold. But currently check_hung_uninterruptible_tasks() cannot report
> the exact location of thread-1 which gives us an important hint for
> understanding why thread-1 is holding that lock for so long period.
> 
> When check_hung_uninterruptible_tasks() reports a thread waiting for a
> lock, it is important to report backtrace of threads which already held
> that lock. Therefore, allow check_hung_uninterruptible_tasks() to report
> the exact location of threads which is holding any lock.
> 
> debug_show_all_lock_holders() skips current thread if the caller is
> holding no lock, for reporting RCU lock taken inside that function is
> generally useless.

> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index c71889f3f3fc..5fba784258b7 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -213,7 +213,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>   unlock:
>  	rcu_read_unlock();
>  	if (hung_task_show_lock)
> -		debug_show_all_locks();
> +		debug_show_all_lock_holders();
>  
>  	if (hung_task_show_all_bt) {
>  		hung_task_show_all_bt = false;

This being the hung-task detector, which is mostly about sleeping locks.

> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e3375bc40dad..d9394de09b79 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -32,6 +32,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/task.h>
>  #include <linux/sched/mm.h>
> +#include <linux/sched/debug.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/proc_fs.h>
> @@ -6511,6 +6512,33 @@ void debug_show_all_locks(void)
>  	pr_warn("=============================================\n\n");
>  }
>  EXPORT_SYMBOL_GPL(debug_show_all_locks);
> +
> +void debug_show_all_lock_holders(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	if (unlikely(!debug_locks)) {
> +		pr_warn("INFO: lockdep is turned off.\n");
> +		return;
> +	}
> +	pr_warn("\nShowing all threads with locks held in the system:\n");
> +
> +	rcu_read_lock();
> +	for_each_process_thread(g, p) {
> +		if (!p->lockdep_depth)
> +			continue;
> +		if (p == current && p->lockdep_depth == 1)
> +			continue;
> +		sched_show_task(p);

And sched_show_task() being an utter piece of crap that will basically
print garbage for anything that's running (it doesn't have much
options).

Should we try and do better? dump_cpu_task() prefers
trigger_single_cpu_backtrace(), which sends an interrupt in order to get
active registers for the CPU.

