Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4A5604A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiJSPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiJSPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259E42FFFA
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:28 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcRSHDvvNo4h9AdyzONtntflPRCM65zBDjJsA3cL8rk=;
        b=3AWz2y6+1k39Qj6Orp5DwOJpZBtwPBMP63eraBDBEEUg437H+y+VYXgKoH9orU/SwQDGLU
        06R/Lg+9+gV+G6DSMSlPyThKh8IWtZh/b43yUs60YI9x5Aq/QYZPclNqeSYqa8O2qovVRV
        7/gu1pKhqmDsprIbI1+hsU5FoG0FOfzUURCDxKiHetLklfjLBP1LTxW2WvhJ9z4+zKWji3
        tgjKytTz6ySvnqr15SPuktV4b5GI7pZo1dPB6vCZKbgEqk5+IaFkLzfG/AW5UjO0AD6gSi
        5mb9w4Tsxx5XDz0L3BY0zgVL5qerQDYGxg22CjiNbu4slbsmj1kKOPNkR1S2lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BcRSHDvvNo4h9AdyzONtntflPRCM65zBDjJsA3cL8rk=;
        b=InuA5nejuGJ/h2WMXNzVlmQY/B0egmLyfHHBCPaaVQ1w3jLH75R9dCp2uDasRu0WaqbXca
        /BZkfNms60ta+KBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 33/38] printk: introduce console_list_lock
Date:   Wed, 19 Oct 2022 17:01:55 +0206
Message-Id: <20221019145600.1282823-34-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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

Currently there exist races in console_register(), where the types
of registered consoles are checked (without holding the console_lock)
and then after acquiring the console_lock, it is assumed that the list
has not changed. Also, some code that performs console_unregister()
make similar assumptions.

Introduce a console_list_lock to provide full synchronization for any
console list changes. The console_list_lock also provides
synchronization for updates to console->flags.

Note that one of the various responsibilities of the console_lock is
also intended to provide this synchronization. Later changes will
update call sites relying on the console_lock for this purpose. Once
all call sites have been updated, the console_lock will be relieved
of synchronizing console_list and console->flags updates.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 20 ++++++++--
 kernel/printk/printk.c  | 82 +++++++++++++++++++++++++++++++++++------
 2 files changed, 88 insertions(+), 14 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 60195cd086dc..bf1e8136424a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -159,8 +159,12 @@ struct console {
 };
 
 #ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_console_list_lock_held(void);
 extern bool console_srcu_read_lock_is_held(void);
 #else
+static inline void lockdep_assert_console_list_lock_held(void)
+{
+}
 static inline bool console_srcu_read_lock_is_held(void)
 {
 	return 1;
@@ -170,6 +174,9 @@ static inline bool console_srcu_read_lock_is_held(void)
 extern int console_srcu_read_lock(void);
 extern void console_srcu_read_unlock(int cookie);
 
+extern void console_list_lock(void) __acquires(console_mutex);
+extern void console_list_unlock(void) __releases(console_mutex);
+
 extern struct hlist_head console_list;
 
 /**
@@ -206,10 +213,17 @@ static inline bool console_is_enabled(const struct console *con)
 	hlist_for_each_entry_srcu(con, &console_list, node,		\
 				  console_srcu_read_lock_is_held())
 
-/*
- * for_each_console() allows you to iterate on each console
+/**
+ * for_each_console() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * The console list and all struct console fields are immutable while
+ * iterating.
+ *
+ * Requires console_list_lock to be held.
  */
-#define for_each_console(con) \
+#define for_each_console(con)						\
+	lockdep_assert_console_list_lock_held();			\
 	hlist_for_each_entry(con, &console_list, node)
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2faa6e3e2fb8..3615ee6d68fd 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -78,6 +78,9 @@ EXPORT_SYMBOL(ignore_console_lock_warning);
 int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
+/* console_mutex protects console_list and console->flags updates. */
+static DEFINE_MUTEX(console_mutex);
+
 /*
  * console_sem protects console_list and console->flags updates, and also
  * provides serialization for access to the entire console driver system.
@@ -104,6 +107,11 @@ static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
 
+void lockdep_assert_console_list_lock_held(void)
+{
+	lockdep_assert_held(&console_mutex);
+}
+
 bool console_srcu_read_lock_is_held(void)
 {
 	return srcu_read_lock_held(&console_srcu);
@@ -225,6 +233,40 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
+/**
+ * console_list_lock - Lock the console list
+ *
+ * For console list or console->flags updates
+ */
+void console_list_lock(void)
+{
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
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
+#endif
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
@@ -3055,9 +3097,11 @@ struct tty_driver *console_device(int *index)
 void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
+	console_list_lock();
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
+	console_list_unlock();
 
 	/* Ensure that all SRCU list walks have completed */
 	synchronize_srcu(&console_srcu);
@@ -3066,9 +3110,11 @@ EXPORT_SYMBOL(console_stop);
 
 void console_start(struct console *console)
 {
+	console_list_lock();
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
+	console_list_unlock();
 	__pr_flush(console, 1000, true);
 }
 EXPORT_SYMBOL(console_start);
@@ -3164,6 +3210,8 @@ static void try_enable_default_console(struct console *newcon)
 #define console_first()				\
 	hlist_entry(console_list.first, struct console, node)
 
+static int unregister_console_locked(struct console *console);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3188,15 +3236,14 @@ void register_console(struct console *newcon)
 	struct console *con;
 	bool bootcon_enabled = false;
 	bool realcon_enabled = false;
-	int cookie;
 	int err;
 
-	cookie = console_srcu_read_lock();
-	for_each_console_srcu(con) {
+	console_list_lock();
+
+	for_each_console(con) {
 		if (WARN(con == newcon, "console '%s%d' already registered\n",
 					 con->name, con->index)) {
-			console_srcu_read_unlock(cookie);
-			return;
+			goto unlock;
 		}
 
 		if (con->flags & CON_BOOT)
@@ -3204,13 +3251,12 @@ void register_console(struct console *newcon)
 		else
 			realcon_enabled = true;
 	}
-	console_srcu_read_unlock(cookie);
 
 	/* Do not register boot consoles when there already is a real one. */
 	if (newcon->flags & CON_BOOT && realcon_enabled) {
 		pr_info("Too late to register bootconsole %s%d\n",
 			newcon->name, newcon->index);
-		return;
+		goto unlock;
 	}
 
 	/*
@@ -3241,7 +3287,7 @@ void register_console(struct console *newcon)
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-		return;
+		goto unlock;
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
@@ -3304,13 +3350,15 @@ void register_console(struct console *newcon)
 
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
+static int unregister_console_locked(struct console *console)
 {
 	int res;
 
@@ -3362,6 +3410,16 @@ int unregister_console(struct console *console)
 	console_unlock();
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
@@ -3414,6 +3472,7 @@ static int __init printk_late_init(void)
 	struct console *con;
 	int ret;
 
+	console_list_lock();
 	hlist_for_each_entry_safe(con, tmp, &console_list, node) {
 		if (!(con->flags & CON_BOOT))
 			continue;
@@ -3431,9 +3490,10 @@ static int __init printk_late_init(void)
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

