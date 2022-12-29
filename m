Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAFD65880F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 01:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiL2AZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 19:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL2AZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 19:25:37 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AFB30
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 16:25:35 -0800 (PST)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2BT0PWTM037332;
        Thu, 29 Dec 2022 09:25:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Thu, 29 Dec 2022 09:25:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.20] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2BT0PWZ9037329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Dec 2022 09:25:32 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c8893402-d1b2-9fad-3aad-d130c5f5923b@I-love.SAKURA.ne.jp>
Date:   Thu, 29 Dec 2022 09:25:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 (repost)] locking/lockdep: add
 debug_show_all_lock_holders()
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
In-Reply-To: <41f43b27-d910-78e0-c0b3-f2885fe1cd22@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

Since neither Peter nor Ingo is responding, would you take this patch via
your tree?

On 2022/11/21 19:10, Tetsuo Handa wrote:
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
> To deduplicate code, share debug_show_all_{locks,lock_holders}() using
> a flag. As a side effect of sharing, __debug_show_all_locks() skips
> current thread if the caller is holding no lock, for reporting RCU lock
> taken inside __debug_show_all_locks() is generally useless.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Waiman Long <longman@redhat.com>
> ---
> Changes in v2:
>   Share debug_show_all_lock_holders() and debug_show_all_locks(),
>   suggested by Waiman Long <longman@redhat.com>.
> 
>  include/linux/debug_locks.h | 17 ++++++++++++++++-
>  kernel/hung_task.c          |  2 +-
>  kernel/locking/lockdep.c    | 14 +++++++++++---
>  3 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
> index dbb409d77d4f..b45c89fadfe4 100644
> --- a/include/linux/debug_locks.h
> +++ b/include/linux/debug_locks.h
> @@ -48,7 +48,18 @@ extern int debug_locks_off(void);
>  #endif
>  
>  #ifdef CONFIG_LOCKDEP
> -extern void debug_show_all_locks(void);
> +extern void __debug_show_all_locks(bool show_stack);
> +
> +static inline void debug_show_all_locks(void)
> +{
> +	__debug_show_all_locks(false);
> +}
> +
> +static inline void debug_show_all_lock_holders(void)
> +{
> +	__debug_show_all_locks(true);
> +}
> +
>  extern void debug_show_held_locks(struct task_struct *task);
>  extern void debug_check_no_locks_freed(const void *from, unsigned long len);
>  extern void debug_check_no_locks_held(void);
> @@ -61,6 +72,10 @@ static inline void debug_show_held_locks(struct task_struct *task)
>  {
>  }
>  
> +static inline void debug_show_all_lock_holders(void)
> +{
> +}
> +
>  static inline void
>  debug_check_no_locks_freed(const void *from, unsigned long len)
>  {
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
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e3375bc40dad..b3da133825cc 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -55,6 +55,7 @@
>  #include <linux/rcupdate.h>
>  #include <linux/kprobes.h>
>  #include <linux/lockdep.h>
> +#include <linux/sched/debug.h>
>  
>  #include <asm/sections.h>
>  
> @@ -6487,7 +6488,7 @@ void debug_check_no_locks_held(void)
>  EXPORT_SYMBOL_GPL(debug_check_no_locks_held);
>  
>  #ifdef __KERNEL__
> -void debug_show_all_locks(void)
> +void __debug_show_all_locks(bool show_stack)
>  {
>  	struct task_struct *g, *p;
>  
> @@ -6495,12 +6496,19 @@ void debug_show_all_locks(void)
>  		pr_warn("INFO: lockdep is turned off.\n");
>  		return;
>  	}
> -	pr_warn("\nShowing all locks held in the system:\n");
> +	if (show_stack)
> +		pr_warn("\nShowing all threads with locks held in the system:\n");
> +	else
> +		pr_warn("\nShowing all locks held in the system:\n");
>  
>  	rcu_read_lock();
>  	for_each_process_thread(g, p) {
>  		if (!p->lockdep_depth)
>  			continue;
> +		if (p == current && p->lockdep_depth == 1)
> +			continue;
> +		if (show_stack)
> +			sched_show_task(p);
>  		lockdep_print_held_locks(p);
>  		touch_nmi_watchdog();
>  		touch_all_softlockup_watchdogs();
> @@ -6510,7 +6518,7 @@ void debug_show_all_locks(void)
>  	pr_warn("\n");
>  	pr_warn("=============================================\n\n");
>  }
> -EXPORT_SYMBOL_GPL(debug_show_all_locks);
> +EXPORT_SYMBOL_GPL(__debug_show_all_locks);
>  #endif
>  
>  /*

