Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809CB604A95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiJSPG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiJSPFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3D2DC6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:59:21 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERAmScBWw3AWOQd/N8KPYvjMNho4M2d8wqoVxvpkojg=;
        b=p7EHFUdVULSPTa08I7V4W4rGuOGZwbKXMbpmy7FQ/hM/Akq2VHbWOybQyOPaIOQrMynit4
        ej7WV/9P69E8eZBOhLDiLJlrtilFtFK9XGJgoWlTrZNjwAdU/JWjcQgAlEaOPb4G1nWl5b
        TReEvqMia7ozppHpRIsh6OEWPdoTOkcPeJH4N8SEI0A/MzxlshaDMF13LQKP1TnMI+ubx9
        Xl4NboHNjl6nuEPXtwS+kozYdOGmAF+ePdeob47Ak0wL6PRzU1obyGe39bWtW3Iy7oJVyD
        Vkv8yDL44DmJ8w3tppP5p/BE8zRaOFrxQ6dZE4JLY+ict0Hs+OTjbOcit2hpwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ERAmScBWw3AWOQd/N8KPYvjMNho4M2d8wqoVxvpkojg=;
        b=XSBfRYfXfVmjl1gxZkSLwF2XwQJDPNi9TKXi2UryMFR1GEHWj2Cu4NTSvRskEHY/1hTm0t
        8ZS0wYOq2I7A30BQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 37/38] printk: relieve console_lock of list synchronization duties
Date:   Wed, 19 Oct 2022 17:01:59 +0206
Message-Id: <20221019145600.1282823-38-john.ogness@linutronix.de>
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

The console_list_lock provides synchronization for console list and
console->flags updates. All call sites that were using the console_lock
for this synchronization have either switched to use the
console_list_lock or the SRCU list iterator.

Remove console_lock usage for console list updates and console->flags
updates.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 3615ee6d68fd..840d581c4b23 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -82,8 +82,8 @@ EXPORT_SYMBOL(oops_in_progress);
 static DEFINE_MUTEX(console_mutex);
 
 /*
- * console_sem protects console_list and console->flags updates, and also
- * provides serialization for access to the entire console driver system.
+ * console_sem protects updates to console->seq and console_suspended,
+ * and also provides serialization for console printing.
  */
 static DEFINE_SEMAPHORE(console_sem);
 HLIST_HEAD(console_list);
@@ -2635,7 +2635,7 @@ static int console_cpu_notify(unsigned int cpu)
  * console_lock - lock the console system for exclusive use.
  *
  * Acquires a lock which guarantees that the caller has
- * exclusive access to the console system and console_list.
+ * exclusive access to the console system.
  *
  * Can sleep, returns nothing.
  */
@@ -2655,7 +2655,7 @@ EXPORT_SYMBOL(console_lock);
  * console_trylock - try to lock the console system for exclusive use.
  *
  * Try to acquire a lock which guarantees that the caller has exclusive
- * access to the console system and console_list.
+ * access to the console system.
  *
  * returns 1 on success, and 0 on failure to acquire the lock.
  */
@@ -2911,8 +2911,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 /**
  * console_unlock - unlock the console system
  *
- * Releases the console_lock which the caller holds on the console system
- * and the console driver list.
+ * Releases the console_lock which the caller holds on the console system.
  *
  * While the console_lock was held, console output may have been buffered
  * by printk().  If this is the case, console_unlock(); emits
@@ -3098,9 +3097,7 @@ void console_stop(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
-	console_lock();
 	console->flags &= ~CON_ENABLED;
-	console_unlock();
 	console_list_unlock();
 
 	/* Ensure that all SRCU list walks have completed */
@@ -3111,9 +3108,7 @@ EXPORT_SYMBOL(console_stop);
 void console_start(struct console *console)
 {
 	console_list_lock();
-	console_lock();
 	console->flags |= CON_ENABLED;
-	console_unlock();
 	console_list_unlock();
 	__pr_flush(console, 1000, true);
 }
@@ -3315,7 +3310,6 @@ void register_console(struct console *newcon)
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
 	 */
-	console_lock();
 	if (hlist_empty(&console_list)) {
 		/* Ensure CON_CONSDEV is always set for the head. */
 		newcon->flags |= CON_CONSDEV;
@@ -3329,7 +3323,6 @@ void register_console(struct console *newcon)
 	} else {
 		hlist_add_behind_rcu(&newcon->node, console_list.first);
 	}
-	console_unlock();
 
 	/* No need to synchronize SRCU here! */
 
@@ -3370,8 +3363,6 @@ static int unregister_console_locked(struct console *console)
 	if (res > 0)
 		return 0;
 
-	console_lock();
-
 	/* Disable it unconditionally */
 	console->flags &= ~CON_ENABLED;
 
@@ -3394,8 +3385,6 @@ static int unregister_console_locked(struct console *console)
 	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
 		console_first()->flags |= CON_CONSDEV;
 
-	console_unlock();
-
 	/* Ensure that all SRCU list walks have completed */
 	synchronize_srcu(&console_srcu);
 
-- 
2.30.2

