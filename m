Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178E4750158
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjGLIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjGLIWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B94228;
        Wed, 12 Jul 2023 01:18:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E4EA6170C;
        Wed, 12 Jul 2023 08:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF8BC433CA;
        Wed, 12 Jul 2023 08:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149913;
        bh=XZREM9dFS9eFEHKaYWll8W+f8NiG+samOrQfIYNIBMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U6aiLMSO7gbLvJ0LltqlGjeqxKQ8Gk+DOFVChVi6j20z3cYmwxXz3BBKf4HO5VorU
         fPz+uoQTUA6x8ZnhVzbP8cRAVk5RMw6yE7G8+Eq3bNUgxEMg3AD+L1b3duzqY5S+qx
         oEO5nnvQRtirI+4fnNk06YddQffnIqbrVpz2CRuq4ZpRFYS6WbKUDfKcFEAXAwTwBm
         KIb28rEXRW/YovyxzwBSDChGJ5/p6YQJHOneY5AQhROVlG0x1yKQl13AN/ExhlA+fL
         AIAKfX9EyBx2jORDXcEuhDG0cXV9JOFVA3wUR24T0uKGzLfgzTyjvAmoeDUj5vixeY
         qpUFtI+GRUryg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 08/10] serial: arc_uart: simplify flags handling in arc_serial_rx_chars()
Date:   Wed, 12 Jul 2023 10:18:09 +0200
Message-ID: <20230712081811.29004-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* move the declaration of flg (with the initializer) to the loop, so
  there is no need to reset it to TTY_NORMAL by an 'else' branch.
* use TTY_NORMAL as initializer above, not a magic zero constant
* remove the outer 'if' from this construct:
  if (S & (A | B)) {
    if (S & A)
      X;
    if (S & B)
      Y;
  }
* drop unlikely() as I doubt it has any benefits here. If it does,
  provide numbers.

All four make the code easier to read.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
---
 drivers/tty/serial/arc_uart.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 4b2512eef577..835903488acb 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -195,8 +195,6 @@ static void arc_serial_start_tx(struct uart_port *port)
 
 static void arc_serial_rx_chars(struct uart_port *port, unsigned int status)
 {
-	unsigned int ch, flg = 0;
-
 	/*
 	 * UART has 4 deep RX-FIFO. Driver's recongnition of this fact
 	 * is very subtle. Here's how ...
@@ -207,24 +205,23 @@ static void arc_serial_rx_chars(struct uart_port *port, unsigned int status)
 	 * controller, which is indeed the Rx-FIFO.
 	 */
 	do {
+		unsigned int ch, flg = TTY_NORMAL;
+
 		/*
 		 * This could be an Rx Intr for err (no data),
 		 * so check err and clear that Intr first
 		 */
-		if (unlikely(status & (RXOERR | RXFERR))) {
-			if (status & RXOERR) {
-				port->icount.overrun++;
-				flg = TTY_OVERRUN;
-				UART_CLR_STATUS(port, RXOERR);
-			}
-
-			if (status & RXFERR) {
-				port->icount.frame++;
-				flg = TTY_FRAME;
-				UART_CLR_STATUS(port, RXFERR);
-			}
-		} else
-			flg = TTY_NORMAL;
+		if (status & RXOERR) {
+			port->icount.overrun++;
+			flg = TTY_OVERRUN;
+			UART_CLR_STATUS(port, RXOERR);
+		}
+
+		if (status & RXFERR) {
+			port->icount.frame++;
+			flg = TTY_FRAME;
+			UART_CLR_STATUS(port, RXFERR);
+		}
 
 		if (status & RXEMPTY)
 			continue;
-- 
2.41.0

