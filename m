Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2D561F5A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiKGOT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiKGORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:17:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5231D641;
        Mon,  7 Nov 2022 06:16:58 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABDFtrgjV5x8uGkolXUUesJdZpQfr7BwwBr7iTObU1k=;
        b=quYSkn0H6WS4/l0RYtMy3BDn/rK/rRzby8k7+wPwnxKordiq2TgHz8VGVPX95WuRGgwskm
        EtBX73KPFW0k9NtYTpUCTtC+tWMJhMww3Zvq9V2lgXuA2ShF3fqmI4g0ScS/P1sTLwetNh
        ExpToebi/v9WRQUmTKE5E/WcN/uuirbBRldIeX/WLOaS06fohXQ/OGszmxg1g6WSergB31
        MbaozUQ59Y9Fv+G+GH08ICMAjHlm76Pco9BS188p4z7JPQKzTEx426fF2f8aER4+H6sylG
        CSiyN8MEZvyACLULxolUeG76LhEFYwnZoc0EQUAsjHeEZdS3ykqCDiKbXDiAqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ABDFtrgjV5x8uGkolXUUesJdZpQfr7BwwBr7iTObU1k=;
        b=0EsqVlG5GcPGEcsVNMZ4uy7CR5J6JcEVjcsCxd7fPEIZJDWclxknPbTwQCDjbw6tArZeef
        7aUFWCYb4TEtlXBA==
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
Subject: [PATCH printk v3 37/40] tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()
Date:   Mon,  7 Nov 2022 15:22:35 +0106
Message-Id: <20221107141638.3790965-38-john.ogness@linutronix.de>
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

Calling tty_find_polling_driver() can lead to uart_set_options() being
called (via the poll_init() callback of tty_operations) to configure the
uart. But uart_set_options() can also be called by register_console()
(via the setup() callback of console).

Take the console_list_lock to synchronize against register_console() and
also use it for console list traversal. This also ensures the console list
cannot change until the polling console has been chosen.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/kgdboc.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 82b4b4d67823..8c2b7ccdfebf 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -189,12 +189,20 @@ static int configure_kgdboc(void)
 	if (kgdboc_register_kbd(&cptr))
 		goto do_register;
 
+	/*
+	 * tty_find_polling_driver() can call uart_set_options()
+	 * (via poll_init) to configure the uart. Take the console_list_lock
+	 * in order to synchronize against register_console(), which can also
+	 * configure the uart via uart_set_options(). This also allows safe
+	 * traversal of the console list.
+	 */
+	console_list_lock();
+
 	p = tty_find_polling_driver(cptr, &tty_line);
-	if (!p)
+	if (!p) {
+		console_list_unlock();
 		goto noconfig;
-
-	/* For safe traversal of the console list. */
-	console_list_lock();
+	}
 
 	/*
 	 * Take console_lock to serialize device() callback with
-- 
2.30.2

