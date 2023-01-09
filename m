Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D1662289
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjAIKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbjAIKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:08:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A38EE29
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:08:46 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673258925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbYaurIRdFG+/mjMZ4Nnsd0tE8OMeEIDH+uE2KSAjBQ=;
        b=nk9xoyaKfHsP6LTQQVu+XG/CdducdR0r431heSBnhyIjJ9fMkZy9Qu8hytCRS5+JkkAwwm
        1/pgMyVjDASfi1Ffscempghhi0+4iIlt942q2Ciaxu55L7LfBY7VUgwgnyeXP/8BzAK9LG
        wjaEV6zuiCuIwD71wAd1KBSNcrgVP40vXRCjksZ3cKAYVKjwNtVZrNXylP8l9qtetjEe14
        ljkZ4gHS3f3n/2rA5Zq4QrNr3HYHE7oINFg5DlnvAgZEFVGA5Kj15wyz+e95bqS8OoW0Cv
        IKDAP5RfLDX0UpuEagGIVL9DZhbqoF3AXxieMVPAkieU26GIgFBu95UyKt+/lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673258925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbYaurIRdFG+/mjMZ4Nnsd0tE8OMeEIDH+uE2KSAjBQ=;
        b=uVEKsQaLbANPNkuvRmKPiltiGgodI/HUGUzLg17l8c1kxkoNEhqWHr6m3N1eKsTqL9vJDb
        7KMyftFzRJpgNoCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v5 2/8] console: Use BIT() macros for @flags values
Date:   Mon,  9 Jan 2023 11:13:54 +0106
Message-Id: <20230109100800.1085541-3-john.ogness@linutronix.de>
In-Reply-To: <20230109100800.1085541-1-john.ogness@linutronix.de>
References: <20230109100800.1085541-1-john.ogness@linutronix.de>
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

Rather than manually calculating powers of 2, use the BIT() macros.
Also take this opportunatity to cleanup and restructure the value
comments into proper kerneldoc comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 46 ++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 9cea254b34b8..ed804dd7c2e8 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -15,6 +15,7 @@
 #define _LINUX_CONSOLE_H_ 1
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/rculist.h>
 #include <linux/types.h>
 
@@ -125,18 +126,43 @@ static inline int con_debug_leave(void)
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
+ * @CON_PRINTBUFFER:	Used by newly registered consoles to avoid duplicate
+ *			output of messages that were already shown by boot
+ *			consoles or read by userspace via syslog() syscall.
+ * @CON_CONSDEV:	Indicates that the console driver is backing
+ *			/dev/console.
+ * @CON_ENABLED:	Indicates if a console is allowed to print records. If
+ *			false, the console also will not advance to later
+ *			records.
+ * @CON_BOOT:		Marks the console driver as early console driver which
+ *			is used during boot before the real driver becomes
+ *			available. It will be automatically unregistered
+ *			when the real console driver is registered unless
+ *			"keep_bootcon" parameter is used.
+ * @CON_ANYTIME:	A misnomed historical flag which tells the core code
+ *			that the legacy @console::write callback can be invoked
+ *			on a CPU which is marked OFFLINE. That is misleading as
+ *			it suggests that there is no contextual limit for
+ *			invoking the callback. The original motivation was
+ *			readiness of the per-CPU areas.
+ * @CON_BRL:		Indicates a braille device which is exempt from
+ *			receiving the printk spam for obvious reasons.
+ * @CON_EXTENDED:	The console supports the extended output format of
+ *			/dev/kmesg which requires a larger output buffer.
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
 
 struct console {
 	char	name[16];
-- 
2.30.2

