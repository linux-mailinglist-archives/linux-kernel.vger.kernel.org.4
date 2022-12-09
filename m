Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC364888D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLISlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiLISlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 13:41:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE98663CA;
        Fri,  9 Dec 2022 10:41:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3233062300;
        Fri,  9 Dec 2022 18:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFE7C433D2;
        Fri,  9 Dec 2022 18:41:46 +0000 (UTC)
Date:   Fri, 9 Dec 2022 13:41:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2] x86/mm/kmmio: Use rcu_read_lock_sched_notrace()
Message-ID: <20221209134144.04f33626@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

The mmiotrace tracer is "special". The purpose is to help reverse engineer
binary drivers by removing the memory allocated by the driver and when the
driver goes to access it, a fault occurs, the mmiotracer will record what
the driver was doing and then do the work on its behalf by single stepping
through the process.

But to achieve this ability, it must do some special things. One is to
take the rcu_read_lock() when the fault occurs, and then release it in the
breakpoint that is single stepping. This makes lockdep unhappy, as it
changes the state of RCU from within an exception that is not contained in
that exception, and we get a nasty splat from lockdep.

Instead, switch to rcu_read_lock_sched_notrace() as the RCU sched variant
has the same grace period as normal RCU. This is basically the same as
rcu_read_lock() but does not make lockdep complain about it.

Note, the preempt_disable() is still needed as it uses preempt_enable_no_resched().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20221206191229.813199661@goodmis.org
  (also called [PATCH 2/2] x86/mm/kmmio: Remove rcu_read_lock())

  - Instead of simply removing rcu_read_lock() call rcu_read_lock_sched_notrace()

 arch/x86/mm/kmmio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index edb486450158..853c49877c16 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -254,7 +254,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 	 * again.
 	 */
 	preempt_disable();
-	rcu_read_lock();
+	rcu_read_lock_sched_notrace();
 
 	faultpage = get_kmmio_fault_page(page_base);
 	if (!faultpage) {
@@ -323,7 +323,7 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 	return 1; /* fault handled */
 
 no_kmmio:
-	rcu_read_unlock();
+	rcu_read_unlock_sched_notrace();
 	preempt_enable_no_resched();
 	return ret;
 }
@@ -363,7 +363,7 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 	/* These were acquired in kmmio_handler(). */
 	ctx->active--;
 	BUG_ON(ctx->active);
-	rcu_read_unlock();
+	rcu_read_unlock_sched_notrace();
 	preempt_enable_no_resched();
 
 	/*
-- 
2.35.1

