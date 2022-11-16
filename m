Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD362C455
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiKPQ0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiKPQXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:23:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E37B58BC8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:22:18 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRaCkCeGsMszYT9s9X+v38mM38ySFiKFFQd/VYKUf0w=;
        b=e+jN8ABV45ZyfD4tNmWn90X36lOsX1xDsiVghP3TjowoogutUHte6IrzfdrMp4obJT61tz
        +hVYOpxVLufBw4bJ43rJi1DtHuYn8mNuonJkPAOOeqxX2LfoZFy5LOY5v+KzJR1EsKADvm
        RRosd2A32Jf5Vsza/2FlvBTxI09mpcvs/1ihMIO+XP8rAvhgdsAb/TKQhKCbki8DF9rfaY
        xfSuX21b9y/E9AN2XyL1DWP5dJCnS8UjQMWPjdgNU/vzw8Dszu8/9o/9lJEk0vYn0etvPb
        NDIiO5gZKAOH0ehEvyq9MrfL14hR13udM3FynxkfzBXYLjTM+dYUzEyJ3sf8SA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRaCkCeGsMszYT9s9X+v38mM38ySFiKFFQd/VYKUf0w=;
        b=L3dIG7lJdJtTQB41A4X/200Ys2o64NZ13GG/NpEMSbMANtT4ykRV6E/mKFlrHgzvhoivNk
        4hnuPRB8SHK9XEDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v5 39/40] printk: relieve console_lock of list synchronization duties
Date:   Wed, 16 Nov 2022 17:27:51 +0106
Message-Id: <20221116162152.193147-40-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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

The console_list_lock provides synchronization for console list and
console->flags updates. All call sites that were using the console_lock
for this synchronization have either switched to use the
console_list_lock or the SRCU list iterator.

Remove console_lock usage for console list updates and console->flags
updates.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 44 +++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ece34abbc9cc..094017c4a5ca 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -86,8 +86,8 @@ EXPORT_SYMBOL(oops_in_progress);
 static DEFINE_MUTEX(console_mutex);
 
 /*
- * console_sem protects console_list and console->flags updates, and also
- * provides serialization for access to the entire console driver system.
+ * console_sem protects updates to console->seq and console_suspended,
+ * and also provides serialization for console printing.
  */
 static DEFINE_SEMAPHORE(console_sem);
 HLIST_HEAD(console_list);
@@ -2639,10 +2639,10 @@ static int console_cpu_notify(unsigned int cpu)
 }
 
 /**
- * console_lock - lock the console system for exclusive use.
+ * console_lock - block the console subsystem from printing
  *
- * Acquires a lock which guarantees that the caller has
- * exclusive access to the console system and console_list.
+ * Acquires a lock which guarantees that no consoles will
+ * be in or enter their write() callback.
  *
  * Can sleep, returns nothing.
  */
@@ -2659,10 +2659,10 @@ void console_lock(void)
 EXPORT_SYMBOL(console_lock);
 
 /**
- * console_trylock - try to lock the console system for exclusive use.
+ * console_trylock - try to block the console subsystem from printing
  *
- * Try to acquire a lock which guarantees that the caller has exclusive
- * access to the console system and console_list.
+ * Try to acquire a lock which guarantees that no consoles will
+ * be in or enter their write() callback.
  *
  * returns 1 on success, and 0 on failure to acquire the lock.
  */
@@ -2919,10 +2919,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 }
 
 /**
- * console_unlock - unlock the console system
+ * console_unlock - unblock the console subsystem from printing
  *
- * Releases the console_lock which the caller holds on the console system
- * and the console driver list.
+ * Releases the console_lock which the caller holds to block printing of
+ * the console subsystem.
  *
  * While the console_lock was held, console output may have been buffered
  * by printk().  If this is the case, console_unlock(); emits
@@ -3109,9 +3109,7 @@ void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
-	console_lock();
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
-	console_unlock();
 	console_list_unlock();
 
 	/*
@@ -3127,9 +3125,7 @@ EXPORT_SYMBOL(console_stop);
 void console_start(struct console *console)
 {
 	console_list_lock();
-	console_lock();
 	console_srcu_write_flags(console, console->flags | CON_ENABLED);
-	console_unlock();
 	console_list_unlock();
 	__pr_flush(console, 1000, true);
 }
@@ -3246,6 +3242,12 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 		 * the furthest behind.
 		 */
 		if (bootcon_registered && !keep_bootcon) {
+			/*
+			 * Hold the console_lock to stop console printing and
+			 * guarantee safe access to console->seq.
+			 */
+			console_lock();
+
 			/*
 			 * Flush all consoles and set the console to start at
 			 * the next unprinted sequence number.
@@ -3272,6 +3274,8 @@ static void console_init_seq(struct console *newcon, bool bootcon_registered)
 					}
 				}
 			}
+
+			console_unlock();
 		}
 	}
 }
@@ -3370,7 +3374,6 @@ void register_console(struct console *newcon)
 	}
 
 	newcon->dropped = 0;
-	console_lock();
 	console_init_seq(newcon, bootcon_registered);
 
 	/*
@@ -3390,7 +3393,6 @@ void register_console(struct console *newcon)
 	} else {
 		hlist_add_behind_rcu(&newcon->node, console_list.first);
 	}
-	console_unlock();
 
 	/*
 	 * No need to synchronize SRCU here! The caller does not rely
@@ -3438,15 +3440,11 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
-	console_lock();
-
 	/* Disable it unconditionally */
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 
-	if (!console_is_registered_locked(console)) {
-		console_unlock();
+	if (!console_is_registered_locked(console))
 		return -ENODEV;
-	}
 
 	hlist_del_init_rcu(&console->node);
 
@@ -3462,8 +3460,6 @@ static int unregister_console_locked(struct console *console)
 	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
 		console_srcu_write_flags(console_first(), console_first()->flags | CON_CONSDEV);
 
-	console_unlock();
-
 	/*
 	 * Ensure that all SRCU list walks have completed. All contexts
 	 * must not be able to see this console in the list so that any
-- 
2.30.2

