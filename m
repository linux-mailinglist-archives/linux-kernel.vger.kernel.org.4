Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E8628550
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbiKNQa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbiKNQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E452EB1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:40 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNQONpXKLQCgtojOiA7woSE6WWehDrB23B3xD86mEsY=;
        b=SGGd/1Vc58i2rYuzhVWBqWHjszRgMZhvnT3oKayx2GYx8/INV2Ype+7smcVWafRhlvCjsV
        dlFlOD2YIZru6VoP5bfq3KHTWxneCjpgDPUU9FZJdE7VdnZaIXcn8lOQuWonP1wUE55SJl
        aZ4ElXS0zoytLriQLgKBm7W73gXDCXsEC59rX+unP1M5AFR4iZDC6LBRFi6t8y/5QCHMut
        TuWpzZ8aHePjJGNKLFOA0+fzo4jQKvBrX6zgklJzVNXkru+1+Cnlu3wWqsM45ZBifxCAx3
        7bwI4GqLAZJmhqMXHwyGVxz7VDih4xcq+QimpQXvQrJJcae3W2WvtgWVKqO5Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yNQONpXKLQCgtojOiA7woSE6WWehDrB23B3xD86mEsY=;
        b=xwbmKegzg6Lrvh1pBjkU3Brmk9CyefQmno6CuRD8GILGq6wDoOyIK4OWzsLrOE4M32qFvf
        kMk6pMrHBfUsxTBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 11/39] console: introduce wrappers to read/write console flags
Date:   Mon, 14 Nov 2022 17:35:04 +0106
Message-Id: <20221114162932.141883-12-john.ogness@linutronix.de>
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

After switching to SRCU for console list iteration, some readers
will begin readings console->flags as a data race. Locklessly
reading console->flags provides a consistent value because there
is at most one CPU modifying console->flags and that CPU is
using only read-modify-write operations.

Introduce a wrapper for SRCU iterators to read console flags.
Introduce a matching wrapper to write to flags of registered
consoles. Writing to flags of registered consoles is synchronized
by the console_list_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 45 +++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c  | 10 ++++-----
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 24d83e24840b..c1ca461d088a 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -183,6 +183,51 @@ extern void console_list_unlock(void) __releases(console_mutex);
 
 extern struct hlist_head console_list;
 
+/**
+ * console_srcu_read_flags - Locklessly read the console flags
+ * @con:	struct console pointer of console to read flags from
+ *
+ * This function provides the necessary READ_ONCE() and data_race()
+ * notation for locklessly reading the console flags. The READ_ONCE()
+ * in this function matches the WRITE_ONCE() when @flags are modified
+ * for registered consoles with console_srcu_write_flags().
+ *
+ * Only use this function to read console flags when locklessly
+ * iterating the console list via srcu.
+ *
+ * Context: Any context.
+ */
+static inline short console_srcu_read_flags(const struct console *con)
+{
+	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
+
+	/*
+	 * Locklessly reading console->flags provides a consistent
+	 * read value because there is at most one CPU modifying
+	 * console->flags and that CPU is using only read-modify-write
+	 * operations to do so.
+	 */
+	return data_race(READ_ONCE(con->flags));
+}
+
+/**
+ * console_srcu_write_flags - Write flags for a registered console
+ * @con:	struct console pointer of console to write flags to
+ * @flags:	new flags value to write
+ *
+ * Only use this function to write flags for registered consoles. It
+ * requires holding the console_list_lock.
+ *
+ * Context: Any context.
+ */
+static inline void console_srcu_write_flags(struct console *con, short flags)
+{
+	lockdep_assert_console_list_lock_held();
+
+	/* This matches the READ_ONCE() in console_srcu_read_flags(). */
+	WRITE_ONCE(con->flags, flags);
+}
+
 /**
  * for_each_console_srcu() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index e3f81dda5b09..41c90b768c1c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3068,7 +3068,7 @@ void console_stop(struct console *console)
 	__pr_flush(console, 1000, true);
 	console_list_lock();
 	console_lock();
-	console->flags &= ~CON_ENABLED;
+	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 	console_unlock();
 	console_list_unlock();
 
@@ -3086,7 +3086,7 @@ void console_start(struct console *console)
 {
 	console_list_lock();
 	console_lock();
-	console->flags |= CON_ENABLED;
+	console_srcu_write_flags(console, console->flags | CON_ENABLED);
 	console_unlock();
 	console_list_unlock();
 	__pr_flush(console, 1000, true);
@@ -3314,7 +3314,7 @@ void register_console(struct console *newcon)
 
 	} else if (newcon->flags & CON_CONSDEV) {
 		/* Only the new head can have CON_CONSDEV set. */
-		console_first()->flags &= ~CON_CONSDEV;
+		console_srcu_write_flags(console_first(), console_first()->flags & ~CON_CONSDEV);
 		hlist_add_head_rcu(&newcon->node, &console_list);
 
 	} else {
@@ -3371,7 +3371,7 @@ static int unregister_console_locked(struct console *console)
 	console_lock();
 
 	/* Disable it unconditionally */
-	console->flags &= ~CON_ENABLED;
+	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 
 	if (hlist_unhashed(&console->node)) {
 		console_unlock();
@@ -3390,7 +3390,7 @@ static int unregister_console_locked(struct console *console)
 	 * console has any device attached. Oh well....
 	 */
 	if (!hlist_empty(&console_list) && console->flags & CON_CONSDEV)
-		console_first()->flags |= CON_CONSDEV;
+		console_srcu_write_flags(console_first(), console_first()->flags | CON_CONSDEV);
 
 	console_unlock();
 
-- 
2.30.2

