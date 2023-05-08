Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1A6FB971
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjEHVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjEHVUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:20:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365515590
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:20:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f14f266b72so3396958e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683580820; x=1686172820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dK03E2M8l7bVCBNTqzVE5mVLTLIW5dP3PvhMkmEu44I=;
        b=LQvB+8ogRPv04y19WvA4bz7w/wJIcDWbnDtyZLlF61s4C3dXWsHviBgL1vZ0d8vTnQ
         iJTyC75PunKIctxUTawEGv6+kVpOsf5er8fGH700MPbKWcLhpODaZ93OyuL4lcRn7UZe
         yFKv2dnS3Me3T7gE5qoha4EG0IAvrgRQ9NHBCByMHoGLDdWoPoDX6JSnXPboi6ILpT+0
         zYkoVFwxzISejMGf9FEwFuPsuQ6x78BajEOx208y++QUiNA9PcQLlLuAXQfUtaL4lXx7
         LMigrZvibVzhQ+H5SUeQz9tseL99XDg0kfbiiE+hP7ldQeTKnG8o+3ev89OcHyzlVZj2
         8RFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683580820; x=1686172820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dK03E2M8l7bVCBNTqzVE5mVLTLIW5dP3PvhMkmEu44I=;
        b=Yz9y9gdaGgj1Gjl/lcIeFjC3fZaVMpmRAoDIahkrJNNDVJPk7NxGBrRDYPqcHb9cOw
         JbFr5mC5OJYq6gYDZT+qTPsvGbzc44UORtHpI8ZoSTiSps83Aimz5GtCjSPXHH/Ba919
         trsBZxUGgaNppaUVp9xjQ6ZTpWUO/LNvadVfAvcOjCbdW5HG1rlkyCkOHUdJ3xqBuORt
         8lIAppj0T7agZgLMSYJ4jtk6aNQ9Kh1m2VMi9cJkvQENqyaEHoOIjN59DpgYxjMhDZc3
         96lRYQhqG5292RF60XCCztPA+bmaaZdV92X1OqAJR9kr18YPznMgD5jLXg8Cpt0gAmF3
         vXlg==
X-Gm-Message-State: AC+VfDxeE38ZT5xNx0KA2mQo8EnZ3vg+j41hqDZ3gwVa0HCMOv2xYDrk
        DpWoQxjsT/oqirC/Q20sTj96nw==
X-Google-Smtp-Source: ACHHUZ5h9zB+DF+SzOXMLkK9IEaMkoFaP5oV3ZE8LadUTKk9C4V94+SoqeKCIiPG3/AYEn/7ujSn7w==
X-Received: by 2002:a19:550d:0:b0:4ef:d742:4dfe with SMTP id n13-20020a19550d000000b004efd7424dfemr124116lfe.65.1683580820134;
        Mon, 08 May 2023 14:20:20 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4-20020ac24844000000b004edc3bd7fa1sm102164lfy.201.2023.05.08.14.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:20:19 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 08 May 2023 23:20:08 +0200
Subject: [PATCH v4 3/4] ARM: omap1: Fix up the Nokia 770 board device IRQs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-nokia770-regression-v4-3-9b6dc5536b17@linaro.org>
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
In-Reply-To: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform devices on the Nokia 770 is using some
board-specific IRQs that get statically assigned to platform
devices in the boardfile.

This does not work with dynamic IRQ chip bases.

Utilize the NULL device to define some board-specific
GPIO lookups and use these to immediately look up the
same GPIOs, convert to IRQ numbers and pass as resources
to the devices. This is ugly but should work.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap1/board-nokia770.c | 57 ++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 218c928f71b3..8965df2c250d 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -6,7 +6,7 @@
  */
 #include <linux/clkdev.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <linux/kernel.h>
@@ -250,19 +250,25 @@ static struct i2c_board_info nokia770_i2c_board_info_2[] __initdata = {
 
 static void __init nokia770_cbus_init(void)
 {
-	const int retu_irq_gpio = 62;
-	const int tahvo_irq_gpio = 40;
-
-	if (gpio_request_one(retu_irq_gpio, GPIOF_IN, "Retu IRQ"))
-		return;
-	if (gpio_request_one(tahvo_irq_gpio, GPIOF_IN, "Tahvo IRQ")) {
-		gpio_free(retu_irq_gpio);
-		return;
+	struct gpio_desc *d;
+	int irq;
+
+	d = gpiod_get(NULL, "retu_irq", GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get CBUS Retu IRQ GPIO descriptor\n");
+	} else {
+		irq = gpiod_to_irq(d);
+		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+		nokia770_i2c_board_info_2[0].irq = irq;
+	}
+	d = gpiod_get(NULL, "tahvo_irq", GPIOD_IN);
+	if (IS_ERR(d)) {
+		pr_err("Unable to get CBUS Tahvo IRQ GPIO descriptor\n");
+	} else {
+		irq = gpiod_to_irq(d);
+		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
+		nokia770_i2c_board_info_2[1].irq = irq;
 	}
-	irq_set_irq_type(gpio_to_irq(retu_irq_gpio), IRQ_TYPE_EDGE_RISING);
-	irq_set_irq_type(gpio_to_irq(tahvo_irq_gpio), IRQ_TYPE_EDGE_RISING);
-	nokia770_i2c_board_info_2[0].irq = gpio_to_irq(retu_irq_gpio);
-	nokia770_i2c_board_info_2[1].irq = gpio_to_irq(tahvo_irq_gpio);
 	i2c_register_board_info(2, nokia770_i2c_board_info_2,
 				ARRAY_SIZE(nokia770_i2c_board_info_2));
 	device_create_managed_software_node(&nokia770_cbus_device.dev,
@@ -275,8 +281,25 @@ static void __init nokia770_cbus_init(void)
 }
 #endif /* CONFIG_I2C_CBUS_GPIO */
 
+static struct gpiod_lookup_table nokia770_irq_gpio_table = {
+	.dev_id = NULL,
+	.table = {
+		/* GPIO used by SPI device 1 */
+		GPIO_LOOKUP("gpio-0-15", 15, "ads7846_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used for retu IRQ */
+		GPIO_LOOKUP("gpio-48-63", 15, "retu_irq",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIO used for tahvo IRQ */
+		GPIO_LOOKUP("gpio-32-47", 8, "tahvo_irq",
+			    GPIO_ACTIVE_HIGH),
+	},
+};
+
 static void __init omap_nokia770_init(void)
 {
+	struct gpio_desc *d;
+
 	/* On Nokia 770, the SleepX signal is masked with an
 	 * MPUIO line by default.  It has to be unmasked for it
 	 * to become functional */
@@ -288,6 +311,14 @@ static void __init omap_nokia770_init(void)
 
 	software_node_register_node_group(nokia770_gpiochip_nodes);
 	platform_add_devices(nokia770_devices, ARRAY_SIZE(nokia770_devices));
+
+	gpiod_add_lookup_table(&nokia770_irq_gpio_table);
+	d = gpiod_get(NULL, "ads7846_irq", GPIOD_IN);
+	if (IS_ERR(d))
+		pr_err("Unable to get ADS7846 IRQ GPIO descriptor\n");
+	else
+		nokia770_spi_board_info[1].irq = gpiod_to_irq(d);
+
 	spi_register_board_info(nokia770_spi_board_info,
 				ARRAY_SIZE(nokia770_spi_board_info));
 	omap_serial_init();

-- 
2.34.1

