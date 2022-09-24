Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD2F5E8684
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiIXAFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiIXAFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51119A2220
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfVMZJNRNmUcXs0AcEgf8PmYZBx9ybi5NZy3duOSBFA=;
        b=Zow98vZHUhmdqMsJES3M8pCx7McItBn90Y/GKqk3vKRNbclqVUaov3IAkPienr20Ndlrxu
        tYBHN9v1A4lJ0U8xdPow1fcAHflWhjwTXU+GNT3/goFE8SgWLeDIWCKXfmv6nhT6pp4jhK
        MQeBQsq0B3rpi/gOn/n1cbHN2dHAxr4ZK8YRQJk12mMH3tvrUGNflxfBrYQ7fC212nSzpU
        vC8OXucQG03GD5u0f9R5nhZhGmvXqjVBRdhae9d9oupqMd5XZ4Vbu/ekXePHk7HhNBNl6U
        aBXR2vC9C0nWcmS/clVrc1wwPs3dMYnIPTJKA0rD40OABRS11H0FrmrRSRKxSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfVMZJNRNmUcXs0AcEgf8PmYZBx9ybi5NZy3duOSBFA=;
        b=qb7loi7gRnwUl6Y/52LX2Rz/INvaxFAKfEz5BoDrnfE/NNdN0SBbAXEool0QD9LHVeRXYZ
        dXfaJ+cbHx2U9IBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 12/18] printk: Prepare for SCRU console list protection
Date:   Sat, 24 Sep 2022 02:10:48 +0206
Message-Id: <20220924000454.3319186-13-john.ogness@linutronix.de>
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

Provide a SRCU protected variant to walk the console list.

Preperatory change for a new console infrastructure which operates
independent of console BKL.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 14 +++++++++++++-
 kernel/printk/printk.c  | 16 +++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 1e3d0a50cef1..dc0df9d9e7d9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,7 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
-#include <linux/list.h>
+#include <linux/rculist.h>
 #include <linux/types.h>
 
 struct vc_data;
@@ -161,6 +161,7 @@ struct console {
 #ifdef CONFIG_LOCKDEP
 extern void lockdep_assert_console_lock_held(void);
 extern void lockdep_assert_console_list_lock_held(void);
+extern bool console_srcu_read_lock_is_held(void);
 #else
 static inline void lockdep_assert_console_lock_held(void) { }
 static inline void lockdep_assert_console_list_lock_held(void) { }
@@ -171,6 +172,17 @@ extern struct hlist_head console_list;
 extern void console_list_lock(void) __acquires(console_mutex);
 extern void console_list_unlock(void) __releases(console_mutex);
 
+/**
+ * for_each_console_srcu() - Iterator over registered consoles
+ * @con:	struct console pointer used as loop cursor
+ *
+ * Requires console_srcu_read_lock to be held. Can be invoked from
+ * any context.
+ */
+#define for_each_console_srcu(con)					\
+	hlist_for_each_entry_srcu(con, &console_list, node,		\
+				  console_srcu_read_lock_is_held())
+
 /**
  * for_each_registered_console() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f1d31dcbd6ba..7e6d1cd34452 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -93,6 +93,7 @@ static DEFINE_MUTEX(console_mutex);
 static DEFINE_SEMAPHORE(console_sem);
 HLIST_HEAD(console_list);
 EXPORT_SYMBOL_GPL(console_list);
+DEFINE_STATIC_SRCU(console_srcu);
 
 /*
  * System may need to suppress printk message under certain
@@ -121,6 +122,10 @@ void lockdep_assert_console_list_lock_held(void)
 	lockdep_assert_held(&console_mutex);
 }
 
+bool console_srcu_read_lock_is_held(void)
+{
+	return srcu_read_lock_held(&console_srcu);
+}
 #endif
 
 enum devkmsg_log_bits {
@@ -3232,9 +3237,9 @@ void register_console(struct console *newcon)
 	 */
 	console_lock();
 	if (newcon->flags & CON_CONSDEV || hlist_empty(&console_list))
-		hlist_add_head(&newcon->node, &console_list);
+		hlist_add_head_rcu(&newcon->node, &console_list);
 	else
-		hlist_add_behind(&newcon->node, console_list.first);
+		hlist_add_behind_rcu(&newcon->node, console_list.first);
 
 	/* Ensure this flag is always set for the head of the list */
 	cons_first()->flags |= CON_CONSDEV;
@@ -3250,6 +3255,7 @@ void register_console(struct console *newcon)
 		newcon->seq = prb_next_seq(prb);
 	}
 	console_unlock();
+	/* No need to synchronize SRCU here! */
 	console_sysfs_notify();
 
 	/*
@@ -3295,7 +3301,7 @@ static int console_unregister_locked(struct console *console)
 	if (hlist_unhashed(&console->node))
 		goto out_unlock;
 
-	hlist_del_init(&console->node);
+	hlist_del_init_rcu(&console->node);
 
 	/*
 	 * <HISTORICAL>
@@ -3310,6 +3316,10 @@ static int console_unregister_locked(struct console *console)
 		cons_first()->flags |= CON_CONSDEV;
 
 	console_unlock();
+
+	/* Ensure that all SRCU list walks have completed */
+	synchronize_srcu(&console_srcu);
+
 	console_sysfs_notify();
 
 	if (console->exit)
-- 
2.30.2

