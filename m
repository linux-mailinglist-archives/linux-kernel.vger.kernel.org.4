Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780B62857E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiKNQc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbiKNQaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF6B2F64D;
        Mon, 14 Nov 2022 08:29:53 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyFJ0F0+PfcRjhKzuNkMUBeWMaE9PNLLtfp/JWoaB8Q=;
        b=o493Ws7OLoNBwC3oJekHe/zqr8d4O1r2boZdC330Lx7sXR/IS+LlFMlQSjiYgilqi2WvYy
        bK6oiaWKOaMF+Ov1zkmR7m17gutu6TqbBnx+DW+0CKcPwn/WP4WoTvHeOnxG3Dcpw50L0F
        uCuMhIdKv8bxHZuMIY7yE5xqI87CzHeE17gRcNmlIyNpc4AunL7RVRWKjhFqzm99845QTr
        GU9GdrUeraNW+PFqq9HeRlvM+uQT2Bk7lgRw4l2QqcvqrMlmgfyI3VLCm+SlLEyaEy08XS
        9IYpB54UDdp25QGOFuwjoXwpDVZUiUqepmIgjw9G5zSxprsVTUdFu7iZnYfhNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lyFJ0F0+PfcRjhKzuNkMUBeWMaE9PNLLtfp/JWoaB8Q=;
        b=3yUj92YNamRVgcCdfRvOJqzWFRVhH0VyAxXFN/+0roEsIDgaS8xom/DI+PxiHFB0NAZLYl
        geAOjgKKccPDeLAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH printk v4 39/39] tty: serial: sh-sci: use setup() callback for early console
Date:   Mon, 14 Nov 2022 17:35:32 +0106
Message-Id: <20221114162932.141883-40-john.ogness@linutronix.de>
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

Since this early console can only be registered via the earlyprintk=
parameter, the @options argument of the setup() callback will always
be NULL. Rather than simply ignoring the argument, add a WARN_ON()
to get our attention in case the setup() callback semantics should
change in the future.

Note that technically the current implementation works because it is
only used in early boot. And since the early console setup is
performed before registering, it cannot race with anything and thus
does not need any locking. However, longterm maintenance is easier
when drivers rely on the subsystem API rather than manually
implementing steps that could cause breakage in the future.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62f773286d44..76452fe2af86 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3054,15 +3054,29 @@ static struct console serial_console = {
 };
 
 #ifdef CONFIG_SUPERH
+static char early_serial_buf[32];
+
+static int early_serial_console_setup(struct console *co, char *options)
+{
+	/*
+	 * This early console is always registered using the earlyprintk=
+	 * parameter, which does not call add_preferred_console(). Thus
+	 * @options is always NULL and the options for this early console
+	 * are passed using a custom buffer.
+	 */
+	WARN_ON(options);
+
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
@@ -3074,8 +3088,6 @@ static int sci_probe_earlyprintk(struct platform_device *pdev)
 
 	sci_init_single(pdev, &sci_ports[pdev->id], pdev->id, cfg, true);
 
-	serial_console_setup(&early_serial_console, early_serial_buf);
-
 	if (!strstr(early_serial_buf, "keep"))
 		early_serial_console.flags |= CON_BOOT;
 
-- 
2.30.2

