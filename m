Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC0C61FAF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiKGRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbiKGRPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:15:12 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600101C42C;
        Mon,  7 Nov 2022 09:15:11 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id x21so7585546qkj.0;
        Mon, 07 Nov 2022 09:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjEUwtW5sL8GuJYm/+Q478PkR3HMmEg3Xukh/a9IkLc=;
        b=L0wrRao/Xut4IM2FaxKpjdKujuZ1Yf/LBQd1EzW1Cf9wkQFEhgfCW8YK6MlK3v61vR
         /3bv3OFywufm8UK0IVlu09o+MQj/1yuKMSKHe60jwYPpbbSd3qUDN5E49xmtt7e98Wag
         58lb4NEWqLTpHccsT4IXzn0hCu1uYADu6SVKsaNP2Tvm8Emnphe0c1+eK9rWVn8IIkTl
         bDAdvB66h9WIX/BkwOFUMYO7NTPOGYoZF70dKMwVRqmv/e+V8Z94eIEFcoASri09l7y3
         /iTJjoQwi5D8uvYidgsyseF6NjKjN1itj82bfdwOpeygbvOE6c0qXb9vMCRgtv6LEnvE
         BREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjEUwtW5sL8GuJYm/+Q478PkR3HMmEg3Xukh/a9IkLc=;
        b=kREje7zXbthYz+fzmvmzg9tluRVwAlUw8mgHpRtwWM98JaQfEV7qfAMKuDlOlhRNLe
         U9GyLRrpTlGhrXjuIesKWBuLoEtsendmE0RFzH/HDOgn5Fzmrg2Hj5ltBrQtmx1P9tc0
         8ObDR1NSpiuCN7PJKnNBF50gFuiNqMx5Ggk4yTUUKysK5hyYKDE94eC7/vOLgtL+Ciw+
         njVVOJONOaxGG+0OfWsJpFXuEwLZAqdAWUaPUQYdjm6P7SC5FObdlgMGbQfXBZBZmjC6
         X9rSuMKBbSl/Z/JcUw4UnguSRJwsFdDYK4Mqa+q3kqWmUUlLZdVK2h/YSTsDi3PreCLv
         F3Mg==
X-Gm-Message-State: ACrzQf2BJPpSoyv8RJEBQqy/b1rUEmZU/DiV4ztze3yobluH5Yg3TWl7
        Udwd/8hBukG9gXwkXmEzv7NmjOkboVPNRA==
X-Google-Smtp-Source: AMsMyM7zaYMrE9JkkNtWvE8rOYVyRltFMsZh3U/rSxGOscYe0tMMdIn3zm1u54X3buS16s2YcegmMQ==
X-Received: by 2002:a05:620a:12b5:b0:6fa:8a0c:ffd9 with SMTP id x21-20020a05620a12b500b006fa8a0cffd9mr13426265qki.518.1667841310142;
        Mon, 07 Nov 2022 09:15:10 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b006ce9e880c6fsm7333611qkb.111.2022.11.07.09.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:15:09 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: [PATCH v1 2/3] serial: liteuart: separate RX loop from poll timer
Date:   Mon,  7 Nov 2022 12:14:59 -0500
Message-Id: <20221107171500.2537938-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107171500.2537938-1-gsomlo@gmail.com>
References: <20221107171500.2537938-1-gsomlo@gmail.com>
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
index 4b9cca249828..90a29ed79bff 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -69,29 +69,34 @@ static struct uart_driver liteuart_driver = {
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

