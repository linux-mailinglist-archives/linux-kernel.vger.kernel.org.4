Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD7B61F56D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiKGOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbiKGOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC71CFF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngtNczYH2Al42VnARGnV9no8ylQKQpkMprF/75ICCho=;
        b=07HIDbcq9ue5xw8Xba4Zoslyp/72IMH+EBXJQAIQRFnSVaOrqHUy5sgB9Lrp6AdNeir+77
        E+NQMpzLlbrtY5pFDmEIyAov6t6Q/5nsMRYhKs8r/20uSVaQ+9gO2qNv6lRqjFokazpVN4
        Xb6fuOLSif55aDSW7BPJkcz7kWLrNOPblKlaJnmy+D8kl80zMYnhbkV4aH4iaOCi7L24u+
        jZfchVCZbjvzSpzazTQhyAlyWVx1vs9NHVXfHsVYdygffN02MSZl0Yb6ibPjYgVMV0VGra
        BzHJ98J2YpeF8SGAWC7NX8okN2JepYLtwoFi4xREN7d0qDG8w4/yVZQPicde7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngtNczYH2Al42VnARGnV9no8ylQKQpkMprF/75ICCho=;
        b=Hz2aKQpH2SxIPxAQcxm3argR2rJV/FpFRd2AWnJSImJxBcMKhwWiKRmL+beifOuxCwmg6P
        B6y6TVOj4SxFU1AA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 21/40] printk: introduce console_list_lock
Date:   Mon,  7 Nov 2022 15:22:19 +0106
Message-Id: <20221107141638.3790965-22-john.ogness@linutronix.de>
In-Reply-To: <20221107141638.3790965-1-john.ogness@linutronix.de>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
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

Currently there exist races in register_console(), where the types
of registered consoles are checked (without holding the console_lock)
and then after acquiring the console_lock, it is assumed that the list
has not changed. Also, some code that performs console_unregister()
make similar assumptions.

It might be possible to fix these races using the console_lock. But
it would require a complex analysis of all console drivers to make
sure that the console_lock is not taken in match() and setup()
callbacks. And we really prefer to split up and reduce the
responsibilities of console_lock rather than expand its complexity.
Therefore, introduce a new console_list_lock to provide full
synchronization for any console list changes.

In addition, also use console_list_lock for synchronization of
console->flags updates. All flags are either static or modified only
during the console registration. There are only two exceptions.

The first exception is CON_ENABLED, which is also modified by
console_start()/console_stop(). Therefore, these functions must
also take the console_list_lock.

The second exception is when the flags are modified by the console
driver init code before the console is registered. These will be
ignored because they are not visible to the rest of the system
via the console_drivers list.

Note that one of the various responsibilities of the console_lock is
also intended to provide console list and console->flags
synchronization. Later changes will update call sites relying on the
console_lock for these purposes. Once all call sites have been
updated, the console_lock will be relieved of synchronizing
console_list and console->flags updates.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 23 +++++++++--
 kernel/printk/printk.c  | 87 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 98 insertions(+), 12 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d9c636011364..47be23be8a88 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -158,6 +158,14 @@ struct console {
 	struct hlist_node node;
 };
 
+#ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_console_list_lock_held(void);
+#else
+static inline void lockdep_assert_console_list_lock_held(void)
+{
+}
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern bool console_srcu_read_lock_is_held(void);
 #else
@@ -170,6 +178,9 @@ static inline bool console_srcu_read_lock_is_held(void)
 extern int console_srcu_read_lock(void);
 extern void console_srcu_read_unlock(int cookie);
 
+extern void console_list_lock(void) __acquires(console_mutex);
+extern void console_list_unlock(void) __releases(console_mutex);
+
 extern struct hlist_head console_list;
 
 /**
@@ -213,10 +224,16 @@ static inline bool console_is_enabled(const struct console *con)
 	hlist_for_each_entry_srcu(con, &console_list, node,		\
 				  console_srcu_read_lock_is_held())
 
-/*
- * for_each_console() allows you to iterate on each console
+/**
+ * for_each_console() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * The console list and the console->flags are immutable while iterating.
+ *
+ * Requires console_list_lock to be held.
  */
-#define for_each_console(con) \
+#define for_each_console(con)						\
+	lockdep_assert_console_list_lock_held();			\
 	hlist_for_each_entry(con, &console_list, node)
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d8ccb7b523e2..31387ba3fa1a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -78,6 +78,13 @@ EXPORT_SYMBOL(ignore_console_lock_warning);
 int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
+/*
+ * console_mutex protects console_list updates and console->flags updates.
+ * The flags are synchronized only for consoles that are registered, i.e.
+ * accessible via the console list.
+ */
+static DEFINE_MUTEX(console_mutex);
+
 /*
  * console_sem protects console_list and console->flags updates, and also
  * provides serialization for access to the entire console driver system.
@@ -103,6 +110,11 @@ static int __read_mostly suppress_panic_printk;
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
+
+void lockdep_assert_console_list_lock_held(void)
+{
+	lockdep_assert_held(&console_mutex);
+}
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -227,6 +239,39 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
+/**
+ * console_list_lock - Lock the console list
+ *
+ * For console list or console->flags updates
+ */
+void console_list_lock(void)
+{
+	/*
+	 * In unregister_console(), synchronize_srcu() is called with the
+	 * console_list_lock held. Therefore it is not allowed that the
+	 * console_list_lock is taken with the srcu_lock held.
+	 *
+	 * Whether or not this context is in the read-side critical section
+	 * can only be detected if the appropriate debug options are enabled.
+	 */
+	WARN_ON_ONCE(debug_lockdep_rcu_enabled() &&
+		     srcu_read_lock_held(&console_srcu));
+
+	mutex_lock(&console_mutex);
+}
+EXPORT_SYMBOL(console_list_lock);
+
+/**
+ * console_list_unlock - Unlock the console list
+ *
+ * Counterpart to console_list_lock()
+ */
+void console_list_unlock(void)
+{
+	mutex_unlock(&console_mutex);
+}
+EXPORT_SYMBOL(console_list_unlock);
+
 /**
  * console_srcu_read_lock - Register a new reader for the
  *	SRCU-protected console list
@@ -3060,9 +3105,11 @@ struct tty_driver *console_device(int *index)
 void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
+	console_list_lock();
 	console_lock();
 	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
 	console_unlock();
+	console_list_unlock();
 
 	/*
 	 * Ensure that all SRCU list walks have completed. All contexts must
@@ -3076,9 +3123,11 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	console_list_lock();
 	console_lock();
 	WRITE_ONCE(console->flags, console->flags | CON_ENABLED);
 	console_unlock();
+	console_list_unlock();
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3177,6 +3226,8 @@ static void try_enable_default_console(struct console *newcon)
 #define console_first()				\
 	hlist_entry(console_list.first, struct console, node)
 
+static int unregister_console_locked(struct console *console);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3203,13 +3254,14 @@ void register_console(struct console *newcon)
 	bool realcon_enabled = false;
 	int err;
 
+	console_list_lock();
+
 	for_each_console(con) {
 		if (WARN(con == newcon, "console '%s%d' already registered\n",
-					 con->name, con->index))
-			return;
-	}
+					 con->name, con->index)) {
+			goto unlock;
+		}
 
-	for_each_console(con) {
 		if (con->flags & CON_BOOT)
 			bootcon_enabled = true;
 		else
@@ -3220,7 +3272,7 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT && realcon_enabled) {
 		pr_info("Too late to register bootconsole %s%d\n",
 			newcon->name, newcon->index);
-		return;
+		goto unlock;
 	}
 
 	/*
@@ -3251,7 +3303,7 @@ void register_console(struct console *newcon)
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-		return;
+		goto unlock;
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
@@ -3330,16 +3382,21 @@ void register_console(struct console *newcon)
 
 		hlist_for_each_entry_safe(con, tmp, &console_list, node) {
 			if (con->flags & CON_BOOT)
-				unregister_console(con);
+				unregister_console_locked(con);
 		}
 	}
+unlock:
+	console_list_unlock();
 }
 EXPORT_SYMBOL(register_console);
 
-int unregister_console(struct console *console)
+/* Must be called under console_list_lock(). */
+static int unregister_console_locked(struct console *console)
 {
 	int res;
 
+	lockdep_assert_console_list_lock_held();
+
 	con_printk(KERN_INFO, console, "disabled\n");
 
 	res = _braille_unregister_console(console);
@@ -3388,6 +3445,16 @@ int unregister_console(struct console *console)
 
 	return res;
 }
+
+int unregister_console(struct console *console)
+{
+	int res;
+
+	console_list_lock();
+	res = unregister_console_locked(console);
+	console_list_unlock();
+	return res;
+}
 EXPORT_SYMBOL(unregister_console);
 
 /*
@@ -3440,6 +3507,7 @@ static int __init printk_late_init(void)
 	struct console *con;
 	int ret;
 
+	console_list_lock();
 	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
 		if (!(con->flags & CON_BOOT))
 			continue;
@@ -3457,9 +3525,10 @@ static int __init printk_late_init(void)
 			 */
 			pr_warn("bootconsole [%s%d] uses init memory and must be disabled even before the real one is ready\n",
 				con->name, con->index);
-			unregister_console(con);
+			unregister_console_locked(con);
 		}
 	}
+	console_list_unlock();
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
 					console_cpu_notify);
-- 
2.30.2

