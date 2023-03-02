Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB1C6A89E5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjCBT6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjCBT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E660C474D0
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1U46EmVNN9TnCO3B4brlRZe5YwAS3YvC6c1avL6o62U=;
        b=E6l68efT6omso5tbfgrByAF4g9A0Zve+auKMhKFOudl2Ov5osLZcTEDSZjFBxI9u4AkmzU
        9OBoTMGuBH/UwX1Vcw2GGJtnjMpQEE7KSltB2YH34Dna9084ObAYx1gbQNfv/PoXFu/BCz
        MFKnDsJ3EeTaxLLHi6oh0b3lCtCJyWJCvuSdz4g7whEd0CUtPBmgO4YdmPj6P8V3xdoDKm
        fZDX+6G3LtUeRcTwd/clkFGx4et8KAnBI2LZdsJQ9jIsxPisKUNggL7o7j3nLKH69DCOTw
        6yxvhhLovuMg4yL9e73yAou2uU4m3b0B+cmh/1bt8oSVBnd/XZ/E8WyL3ct/6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1U46EmVNN9TnCO3B4brlRZe5YwAS3YvC6c1avL6o62U=;
        b=Xdd82s+bmvpLoHZz1SKKV6YdK9jMrOoOnLvcaRY94voySdrwV8w00Tq++CjoESTFYKvg6f
        KPyZP4m/3kf2VODQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 10/18] printk: nobkl: Add emit function and callback functions for atomic printing
Date:   Thu,  2 Mar 2023 21:02:10 +0106
Message-Id: <20230302195618.156940-11-john.ogness@linutronix.de>
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

Implement an emit function for non-BKL consoles to output printk
messages. It utilizes the lockless printk_get_next_message() and
console_prepend_dropped() functions to retrieve/build the output
message. The emit function includes the required safety points to
check for handover/takeover and calls a new write_atomic callback
of the console driver to output the message. It also includes proper
handling for updating the non-BKL console sequence number.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |   8 +++
 kernel/printk/internal.h     |   9 +++
 kernel/printk/printk.c       |  12 ++--
 kernel/printk/printk_nobkl.c | 121 ++++++++++++++++++++++++++++++++++-
 4 files changed, 141 insertions(+), 9 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 0779757cb917..15f71ccfcd9d 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -250,10 +250,12 @@ struct printk_buffers;
  * @newseq:		The sequence number for progress
  * @prio:		Priority of the context
  * @pbufs:		Pointer to the text buffer for this context
+ * @dropped:		Dropped counter for the current context
  * @thread:		The acquire is printk thread context
  * @hostile:		Hostile takeover requested. Cleared on normal
  *			acquire or friendly handover
  * @spinwait:		Spinwait on acquire if possible
+ * @backlog:		Ringbuffer has pending records
  */
 struct cons_context {
 	struct console		*console;
@@ -266,9 +268,11 @@ struct cons_context {
 	unsigned int		spinwait_max_us;
 	enum cons_prio		prio;
 	struct printk_buffers	*pbufs;
+	unsigned long		dropped;
 	unsigned int		thread		: 1;
 	unsigned int		hostile		: 1;
 	unsigned int		spinwait	: 1;
+	unsigned int		backlog		: 1;
 };
 
 /**
@@ -310,6 +314,7 @@ struct cons_context_data;
  * @atomic_state:	State array for NOBKL consoles; real and handover
  * @atomic_seq:		Sequence for record tracking (32bit only)
  * @thread_pbufs:	Pointer to thread private buffer
+ * @write_atomic:	Write callback for atomic context
  * @pcpu_data:		Pointer to percpu context data
  */
 struct console {
@@ -337,6 +342,9 @@ struct console {
 	atomic_t		__private atomic_seq;
 #endif
 	struct printk_buffers	*thread_pbufs;
+
+	bool (*write_atomic)(struct console *con, struct cons_write_context *wctxt);
+
 	struct cons_context_data	__percpu *pcpu_data;
 };
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 15a412065327..13dd0ce23c37 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -133,3 +133,12 @@ struct printk_message {
 struct cons_context_data {
 	struct printk_buffers		pbufs;
 };
+
+#ifdef CONFIG_PRINTK
+
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_supress);
+void console_prepend_dropped(struct printk_message *pmsg,
+			     unsigned long dropped);
+
+#endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 21b31183ff2b..eab0358baa6f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -715,9 +715,6 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return len;
 }
 
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_supress);
-
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	atomic64_t seq;
@@ -2786,7 +2783,7 @@ static void __console_unlock(void)
  * If @pmsg->pbufs->outbuf is modified, @pmsg->outbuf_len is updated.
  */
 #ifdef CONFIG_PRINTK
-static void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
+void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 {
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
@@ -2818,7 +2815,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
 	pmsg->outbuf_len += len;
 }
 #else
-#define console_prepend_dropped(pmsg, dropped)
+static inline void console_prepend_dropped(struct printk_message *pmsg,
+					   unsigned long dropped) { }
 #endif /* CONFIG_PRINTK */
 
 /*
@@ -2840,8 +2838,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
  * of @pmsg are valid. (See the documentation of struct printk_message
  * for information about the @pmsg fields.)
  */
-static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
-				    bool is_extended, bool may_suppress)
+bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
+			     bool is_extended, bool may_suppress)
 {
 	static int panic_console_dropped;
 
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 3318a79a150a..5c591bced1be 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -317,7 +317,7 @@ static void cons_context_set_seq(struct cons_context *ctxt)
  * invalid. Caller has to reacquire the console.
  */
 #ifdef CONFIG_64BIT
-static bool __maybe_unused cons_seq_try_update(struct cons_context *ctxt)
+static bool cons_seq_try_update(struct cons_context *ctxt)
 {
 	struct console *con = ctxt->console;
 	struct cons_state old;
@@ -346,7 +346,7 @@ static bool __maybe_unused cons_seq_try_update(struct cons_context *ctxt)
 }
 #else
 static bool cons_release(struct cons_context *ctxt);
-static bool __maybe_unused cons_seq_try_update(struct cons_context *ctxt)
+static bool cons_seq_try_update(struct cons_context *ctxt)
 {
 	struct console *con = ctxt->console;
 	struct cons_state state;
@@ -1086,6 +1086,123 @@ bool console_exit_unsafe(struct cons_write_context *wctxt)
 	return __console_update_unsafe(wctxt, false);
 }
 
+/**
+ * cons_get_record - Fill the buffer with the next pending ringbuffer record
+ * @wctxt:	The write context which will be handed to the write function
+ *
+ * Returns:	True if there are records available. If the next record should
+ *		be printed, the output buffer is filled and @wctxt->outbuf
+ *		points to the text to print. If @wctxt->outbuf is NULL after
+ *		the call, the record should not be printed but the caller must
+ *		still update the console sequence number.
+ *
+ *		False means that there are no pending records anymore and the
+ *		printing can stop.
+ */
+static bool cons_get_record(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
+	struct printk_message pmsg = {
+		.pbufs = ctxt->pbufs,
+	};
+
+	if (!printk_get_next_message(&pmsg, ctxt->newseq, is_extended, true))
+		return false;
+
+	ctxt->newseq = pmsg.seq;
+	ctxt->dropped += pmsg.dropped;
+
+	if (pmsg.outbuf_len == 0) {
+		wctxt->outbuf = NULL;
+	} else {
+		if (ctxt->dropped && !is_extended)
+			console_prepend_dropped(&pmsg, ctxt->dropped);
+		wctxt->outbuf = &pmsg.pbufs->outbuf[0];
+	}
+
+	wctxt->len = pmsg.outbuf_len;
+
+	return true;
+}
+
+/**
+ * cons_emit_record - Emit record in the acquired context
+ * @wctxt:	The write context that will be handed to the write function
+ *
+ * Returns:	False if the operation was aborted (takeover or handover).
+ *		True otherwise
+ *
+ * When false is returned, the caller is not allowed to touch console state.
+ * The console is owned by someone else. If the caller wants to print more
+ * it has to reacquire the console first.
+ *
+ * When true is returned, @wctxt->ctxt.backlog indicates whether there are
+ * still records pending in the ringbuffer,
+ */
+static int __maybe_unused cons_emit_record(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	bool done = false;
+
+	/*
+	 * @con->dropped is not protected in case of hostile takeovers so
+	 * the update below is racy. Annotate it accordingly.
+	 */
+	ctxt->dropped = data_race(READ_ONCE(con->dropped));
+
+	/* Fill the output buffer with the next record */
+	ctxt->backlog = cons_get_record(wctxt);
+	if (!ctxt->backlog)
+		return true;
+
+	/* Safety point. Don't touch state in case of takeover */
+	if (!console_can_proceed(wctxt))
+		return false;
+
+	/* Counterpart to the read above */
+	WRITE_ONCE(con->dropped, ctxt->dropped);
+
+	/*
+	 * In case of skipped records, Update sequence state in @con.
+	 */
+	if (!wctxt->outbuf)
+		goto update;
+
+	/* Tell the driver about potential unsafe state */
+	wctxt->unsafe = ctxt->state.unsafe;
+
+	if (!ctxt->thread && con->write_atomic) {
+		done = con->write_atomic(con, wctxt);
+	} else {
+		cons_release(ctxt);
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* If not done, the write was aborted due to takeover */
+	if (!done)
+		return false;
+
+	/* If there was a dropped message, it has now been output. */
+	if (ctxt->dropped) {
+		ctxt->dropped = 0;
+		/* Counterpart to the read above */
+		WRITE_ONCE(con->dropped, ctxt->dropped);
+	}
+update:
+	ctxt->newseq++;
+	/*
+	 * The sequence update attempt is not part of console_release()
+	 * because in panic situations the console is not released by
+	 * the panic CPU until all records are written. On 32bit the
+	 * sequence is separate from state anyway.
+	 */
+	return cons_seq_try_update(ctxt);
+}
+
 /**
  * cons_nobkl_init - Initialize the NOBKL console specific data
  * @con:	Console to initialize
-- 
2.30.2

