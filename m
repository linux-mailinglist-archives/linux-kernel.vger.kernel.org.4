Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB55B4A89
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiIJWaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIJW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6E3459A7
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:13 -0700 (PDT)
Message-ID: <20220910222301.824778546@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1nKppJo7BxmMJFXIfi8EoIqbK71Dxa8Haxjpt9z15Tk=;
        b=g5J80fbLvcjgxTYMH/kc3+rSHiZf9tIk3s1vdHkcLgJfjdFUugd9s6TV48/9SOtc9JpDkt
        JH9SnrWIBdUlbFCU8akBmSuSm+UVdI2Ilcj3RR6Quevp2Y0s+e5R64MlVFaliyhsySXYn3
        UAOCpzcmYFLYcCZYZTI2nah7UYOqhi8j2t7JtKoa2ZGm59htiRxPx+eXccSdCY0TiViJLm
        TaFChIZ+cm5SKeb0vCA2yuOG1WQYx4uYVFbFAadgDMQKu3Wyz3vOm74/TSErGk0Xa0klF8
        9SR5MwBtyqSJXVYrAgzTBsrD82FZoGKnXqQgAvVpL526/XnSOU45qrfcctQApg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1nKppJo7BxmMJFXIfi8EoIqbK71Dxa8Haxjpt9z15Tk=;
        b=MCwdSrA92NhXmAsBZe8KYswZIlVESP+CVhdL4sdzlA3yE2+ZjhM71Dlvjcj5X2Kxip1pqr
        Kwv8Zv3ZsX3pnhAg==
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
Subject: [patch RFC 25/29] printk: Provide functions to emit a ringbuffer
 record on non-BKL consoles
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:10 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Utilize the shared fill function and add the required safety points to
check for handover/takeover and invoke the atomic write function of the
console driver. Add the proper handling for updating the sequence number.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |    7 ++
 kernel/printk/printk_nobkl.c |  107 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 2 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -281,10 +281,12 @@ struct console;
  * @newseq:		The sequence number for progress
  * @prio:		Priority of the context
  * @txtbuf:		Pointer to the text buffer for this context
+ * @dropped:		Dropped counter for the current context
  * @thread:		The acquire is printk thread context
  * @hostile:		Hostile takeover requested. Cleared on normal
  *			acquire or friendly handover
  * @spinwait:		Spinwait on acquire if possible
+ * @backlog:		Ringbuffer has pending records
  */
 struct cons_context {
 	struct console		*console;
@@ -297,9 +299,11 @@ struct cons_context {
 	unsigned int		spinwait_max_us;
 	enum cons_prio		prio;
 	struct cons_text_buf	*txtbuf;
+	unsigned long		dropped;
 	unsigned int		thread		: 1;
 	unsigned int		hostile		: 1;
 	unsigned int		spinwait	: 1;
+	unsigned int		backlog		: 1;
 };
 
 /**
@@ -380,6 +384,9 @@ struct console {
 #ifndef CONFIG_64BIT
 	atomic_t __private	atomic_seq;
 #endif
+
+	bool (*write_atomic)(struct console *con, struct cons_write_context *wctxt);
+
 	struct cons_context_data __percpu	*pcpu_data;
 	struct cons_context_data		ctxt_data;
 };
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -328,7 +328,7 @@ static void cons_context_sequence_init(s
  * invalid. Caller has to reacquire the console.
  */
 #ifdef CONFIG_64BIT
-static bool __maybe_unused cons_sequence_try_update(struct cons_context *ctxt)
+static bool cons_sequence_try_update(struct cons_context *ctxt)
 {
 	struct console *con = ctxt->console;
 	struct cons_state old, new;
@@ -354,7 +354,7 @@ static bool __maybe_unused cons_sequence
 	return true;
 }
 #else
-static bool __maybe_unused cons_sequence_try_update(struct cons_context *ctxt)
+static bool cons_sequence_try_update(struct cons_context *ctxt)
 {
 	struct console *con = ctxt->console;
 	unsigned long old, new, cur;
@@ -1006,6 +1006,109 @@ bool console_exit_unsafe(struct cons_wri
 	return __console_update_unsafe(wctxt, false);
 }
 
+static bool cons_fill_outbuf(struct cons_outbuf_desc *desc);
+
+/**
+ * cons_get_record - Fill the buffer with the next pending ringbuffer record
+ * @wctxt:	The write context which will be handed to the write function
+ *
+ * Returns:	True if there are records to print. If the output buffer is
+ *		filled @wctxt->outbuf points to the text, otherwise it is NULL.
+ *
+ *		False signals that there are no pending records anymore and
+ *		the printing can stop.
+ */
+static bool cons_get_record(struct cons_write_context *wctxt)
+{
+	struct cons_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct cons_outbuf_desc desc = {
+		.txtbuf		= ctxt->txtbuf,
+		.extmsg		= con->flags & CON_EXTENDED,
+		.seq		= ctxt->newseq,
+		.dropped	= ctxt->dropped,
+	};
+	bool progress = cons_fill_outbuf(&desc);
+
+	ctxt->newseq = desc.seq;
+	ctxt->dropped = desc.dropped;
+
+	wctxt->pos = 0;
+	wctxt->len = desc.len;
+	wctxt->outbuf = desc.outbuf;
+	return progress;
+}
+
+/**
+ * cons_emit_record - Emit record in the acquired context
+ * @wctxt:	The write context which will be handed to the write function
+ *
+ * Returns:	False if the operation was aborted (takeover)
+ *		True otherwise
+ *
+ * In case of takeover the caller is not allowed to touch console state.
+ * The console is owned by someone else. If the caller wants to print
+ * more it has to reacquire the console first.
+ *
+ * If it returns true @wctxt->ctxt.backlog indicates whether there are
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
+	ctxt->newseq++;
+update:
+	/*
+	 * The sequence update attempt is not part of console_release()
+	 * because in panic situations the console is not released by
+	 * the panic CPU until all records are written. On 32bit the
+	 * sequence is seperate from state anyway.
+	 */
+	return cons_sequence_try_update(ctxt);
+}
+
 /**
  * cons_nobkl_init - Initialize the NOBKL console state
  * @con:	Console to initialize

