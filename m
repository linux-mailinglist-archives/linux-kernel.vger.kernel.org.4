Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9225E8683
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiIXAFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiIXAFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562ECA50C5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19twU3lQfNuvUm9JND8TvG6rBZFGKcSPH9RyFrZuYhQ=;
        b=lqetqNRvqeJqLk8TBA11OGuf2NUa6RHrjlEyJz6gz4r+c8kBjyRL4nRzG+BW3/VCuRUeoY
        wg8wRvVkF5t15eiKwmpBE/BwM+8kDtg06vlf4vUPXoQwYADxDQSR2VD2h12ctlhVx1+0LR
        jZQVnE4JiHijrL7Sn8XD6RJScn1p5cT5AtGWUPmSLeAcbS0m/tA22U0Amrm89mDe8a6+is
        nZ0jGgyKz8REztYSusY/AXexeHX8I3W7WHKnQ0B+PIvjhj+K8Ju9pYcMLLmAd2NG3EVDCH
        WLiN+JaJEyeZH9CtC74KWFN4YXmOC8XBGWY4q9mZ32Xg42Shcys9fjjJUTppAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=19twU3lQfNuvUm9JND8TvG6rBZFGKcSPH9RyFrZuYhQ=;
        b=PnSeZAOK90thATM65Hp/yFXp9CjpHPOhtAVLF/An+huTzDUUsRLvdFBK4JiUQr0DQyth1Z
        sacn3uM1K6kLTaAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 06/18] printk: Protect [un]register_console() with a mutex
Date:   Sat, 24 Sep 2022 02:10:42 +0206
Message-Id: <20220924000454.3319186-7-john.ogness@linutronix.de>
In-Reply-To: <20220924000454.3319186-1-john.ogness@linutronix.de>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
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

Unprotected list walks are a brilliant idea. Especially in the context of
hotpluggable consoles.

The new list lock provides not only synchronization for console list
manipulation, but also for manipulation of console->flags:

    console_list_lock();
    console_lock();

    /* may now manipulate the console list and/or console->flags */

    console_unlock();
    console_list_unlock();

Therefore it is safe to iterate the console list and read console->flags
if holding either the console lock or the console list lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 30 +++++++++++++--
 kernel/printk/printk.c  | 84 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 98 insertions(+), 16 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 8c1686e2c233..24344f9b0bc1 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -157,10 +157,34 @@ struct console {
 	struct	 console *next;
 };
 
-/*
- * for_each_console() allows you to iterate on each console
+#ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_console_list_lock_held(void);
+#else
+static inline void lockdep_assert_console_list_lock_held(void) { }
+#endif
+
+extern void console_list_lock(void) __acquires(console_mutex);
+extern void console_list_unlock(void) __releases(console_mutex);
+
+/**
+ * for_each_registered_console() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Requires console_list_lock to be held. Can only be invoked from
+ * preemptible context.
+ */
+#define for_each_registered_console(con)				\
+	lockdep_assert_console_list_lock_held();			\
+	for (con = console_drivers; con != NULL; con = con->next)
+
+/**
+ * for_each_console() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Requires console_lock to be held which guarantees that the
+ * list is immutable.
  */
-#define for_each_console(con) \
+#define for_each_console(con)						\
 	for (con = console_drivers; con != NULL; con = con->next)
 
 extern int console_set_on_cmdline;
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e4f1e7478b52..8c56f6071873 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -79,10 +79,17 @@ int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
 /*
- * console_sem protects the console_drivers list, and also
- * provides serialisation for access to the entire console
- * driver system.
+ * console_sem protects the console_drivers list, and also provides
+ * serialization for access to the entire console driver system.
+ *
+ * console_mutex serializes register/unregister.
+ *
+ * console_sem must be taken inside a console_mutex locked section
+ * for any list manipulation in order to keep the console BKL
+ * machinery happy. This requirement also applies to manipulation
+ * of console->flags.
  */
+static DEFINE_MUTEX(console_mutex);
 static DEFINE_SEMAPHORE(console_sem);
 struct console *console_drivers;
 EXPORT_SYMBOL_GPL(console_drivers);
@@ -103,6 +110,12 @@ static int __read_mostly suppress_panic_printk;
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
+
+void lockdep_assert_console_list_lock_held(void)
+{
+	lockdep_assert_held(&console_mutex);
+}
+
 #endif
 
 enum devkmsg_log_bits {
@@ -220,6 +233,28 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
+/**
+ * console_list_lock - Lock the console list
+ *
+ * For non-console related list walks, e.g. procfs, sysfs...
+ */
+void console_list_lock(void)
+{
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
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -2978,17 +3013,21 @@ struct tty_driver *console_device(int *index)
 void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
+	console_list_lock();
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
+	console_list_unlock();
 }
 EXPORT_SYMBOL(console_stop);
 
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
@@ -3081,6 +3120,8 @@ static void try_enable_default_console(struct console *newcon)
 	       (con->flags & CON_BOOT) ? "boot" : "",	\
 	       con->name, con->index, ##__VA_ARGS__)
 
+static int console_unregister_locked(struct console *console);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3107,13 +3148,14 @@ void register_console(struct console *newcon)
 	bool realcon_enabled = false;
 	int err;
 
-	for_each_console(con) {
+	console_list_lock();
+	for_each_registered_console(con) {
 		if (WARN(con == newcon, "console '%s%d' already registered\n",
 					 con->name, con->index))
-			return;
+			goto unlock;
 	}
 
-	for_each_console(con) {
+	for_each_registered_console(con) {
 		if (con->flags & CON_BOOT)
 			bootcon_enabled = true;
 		else
@@ -3124,7 +3166,7 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT && realcon_enabled) {
 		pr_info("Too late to register bootconsole %s%d\n",
 			newcon->name, newcon->index);
-		return;
+		goto unlock;
 	}
 
 	/*
@@ -3155,7 +3197,7 @@ void register_console(struct console *newcon)
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-		return;
+		goto unlock;
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
@@ -3209,14 +3251,17 @@ void register_console(struct console *newcon)
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		for_each_console(con)
+		for_each_console(con) {
 			if (con->flags & CON_BOOT)
-				unregister_console(con);
+				console_unregister_locked(con);
+		}
 	}
+unlock:
+	console_list_unlock();
 }
 EXPORT_SYMBOL(register_console);
 
-int unregister_console(struct console *console)
+static int console_unregister_locked(struct console *console)
 {
 	struct console *con;
 	int res;
@@ -3269,6 +3314,16 @@ int unregister_console(struct console *console)
 
 	return res;
 }
+
+int unregister_console(struct console *console)
+{
+	int res;
+
+	console_list_lock();
+	res = console_unregister_locked(console);
+	console_list_unlock();
+	return res;
+}
 EXPORT_SYMBOL(unregister_console);
 
 /*
@@ -3320,7 +3375,8 @@ static int __init printk_late_init(void)
 	struct console *con;
 	int ret;
 
-	for_each_console(con) {
+	console_list_lock();
+	for_each_registered_console(con) {
 		if (!(con->flags & CON_BOOT))
 			continue;
 
@@ -3337,9 +3393,11 @@ static int __init printk_late_init(void)
 			 */
 			pr_warn("bootconsole [%s%d] uses init memory and must be disabled even before the real one is ready\n",
 				con->name, con->index);
-			unregister_console(con);
+			console_unregister_locked(con);
 		}
 	}
+	console_list_unlock();
+
 	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
 					console_cpu_notify);
 	WARN_ON(ret < 0);
-- 
2.30.2

