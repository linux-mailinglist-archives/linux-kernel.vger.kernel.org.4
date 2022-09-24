Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF35E8689
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiIXAGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbiIXAFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:05:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C297D33CA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:05:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663977904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNgrSZ2OGE1ZcTDR6ScZab8YT3+EG0Nnd7/A9t2uS7k=;
        b=XKNIg73wEnHG16+eSKTWfVTJUDOSUZQD9/ZQ1qxyh5+kmutvwlSuAM+g4UmR/Kh4/h3Lwy
        gB8N0T+ADUxZfG0r0wgO9T7Banvn+zOL5qTP1uju825a4ZUhEgGizR2t7FEMQDCbtBeB2S
        pie+UB/SuRjH3o/g7NoOv/LYWjkcMgVOk6q1JFyxfv6KiajRjR5Pwc030CrZQKlMBfKULC
        Bftp6qKO6KMFMLvtr43s5etqK8aVen8+c7YJBp3TGvSrNxD7gjI0Iad6mLL9jOoC4Uoh3F
        X41AEll5jRiKyGP8bhhtpgRcQN4tgW0Qatdwn8IcXSJ1FBXGQfqYO4ICEyOmGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663977904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNgrSZ2OGE1ZcTDR6ScZab8YT3+EG0Nnd7/A9t2uS7k=;
        b=6hiCZndz3RSsX6T+VCzGWe1MeMk4920P8DOw2MA+k5VJgmXxoJJFxzWWqJsOXdcK448BAn
        YODkZ67swoUsRkAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk 14/18] printk: Document struct console
Date:   Sat, 24 Sep 2022 02:10:50 +0206
Message-Id: <20220924000454.3319186-15-john.ogness@linutronix.de>
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

Add docbook comments to struct console.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/console.h | 95 +++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3bb5bc62e154..8ec24fe097d3 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/rculist.h>
 #include <linux/types.h>
 
@@ -139,37 +140,77 @@ static inline int con_debug_leave(void)
 /*
  * The interface for a console, or any other device that wants to capture
  * console messages (printer driver?)
- *
- * If a console driver is marked CON_BOOT then it will be auto-unregistered
- * when the first real console is registered.  This is for early-printk drivers.
  */
 
-#define CON_PRINTBUFFER	(1)
-#define CON_CONSDEV	(2) /* Preferred console, /dev/console */
-#define CON_ENABLED	(4)
-#define CON_BOOT	(8)
-#define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
-#define CON_BRL		(32) /* Used for a braille device */
-#define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
+/**
+ * cons_flags - General console flags
+ * @CON_PRINTBUFFER:	On register, start from the oldest dmesg record
+ * @CON_CONSDEV:	Questionable historical leftover to denote which console
+ *			driver is the preferred console which is defining what
+ *			backs up /dev/console
+ * @CON_ENABLED:	Indicates if a console is allowed to print records. If false,
+ *			the console also will not advance to later records.
+ * @CON_BOOT:		Marks the console driver as early console driver which
+ *			is used during boot before the real driver becomes available.
+ *			It will be automatically unregistered unless the early console
+ *			command line parameter for this console has the 'keep' option set.
+ * @CON_ANYTIME:	A misnomed historical flag which tells the core code that the
+ *			legacy @console::write callback can be invoked on a CPU which
+ *			is marked OFFLINE. That's misleading as it suggests that there
+ *			is no contextual limit for invoking the callback.
+ * @CON_BRL:		Indicates a braille device which is exempt from receiving the
+ *			printk spam for obvious reasons
+ * @CON_EXTENDED:	The console supports the extended output format of /dev/kmesg
+ *			which requires a larger output record buffer
+ */
+enum cons_flags {
+	CON_PRINTBUFFER		= BIT(0),
+	CON_CONSDEV		= BIT(1),
+	CON_ENABLED		= BIT(2),
+	CON_BOOT		= BIT(3),
+	CON_ANYTIME		= BIT(4),
+	CON_BRL			= BIT(5),
+	CON_EXTENDED		= BIT(6),
+};
 
+/**
+ * struct console - The console descriptor structure
+ * @name:		The name of the console driver
+ * @write:		Write callback to output messages (Optional)
+ * @read:		Read callback for console input (Optional)
+ * @device:		The underlying TTY device driver (Optional)
+ * @unblank:		Callback to unblank the console (Optional)
+ * @setup:		Callback for initializing the console (Optional)
+ * @exit:		Callback for teardown of the console (Optional)
+ * @match:		Callback for matching a console (Optional)
+ * @flags:		Console flags. See enum cons_flags
+ * @index:		Console index, e.g. port number
+ * @cflag:		TTY control mode flags
+ * @ispeed:		TTY input speed
+ * @ospeed:		TTY output speed
+ * @seq:		Sequence number of the next ringbuffer record to print
+ * @dropped:		Number of dropped ringbuffer records
+ * @data:		Driver private data
+ * @node:		hlist node for the console list
+ */
 struct console {
-	char	name[16];
-	void	(*write)(struct console *, const char *, unsigned);
-	int	(*read)(struct console *, char *, unsigned);
-	struct tty_driver *(*device)(struct console *, int *);
-	void	(*unblank)(void);
-	int	(*setup)(struct console *, char *);
-	int	(*exit)(struct console *);
-	int	(*match)(struct console *, char *name, int idx, char *options);
-	short	flags;
-	short	index;
-	int	cflag;
-	uint	ispeed;
-	uint	ospeed;
-	u64	seq;
-	unsigned long dropped;
-	void	*data;
-	struct hlist_node node;
+	char			name[16];
+	void			(*write)(struct console *, const char *, unsigned);
+	int			(*read)(struct console *, char *, unsigned);
+	struct tty_driver	 *(*device)(struct console *, int *);
+	void			(*unblank)(void);
+	int			(*setup)(struct console *, char *);
+	int			(*exit)(struct console *);
+	int			(*match)(struct console *, char *name, int idx, char *options);
+	short			flags;
+	short			index;
+	int			cflag;
+	uint			ispeed;
+	uint			ospeed;
+	u64			seq;
+	unsigned long		dropped;
+	void			*data;
+	struct hlist_node	node;
 };
 
 #ifdef CONFIG_LOCKDEP
-- 
2.30.2

