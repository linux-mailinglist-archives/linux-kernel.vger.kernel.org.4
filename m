Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC0608DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJVPNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJVPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:13:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675281366A4;
        Sat, 22 Oct 2022 08:13:04 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a10so8641337wrm.12;
        Sat, 22 Oct 2022 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tn9ME0TL0Y61oMWgSDpk8x/grA5ek9OA4zh/3kmEPY=;
        b=GW6/l8Uizmyk8qF8jHpYfz4onM5N4g60uc/bdSTaYk01iniF1ZAx6pIQKcNcUHVvfO
         oZa3Ug4sBDiPhEV7NJd+arZ2743Nyw9QCdquW6gP3SQRQkoHOox/zVPn85tE1+qPh3SB
         uPjZeHR9n5Ot9bQW8BbhW24iKUKKJUxsi58ENfKu0p6UoyFY3Mb4bW1lvdWf7ruP/2Ct
         AK4CvyA2f4/EYH6zQ4t7mroec2yKxVH2HoxTx1JHTPvSB4xIcJe8xVbwYUZl3AxI4nRf
         YIfLXdyywGGGNKQPOvLuprvdTXN/E/Fkc7auipw3rBa06SwZgdUzEcn+mpN//LTzNJXM
         H4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/tn9ME0TL0Y61oMWgSDpk8x/grA5ek9OA4zh/3kmEPY=;
        b=aANCfTw4+pyTo5kfqsuhmbfYvk9E5bfjisVA6nu6AqLdmwIAB/8+CD/Skq+CKH2Cxr
         UUpu4xifop4qO89ZQJy1V6sG8zwq9Cgg6aTPi0TnN/bBgjEu3LwYkjeyq8R8cy5KskRf
         66v6cWAD9hZTkG1sWDyJRpIH6TZX442hcbM2QQF6TWMjRlaxOafYG7PSHOFGoZXkc8+J
         xprQCvONWt19yyCKQVtG8OWvOlGvdyfQDY4LBMNP6MnYstgUhSIbZ3VtEs9wqpQs/hzh
         +a7I/loU7Glh6fdqQCnPH9qGwR+Abp+prgSfDXhUInDHdWm0oPYn2p+CfnM2gyPLNtJW
         tnnw==
X-Gm-Message-State: ACrzQf1pIgKJ5uq4EtGFjW3Y0W3HfIF1GRLneJAmgM/bTSypQ7XMGOQV
        +rBM8aisebyp+h//mwVsoNI=
X-Google-Smtp-Source: AMsMyM5vOXs+oBjgGHsKPd1b4S6qy+roDx3CDdb9OtBvR7J9WzXkYmXr7Y+R5BUL4bb8uBZT5hvsXA==
X-Received: by 2002:adf:ec03:0:b0:22e:4d3:bb37 with SMTP id x3-20020adfec03000000b0022e04d3bb37mr15469099wrn.665.1666451582570;
        Sat, 22 Oct 2022 08:13:02 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.133])
        by smtp.gmail.com with ESMTPSA id u11-20020adff88b000000b0022e2eaa2bdcsm21310581wrp.98.2022.10.22.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 08:13:02 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 2/2] serial: 8250/ingenic: Add support for the JZ4750/JZ4755
Date:   Sat, 22 Oct 2022 18:12:24 +0300
Message-Id: <20221022151224.4000238-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221022151224.4000238-1-lis8215@gmail.com>
References: <20221022151224.4000238-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JZ4750/55/60 (but not JZ4760b) have an extra divisor in between extclk
and peripheral clock, called CPCCR.ECS, the driver can't figure out the
real state of the divisor without dirty hack - peek CGU CPCCR register.
However, we can rely on a vendor's bootloader (u-boot 1.1.6) behavior:
if (extclk > 16MHz)
    the divisor is enabled, so the UART driving clock is extclk/2.

This behavior relies on hardware differences: most boards (if not all)
with those SoCs have 12 or 24 MHz oscillators but many peripherals want
12Mhz to operate properly (AIC and USB-PHY at least).

The patch doesn't affect JZ4760's behavior as it is subject for another
patchset with re-classification of all supported ingenic UARTs.

Link: https://github.com/carlos-wong/uboot_jz4755/blob/master/cpu/mips/jz_serial.c#L158
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 50 ++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 2b2f5d8d2..3ffa6b722 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -87,24 +87,19 @@ static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev
 	dev->port.uartclk = be32_to_cpup(prop);
 }
 
-static int __init ingenic_early_console_setup(struct earlycon_device *dev,
-					      const char *opt)
+static int __init ingenic_earlycon_setup_tail(struct earlycon_device *dev,
+					      const char *opt)
 {
 	struct uart_port *port = &dev->port;
 	unsigned int divisor;
 	int baud = 115200;
 
-	if (!dev->port.membase)
-		return -ENODEV;
-
 	if (opt) {
 		unsigned int parity, bits, flow; /* unused for now */
 
 		uart_parse_options(opt, &baud, &parity, &bits, &flow);
 	}
 
-	ingenic_early_console_setup_clock(dev);
-
 	if (dev->baud)
 		baud = dev->baud;
 	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
@@ -129,9 +124,49 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 	return 0;
 }
 
+static int __init ingenic_early_console_setup(struct earlycon_device *dev,
+					      const char *opt)
+{
+	if (!dev->port.membase)
+		return -ENODEV;
+
+	ingenic_early_console_setup_clock(dev);
+
+	ingenic_earlycon_setup_tail(dev, opt);
+}
+
+static int __init jz4750_early_console_setup(struct earlycon_device *dev,
+					     const char *opt)
+{
+	if (!dev->port.membase)
+		return -ENODEV;
+
+	/*
+	 * JZ4750/55/60 (not JZ4760b) have an extra divisor
+	 * between extclk and peripheral clock, the
+	 * driver can't figure out the real state of the
+	 * divisor without dirty hacks (peek CGU register).
+	 * However, we can rely on a vendor's behavior:
+	 * if (extclk > 16MHz)
+	 *   the divisor is enabled.
+	 * This behavior relies on hardware differences:
+	 * most boards with those SoCs have 12 or 24 MHz
+	 * oscillators but many peripherals want 12Mhz
+	 * to operate properly (AIC and USB-phy at least).
+	 */
+	ingenic_early_console_setup_clock(dev);
+	if (dev->port.uartclk > 16000000)
+		dev->port.uartclk /= 2;
+
+	ingenic_earlycon_setup_tail(dev, opt);
+}
+
 OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
 		    ingenic_early_console_setup);
 
+OF_EARLYCON_DECLARE(jz4750_uart, "ingenic,jz4750-uart",
+		    jz4750_early_console_setup);
+
 OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
 		    ingenic_early_console_setup);
 
@@ -328,6 +363,7 @@ static const struct ingenic_uart_config x1000_uart_config = {
 
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
+	{ .compatible = "ingenic,jz4750-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
-- 
2.36.1

