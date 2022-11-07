Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7443161FAF2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiKGRPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiKGRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:15:11 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5421CB17;
        Mon,  7 Nov 2022 09:15:10 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f8so7562135qkg.3;
        Mon, 07 Nov 2022 09:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ad8luJYSej7aw2mX5QDdm2q90JBkKxRfRuuN+1GfVOg=;
        b=iO1KP1sN9ONNmhVWElB/IPStlYoF/+sJKZXELeNvF57ki8OZKdN2vtv7LxIcGFOBTC
         D0qYKNSW4VctBK4su1IbcDI0nePTpZpPzUWZVyPTCi4oKjDEWj3RhoS/1bjOFRRGXz11
         gihW4NhNDIo/zvrS3kl9mg5Wp4cUcDRMe6vIHzcSpx7Sfm4zC5FbR/DC3VONdmescEEc
         mqiDNAorWDcnSeDoTkbdzPivTnFk9GNw1UwPXJ7CP8WRdK2xQaqdDPx73QImStNPd33q
         ON6frvBKN0JP1qo6uB4vS2FPN2lC6/ooaokPvlxQliaW1tp/QZV9NIlTowK8V5ivL4GM
         5CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ad8luJYSej7aw2mX5QDdm2q90JBkKxRfRuuN+1GfVOg=;
        b=1foJbaOh4PhWCVIxiozzYlBhg4lh2UbDOKA+VNduZg6ZC5m862NMUTFKvbY6tgZ4xN
         cgSxjVeHetb4EcVJ93FXLJ0EsjszYHVKD1eE4DU7YAYcZvnY80JS1pNtfMjGZoqN6KY3
         yCRd6HwMvte4JwoLsQvDBGugOF2nwpDDBZQjNQeLFXaZBHZc5Fh8ygrxvcuWR5MIXCWK
         CEWDg+XvHomRTXDQHaeCNmrwPVTX6TFEcU4FlGNQIUhK8WL1r/SAlD/c/UVwjFBFzOHg
         TuY/J0nkZs4+2ediKEfE0QHCEM+8tNC2tZah/phpfFRAh9Sp+oeHpwtWCsKy5G0YFWBF
         kp8g==
X-Gm-Message-State: ACrzQf3ShMqqPgKCt4nRaNbksHW2j3IW0xgQUaRJwMi2wg/rKQwrIRyo
        AwTWH8ghHU+9fRJp24aIVqXpYqmKFZSBmQ==
X-Google-Smtp-Source: AMsMyM4Fkzd9tqv3aaL9PfqEgkgX6/D7+Fn0CGNn7EpzOEIrmpIcIkW1e9jwRp+mohn9FwrSSLUbvQ==
X-Received: by 2002:a37:ad18:0:b0:6fa:b07:9e8d with SMTP id f24-20020a37ad18000000b006fa0b079e8dmr35152948qkm.670.1667841309023;
        Mon, 07 Nov 2022 09:15:09 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b006ce9e880c6fsm7333611qkb.111.2022.11.07.09.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:15:08 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: [PATCH v1 1/3] serial: liteuart: cosmetic changes
Date:   Mon,  7 Nov 2022 12:14:58 -0500
Message-Id: <20221107171500.2537938-2-gsomlo@gmail.com>
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

Make some cosmetic/stylistic (non-functional) improvements:

1. Use a DRV_NAME macro to avoid hard-coding "liteuart" in multiple
locations throughout the source file

2. Use bit numbers instead of magic constants for event flags

3. Remove stub uart_ops methods that are not called unconditionally
from serial_core; Document stubs that are required by serial_core

4. Don't set unused port->regshift and port->iobase fields gratuitously
during probe()

5. Improve coding style in liteuart_init()

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 38 +++++++++--------------------------
 1 file changed, 10 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 4c0604325ee9..4b9cca249828 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -18,6 +18,8 @@
 #include <linux/tty_flip.h>
 #include <linux/xarray.h>
 
+#define DRV_NAME "liteuart"
+
 /*
  * CSRs definitions (base address offsets + width)
  *
@@ -38,8 +40,8 @@
 #define OFF_EV_ENABLE	0x14
 
 /* events */
-#define EV_TX		0x1
-#define EV_RX		0x2
+#define EV_TX		BIT(0)
+#define EV_RX		BIT(1)
 
 struct liteuart_port {
 	struct uart_port port;
@@ -57,7 +59,7 @@ static struct console liteuart_console;
 
 static struct uart_driver liteuart_driver = {
 	.owner = THIS_MODULE,
-	.driver_name = "liteuart",
+	.driver_name = DRV_NAME,
 	.dev_name = "ttyLXU",
 	.major = 0,
 	.minor = 0,
@@ -122,6 +124,7 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 
 static void liteuart_stop_tx(struct uart_port *port)
 {
+	/* not used in LiteUART, but called unconditionally from serial_core */
 }
 
 static void liteuart_start_tx(struct uart_port *port)
@@ -154,11 +157,6 @@ static void liteuart_stop_rx(struct uart_port *port)
 	del_timer(&uart->timer);
 }
 
-static void liteuart_break_ctl(struct uart_port *port, int break_state)
-{
-	/* LiteUART doesn't support sending break signal */
-}
-
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
@@ -197,15 +195,6 @@ static const char *liteuart_type(struct uart_port *port)
 	return "liteuart";
 }
 
-static void liteuart_release_port(struct uart_port *port)
-{
-}
-
-static int liteuart_request_port(struct uart_port *port)
-{
-	return 0;
-}
-
 static void liteuart_config_port(struct uart_port *port, int flags)
 {
 	/*
@@ -232,13 +221,10 @@ static const struct uart_ops liteuart_ops = {
 	.stop_tx	= liteuart_stop_tx,
 	.start_tx	= liteuart_start_tx,
 	.stop_rx	= liteuart_stop_rx,
-	.break_ctl	= liteuart_break_ctl,
 	.startup	= liteuart_startup,
 	.shutdown	= liteuart_shutdown,
 	.set_termios	= liteuart_set_termios,
 	.type		= liteuart_type,
-	.release_port	= liteuart_release_port,
-	.request_port	= liteuart_request_port,
 	.config_port	= liteuart_config_port,
 	.verify_port	= liteuart_verify_port,
 };
@@ -280,9 +266,7 @@ static int liteuart_probe(struct platform_device *pdev)
 	port->iotype = UPIO_MEM;
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->ops = &liteuart_ops;
-	port->regshift = 2;
 	port->fifosize = 16;
-	port->iobase = 1;
 	port->type = PORT_UNKNOWN;
 	port->line = dev_id;
 	spin_lock_init(&port->lock);
@@ -322,7 +306,7 @@ static struct platform_driver liteuart_platform_driver = {
 	.probe = liteuart_probe,
 	.remove = liteuart_remove,
 	.driver = {
-		.name = "liteuart",
+		.name = DRV_NAME,
 		.of_match_table = liteuart_of_match,
 	},
 };
@@ -368,7 +352,7 @@ static int liteuart_console_setup(struct console *co, char *options)
 }
 
 static struct console liteuart_console = {
-	.name = "liteuart",
+	.name = DRV_NAME,
 	.write = liteuart_console_write,
 	.device = uart_console_device,
 	.setup = liteuart_console_setup,
@@ -416,12 +400,10 @@ static int __init liteuart_init(void)
 		return res;
 
 	res = platform_driver_register(&liteuart_platform_driver);
-	if (res) {
+	if (res)
 		uart_unregister_driver(&liteuart_driver);
-		return res;
-	}
 
-	return 0;
+	return res;
 }
 
 static void __exit liteuart_exit(void)
-- 
2.37.3

