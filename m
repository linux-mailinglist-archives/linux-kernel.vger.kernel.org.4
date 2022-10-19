Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6949604A96
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbiJSPGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiJSPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F6193EE9;
        Wed, 19 Oct 2022 07:59:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHpEExScLzm4b3PGICcqjxP6eSShWDRVil4o7DIdRaU=;
        b=eDfs/FrHZ7HvnRF4atKhYEZ/pRXno8GEGAkw6IqnyiCmO75Q9sEJ6bqLoRWApu5I/kGcQh
        KCTzK1MrPYWFQHFbhhZ4ddIBd7thtElTQ1FhTZSvTGr+D/NiY6ja5av6esQrgKRy3JmdV3
        rrRE8vZ1b74ucDPVRwBFE1RIC+RhuKL5DdLWniGfxLfcajr60p331h+dY6KdEzGysIZMdC
        yATsOHK/PLnHwsUFjoxiti7aJ0XxaKU0B+KQDroX00sQ4UKCeboef9oWWEJpZprSsCboLS
        UQL5y2A8i38TojR6bF2UMoVPjjyV/EALMD7ITlxAjhc539biNA5Q3/A88oMp9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aHpEExScLzm4b3PGICcqjxP6eSShWDRVil4o7DIdRaU=;
        b=ag8wipmZjScVK96FvYUT41NwW8W8jBS77tduneOJOnLYN8uLmQW8RkuO+x9sTyAf/SfPXA
        QV5RyDV2N62v9UBQ==
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
Subject: [PATCH printk v2 21/38] serial: kgdboc: use srcu console list iterator
Date:   Wed, 19 Oct 2022 17:01:43 +0206
Message-Id: <20221019145600.1282823-22-john.ogness@linutronix.de>
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

Use srcu console list iteration for safe console list traversal.

Note that configure_kgdboc() still requires the console_lock in
order to ensure that no console is in its write() callback when
its direct() callback is called. Add comments to clarify this.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/kgdboc.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index b17aa7e49894..e9d3f8c6e3dc 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -171,6 +171,7 @@ static int configure_kgdboc(void)
 	int err = -ENODEV;
 	char *cptr = config;
 	struct console *cons;
+	int cookie;
 
 	if (!strlen(config) || isspace(config[0])) {
 		err = 0;
@@ -193,8 +194,14 @@ static int configure_kgdboc(void)
 	if (!p)
 		goto noconfig;
 
+	/*
+	 * Stop console printing because the device() callback may
+	 * assume the console is not within its write() callback.
+	 */
 	console_lock();
-	for_each_console(cons) {
+
+	cookie = console_srcu_read_lock();
+	for_each_console_srcu(cons) {
 		int idx;
 		if (cons->device && cons->device(cons, &idx) == p &&
 		    idx == tty_line) {
@@ -202,6 +209,8 @@ static int configure_kgdboc(void)
 			break;
 		}
 	}
+	console_srcu_read_unlock(cookie);
+
 	console_unlock();
 
 	kgdb_tty_driver = p;
@@ -451,6 +460,7 @@ static void kgdboc_earlycon_pre_exp_handler(void)
 {
 	struct console *con;
 	static bool already_warned;
+	int cookie;
 
 	if (already_warned)
 		return;
@@ -463,9 +473,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
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

