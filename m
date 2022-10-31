Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E2613D90
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiJaSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJaSkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:40:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A107212626;
        Mon, 31 Oct 2022 11:40:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o4so17223568wrq.6;
        Mon, 31 Oct 2022 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4l/rQiBjU2EDqlLswcve2tJlyY/XQgWJ8y1LR4isvn0=;
        b=DjG/2ufk+7Y/8//JX+76+6lP62M9TveRoAHeKTQuwNmllazKZR1h4IANy23WyhsSCX
         243ph3qCkpilBizc50D21TYy8sBYgHWyDwmwNIzljrqo6AfC1L+gkYnf+3jnhlpRL+ke
         vbnBVCjvAGtGymBLSk4DP6rx19thJXyDhPPDfjajf/XLtR0NHhEYlgOsJe0MV8T9Ou45
         ilM3Z4dbReG5MMTm+3RyLrAT5WVoxSo1i6dDIT52CgM+kM0yV0I0kyaESPVkn+hE8T8p
         0w/ZCcgbzVDhmwXnHZD7z8yQWWNSObaFIVK4kqhqTipr0iAPE+hySuc63zBhEJEbGBZe
         If1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4l/rQiBjU2EDqlLswcve2tJlyY/XQgWJ8y1LR4isvn0=;
        b=nUph5eV+4/L7Pv56oKEJpVB/UMfUucG3MABFykz2HzVcy3RCdMiBPJ0uyYl7ObqJBE
         RlHZmfnS/Kq21LCqNbbRALc9bG9FHI9v09GWNN2Mmjq4m53ZF/U7Zbrn7OknSChBqGSu
         i0ZDoblQu2mO0/VEYIOqWz0giZPF3e0BAJUGpXrvQZKLZww2UK60+oBwYzpzgt6pBSDO
         z74n8mUTkZ/RgXONLFrAbIyuM2YfdVrURUiCrfwiTCxx57JAPQpvbNxoV47OBaWNv0dx
         jrm6OyMlhVW/bnMWIHXlASa82sG1u66BZWViqe/hiQ0PXfU/qjlyobElqp1msMPsx4EM
         pWzA==
X-Gm-Message-State: ACrzQf2Zc30bdav0IUXkKjBrGjIwmVf3Wt7SgumDbTk3fciQgoBGAfD6
        g3YWeqovGp8COV11QyID9Sk=
X-Google-Smtp-Source: AMsMyM5npn0gP5TdeeyQ46cg9Bn7gzkoKCuKASGnw5gB32sz/rFPxQXnD+wbE8y1BuSZdV/ui3EXJw==
X-Received: by 2002:a05:6000:a09:b0:236:6b18:6b30 with SMTP id co9-20020a0560000a0900b002366b186b30mr9565291wrb.356.1667241649233;
        Mon, 31 Oct 2022 11:40:49 -0700 (PDT)
Received: from hp-power-15.localdomain (mm-167-8-212-37.vitebsk.dynamic.pppoe.byfly.by. [37.212.8.167])
        by smtp.gmail.com with ESMTPSA id k18-20020a05600c081200b003b4935f04a4sm8525887wmp.5.2022.10.31.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:40:48 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
Cc:     Siarhei Volkau <lis8215@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v4 2/2] serial: 8250/ingenic: Add support for the JZ4750/JZ4755
Date:   Mon, 31 Oct 2022 21:40:40 +0300
Message-Id: <20221031184041.1338129-3-lis8215@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221031184041.1338129-1-lis8215@gmail.com>
References: <20221031184041.1338129-1-lis8215@gmail.com>
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

JZ4750/55/60 (but not JZ4760b) have an optional /2 divider between the
EXT oscillator and some peripherals including UART, which will
be enabled if using a 24 MHz oscillator, and disabled when
using a 12 MHz oscillator.

This behavior relies on hardware differences: most boards (if not all)
with those SoCs have 12 or 24 MHz oscillators but many peripherals want
12Mhz to operate properly (AIC and USB-PHY at least).

The 16MHz threshold looks arbitrary but used in vendor's bootloader code
for enable the divider.

The patch doesn't affect JZ4760's behavior as it is subject for another
patchset with re-classification of all supported ingenic UARTs.

Link: https://github.com/carlos-wong/uboot_jz4755/blob/master/cpu/mips/jz_serial.c#L158
Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 drivers/tty/serial/8250/8250_ingenic.c | 32 +++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 2b2f5d8d2..617b8ce60 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -87,7 +87,7 @@ static void __init ingenic_early_console_setup_clock(struct earlycon_device *dev
 	dev->port.uartclk = be32_to_cpup(prop);
 }
 
-static int __init ingenic_early_console_setup(struct earlycon_device *dev,
+static int __init ingenic_earlycon_setup_tail(struct earlycon_device *dev,
 					      const char *opt)
 {
 	struct uart_port *port = &dev->port;
@@ -103,8 +103,6 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 		uart_parse_options(opt, &baud, &parity, &bits, &flow);
 	}
 
-	ingenic_early_console_setup_clock(dev);
-
 	if (dev->baud)
 		baud = dev->baud;
 	divisor = DIV_ROUND_CLOSEST(port->uartclk, 16 * baud);
@@ -129,9 +127,36 @@ static int __init ingenic_early_console_setup(struct earlycon_device *dev,
 	return 0;
 }
 
+static int __init ingenic_early_console_setup(struct earlycon_device *dev,
+					      const char *opt)
+{
+	ingenic_early_console_setup_clock(dev);
+
+	return ingenic_earlycon_setup_tail(dev, opt);
+}
+
+static int __init jz4750_early_console_setup(struct earlycon_device *dev,
+					     const char *opt)
+{
+	/*
+	 * JZ4750/55/60 have an optional /2 divider between the EXT
+	 * oscillator and some peripherals including UART, which will
+	 * be enabled if using a 24 MHz oscillator, and disabled when
+	 * using a 12 MHz oscillator.
+	 */
+	ingenic_early_console_setup_clock(dev);
+	if (dev->port.uartclk >= 16000000)
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
 
@@ -328,6 +353,7 @@ static const struct ingenic_uart_config x1000_uart_config = {
 
 static const struct of_device_id of_match[] = {
 	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
+	{ .compatible = "ingenic,jz4750-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
 	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
-- 
2.36.1

