Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4335BDC49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiITFVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiITFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121BC4DB7A;
        Mon, 19 Sep 2022 22:20:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BE5AA1F8B0;
        Tue, 20 Sep 2022 05:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqYWbHDys658PO9cI+Q4Z9fm/eu7KUQM2lLlwljC3xU=;
        b=V0cjK7yIJU3KGRaV1ns5Ue01jzb1IEM9mQOPmKorxPHeY5lRbhV9x7x9mZSVX58sJss5MW
        78fdsgzTs+nQsK7LnPaXZDUva6ysoh+tujDKX6v2A3uAW4CeVDpnphVBDXyrNAFsLKGRW5
        Eki8M08bsuobCa07kmKLSDofdStwkdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqYWbHDys658PO9cI+Q4Z9fm/eu7KUQM2lLlwljC3xU=;
        b=Vcj6lXpcWhOmR7ycgpi0XPB/h6zk0jlUMC2iFU5fpMT6GqWLxQtTZ5nm5FIQpQI0oXnufP
        9lnNPPUOqjTd1jDw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9058E2C142;
        Tue, 20 Sep 2022 05:20:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 07/10] tty: serial: extract serial_omap_put_char() from transmit_chars()
Date:   Tue, 20 Sep 2022 07:20:47 +0200
Message-Id: <20220920052049.20507-8-jslaby@suse.cz>
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

This non-trivial code is doubled in transmit_chars(), so it deserves its
own function. This will make next patches easier.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v4] this is new in v4 -- extracted as a separate change

 drivers/tty/serial/omap-serial.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c87d85b901a7..b7b76e49115e 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -337,19 +337,24 @@ static void serial_omap_stop_rx(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+static void serial_omap_put_char(struct uart_omap_port *up, unsigned char ch)
+{
+	serial_out(up, UART_TX, ch);
+
+	if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
+			!(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		up->rs485_tx_filter_count++;
+}
+
 static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 {
 	struct circ_buf *xmit = &up->port.state->xmit;
 	int count;
 
 	if (up->port.x_char) {
-		serial_out(up, UART_TX, up->port.x_char);
+		serial_omap_put_char(up, up->port.x_char);
 		up->port.icount.tx++;
 		up->port.x_char = 0;
-		if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
-		    !(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			up->rs485_tx_filter_count++;
-
 		return;
 	}
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
@@ -358,12 +363,9 @@ static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 	}
 	count = up->port.fifosize / 4;
 	do {
-		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
+		serial_omap_put_char(up, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		up->port.icount.tx++;
-		if ((up->port.rs485.flags & SER_RS485_ENABLED) &&
-		    !(up->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			up->rs485_tx_filter_count++;
 
 		if (uart_circ_empty(xmit))
 			break;
-- 
2.37.3

