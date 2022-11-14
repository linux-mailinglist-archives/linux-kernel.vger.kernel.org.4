Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA305628579
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237874AbiKNQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237715AbiKNQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:30:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A682F3B0;
        Mon, 14 Nov 2022 08:29:52 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668443391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9VqGyF+glKoWbwrATKZGXQP3ZfoC2SELt3pYx7i6e4=;
        b=DacyzsBcp752j0f06x6Q5nIQ3Y5gHBQvOHj6L2Z1z+kRtb13uwnRXYW37qeBlA7kgq5U5n
        OaG76pGwOCwmTLoNnu/ZsGzwldP/gJxxLG3s06WbdxVYr9g1JXPqk0nThtOkMIKl8nD9ZC
        J5NDzg7I6YeBPhNNt11xV2oCLyep6w6l3sQDsNbw86SZHUUGw3Z7L59dKKhdvveul7RcQw
        gTAN2eDqhT8DvmFpCl3VGyA+CLcij+AIKpEnvnW1Y2ot2Pkpr7hjHH5KLAm7Due/1vwzjr
        AB7lVHWHuwghLHNLPcTikzz1Xbjg9af9IqHrb2u8wSXUTwh+qQgOKXTfbaCX7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668443391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R9VqGyF+glKoWbwrATKZGXQP3ZfoC2SELt3pYx7i6e4=;
        b=5U/0tNMtf/1+xSx/qQ15ry4JRyEwzML/OTxzN7u46NDdwk8a6TlIBlnh67P6RTs4qrLo08
        vYO+POSL/MrszBCw==
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
Subject: [PATCH printk v4 37/39] tty: serial: kgdboc: use console_list_lock to trap exit
Date:   Mon, 14 Nov 2022 17:35:30 +0106
Message-Id: <20221114162932.141883-38-john.ogness@linutronix.de>
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

kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
are unregistered until the kgdboc_earlycon is setup. The console_list_lock
should be used instead because list synchronization responsibility will
be removed from the console_lock in a later change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 drivers/tty/serial/kgdboc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 8c2b7ccdfebf..a3ed9b34e2ab 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -558,13 +558,13 @@ static int __init kgdboc_earlycon_init(char *opt)
 	 */
 
 	/*
-	 * Hold the console_lock to guarantee that no consoles are
+	 * Hold the console_list_lock to guarantee that no consoles are
 	 * unregistered until the kgdboc_earlycon setup is complete.
 	 * Trapping the exit() callback relies on exit() not being
 	 * called until the trap is setup. This also allows safe
 	 * traversal of the console list and race-free reading of @flags.
 	 */
-	console_lock();
+	console_list_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
 		    (con->flags & (CON_BOOT | CON_ENABLED)) &&
@@ -606,7 +606,7 @@ static int __init kgdboc_earlycon_init(char *opt)
 	}
 
 unlock:
-	console_unlock();
+	console_list_unlock();
 
 	/* Non-zero means malformed option so we always return zero */
 	return 0;
-- 
2.30.2

