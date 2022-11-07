Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AAD61F5B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiKGOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbiKGOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38191D657
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:59 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ntEDPcr5gl/sGw5Dmqd2ISJ+9btMVLz4NUDJ5QQuQk=;
        b=Psrm3reZr9kysl9Tn1lMLhsfY5qgTs72dx39Z6TUhfscMIiI995txF022+vSD5ubntOOra
        Lk7d9/OReZRm3NO5slsFYAGRDlkIuIdmKVORh8P/5rOlpDCtj4pI7wgrKOFcDmY5RrytQ7
        DMmvCxfhKvJUKTIV1QC/nxp0pouW2jG61Fs+YhHj6VGkMaAdMbELRvMPsZEVnJVKFMBdxK
        4LEHJqSO5RYZb/bOVC3ku3CSNenc5aoSwbYarq9jcJU4lavnhL8K8hrNF9aqHLwjE/7VWz
        3KMgrY6mHKNv2TutR6wldCW0Yf4+C1QJpoSDN5ICiEx7Lp+0MPN8/+Evd7t1AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ntEDPcr5gl/sGw5Dmqd2ISJ+9btMVLz4NUDJ5QQuQk=;
        b=TK0lbEVUCLYouE80PFUcyh3vWELMzkrRwFJphk6baU7GQtFKsT+iJFiBdoAfONEK2P50Yz
        ubFP0L2Gq5F/MPAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 39/40] printk: relieve console_lock of list synchronization duties
Date:   Mon,  7 Nov 2022 15:22:37 +0106
Message-Id: <20221107141638.3790965-40-john.ogness@linutronix.de>
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

The console_list_lock provides synchronization for console list and
console->flags updates. All call sites that were using the console_lock
for this synchronization have either switched to use the
console_list_lock or the SRCU list iterator.

Remove console_lock usage for console list updates and console->flags
updates.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d74e6e609f7d..17765166ac42 100644
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
@@ -2638,10 +2638,10 @@ static int console_cpu_notify(unsigned int cpu)
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
@@ -2658,10 +2658,10 @@ void console_lock(void)
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
@@ -2917,10 +2917,10 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
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
@@ -3107,9 +3107,7 @@ void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
-	console_lock();
 	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
-	console_unlock();
 	console_list_unlock();
 
 	/*
@@ -3125,9 +3123,7 @@ EXPORT_SYMBOL(console_stop);
 void console_start(struct console *console)
 {
 	console_list_lock();
-	console_lock();
 	WRITE_ONCE(console->flags, console->flags | CON_ENABLED);
-	console_unlock();
 	console_list_unlock();
 	__pr_flush(console, 1000, true);
 }
@@ -3344,7 +3340,6 @@ void register_console(struct console *newcon)
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
 	 */
-	console_lock();
 	if (hlist_empty(&console_list)) {
 		/* Ensure CON_CONSDEV is always set for the head. */
 		newcon->flags |= CON_CONSDEV;
@@ -3358,7 +3353,6 @@ void register_console(struct console *newcon)
 	} else {
 		hlist_add_behind_rcu(&newcon->node, console_list.first);
 	}
-	console_unlock();
 
 	/*
 	 * No need to synchronize SRCU here! The caller does not rely
@@ -3406,15 +3400,11 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
-	console_lock();
-
 	/* Disable it unconditionally */
 	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
 
-	if (!console_is_registered_locked(console)) {
-		console_unlock();
+	if (!console_is_registered_locked(console))
 		return -ENODEV;
-	}
 
 	hlist_del_init_rcu(&console->node);
 
@@ -3430,8 +3420,6 @@ static int unregister_console_locked(struct console *console)
 	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
 		WRITE_ONCE(console_first()->flags, console_first()->flags | CON_CONSDEV);
 
-	console_unlock();
-
 	/*
 	 * Ensure that all SRCU list walks have completed. All contexts
 	 * must not be able to see this console in the list so that any
-- 
2.30.2

