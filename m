Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF18719298
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 07:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjFAFrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 01:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFAFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 01:46:45 -0400
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [178.154.239.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09392197;
        Wed, 31 May 2023 22:46:20 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:5e51:0:640:23ee:0])
        by forward102a.mail.yandex.net (Yandex) with ESMTP id 3BEA346C8B;
        Thu,  1 Jun 2023 08:46:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id pjGDMhnDduQ0-83pJjdCs;
        Thu, 01 Jun 2023 08:46:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1685598376;
        bh=DE0PuhGLjmts/t1BvDTS/OGhf3InURtuByTCtC1VZZk=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=fqC30tuy+udEfYHlfq6RiYhu8CameR2zMYXEoQEdcTtfZ9fnEz+VO3k76/oBjJsG1
         PDu44vzD4Be7sHvTdOEgQqudvgNcvlfywfzfd8alcyORE4c+hFf1IRdTBZONmQrsiU
         F4+lil+QNt1g8JC3pOsd7T20nP8lrxFXy6PApp+c=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for Cirrus EP93xx
Date:   Thu,  1 Jun 2023 08:45:33 +0300
Message-Id: <20230601054549.10843-10-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- get keymap from the device tree
- find register range from the device tree
- get interrupts from device tree

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---

Notes:
    v0 -> v1:
    
    - fixed header
    - dropped coma in id table
    - take debounce, prescale from dt
    - remove ep93xx_keypad_platform_data
    - move flags to module params
    - drop setting clock rate, it's useless, as was never used,
      it seems we are okay with default clk rate used
    - move usefull defines from platform file here
    - drop platform header

 drivers/input/keyboard/ep93xx_keypad.c | 78 +++++++++++++-------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 55075addcac2..8b0e73f56216 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -20,6 +20,7 @@
 #include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -27,7 +28,6 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/slab.h>
 #include <linux/soc/cirrus/ep93xx.h>
-#include <linux/platform_data/keypad-ep93xx.h>
 #include <linux/pm_wakeirq.h>
 
 /*
@@ -61,12 +61,18 @@
 #define KEY_REG_KEY1_MASK	GENMASK(5, 0)
 #define KEY_REG_KEY1_SHIFT	0
 
+#define EP93XX_MATRIX_ROWS		(8)
+#define EP93XX_MATRIX_COLS		(8)
+
 #define EP93XX_MATRIX_SIZE	(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
 
 struct ep93xx_keypad {
-	struct ep93xx_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	struct clk *clk;
+	unsigned int	debounce;
+	unsigned int	prescale;
+	unsigned int	flags;
+	unsigned int	clk_rate;
 
 	void __iomem *mmio_base;
 
@@ -80,6 +86,17 @@ struct ep93xx_keypad {
 	bool enabled;
 };
 
+/* flags for the ep93xx_keypad driver */
+#define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
+#define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
+#define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
+#define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
+#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */
+
+static int ep93xx_keypad_flags;
+module_param(ep93xx_keypad_flags, int, 0);
+MODULE_PARM_DESC(ep93xx_keypad_flags, "EP93XX keypad flags.");
+
 static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 {
 	struct ep93xx_keypad *keypad = dev_id;
@@ -133,23 +150,20 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
 
 static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
 {
-	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
 	unsigned int val = 0;
 
-	clk_set_rate(keypad->clk, pdata->clk_rate);
-
-	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
+	if (keypad->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
 		val |= KEY_INIT_DIS3KY;
-	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
+	if (keypad->flags & EP93XX_KEYPAD_DIAG_MODE)
 		val |= KEY_INIT_DIAG;
-	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
+	if (keypad->flags & EP93XX_KEYPAD_BACK_DRIVE)
 		val |= KEY_INIT_BACK;
-	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
+	if (keypad->flags & EP93XX_KEYPAD_TEST_MODE)
 		val |= KEY_INIT_T2;
 
-	val |= ((pdata->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
+	val |= ((keypad->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
 
-	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
+	val |= ((keypad->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
 
 	__raw_writel(val, keypad->mmio_base + KEY_INIT);
 }
@@ -220,17 +234,10 @@ static int ep93xx_keypad_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
 				ep93xx_keypad_suspend, ep93xx_keypad_resume);
 
-static void ep93xx_keypad_release_gpio_action(void *_pdev)
-{
-	struct platform_device *pdev = _pdev;
-
-	ep93xx_keypad_release_gpio(pdev);
-}
-
 static int ep93xx_keypad_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct ep93xx_keypad *keypad;
-	const struct matrix_keymap_data *keymap_data;
 	struct input_dev *input_dev;
 	int err;
 
@@ -238,14 +245,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (!keypad)
 		return -ENOMEM;
 
-	keypad->pdata = dev_get_platdata(&pdev->dev);
-	if (!keypad->pdata)
-		return -EINVAL;
-
-	keymap_data = keypad->pdata->keymap_data;
-	if (!keymap_data)
-		return -EINVAL;
-
 	keypad->irq = platform_get_irq(pdev, 0);
 	if (keypad->irq < 0)
 		return keypad->irq;
@@ -254,19 +253,15 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-	err = ep93xx_keypad_acquire_gpio(pdev);
-	if (err)
-		return err;
-
-	err = devm_add_action_or_reset(&pdev->dev,
-				       ep93xx_keypad_release_gpio_action, pdev);
-	if (err)
-		return err;
-
 	keypad->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(keypad->clk))
 		return PTR_ERR(keypad->clk);
 
+	keypad->flags = ep93xx_keypad_flags;
+
+	of_property_read_u32(np, "cirrus,debounce-delay-ms", &keypad->debounce);
+	of_property_read_u32(np, "cirrus,prescale", &keypad->prescale);
+
 	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -278,13 +273,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	input_dev->open = ep93xx_keypad_open;
 	input_dev->close = ep93xx_keypad_close;
 
-	err = matrix_keypad_build_keymap(keymap_data, NULL,
+	err = matrix_keypad_build_keymap(NULL, NULL,
 					 EP93XX_MATRIX_ROWS, EP93XX_MATRIX_COLS,
 					 keypad->keycodes, input_dev);
 	if (err)
 		return err;
 
-	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
+	if (keypad->flags & EP93XX_KEYPAD_AUTOREPEAT)
 		__set_bit(EV_REP, input_dev->evbit);
 	input_set_drvdata(input_dev, keypad);
 
@@ -315,10 +310,17 @@ static int ep93xx_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ep93xx_keypad_of_ids[] = {
+	{ .compatible = "cirrus,ep9307-keypad" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ep93xx_keypad_of_ids);
+
 static struct platform_driver ep93xx_keypad_driver = {
 	.driver		= {
 		.name	= "ep93xx-keypad",
 		.pm	= pm_sleep_ptr(&ep93xx_keypad_pm_ops),
+		.of_match_table = ep93xx_keypad_of_ids,
 	},
 	.probe		= ep93xx_keypad_probe,
 	.remove		= ep93xx_keypad_remove,
-- 
2.37.4

