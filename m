Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F285B4A96
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiIJWaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiIJW2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8EE4506B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:10 -0700 (PDT)
Message-ID: <20220910222301.710939648@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NoR5hNciBAMmxWbbiSpzU3uPg8Vew2ti+A3f4lzSUQ0=;
        b=yNNXbj8a/j3A9TY1ZHo2z5SgqvWreIKreHIaMzHIe2PvsxuYEFagUD3rNVp/9RfqUskxex
        a3ud3ZiZnKpHt0Zaos5RRB9nPHCemBvchJ6ATLPYUIcZvDAtGfi3cCiIu5RKtOdYHee8U0
        LFnJ+LNXeQ/7/K9LR9impGjmX6pQ53XHkiUqDPuSasAr22g/ADp8YwgtAGzlZ6/YDyMNyG
        aKxhst2iWR9OaFic4M1YZTWBzt8qHNe5PM5sb/4RWieBLn61BOTa6OnkV5EMSXDHKNq/5k
        fkYGaFSK6ECCdToUK6NY8aTLS+Z5f2nrMHtL/BCIDihy94a5f9yZmMfwTZOuRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NoR5hNciBAMmxWbbiSpzU3uPg8Vew2ti+A3f4lzSUQ0=;
        b=DlTb6LDsL6x3MKInZGhzoseEIEsULkMOi1PDfI8o49hVdTECfkOsJ7EGgj23aBoF+ZyO+6
        5QctIlp+4Da7xyBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Ogness <jogness@linutronix.de>
Subject: [patch RFC 23/29] printk: Add non-BKL console print state functions
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:07 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide three functions which are related to the safe handover mechanism
and allow console drivers to denote takeover unsafe sections:

 - console_can_proceed()

   Invoked by a console driver to check whether a handover request is pending
   or whether the console was taken over in a hostile fashion.

 - console_enter/exit_unsafe()

   Invoked by a console driver to reflect that the driver output function is
   about to enter or to leave an critical region where a hostile take over
   is unsafe. These functions are also cancelation points.

   The unsafe state is reflected in the console state and allows a takeover
   attempt to make informed decisions whether to take over and/or output on
   such console at all. The unsafe state is also reflected on output to the
   driver in the write context to the atomic_write() output function so the
   driver can make informed decisions about the required actions or take an
   special emergency path.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |   20 ++++++
 kernel/printk/printk_nobkl.c |  134 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -300,6 +300,22 @@ struct cons_context {
 	unsigned int		spinwait	: 1;
 };
 
+/**
+ * struct cons_write_context - Context handed to the write callbacks
+ * @ctxt:	The core console context
+ * @outbuf:	Pointer to the text buffer for output
+ * @len:	Length to write
+ * @pos:	Current write position in @outbuf
+ * @unsafe:	Invoked in unsafe state due to force takeover
+ */
+struct cons_write_context {
+	struct cons_context __private	ctxt;
+	char				*outbuf;
+	unsigned int			len;
+	unsigned int			pos;
+	bool				unsafe;
+};
+
 #define CONS_MAX_NEST_LVL	8
 
 /**
@@ -423,6 +439,10 @@ extern void console_list_unlock(void) __
 #define for_each_console_kgdb(con)					\
 	hlist_for_each_entry(con, &console_list, node)
 
+extern bool console_can_proceed(struct cons_write_context *wctxt);
+extern bool console_enter_unsafe(struct cons_write_context *wctxt);
+extern bool console_exit_unsafe(struct cons_write_context *wctxt);
+
 extern int console_set_on_cmdline;
 extern struct console *early_console;
 
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -874,6 +874,140 @@ static void cons_free_percpu_data(struct
 }
 
 /**
+ * console_can_proceed - Check whether printing can proceed
+ * @wctxt:	The write context which was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked after the record was dumped into the assigned record
+ * buffer and at appropriate safe places in the driver.  For unsafe driver
+ * sections see console_enter_unsafe().
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully.  The buffer
+ * content is not longer trusted either and the console lock is not longer
+ * held.
+ */
+bool console_can_proceed(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct cons_state state;
+
+	cons_state_read(con, STATE_REAL, &state);
+	/* Store it for analyis or reuse */
+	copy_full_state(ctxt->old_state, state);
+
+	/*
+	 * If the state aside of req_prio is not longer matching, console
+	 * was taken over.
+	 */
+	if (!cons_state_full_match(state, ctxt->state))
+		return false;
+
+	/*
+	 * Having a safe point for take over and eventually a few
+	 * duplicated characters or a full line is way better than a
+	 * hostile takeover. Post processing can take care of the garbage.
+	 * Continue if the requested priority is not sufficient.
+	 */
+	if (state.req_prio <= state.cur_prio)
+		return true;
+
+	/* Release and hand over */
+	cons_release(ctxt);
+	/*
+	 * This does not check whether the handover succeeded. The
+	 * outermost callsite has to do the final check whether printing
+	 * should continue or not. The console is unlocked already so go
+	 * back all the way instead of trying to implement heuristics in
+	 * tons of places.
+	 */
+	return false;
+}
+
+/**
+ * __console_update_unsafe - Update the unsafe bit in @con->atomic_state
+ * @wctxt:	The write context which was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before a unsafe driver section is entered.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully.  The buffer
+ * content is not longer trusted either and the console lock is not longer
+ * held.
+ *
+ * Internal helper to avoid duplicated code
+ */
+static bool __console_update_unsafe(struct cons_write_context *wctxt, bool unsafe)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct cons_state new;
+
+	do  {
+		if (!console_can_proceed(wctxt))
+			return false;
+		/*
+		 * console_can_proceed() saved the real state in
+		 * ctxt->old_state
+		 */
+		copy_full_state(new, ctxt->old_state);
+		new.unsafe = unsafe;
+
+	} while (!cons_state_try_cmpxchg(con, STATE_REAL, &ctxt->old_state, &new));
+
+	copy_full_state(ctxt->state, new);
+	return true;
+}
+
+/**
+ * console_enter_unsafe - Enter an unsafe region in the driver
+ * @wctxt:	The write context which was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before a unsafe driver section is entered.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully.  The buffer
+ * content is not longer trusted either and the console lock is not longer
+ * held.
+ */
+bool console_enter_unsafe(struct cons_write_context *wctxt)
+{
+	return __console_update_unsafe(wctxt, true);
+}
+
+/**
+ * console_exit_unsafe - Exit an unsafe region in the driver
+ * @wctxt:	The write context which was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before a unsafe driver section is exited.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully.  The buffer
+ * content is not longer trusted either and the console lock is not longer
+ * held.
+ */
+bool console_exit_unsafe(struct cons_write_context *wctxt)
+{
+	return __console_update_unsafe(wctxt, false);
+}
+
+/**
  * cons_nobkl_init - Initialize the NOBKL console state
  * @con:	Console to initialize
  */

