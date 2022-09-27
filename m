Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080415EC0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiI0LTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiI0LSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:18:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AABB6BCE9;
        Tue, 27 Sep 2022 04:18:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AE451FD05;
        Tue, 27 Sep 2022 11:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664277501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gm3ZZcNM0cZY4fp0d7F1FO1agY/rjagivksQPwk6oIA=;
        b=ppqx4kdco2y2Xo+vIvFPNzincoNo3Qwu7T3jJSA7FI0FamgW9vwRn7/sgsusjfTiej1ePN
        7sM1Y5JkdiQojlVyYUgaaxhwnR/SbHsZGl4cBaqdDkNUaGo3i2TV+mEzJgVCOjt0HSfvKV
        Phm4Nkhxo5pGCVxutaWnnknL/eSNzkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664277501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gm3ZZcNM0cZY4fp0d7F1FO1agY/rjagivksQPwk6oIA=;
        b=QvdEkqSKah1i7nT4ePYpknUqnl3xXCbstUGUzQyh7RzdtaMto+1v2jnQgIm+BxaWOpp/9L
        Ab7xdE1bs35yaWAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 039E62C166;
        Tue, 27 Sep 2022 11:18:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 3/4] tty: serial: unify TX space reads under altera_jtaguart_tx_space()
Date:   Tue, 27 Sep 2022 13:18:18 +0200
Message-Id: <20220927111819.18516-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927111819.18516-1-jslaby@suse.cz>
References: <20220927111819.18516-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TX space reads from the control register are performed in various forms
on 4 places in altera_jtaguart. Unify all those and do the read and
masking on a single place.

The new helper altera_jtaguart_tx_space() uses FIELD_GET(), so we can
drop ALTERA_JTAGUART_CONTROL_WSPACE_OFF now.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/altera_jtaguart.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 23f339757894..ac8ce418de36 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -9,6 +9,7 @@
  * (C) Copyright 2010, Tobias Klauser <tklauser@distanz.ch>
  */
 
+#include <linux/bitfield.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -48,7 +49,6 @@
 #define ALTERA_JTAGUART_CONTROL_WI_MSK		0x00000200
 #define ALTERA_JTAGUART_CONTROL_AC_MSK		0x00000400
 #define ALTERA_JTAGUART_CONTROL_WSPACE_MSK	0xFFFF0000
-#define ALTERA_JTAGUART_CONTROL_WSPACE_OFF	16
 
 /*
  * Local per-uart structure.
@@ -59,10 +59,19 @@ struct altera_jtaguart {
 	unsigned long imr;	/* Local IMR mirror */
 };
 
+static unsigned int altera_jtaguart_tx_space(struct uart_port *port, u32 *ctlp)
+{
+	u32 ctl = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG);
+
+	if (ctlp)
+		*ctlp = ctl;
+
+	return FIELD_GET(ALTERA_JTAGUART_CONTROL_WSPACE_MSK, ctl);
+}
+
 static unsigned int altera_jtaguart_tx_empty(struct uart_port *port)
 {
-	return (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
-		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) ? TIOCSER_TEMT : 0;
+	return altera_jtaguart_tx_space(port, NULL) ? TIOCSER_TEMT : 0;
 }
 
 static unsigned int altera_jtaguart_get_mctrl(struct uart_port *port)
@@ -150,9 +159,7 @@ static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
 
 	pending = uart_circ_chars_pending(xmit);
 	if (pending > 0) {
-		count = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
-				ALTERA_JTAGUART_CONTROL_WSPACE_MSK) >>
-			ALTERA_JTAGUART_CONTROL_WSPACE_OFF;
+		count = altera_jtaguart_tx_space(port, NULL);
 		if (count > pending)
 			count = pending;
 		if (count > 0) {
@@ -298,12 +305,11 @@ static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE_BYPASS)
 static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c)
 {
-	unsigned long status;
 	unsigned long flags;
+	u32 status;
 
 	spin_lock_irqsave(&port->lock, flags);
-	while (((status = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG)) &
-		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0) {
+	while (!altera_jtaguart_tx_space(port, &status)) {
 		if ((status & ALTERA_JTAGUART_CONTROL_AC_MSK) == 0) {
 			spin_unlock_irqrestore(&port->lock, flags);
 			return;	/* no connection activity */
@@ -321,8 +327,7 @@ static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
-	while ((readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) &
-		ALTERA_JTAGUART_CONTROL_WSPACE_MSK) == 0) {
+	while (!altera_jtaguart_tx_space(port, NULL)) {
 		spin_unlock_irqrestore(&port->lock, flags);
 		cpu_relax();
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.37.3

