Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755E261F542
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiKGORX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:16:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4B1D0DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:16:45 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOJ5rVozh2o4kPFAPBIzU10/hQr/WmijEHoN/lMfTbg=;
        b=HeyA6jwDJkk3W2Q7mXT/ixKWhsA8ouQ5x3YmRFUo4cMH60xQZGJzZX4chawitd1iPMWjj5
        e1xuQCVukVX/IsrCbyMingnYZs/NrFrV3g2vB9puzYxGOsFAttamfXWa2/AEzrwJLKJRcQ
        h/dTUY/sLCOQ3ALJOzLIKgc8o2cLApgCDYNxlsd1HDZTKaiK36/f73EdhXvxpB1sEQNFX4
        eYvXjSX7BxLoMcYxICFQ40UmRRi6kb1tMPBwFVEy3dZUZg3OQvwWIsaDHdfaEX8N++xjka
        4Cvw+xRujtByhc+iJy5WmkPysbqKCqQZ3Yo4U/3G0aDl6A+SZoOd5KpBwm5OTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OOJ5rVozh2o4kPFAPBIzU10/hQr/WmijEHoN/lMfTbg=;
        b=g1QtfHWB/sN4/tDQrxu15t2rQx2DDWU9losLN3bT+0thLU62fNQqOH+iBtBaUXZTVGdnUB
        Hhw8EHn92GjSS5AQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 08/40] printk: use console_is_enabled()
Date:   Mon,  7 Nov 2022 15:22:06 +0106
Message-Id: <20221107141638.3790965-9-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled()
if it involves a data race. Otherwise add comments mentioning why the
wrapper is not used.

Note that this is a preparatory change for when console_lock no longer
provides synchronization for console->flags.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 79811984da34..f243bb56a3ba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2660,7 +2660,7 @@ static bool abandon_console_lock_in_panic(void)
  */
 static inline bool console_is_usable(struct console *con)
 {
-	if (!(con->flags & CON_ENABLED))
+	if (!console_is_enabled(con))
 		return false;
 
 	if (!con->write)
@@ -2946,7 +2946,7 @@ void console_unblank(void)
 	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
-		if ((c->flags & CON_ENABLED) && c->unblank)
+		if (console_is_enabled(c) && c->unblank)
 			c->unblank();
 	console_unlock();
 
@@ -3104,8 +3104,11 @@ static int try_enable_preferred_console(struct console *newcon,
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
+	 *
+	 * Note that reading @flags is race-free because the console is not
+	 * yet added to the console list.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
+	if ((newcon->flags & CON_ENABLED) && (c->user_specified == user_specified))
 		return 0;
 
 	return -ENOENT;
-- 
2.30.2

