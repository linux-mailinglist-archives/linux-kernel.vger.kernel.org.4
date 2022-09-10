Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C78B5B4A8D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiIJW2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIJW1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5E43327
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:50 -0700 (PDT)
Message-ID: <20220910222301.026064288@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lpamWxeD7WXfacPVoNQg0Q6R4SqcQTvaVnGnp8PqLdM=;
        b=YmPFuIYQ+9V+opmDhlZv871qYOrvkfmjaaoinjHRpOO4MbDMcfvdRmThrwQkPPgcAoK6Se
        HnyGMCFsWA8MJfWoviDLEqQHOLy5Fzu1lf9wne0QsQNvpATkh+vT3Qt+NAOpnJDdIftbGJ
        aez2V18hlxCrw5CTkI6OUtjD+j4aCcDTu/l7/pXqnCmgsKXUbK639wj5xQh80g88/ujo2i
        NfBPnO26aco9HMtbvwgdD1+2Nl6IPmIGnWYQIvqhkxmJ1S3L0OUr0JLSKtXhlOPGzv+oeP
        1UVbMfmgMXzKDZyhCbB2qo62hxlryR1hE+AcTnS6M1GjJ8dqgHEej0oU3ypbng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lpamWxeD7WXfacPVoNQg0Q6R4SqcQTvaVnGnp8PqLdM=;
        b=pdw/ixWADrwbJmqaSrRHP4ujDZNNf0Tt5fTGkbeNM1f5dFSeZs3czHaPDW8JzCvrL64lCQ
        2w/r0ChClTo3n3AQ==
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
Subject: [patch RFC 11/29] printk: Convert console_drivers list to hlist
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded single linked list with a hlist so a conversion to
SRCU protected list walks can reuse the existing primitives.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/parisc/kernel/pdc_cons.c |   17 ++-----
 fs/proc/consoles.c            |    5 +-
 include/linux/console.h       |   19 +++++---
 kernel/printk/printk.c        |   99 ++++++++++++++++++++++--------------------
 4 files changed, 75 insertions(+), 65 deletions(-)

--- a/arch/parisc/kernel/pdc_cons.c
+++ b/arch/parisc/kernel/pdc_cons.c
@@ -147,13 +147,8 @@ static int __init pdc_console_tty_driver
 
 	struct console *tmp;
 
-	console_lock();
-	for_each_console(tmp)
-		if (tmp == &pdc_cons)
-			break;
-	console_unlock();
-
-	if (!tmp) {
+	/* Pretend that this works as much as it pretended to work historically */
+	if (hlist_unhashed_lockless(&pdc_cons.node)) {
 		printk(KERN_INFO "PDC console driver not registered anymore, not creating %s\n", pdc_cons.name);
 		return -ENODEV;
 	}
@@ -272,15 +267,15 @@ void pdc_console_restart(bool hpmc)
 	if (pdc_console_initialized)
 		return;
 
-	if (!hpmc && console_drivers)
+	if (!hpmc && !hlist_empty(&console_list))
 		return;
 
 	/* If we've already seen the output, don't bother to print it again */
-	if (console_drivers != NULL)
+	if (!hlist_empty(&console_list))
 		pdc_cons.flags &= ~CON_PRINTBUFFER;
 
-	while ((console = console_drivers) != NULL)
-		unregister_console(console_drivers);
+	while (!hlist_empty(&console_list))
+		unregister_console(READ_ONCE(console_list.first));
 
 	/* force registering the pdc console */
 	pdc_console_init_force();
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -74,8 +74,11 @@ static void *c_start(struct seq_file *m,
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct console *con = v;
+
 	++*pos;
-	return con->next;
+	hlist_for_each_entry_continue(con, node)
+		break;
+	return con;
 }
 
 static void c_stop(struct seq_file *m, void *v)
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
+#include <linux/list.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -154,15 +155,19 @@ struct console {
 	u64	seq;
 	unsigned long dropped;
 	void	*data;
-	struct	 console *next;
+	struct hlist_node node;
 };
 
 #ifdef CONFIG_LOCKDEP
+extern void lockdep_assert_console_lock_held(void);
 extern void lockdep_assert_console_list_lock_held(void);
 #else
+static inline void lockdep_assert_console_lock_held(void) { }
 static inline void lockdep_assert_console_list_lock_held(void) { }
 #endif
 
+extern struct hlist_head console_list;
+
 extern void console_list_lock(void) __acquires(console_mutex);
 extern void console_list_unlock(void) __releases(console_mutex);
 
@@ -175,7 +180,7 @@ extern void console_list_unlock(void) __
  */
 #define for_each_registered_console(con)				\
 	lockdep_assert_console_list_lock_held();			\
-	for (con = console_drivers; con != NULL; con = con->next)
+	hlist_for_each_entry(con, &console_list, node)
 
 /**
  * for_each_console() - Iterator over registered consoles
@@ -184,8 +189,9 @@ extern void console_list_unlock(void) __
  * Requires console_lock to be held which guarantees that the
  * list is immutable.
  */
-#define for_each_console(con) \
-	for (con = console_drivers; con != NULL; con = con->next)
+#define for_each_console(con)						\
+	lockdep_assert_console_lock_held();				\
+	hlist_for_each_entry(con, &console_list, node)
 
 /**
  * for_each_console_kgdb() - Iterator over registered consoles for KGDB
@@ -194,8 +200,8 @@ extern void console_list_unlock(void) __
  * Has no serialization requirements and KGDB pretends that this is safe.
  * Don't use outside of the KGDB fairy tale land!
  */
-#define for_each_console_kgdb(con)				\
-	for (con = console_drivers; con != NULL; con = con->next)
+#define for_each_console_kgdb(con)					\
+	hlist_for_each_entry(con, &console_list, node)
 
 extern int console_set_on_cmdline;
 extern struct console *early_console;
@@ -208,7 +214,6 @@ enum con_flush_mode {
 extern int add_preferred_console(char *name, int idx, char *options);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
-extern struct console *console_drivers;
 extern void console_lock(void);
 extern int console_trylock(void);
 extern void console_unlock(void);
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -79,17 +79,17 @@ int oops_in_progress;
 EXPORT_SYMBOL(oops_in_progress);
 
 /*
- * console_sem protects the console_drivers list, and also provides
- * serialization for access to the entire console driver system.
+ * console_sem protects onsole_list, and also provides serialization for
+ * access to the entire console driver system.
  *
  * console_mutex serializes register/unregister. console_sem has to be
- * taken for any list manipulation inside the console_mutex locked
+ * taken for any console_list manipulation inside the console_mutex locked
  * section to keep the console BKL machinery happy.
  */
 static DEFINE_MUTEX(console_mutex);
 static DEFINE_SEMAPHORE(console_sem);
-struct console *console_drivers;
-EXPORT_SYMBOL_GPL(console_drivers);
+HLIST_HEAD(console_list);
+EXPORT_SYMBOL_GPL(console_list);
 
 /*
  * System may need to suppress printk message under certain
@@ -108,6 +108,11 @@ static struct lockdep_map console_lock_d
 	.name = "console_lock"
 };
 
+void lockdep_assert_console_lock_held(void)
+{
+	lockdep_assert(lock_is_held(&console_lock_dep_map));
+}
+
 void lockdep_assert_console_list_lock_held(void)
 {
 	lockdep_assert_held(&console_mutex);
@@ -2586,7 +2591,7 @@ static int console_cpu_notify(unsigned i
  * console_lock - lock the console system for exclusive use.
  *
  * Acquires a lock which guarantees that the caller has
- * exclusive access to the console system and the console_drivers list.
+ * exclusive access to the console system and console_list.
  *
  * Can sleep, returns nothing.
  */
@@ -2606,7 +2611,7 @@ EXPORT_SYMBOL(console_lock);
  * console_trylock - try to lock the console system for exclusive use.
  *
  * Try to acquire a lock which guarantees that the caller has exclusive
- * access to the console system and the console_drivers list.
+ * access to the console system and console_list.
  *
  * returns 1 on success, and 0 on failure to acquire the lock.
  */
@@ -2974,7 +2979,15 @@ void console_flush_on_panic(enum con_flu
 		u64 seq;
 
 		seq = prb_first_valid_seq(prb);
-		for_each_console(c)
+		/*
+		 * This cannot use for_each_console() because it's not established
+		 * that the current context has console locked and neither there is
+		 * a guarantee that there is no concurrency in that case.
+		 *
+		 * Open code it for documentation purposes and pretend that
+		 * it works.
+		 */
+		hlist_for_each_entry(c, &console_list, node)
 			c->seq = seq;
 	}
 	console_unlock();
@@ -3115,6 +3128,9 @@ static void try_enable_default_console(s
 	       (con->flags & CON_BOOT) ? "boot" : "",	\
 	       con->name, con->index, ##__VA_ARGS__)
 
+#define cons_first()					\
+	hlist_entry(console_list.first, struct console, node)
+
 static int console_unregister_locked(struct console *console);
 
 /*
@@ -3177,8 +3193,8 @@ void register_console(struct console *ne
 	 * flag set and will be first in the list.
 	 */
 	if (preferred_console < 0) {
-		if (!console_drivers || !console_drivers->device ||
-		    console_drivers->flags & CON_BOOT) {
+		if (hlist_empty(&console_list) || !cons_first()->device ||
+		    cons_first()->flags & CON_BOOT) {
 			try_enable_default_console(newcon);
 		}
 	}
@@ -3206,21 +3222,17 @@ void register_console(struct console *ne
 	}
 
 	/*
-	 *	Put this console in the list - keep the
-	 *	preferred driver at the head of the list.
+	 * Put this console in the list and keep the referred driver at the
+	 * head of the list.
 	 */
 	console_lock();
-	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
-		newcon->next = console_drivers;
-		console_drivers = newcon;
-		if (newcon->next)
-			newcon->next->flags &= ~CON_CONSDEV;
-		/* Ensure this flag is always set for the head of the list */
-		newcon->flags |= CON_CONSDEV;
-	} else {
-		newcon->next = console_drivers->next;
-		console_drivers->next = newcon;
-	}
+	if (newcon->flags & CON_CONSDEV || hlist_empty(&console_list))
+		hlist_add_head(&newcon->node, &console_list);
+	else
+		hlist_add_behind(&newcon->node, console_list.first);
+
+	/* Ensure this flag is always set for the head of the list */
+	cons_first()->flags |= CON_CONSDEV;
 
 	newcon->dropped = 0;
 	if (newcon->flags & CON_PRINTBUFFER) {
@@ -3246,7 +3258,9 @@ void register_console(struct console *ne
 	if (bootcon_enabled &&
 	    ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV) &&
 	    !keep_bootcon) {
-		for_each_console(con) {
+		struct hlist_node *tmp;
+
+		hlist_for_each_entry_safe(con, tmp, &console_list, node) {
 			if (con->flags & CON_BOOT)
 				console_unregister_locked(con);
 		}
@@ -3258,7 +3272,6 @@ EXPORT_SYMBOL(register_console);
 
 static int console_unregister_locked(struct console *console)
 {
-	struct console *con;
 	int res;
 
 	con_printk(KERN_INFO, console, "disabled\n");
@@ -3269,32 +3282,28 @@ static int console_unregister_locked(str
 	if (res > 0)
 		return 0;
 
-	res = -ENODEV;
 	console_lock();
-	if (console_drivers == console) {
-		console_drivers=console->next;
-		res = 0;
-	} else {
-		for_each_console(con) {
-			if (con->next == console) {
-				con->next = console->next;
-				res = 0;
-				break;
-			}
-		}
-	}
 
-	if (res)
-		goto out_disable_unlock;
+	/* Disable it unconditionally */
+	console->flags &= ~CON_ENABLED;
+
+	if (hlist_unhashed(&console->node))
+		goto out_unlock;
+
+	hlist_del_init(&console->node);
 
 	/*
+	 * <HISTORICAL>
 	 * If this isn't the last console and it has CON_CONSDEV set, we
 	 * need to set it on the next preferred console.
+	 * </HISTORICAL>
+	 *
+	 * The above makes no sense as there is no guarantee that the next
+	 * console has any device attached. Oh well....
 	 */
-	if (console_drivers != NULL && console->flags & CON_CONSDEV)
-		console_drivers->flags |= CON_CONSDEV;
+	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
+		cons_first()->flags |= CON_CONSDEV;
 
-	console->flags &= ~CON_ENABLED;
 	console_unlock();
 	console_sysfs_notify();
 
@@ -3303,10 +3312,8 @@ static int console_unregister_locked(str
 
 	return res;
 
-out_disable_unlock:
-	console->flags &= ~CON_ENABLED;
+out_unlock:
 	console_unlock();
-
 	return res;
 }
 

