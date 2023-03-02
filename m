Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0371A6A89E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCBT6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2CF474E8
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2fMZu7G+YK9eneabidoKIltYZn7KfVS0Zt0k2ab0y0=;
        b=3nCVLeHqSTGTltSXJiVNkoE1q8fdIPyjeuYWyzSd4c7S1+AztCDDJIZRwc0oNa7iLmCJQm
        k1Er7/aw3qWpZ5X9i3hP/KFf5rWAlU1SVOB9NQiRAwwJFny8SQTVfRzkBeGk4Tk1GBEeL9
        +R6vWhYToMqDU/WTBI2pnHuRXnFZ8xwCV+0FIV1mnDERyiqPfG8Itln0C9xQM0Av/Kn8Ij
        jvbWmqO7Ukglg/lBmB3MTAUNFLn4gYrqvQlJwL3lw7+gFlvXL5UhB8rA42LBRfSdCmyyxI
        thEG1ez8IbCg8z+lLVV51R7KoWAVTGhI1v6bPzmDNeL4n+F36DR5mxSgxHQl9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2fMZu7G+YK9eneabidoKIltYZn7KfVS0Zt0k2ab0y0=;
        b=NbLLJtoEj1oiWEL7cz5tkc94m1maoG84ijey5UzBqQUkgzAHCQZ1fbPMsrx18wvdzgYufs
        BPYawCdSurW+GCBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 09/18] printk: nobkl: Add print state functions
Date:   Thu,  2 Mar 2023 21:02:09 +0106
Message-Id: <20230302195618.156940-10-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Provide three functions which are related to the safe handover
mechanism and allow console drivers to denote takeover unsafe
sections:

 - console_can_proceed()

   Invoked by a console driver to check whether a handover request
   is pending or whether the console was taken over in a hostile
   fashion.

 - console_enter/exit_unsafe()

   Invoked by a console driver to denote that the driver output
   function is about to enter or to leave an critical region where a
   hostile take over is unsafe. These functions are also
   cancellation points.

   The unsafe state is stored in the console state and allows a
   takeover attempt to make informed decisions whether to take over
   and/or output on such a console at all. The unsafe state is also
   available to the driver in the write context for the
   atomic_write() output function so the driver can make informed
   decisions about the required actions or take a special emergency
   path.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |   3 +
 kernel/printk/printk_nobkl.c | 139 +++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 942cc7f57798..0779757cb917 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -464,6 +464,9 @@ static inline bool console_is_registered(const struct console *con)
 	lockdep_assert_console_list_lock_held();			\
 	hlist_for_each_entry(con, &console_list, node)
 
+extern bool console_can_proceed(struct cons_write_context *wctxt);
+extern bool console_enter_unsafe(struct cons_write_context *wctxt);
+extern bool console_exit_unsafe(struct cons_write_context *wctxt);
 extern bool console_try_acquire(struct cons_write_context *wctxt);
 extern bool console_release(struct cons_write_context *wctxt);
 
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 7184a93a5b0d..3318a79a150a 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -947,6 +947,145 @@ static void cons_free_percpu_data(struct console *con)
 	con->pcpu_data = NULL;
 }
 
+/**
+ * console_can_proceed - Check whether printing can proceed
+ * @wctxt:	The write context that was handed to the write function
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
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ */
+bool console_can_proceed(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct cons_state state;
+
+	cons_state_read(con, CON_STATE_CUR, &state);
+	/* Store it for analysis or reuse */
+	copy_full_state(ctxt->old_state, state);
+
+	/* Make sure this context is still the owner. */
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
+	/*
+	 * A console printer within an unsafe region is allowed to continue.
+	 * It can perform the handover when exiting the safe region. Otherwise
+	 * a hostile takeover will be necessary.
+	 */
+	if (state.unsafe)
+		return true;
+
+	/* Release and hand over */
+	cons_release(ctxt);
+	/*
+	 * This does not check whether the handover succeeded. The
+	 * outermost callsite has to make the final decision whether printing
+	 * should continue or not (via reacquire, possibly hostile). The
+	 * console is unlocked already so go back all the way instead of
+	 * trying to implement heuristics in tons of places.
+	 */
+	return false;
+}
+
+/**
+ * __console_update_unsafe - Update the unsafe bit in @con->atomic_state
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before an unsafe driver section is entered.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
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
+	} while (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &ctxt->old_state, &new));
+
+	copy_full_state(ctxt->state, new);
+	return true;
+}
+
+/**
+ * console_enter_unsafe - Enter an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before an unsafe driver section is entered.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ */
+bool console_enter_unsafe(struct cons_write_context *wctxt)
+{
+	return __console_update_unsafe(wctxt, true);
+}
+
+/**
+ * console_exit_unsafe - Exit an unsafe region in the driver
+ * @wctxt:	The write context that was handed to the write function
+ *
+ * Returns:	True if the state is correct. False if a handover
+ *		has been requested or if the console was taken
+ *		over.
+ *
+ * Must be invoked before an unsafe driver section is exited.
+ *
+ * When this function returns false then the calling context is not allowed
+ * to go forward and has to back out immediately and carefully. The buffer
+ * content is no longer trusted either and the console lock is no longer
+ * held.
+ */
+bool console_exit_unsafe(struct cons_write_context *wctxt)
+{
+	return __console_update_unsafe(wctxt, false);
+}
+
 /**
  * cons_nobkl_init - Initialize the NOBKL console specific data
  * @con:	Console to initialize
-- 
2.30.2

