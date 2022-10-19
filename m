Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E5604AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiJSPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiJSPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:06:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A69479620;
        Wed, 19 Oct 2022 07:59:31 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXcesGHiS9CJwBLB5AtQkJ+SjPh3MNkbA2I4bHFlwT4=;
        b=vyVdNsmDCOtZ1td7FZJE2kL0NFcmHJkDeb8tBWR6iDUAHMNtB/gaxUaCu7IOuYDjCtdTGf
        7JMy3AFlQHUwJVxxWRF61DKsEUyqZRkxV7auxPl3IWWrfKeqXCbTFP1XCjq4+t36WbX9n3
        Lk0u97wao4rNY5seMwaeTD9hMMmwwZAO7FNkBian35LLG7JI5kr+LIiauXac/JHyFLh0oS
        0bab60tCRUjG95HHblokpeEUA2qyzG6Wp6FwAKRehYx7odX+BRLntV+unpa7brXAp90riX
        g0saBHF8isP/h2pPYkiVRR0qX2oN2XOyv2ogU5splu0VZKufFuAm+1ETP7yO7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aXcesGHiS9CJwBLB5AtQkJ+SjPh3MNkbA2I4bHFlwT4=;
        b=3KenGGEQ+2eWZ5r+4AzHNAE//1dUZSpARbtG8UMeJGjl8XQGUV1nPPSymknxmfh1mJh3sK
        E+W71aY0Z0vk/3Bg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tom Rix <trix@redhat.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH printk v2 38/38] printk, xen: fbfront: create/use safe function for forcing preferred
Date:   Wed, 19 Oct 2022 17:02:00 +0206
Message-Id: <20221019145600.1282823-39-john.ogness@linutronix.de>
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

With commit 9e124fe16ff2("xen: Enable console tty by default in domU
if it's not a dummy") a hack was implemented to make sure that the
tty console remains the console behind the /dev/console device. The
main problem with the hack is that, after getting the console pointer
to the tty console, it is assumed the pointer is still valid after
releasing the console_sem. This assumption is incorrect and unsafe.

Make the hack safe by introducing a new function
console_force_preferred() to perform the full operation under
the console_list_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/video/fbdev/xen-fbfront.c |  8 +---
 include/linux/console.h           |  1 +
 kernel/printk/printk.c            | 69 +++++++++++++++++++------------
 3 files changed, 46 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
index 2552c853c6c2..aa362b25a60f 100644
--- a/drivers/video/fbdev/xen-fbfront.c
+++ b/drivers/video/fbdev/xen-fbfront.c
@@ -512,12 +512,8 @@ static void xenfb_make_preferred_console(void)
 	}
 	console_srcu_read_unlock(cookie);
 
-	if (c) {
-		unregister_console(c);
-		c->flags |= CON_CONSDEV;
-		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
-		register_console(c);
-	}
+	if (c)
+		console_force_preferred(c);
 }
 
 static int xenfb_resume(struct xenbus_device *dev)
diff --git a/include/linux/console.h b/include/linux/console.h
index bf1e8136424a..41378b00bbdd 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -235,6 +235,7 @@ enum con_flush_mode {
 };
 
 extern int add_preferred_console(char *name, int idx, char *options);
+extern void console_force_preferred(struct console *c);
 extern void register_console(struct console *);
 extern int unregister_console(struct console *);
 extern void console_lock(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 840d581c4b23..9a056a42b8d8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3207,38 +3207,17 @@ static void try_enable_default_console(struct console *newcon)
 
 static int unregister_console_locked(struct console *console);
 
-/*
- * The console driver calls this routine during kernel initialization
- * to register the console printing procedure with printk() and to
- * print any messages that were printed by the kernel before the
- * console driver was initialized.
- *
- * This can happen pretty early during the boot process (because of
- * early_printk) - sometimes before setup_arch() completes - be careful
- * of what kernel features are used - they may not be initialised yet.
- *
- * There are two types of consoles - bootconsoles (early_printk) and
- * "real" consoles (everything which is not a bootconsole) which are
- * handled differently.
- *  - Any number of bootconsoles can be registered at any time.
- *  - As soon as a "real" console is registered, all bootconsoles
- *    will be unregistered automatically.
- *  - Once a "real" console is registered, any attempt to register a
- *    bootconsoles will be rejected
- */
-void register_console(struct console *newcon)
+static void register_console_locked(struct console *newcon)
 {
 	struct console *con;
 	bool bootcon_enabled = false;
 	bool realcon_enabled = false;
 	int err;
 
-	console_list_lock();
-
 	for_each_console(con) {
 		if (WARN(con == newcon, "console '%s%d' already registered\n",
 					 con->name, con->index)) {
-			goto unlock;
+			return;
 		}
 
 		if (con->flags & CON_BOOT)
@@ -3251,7 +3230,7 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_BOOT && realcon_enabled) {
 		pr_info("Too late to register bootconsole %s%d\n",
 			newcon->name, newcon->index);
-		goto unlock;
+		return;
 	}
 
 	/*
@@ -3282,7 +3261,7 @@ void register_console(struct console *newcon)
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL)
-		goto unlock;
+		return;
 
 	/*
 	 * If we have a bootconsole, and are switching to a real console,
@@ -3346,7 +3325,31 @@ void register_console(struct console *newcon)
 				unregister_console_locked(con);
 		}
 	}
-unlock:
+}
+
+/*
+ * The console driver calls this routine during kernel initialization
+ * to register the console printing procedure with printk() and to
+ * print any messages that were printed by the kernel before the
+ * console driver was initialized.
+ *
+ * This can happen pretty early during the boot process (because of
+ * early_printk) - sometimes before setup_arch() completes - be careful
+ * of what kernel features are used - they may not be initialised yet.
+ *
+ * There are two types of consoles - bootconsoles (early_printk) and
+ * "real" consoles (everything which is not a bootconsole) which are
+ * handled differently.
+ *  - Any number of bootconsoles can be registered at any time.
+ *  - As soon as a "real" console is registered, all bootconsoles
+ *    will be unregistered automatically.
+ *  - Once a "real" console is registered, any attempt to register a
+ *    bootconsoles will be rejected
+ */
+void register_console(struct console *newcon)
+{
+	console_list_lock();
+	register_console_locked(newcon);
 	console_list_unlock();
 }
 EXPORT_SYMBOL(register_console);
@@ -3411,6 +3414,20 @@ int unregister_console(struct console *console)
 }
 EXPORT_SYMBOL(unregister_console);
 
+void console_force_preferred(struct console *c)
+{
+	console_list_lock();
+
+	if (unregister_console_locked(c) == 0) {
+		c->flags |= CON_CONSDEV;
+		c->flags &= ~CON_PRINTBUFFER; /* don't print again */
+		register_console_locked(c);
+	}
+
+	console_list_unlock();
+}
+EXPORT_SYMBOL(console_force_preferred);
+
 /*
  * Initialize the console device. This is called *early*, so
  * we can't necessarily depend on lots of kernel help here.
-- 
2.30.2

