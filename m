Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA78604A83
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiJSPGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiJSPFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B872F007;
        Wed, 19 Oct 2022 07:59:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACPI8gcDk9OHrPL7ke5XVpq5ui7KkEF2l2bHZNH8aSI=;
        b=Ccgy/tfHlK5pUky0RE3+PgIt1rgjfkq3Tlb6Sd8WDUWfjg35ogZEbfXvjsXgVU7QAtpI49
        nw+J0Yr/pj68t053bnHszLo5Yf5Got25SfdJCTQ1XQR/4b43Xz8/x2LVdovnTWreK9d35z
        WppqeLftN6a6CqKiUrS4MgpzyM4QuBB9/5G05SLCI2HKV5qPIqRLUZfGfcz/gCiINc34o6
        h7jJYblRSvG5ZqO55I7PrZ9Ycato2Lu3jOD83rw09TuE0vlq+TQ/1tpX9HLurzS3xA447+
        yFPYxB156iSolo2OCep4UyfsiV0RLod+tQBCSKSpjrxSxsn1FDpKIja+pCHk1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ACPI8gcDk9OHrPL7ke5XVpq5ui7KkEF2l2bHZNH8aSI=;
        b=yIzC1pH27dxiAovKC98wbTRSEd+6o8YRWTr6jNZ8jbaA2SP9qlYcbF+l4kQ4Idnk3qN43O
        wYA6fbuZuIsJFdCw==
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
Subject: [PATCH printk v2 22/38] serial: kgdboc: document console_lock usage
Date:   Wed, 19 Oct 2022 17:01:44 +0206
Message-Id: <20221019145600.1282823-23-john.ogness@linutronix.de>
In-Reply-To: <20221019145600.1282823-1-john.ogness@linutronix.de>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
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
are unregistered until the kgdboc_earlycon is setup. This is necessary
because the trapping of the exit() callback assumes that the exit()
callback is not called before the trap is setup.

Explicitly document this non-typical console_lock usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/kgdboc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index e9d3f8c6e3dc..48000666789a 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -545,6 +545,14 @@ static int __init kgdboc_earlycon_init(char *opt)
 	 * Look for a matching console, or if the name was left blank just
 	 * pick the first one we find.
 	 */
+
+	/*
+	 * Hold the console_lock to guarantee that no consoles are
+	 * unregistered until the kgdboc_earlycon setup is complete.
+	 * Trapping the exit() callback relies on exit() not being
+	 * called until the trap is setup. This also allows safe
+	 * traversal of the console list.
+	 */
 	console_lock();
 	for_each_console(con) {
 		if (con->write && con->read &&
-- 
2.30.2

