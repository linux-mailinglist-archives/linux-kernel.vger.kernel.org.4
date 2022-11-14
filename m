Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B344662855A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237714AbiKNQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbiKNQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092922BC4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wX56Rx4ehD7yCLYC+HBYrPWlmwQCTi9+gNx/cMRdAa0=;
        b=sZwXHYkHvPbktNSwjxUK5aj2mlUfsNem40DSF6jkIhmjnLqme07Bj37zy8BIOHUrp4R+kO
        z20l7qtc9/VbGba0euziTCjOck6y0KeieHFYZ16r4/5p3EUfZkyVMuYj/ZUI1Y9PQXqyKQ
        wwabfaBCwER2N2R8NdsQJIhHmtea3R6RtskJewsP9Sc3cDiAnrz/ibxX+tysUT3L3qoZ9a
        RTuLJLASQj//Ycg2JFB4X8jCBVC8rTaTv/+ou5+jjJl98bUO4W74oj0ghdFP/CzB+UUTZK
        sV2lPIpF5ion3n4mLc5PiZdySngafhsq9WtLsLgbX/eTUODx2a9RiD+3L4b+Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wX56Rx4ehD7yCLYC+HBYrPWlmwQCTi9+gNx/cMRdAa0=;
        b=YSUY3x9QKkaBKpLI3HuYgJ3L+uxIygG746+BhVG6JRy2hyD9v0E6waIFwmYOUybnOdJ3Al
        G7H0jZldXWqYGJBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 20/39] console: introduce console_is_registered()
Date:   Mon, 14 Nov 2022 17:35:13 +0106
Message-Id: <20221114162932.141883-21-john.ogness@linutronix.de>
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

Currently it is not possible for drivers to detect if they have
already successfully registered their console. Several drivers
have multiple paths that lead to console registration. To avoid
attempting a 2nd registration (which leads to a WARN), drivers
are implementing their own solution.

Introduce console_is_registered() so drivers can easily identify
if their console is currently registered. A _locked() variant
is also provided if the caller is already holding the
console_list_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h | 28 ++++++++++++++++++++++++++++
 kernel/printk/printk.c  |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index c1ca461d088a..f716e1dd9eaf 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -228,6 +228,34 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
 	WRITE_ONCE(con->flags, flags);
 }
 
+/* Variant of console_is_registered() when the console_list_lock is held. */
+static inline bool console_is_registered_locked(const struct console *con)
+{
+	lockdep_assert_console_list_lock_held();
+	return !hlist_unhashed(&con->node);
+}
+
+/*
+ * console_is_registered - Check if the console is registered
+ * @con:	struct console pointer of console to check
+ *
+ * Context: Process context. May sleep while acquiring console list lock.
+ * Return: true if the console is in the console list, otherwise false.
+ *
+ * If false is returned for a console that was previously registered, it
+ * can be assumed that the console's unregistration is fully completed,
+ * including the exit() callback after console list removal.
+ */
+static inline bool console_is_registered(const struct console *con)
+{
+	bool ret;
+
+	console_list_lock();
+	ret = console_is_registered_locked(con);
+	console_list_unlock();
+	return ret;
+}
+
 /**
  * for_each_console_srcu() - Iterator over registered consoles
  * @con:	struct console pointer used as loop cursor
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fb609a19f797..e770b1ede6c9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3414,7 +3414,7 @@ static int unregister_console_locked(struct console *console)
 	/* Disable it unconditionally */
 	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
 
-	if (hlist_unhashed(&console->node)) {
+	if (!console_is_registered_locked(console)) {
 		console_unlock();
 		return -ENODEV;
 	}
-- 
2.30.2

