Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1562C451
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbiKPQZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiKPQXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:23:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C458BF2;
        Wed, 16 Nov 2022 08:22:17 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668615735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rR7OgmI/JUsM6cOvDEez6+6LhtAAivMeCFIKDYeiDs=;
        b=yek+I+AWhez5rkEA5jpNLeS+dTK2vOYMuw49/4KeOx+vZ3j7fSICGh+A7GDKzg5z7TNe2w
        GNw3aJ8GgsUetQiTtAe6edQKm2iFjgqj4sP/xbEFwx5FjRjF+o3qdfUN8VptbvgQ1FTgSU
        XNuT7pmvKcUE6jWrDCsA8If0jfaxz/Nfe59VftfvTuxUeW3lurw11BtZ43HdyVaJd/ROh6
        AXV7vSqILME+Fby/jKq7IUA2zE+x+sKNyx1ZxF8IafSf1P7CUoGoNq4M6G9DeWlhcmumgB
        9rzjBdRedJFUuh6GLZNJHCwNg1g0XRq+YBkVa1FS/uzQFrOkhHTRPBf3H3u0jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668615735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rR7OgmI/JUsM6cOvDEez6+6LhtAAivMeCFIKDYeiDs=;
        b=BUIX13s3OtJiinZiPhHeHtVgfLl3mq3vyjm9l09/OnWGIn8MwDBkNG+hBGTwiLBOEgYOs4
        z5ZfPI5vGKcwmmCA==
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
Subject: [PATCH printk v5 36/40] tty: serial: kgdboc: use console_list_lock for list traversal
Date:   Wed, 16 Nov 2022 17:27:48 +0106
Message-Id: <20221116162152.193147-37-john.ogness@linutronix.de>
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

configure_kgdboc() uses the console_lock for console list iteration. Use
the console_list_lock instead because list synchronization responsibility
will be removed from the console_lock in a later change.

The SRCU iterator could have been used here, but a later change will
relocate the locking of the console_list_lock to also provide
synchronization against register_console().

Note, the console_lock is still needed to serialize the device()
callback with other console operations.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

