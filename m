Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F9A5B4A8C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiIJW3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiIJW2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8C945040
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:28:07 -0700 (PDT)
Message-ID: <20220910222301.597440803@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yRyMpUYT+kmNyPrU5TuOkxnIPqW5hmLjaAM5Dx5YUoo=;
        b=1A7aaJDo5ez7UQG931AM8p7H8p6BWjG63SKE1+1TPnXaVDmopf1Esy9YgKCz9z7VQ2KHu/
        w9Wctya/3qu04CV3Y/iPRYP9JGm+1hkaTUItnJfB7gUrChLs9TU5+is8FhwZ5SGAtcD1Wo
        L3aqmnQa5uy+FuHnc4mhLsBV2nialmlPvXnddzylyWy5JAcwRyC/p8rYptlRL+BGnDBn6u
        Qk1h+dmGIMVQJysK6VcJDUmLxbSRWV9yJvyQtZQIAfbR3beT0cvCzek/Dgjte5IDAdzt/J
        E3hry0isBo7OT+0tP+wM8/wI6oFV4kLcSUHIXyPGuv9HKse+UsdvM8Lpyvwd9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yRyMpUYT+kmNyPrU5TuOkxnIPqW5hmLjaAM5Dx5YUoo=;
        b=J6KUbzvZVvtdwgZ9oumV19NJwy3XtkgtPj+dhTtWS+2XytNviPsASH/b9X/AaSxZWx6yEf
        N0mJYDKrvnmoTQCQ==
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
Subject: [patch RFC 21/29] printk: Add buffer management for noBKL consoles
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:28:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of hostile takeovers it must be ensured that the previous owner
cannot scribble over the output buffer of the emergency/panic context. This
is achieved by:

 - Allocating per CPU output buffers per console and add the required handling
   into the acquire/release functions.

 - Adding a single instance to struct console for early boot (pre per CPU
   data being available). The builtin instance is also used for threaded
   printing once printer threads become available.

Wrapped into a seperate data structure so other context related fields can
be added in later steps.

Co-Developed-by: John Ogness <jogness@linutronix.de>
Signed-off-by: John Ogness <jogness@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h      |   21 ++++++++++++-
 kernel/printk/printk.c       |   18 ++++++++---
 kernel/printk/printk_nobkl.c |   69 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+), 6 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -276,6 +276,7 @@ struct console;
  * @req_state:		The request state for spin and cleanup
  * @spinwait_max_us:	Limit for spinwait acquire
  * @prio:		Priority of the context
+ * @txtbuf:		Pointer to the text buffer for this context
  * @thread:		The acquire is printk thread context
  * @hostile:		Hostile takeover requested. Cleared on normal
  *			acquire or friendly handover
@@ -289,11 +290,25 @@ struct cons_context {
 	struct cons_state	req_state;
 	unsigned int		spinwait_max_us;
 	enum cons_prio		prio;
+	struct cons_text_buf	*txtbuf;
 	unsigned int		thread		: 1;
 	unsigned int		hostile		: 1;
 	unsigned int		spinwait	: 1;
 };
 
+#define CONS_MAX_NEST_LVL	8
+
+/**
+ * struct cons_context_data - console context data
+ * @txtbuf:		Buffer for storing the text
+ *
+ * Used for early boot embedded into struct console and for
+ * per CPU data.
+ */
+struct cons_context_data {
+	struct cons_text_buf		txtbuf;
+};
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -315,6 +330,8 @@ struct cons_context {
  * @node:		hlist node for the console list
  *
  * @atomic_state:	State array for non-BKL consoles. Real and handover
+ * @pcpu_data:		Pointer to percpu context data
+ * @ctxt_data:		Builtin context data for early boot and threaded printing
  */
 struct console {
 	char			name[16];
@@ -336,8 +353,10 @@ struct console {
 	struct hlist_node	node;
 
 	/* NOBKL console specific members */
-	atomic_long_t __private	atomic_state[2];
+	atomic_long_t __private		atomic_state[2];
 
+	struct cons_context_data __percpu	*pcpu_data;
+	struct cons_context_data		ctxt_data;
 };
 
 #ifdef CONFIG_LOCKDEP
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1071,9 +1071,17 @@ static void __init log_buf_add_cpu(void)
 static inline void log_buf_add_cpu(void) {}
 #endif /* CONFIG_SMP */
 
+static void cons_alloc_percpu_data(struct console *con);
+
 static void __init set_percpu_data_ready(void)
 {
+	struct console *con;
+
+	console_list_lock();
+	for_each_registered_console(con)
+		cons_alloc_percpu_data(con);
 	__printk_percpu_data_ready = true;
+	console_list_unlock();
 }
 
 static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
@@ -2341,6 +2349,11 @@ static bool __pr_flush(struct console *c
 
 #endif /* !CONFIG_PRINTK */
 
+#define con_printk(lvl, con, fmt, ...)			\
+	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),	\
+	       (con->flags & CON_BOOT) ? "boot" : "",	\
+	       con->name, con->index, ##__VA_ARGS__)
+
 #include "printk_nobkl.c"
 
 #ifdef CONFIG_EARLY_PRINTK
@@ -3191,11 +3204,6 @@ static void try_enable_default_console(s
 		newcon->flags |= CON_CONSDEV;
 }
 
-#define con_printk(lvl, con, fmt, ...)			\
-	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),	\
-	       (con->flags & CON_BOOT) ? "boot" : "",	\
-	       con->name, con->index, ##__VA_ARGS__)
-
 #define cons_first()					\
 	hlist_entry(console_list.first, struct console, node)
 
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -207,6 +207,43 @@ static inline bool cons_check_panic(void
 }
 
 /**
+ * cons_context_set_text_buf - Set the output text buffer for the current context
+ * @ctxt:	Pointer to the aquire context
+ *
+ * Buffer selection:
+ *   1) Early boot uses the console builtin buffer
+ *   2) Threads use the console builtin buffer
+ *   3) All other context use the per CPU buffers
+ *
+ * This guarantees that there is no concurrency on the output records
+ * ever. Per CPU nesting is not a problem at all. The takeover logic
+ * tells the interrupted context that the buffer has been overwritten.
+ *
+ * There are two critical regions which matter:
+ *
+ * 1) Context is filling the buffer with a record. After interruption
+ *    it continues to sprintf() the record and before it goes to
+ *    write it out, it checks the state, notices the takeover, discards
+ *    the content and backs out.
+ *
+ * 2) Context is in a unsafe critical region in the driver. After
+ *    interruption it might read overwritten data from the output
+ *    buffer. When it leaves the critical region it notices and backs
+ *    out. Hostile takeovers in driver critical regions are best effort
+ *    and there is not much which can be done about that.
+ */
+static void cons_context_set_text_buf(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+
+	/* Early boot or allocation fail? */
+	if (!con->pcpu_data)
+		ctxt->txtbuf = &con->ctxt_data.txtbuf;
+	else
+		ctxt->txtbuf = &(this_cpu_ptr(con->pcpu_data)->txtbuf);
+}
+
+/**
  * cons_cleanup_handover - Cleanup a handover request
  * @ctxt:	Pointer to acquire context
  *
@@ -482,6 +519,7 @@ static bool __cons_try_acquire(struct co
 		return false;
 success:
 	/* Common updates on success */
+	cons_context_set_text_buf(ctxt);
 	return true;
 
 check_hostile:
@@ -610,6 +648,35 @@ static bool __maybe_unused cons_release(
 }
 
 /**
+ * cons_alloc_percpu_data - Allocate percpu data for a console
+ * @con:	Console to allocate for
+ */
+static void cons_alloc_percpu_data(struct console *con)
+{
+	if (!printk_percpu_data_ready())
+		return;
+
+	con->pcpu_data = alloc_percpu(typeof(*con->pcpu_data));
+	if (con->pcpu_data)
+		return;
+
+	con_printk(KERN_WARNING, con, "Failed to allocate percpu buffers\n");
+}
+
+/**
+ * cons_free_percpu_data - Free percpu data of a console on unregister
+ * @con:	Console to clean up
+ */
+static void cons_free_percpu_data(struct console *con)
+{
+	if (!con->pcpu_data)
+		return;
+
+	free_percpu(con->pcpu_data);
+	con->pcpu_data = NULL;
+}
+
+/**
  * cons_nobkl_init - Initialize the NOBKL console state
  * @con:	Console to initialize
  */
@@ -620,6 +687,7 @@ static void cons_nobkl_init(struct conso
 		.enabled = !!(con->flags & CON_ENABLED),
 	};
 
+	cons_alloc_percpu_data(con);
 	cons_state_set(con, STATE_REAL, &state);
 }
 
@@ -632,6 +700,7 @@ static void cons_nobkl_cleanup(struct co
 	struct cons_state state = { };
 
 	cons_state_set(con, STATE_REAL, &state);
+	cons_free_percpu_data(con);
 }
 
 #else /* CONFIG_PRINTK */

