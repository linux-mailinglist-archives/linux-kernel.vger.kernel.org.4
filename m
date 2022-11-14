Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D49B62857D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiKNQcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiKNQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96BC2F642
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:52 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8qnAfFTCJMXSmY0z9NbV6BFCys+Bgcrek19V+DaSP4=;
        b=SVbG4PEKxAfH1E92FMTtE9BRZSIjc27GBLM2VkhgVtSRrzxNzR+aTM/aj0phkPxO7Rt/yY
        kzAjig+wcjxC+AmDMHmPxDPYPwbNT0XvqlmF0++7F/c916y6Kn0O2jIJRkPfECvyhWECev
        dI9lj/FxcerEjNO07uBv8QSAMRStiDR9Qe5s1SER/kk11wr288ZPxVpA1vz5NZ+sGiiDcz
        nIp+xNOvK2zsK2ktiJuieYIiR+MhHHECfpwq8TRAoEomSR/OcP2tyhZq1cgIFpqzEA9JcG
        rZM7q7LrQX8UssNG4FpuEmHQoCSerkvbQ+PDbtTKhrk49rS/OiaS+n0A/092sA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8qnAfFTCJMXSmY0z9NbV6BFCys+Bgcrek19V+DaSP4=;
        b=IdXS+nHY6Hxx42ohYDYs3dMXShPYMab1+9r7Y2/TXhfUnf3OSGQ3URpdqRepwgEn7592sy
        qruYH2a1Ng+xJyBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 38/39] printk: relieve console_lock of list synchronization duties
Date:   Mon, 14 Nov 2022 17:35:31 +0106
Message-Id: <20221114162932.141883-39-john.ogness@linutronix.de>
In-Reply-To: <20221114162932.141883-1-john.ogness@linutronix.de>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
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
 kernel/printk/printk.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dff76c1cef80..8d635467882f 100644
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
@@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
 		 * boot console that is the furthest behind.
 		 */
 		if (bootcon_registered && !keep_bootcon) {
+			/*
+			 * Hold the console_lock to guarantee safe access to
+			 * console->seq.
+			 */
+			console_lock();
 			for_each_console(con) {
 				if ((con->flags & CON_BOOT) &&
 				    (con->flags & CON_ENABLED) &&
@@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
 					newcon->seq = con->seq;
 				}
 			}
+			console_unlock();
 		}
 	}
 
@@ -3348,7 +3350,6 @@ void register_console(struct console *newcon)
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
 	 */
-	console_lock();
 	if (hlist_empty(&console_list)) {
 		/* Ensure CON_CONSDEV is always set for the head. */
 		newcon->flags |= CON_CONSDEV;
@@ -3362,7 +3363,6 @@ void register_console(struct console *newcon)
 	} else {
 		hlist_add_behind_rcu(&newcon->node, console_list.first);
 	}
-	console_unlock();
 
 	/*
 	 * No need to synchronize SRCU here! The caller does not rely
@@ -3410,15 +3410,11 @@ static int unregister_console_locked(struct console *console)
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
 
@@ -3434,8 +3430,6 @@ static int unregister_console_locked(struct console *console)
 	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
 		console_srcu_write_flags(console_first(), console_first()->flags | CON_CONSDEV);
 
-	console_unlock();
-
 	/*
 	 * Ensure that all SRCU list walks have completed. All contexts
 	 * must not be able to see this console in the list so that any
-- 
2.30.2

