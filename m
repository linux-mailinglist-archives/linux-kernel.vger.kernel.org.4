Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F85B4A82
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 00:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIJW26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 18:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIJW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 18:28:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1BA43E43
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 15:27:56 -0700 (PDT)
Message-ID: <20220910222301.198303830@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662848874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OGECJYeezcNM6bctMFLtG7sTwDOnNte8eZxyEhnl5nM=;
        b=IuZNLSLWrfeHviHjBCswWUiLPjJFadWgbgopNg+pFLiSOex8+bMxyrgNnktQ7UJE5v1hcp
        TOrC3ymS+Q0JSjqxcm0YLsXRNeWd1gAtLs5VYgL9Lfr7Yb7dSsB9wcSLco5Q9Wq7P2FZjg
        UaHIB2NS3xgrDaC6GKKBOhcOEbUcd1NxStfD+vxTQWxa3G680gY4e6pMjboeFMAhm5fbYf
        mIZcGZyxrCk2jn82OvS1jgM2Du+GkcOpSSno3SSiIkAmZd+XlgiW3Ih7kgzUGro28FcCyN
        kRGoImK+ZOP4sD/GVt+WAqlbCIa+Qe/08QXTOd+BVqxGZ5YB/i8kFyX1pe+0Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662848874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OGECJYeezcNM6bctMFLtG7sTwDOnNte8eZxyEhnl5nM=;
        b=PKAdd0InIgltg78+kqH3kBPOYXjLT9jGUBShTCd3FLo95raEjRV00tE5D+dK7A2xBZMql5
        Ux091lYUiBpbyuDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [patch RFC 14/29] printk: Document struct console
References: <20220910221947.171557773@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 11 Sep 2022 00:27:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add docbook comments to struct console.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/console.h |   94 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 27 deletions(-)

--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/rculist.h>
 #include <linux/types.h>
 
@@ -139,37 +140,76 @@ static inline int con_debug_leave(void)
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
+ * @CON_PRINTBUFFER:	Print the complete dmesg backlog on register/enable
+ * @CON_CONSDEV:	Questionable historical leftover to denote which console
+ *			driver is the preferred console which is defining what
+ *			backs up /dev/console
+ * @CON_ENABLED:	General enable state subject to note #1
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
+ * @seq:		Sequence number of the last ringbuffer record printed
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

