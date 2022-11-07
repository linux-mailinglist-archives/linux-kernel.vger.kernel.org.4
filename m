Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AAF61F5AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiKGOTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbiKGORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:17:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A241D31D;
        Mon,  7 Nov 2022 06:16:59 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667830618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUO1Wdk5xzj9Vs+pxrA7dhcSw4wLvHPzDi2xSOEA1ME=;
        b=MUs03b3dJuWNfo7QVI5dMRKPmYfQe1AaNJ2UCFqmSPdHCpaerJkXb3JFXDpY8yzudMgvnP
        61U2iJhwFpPiu02FexbWU0B8hzVeF59HrupwiQEC7KereqcT3hG2P1BwQAp1BnEjetn9Os
        VLR5NODmKIEmjVQZXGsbpSHYyLjvtewiY1to6bauh8e82VcN2YloCflvNTuVwlXypZ5AvZ
        tZvQA8n2lcbO4jAm0y2Iw584HkKm6Vkg/w3L2cfPtUw+CBVoFVvHQEVfVo0mPUpKxPR9JJ
        I4LIPcFhdvv006X3sdjQF2kzFT6wD4jjecuBt4WILIomm2h6+JrS8JvaVx9KhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667830618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wUO1Wdk5xzj9Vs+pxrA7dhcSw4wLvHPzDi2xSOEA1ME=;
        b=y/4D56T+eDpvRE8oe5A4x+AW38ZOTavCt3hqTDnko5X0Qde4DudGdqovNKjwfPfw9L1jQR
        KXKUXgdgHjl6TwCQ==
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
Subject: [PATCH printk v3 38/40] tty: serial: kgdboc: use console_list_lock to trap exit
Date:   Mon,  7 Nov 2022 15:22:36 +0106
Message-Id: <20221107141638.3790965-39-john.ogness@linutronix.de>
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

kgdboc_earlycon_init() uses the console_lock to ensure that no consoles
are unregistered until the kgdboc_earlycon is setup. The console_list_lock
should be used instead because list synchronization responsibility will
be removed from the console_lock in a later change.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
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

