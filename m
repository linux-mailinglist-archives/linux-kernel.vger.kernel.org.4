Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3829E5EBA50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiI0GDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiI0GDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:03:30 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA04A8CF9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:03:29 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w13so8205107plp.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 23:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=EZfUYjl19VxlZwwP8BFN0PP04wVkOC+g8beRq8IH3Gc=;
        b=JC5eHvO6tWblV52dA/M0NB2aSEKkmUvLAwWciP0f4K92WUEzswH7b+/q3YIR/SQPXG
         bROcP2QlUhoMziqbGL/AHNTGxDBPqukHwCXErbKu7lcjFzRrTyB5+gKfrSknjuW5IPBl
         Yz79gQSY0HtoDvwzOa3pjJF1T1d3jQ2cNyEGJPvqVb4eJeAjNlr/27gn1W35tKAgdm3e
         hFZ6bImcNcNA1EAECj2UJWtyr5gYvQm4ohLrMX0l16/mHG6J/cZhdNUwXgO2QHgV1RkX
         0jbA7tx0Golu+NQZqLLqvSvsJBo6gYvNEQ8Z2G/ROfMHjyKBxKqHLTg6mcGUTI/iJXGd
         Z+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EZfUYjl19VxlZwwP8BFN0PP04wVkOC+g8beRq8IH3Gc=;
        b=TkMU6TgNpRmQQoIp5I25xEDlfTpQwrIxEJZNGzS5WxdrE5H2S9OlWFOQbYdUNUO3e1
         fKNhk+S+LJ0OwdxwgccndFg1J3Z7oQMLu5mIAWxvFtEI15IvJPJCigagoodm21lEJEhW
         oMLAbG1Tw0oma6Kj1FS6C1BA20DNzLZVQYIl9Ghq1/+8mq+gi20lZs+LCFSP0W9IjC2i
         m2aWWDsNnM68dkJeMVDVRz2kPw48ikjP8igLec1kmcwFvy8vE4049mYysdJnBmlPsBQ3
         qemBRSBcU/66Y0xG6PG1hVDva/eNQ/0ZRFzjvr67Aw9OuL4fEbQzXRgydzSXF1ER3vSF
         +5oQ==
X-Gm-Message-State: ACrzQf1CllGuCfB/46zlJF94FqABhOsJR4/42au7eMRSDGDUuOGeGs3F
        Red9ru/ez3az7CcLytAcHF8=
X-Google-Smtp-Source: AMsMyM4ow6d23E/pG/93PCNL+psNp3TdPIpDhg5CKywxpSjxkrddmwErM51D8Z06AUFUSYmpCCcb8A==
X-Received: by 2002:a17:90a:e60d:b0:201:6b28:5406 with SMTP id j13-20020a17090ae60d00b002016b285406mr2670118pjy.228.1664258608633;
        Mon, 26 Sep 2022 23:03:28 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b00172f4835f60sm517888pla.189.2022.09.26.23.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 23:03:28 -0700 (PDT)
Date:   Mon, 26 Sep 2022 23:03:25 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/warp: switch to using gpiod API
Message-ID: <YzKSLcrYmV5kjyeX@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches PIKA Warp away from legacy gpio API and to newer gpiod
API, so that we can eventually deprecate the former.

Because LEDs are normally driven by leds-gpio driver, but the
platform code also wants to access the LEDs during thermal shutdown,
and gpiod API does not allow locating GPIO without requesting it,
the platform code is now responsible for locating GPIOs through device
tree and requesting them. It then constructs platform data for
leds-gpio platform device and registers it. This allows platform
code to retain access to LED GPIO descriptors and use them when needed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Compiled only, no hardware to test this.

 arch/powerpc/boot/dts/warp.dts    |   4 +-
 arch/powerpc/platforms/44x/warp.c | 105 ++++++++++++++++++++++++++----
 2 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index b4f32740870e..aa62d08e97c2 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -258,14 +258,12 @@ GPIO1: gpio@ef600c00 {
 			};
 
 			power-leds {
-				compatible = "gpio-leds";
+				compatible = "warp-power-leds";
 				green {
 					gpios = <&GPIO1 0 0>;
-					default-state = "keep";
 				};
 				red {
 					gpios = <&GPIO1 1 0>;
-					default-state = "keep";
 				};
 			};
 
diff --git a/arch/powerpc/platforms/44x/warp.c b/arch/powerpc/platforms/44x/warp.c
index f03432ef010b..cefa313c09f0 100644
--- a/arch/powerpc/platforms/44x/warp.c
+++ b/arch/powerpc/platforms/44x/warp.c
@@ -5,15 +5,17 @@
  * Copyright (c) 2008-2009 PIKA Technologies
  *   Sean MacLennan <smaclennan@pikatech.com>
  */
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/kthread.h>
+#include <linux/leds.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/export.h>
 
@@ -92,8 +94,6 @@ static int __init warp_post_info(void)
 
 static LIST_HEAD(dtm_shutdown_list);
 static void __iomem *dtm_fpga;
-static unsigned green_led, red_led;
-
 
 struct dtm_shutdown {
 	struct list_head list;
@@ -101,7 +101,6 @@ struct dtm_shutdown {
 	void *arg;
 };
 
-
 int pika_dtm_register_shutdown(void (*func)(void *arg), void *arg)
 {
 	struct dtm_shutdown *shutdown;
@@ -132,6 +131,35 @@ int pika_dtm_unregister_shutdown(void (*func)(void *arg), void *arg)
 	return -EINVAL;
 }
 
+#define WARP_GREEN_LED	0
+#define WARP_RED_LED	1
+
+static struct gpio_led warp_gpio_led_pins[] = {
+	[WARP_GREEN_LED] = {
+		.name		= "green",
+		.default_state	= LEDS_DEFSTATE_KEEP,
+		.gpiod		= NULL, /* to be filled by pika_setup_leds() */
+	},
+	[WARP_RED_LED] = {
+		.name		= "red",
+		.default_state	= LEDS_DEFSTATE_KEEP,
+		.gpiod		= NULL, /* to be filled by pika_setup_leds() */
+	},
+};
+
+static struct gpio_led_platform_data warp_gpio_led_data = {
+	.leds		= warp_gpio_led_pins,
+	.num_leds	= ARRAY_SIZE(warp_gpio_led_pins),
+};
+
+static struct platform_device warp_gpio_leds = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &warp_gpio_led_data,
+	},
+};
+
 static irqreturn_t temp_isr(int irq, void *context)
 {
 	struct dtm_shutdown *shutdown;
@@ -139,7 +167,7 @@ static irqreturn_t temp_isr(int irq, void *context)
 
 	local_irq_disable();
 
-	gpio_set_value(green_led, 0);
+	gpiod_set_value(warp_gpio_led_pins[WARP_GREEN_LED].gpiod, 0);
 
 	/* Run through the shutdown list. */
 	list_for_each_entry(shutdown, &dtm_shutdown_list, list)
@@ -153,7 +181,7 @@ static irqreturn_t temp_isr(int irq, void *context)
 			out_be32(dtm_fpga + 0x14, reset);
 		}
 
-		gpio_set_value(red_led, value);
+		gpiod_set_value(warp_gpio_led_pins[WARP_RED_LED].gpiod, value);
 		value ^= 1;
 		mdelay(500);
 	}
@@ -162,25 +190,78 @@ static irqreturn_t temp_isr(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Because green and red power LEDs are normally driven by leds-gpio driver,
+ * but in case of critical temperature shutdown we want to drive them
+ * ourselves, we acquire both and then create leds-gpio platform device
+ * ourselves, instead of doing it through device tree. This way we can still
+ * keep access to the gpios and use them when needed.
+ */
 static int pika_setup_leds(void)
 {
 	struct device_node *np, *child;
+	struct gpio_desc *gpio;
+	struct gpio_led *led;
+	int led_count = 0;
+	int error;
+	int i;
 
-	np = of_find_compatible_node(NULL, NULL, "gpio-leds");
+	np = of_find_compatible_node(NULL, NULL, "warp-power-leds");
 	if (!np) {
 		printk(KERN_ERR __FILE__ ": Unable to find leds\n");
 		return -ENOENT;
 	}
 
-	for_each_child_of_node(np, child)
-		if (of_node_name_eq(child, "green"))
-			green_led = of_get_gpio(child, 0);
-		else if (of_node_name_eq(child, "red"))
-			red_led = of_get_gpio(child, 0);
+	for_each_child_of_node(np, child) {
+		for (i = 0; i < ARRAY_SIZE(warp_gpio_led_pins); i++) {
+			led = &warp_gpio_led_pins[i];
+
+			if (!of_node_name_eq(child, led->name))
+				continue;
+
+			if (led->gpiod) {
+				printk(KERN_ERR __FILE__ ": %s led has already been defined\n",
+				       led->name);
+				continue;
+			}
+
+			gpio = fwnode_gpiod_get_index(of_fwnode_handle(child),
+						      NULL, 0, GPIOD_ASIS,
+						      led->name);
+			error = PTR_ERR_OR_ZERO(gpio);
+			if (error) {
+				printk(KERN_ERR __FILE__ ": Failed to get %s led gpio: %d\n",
+				       led->name, error);
+				of_node_put(child);
+				goto err_cleanup_pins;
+			}
+
+			led->gpiod = gpio;
+			led_count++;
+		}
+	}
 
 	of_node_put(np);
 
+	/* Skip device registration if no leds have been defined */
+	if (led_count) {
+		error = platform_device_register(&warp_gpio_leds);
+		if (error) {
+			printk(KERN_ERR __FILE__ ": Unable to add leds-gpio: %d\n",
+			       error);
+			goto err_cleanup_pins;
+		}
+	}
+
 	return 0;
+
+err_cleanup_pins:
+	for (i = 0; i < ARRAY_SIZE(warp_gpio_led_pins); i++) {
+		led = &warp_gpio_led_pins[i];
+		gpiod_put(led->gpiod);
+		led->gpiod = NULL;
+	}
+	return error;
 }
 
 static void pika_setup_critical_temp(struct device_node *np,
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
