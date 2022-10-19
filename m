Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87A604A90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiJSPGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiJSPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:05:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA2D32047;
        Wed, 19 Oct 2022 07:59:15 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666191370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzgyVUdc3c3kCjuysiyU5ciOaxj14Ka8qNAluIGo2ws=;
        b=oMqTMwFgA7TRBPKkkgg2SqcRq6lIX5GGgXm4dRv/bMgruBa0iJWddlwoaLUfKzhFqpC6WR
        gwr90qgT4eOy+NBCyDnpmsmy21dVcFJfucOAlyOaD0dBidVgI84sy3+hasNAbOJlFopeIX
        EoGBXAmUhpgj+FmhG/kz41N/6M8NIlNgrCEMfeZjFloXm7gwFQyF30r1x8A5O1Ae0MgVdJ
        w9n7t84CPDZqWN9vXSJzz+kCubBP+BWaDlt+OHM8hc8e8905TZMfm5ln6dAhILh8HZ273m
        myRuJkzDuM/0PtnahsjcVV7NerXl1J+nrLHS7FK5f2OsLl4h+1Sz88UbEye5LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666191370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzgyVUdc3c3kCjuysiyU5ciOaxj14Ka8qNAluIGo2ws=;
        b=538n87jf9fQBuIO0i1kQOYmPKMxRqFehBEvcShiER+MFwipHan1NRjt/wMAfdBOIqq93S6
        /K6fsXGFCl2rWVBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH printk v2 15/38] tty: serial: serial_core: use console_is_enabled()
Date:   Wed, 19 Oct 2022 17:01:37 +0206
Message-Id: <20221019145600.1282823-16-john.ogness@linutronix.de>
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

Replace (console->flags & CON_ENABLED) usage with console_is_enabled().

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/serial_core.c | 2 +-
 include/linux/serial_core.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 179ee199df34..ebf609e4e179 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2573,7 +2573,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * successfully registered yet, try to re-register it.
 		 * It may be that the port was not available.
 		 */
-		if (port->cons && !(port->cons->flags & CON_ENABLED))
+		if (port->cons && !console_is_enabled(port->cons))
 			register_console(port->cons);
 
 		/*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d657f2a42a7b..ed5d1aeb91e1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -745,7 +745,7 @@ static inline int setup_earlycon(char *buf) { return 0; }
 
 static inline bool uart_console_enabled(struct uart_port *port)
 {
-	return uart_console(port) && (port->cons->flags & CON_ENABLED);
+	return uart_console(port) && console_is_enabled(port->cons);
 }
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
-- 
2.30.2

