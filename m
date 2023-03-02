Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5F6A8B89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 23:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCBWMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 17:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCBWMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:12:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA50C15C8A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 14:12:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08BEA61629
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 21:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E528C433D2;
        Thu,  2 Mar 2023 21:32:55 +0000 (UTC)
Date:   Thu, 2 Mar 2023 16:32:53 -0500
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
Message-ID: <20230302163253.541ac3a8@gandalf.local.home>
In-Reply-To: <20230302152103.2618f1b7@gandalf.local.home>
References: <20230302062741.483079-1-jstultz@google.com>
        <20230302082414.77613351@gandalf.local.home>
        <CANDhNCo4ruC4pP+iDe49b3e1nAcWtYQj4bx82+oZhyLFYkdFJQ@mail.gmail.com>
        <20230302152103.2618f1b7@gandalf.local.home>
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

On Thu, 2 Mar 2023 15:21:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I could possibly add a patch, and see if that also works.

Can you try this patch to see if it improves the situation.

A few of things about this patch. It is lightly tested. It can be optimized
to cache the top waiter and not need to grab the spin lock and disable
interrupts for every loop, but right now I want to see if this improves the
situation. As when PREEMPT_RT becomes more mainline, we may need this.

Another thing I noticed is I think there's a bug in the existing code.


   CPU1					CPU2
   ----					----
rt_mutex_slowlock_block() {
  raw_spin_lock_irq(wait_lock);
  owner = rt_mutex_owner();
  raw_spin_unlock_irq(wait_lock);

  rtmutex_spin_on_owner(owner) {
    owner = rt_mutex_owner();

    [ task preempted! (could also be a long interrupt) ]

				   owner releases lock and exits
				   owner is freed

    [ task resumes ]

    if (!owner_on_cpu(owner)

      READ_ONCE(owner->on_cpu)
     *** BOOM invalid pointer dereference ***

I think we need a get_task_struct() somewhere there.

Anyway, that's another issue. Could you try this patch? I even added a
trace_printk() in there to see if it gets hit.

Thanks!

-- Steve

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 010cf4e6d0b8..6c602775bb23 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1399,6 +1399,7 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter,
 				  struct task_struct *owner)
 {
+	struct rt_mutex_waiter *top_waiter;
 	bool res = true;
 
 	rcu_read_lock();
@@ -1421,11 +1422,25 @@ static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
 		 *    for CONFIG_PREEMPT_RCU=y)
 		 *  - the VCPU on which owner runs is preempted
 		 */
-		if (!owner_on_cpu(owner) || need_resched() ||
-		    !rt_mutex_waiter_is_top_waiter(lock, waiter)) {
+		if (!owner_on_cpu(owner) || need_resched()) {
 			res = false;
 			break;
 		}
+		top_waiter = rt_mutex_top_waiter(lock);
+		if (top_waiter != waiter) {
+			raw_spin_lock_irq(&lock->wait_lock);
+			top_waiter = rt_mutex_top_waiter(lock);
+			if (top_waiter && top_waiter != waiter) {
+				trace_printk("spin on waiter! %s:%d\n",
+					     top_waiter->task->comm,
+					     top_waiter->task->pid);
+				if (!owner_on_cpu(top_waiter->task))
+					res = false;
+			}
+			raw_spin_unlock_irq(&lock->wait_lock);
+			if (!res)
+				break;
+		}
 		cpu_relax();
 	}
 	rcu_read_unlock();
