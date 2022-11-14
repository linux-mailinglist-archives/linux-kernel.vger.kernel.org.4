Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F054628577
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiKNQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiKNQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F412F3A0;
        Mon, 14 Nov 2022 08:29:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ekc6YsdvItEWqTtBsALAxHEjpl5Na6n2oyZUMYkLTB4=;
        b=yLTA3smRSwZAzo0WodrUiCw7R5e475OFiwy+MWrPjH2XP7ogPwQVMS/zXU+LhKNp3eKpXA
        KGtD1o1+JZmtwdaVIy0gg29vMf6kvK9rm2vrsZyonpaDUUTb5Sp/mH9T0OWeMIm1fw0CNZ
        yVxqCP1JkAW2TE0usGB3mIL6COdrOyYk7TGKh3uCK6ZEoKV1rsr8JN2AswuXWtLRch8B/g
        h9RBqzV3HRHCpEuRiQzw7NorZv1XRz1MTdoruSZvLqfVBLUkSQNCGeokFeJYuRRdnl1ChN
        gpVIJdkzBvjKIPQNYUsMfwB2OouUp3eQQlkvIZcwWD6vHw7JrG+3vaFv+Ovqvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ekc6YsdvItEWqTtBsALAxHEjpl5Na6n2oyZUMYkLTB4=;
        b=cu2GY0TtUc+v5tINvlKDlxbO+i9OxziAYNewzqmSMu9L8Im8ozqk0RzFdYXxlRic6fMIZq
        zx1LlYZGgEzZ0FCA==
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
Subject: [PATCH printk v4 36/39] tty: serial: kgdboc: synchronize tty_find_polling_driver() and register_console()
Date:   Mon, 14 Nov 2022 17:35:29 +0106
Message-Id: <20221114162932.141883-37-john.ogness@linutronix.de>
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

Calling tty_find_polling_driver() can lead to uart_set_options() being
called (via the poll_init() callback of tty_operations) to configure the
uart. But uart_set_options() can also be called by register_console()
(via the setup() callback of console).

Take the console_list_lock to synchronize against register_console() and
also use it for console list traversal. This also ensures the console list
cannot change until the polling console has been chosen.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

