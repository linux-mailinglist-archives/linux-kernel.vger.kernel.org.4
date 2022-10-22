Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EB7608EB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiJVQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJVQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:51:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BF9196342;
        Sat, 22 Oct 2022 09:51:01 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l14so2366084wrw.2;
        Sat, 22 Oct 2022 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9cJA/mlkjauolOlXzYfHnCzwud4m1S/AxeoQy1cW6k=;
        b=N4fQoqfCmUImIBzGw5sWs02pmODNpEDlNS1IFSZHANlCiDPOF+lUr3And/jgxvsE3A
         cq3Qh4lqH1xZixBWKfJ9BavQMBbwVlNNmG2x8Fd2VmsuopFFELZHOc0PQ0Jh+UeLmiBV
         YSRfpPJQeTc9SVJCjhVSlKmtZ33LRvxdROpTeLKfYlzvHngM3T7kQAuU2ehzkdaIVDf5
         k1Dv8CLcGaQS2oPcIl094tHGe+zdWh9a0UiWVe5Y59WWTXOQM7C7sOHCaxIJ056JdUW4
         Vp7Cq1Uih10LtvkBXs3izaZeFryFf8qVfXmFPXBq+H1DB7GQ6FlBLy/nbYLgQxA2UHPY
         QSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9cJA/mlkjauolOlXzYfHnCzwud4m1S/AxeoQy1cW6k=;
        b=a+60Bln8rPu7UPWgiXsgrZvjPSVHWY/PF7xHclwTv76QGgtN0e0BWvKzkRoAUxz56z
         ZL3N8yUBzZPQUBf1sD+NbSEHlCK0AX2IRZYpWbeZzFrVYNZbV7rFfYC47ghJdnxJfOzc
         7BIbQjcl2XvCjDv6A8psO6F7hPk4asXwCvesY2ZEJvUMtaS85b7yiR64ce8fVTUYvEXe
         +tPSMhSvEuds+f6GQarI1OW8LgGUZoA5UfzRyi4F17UQuf0+fHH1i2TexNWqA17QGGf+
         Qv52qFzzs4fQ5UEyw6DEHEM4WcDQKtCYF/hYerEtQqXGrO/SDhnkNrU/ssPpoW1ew8uw
         /wOg==
X-Gm-Message-State: ACrzQf2wKphj0g/4jzMjg2B+O4jJXSRqWOA0l0uJUYpOuLCSK7PujFle
        BZq4Pazp/7aJWl3CwE3SOXY=
X-Google-Smtp-Source: AMsMyM5tEeTAo1qq3PawaoSpMU8QQwXa5mXvMyVDQ5rYf+rLn2w8J78WgxjLs79lt2vSj3oYS8Pe+A==
X-Received: by 2002:a05:6000:10c6:b0:236:6613:a7bd with SMTP id b6-20020a05600010c600b002366613a7bdmr552874wrx.570.1666457460408;
        Sat, 22 Oct 2022 09:51:00 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-133-18-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.18.133])
        by smtp.gmail.com with ESMTPSA id h22-20020a05600c351600b003c7084d072csm3196787wmq.28.2022.10.22.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 09:50:59 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 2/2] serial: 8250/ingenic: Add support for the JZ4750/JZ4755
Date:   Sat, 22 Oct 2022 19:50:47 +0300
Message-Id: <20221022165047.4020785-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221022165047.4020785-1-lis8215@gmail.com>
References: <20221022165047.4020785-1-lis8215@gmail.com>
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
 drivers/tty/serial/8250/8250_ingenic.c | 48 ++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 2b2f5d8d2..744705467 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -87,24 +87,19 @@ static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev
 	dev->port.uartclk = be32_to_cpup(prop);
 }
 
-static int __init ingenic_early_console_setup(struct earlycon_device *dev,
+static int __init ingenic_earlycon_setup_tail(struct earlycon_device *dev,
 					      const char *opt)
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
+	return ingenic_earlycon_setup_tail(dev, opt);
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
+	return ingenic_earlycon_setup_tail(dev, opt);
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

