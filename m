Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0E6AFC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCHBbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCHBba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:31:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9211EA0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A3E61602
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 01:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B9C433EF;
        Wed,  8 Mar 2023 01:31:23 +0000 (UTC)
Date:   Tue, 7 Mar 2023 20:31:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Wei Wang <wvw@google.com>,
        Midas Chien <midaschieh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Tony Luck <tony.luck@intel.com>, kernel-team@android.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] pstore: Revert pmsg_lock back to a normal mutex
Message-ID: <20230307203122.14b077c4@gandalf.local.home>
In-Reply-To: <20230302200136.381468f0@gandalf.local.home>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
        <20230302163253.541ac3a8@gandalf.local.home>
        <20230302163603.223313ba@gandalf.local.home>
        <20230302165613.2dcc18ca@gandalf.local.home>
        <20230302200136.381468f0@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Mar 2023 20:01:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -1421,11 +1425,23 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
>  		 *    for CONFIG_PREEMPT_RCU=y)
>  		 *  - the VCPU on which owner runs is preempted
>  		 */
> -		if (!owner_on_cpu(owner) || need_resched() ||
> -		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
> +		if (!owner_on_cpu(owner) || need_resched()) {
>  			res = false;
>  			break;
>  		}
> +		top_waiter = rt_mutex_top_waiter(lock);

rt_mutex_top_waiter() can not be called outside the wait_lock, as it may
trigger that BUG_ON() you saw.

New patch below.

> +		if (top_waiter != waiter) {
> +			if (top_waiter != last_waiter) {
> +				raw_spin_lock_irq(&lock->wait_lock);
> +				last_waiter = rt_mutex_top_waiter(lock);
> +				top_task = last_waiter->task;
> +				raw_spin_unlock_irq(&lock->wait_lock);
> +			}
> +			if (!owner_on_cpu(top_task)) {
> +				res = false;
> +				break;
> +			}
> +		}

-- Steve

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8abc2a..f7b0cc3be20e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1362,8 +1362,11 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter,
 				  struct task_struct *owner)
 {
+	struct rt_mutex_waiter *top_waiter = NULL;
+	struct task_struct *top_task = NULL;
 	bool res = true;
 
+	/* rcu_read_lock keeps task_structs around */
 	rcu_read_lock();
 	for (;;) {
 		/* If owner changed, trylock again. */
@@ -1384,11 +1387,22 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *    for CONFIG_PREEMPT_RCU=y)
 		 *  - the VCPU on which owner runs is preempted
 		 */
-		if (!owner_on_cpu(owner) || need_resched() ||
-		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
+		if (!owner_on_cpu(owner) || need_resched()) {
 			res = false;
 			break;
 		}
+		if (!rt_mutex_waiter_is_top_waiter(lock, waiter)) {
+			if (!rt_mutex_waiter_is_top_waiter(lock, top_waiter)) {
+				raw_spin_lock_irq(&lock->wait_lock);
+				top_waiter = rt_mutex_top_waiter(lock);
+				top_task = top_waiter->task;
+				raw_spin_unlock_irq(&lock->wait_lock);
+			}
+			if (!owner_on_cpu(top_task)) {
+				res = false;
+				break;
+			}
+		}
 		cpu_relax();
 	}
 	rcu_read_unlock();
@@ -1510,10 +1524,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 				break;
 		}
 
-		if (waiter == rt_mutex_top_waiter(lock))
-			owner = rt_mutex_owner(lock);
-		else
-			owner = NULL;
+		owner = rt_mutex_owner(lock);
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
@@ -1699,10 +1710,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 		if (try_to_take_rt_mutex(lock, current, &waiter))
 			break;
 
-		if (&waiter == rt_mutex_top_waiter(lock))
-			owner = rt_mutex_owner(lock);
-		else
-			owner = NULL;
+		owner = rt_mutex_owner(lock);
 		raw_spin_unlock_irq(&lock->wait_lock);
 
 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
