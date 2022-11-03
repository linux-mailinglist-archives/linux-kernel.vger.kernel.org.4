Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07F861E09C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 08:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiKFHOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 02:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiKFHO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 02:14:29 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D786DE94
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 00:14:26 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l15so5467365qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okHcJs2Cc2s2NGFd3cbIMzhnoKFHepCEh8VYgpHYEm0=;
        b=rxrXpSOFJPnPjTQuX3EFpO6Z71tQuYoT6dRTArK3koTJxKg/V5fZExzQT2cjh6cV2u
         M080BuKHQyDOIS/BMyB04EFy54PZ9hlg3tODAiejquMiLJaQMJhT3FEuLBhVQlLMu48Q
         oCe+sCeu1XZAAipv2A6MnDT8pcnwO+jRRZb6LsdieZGkt004x/c377HPbx7MKzjv+d78
         5mIx/Z9n4M/u1PRB+CCT2BzS+RuxJbjCqwq7AiADzkHurJpRYP91F7lAjJgaUYJARjLg
         zPqp5mn3Or7Wws9gMzZV3dweJqGIpy2iT2WxtsOv9VIfwhunC0QKi16xs1Qnn/+UOrKV
         WTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okHcJs2Cc2s2NGFd3cbIMzhnoKFHepCEh8VYgpHYEm0=;
        b=x+m8+6LXmOGUJoI++cVi1wnCCUt7qSpl+AkoyDXsjdQgrg4n0xeM5ZJCOsYNwWTlYy
         VjwE9YsCJwphQYN+JLELfKhJ1jn6+cOkA4s1uhQJmQJDP3tkfgaBIoQqAIjPZ0UxJ5t1
         4AbkCkBYKDxrQwdJvw4TIKcx5S+lgjQx0/635L/vu1l+V/6CrBBPlceV+IGooEkN+Ruy
         jAHEQnJmfm2JRO/4O8mUq+7N9WUb1y7nevoWEdeFspBFqoVvQQI87R7jpy3te3Hv2/HS
         SJkle3ddik7OBmO8qRfeBUgfGs1Mp6PY9O20weEwn77V9mhCYk1xezBakVofl5vosZBn
         5DoA==
X-Gm-Message-State: ANoB5pnieSYT6vuQ3nnIA9XfMHG9YAMar5es6Motf0YAS9lQSpmvbIVI
        9+gvh5q+rDOsayj1bBBS5z2ZAQ==
X-Google-Smtp-Source: AA0mqf6r8jH/vflciLJrs9jiSA9IdYjSUPCnsY4ZPe9oJbViqCgsY72JySFZD6l05gP/F8LvyADTmA==
X-Received: by 2002:ac8:5f0b:0:b0:3a5:848e:d161 with SMTP id x11-20020ac85f0b000000b003a5848ed161mr980577qta.196.1667718865527;
        Sun, 06 Nov 2022 00:14:25 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006af0ce13499sm3719038qkj.115.2022.11.06.00.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 00:14:25 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/3] gpio: 104-idi-48: Migrate to regmap API
Date:   Thu,  3 Nov 2022 07:20:48 -0400
Message-Id: <a25550306d3bb93213ff250a609f0f8cf01278db.1667472555.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667472555.git.william.gray@linaro.org>
References: <cover.1667472555.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-idi-48.c | 54 ++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index c5e231fde1af..5d9de5b5e7af 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -8,9 +8,9 @@
  */
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
-#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/irqdesc.h>
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -43,22 +44,27 @@ MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
  * @port0:	Port 0 Inputs
  * @unused:	Unused
  * @port1:	Port 1 Inputs
- * @irq:	Read: IRQ Status Register/IRQ Clear
- *		Write: IRQ Enable/Disable
  */
 struct idi_48_reg {
 	u8 port0[3];
 	u8 unused;
 	u8 port1[3];
-	u8 irq;
 };
 
+#define IDI48_NAME "104-idi-48"
+
+#define IDI48_REGS_OFFSET 0x3
+#define IDI48_IRQ_STATUS 0x0
+#define IDI48_IRQ_CLEAR 0x0
+#define IDI48_IRQ_ENABLE 0x0
+
 /**
  * struct idi_48_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	input bits affected by interrupts
  * @reg:	I/O address offset for the device registers
+ * @map:	device register map
  * @cos_enb:	Change-Of-State IRQ enable boundaries mask
  */
 struct idi_48_gpio {
@@ -66,6 +72,7 @@ struct idi_48_gpio {
 	spinlock_t lock;
 	unsigned char irq_mask[6];
 	struct idi_48_reg __iomem *reg;
+	struct regmap *map;
 	unsigned char cos_enb;
 };
 
@@ -122,7 +129,7 @@ static void idi_48_irq_mask(struct irq_data *data)
 
 	idi48gpio->cos_enb &= ~BIT(boundary);
 
-	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
+	regmap_write(idi48gpio->map, IDI48_IRQ_ENABLE, idi48gpio->cos_enb);
 
 exit:
 	spin_unlock_irqrestore(&idi48gpio->lock, flags);
@@ -151,7 +158,7 @@ static void idi_48_irq_unmask(struct irq_data *data)
 
 	idi48gpio->cos_enb |= BIT(boundary);
 
-	iowrite8(idi48gpio->cos_enb, &idi48gpio->reg->irq);
+	regmap_write(idi48gpio->map, IDI48_IRQ_ENABLE, idi48gpio->cos_enb);
 
 exit:
 	spin_unlock_irqrestore(&idi48gpio->lock, flags);
@@ -168,7 +175,7 @@ static int idi_48_irq_set_type(struct irq_data *data, unsigned int flow_type)
 }
 
 static const struct irq_chip idi_48_irqchip = {
-	.name = "104-idi-48",
+	.name = IDI48_NAME,
 	.irq_ack = idi_48_irq_ack,
 	.irq_mask = idi_48_irq_mask,
 	.irq_unmask = idi_48_irq_unmask,
@@ -180,6 +187,7 @@ static const struct irq_chip idi_48_irqchip = {
 static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 {
 	struct idi_48_gpio *const idi48gpio = dev_id;
+	unsigned int irq_status;
 	unsigned long cos_status;
 	unsigned long boundary;
 	unsigned long irq_mask;
@@ -189,7 +197,8 @@ static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
 
 	spin_lock(&idi48gpio->lock);
 
-	cos_status = ioread8(&idi48gpio->reg->irq);
+	regmap_read(idi48gpio->map, IDI48_IRQ_STATUS, &irq_status);
+	cos_status = irq_status;
 
 	/* IRQ Status (bit 6) is active low (0 = IRQ generated by device) */
 	if (cos_status & BIT(6)) {
@@ -231,18 +240,27 @@ static const char *idi48_names[IDI48_NGPIO] = {
 static int idi_48_irq_init_hw(struct gpio_chip *gc)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
+	unsigned int val;
 
 	/* Disable IRQ by default */
-	iowrite8(0, &idi48gpio->reg->irq);
-	ioread8(&idi48gpio->reg->irq);
-
-	return 0;
+	regmap_write(idi48gpio->map, IDI48_IRQ_ENABLE, 0x00);
+	return regmap_read(idi48gpio->map, IDI48_IRQ_CLEAR, &val);
 }
 
+static const struct regmap_config idi48_regmap_config = {
+	.name = IDI48_NAME,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_stride = 1,
+	.io_port = true,
+	.max_register = 0x0,
+};
+
 static int idi_48_probe(struct device *dev, unsigned int id)
 {
 	struct idi_48_gpio *idi48gpio;
 	const char *const name = dev_name(dev);
+	void __iomem *regs;
 	struct gpio_irq_chip *girq;
 	int err;
 
@@ -256,9 +274,15 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	idi48gpio->reg = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
-	if (!idi48gpio->reg)
+	regs = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
+	if (!regs)
 		return -ENOMEM;
+	idi48gpio->reg = regs;
+
+	idi48gpio->map = devm_regmap_init_mmio(dev, regs + IDI48_REGS_OFFSET,
+					       &idi48_regmap_config);
+	if (IS_ERR(idi48gpio->map))
+		return PTR_ERR(idi48gpio->map);
 
 	idi48gpio->chip.label = name;
 	idi48gpio->chip.parent = dev;
@@ -302,7 +326,7 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 static struct isa_driver idi_48_driver = {
 	.probe = idi_48_probe,
 	.driver = {
-		.name = "104-idi-48"
+		.name = IDI48_NAME,
 	},
 };
 module_isa_driver_with_irq(idi_48_driver, num_idi_48, num_irq);
-- 
2.37.3

