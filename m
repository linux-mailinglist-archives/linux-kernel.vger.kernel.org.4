Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659AB62854F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbiKNQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiKNQ3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:29:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2612116D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:29:41 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmQgD+t+Pywrubu3H0mhuWuMaWs++GAlupQRHdINU0E=;
        b=XQ9KB4oeyyyeCvUXMGQ2bqZFv93YVz5KGSl5A172siQS+8OuGoVz7/F/KnpUIaynkz30Dp
        kR2kETCMrLKZgEatVBs6HhoMFGvz8KgezFKHF9fyJDmnDbCfNsbmrmczlEVLF9Ry29VGvQ
        t8G8SOFz7fWVamv5nnHRbw2w4/WvrFzdv2qwZEsXXZNG+fqHiGHM+ldv0yOUhM9AB7HC+n
        PqdpZ6hgVYTjCqEWW9jv1c2vNJYWHDSw6YOV+e11DsrQlKDkrQr12iNfRLDQlPmHr/jkuY
        gujwc6Rq9oLYttRJ00U3/vfnvy6Q1XE4fL5/+X8lKDr5c21zlTaWuyeQuf7+hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dmQgD+t+Pywrubu3H0mhuWuMaWs++GAlupQRHdINU0E=;
        b=RTsdtTusacNEWE15rK5zI5JAuKscbSo2PVn8TlR/kHK5kLMWgXvw5/Ga525pquU1vcOsps
        JLpNpTN3W+2dYvBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH printk v4 13/39] kdb: use srcu console list iterator
Date:   Mon, 14 Nov 2022 17:35:06 +0106
Message-Id: <20221114162932.141883-14-john.ogness@linutronix.de>
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

Guarantee safe iteration of the console list by using SRCU.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/debug/kdb/kdb_io.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 67d3c48a1522..5c7e9ba7cd6b 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 {
 	struct console *c;
 	const char *cp;
+	int cookie;
 	int len;
 
 	if (msg_len == 0)
@@ -558,8 +559,20 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
-	for_each_console(c) {
-		if (!(c->flags & CON_ENABLED))
+	/*
+	 * The console_srcu_read_lock() only provides safe console list
+	 * traversal. The use of the ->write() callback relies on all other
+	 * CPUs being stopped at the moment and console drivers being able to
+	 * handle reentrance when @oops_in_progress is set.
+	 *
+	 * There is no guarantee that every console driver can handle
+	 * reentrance in this way; the developer deploying the debugger
+	 * is responsible for ensuring that the console drivers they
+	 * have selected handle reentrance appropriately.
+	 */
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(c) {
+		if (!(console_srcu_read_flags(c) & CON_ENABLED))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
@@ -577,6 +590,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		--oops_in_progress;
 		touch_nmi_watchdog();
 	}
+	console_srcu_read_unlock(cookie);
 }
 
 int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
-- 
2.30.2

