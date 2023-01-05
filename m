Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1709765E923
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjAEKjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjAEKiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:38:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704283D1C1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:38:17 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672915095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbYaurIRdFG+/mjMZ4Nnsd0tE8OMeEIDH+uE2KSAjBQ=;
        b=OyPbJCV/0RK4Z5l8+dTVu6yHvXQ70l1n7PW0gElQzOHS3oez0h793xmtJrG8Ibf+KREW9u
        1VzN0lMdCqaDig6Kf2ZAe3Qt9XTeJZ0iw3t+FgCBZawyKGYgyfvVyJ/3hkczitkNPhTTNB
        j40WbAW8PlxBK7U6nHBp40S4U4M+vcLzVBskrtz34k7jpvzF5gpAPjuRvjPanL64wfkI3G
        L63FCU3mdkRq1LPWENt2ooY4SFxJq3I/VJSfGa6mvvJ7ENGPikM8x6dUwVeSX4Dh8DWv6u
        Y3CrDzEDX6gTk6ASE4aCY0iEF6ooJOqUsZzvKQK8dq8vusbhORjPg3ZKH4r1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672915095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XbYaurIRdFG+/mjMZ4Nnsd0tE8OMeEIDH+uE2KSAjBQ=;
        b=sPVu67nrL/W0LLko+a9J1lMTSZXIt6Pmfe1siI4O6rnww0XwqxREtvcL3y9PhvRfmaMj07
        qnH6IGrkUUh9itAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 2/8] console: Use BIT() macros for @flags values
Date:   Thu,  5 Jan 2023 11:43:29 +0106
Message-Id: <20230105103735.880956-3-john.ogness@linutronix.de>
In-Reply-To: <20230105103735.880956-1-john.ogness@linutronix.de>
References: <20230105103735.880956-1-john.ogness@linutronix.de>
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

