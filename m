Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71F64A444
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiLLPhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbiLLPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:37:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07251B4BD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:37:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971A961122
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E1DC433EF;
        Mon, 12 Dec 2022 15:37:05 +0000 (UTC)
Date:   Mon, 12 Dec 2022 10:37:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] x86/mm/kmmio: Remove redundant preempt_disable()
Message-ID: <20221212103703.7129cc5d@gandalf.local.home>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Now that kmmio uses rcu_read_lock_sched_notrace() there's no reason to
call preempt_disable() as the read_lock_sched_notrace() already does that
and is redundant.

This also removes the preempt_enable_no_resched() as the "no_resched()"
portion was bogus as there's no reason to do that.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/mm/kmmio.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/mm/kmmio.c b/arch/x86/mm/kmmio.c
index 853c49877c16..9f82019179e1 100644
--- a/arch/x86/mm/kmmio.c
+++ b/arch/x86/mm/kmmio.c
@@ -246,14 +246,13 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 	page_base &= page_level_mask(l);
 
 	/*
-	 * Preemption is now disabled to prevent process switch during
-	 * single stepping. We can only handle one active kmmio trace
+	 * Hold the RCU read lock over single stepping to avoid looking
+	 * up the probe and kmmio_fault_page again. The rcu_read_lock_sched()
+	 * also disables preemption and prevents process switch during
+	 * the single stepping. We can only handle one active kmmio trace
 	 * per cpu, so ensure that we finish it before something else
-	 * gets to run. We also hold the RCU read lock over single
-	 * stepping to avoid looking up the probe and kmmio_fault_page
-	 * again.
+	 * gets to run.
 	 */
-	preempt_disable();
 	rcu_read_lock_sched_notrace();
 
 	faultpage = get_kmmio_fault_page(page_base);
@@ -324,7 +323,6 @@ int kmmio_handler(struct pt_regs *regs, unsigned long addr)
 
 no_kmmio:
 	rcu_read_unlock_sched_notrace();
-	preempt_enable_no_resched();
 	return ret;
 }
 
@@ -364,7 +362,6 @@ static int post_kmmio_handler(unsigned long condition, struct pt_regs *regs)
 	ctx->active--;
 	BUG_ON(ctx->active);
 	rcu_read_unlock_sched_notrace();
-	preempt_enable_no_resched();
 
 	/*
 	 * if somebody else is singlestepping across a probe point, flags
-- 
2.35.1

