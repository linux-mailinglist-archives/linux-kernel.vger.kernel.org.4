Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E25EC71F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiI0PBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiI0PBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:01:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E61386B3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:01:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664290862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfZ+y69S5Kb6ArHkND0xlOW2EnHlhDe1FMbMze0LBBQ=;
        b=Ii6hF6qF8w+fRxRAgYIBtzio+KSO0fe/zm/v8cHxw9fUVrGYeixR3o/jrBcTRX2tSfG0vI
        1K6qGC6X0GV+9MRpLj+aLAuOZqimMsQO5bGYy9JEgLNoeGb/4MNCZNaGGR0MvLyhpDpUG/
        gnuKTWJsAWNViqkUlRzqXrzQ2NXsJq6GKjbhtmIgSapjiVRvuvHLg7jXN2KIDgt2Y2NgZu
        7sNpTIHAW11FOinNuW92deVTCL7EvPY3BlybuNjpD3qaOX6RQ6WqdzDnNXYsW1REgMG134
        53+CizBn50RkvI0VJBfEqgNnIRqsMYIbvtSqRIEH7S8yC0aK7wI7EgSB0XqE6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664290862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfZ+y69S5Kb6ArHkND0xlOW2EnHlhDe1FMbMze0LBBQ=;
        b=OtXIekqyobgL1MWBktr1iN8hT1pbL41ESmwtWuVMphwz4bDgsmJJw+T+IG8NOBgdxXR/c0
        RwBes69CRQd8kTAg==
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [patch RFC 28/29] printk: Provide functions for atomic write
 enforcement
In-Reply-To: <20220910222301.995758602@linutronix.de>
References: <20220910221947.171557773@linutronix.de>
 <20220910222301.995758602@linutronix.de>
Date:   Tue, 27 Sep 2022 17:07:01 +0206
Message-ID: <87h70slv4i.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a fix that was used for the LPC2022 demo to avoid unnecessarily
performing the console_lock/console_unlock dance.

Add a new global boolean @have_bkl_console to be able to quickly
identify if any legacy (bkl) consoles are registered. If there are none,
the console_lock/console_unlock stuff can be skipped. The following
patch does this and can be applied on top.

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1830,6 +1830,7 @@ static struct lockdep_map console_owner_dep_map = {
 static DEFINE_RAW_SPINLOCK(console_owner_lock);
 static struct task_struct *console_owner;
 static bool console_waiter;
+static bool have_bkl_console;
 
 /**
  * console_lock_spinning_enable - mark beginning of code where another
@@ -2285,7 +2286,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	cons_atomic_flush();
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && have_bkl_console) {
 		/*
 		 * Try to acquire and then immediately release the console
 		 * semaphore. The release will print out buffers. With the
@@ -2575,7 +2576,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && have_bkl_console) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -3023,6 +3024,9 @@ void console_unblank(void)
 {
 	struct console *c;
 
+	if (!have_bkl_console)
+		return;
+
 	/*
 	 * console_unblank can no longer be called in interrupt context unless
 	 * oops_in_progress is set to 1..
@@ -3052,6 +3056,9 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	if (!have_bkl_console)
+		return;
+
 	/*
 	 * If someone else is holding the console lock, trylock will fail
 	 * and may_schedule may be set.  Ignore and proceed to unlock so
@@ -3311,6 +3318,10 @@ void register_console(struct console *newcon)
 	/* Initialize the nobkl data in @newcon */
 	cons_nobkl_init(newcon);
 
+	/* Has a legacy (BKL) console registered? */
+	if (!(newcon->flags & CON_NO_BKL))
+		have_bkl_console = true;
+
 	/*
 	 * Put this console in the list and keep the referred driver at the
 	 * head of the list.
@@ -3603,7 +3613,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = this_cpu_xchg(printk_pending, 0);
 
-	if (pending & PRINTK_PENDING_OUTPUT) {
+	if (have_bkl_console && (pending & PRINTK_PENDING_OUTPUT)) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();

John Ogness
