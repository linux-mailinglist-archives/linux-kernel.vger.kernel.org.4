Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C434061F5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiKGOTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiKGOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53161CFFE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nF9ItXxFwRvPMruy1z9DBE5scW8r/i0a6aD5QIaBD04=;
        b=4UvomhlSZAvFX9ARbtGXTPtRcZnlbiu/Os6h1wdRy1FvTcQ6bQarj88zARfxWv83EAETG9
        nf9/td7bOpBTfIDuxNdbLnqkaICA9JTZ6vRVCn5NdRYve1U4ImRGBrCvoLINW3lQZhkq0R
        XWlKuGl0YbQgyUvW2pIoJt1LN2c2ALoD2o1wQ4d0OpZYcP6tfw7/LInHCIy8n8+CHbA/3i
        4gmwoCBlnoDkWAEBNYFPMkMGB9O+7CcB0/qfuIvx8+vocHNyPQpkvoBCx9ZvoQ3ETUCut3
        9V48M+wRPHF9FZSvOg28q88hMORPAsWxQToGssYL6natRATqyCSp2F4QTw1IxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nF9ItXxFwRvPMruy1z9DBE5scW8r/i0a6aD5QIaBD04=;
        b=WH+/leZjumZ+rt5PP5ML58idCQJBWKJkxwo/rAmnAt7OoTZ9b62aec54aBDjDx/BwP7Ig2
        EzYFB3SXZ0SQQhAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 22/40] console: introduce console_is_registered()
Date:   Mon,  7 Nov 2022 15:22:20 +0106
Message-Id: <20221107141638.3790965-23-john.ogness@linutronix.de>
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
---
 include/linux/console.h | 28 ++++++++++++++++++++++++++++
 kernel/printk/printk.c  |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 47be23be8a88..cdae70e27377 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -210,6 +210,34 @@ static inline bool console_is_enabled(const struct console *con)
 	return (data_race(READ_ONCE(con->flags)) & CON_ENABLED);
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
index 31387ba3fa1a..be40a9688403 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3410,7 +3410,7 @@ static int unregister_console_locked(struct console *console)
 	/* Disable it unconditionally */
 	WRITE_ONCE(console->flags, console->flags & ~CON_ENABLED);
 
-	if (hlist_unhashed(&console->node)) {
+	if (!console_is_registered_locked(console)) {
 		console_unlock();
 		return -ENODEV;
 	}
-- 
2.30.2

