Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77A2620759
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiKHDRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiKHDRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:17:07 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1755915A16;
        Mon,  7 Nov 2022 19:16:54 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id io19so12997336plb.8;
        Mon, 07 Nov 2022 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCHZRMv72CNijBXvJ4zsMsCF3iCoVBcytqRG84UrlOQ=;
        b=jHA7NR14yIWY0FrfzNLcfo0aGMJZM+nYXsUyaR/pqN+N3jQUqEUc3H1tTcXsHZnu8q
         xo3mWVgWBJtvfV9xtLHBDoxI+3gEOHv7eyErepFvpYAIggxWrOksR9vqRY3elvAqX5sp
         f8FPLqTwidtLT2dX6z6xmnYD11H4aFh1CS8K8g+Z1jv6Al4sN1yq3CLjtEqNUZUMITpL
         NKwXFRnCoahkCCehIK4HqHWS5poeRq91QJGDYQA67hP7Y6qK0645BGLik0vBpGd59XQ4
         1ivg6oyRW8qDZuwnLnartRSCcEo2ME7Ffiaj+8YqlFo4Sx+DPlkra43VYc7apP7UBwaN
         0RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCHZRMv72CNijBXvJ4zsMsCF3iCoVBcytqRG84UrlOQ=;
        b=MRDhAi3xWycCZ4b/8ExhYpEMbubencidQ2e3r8sq+2jGPgymsKZF41fEC+SR02Gt/6
         0YXXnJXb3Q9npxa5iOc7XIv4ndXOTXf+X4JMr2igeN8laRy1EfY3cSRCcEeLWT/MnTy5
         gT3+6McAfqyMOJAtI7e4O49Go3BE8eh3rs2gklqBQNG1/QWbsR+6BWrS6Dk0gJvG0RL0
         BzcPWpdkQjz27t4Wg2dQl1dUarKJhDw3qkFVbK8/bFlK+1CU2gTNXlihmojZsvcft6UQ
         lAbBkktRg9rTpG2whnjQxYBYCBGgkef7G9r/31V5oybuPOYaSUbcBvOrMTg7+s/xHBNH
         fcKQ==
X-Gm-Message-State: ACrzQf2Ka1JfC9Jhx+uYOhWZzMusWt4K2MCusx5hNv/0ZcwY/WFdAJjL
        OpkUh42pWTVc+Z+uMk1T2bM=
X-Google-Smtp-Source: AMsMyM4HZWrFNC5Yhnaiyipp2Q2b1huY1xTKqLQh9FET5IqRe4Q5oETkwZxvGqQAyIDdGHTisFvU5Q==
X-Received: by 2002:a17:903:2289:b0:187:21f6:fdea with SMTP id b9-20020a170903228900b0018721f6fdeamr45261729plh.120.1667877413340;
        Mon, 07 Nov 2022 19:16:53 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb10:b5b0:232e:4afb])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902690700b00186e2b3e12fsm5632842plk.261.2022.11.07.19.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:16:52 -0800 (PST)
Date:   Mon, 7 Nov 2022 19:16:49 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH] soc: fsl: qe: request pins non-exclusively
Message-ID: <Y2nKIbKxHAMimxII@google.com>
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

Commit 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()") changed
qe_pin_request() to request and hold GPIO corresponding to a given pin.
Unfortunately this does not work, as fhci-hcd requests these GPIOs
first, befor calling qe_pin_request() (see
drivers/usb/host/fhci-hcd.c::of_fhci_probe()).
To fix it change qe_pin_request() to request GPIOs non-exclusively, and
free them once the code determines GPIO controller and offset for each
GPIO/pin.

Also reaching deep into gpiolib implementation is not the best idea. We
should either export gpio_chip_hwgpio() or keep converting to the global
gpio numbers space until we fix the driver to implement proper pin
control.

Fixes: 84582f9ed090 ("soc: fsl: qe: Avoid using gpio_to_desc()")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Compiled only, not tested on hardware.

 drivers/soc/fsl/qe/gpio.c   | 71 ++++++++++++++++++-------------------
 drivers/usb/host/fhci-hcd.c |  2 +-
 include/soc/fsl/qe/qe.h     |  5 +--
 3 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/drivers/soc/fsl/qe/gpio.c b/drivers/soc/fsl/qe/gpio.c
index 0ee887f89deb..5bb71a2b5b7a 100644
--- a/drivers/soc/fsl/qe/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -13,7 +13,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/of_gpio.h>	/* for of_mm_gpio_chip */
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
@@ -21,13 +21,6 @@
 #include <linux/property.h>
 
 #include <soc/fsl/qe/qe.h>
-/*
- * FIXME: this is legacy code that is accessing gpiolib internals in order
- * to implement a custom pin controller. The proper solution is to create
- * a real combined pin control and GPIO driver in drivers/pinctrl. However
- * this hack is here for legacy code reasons.
- */
-#include "../../../gpio/gpiolib.h"
 
 struct qe_gpio_chip {
 	struct of_mm_gpio_chip mm_gc;
@@ -149,20 +142,19 @@ struct qe_pin {
 	 * something like qe_pio_controller. Someday.
 	 */
 	struct qe_gpio_chip *controller;
-	struct gpio_desc *gpiod;
 	int num;
 };
 
 /**
  * qe_pin_request - Request a QE pin
- * @np:		device node to get a pin from
- * @index:	index of a pin in the device tree
+ * @dev:	device to get the pin from
+ * @index:	index of the pin in the device tree
  * Context:	non-atomic
  *
  * This function return qe_pin so that you could use it with the rest of
  * the QE Pin Multiplexing API.
  */
-struct qe_pin *qe_pin_request(struct device_node *np, int index)
+struct qe_pin *qe_pin_request(struct device *dev, int index)
 {
 	struct qe_pin *qe_pin;
 	struct gpio_chip *gc;
@@ -171,40 +163,46 @@ struct qe_pin *qe_pin_request(struct device_node *np, int index)
 
 	qe_pin = kzalloc(sizeof(*qe_pin), GFP_KERNEL);
 	if (!qe_pin) {
-		pr_debug("%s: can't allocate memory\n", __func__);
+		dev_dbg(dev, "%s: can't allocate memory\n", __func__);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	gpiod = fwnode_gpiod_get_index(of_fwnode_handle(np), NULL, index, GPIOD_ASIS, "qe");
-	if (IS_ERR(gpiod)) {
-		err = PTR_ERR(gpiod);
-		goto err0;
-	}
-	if (!gpiod) {
-		err = -EINVAL;
+	/*
+	 * Request gpio as nonexclusive as it was likely was reserved by
+	 * the caller, and we are not planning on controlling it, we only
+	 * need the descriptor to the to the gpio chip structure.
+	 */
+	gpiod = gpiod_get_index(dev, NULL, index,
+			        GPIOD_ASIS | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	err = PTR_ERR_OR_ZERO(gpiod);
+	if (err)
 		goto err0;
-	}
+
 	gc = gpiod_to_chip(gpiod);
 	if (WARN_ON(!gc)) {
 		err = -ENODEV;
 		goto err0;
-	}
-	qe_pin->gpiod = gpiod;
-	qe_pin->controller = gpiochip_get_data(gc);
-	/*
-	 * FIXME: this gets the local offset on the gpio_chip so that the driver
-	 * can manipulate pin control settings through its custom API. The real
-	 * solution is to create a real pin control driver for this.
-	 */
-	qe_pin->num = gpio_chip_hwgpio(gpiod);
-
-	if (!fwnode_device_is_compatible(gc->fwnode, "fsl,mpc8323-qe-pario-bank")) {
-		pr_debug("%s: tried to get a non-qe pin\n", __func__);
-		gpiod_put(gpiod);
+	} else if (!fwnode_device_is_compatible(gc->fwnode,
+						"fsl,mpc8323-qe-pario-bank")) {
+		dev_dbg(dev, "%s: tried to get a non-qe pin\n", __func__);
 		err = -EINVAL;
-		goto err0;
+	} else {
+		qe_pin->controller = gpiochip_get_data(gc);
+		/*
+		 * FIXME: this gets the local offset on the gpio_chip so that
+		 * the driver can manipulate pin control settings through its
+		 * custom API. The real solution is to create a real pin control
+		 * driver for this.
+		 */
+		qe_pin->num = desc_to_gpio(gpiod) - gc->base;
 	}
-	return qe_pin;
+
+	/* We no longer need this descriptor */
+	gpiod_put(gpiod);
+
+	if (!err)
+		return qe_pin;
+
 err0:
 	kfree(qe_pin);
 	pr_debug("%s failed with status %d\n", __func__, err);
@@ -222,7 +220,6 @@ EXPORT_SYMBOL(qe_pin_request);
  */
 void qe_pin_free(struct qe_pin *qe_pin)
 {
-	gpiod_put(qe_pin->gpiod);
 	kfree(qe_pin);
 }
 EXPORT_SYMBOL(qe_pin_free);
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 95a44462bed0..1f666804fa91 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -651,7 +651,7 @@ static int of_fhci_probe(struct platform_device *ofdev)
 	}
 
 	for (j = 0; j < NUM_PINS; j++) {
-		fhci->pins[j] = qe_pin_request(node, j);
+		fhci->pins[j] = qe_pin_request(dev, j);
 		if (IS_ERR(fhci->pins[j])) {
 			ret = PTR_ERR(fhci->pins[j]);
 			dev_err(dev, "can't get pin %d: %d\n", j, ret);
diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index b02e9fe69146..eb5079904cc8 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -172,14 +172,15 @@ static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
 /*
  * Pin multiplexing functions.
  */
+struct device;
 struct qe_pin;
 #ifdef CONFIG_QE_GPIO
-extern struct qe_pin *qe_pin_request(struct device_node *np, int index);
+extern struct qe_pin *qe_pin_request(struct device *dev, int index);
 extern void qe_pin_free(struct qe_pin *qe_pin);
 extern void qe_pin_set_gpio(struct qe_pin *qe_pin);
 extern void qe_pin_set_dedicated(struct qe_pin *pin);
 #else
-static inline struct qe_pin *qe_pin_request(struct device_node *np, int index)
+static inline struct qe_pin *qe_pin_request(struct device *dev, int index)
 {
 	return ERR_PTR(-ENOSYS);
 }
-- 
2.38.1.431.g37b22c650d-goog


-- 
Dmitry
