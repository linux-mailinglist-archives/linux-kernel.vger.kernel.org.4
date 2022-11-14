Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E44628575
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiKNQbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiKNQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB652F031;
        Mon, 14 Nov 2022 08:29:50 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wDn6g+8UuBdFK6wWrlxzslZkfyRUaJ6YAvy13J2JzM=;
        b=BImf087f9JnZ88MWf7ANkPfWPNC7L78l8GKfPWaZ1afRJ+A+JBuMrpM8D1Ka321WprAnA3
        EGloFZFKdW72lAGMkaKfGh8DjWcnX/CaE/PiSwUMI6Ev+J+j0YujoKIAviukaNA6BNfXG6
        vZQKB3mcJni3b4fbuzwdnXl0zvRf10T9m37lJxrHpv2cksUNBagpZ2TxbYiXBkkwN8uGFR
        QmO4TI8BuMPRs08ILB69SI8eB5ifJwO3XFa/Na0Ps0ULOqzEpXNv/aY2+GJpk5tnowTx8g
        lQWj2mP+9P3cjsdwI04CGBTnOSDytJN+t4szjXImS/5DCyylCW1RsCBuFWAI7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wDn6g+8UuBdFK6wWrlxzslZkfyRUaJ6YAvy13J2JzM=;
        b=1WUe4EQRUuyC882lbN52LVmxM2UtRXMjNbX4zkjqflQk4DO03Am6ce06RfjNxTxnINegur
        l44TkJN3V9duhpDA==
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
Subject: [PATCH printk v4 34/39] tty: serial: kgdboc: use srcu console list iterator
Date:   Mon, 14 Nov 2022 17:35:27 +0106
Message-Id: <20221114162932.141883-35-john.ogness@linutronix.de>
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

Use srcu console list iteration for safe console list traversal.
Note that this is a preparatory change for when console_lock no
longer provides synchronization for the console list.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
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

