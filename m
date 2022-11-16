Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC4262C450
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiKPQZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiKPQXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:23:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD3958BE3;
        Wed, 16 Nov 2022 08:22:15 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOHwuBaQ1W+3awwG2RAkUq8lXTwRKxgLO4vJVGnxlV8=;
        b=zwABEZ9mxonAyBNUeWB10LZTBQNhVUWXnM4uJOtaQ2YyZadMZ5Bi3atLrrsSkVEU/BnViB
        xAZVnMRA2dR8k2nO0aVndbNd46Y1KfXjZxNnIMCd0MWCLq21gTPYXnDQlH47HazQ4NDvNt
        wmcJ6p2S4E6O3pkDLBoS7eyHnNAg3KsSCoQvLEKQjz/CSbQe3nu6Pon8WzaivpF79mr26K
        BAILjyp28M6MufGbgldEQGXoQwcNvfSuPpzdX/UBg8mB6SWPRgUX+uX2ZRJIGeOWZIQXpE
        2Z/4P+skN/oruOza9baWAElWHHWGDsIWdsfXNjTGDHR5DZfUdF7y4XpQqQEB6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOHwuBaQ1W+3awwG2RAkUq8lXTwRKxgLO4vJVGnxlV8=;
        b=s9R0LFz1ZdiHDzIlIEwfz6Uf9mV1b7pU/Ru3/LSGYsFj+6aDJGhMs03+ARyz6ujFNcaXLF
        WcI0pM16uwfwndDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: [PATCH printk v5 35/40] tty: serial: kgdboc: use srcu console list iterator
Date:   Wed, 16 Nov 2022 17:27:47 +0106
Message-Id: <20221116162152.193147-36-john.ogness@linutronix.de>
In-Reply-To: <20221116162152.193147-1-john.ogness@linutronix.de>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
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

Use srcu console list iteration for safe console list traversal.
Note that this is a preparatory change for when console_lock no
longer provides synchronization for the console list.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/kgdboc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 5be381003e58..c6df9ef34099 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -451,6 +451,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
 {
 	struct console *con;
 	static bool already_warned;
+	int cookie;
 
 	if (already_warned)
 		return;
@@ -463,9 +464,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
 	 * serial drivers might be OK with this, print a warning once per
 	 * boot if we detect this case.
 	 */
-	for_each_console(con)
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(con) {
 		if (con == kgdboc_earlycon_io_ops.cons)
-			return;
+			break;
+	}
+	console_srcu_read_unlock(cookie);
+	if (con)
+		return;
 
 	already_warned = true;
 	pr_warn("kgdboc_earlycon is still using bootconsole\n");
-- 
2.30.2

