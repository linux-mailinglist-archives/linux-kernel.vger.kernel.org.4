Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE25BB24A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 20:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIPSlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 14:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiIPSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 14:41:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9105B08A4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663353679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOWbr+J3nokN59eiOVRzXdB1ZBVlu2bj0YVITjUeb4o=;
        b=MFaMvm6v3vf+MIjWgOqIA2R9qw1N4u78NP3To9qnkdgy+olBPCYAgWYDZsZExOT/0gsG71
        bVhlReA/GddS76FEOrBGpBBbA6s7GyWygrw3W5cJKdM8dMr4378tVGdPzdQLpzF0iRLxdl
        FZHiscXyT/oYXbEQ1A09v5/LsZ7lQ+0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-ouoQdD1yMsmmaqFCw8qwWg-1; Fri, 16 Sep 2022 14:41:13 -0400
X-MC-Unique: ouoQdD1yMsmmaqFCw8qwWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCA1429AB3F3;
        Fri, 16 Sep 2022 18:41:12 +0000 (UTC)
Received: from [10.22.17.61] (unknown [10.22.17.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB7F92166B26;
        Fri, 16 Sep 2022 18:41:11 +0000 (UTC)
Message-ID: <1fd381e0-03e7-df2a-4865-d157714ce9b2@redhat.com>
Date:   Fri, 16 Sep 2022 14:41:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] locking/lockdep: add debug_show_all_lock_holders()
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@sifive.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        John Ogness <john.ogness@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <d5393b0e-a296-3296-d376-c9178669747b@I-love.SAKURA.ne.jp>
 <3e027453-fda4-3891-3ec3-5623f1525e56@redhat.com>
 <9f42e8a5-f809-3f2c-0fda-b7657bc94eb3@I-love.SAKURA.ne.jp>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <9f42e8a5-f809-3f2c-0fda-b7657bc94eb3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 11:57, Tetsuo Handa wrote:
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
> ---
> Changes in v2:
>    Share debug_show_all_lock_holders() and debug_show_all_locks(),
>    suggested by Waiman Long <longman@redhat.com>.
>
>   include/linux/debug_locks.h | 17 ++++++++++++++++-
>   kernel/hung_task.c          |  2 +-
>   kernel/locking/lockdep.c    | 14 +++++++++++---
>   3 files changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
> index dbb409d77d4f..b45c89fadfe4 100644
> --- a/include/linux/debug_locks.h
> +++ b/include/linux/debug_locks.h
> @@ -48,7 +48,18 @@ extern int debug_locks_off(void);
>   #endif
>   
>   #ifdef CONFIG_LOCKDEP
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
>   extern void debug_show_held_locks(struct task_struct *task);
>   extern void debug_check_no_locks_freed(const void *from, unsigned long len);
>   extern void debug_check_no_locks_held(void);
> @@ -61,6 +72,10 @@ static inline void debug_show_held_locks(struct task_struct *task)
>   {
>   }
>   
> +static inline void debug_show_all_lock_holders(void)
> +{
> +}
> +
>   static inline void
>   debug_check_no_locks_freed(const void *from, unsigned long len)
>   {
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index bb2354f73ded..18e22bbb714f 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -205,7 +205,7 @@ static void check_hung_uninterruptible_tasks(unsigned long timeout)
>    unlock:
>   	rcu_read_unlock();
>   	if (hung_task_show_lock)
> -		debug_show_all_locks();
> +		debug_show_all_lock_holders();
>   
>   	if (hung_task_show_all_bt) {
>   		hung_task_show_all_bt = false;
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 64a13eb56078..7870f7e5c46b 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -55,6 +55,7 @@
>   #include <linux/rcupdate.h>
>   #include <linux/kprobes.h>
>   #include <linux/lockdep.h>
> +#include <linux/sched/debug.h>
>   
>   #include <asm/sections.h>
>   
> @@ -6485,7 +6486,7 @@ void debug_check_no_locks_held(void)
>   EXPORT_SYMBOL_GPL(debug_check_no_locks_held);
>   
>   #ifdef __KERNEL__
> -void debug_show_all_locks(void)
> +void __debug_show_all_locks(bool show_stack)
>   {
>   	struct task_struct *g, *p;
>   
> @@ -6493,12 +6494,19 @@ void debug_show_all_locks(void)
>   		pr_warn("INFO: lockdep is turned off.\n");
>   		return;
>   	}
> -	pr_warn("\nShowing all locks held in the system:\n");
> +	if (show_stack)
> +		pr_warn("\nShowing all threads with locks held in the system:\n");
> +	else
> +		pr_warn("\nShowing all locks held in the system:\n");
>   
>   	rcu_read_lock();
>   	for_each_process_thread(g, p) {
>   		if (!p->lockdep_depth)
>   			continue;
> +		if (p == current && p->lockdep_depth == 1)
> +			continue;
> +		if (show_stack)
> +			sched_show_task(p);
>   		lockdep_print_held_locks(p);
>   		touch_nmi_watchdog();
>   		touch_all_softlockup_watchdogs();
> @@ -6508,7 +6516,7 @@ void debug_show_all_locks(void)
>   	pr_warn("\n");
>   	pr_warn("=============================================\n\n");
>   }
> -EXPORT_SYMBOL_GPL(debug_show_all_locks);
> +EXPORT_SYMBOL_GPL(__debug_show_all_locks);
>   #endif
>   
>   /*
Acked-by: Waiman Long <longman@redhat.com>

