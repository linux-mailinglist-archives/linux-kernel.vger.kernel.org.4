Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E09361F534
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiKGORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKGOQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98061D0DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrbpCQycb+/taI/uRVaujF070w6Ca/Xi2eD/NxYFOUA=;
        b=HqvME5Z0n3Sq4uIE7mKgJdkv76kPDLd7hmC4sMytV1WdFRZz425hUdrdzhzIkrXq9WCVVj
        fskriOgAcC/vf3C/in8fRBYof57CsewAT5P3F+Iab6xXAvCT9UUTghXFBBc42+EjxKHINh
        SdgtUtF5YrQaXy9E+/kKVN7yRtiys93S2dOzaWg8wBaiFuKSOE+TC2w+rwhBfIPY6wXZky
        fOiIeEI8lkfA6przjc9IGVCUXUfxEuDQpVIP+A9NmT2lfp+3Vr09HXn61OS+3MEG9650RO
        LKTUSBM+9EdZSZPRfQC7gdjrN2KYNVgn3EtECEJ4ObWJsKp3Lh4xZdmf1Wdz2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrbpCQycb+/taI/uRVaujF070w6Ca/Xi2eD/NxYFOUA=;
        b=A8vINHDp/X57Dv+RlcmMQXpe2//s+tDplkRKnVNA7KZvTtPQVciNTfI8YFjookeUoNft3N
        9Jbx3/pBS2cnf9Bg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH printk v3 04/40] printk: Prepare for SRCU console list protection
Date:   Mon,  7 Nov 2022 15:22:02 +0106
Message-Id: <20221107141638.3790965-5-john.ogness@linutronix.de>
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

Provide an NMI-safe SRCU protected variant to walk the console list.

Note that all console fields are now set before adding the console
to the list to avoid the console becoming visible by SCRU readers
before being fully initialized.

This is a preparatory change for a new console infrastructure which
operates independent of the console BKL.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 .clang-format           |  1 +
 include/linux/console.h | 28 ++++++++++++-
 kernel/printk/printk.c  | 87 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 100 insertions(+), 16 deletions(-)

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
index 7b5f21f9e469..f4f0c9523835 100644
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
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
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
index e6f0832e71f0..173f46a29252 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -85,6 +85,7 @@ EXPORT_SYMBOL(oops_in_progress);
 static DEFINE_SEMAPHORE(console_sem);
 HLIST_HEAD(console_list);
 EXPORT_SYMBOL_GPL(console_list);
+DEFINE_STATIC_SRCU(console_srcu);
 
 /*
  * System may need to suppress printk message under certain
@@ -104,6 +105,13 @@ static struct lockdep_map console_lock_dep_map = {
 };
 #endif
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+bool console_srcu_read_lock_is_held(void)
+{
+	return srcu_read_lock_held(&console_srcu);
+}
+#endif
+
 enum devkmsg_log_bits {
 	__DEVKMSG_LOG_BIT_ON = 0,
 	__DEVKMSG_LOG_BIT_OFF,
@@ -219,6 +227,32 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
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
@@ -2989,6 +3023,14 @@ void console_stop(struct console *console)
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All contexts must
+	 * be able to see that this console is disabled so that (for example)
+	 * the caller can suspend the port without risk of another context
+	 * using the port.
+	 */
+	synchronize_srcu(&console_srcu);
 }
 EXPORT_SYMBOL(console_stop);
 
@@ -3179,6 +3221,17 @@ void register_console(struct console *newcon)
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
@@ -3187,28 +3240,24 @@ void register_console(struct console *newcon)
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
+	/*
+	 * No need to synchronize SRCU here! The caller does not rely
+	 * on all contexts being able to see the new console before
+	 * register_console() completes.
+	 */
+
 	console_sysfs_notify();
 
 	/*
@@ -3254,7 +3303,7 @@ int unregister_console(struct console *console)
 		return -ENODEV;
 	}
 
-	hlist_del_init(&console->node);
+	hlist_del_init_rcu(&console->node);
 
 	/*
 	 * <HISTORICAL>
@@ -3269,6 +3318,14 @@ int unregister_console(struct console *console)
 		console_first()->flags |= CON_CONSDEV;
 
 	console_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All contexts
+	 * must not be able to see this console in the list so that any
+	 * exit/cleanup routines can be performed safely.
+	 */
+	synchronize_srcu(&console_srcu);
+
 	console_sysfs_notify();
 
 	if (console->exit)
-- 
2.30.2

