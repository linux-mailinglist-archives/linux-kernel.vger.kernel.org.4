Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6F3628578
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbiKNQbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237708AbiKNQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD02F393;
        Mon, 14 Nov 2022 08:29:51 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PxzIkDOo+u2ZWn4WKSm9Hq+Fp48aeu4iQFbr0MeDXE=;
        b=1BKrXov9UpGW8i3q7hfrAts/TS9f1RYajAbeVEXEGrtL7vaFgC21p2/gycHpZdggcRdkMR
        ymAXLo3nI1XznOcfkM8o5VPA4u6dK12AQ9M+D9N/Y7xJ/VWzIzjgdzIM7jZdzTrLeTEgVf
        ldvYptvRObxoWgQM1mjVO0U5z0p5nGCAs7EtMbBk3dTvPNu5ImyjgmMlyxInldZZtJmK2A
        1C5vFloKr8VFUqWXDe8yM2OiOhAi0RIy9lNx/vMF7VcWmlEYi+lu43zGfF6mavA+0ue7WX
        HCOKbjnE3m0/2oipWF8vmACY9N8pHiiQtSahib4N206+Wa9R/AOzX9tdp8cgXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PxzIkDOo+u2ZWn4WKSm9Hq+Fp48aeu4iQFbr0MeDXE=;
        b=YJxFMEQT+jRTL58bXGade43+HEy6xareEPmdNqBiX7GialR4nAAc3bII7mmuoQPHmtUymm
        dWTycSv7+nBOStCQ==
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
Subject: [PATCH printk v4 35/39] tty: serial: kgdboc: use console_list_lock for list traversal
Date:   Mon, 14 Nov 2022 17:35:28 +0106
Message-Id: <20221114162932.141883-36-john.ogness@linutronix.de>
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

configure_kgdboc() uses the console_lock for console list iteration. Use
the console_list_lock instead because list synchronization responsibility
will be removed from the console_lock in a later change.

The SRCU iterator could have been used here, but a later change will
relocate the locking of the console_list_lock to also provide
synchronization against register_console().

Note, the console_lock is still needed to serialize the device()
callback with other console operations.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/kgdboc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index c6df9ef34099..82b4b4d67823 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -193,7 +193,16 @@ static int configure_kgdboc(void)
 	if (!p)
 		goto noconfig;
 
+	/* For safe traversal of the console list. */
+	console_list_lock();
+
+	/*
+	 * Take console_lock to serialize device() callback with
+	 * other console operations. For example, fg_console is
+	 * modified under console_lock when switching vt.
+	 */
 	console_lock();
+
 	for_each_console(cons) {
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
@@ -202,8 +211,11 @@ static int configure_kgdboc(void)
 			break;
 		}
 	}
+
 	console_unlock();
 
+	console_list_unlock();
+
 	kgdb_tty_driver = p;
 	kgdb_tty_line = tty_line;
 
-- 
2.30.2

