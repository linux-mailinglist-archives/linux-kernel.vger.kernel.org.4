Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C26E5BDC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiITFVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiITFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FF84F669;
        Mon, 19 Sep 2022 22:20:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B4371F8A8;
        Tue, 20 Sep 2022 05:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DR+e5tUXrU5pDouwWQoOJcV84hEa4+bOrdcoGBahis=;
        b=AHlZ6BHmkCZhxrHKia31hETrcgXlk+z2qr1mmJoKqGy8iCeLFN5pmRIKSo6tvoGDZ+MsxV
        EGPlgFVnH9amtpbWjXAvi3U72/FyvTcEtWVA1poFSDX+sxjzNKR1QrW4VyDyzNMxLUnZV9
        //Lmah+LrAYoJ6uR/44KRIvELBy9zh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651252;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DR+e5tUXrU5pDouwWQoOJcV84hEa4+bOrdcoGBahis=;
        b=3KvSp9eNVo6hma1f/FIQVS47Gx+6sERkSqqH6QPNc8c3rEaFCIC3sAOFTTchzZYbg4zyld
        yOSEBD2qbOiPeoAA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6DF7E2C142;
        Tue, 20 Sep 2022 05:20:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 05/10] tty: serial: extract tx_ready() from __serial_lpc32xx_tx()
Date:   Tue, 20 Sep 2022 07:20:45 +0200
Message-Id: <20220920052049.20507-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920052049.20507-1-jslaby@suse.cz>
References: <20220920052049.20507-1-jslaby@suse.cz>
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

The condition in __serial_lpc32xx_tx()'s loop is barely readable.
Extract it to a separate function. This will make the cleanup in the
next patches easier too.

Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v4] this is new in v4 -- extracted as a separate change

 drivers/tty/serial/lpc32xx_hs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 0d5ef7df27d0..ed47f4768338 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -278,6 +278,13 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 
 static void serial_lpc32xx_stop_tx(struct uart_port *port);
 
+static bool serial_lpc32xx_tx_ready(struct uart_port *port)
+{
+	u32 level = readl(LPC32XX_HSUART_LEVEL(port->membase));
+
+	return LPC32XX_HSU_TX_LEV(level) < 64;
+}
+
 static void __serial_lpc32xx_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
@@ -293,8 +300,7 @@ static void __serial_lpc32xx_tx(struct uart_port *port)
 		goto exit_tx;
 
 	/* Transfer data */
-	while (LPC32XX_HSU_TX_LEV(readl(
-		LPC32XX_HSUART_LEVEL(port->membase))) < 64) {
+	while (serial_lpc32xx_tx_ready(port)) {
 		writel((u32) xmit->buf[xmit->tail],
 		       LPC32XX_HSUART_FIFO(port->membase));
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-- 
2.37.3

