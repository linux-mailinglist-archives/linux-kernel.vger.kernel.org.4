Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A3E6F2FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjEAJFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 05:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjEAJFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 05:05:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CA11703
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 02:05:26 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f00d3f98deso21541342e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682931924; x=1685523924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXdZAJISVYKxbEbdwmpT3boOdl7nZiaSe7tYGc+O75A=;
        b=GUAhLCVqCZhF4ZWIK/0c6WPHUdtleQRRHmcqnKzgi0OLYiMHOysV+Ad9ZpWVgzbRIi
         LgHKw2Fql10hxJmqyWJin/W8Dk4L0oys1KF9Fmr9SVnT0k/rTX1uZAY1X18OWpySVl83
         iQQDbKcDMu/qF6sBcs7/Tm/DUjSYspFnS0SFD4qVMyb7SSnBPzL60vZ7K+Abwy4kGmgO
         c1ul50AkmmXg4e92MZ1wfYBsBmvurpDuAcFgSMnGSXCklVkBPmZR75hqskuyO133wbc4
         8Nfdml+qqGi6fMLWith90U+MxpUV6qBpipH0vOTlGD++QsF7MTkN7jJXRvukRXqQTQdO
         NR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931924; x=1685523924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXdZAJISVYKxbEbdwmpT3boOdl7nZiaSe7tYGc+O75A=;
        b=duBJG8yZAHAXYstCMrzCa2+012wu15ppFcagX3WtgRfRtvvEA7/wD+26gaCFcMAvaW
         5ethyw6+EEVQ4lTeEmRZr+8Do8okYtMKKopOXyNW2vx9aUJ91Q0zUkmv/v5KBIHKiUn8
         l650bLmWwlyi/dEgMyApm8dpKFUIpX/AffJ5de81R7/6oC8gFrP/yQ7SRAnSh4efpPCU
         5KfqAvJTU6/qXPwthhU/raOicC0yIaSZRDx/1a9Mr4WMSP7pEZD9ZLiztxhcpgAe9jgC
         G9vdDS3fY/YOIaBb/xRAubGS6PJca0IgV4Bf3vSsCDG1Pe0he/weJjTfionAVu3aDY7Y
         av6Q==
X-Gm-Message-State: AC+VfDw6XIxLrClDQ8mOWLEz4OzN4xI2qtxbxCEQMhWiVm9kU6JdeDzo
        D/cqARGchyYGT7EgOjoIKnheLiWrz3rYkhtqyEw=
X-Google-Smtp-Source: ACHHUZ6Prq6VLsV7Pb3wRSpaNQVhhgIrWt8BlU/nxpH//cmql6KUAQHWlw2XrrIZCC+nv2SWhyLhIQ==
X-Received: by 2002:a2e:9d0b:0:b0:2a8:baea:2554 with SMTP id t11-20020a2e9d0b000000b002a8baea2554mr3729962lji.3.1682931924282;
        Mon, 01 May 2023 02:05:24 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id f21-20020ac251b5000000b004eb554a1711sm4601208lfk.51.2023.05.01.02.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 02:05:23 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 01 May 2023 11:05:21 +0200
Subject: [PATCH 1/3] ARM/gpio: Push OMAP2 quirk down into TWL4030 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230430-omap2-pdata-quirks-v1-1-e015f3a3ea46@linaro.org>
References: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
In-Reply-To: <20230430-omap2-pdata-quirks-v1-0-e015f3a3ea46@linaro.org>
To:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Lee Jones <lee@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
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

The TWL4030 GPIO driver has a custom platform data .set_up()
callback to call back into the platform and do misc stuff such
as hog and export a GPIO for WLAN PWR on a specific OMAP3 board.

Avoid all the kludgery in the platform data and the boardfile
and just put the quirks right into the driver. Make it
conditional on OMAP3.

I think the exported GPIO is used by some kind of userspace
so ordinary DTS hogs will probably not work.

Fixes: 92bf78b33b0b ("gpio: omap: use dynamic allocation of base")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-omap2/omap_device.c  |  1 -
 arch/arm/mach-omap2/pdata-quirks.c | 41 +-----------------------------
 drivers/gpio/gpio-twl4030.c        | 52 ++++++++++++++++++++++++++------------
 include/linux/mfd/twl.h            |  3 ---
 4 files changed, 37 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 4afa2f08e668..fca7869c8075 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -244,7 +244,6 @@ static int _omap_device_notifier_call(struct notifier_block *nb,
 	case BUS_NOTIFY_ADD_DEVICE:
 		if (pdev->dev.of_node)
 			omap_device_build_from_dt(pdev);
-		omap_auxdata_legacy_init(dev);
 		fallthrough;
 	default:
 		od = to_omap_device(pdev);
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 04208cc52784..c363ad8d6a06 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -6,6 +6,7 @@
  */
 #include <linux/clk.h>
 #include <linux/davinci_emac.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -41,7 +42,6 @@ struct pdata_init {
 };
 
 static struct of_dev_auxdata omap_auxdata_lookup[];
-static struct twl4030_gpio_platform_data twl_gpio_auxdata;
 
 #ifdef CONFIG_MACH_NOKIA_N8X0
 static void __init omap2420_n8x0_legacy_init(void)
@@ -98,22 +98,6 @@ static struct iommu_platform_data omap3_iommu_isp_pdata = {
 };
 #endif
 
-static int omap3_sbc_t3730_twl_callback(struct device *dev,
-					   unsigned gpio,
-					   unsigned ngpio)
-{
-	int res;
-
-	res = gpio_request_one(gpio + 2, GPIOF_OUT_INIT_HIGH,
-			       "wlan pwr");
-	if (res)
-		return res;
-
-	gpiod_export(gpio_to_desc(gpio), 0);
-
-	return 0;
-}
-
 static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
 {
 	int err = gpio_request_one(gpio, GPIOF_OUT_INIT_LOW, hub_name);
@@ -131,11 +115,6 @@ static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
 	msleep(1);
 }
 
-static void __init omap3_sbc_t3730_twl_init(void)
-{
-	twl_gpio_auxdata.setup = omap3_sbc_t3730_twl_callback;
-}
-
 static void __init omap3_sbc_t3730_legacy_init(void)
 {
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
@@ -393,21 +372,6 @@ static struct ti_prm_platform_data ti_prm_pdata = {
 	.clkdm_lookup = clkdm_lookup,
 };
 
-/*
- * GPIOs for TWL are initialized by the I2C bus and need custom
- * handing until DSS has device tree bindings.
- */
-void omap_auxdata_legacy_init(struct device *dev)
-{
-	if (dev->platform_data)
-		return;
-
-	if (strcmp("twl4030-gpio", dev_name(dev)))
-		return;
-
-	dev->platform_data = &twl_gpio_auxdata;
-}
-
 #if defined(CONFIG_ARCH_OMAP3) && IS_ENABLED(CONFIG_SND_SOC_OMAP_MCBSP)
 static struct omap_mcbsp_platform_data mcbsp_pdata;
 static void __init omap3_mcbsp_init(void)
@@ -427,9 +391,6 @@ static struct pdata_init auxdata_quirks[] __initdata = {
 	{ "nokia,n800", omap2420_n8x0_legacy_init, },
 	{ "nokia,n810", omap2420_n8x0_legacy_init, },
 	{ "nokia,n810-wimax", omap2420_n8x0_legacy_init, },
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-	{ "compulab,omap3-sbc-t3730", omap3_sbc_t3730_twl_init, },
 #endif
 	{ /* sentinel */ },
 };
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index c1bb2c3ca6f2..446599ac234a 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -17,7 +17,9 @@
 #include <linux/interrupt.h>
 #include <linux/kthread.h>
 #include <linux/irq.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio/driver.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
@@ -465,8 +467,7 @@ static int gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
 				REG_GPIO_DEBEN1, 3);
 }
 
-static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev,
-				struct twl4030_gpio_platform_data *pdata)
+static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev)
 {
 	struct twl4030_gpio_platform_data *omap_twl_info;
 
@@ -474,9 +475,6 @@ static struct twl4030_gpio_platform_data *of_gpio_twl4030(struct device *dev,
 	if (!omap_twl_info)
 		return NULL;
 
-	if (pdata)
-		*omap_twl_info = *pdata;
-
 	omap_twl_info->use_leds = of_property_read_bool(dev->of_node,
 			"ti,use-leds");
 
@@ -504,9 +502,18 @@ static int gpio_twl4030_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Called from the registered devm action */
+static void gpio_twl4030_power_off_action(void *data)
+{
+	struct gpio_desc *d = data;
+
+	gpiod_unexport(d);
+	gpiochip_free_own_desc(d);
+}
+
 static int gpio_twl4030_probe(struct platform_device *pdev)
 {
-	struct twl4030_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct twl4030_gpio_platform_data *pdata;
 	struct device_node *node = pdev->dev.of_node;
 	struct gpio_twl4030_priv *priv;
 	int ret, irq_base;
@@ -546,9 +553,7 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 
 	mutex_init(&priv->mutex);
 
-	if (node)
-		pdata = of_gpio_twl4030(&pdev->dev, pdata);
-
+	pdata = of_gpio_twl4030(&pdev->dev);
 	if (pdata == NULL) {
 		dev_err(&pdev->dev, "Platform data is missing\n");
 		return -ENXIO;
@@ -585,17 +590,32 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	platform_set_drvdata(pdev, priv);
+	/*
+	 * Special quirk for the OMAP3 to hog and export a WLAN power
+	 * GPIO.
+	 */
+	if (IS_ENABLED(CONFIG_ARCH_OMAP3) &&
+	    of_machine_is_compatible("compulab,omap3-sbc-t3730")) {
+		struct gpio_desc *d;
 
-	if (pdata->setup) {
-		int status;
+		d = gpiochip_request_own_desc(&priv->gpio_chip,
+						 2, "wlan pwr",
+						 GPIO_ACTIVE_HIGH,
+						 GPIOD_OUT_HIGH);
+		if (IS_ERR(d))
+			return dev_err_probe(&pdev->dev, PTR_ERR(d),
+					     "unable to hog wlan pwr GPIO\n");
+
+		gpiod_export(d, 0);
+
+		ret = devm_add_action_or_reset(&pdev->dev, gpio_twl4030_power_off_action, d);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to install power off handler\n");
 
-		status = pdata->setup(&pdev->dev, priv->gpio_chip.base,
-				      TWL4030_GPIO_MAX);
-		if (status)
-			dev_dbg(&pdev->dev, "setup --> %d\n", status);
 	}
 
+	platform_set_drvdata(pdev, priv);
 out:
 	return ret;
 }
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index 6e3d99b7a0ee..c062d91a67d9 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -593,9 +593,6 @@ struct twl4030_gpio_platform_data {
 	 */
 	u32		pullups;
 	u32		pulldowns;
-
-	int		(*setup)(struct device *dev,
-				unsigned gpio, unsigned ngpio);
 };
 
 struct twl4030_madc_platform_data {

-- 
2.34.1

