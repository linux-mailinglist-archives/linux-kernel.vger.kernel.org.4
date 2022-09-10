Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1A5B4A9C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiIJW2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiIJW1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE703D5A0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:43 -0700 (PDT)
Message-ID: <20220910222300.712668210@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o5EroeZfB4NRvl63EpSxfqZIvT4RtM7/V27p+d+Wyos=;
        b=Lq9KRRbRCX0Ak4qz8PNcmnbY1qO4QNuFUisqEyBcaC5V2qUJOYoGBlTG0ZgaRxHg4CRI78
        G323bD21b5keHOyH+Je+VPkSF2+aXuajMFh8PlD4ejaIig7y9+BGqkcmuxmUMxLLk/ZJlG
        JS6hS0K9YILffaYp7z/VAm6Obqb3AkoU73qZcUAiAWbTV1m2enP0INBpikmYVyMVaQezS2
        PfYjSVb4htLORkATadQbQAyA2evBdVOlOuDBZBLlSPgMEz2RTZ7fxXbAEbdtjPBSniWcni
        9NnwSLKJaRWNi5Gt/y1iGVoJi5hOiwjcbTtph597AlCSKOiKvrVU/Cam5ML3jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=o5EroeZfB4NRvl63EpSxfqZIvT4RtM7/V27p+d+Wyos=;
        b=sYK6VGhDAuF/Gqfwp7U/eUg7y/W1Byds18bfIvK6JOlosn9b09WsD0fVaMKF95jHZnCAym
        IpH7WSzU4DPAXiAQ==
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
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 06/29] printk: Protect [un]register_console() with a mutex
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:41 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unprotected list walks are a brilliant idea. Especially in the context of
hotpluggable consoles.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   30 ++++++++++++++++--
 kernel/printk/printk.c  |   79 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 93 insertions(+), 16 deletions(-)

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
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -79,10 +79,14 @@ int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
 /*
- * console_sem protects the console_drivers list, and also
- * provides serialisation for access to the entire console
- * driver system.
+ * console_sem protects the console_drivers list, and also provides
+ * serialization for access to the entire console driver system.
+ *
+ * console_mutex serializes register/unregister. console_sem has to be
+ * taken for any list manipulation inside the console_mutex locked
+ * section to keep the console BKL machinery happy.
  */
+static DEFINE_MUTEX(console_mutex);
 static DEFINE_SEMAPHORE(console_sem);
 struct console *console_drivers;
 EXPORT_SYMBOL_GPL(console_drivers);
@@ -103,6 +107,12 @@ static int __read_mostly suppress_panic_
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
@@ -220,6 +230,26 @@ int devkmsg_sysctl_set_loglvl(struct ctl
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
+
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -2978,17 +3008,21 @@ struct tty_driver *console_device(int *i
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
@@ -3081,6 +3115,8 @@ static void try_enable_default_console(s
 	       (con->flags & CON_BOOT) ? "boot" : "",	\
 	       con->name, con->index, ##__VA_ARGS__)
 
+static int console_unregister_locked(struct console *console);
+
 /*
  * The console driver calls this routine during kernel initialization
  * to register the console printing procedure with printk() and to
@@ -3107,13 +3143,14 @@ void register_console(struct console *ne
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
@@ -3124,7 +3161,7 @@ void register_console(struct console *ne
 	if (newcon->flags & CON_BOOT && realcon_enabled) {
 		pr_info("Too late to register bootconsole %s%d\n",
 			newcon->name, newcon->index);
-		return;
+		goto unlock;
 	}
 
 	/*
@@ -3155,7 +3192,7 @@ void register_console(struct console *ne
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-		return;
+		goto unlock;
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
@@ -3209,14 +3246,17 @@ void register_console(struct console *ne
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
@@ -3269,6 +3309,16 @@ int unregister_console(struct console *c
 
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
@@ -3320,7 +3370,8 @@ static int __init printk_late_init(void)
 	struct console *con;
 	int ret;
 
-	for_each_console(con) {
+	console_list_lock();
+	for_each_registered_console(con) {
 		if (!(con->flags & CON_BOOT))
 			continue;
 
@@ -3337,9 +3388,11 @@ static int __init printk_late_init(void)
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

