Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1D5BDC48
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiITFVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiITFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA050184;
        Mon, 19 Sep 2022 22:20:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 867981F8AB;
        Tue, 20 Sep 2022 05:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYr7Z62BDiJmHGeEjwvvRpRLmgO1LxdvAVFhnRhBAuU=;
        b=gShQunqA0Rgna9E2rlYCaPjsbh+aRbdw8uxgzvHtnLorl9NLvg7g7GhtTuscdkAqxnM1nI
        //uO2xSaCn1i/WoTl4UgJBWI388oYH6jsZwYRjatTPH8N480KirwLCoCm7bS8HDsWhoELg
        Vspzw2t7eoJ+8mFF6SsfPO/oAcpoMig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oYr7Z62BDiJmHGeEjwvvRpRLmgO1LxdvAVFhnRhBAuU=;
        b=xzZ8giAcMxfEo/SouinHWMmzrOIiXZCMRtaq8Vvo2sfP/TduXLv2poBA7DsfZ8z1G5Kz6a
        Z5N43FEfcD0IhGAA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56EA12C141;
        Tue, 20 Sep 2022 05:20:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 06/10] tty: serial: switch mpc52xx_uart_int_{r,t}x_chars() to bool
Date:   Tue, 20 Sep 2022 07:20:46 +0200
Message-Id: <20220920052049.20507-7-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920052049.20507-1-jslaby@suse.cz>
References: <20220920052049.20507-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc52xx_uart_int_rx_chars() returns unsigned int.
mpc52xx_uart_int_tx_chars() returns int.

The both results are binary ORed to the "keepgoing" variable. Unify all
three to bool as the only interesting value is whether we should keep
looping (true/false).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v4] this is new in v4 -- extracted as a separate change

 drivers/tty/serial/mpc52xx_uart.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 6f09b1cb3e1c..73362d4bc45d 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1364,7 +1364,7 @@ static const struct uart_ops mpc52xx_uart_ops = {
 /* Interrupt handling                                                       */
 /* ======================================================================== */
 
-static inline unsigned int
+static inline bool
 mpc52xx_uart_int_rx_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -1425,7 +1425,7 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 	return psc_ops->raw_rx_rdy(port);
 }
 
-static inline int
+static inline bool
 mpc52xx_uart_int_tx_chars(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
@@ -1435,13 +1435,13 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 		psc_ops->write_char(port, port->x_char);
 		port->icount.tx++;
 		port->x_char = 0;
-		return 1;
+		return true;
 	}
 
 	/* Nothing to do ? */
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
 		mpc52xx_uart_stop_tx(port);
-		return 0;
+		return false;
 	}
 
 	/* Send chars */
@@ -1460,23 +1460,23 @@ mpc52xx_uart_int_tx_chars(struct uart_port *port)
 	/* Maybe we're done after all */
 	if (uart_circ_empty(xmit)) {
 		mpc52xx_uart_stop_tx(port);
-		return 0;
+		return false;
 	}
 
-	return 1;
+	return true;
 }
 
 static irqreturn_t
 mpc5xxx_uart_process_int(struct uart_port *port)
 {
 	unsigned long pass = ISR_PASS_LIMIT;
-	unsigned int keepgoing;
+	bool keepgoing;
 	u8 status;
 
 	/* While we have stuff to do, we continue */
 	do {
 		/* If we don't find anything to do, we stop */
-		keepgoing = 0;
+		keepgoing = false;
 
 		psc_ops->rx_clr_irq(port);
 		if (psc_ops->rx_rdy(port))
@@ -1495,7 +1495,7 @@ mpc5xxx_uart_process_int(struct uart_port *port)
 
 		/* Limit number of iteration */
 		if (!(--pass))
-			keepgoing = 0;
+			keepgoing = false;
 
 	} while (keepgoing);
 
-- 
2.37.3

