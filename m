Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB33F61E09E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 08:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKFHOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 02:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiKFHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 02:14:30 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B05BC19
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 00:14:27 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l15so5467372qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k52tAjJFQnpL2hCjsnttJ7jMf+0wZPGn0WtzO16U/A=;
        b=Ui82qdSDlL3GRo4spJ7o5dnb7zkb+VUQpVKfXbu7gH9CD5LGE3be5ScvUxwuJQH3A8
         sMV94qlfp6ZsJOVnxnYFLOv9MqzQW+/Z3jPJZC+NZ0DIVWyQ18TEWLE+AnUjlWu4gWEV
         JpNnVkGHJa5QZF+nntEuaGDPvkspOq/3wZVfrkSv/kmpIHyJHrywT1NRzBhNJvgg+pAM
         EMKBO3Ib2D2wOq45K90I+mg6dzdXVXxe1IOHhrT4+YEX/DcePDwjwxQRk0vJ2x5n+F2k
         u7M/LXhD50TmHMUQuP9ZfjZ2RbfEbPsmDCClSQutnLS2iTxdMxnkpP3hekx8U1kzYnew
         zNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k52tAjJFQnpL2hCjsnttJ7jMf+0wZPGn0WtzO16U/A=;
        b=YsD2AdZ4czZkOCZGpHg2ZCqZQ38jEAQ65n6lc2cGDuDGQBdGLQalGt8pCKfCk+qom9
         6SMqMEAXdPba+UorbjT1Ltxn4oSmTfYcwNDF49fxg4a3X0BqtTFnuyqIPvbgdSKnuDv+
         Kc2cbVjG2f8di/YmI7ZtW/oLikBd7bG1CHpsjNOH9FL/BcAcLwObirHHXsnoe2QAMq3A
         nArwzPg3Xu0rPfsw8bxgrsITC0Yz5tO7Cyig6jwAvjuWMjZQfxrI7kgkxhow8bjQaGcn
         o7wahjboea8x1bDfUa93cAEAHjjappswmCjDA2apPv+gvHxFd0FZA+/cIVHemuY610ZJ
         EGfA==
X-Gm-Message-State: ACrzQf2+QU1iEjrJAontWLiJOA55UOUh8bxxMVhdAL9ldVOMBlUB6MJj
        2Ku7mr5dBMRZDKYOdZa8oZ+qvA==
X-Google-Smtp-Source: AMsMyM5MfxL6/GwlQ9BsM8QNwrsxsHGZHPEZMncurR/Q0y0NlNkVL8AwxJ20xmbrbOyhtSiG0uIcEw==
X-Received: by 2002:ac8:67cf:0:b0:3a5:3fab:a067 with SMTP id r15-20020ac867cf000000b003a53faba067mr20362063qtp.514.1667718866827;
        Sun, 06 Nov 2022 00:14:26 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id t29-20020a37ea1d000000b006af0ce13499sm3719038qkj.115.2022.11.06.00.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 00:14:26 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 3/3] gpio: i8255: Migrate to regmap API
Date:   Thu,  3 Nov 2022 07:20:49 -0400
Message-Id: <508cc1c01cdfa8192e553ac290995ffe8e5681a2.1667472555.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667472555.git.william.gray@linaro.org>
References: <cover.1667472555.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The 104-dio-48e, 104-idi-48, and gpio-mm modules
depend on the i8255 library and are thus updated accordingly.

The struct i8255_state data structure is removed and its role merged
into the struct i8255 data structure which is updated to hold regmap
register maps. Similarly, the i8255_state_init() function is repurposed
to the i8255_init() function; the other i8255 library functions are
adjusted to utilize the regmap API. The I8255_REGMAP_CONFIG macro is
introduced to facilitate the initialization of struct regmap_config
data structures for i8255 register mappings.

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 111 ++++++++++------
 drivers/gpio/gpio-104-idi-48.c  |  60 ++++++---
 drivers/gpio/gpio-gpio-mm.c     |  97 ++++++++++----
 drivers/gpio/gpio-i8255.c       | 218 +++++++++++++++++++++-----------
 drivers/gpio/gpio-i8255.h       |  54 ++++----
 5 files changed, 353 insertions(+), 187 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index 134e3dd12ae9..e460d66800cb 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -52,28 +52,18 @@ MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
 #define DIO48E_NUM_PPI 2
 
-/**
- * struct dio48e_reg - device register structure
- * @ppi:		Programmable Peripheral Interface groups
- */
-struct dio48e_reg {
-	struct i8255 ppi[DIO48E_NUM_PPI];
-};
-
 /**
  * struct dio48e_gpio - GPIO device private data structure
  * @chip:		instance of the gpio_chip
- * @ppi_state:		PPI device states
+ * @ppi:		Programmable Peripheral Interface device structures
  * @lock:		synchronization lock to prevent I/O race conditions
- * @reg:		I/O address offset for the device registers
  * @map:		device register map
  * @irq_mask:		I/O bits affected by interrupts
  */
 struct dio48e_gpio {
 	struct gpio_chip chip;
-	struct i8255_state ppi_state[DIO48E_NUM_PPI];
+	struct i8255 ppi[DIO48E_NUM_PPI];
 	raw_spinlock_t lock;
-	struct dio48e_reg __iomem *reg;
 	struct regmap *map;
 	unsigned char irq_mask;
 };
@@ -82,7 +72,7 @@ static int dio48e_gpio_get_direction(struct gpio_chip *chip, unsigned int offset
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 
-	if (i8255_get_direction(dio48egpio->ppi_state, offset))
+	if (i8255_get_direction(dio48egpio->ppi, offset))
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
@@ -92,10 +82,7 @@ static int dio48e_gpio_direction_input(struct gpio_chip *chip, unsigned int offs
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 
-	i8255_direction_input(dio48egpio->reg->ppi, dio48egpio->ppi_state,
-			      offset);
-
-	return 0;
+	return i8255_direction_input(dio48egpio->ppi, offset);
 }
 
 static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
@@ -103,17 +90,20 @@ static int dio48e_gpio_direction_output(struct gpio_chip *chip, unsigned int off
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 
-	i8255_direction_output(dio48egpio->reg->ppi, dio48egpio->ppi_state,
-			       offset, value);
-
-	return 0;
+	return i8255_direction_output(dio48egpio->ppi, offset, value);
 }
 
 static int dio48e_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
+	bool value;
+	int err;
 
-	return i8255_get(dio48egpio->reg->ppi, offset);
+	err = i8255_get(dio48egpio->ppi, offset, &value);
+	if (err)
+		return err;
+
+	return value;
 }
 
 static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -121,25 +111,32 @@ static int dio48e_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
 
-	i8255_get_multiple(dio48egpio->reg->ppi, mask, bits, chip->ngpio);
-
-	return 0;
+	return i8255_get_multiple(dio48egpio->ppi, mask, bits, chip->ngpio);
 }
 
 static void dio48e_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
+	int err;
 
-	i8255_set(dio48egpio->reg->ppi, dio48egpio->ppi_state, offset, value);
+	err = i8255_set(dio48egpio->ppi, offset, value);
+	if (err)
+		dev_warn(chip->parent,
+			 "Unable to set GPIO offset %u to value %d (errno %d)\n",
+			 offset, value, err);
 }
 
 static void dio48e_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct dio48e_gpio *const dio48egpio = gpiochip_get_data(chip);
+	int err;
 
-	i8255_set_multiple(dio48egpio->reg->ppi, dio48egpio->ppi_state, mask,
-			   bits, chip->ngpio);
+	err = i8255_set_multiple(dio48egpio->ppi, mask, bits, chip->ngpio);
+	if (err)
+		dev_warn(chip->parent,
+			 "Unable to set GPIO with mask %lu and bits %lu (errno %d)\n",
+			 *mask, *bits, err);
 }
 
 static void dio48e_irq_ack(struct irq_data *data)
@@ -271,19 +268,52 @@ static int dio48e_irq_init_hw(struct gpio_chip *gc)
 	return regmap_read(dio48egpio->map, DIO48E_DISABLE_INTERRUPT, &val);
 }
 
-static void dio48e_init_ppi(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const ppi_state)
+static const struct regmap_range dio48e_ppi_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x2),
+};
+static const struct regmap_access_table dio48e_ppi_rd_table = {
+	.yes_ranges = dio48e_ppi_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(dio48e_ppi_rd_ranges),
+};
+
+static int devm_dio48e_init_ppi_maps(struct device *const dev,
+				     struct regmap **const maps,
+				     void __iomem *const regs)
+{
+	struct regmap_config config = I8255_REGMAP_CONFIG;
+	unsigned long i;
+
+	config.io_port = true;
+	config.rd_table = &dio48e_ppi_rd_table;
+
+	for (i = 0; i < DIO48E_NUM_PPI; i++) {
+		maps[i] = devm_regmap_init_mmio(dev, regs + i * 4, &config);
+		if (IS_ERR(maps[i]))
+			return PTR_ERR(maps[i]);
+	}
+
+	return 0;
+}
+
+static int dio48e_init_ppi(struct i8255 *const ppi)
 {
 	const unsigned long ngpio = 24;
 	const unsigned long mask = GENMASK(ngpio - 1, 0);
 	const unsigned long bits = 0;
 	unsigned long i;
+	int err;
 
 	/* Initialize all GPIO to output 0 */
 	for (i = 0; i < DIO48E_NUM_PPI; i++) {
-		i8255_mode0_output(&ppi[i]);
-		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
+		err = i8255_mode0_output(&ppi[i]);
+		if (err)
+			return err;
+		err = i8255_set_multiple(&ppi[i], &mask, &bits, ngpio);
+		if (err)
+			return err;
 	}
+
+	return 0;
 }
 
 static const struct regmap_range dio48e_wr_ranges[] = {
@@ -322,6 +352,7 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	struct dio48e_gpio *dio48egpio;
 	const char *const name = dev_name(dev);
 	void __iomem *regs;
+	struct regmap *ppi_maps[DIO48E_NUM_PPI];
 	struct gpio_irq_chip *girq;
 	int err;
 
@@ -338,7 +369,18 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 	regs = devm_ioport_map(dev, base[id], DIO48E_EXTENT);
 	if (!regs)
 		return -ENOMEM;
-	dio48egpio->reg = regs;
+
+	err = devm_dio48e_init_ppi_maps(dev, ppi_maps, regs);
+	if (err) {
+		dev_err(dev, "Regmaps initialization failed (%d)\n", err);
+		return err;
+	}
+	i8255_init(dio48egpio->ppi, DIO48E_NUM_PPI, ppi_maps);
+	err = dio48e_init_ppi(dio48egpio->ppi);
+	if (err) {
+		dev_err(dev, "PPI initialization failed (%d)\n", err);
+		return err;
+	}
 
 	dio48egpio->map = devm_regmap_init_mmio(dev, regs + DIO48E_REGS_OFFSET,
 						&dio48e_regmap_config);
@@ -371,9 +413,6 @@ static int dio48e_probe(struct device *dev, unsigned int id)
 
 	raw_spin_lock_init(&dio48egpio->lock);
 
-	i8255_state_init(dio48egpio->ppi_state, DIO48E_NUM_PPI);
-	dio48e_init_ppi(dio48egpio->reg->ppi, dio48egpio->ppi_state);
-
 	err = devm_gpiochip_add_data(dev, &dio48egpio->chip, dio48egpio);
 	if (err) {
 		dev_err(dev, "GPIO registering failed (%d)\n", err);
diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 5d9de5b5e7af..e44dfbb68142 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -39,18 +39,6 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
-/**
- * struct idi_48_reg - device register structure
- * @port0:	Port 0 Inputs
- * @unused:	Unused
- * @port1:	Port 1 Inputs
- */
-struct idi_48_reg {
-	u8 port0[3];
-	u8 unused;
-	u8 port1[3];
-};
-
 #define IDI48_NAME "104-idi-48"
 
 #define IDI48_REGS_OFFSET 0x3
@@ -58,12 +46,14 @@ struct idi_48_reg {
 #define IDI48_IRQ_CLEAR 0x0
 #define IDI48_IRQ_ENABLE 0x0
 
+#define IDI48_NUM_PPI 2
+
 /**
  * struct idi_48_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	input bits affected by interrupts
- * @reg:	I/O address offset for the device registers
+ * @ppi:	Programmable Peripheral Interface device structures
  * @map:	device register map
  * @cos_enb:	Change-Of-State IRQ enable boundaries mask
  */
@@ -71,7 +61,7 @@ struct idi_48_gpio {
 	struct gpio_chip chip;
 	spinlock_t lock;
 	unsigned char irq_mask[6];
-	struct idi_48_reg __iomem *reg;
+	struct i8255 ppi[IDI48_NUM_PPI];
 	struct regmap *map;
 	unsigned char cos_enb;
 };
@@ -89,20 +79,22 @@ static int idi_48_gpio_direction_input(struct gpio_chip *chip, unsigned int offs
 static int idi_48_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
+	bool value;
+	int err;
 
-	return i8255_get(ppi, offset);
+	err = i8255_get(idi48gpio->ppi, offset, &value);
+	if (err)
+		return err;
+
+	return value;
 }
 
 static int idi_48_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 	unsigned long *bits)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(chip);
-	void __iomem *const ppi = idi48gpio->reg;
-
-	i8255_get_multiple(ppi, mask, bits, chip->ngpio);
 
-	return 0;
+	return i8255_get_multiple(idi48gpio->ppi, mask, bits, chip->ngpio);
 }
 
 static void idi_48_irq_ack(struct irq_data *data)
@@ -237,6 +229,25 @@ static const char *idi48_names[IDI48_NGPIO] = {
 	"Bit 18 B", "Bit 19 B", "Bit 20 B", "Bit 21 B", "Bit 22 B", "Bit 23 B"
 };
 
+static int devm_idi_48_init_ppi_maps(struct device *const dev,
+				     struct regmap **const maps,
+				     void __iomem *const regs)
+{
+	struct regmap_config config = I8255_REGMAP_CONFIG;
+	unsigned long i;
+
+	config.io_port = true;
+	config.max_register = 0x2;
+
+	for (i = 0; i < IDI48_NUM_PPI; i++) {
+		maps[i] = devm_regmap_init_mmio(dev, regs + i * 4, &config);
+		if (IS_ERR(maps[i]))
+			return PTR_ERR(maps[i]);
+	}
+
+	return 0;
+}
+
 static int idi_48_irq_init_hw(struct gpio_chip *gc)
 {
 	struct idi_48_gpio *const idi48gpio = gpiochip_get_data(gc);
@@ -261,6 +272,7 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	struct idi_48_gpio *idi48gpio;
 	const char *const name = dev_name(dev);
 	void __iomem *regs;
+	struct regmap *ppi_maps[IDI48_NUM_PPI];
 	struct gpio_irq_chip *girq;
 	int err;
 
@@ -277,7 +289,13 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	regs = devm_ioport_map(dev, base[id], IDI_48_EXTENT);
 	if (!regs)
 		return -ENOMEM;
-	idi48gpio->reg = regs;
+
+	err = devm_idi_48_init_ppi_maps(dev, ppi_maps, regs);
+	if (err) {
+		dev_err(dev, "Regmaps initialization failed (%d)\n", err);
+		return err;
+	}
+	i8255_init(idi48gpio->ppi, IDI48_NUM_PPI, ppi_maps);
 
 	idi48gpio->map = devm_regmap_init_mmio(dev, regs + IDI48_REGS_OFFSET,
 					       &idi48_regmap_config);
diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 2689671b6b01..2efcf63fb0f6 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -33,13 +33,11 @@ MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
 /**
  * struct gpiomm_gpio - GPIO device private data structure
  * @chip:		instance of the gpio_chip
- * @ppi_state:		Programmable Peripheral Interface group states
- * @ppi:		Programmable Peripheral Interface groups
+ * @ppi:		Programmable Peripheral Interface device structures
  */
 struct gpiomm_gpio {
 	struct gpio_chip chip;
-	struct i8255_state ppi_state[GPIOMM_NUM_PPI];
-	struct i8255 __iomem *ppi;
+	struct i8255 ppi[GPIOMM_NUM_PPI];
 };
 
 static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
@@ -47,7 +45,7 @@ static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 
-	if (i8255_get_direction(gpiommgpio->ppi_state, offset))
+	if (i8255_get_direction(gpiommgpio->ppi, offset))
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
@@ -58,9 +56,7 @@ static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 
-	i8255_direction_input(gpiommgpio->ppi, gpiommgpio->ppi_state, offset);
-
-	return 0;
+	return i8255_direction_input(gpiommgpio->ppi, offset);
 }
 
 static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
@@ -68,17 +64,20 @@ static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 
-	i8255_direction_output(gpiommgpio->ppi, gpiommgpio->ppi_state, offset,
-			       value);
-
-	return 0;
+	return i8255_direction_output(gpiommgpio->ppi, offset, value);
 }
 
 static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
+	bool value;
+	int err;
+
+	err = i8255_get(gpiommgpio->ppi, offset, &value);
+	if (err)
+		return err;
 
-	return i8255_get(gpiommgpio->ppi, offset);
+	return value;
 }
 
 static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
@@ -86,26 +85,33 @@ static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
 
-	i8255_get_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
-
-	return 0;
+	return i8255_get_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
 }
 
 static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
+	int err;
 
-	i8255_set(gpiommgpio->ppi, gpiommgpio->ppi_state, offset, value);
+	err = i8255_set(gpiommgpio->ppi, offset, value);
+	if (err)
+		dev_warn(chip->parent,
+			 "Unable to set GPIO offset %u to value %d (errno %d)\n",
+			 offset, value, err);
 }
 
 static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
+	int err;
 
-	i8255_set_multiple(gpiommgpio->ppi, gpiommgpio->ppi_state, mask, bits,
-			   chip->ngpio);
+	err = i8255_set_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
+	if (err)
+		dev_warn(chip->parent,
+			 "Unable to set GPIO with mask %lu and bits %lu (errno %d)\n",
+			 *mask, *bits, err);
 }
 
 #define GPIOMM_NGPIO 48
@@ -120,25 +126,51 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
 	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
 };
 
-static void gpiomm_init_dio(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const ppi_state)
+static int devm_gpiomm_init_ppi_maps(struct device *const dev,
+				     struct regmap **const maps,
+				     void __iomem *const regs)
+{
+	struct regmap_config config = I8255_REGMAP_CONFIG;
+	unsigned long i;
+
+	config.io_port = true;
+
+	for (i = 0; i < GPIOMM_NUM_PPI; i++) {
+		maps[i] = devm_regmap_init_mmio(dev, regs + i * 4, &config);
+		if (IS_ERR(maps[i]))
+			return PTR_ERR(maps[i]);
+	}
+
+	return 0;
+}
+
+static int gpiomm_init_dio(struct i8255 *const ppi)
 {
 	const unsigned long ngpio = 24;
 	const unsigned long mask = GENMASK(ngpio - 1, 0);
 	const unsigned long bits = 0;
 	unsigned long i;
+	int err;
 
 	/* Initialize all GPIO to output 0 */
 	for (i = 0; i < GPIOMM_NUM_PPI; i++) {
-		i8255_mode0_output(&ppi[i]);
-		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
+		err = i8255_mode0_output(&ppi[i]);
+		if (err)
+			return err;
+		err = i8255_set_multiple(&ppi[i], &mask, &bits, ngpio);
+		if (err)
+			return err;
 	}
+
+	return 0;
 }
 
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
 	struct gpiomm_gpio *gpiommgpio;
 	const char *const name = dev_name(dev);
+	void __iomem *regs;
+	struct regmap *ppi_maps[GPIOMM_NUM_PPI];
 	int err;
 
 	gpiommgpio = devm_kzalloc(dev, sizeof(*gpiommgpio), GFP_KERNEL);
@@ -151,10 +183,22 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	gpiommgpio->ppi = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
-	if (!gpiommgpio->ppi)
+	regs = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
+	err = devm_gpiomm_init_ppi_maps(dev, ppi_maps, regs);
+	if (err) {
+		dev_err(dev, "Regmaps initialization failed (%d)\n", err);
+		return err;
+	}
+	i8255_init(gpiommgpio->ppi, GPIOMM_NUM_PPI, ppi_maps);
+	err = gpiomm_init_dio(gpiommgpio->ppi);
+	if (err) {
+		dev_err(dev, "PPI initialization failed (%d)\n", err);
+		return err;
+	}
+
 	gpiommgpio->chip.label = name;
 	gpiommgpio->chip.parent = dev;
 	gpiommgpio->chip.owner = THIS_MODULE;
@@ -169,9 +213,6 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 	gpiommgpio->chip.set = gpiomm_gpio_set;
 	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
 
-	i8255_state_init(gpiommgpio->ppi_state, GPIOMM_NUM_PPI);
-	gpiomm_init_dio(gpiommgpio->ppi, gpiommgpio->ppi_state);
-
 	err = devm_gpiochip_add_data(dev, &gpiommgpio->chip, gpiommgpio);
 	if (err) {
 		dev_err(dev, "GPIO registering failed (%d)\n", err);
diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
index 9b97db418df1..5ff8d90c0fe3 100644
--- a/drivers/gpio/gpio-i8255.c
+++ b/drivers/gpio/gpio-i8255.c
@@ -6,8 +6,8 @@
 #include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/io.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -21,14 +21,22 @@
 #define I8255_PORTA 0
 #define I8255_PORTB 1
 #define I8255_PORTC 2
+#define I8255_CONTROL 3
 
-static int i8255_get_port(struct i8255 __iomem *const ppi,
-			  const unsigned long io_port, const unsigned long mask)
+static int i8255_get_port(struct i8255 *const ppi, const unsigned long io_port,
+			  const unsigned long mask, unsigned int *val)
 {
 	const unsigned long bank = io_port / 3;
 	const unsigned long ppi_port = io_port % 3;
+	int err;
 
-	return ioread8(&ppi[bank].port[ppi_port]) & mask;
+	err = regmap_read(ppi[bank].map, ppi_port, val);
+	if (err)
+		return err;
+
+	*val &= mask;
+
+	return 0;
 }
 
 static u8 i8255_direction_mask(const unsigned long offset)
@@ -53,85 +61,90 @@ static u8 i8255_direction_mask(const unsigned long offset)
 	}
 }
 
-static void i8255_set_port(struct i8255 __iomem *const ppi,
-			   struct i8255_state *const state,
-			   const unsigned long io_port,
-			   const unsigned long mask, const unsigned long bits)
+static int i8255_set_port(struct i8255 *const ppi, const unsigned long io_port,
+			  const unsigned long mask, const unsigned long bits)
 {
 	const unsigned long bank = io_port / 3;
 	const unsigned long ppi_port = io_port % 3;
-	unsigned long flags;
-	unsigned long out_state;
+	unsigned int out_state;
+	int err;
 
-	spin_lock_irqsave(&state[bank].lock, flags);
+	err = regmap_read(ppi[bank].map, ppi_port, &out_state);
+	if (err)
+		return err;
 
-	out_state = ioread8(&ppi[bank].port[ppi_port]);
 	out_state = (out_state & ~mask) | (bits & mask);
-	iowrite8(out_state, &ppi[bank].port[ppi_port]);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
+	return regmap_write(ppi[bank].map, ppi_port, out_state);
 }
 
 /**
  * i8255_direction_input - configure signal offset as input
  * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
  * @offset:	signal offset to configure as input
  *
  * Configures a signal @offset as input for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks. The @state control_state
- * values are updated to reflect the new configuration.
+ * Programmable Peripheral Interface (@ppi) banks. Returns 0 on success and
+ * negative error number on failure.
  */
-void i8255_direction_input(struct i8255 __iomem *const ppi,
-			   struct i8255_state *const state,
-			   const unsigned long offset)
+int i8255_direction_input(struct i8255 *const ppi, const unsigned long offset)
 {
 	const unsigned long io_port = offset / 8;
 	const unsigned long bank = io_port / 3;
 	unsigned long flags;
+	int err;
 
-	spin_lock_irqsave(&state[bank].lock, flags);
+	spin_lock_irqsave(&ppi[bank].lock, flags);
 
-	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state |= i8255_direction_mask(offset);
+	ppi[bank].control_state |= I8255_CONTROL_MODE_SET;
+	ppi[bank].control_state |= i8255_direction_mask(offset);
 
-	iowrite8(state[bank].control_state, &ppi[bank].control);
+	err = regmap_write(ppi[bank].map, I8255_CONTROL,
+			   ppi[bank].control_state);
+	if (err) {
+		spin_unlock_irqrestore(&ppi[bank].lock, flags);
+		return err;
+	}
+
+	spin_unlock_irqrestore(&ppi[bank].lock, flags);
 
-	spin_unlock_irqrestore(&state[bank].lock, flags);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(i8255_direction_input, I8255);
 
 /**
  * i8255_direction_output - configure signal offset as output
  * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
  * @offset:	signal offset to configure as output
  * @value:	signal value to output
  *
  * Configures a signal @offset as output for the respective Intel 8255
  * Programmable Peripheral Interface (@ppi) banks and sets the respective signal
- * output to the desired @value. The @state control_state values are updated to
- * reflect the new configuration.
+ * output to the desired @value. Returns 0 on success and negative error number
+ * on failure.
  */
-void i8255_direction_output(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const state,
-			    const unsigned long offset,
-			    const unsigned long value)
+int i8255_direction_output(struct i8255 *const ppi, const unsigned long offset,
+			   const unsigned long value)
 {
 	const unsigned long io_port = offset / 8;
 	const unsigned long bank = io_port / 3;
 	unsigned long flags;
+	int err;
 
-	spin_lock_irqsave(&state[bank].lock, flags);
+	spin_lock_irqsave(&ppi[bank].lock, flags);
 
-	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state &= ~i8255_direction_mask(offset);
+	ppi[bank].control_state |= I8255_CONTROL_MODE_SET;
+	ppi[bank].control_state &= ~i8255_direction_mask(offset);
 
-	iowrite8(state[bank].control_state, &ppi[bank].control);
+	err = regmap_write(ppi[bank].map, I8255_CONTROL,
+			   ppi[bank].control_state);
+	if (err) {
+		spin_unlock_irqrestore(&ppi[bank].lock, flags);
+		return err;
+	}
 
-	spin_unlock_irqrestore(&state[bank].lock, flags);
+	spin_unlock_irqrestore(&ppi[bank].lock, flags);
 
-	i8255_set(ppi, state, offset, value);
+	return i8255_set(ppi, offset, value);
 }
 EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
 
@@ -139,16 +152,28 @@ EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
  * i8255_get - get signal value at signal offset
  * @ppi:	Intel 8255 Programmable Peripheral Interface banks
  * @offset:	offset of signal to get
+ * @value:	pointer to store read signal value
  *
- * Returns the signal value (0=low, 1=high) for the signal at @offset for the
- * respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
+ * Gets the signal value for the signal at @offset for the
+ * respective Intel 8255 Programmable Peripheral Interface (@ppi) banks and
+ * stores it at the location pointed to by @value. Returns 0 on success and
+ * negative error number on failure.
  */
-int i8255_get(struct i8255 __iomem *const ppi, const unsigned long offset)
+int i8255_get(struct i8255 *const ppi, const unsigned long offset,
+	      bool *const value)
 {
 	const unsigned long io_port = offset / 8;
 	const unsigned long offset_mask = BIT(offset % 8);
+	unsigned int port_val;
+	int err;
 
-	return !!i8255_get_port(ppi, io_port, offset_mask);
+	err = i8255_get_port(ppi, io_port, offset_mask, &port_val);
+	if (err)
+		return err;
+
+	*value = port_val;
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(i8255_get, I8255);
 
@@ -159,13 +184,13 @@ EXPORT_SYMBOL_NS_GPL(i8255_get, I8255);
  *
  * Returns the signal direction (0=output, 1=input) for the signal at @offset.
  */
-int i8255_get_direction(const struct i8255_state *const state,
+int i8255_get_direction(const struct i8255 *const ppi,
 			const unsigned long offset)
 {
 	const unsigned long io_port = offset / 8;
 	const unsigned long bank = io_port / 3;
 
-	return !!(state[bank].control_state & i8255_direction_mask(offset));
+	return !!(ppi[bank].control_state & i8255_direction_mask(offset));
 }
 EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
 
@@ -178,24 +203,29 @@ EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
  *
  * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask
  * for the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
+ * Returns 0 on success and negative error number on failure.
  */
-void i8255_get_multiple(struct i8255 __iomem *const ppi,
-			const unsigned long *const mask,
-			unsigned long *const bits, const unsigned long ngpio)
+int i8255_get_multiple(struct i8255 *const ppi, const unsigned long *const mask,
+		       unsigned long *const bits, const unsigned long ngpio)
 {
 	unsigned long offset;
 	unsigned long port_mask;
 	unsigned long io_port;
-	unsigned long port_state;
+	unsigned int port_state;
+	int err;
 
 	bitmap_zero(bits, ngpio);
 
 	for_each_set_clump8(offset, port_mask, mask, ngpio) {
 		io_port = offset / 8;
-		port_state = i8255_get_port(ppi, io_port, port_mask);
+		err = i8255_get_port(ppi, io_port, port_mask, &port_state);
+		if (err)
+			return err;
 
 		bitmap_set_value8(bits, port_state, offset);
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
 
@@ -204,83 +234,123 @@ EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
  * @ppi:	Intel 8255 Programmable Peripheral Interface bank
  *
  * Configures all Intel 8255 Programmable Peripheral Interface (@ppi) ports to
- * MODE 0 (Basic Input/Output) output mode.
+ * MODE 0 (Basic Input/Output) output mode. Returns 0 on success and negative
+ * error number on failure.
  */
-void i8255_mode0_output(struct i8255 __iomem *const ppi)
+int i8255_mode0_output(struct i8255 *const ppi)
 {
-	iowrite8(I8255_CONTROL_MODE_SET, &ppi->control);
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&ppi->lock, flags);
+
+	err = regmap_write(ppi->map, I8255_CONTROL, I8255_CONTROL_MODE_SET);
+	if (err) {
+		spin_unlock_irqrestore(&ppi->lock, flags);
+		return err;
+	}
+
+	spin_unlock_irqrestore(&ppi->lock, flags);
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(i8255_mode0_output, I8255);
 
 /**
  * i8255_set - set signal value at signal offset
  * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
  * @offset:	offset of signal to set
  * @value:	value of signal to set
  *
  * Assigns output @value for the signal at @offset for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks.
+ * Programmable Peripheral Interface (@ppi) banks. Returns 0 on success and
+ * negative error number on failure.
  */
-void i8255_set(struct i8255 __iomem *const ppi, struct i8255_state *const state,
-	       const unsigned long offset, const unsigned long value)
+int i8255_set(struct i8255 *const ppi, const unsigned long offset,
+	      const unsigned long value)
 {
 	const unsigned long io_port = offset / 8;
 	const unsigned long port_offset = offset % 8;
 	const unsigned long mask = BIT(port_offset);
 	const unsigned long bits = value << port_offset;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&ppi->lock, flags);
 
-	i8255_set_port(ppi, state, io_port, mask, bits);
+	err = i8255_set_port(ppi, io_port, mask, bits);
+	if (err) {
+		spin_unlock_irqrestore(&ppi->lock, flags);
+		return err;
+	}
+
+	spin_unlock_irqrestore(&ppi->lock, flags);
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(i8255_set, I8255);
 
 /**
  * i8255_set_multiple - set signal values at multiple signal offsets
  * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
  * @mask:	mask of signals to set
  * @bits:	bitmap of signal output values
  * @ngpio:	number of GPIO signals of the respective PPI banks
  *
  * Assigns output values defined by @bits for the signals defined by @mask for
  * the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
+ * Returns 0 on success and negative error number on failure.
  */
-void i8255_set_multiple(struct i8255 __iomem *const ppi,
-			struct i8255_state *const state,
-			const unsigned long *const mask,
-			const unsigned long *const bits,
-			const unsigned long ngpio)
+int i8255_set_multiple(struct i8255 *const ppi, const unsigned long *const mask,
+		       const unsigned long *const bits,
+		       const unsigned long ngpio)
 {
 	unsigned long offset;
 	unsigned long port_mask;
 	unsigned long io_port;
 	unsigned long value;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&ppi->lock, flags);
 
 	for_each_set_clump8(offset, port_mask, mask, ngpio) {
 		io_port = offset / 8;
 		value = bitmap_get_value8(bits, offset);
-		i8255_set_port(ppi, state, io_port, port_mask, value);
+
+		err = i8255_set_port(ppi, io_port, port_mask, value);
+		if (err) {
+			spin_unlock_irqrestore(&ppi->lock, flags);
+			return err;
+		}
 	}
+
+	spin_unlock_irqrestore(&ppi->lock, flags);
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(i8255_set_multiple, I8255);
 
 /**
- * i8255_state_init - initialize i8255_state structure
- * @state:	devices states of the respective PPI banks
+ * i8255_init - initialize i8255 device structures
+ * @ppi:	Intel 8255 Programmable Peripheral Interface banks
  * @nbanks:	number of Intel 8255 Programmable Peripheral Interface banks
+ * @maps:	array of regmaps for respective PPI banks
  *
- * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
- * bank for use in i8255 library functions.
+ * Initializes the Intel 8255 Programmable Peripheral Interface device structure
+ * (@ppi) for use in i8255 library functions.
  */
-void i8255_state_init(struct i8255_state *const state,
-		      const unsigned long nbanks)
+void i8255_init(struct i8255 *const ppi, const unsigned long nbanks,
+		struct regmap **const maps)
 {
 	unsigned long bank;
 
-	for (bank = 0; bank < nbanks; bank++)
-		spin_lock_init(&state[bank].lock);
+	for (bank = 0; bank < nbanks; bank++) {
+		ppi[bank].map = maps[bank];
+		spin_lock_init(&ppi[bank].lock);
+	}
 }
-EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
+EXPORT_SYMBOL_NS_GPL(i8255_init, I8255);
 
 MODULE_AUTHOR("William Breathitt Gray");
 MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
index d9084aae9446..f0773ae458c8 100644
--- a/drivers/gpio/gpio-i8255.h
+++ b/drivers/gpio/gpio-i8255.h
@@ -3,44 +3,42 @@
 #ifndef _I8255_H_
 #define _I8255_H_
 
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
 /**
- * struct i8255 - Intel 8255 register structure
- * @port:	Port A, B, and C
- * @control:	Control register
- */
-struct i8255 {
-	u8 port[3];
-	u8 control;
-};
-
-/**
- * struct i8255_state - Intel 8255 state structure
+ * struct i8255 - Intel 8255 device structure
+ * @map:		device register map
  * @lock:		synchronization lock for accessing device state
  * @control_state:	Control register state
  */
-struct i8255_state {
+struct i8255 {
+	struct regmap *map;
 	spinlock_t lock;
 	u8 control_state;
 };
 
-void i8255_direction_input(struct i8255 __iomem *ppi, struct i8255_state *state,
-			   unsigned long offset);
-void i8255_direction_output(struct i8255 __iomem *ppi,
-			    struct i8255_state *state, unsigned long offset,
-			    unsigned long value);
-int i8255_get(struct i8255 __iomem *ppi, unsigned long offset);
-int i8255_get_direction(const struct i8255_state *state, unsigned long offset);
-void i8255_get_multiple(struct i8255 __iomem *ppi, const unsigned long *mask,
-			unsigned long *bits, unsigned long ngpio);
-void i8255_mode0_output(struct i8255 __iomem *const ppi);
-void i8255_set(struct i8255 __iomem *ppi, struct i8255_state *state,
-	       unsigned long offset, unsigned long value);
-void i8255_set_multiple(struct i8255 __iomem *ppi, struct i8255_state *state,
-			const unsigned long *mask, const unsigned long *bits,
-			unsigned long ngpio);
-void i8255_state_init(struct i8255_state *const state, unsigned long nbanks);
+int i8255_direction_input(struct i8255 *ppi, unsigned long offset);
+int i8255_direction_output(struct i8255 *ppi, unsigned long offset,
+			   unsigned long value);
+int i8255_get(struct i8255 *ppi, unsigned long offset, bool *value);
+int i8255_get_direction(const struct i8255 *ppi, unsigned long offset);
+int i8255_get_multiple(struct i8255 *ppi, const unsigned long *mask,
+		       unsigned long *bits, unsigned long ngpio);
+int i8255_mode0_output(struct i8255 *ppi);
+int i8255_set(struct i8255 *ppi, unsigned long offset, unsigned long value);
+int i8255_set_multiple(struct i8255 *ppi, const unsigned long *mask,
+		       const unsigned long *bits, unsigned long ngpio);
+void i8255_init(struct i8255 *ppi, unsigned long nbanks, struct regmap **maps);
+
+#define I8255_REGMAP_CONFIG \
+{ \
+	.name = "i8255", \
+	.reg_bits = 8, \
+	.val_bits = 8, \
+	.reg_stride = 1, \
+	.max_register = 0x3, \
+}
 
 #endif /* _I8255_H_ */
-- 
2.37.3

