Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAFE6A89E6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjCBT6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCBT5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA73474E3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBDHpobBKXIM6RJKVOV/6OUdGKuVSr8Ny7FvUBSWgMA=;
        b=F9jgTIjau6FlbBvAkNBAGqExHf6rP9l0Bsbra3pCuqLciyr5U+3sOKcR51Ys9BhohKzDOQ
        ygTHyVdbpUkccUIHtIZwiNJBR7CRy185ReNC5jiv8b3yWb078Mc+SzsAUmTqoSMlL7IBvx
        7PSK2aA0AF+NsP6S2+n8gXAiXCihcyot56X84mk6Yrvf1u+aWcBQt+KeM4ElObelskrxTx
        fmoHE9Wjrb2fkoAPGBiDjyBVKvvRPKJMeXeGjchOVIihMvdIC2RN+1gpz9MsCRGpTdvZiC
        CxY4KqUCr86w9O7aetoqTk1zKJam1pU8Io//5zEnL5KPOWmdnTZ9hRJO1g7tYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBDHpobBKXIM6RJKVOV/6OUdGKuVSr8Ny7FvUBSWgMA=;
        b=z9Uc4xrA3/WMTHj6hBOSc63s19KRlMAU+WpRllEa+ErDvhMF4h2f4M86PATw2yLy6iblRu
        aBBusNS+sInwIrBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 07/18] printk: nobkl: Add buffer management
Date:   Thu,  2 Mar 2023 21:02:07 +0106
Message-Id: <20230302195618.156940-8-john.ogness@linutronix.de>
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

In case of hostile takeovers it must be ensured that the previous
owner cannot scribble over the output buffer of the emergency/panic
context. This is achieved by:

 - Adding a global output buffer instance for early boot (pre per CPU
   data being available).

 - Allocating an output buffer per console for threaded printers once
   printer threads become available.

 - Allocating per CPU output buffers per console for printing from
   all contexts not covered by the other buffers.

 - Choosing the appropriate buffer is handled in the acquire/release
   functions.

The output buffer is wrapped into a separate data structure so other
context related fields can be added in later steps.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      | 13 ++++++
 kernel/printk/internal.h     | 22 +++++++--
 kernel/printk/printk.c       | 26 +++++++----
 kernel/printk/printk_nobkl.c | 90 +++++++++++++++++++++++++++++++++++-
 4 files changed, 137 insertions(+), 14 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 2c95fcc765e6..3d989104240f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -178,6 +178,7 @@ enum cons_flags {
  *
  * @locked:	Console is locked by a writer
  * @unsafe:	Console is busy in a non takeover region
+ * @thread:	Current owner is the printk thread
  * @cur_prio:	The priority of the current output
  * @req_prio:	The priority of a handover request
  * @cpu:	The CPU on which the writer runs
@@ -203,6 +204,7 @@ struct cons_state {
 				struct {
 					u32 locked	:  1;
 					u32 unsafe	:  1;
+					u32 thread	:  1;
 					u32 cur_prio	:  2;
 					u32 req_prio	:  2;
 					u32 cpu		: 18;
@@ -233,6 +235,7 @@ enum cons_prio {
 };
 
 struct console;
+struct printk_buffers;
 
 /**
  * struct cons_context - Context for console acquire/release
@@ -244,6 +247,8 @@ struct console;
  * @req_state:		The request state for spin and cleanup
  * @spinwait_max_us:	Limit for spinwait acquire
  * @prio:		Priority of the context
+ * @pbufs:		Pointer to the text buffer for this context
+ * @thread:		The acquire is printk thread context
  * @hostile:		Hostile takeover requested. Cleared on normal
  *			acquire or friendly handover
  * @spinwait:		Spinwait on acquire if possible
@@ -256,6 +261,8 @@ struct cons_context {
 	struct cons_state	req_state;
 	unsigned int		spinwait_max_us;
 	enum cons_prio		prio;
+	struct printk_buffers	*pbufs;
+	unsigned int		thread		: 1;
 	unsigned int		hostile		: 1;
 	unsigned int		spinwait	: 1;
 };
@@ -274,6 +281,8 @@ struct cons_write_context {
 	bool			unsafe;
 };
 
+struct cons_context_data;
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -295,6 +304,8 @@ struct cons_write_context {
  * @node:		hlist node for the console list
  *
  * @atomic_state:	State array for NOBKL consoles; real and handover
+ * @thread_pbufs:	Pointer to thread private buffer
+ * @pcpu_data:		Pointer to percpu context data
  */
 struct console {
 	char			name[16];
@@ -317,6 +328,8 @@ struct console {
 
 	/* NOBKL console specific members */
 	atomic_long_t		__private atomic_state[2];
+	struct printk_buffers	*thread_pbufs;
+	struct cons_context_data	__percpu *pcpu_data;
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index da380579263b..61ecdde5c872 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -13,8 +13,13 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 #define printk_sysctl_init() do { } while (0)
 #endif
 
-#ifdef CONFIG_PRINTK
+#define con_printk(lvl, con, fmt, ...)				\
+	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
+	       (con->flags & CON_NO_BKL) ? "" : "legacy ",	\
+	       (con->flags & CON_BOOT) ? "boot" : "",		\
+	       con->name, con->index, ##__VA_ARGS__)
 
+#ifdef CONFIG_PRINTK
 #ifdef CONFIG_PRINTK_CALLER
 #define PRINTK_PREFIX_MAX	48
 #else
@@ -64,7 +69,8 @@ u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 
 void cons_nobkl_cleanup(struct console *con);
-void cons_nobkl_init(struct console *con);
+bool cons_nobkl_init(struct console *con);
+bool cons_alloc_percpu_data(struct console *con);
 
 #else
 
@@ -81,7 +87,7 @@ void cons_nobkl_init(struct console *con);
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
-static inline void cons_nobkl_init(struct console *con) { }
+static inline bool cons_nobkl_init(struct console *con) { return true; }
 static inline void cons_nobkl_cleanup(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
@@ -113,3 +119,13 @@ struct printk_message {
 	u64			seq;
 	unsigned long		dropped;
 };
+
+/**
+ * struct cons_context_data - console context data
+ * @pbufs:		Buffer for storing the text
+ *
+ * Used for early boot and for per CPU data.
+ */
+struct cons_context_data {
+	struct printk_buffers		pbufs;
+};
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b2c7c92c3d79..3abefdead7ae 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -459,6 +459,8 @@ static bool have_bkl_console;
  */
 bool have_boot_console;
 
+static int unregister_console_locked(struct console *console);
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -1117,7 +1119,19 @@ static inline void log_buf_add_cpu(void) {}
 
 static void __init set_percpu_data_ready(void)
 {
+	struct hlist_node *tmp;
+	struct console *con;
+
+	console_list_lock();
+
+	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
+		if (!cons_alloc_percpu_data(con))
+			unregister_console_locked(con);
+	}
+
 	__printk_percpu_data_ready = true;
+
+	console_list_unlock();
 }
 
 static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
@@ -3329,12 +3343,6 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-#define con_printk(lvl, con, fmt, ...)				\
-	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
-	       (con->flags & CON_NO_BKL) ? "" : "legacy ",	\
-	       (con->flags & CON_BOOT) ? "boot" : "",		\
-	       con->name, con->index, ##__VA_ARGS__)
-
 static void console_init_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
@@ -3399,8 +3407,6 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 #define console_first()				\
 	hlist_entry(console_list.first, struct console, node)
 
-static int unregister_console_locked(struct console *console);
-
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3494,8 +3500,8 @@ void register_console(struct console *newcon)
 
 	if (!(newcon->flags & CON_NO_BKL))
 		have_bkl_console = true;
-	else
-		cons_nobkl_init(newcon);
+	else if (!cons_nobkl_init(newcon))
+		goto unlock;
 
 	if (newcon->flags & CON_BOOT)
 		have_boot_console = true;
diff --git a/kernel/printk/printk_nobkl.c b/kernel/printk/printk_nobkl.c
index 78136347a328..7db56ffd263a 100644
--- a/kernel/printk/printk_nobkl.c
+++ b/kernel/printk/printk_nobkl.c
@@ -166,6 +166,47 @@ static inline bool cons_check_panic(void)
 	return pcpu != PANIC_CPU_INVALID && pcpu != smp_processor_id();
 }
 
+static struct cons_context_data early_cons_ctxt_data __initdata;
+
+/**
+ * cons_context_set_pbufs - Set the output text buffer for the current context
+ * @ctxt:	Pointer to the acquire context
+ *
+ * Buffer selection:
+ *   1) Early boot uses the global (initdata) buffer
+ *   2) Printer threads use the dynamically allocated per-console buffers
+ *   3) All other contexts use the per CPU buffers
+ *
+ * This guarantees that there is no concurrency on the output records ever.
+ * Early boot and per CPU nesting is not a problem. The takeover logic
+ * tells the interrupted context that the buffer has been overwritten.
+ *
+ * There are two critical regions that matter:
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
+ *    and there is not much that can be done about that.
+ */
+static __ref void cons_context_set_pbufs(struct cons_context *ctxt)
+{
+	struct console *con = ctxt->console;
+
+	/* Thread context or early boot? */
+	if (ctxt->thread)
+		ctxt->pbufs = con->thread_pbufs;
+	else if (!con->pcpu_data)
+		ctxt->pbufs = &early_cons_ctxt_data.pbufs;
+	else
+		ctxt->pbufs = &(this_cpu_ptr(con->pcpu_data)->pbufs);
+}
+
 /**
  * cons_cleanup_handover - Cleanup a handover request
  * @ctxt:	Pointer to acquire context
@@ -501,6 +542,7 @@ static bool __cons_try_acquire(struct cons_context *ctxt)
 	}
 success:
 	/* Common updates on success */
+	cons_context_set_pbufs(ctxt);
 	return true;
 
 check_hostile:
@@ -623,6 +665,9 @@ static bool cons_release(struct cons_context *ctxt)
 {
 	bool ret = __cons_release(ctxt);
 
+	/* Invalidate the buffer pointer. It is no longer valid. */
+	ctxt->pbufs = NULL;
+
 	ctxt->state.atom = 0;
 	return ret;
 }
@@ -643,16 +688,58 @@ bool console_release(struct cons_write_context *wctxt)
 }
 EXPORT_SYMBOL(console_release);
 
+/**
+ * cons_alloc_percpu_data - Allocate percpu data for a console
+ * @con:	Console to allocate for
+ *
+ * Returns: True on success. False otherwise and the console cannot be used.
+ *
+ * If it is not yet possible to allocate per CPU data, success is returned.
+ * When per CPU data becomes possible, set_percpu_data_ready() will call
+ * this function again for all registered consoles.
+ */
+bool cons_alloc_percpu_data(struct console *con)
+{
+	if (!printk_percpu_data_ready())
+		return true;
+
+	con->pcpu_data = alloc_percpu(typeof(*con->pcpu_data));
+	if (con->pcpu_data)
+		return true;
+
+	con_printk(KERN_WARNING, con, "failed to allocate percpu buffers\n");
+	return false;
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
 /**
  * cons_nobkl_init - Initialize the NOBKL console specific data
  * @con:	Console to initialize
+ *
+ * Returns: True on success. False otherwise and the console cannot be used.
  */
-void cons_nobkl_init(struct console *con)
+bool cons_nobkl_init(struct console *con)
 {
 	struct cons_state state = { };
 
+	if (!cons_alloc_percpu_data(con))
+		return false;
+
 	cons_state_set(con, CON_STATE_CUR, &state);
 	cons_state_set(con, CON_STATE_REQ, &state);
+	return true;
 }
 
 /**
@@ -665,4 +752,5 @@ void cons_nobkl_cleanup(struct console *con)
 
 	cons_state_set(con, CON_STATE_CUR, &state);
 	cons_state_set(con, CON_STATE_REQ, &state);
+	cons_free_percpu_data(con);
 }
-- 
2.30.2

