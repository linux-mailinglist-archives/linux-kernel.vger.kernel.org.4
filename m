Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6C61F5AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiKGOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiKGOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:18:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD41D33D;
        Mon,  7 Nov 2022 06:17:00 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOWHeHInm2fmU2wKM0mWh276PVpVVzC8ULssrB/joiM=;
        b=swwcC/eytgcMbEKzOsEncCun4WY7vCLbcSffYIRaqcjIVCgoqyAiB72Hq237ceNlyL5/yg
        IaBRPSjRNC+INjKqpcmmT7hw6GRutYGeymQnr6Ol54Fij7be5Jfsm1DMqRlgS5UuQl9Rvq
        kdDA0dnHuT7VyfDq9u5tURAAc7KWeGndsalFDzyw85DF2YnZXb09JJH4a9xoJEpkWVwyS8
        9jeLeuqUOLHzlmT4uTJIGlq4oWnVJQX+g1TczTiRuFCoB5GfciO6IKmx3iBPLaJbghiv/i
        PLkKtR22cC0RUj+pZZuRVN6VNvOn/czOzbB7QmzT3PZHj15nJHjX9f2zg0usMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOWHeHInm2fmU2wKM0mWh276PVpVVzC8ULssrB/joiM=;
        b=XMu8M3iTA3yEquZZqVsUkXpN+6MK0GssBgVj2Cl5IKI6K2iL8N2eyBMcwztJY/whxe4NYQ
        BGYy6M/luah7T/Cg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v3 40/40] tty: serial: sh-sci: use setup() callback for early console
Date:   Mon,  7 Nov 2022 15:22:38 +0106
Message-Id: <20221107141638.3790965-41-john.ogness@linutronix.de>
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

When setting up the early console, the setup() callback of the
regular console is used. It is called manually before registering
the early console instead of providing a setup() callback for the
early console. This is probably because the early setup needs a
different @options during the early stage.

The issue here is that the setup() callback is called without the
console_list_lock held and functions such as uart_set_options()
expect that.

Rather than manually calling the setup() function before registering,
provide an early console setup() callback that will use the different
early options. This ensures that the error checking, ordering, and
locking context when setting up the early console are correct.

Note that technically the current implementation works because it is
only used in early boot. And since the early console setup is
performed before registering, it cannot race with anything and thus
does not need any locking. However, longterm maintenance is easier
when drivers rely on the subsystem API rather than manually
implementing steps that could cause breakage in the future.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/sh-sci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62f773286d44..f3a1cfec757a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3054,15 +3054,26 @@ static struct console serial_console = {
 };
 
 #ifdef CONFIG_SUPERH
+static char early_serial_buf[32];
+
+static int early_serial_console_setup(struct console *co, char *options)
+{
+	WARN_ON(options);
+	/*
+	 * Use @early_serial_buf because @options will always be
+	 * NULL at this early stage.
+	 */
+	return serial_console_setup(co, early_serial_buf);
+}
+
 static struct console early_serial_console = {
 	.name           = "early_ttySC",
 	.write          = serial_console_write,
+	.setup		= early_serial_console_setup,
 	.flags          = CON_PRINTBUFFER,
 	.index		= -1,
 };
 
-static char early_serial_buf[32];
-
 static int sci_probe_earlyprintk(struct platform_device *pdev)
 {
 	const struct plat_sci_port *cfg = dev_get_platdata(&pdev->dev);
@@ -3074,8 +3085,6 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
 
 	sci_init_single(pdev, &sci_ports[pdev->id], pdev->id, cfg, true);
 
-	serial_console_setup(&early_serial_console, early_serial_buf);
-
 	if (!strstr(early_serial_buf, "keep"))
 		early_serial_console.flags |= CON_BOOT;
 
-- 
2.30.2

