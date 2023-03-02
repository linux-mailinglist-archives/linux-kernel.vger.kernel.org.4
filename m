Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672296A89E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCBT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCBT5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:57:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CEE474E3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:57:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9tOYyS2PzrZZNPqHz2RZVi/VNmEwSgQ/BXnraEltaw=;
        b=t7LjSSSEITvx8kbiv5CVXv2TXdNm6VXkiTcPhTMnFJX4uIr7wF06FV5+xsBpNoi8RF6APL
        UO2YbBOrbzGF/RMFHD+y8k1VuMeEzXW42wTe98I556VXsXrPWorh0w3dwAcO2Rwf4Vxgkd
        I3enyGsYKtohM4C8uiKqw3hL//CQ8usus0d4Il4sQZK30JSxgfQ8QbCpygTMbOsDtRJTeJ
        Fk+vKkKIejQ3e6s8f8TnxJ/kazi1uJky+fO9DpowvQunD4NR/+aCzJ+p7peDZ37PlzKSH9
        mCK0vzr1g86tZ39IPMVc2Vo3iU3nFyewTWe7vUwFXdm+rNqrX4szqlm9ejBNtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677787063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9tOYyS2PzrZZNPqHz2RZVi/VNmEwSgQ/BXnraEltaw=;
        b=JM39akAot7pRoHec+7jJQXSabDYbtHF8CZ6R6xuPk+UspGwDe0FQfGbU+lqt/abGpZprEb
        eBv9KM06PZPGPvDA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v1 04/18] printk: Add per-console suspended state
Date:   Thu,  2 Mar 2023 21:02:04 +0106
Message-Id: <20230302195618.156940-5-john.ogness@linutronix.de>
In-Reply-To: <20230302195618.156940-1-john.ogness@linutronix.de>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
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

Currently the global @console_suspended is used to determine if
consoles are in a suspended state. Its primary purpose is to allow
usage of the console_lock when suspended without causing console
printing. It is synchronized by the console_lock.

Rather than relying on the console_lock to determine suspended
state, make it an official per-console state that is set within
console->flags. This allows the state to be queried via SRCU.

@console_suspended will continue to exist, but now only to implement
the console_lock/console_unlock trickery and _not_ to represent
the suspend state of a particular console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h |  3 +++
 kernel/printk/printk.c  | 46 ++++++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 1e36958aa656..f7967fb238e0 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -153,6 +153,8 @@ static inline int con_debug_leave(void)
  *			receiving the printk spam for obvious reasons.
  * @CON_EXTENDED:	The console supports the extended output format of
  *			/dev/kmesg which requires a larger output buffer.
+ * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
+ *			printing callbacks must not be called.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -162,6 +164,7 @@ enum cons_flags {
 	CON_ANYTIME		= BIT(4),
 	CON_BRL			= BIT(5),
 	CON_EXTENDED		= BIT(6),
+	CON_SUSPENDED		= BIT(7),
 };
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bdeaf12e0bd2..626d467c7e9b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2563,10 +2563,26 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
  */
 void suspend_console(void)
 {
+	struct console *con;
+
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 	pr_flush(1000, true);
+
+	console_list_lock();
+	for_each_console(con)
+		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All printing
+	 * contexts must be able to see that they are suspended so that it
+	 * is guaranteed that all printing has stopped when this function
+	 * completes.
+	 */
+	synchronize_srcu(&console_srcu);
+
 	console_lock();
 	console_suspended = 1;
 	up_console_sem();
@@ -2574,11 +2590,26 @@ void suspend_console(void)
 
 void resume_console(void)
 {
+	struct console *con;
+
 	if (!console_suspend_enabled)
 		return;
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
+
+	console_list_lock();
+	for_each_console(con)
+		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All printing
+	 * contexts must be able to see they are no longer suspended so
+	 * that they are guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
 	pr_flush(1000, true);
 }
 
@@ -2681,6 +2712,9 @@ static inline bool console_is_usable(struct console *con)
 	if (!(flags & CON_ENABLED))
 		return false;
 
+	if ((flags & CON_SUSPENDED))
+		return false;
+
 	if (!con->write)
 		return false;
 
@@ -3695,8 +3729,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 		/*
 		 * Hold the console_lock to guarantee safe access to
-		 * console->seq and to prevent changes to @console_suspended
-		 * until all consoles have been processed.
+		 * console->seq.
 		 */
 		console_lock();
 
@@ -3712,14 +3745,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		}
 		console_srcu_read_unlock(cookie);
 
-		/*
-		 * If consoles are suspended, it cannot be expected that they
-		 * make forward progress, so timeout immediately. @diff is
-		 * still used to return a valid flush status.
-		 */
-		if (console_suspended)
-			remaining = 0;
-		else if (diff != last_diff && reset_on_progress)
+		if (diff != last_diff && reset_on_progress)
 			remaining = timeout_ms;
 
 		console_unlock();
-- 
2.30.2

