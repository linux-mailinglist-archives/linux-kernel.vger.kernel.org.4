Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11369604A56
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJSPDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiJSPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:02:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776EB161FFD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:57:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6Lc6N8r4GU5ofoIRm/xI96rlQR9N7h7xiEY7U0rrdo=;
        b=WcKxAuyJq3DhMytoZZKyfHvx3LUKiASxL0GbPcB1wiS/AN+FmRlf+Y30OSXWRsOlc3wVaq
        /SWkceKhUAinGtpHYuLE42d1xDizmjhjEIPqbNpXYHfKx9eqLDMDDxK3z2rZn9bPe12Wjg
        f6gN8yvnfKVrJP55j5feRIueav0JUWVpMkWvXrcpC/cyzetAvy9bjoXWLy1KvwWICGcfBF
        mN1zr8EeamOVmxzKEDR+Uxrf+ws2dse3cutZnK3IDTinucc0LRHOa4BfCtQmVxO3DMG80z
        YMl9KMskdAhYkhopMbjExWNpcqwr2+BspZELNDSDJrIfzAOlvm83EsTwjHNC0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6Lc6N8r4GU5ofoIRm/xI96rlQR9N7h7xiEY7U0rrdo=;
        b=1uEhuY8uFfwvbP4a9XQV3e1TWLBlz1xafI012vsQdF6svzD14yCfuelM5LkCwRU3pmoAVa
        WFoGoc7AIHW8TGDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 03/38] printk: Prepare for SRCU console list protection
Date:   Wed, 19 Oct 2022 17:01:25 +0206
Message-Id: <20221019145600.1282823-4-john.ogness@linutronix.de>
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

Provide an NMI-safe SRCU protected variant to walk the console list.

Note that all console fields are now set before adding the console
to the list to avoid the console becoming visible by SCRU readers
before being fully initialized.

This is a preparatory change for a new console infrastructure which
operates independent of the console BKL.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 .clang-format           |  1 +
 include/linux/console.h | 28 +++++++++++++++-
 kernel/printk/printk.c  | 72 ++++++++++++++++++++++++++++++++---------
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/.clang-format b/.clang-format
index 1247d54f9e49..04a675b56b57 100644
--- a/.clang-format
+++ b/.clang-format
@@ -222,6 +222,7 @@ ForEachMacros:
   - 'for_each_component_dais'
   - 'for_each_component_dais_safe'
   - 'for_each_console'
+  - 'for_each_console_srcu'
   - 'for_each_cpu'
   - 'for_each_cpu_and'
   - 'for_each_cpu_not'
diff --git a/include/linux/console.h b/include/linux/console.h
index 7b5f21f9e469..cff86cc615f8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,7 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
-#include <linux/list.h>
+#include <linux/rculist.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -158,8 +158,34 @@ struct console {
 	struct hlist_node node;
 };
 
+#ifdef CONFIG_LOCKDEP
+extern bool console_srcu_read_lock_is_held(void);
+#else
+static inline bool console_srcu_read_lock_is_held(void)
+{
+	return 1;
+}
+#endif
+
+extern int console_srcu_read_lock(void);
+extern void console_srcu_read_unlock(int cookie);
+
 extern struct hlist_head console_list;
 
+/**
+ * for_each_console_srcu() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Although SRCU guarantees the console list will be consistent, the
+ * struct console fields may be updated by other CPUs while iterating.
+ *
+ * Requires console_srcu_read_lock to be held. Can be invoked from
+ * any context.
+ */
+#define for_each_console_srcu(con)					\
+	hlist_for_each_entry_srcu(con, &console_list, node,		\
+				  console_srcu_read_lock_is_held())
+
 /*
  * for_each_console() allows you to iterate on each console
  */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 867becc40021..e8a56056cd50 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -85,6 +85,7 @@ EXPORT_SYMBOL(oops_in_progress);
 static DEFINE_SEMAPHORE(console_sem);
 HLIST_HEAD(console_list);
 EXPORT_SYMBOL_GPL(console_list);
+DEFINE_STATIC_SRCU(console_srcu);
 
 /*
  * System may need to suppress printk message under certain
@@ -102,6 +103,11 @@ static int __read_mostly suppress_panic_printk;
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
 };
+
+bool console_srcu_read_lock_is_held(void)
+{
+	return srcu_read_lock_held(&console_srcu);
+}
 #endif
 
 enum devkmsg_log_bits {
@@ -219,6 +225,32 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_PRINTK && CONFIG_SYSCTL */
 
+/**
+ * console_srcu_read_lock - Register a new reader for the
+ *	SRCU-protected console list
+ *
+ * Use for_each_console_srcu() to iterate the console list
+ *
+ * Context: Any context.
+ */
+int console_srcu_read_lock(void)
+{
+	return srcu_read_lock_nmisafe(&console_srcu);
+}
+EXPORT_SYMBOL(console_srcu_read_lock);
+
+/**
+ * console_srcu_read_unlock - Unregister an old reader from
+ *	the SRCU-protected console list
+ *
+ * Counterpart to console_srcu_read_lock()
+ */
+void console_srcu_read_unlock(int cookie)
+{
+	srcu_read_unlock_nmisafe(&console_srcu, cookie);
+}
+EXPORT_SYMBOL(console_srcu_read_unlock);
+
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -2989,6 +3021,9 @@ void console_stop(struct console *console)
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
+
+	/* Ensure that all SRCU list walks have completed */
+	synchronize_srcu(&console_srcu);
 }
 EXPORT_SYMBOL(console_stop);
 
@@ -3179,6 +3214,17 @@ void register_console(struct console *newcon)
 		newcon->flags &= ~CON_PRINTBUFFER;
 	}
 
+	newcon->dropped = 0;
+	if (newcon->flags & CON_PRINTBUFFER) {
+		/* Get a consistent copy of @syslog_seq. */
+		mutex_lock(&syslog_lock);
+		newcon->seq = syslog_seq;
+		mutex_unlock(&syslog_lock);
+	} else {
+		/* Begin with next message. */
+		newcon->seq = prb_next_seq(prb);
+	}
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3187,28 +3233,20 @@ void register_console(struct console *newcon)
 	if (hlist_empty(&console_list)) {
 		/* Ensure CON_CONSDEV is always set for the head. */
 		newcon->flags |= CON_CONSDEV;
-		hlist_add_head(&newcon->node, &console_list);
+		hlist_add_head_rcu(&newcon->node, &console_list);
 
 	} else if (newcon->flags & CON_CONSDEV) {
 		/* Only the new head can have CON_CONSDEV set. */
 		console_first()->flags &= ~CON_CONSDEV;
-		hlist_add_head(&newcon->node, &console_list);
+		hlist_add_head_rcu(&newcon->node, &console_list);
 
 	} else {
-		hlist_add_behind(&newcon->node, console_list.first);
-	}
-
-	newcon->dropped = 0;
-	if (newcon->flags & CON_PRINTBUFFER) {
-		/* Get a consistent copy of @syslog_seq. */
-		mutex_lock(&syslog_lock);
-		newcon->seq = syslog_seq;
-		mutex_unlock(&syslog_lock);
-	} else {
-		/* Begin with next message. */
-		newcon->seq = prb_next_seq(prb);
+		hlist_add_behind_rcu(&newcon->node, console_list.first);
 	}
 	console_unlock();
+
+	/* No need to synchronize SRCU here! */
+
 	console_sysfs_notify();
 
 	/*
@@ -3254,7 +3292,7 @@ int unregister_console(struct console *console)
 		goto out_unlock;
 	}
 
-	hlist_del_init(&console->node);
+	hlist_del_init_rcu(&console->node);
 
 	/*
 	 * <HISTORICAL>
@@ -3269,6 +3307,10 @@ int unregister_console(struct console *console)
 		console_first()->flags |= CON_CONSDEV;
 
 	console_unlock();
+
+	/* Ensure that all SRCU list walks have completed */
+	synchronize_srcu(&console_srcu);
+
 	console_sysfs_notify();
 
 	if (console->exit)
-- 
2.30.2

