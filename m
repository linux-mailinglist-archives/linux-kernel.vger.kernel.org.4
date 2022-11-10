Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2923E623856
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiKJApY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbiKJApH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:07 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23610B4B;
        Wed,  9 Nov 2022 16:45:05 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v8so276361qkg.12;
        Wed, 09 Nov 2022 16:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGJtELmNn2N31csZAgx2uQhrYPHpFF+hYpnYsk0wKOQ=;
        b=PGzXe0NF6uhRCr/YlqlmwGO9Vn7L9XDFgrwLwqdU3s+9e4Guk+msChFd1ZpbLpuR/j
         krg277Y74VLK04l9Kn9/mpojXgvJfkw7SlwoxpvBzFrCPbfwmwSrHGkY6EWSIqocbZnK
         7qC6MdJIoAS6tf4nib2gB70ymqOlYvVj0GgwYxN37N/dqIC9T/emrkQ8tGx/BEhzqI3/
         TvnBgNQgffvQVNSkMBqJaaVwsdoE5tHlXdW1UTi+DakZPAybRW+AAGAh5eKSGgwIY6Xc
         +RCYUf0P8et2C915xHdKldzeUBB1rM1HkFGtSikA6xzOi9bxAAtx/JVLKXVzXfVSodTG
         /9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGJtELmNn2N31csZAgx2uQhrYPHpFF+hYpnYsk0wKOQ=;
        b=yqjWb7p3uSZpltnJwZd9CC9Rq1hn+l97XqJq2yJqw3SF6AvCXeOFOK8CEZGkMEVELS
         MEl+7TJpNYEV7BNnWuTMK/dGZyvOCj8KDtUINL3EFJ3r59fPZpeLoF2DZyN4c0K0rdM3
         z15YKvamjpNIvZXuuFNCnbb9gY4Qm7JdPpwqzb66Eom9eYzwGNtPV3Fdn9wcWEpn/QAE
         sGvldyb7jn5Ft+R5EHmWysoz+2l3JNKbnzDf4gIt7uVF9hm6CZNHa9nWg+4Y3NVaDa4u
         NmWdXU465XUTNwFb7jiCWdrM3dIzUEyu/yVYqKkVZLoLoc1PnPkTBvBSPqsjzFIsdvgo
         I28A==
X-Gm-Message-State: ANoB5pkeDSlCt5+7s78z7DWviBVTqJk6K0gmN8lC7IhJl0eu3g+phSPu
        2KG/p+QiBnPkTU+NBkfi2VmG84eY/rEEkw==
X-Google-Smtp-Source: AA0mqf7ONdtZeMcE/TcJ/hb19GNm8vvMxnryhx/U1o6x7euahSllOb1OxXcB+AaczRvC+v7GfQv5wg==
X-Received: by 2002:ae9:f30d:0:b0:6fb:7cb:7b21 with SMTP id p13-20020ae9f30d000000b006fb07cb7b21mr7851196qkg.653.1668041105219;
        Wed, 09 Nov 2022 16:45:05 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:04 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 6/7] serial: liteuart: separate RX loop from poll timer
Date:   Wed,  9 Nov 2022 19:44:49 -0500
Message-Id: <20221110004450.772768-7-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110004450.772768-1-gsomlo@gmail.com>
References: <20221110004450.772768-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the character-receive (RX) loop to its own dedicated function,
and (for now) call that from the poll timer, liteuart_timer().

This is in preparation for adding IRQ support to the receive path.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 047d5ad32e13..aa7052280197 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -67,29 +67,34 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_timer(struct timer_list *t)
+static void liteuart_rx_chars(struct uart_port *port)
 {
-	struct liteuart_port *uart = from_timer(uart, t, timer);
-	struct uart_port *port = &uart->port;
 	unsigned char __iomem *membase = port->membase;
-	unsigned int flg = TTY_NORMAL;
-	int ch;
-	unsigned long status;
+	unsigned int status;
+	unsigned char ch;
 
 	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
 		ch = litex_read8(membase + OFF_RXTX);
 		port->icount.rx++;
 
 		/* necessary for RXEMPTY to refresh its value */
-		litex_write8(membase + OFF_EV_PENDING, EV_TX | EV_RX);
+		litex_write8(membase + OFF_EV_PENDING, EV_RX);
 
 		/* no overflow bits in status */
 		if (!(uart_handle_sysrq_char(port, ch)))
-			uart_insert_char(port, status, 0, ch, flg);
-
-		tty_flip_buffer_push(&port->state->port);
+			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
 	}
 
+	tty_flip_buffer_push(&port->state->port);
+}
+
+static void liteuart_timer(struct timer_list *t)
+{
+	struct liteuart_port *uart = from_timer(uart, t, timer);
+	struct uart_port *port = &uart->port;
+
+	liteuart_rx_chars(port);
+
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-- 
2.37.3

