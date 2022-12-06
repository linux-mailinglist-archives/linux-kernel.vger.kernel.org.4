Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721D644C47
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 20:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiLFTMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 14:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiLFTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 14:12:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C73B1F;
        Tue,  6 Dec 2022 11:12:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56EB9B81B2A;
        Tue,  6 Dec 2022 19:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B3FC433D6;
        Tue,  6 Dec 2022 19:12:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p2dMj-0004RL-33;
        Tue, 06 Dec 2022 14:12:29 -0500
Message-ID: <20221206191229.813199661@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Dec 2022 14:12:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/2] x86/mm/kmmio: Remove rcu_read_lock()
References: <20221206191201.217838841@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

But to achieve this ability, it must do some special things. One is it
take the rcu_read_lock() when the fault occurs, and then release it in the
breakpoint that in the single stepping. This makes lockdep unhappy, as it
changes the state of RCU from within an exception that is not contained in
that exception, and we get a nasty splat from lockdep.

As it also disables preemption everywhere rcu_read_lock() is taken, and
enables preemption everywhere rcu_read_unlock(), and does not enable
preemption in between, it is the same as synchronize_rcu_sched(). But as
the RCU sched variant has the same grace period as normal RCU, there's no
reason to take the rcu_read_lock(). Simply remove it.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86/mm/kmmio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index edb486450158..e15e3aaaf94c 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -254,7 +254,6 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 	 * again.
 	 */
 	preempt_disable();
-	rcu_read_lock();
 
 	faultpage = get_kmmio_fault_page(page_base);
 	if (!faultpage) {
@@ -323,7 +322,6 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 	return 1; /* fault handled */
 
 no_kmmio:
-	rcu_read_unlock();
 	preempt_enable_no_resched();
 	return ret;
 }
@@ -363,7 +361,6 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 	/* These were acquired in kmmio_handler(). */
 	ctx->active--;
 	BUG_ON(ctx->active);
-	rcu_read_unlock();
 	preempt_enable_no_resched();
 
 	/*
-- 
2.35.1


