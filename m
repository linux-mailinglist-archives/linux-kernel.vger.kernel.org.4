Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3853743B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjF3MGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjF3MGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:06:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575B3C3F;
        Fri, 30 Jun 2023 05:05:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so9243905e9.3;
        Fri, 30 Jun 2023 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688126719; x=1690718719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAapxjBD/rwbhfxji86yGKwLK1ac+lCSTHoejUz0sCA=;
        b=G2hm/3wbHT0wdTRF7Ea5NM+45CGLivRnJb/bhiN7YvbTVDF6UKc1ItVDMFUINx75gj
         /4/FFdJ8sMckmZ3wphiO+3xKSY8GI6DQ0OBoJPGssSpp6uyKdES9t8GxQOfK3slypcic
         FaHedPYgaQhhq6u2gqDBTdOhs0ttIBxACyB/ycGLjM9V2P7AlUPzUo/iCHiOD8JcP478
         7TDRQ3UBbkZ5BR3m764DM09VzhG84IPlactzdrqz2HlhmLNR+szB3mLasJLZLnyPKFqj
         TwDwSNSvLW1XQrxiOGIc9iUppvbsphFiShxlKpvtH08Rw0nf3uitJnn2/7bWGv71QAd/
         XxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126719; x=1690718719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAapxjBD/rwbhfxji86yGKwLK1ac+lCSTHoejUz0sCA=;
        b=hdrOumT2+IiMZcxVKe3/Q0HZ7s+LjuBktmr44ddkPBDmc2C+lkKzc1G4nADdW7CM2R
         MBriTq1WK1tIUEi+8MiPm+0ufmhnilRS6QCknx5HyLoRjb39EHRrk6SDExZqo6lxqDQH
         PUo+Z40UAhix0SoevLUKgkAzZV8tAU4CdD+5rfmuYUh0AxH9Kgl80VH0vAZXkOZ27oiJ
         lJBgvfDixvSIpD0HwmCxcwiXuX0RhHnkP9I+g2vn+nPcml3M5QTMbGnxDfrNjq110qeZ
         mpKqJU0uN0oNkUpVvhcOegnuyWUPe7+vZIEO0pmwfzV8tRQm268okX0EaxiEJed06GFk
         GJHw==
X-Gm-Message-State: AC+VfDx7SqBLaFkw4vDBG8jT3fHBxmqWUD2RADOy74Lf/88id/FaZ7uJ
        hIPpleuViDpWjzywXIB270Cp7TGXTeIlyQ==
X-Google-Smtp-Source: ACHHUZ4FBzWCO79mHqc3NNlVCRxRufqe6utoDxt/Tyry73lyfuOkoJAyW7uH5d2LVhuuPH9K2VERcQ==
X-Received: by 2002:a05:600c:2902:b0:3fb:739d:27b2 with SMTP id i2-20020a05600c290200b003fb739d27b2mr1807622wmd.8.1688126719204;
        Fri, 30 Jun 2023 05:05:19 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:dbbb:7082:18ec:f407])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm11766912wmr.31.2023.06.30.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:05:18 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
Date:   Fri, 30 Jun 2023 13:04:32 +0100
Message-Id: <20230630120433.49529-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the missing port pins P19 to P28 for RZ/Five SoC. These additional pins
provide expanded capabilities and are exclusive to the RZ/Five SoC.
Furthermore, a new variant called r9a07g043_data has been introduced
specifically for the RZ/Five SoC. When CONFIG_RISCV is enabled, this
variant replaces the previous data configuration. Additionally, a new macro
named PIN_CFG_NOGPIO has been implemented. This macro serves as an
indicator to determine whether the port pins can be utilized as GPIO pins.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Please note that I have only included the necessary changes for PFC
settings in this paragraph. However, further work is required to set
the attributes of the pin. While we already have generic properties in
place for most of the attributes, setting the ISEL attribute for those
pins may require a specific property unique to Renesas. Alternatively,
is there a possibility of addressing this requirement in a different manner?
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 94 +++++++++++++++++++++----
 1 file changed, 82 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 2fc1b880db0c..61004733c2eb 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
+#include <linux/sys_soc.h>
 
 #include <linux/pinctrl/consumer.h>
 #include <linux/pinctrl/pinconf-generic.h>
@@ -53,6 +54,7 @@
 #define PIN_CFG_FILONOFF		BIT(10)
 #define PIN_CFG_FILNUM			BIT(11)
 #define PIN_CFG_FILCLKSEL		BIT(12)
+#define PIN_CFG_NOGPIO			BIT(13)
 
 #define RZG2L_MPXED_PIN_FUNCS		(PIN_CFG_IOLH_A | \
 					 PIN_CFG_SR | \
@@ -101,6 +103,12 @@
 #define SD_CH(n)		(0x3000 + (n) * 4)
 #define QSPI			(0x3008)
 
+#define RZFIVE_P_EX(n)		(0x0000 + 0x06 + ((n) - 19))
+#define RZFIVE_PM_EX(n)		(0x0100 + 0x0c + ((n) - 19) * 2)
+#define RZFIVE_PMC_EX(n)	(0x0200 + 0x06 + ((n) - 19))
+#define RZFIVE_PFC_EX(n)	(0x0400 + 0x18 + ((n) - 19) * 4)
+#define RZFIVE_PIN_EX(n)	(0x0800 + 0x06 + ((n) - 19))
+
 #define PVDD_1800		1	/* I/O domain voltage <= 1.8V */
 #define PVDD_3300		0	/* I/O domain voltage >= 3.3V */
 
@@ -160,39 +168,53 @@ struct rzg2l_pinctrl {
 static const unsigned int iolh_groupa_mA[] = { 2, 4, 8, 12 };
 static const unsigned int iolh_groupb_oi[] = { 100, 66, 50, 33 };
 
+static const struct soc_device_attribute rzfive_match[] = {
+	{ .family = "RZ/Five" },
+	{ /* sentinel */}
+};
+
 static void rzg2l_pinctrl_set_pfc_mode(struct rzg2l_pinctrl *pctrl,
 				       u8 port, u8 pin, u8 func)
 {
+	u32 pm_offset = PM(port);
+	u32 pmc_offset = PMC(port);
+	u32 pfc_offset = PFC(port);
 	unsigned long flags;
 	u32 reg;
 
+	if (soc_device_match(rzfive_match) && port > 18) {
+		pm_offset = RZFIVE_PM_EX(port);
+		pmc_offset = RZFIVE_PMC_EX(port);
+		pfc_offset = RZFIVE_PFC_EX(port);
+	}
+
 	spin_lock_irqsave(&pctrl->lock, flags);
 
 	/* Set pin to 'Non-use (Hi-Z input protection)'  */
-	reg = readw(pctrl->base + PM(port));
+	reg = readw(pctrl->base + pm_offset);
 	reg &= ~(PM_MASK << (pin * 2));
-	writew(reg, pctrl->base + PM(port));
+	writew(reg, pctrl->base + pm_offset);
 
 	/* Temporarily switch to GPIO mode with PMC register */
-	reg = readb(pctrl->base + PMC(port));
-	writeb(reg & ~BIT(pin), pctrl->base + PMC(port));
+	reg = readb(pctrl->base + pmc_offset);
+	writeb(reg & ~BIT(pin), pctrl->base + pmc_offset);
 
 	/* Set the PWPR register to allow PFC register to write */
 	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
 	writel(PWPR_PFCWE, pctrl->base + PWPR);  /* B0WI=0, PFCWE=1 */
 
 	/* Select Pin function mode with PFC register */
-	reg = readl(pctrl->base + PFC(port));
+	reg = readl(pctrl->base + pfc_offset);
 	reg &= ~(PFC_MASK << (pin * 4));
-	writel(reg | (func << (pin * 4)), pctrl->base + PFC(port));
+	writel(reg | (func << (pin * 4)), pctrl->base + pfc_offset);
 
 	/* Set the PWPR register to be write-protected */
 	writel(0x0, pctrl->base + PWPR);        /* B0WI=0, PFCWE=0 */
 	writel(PWPR_B0WI, pctrl->base + PWPR);  /* B0WI=1, PFCWE=0 */
 
 	/* Switch to Peripheral pin function with PMC register */
-	reg = readb(pctrl->base + PMC(port));
-	writeb(reg | BIT(pin), pctrl->base + PMC(port));
+	reg = readb(pctrl->base + pmc_offset);
+	writeb(reg | BIT(pin), pctrl->base + pmc_offset);
 
 	spin_unlock_irqrestore(&pctrl->lock, flags);
 };
@@ -447,12 +469,15 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 }
 
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
-				   u64 cfg, u32 port, u8 bit)
+				   u64 cfg, u32 port, u8 bit, bool pfc)
 {
 	u32 port_index = RZG2L_GPIO_PORT_GET_INDEX(cfg);
 	u8 pinmap = RZG2L_GPIO_PORT_GET_PINMAP(cfg);
 	u64 data;
 
+	if (!pfc && (cfg & PIN_CFG_NOGPIO))
+		return -EINVAL;
+
 	if (port >= pctrl->data->n_port_pins)
 		return -EINVAL;
 
@@ -526,7 +551,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
-		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
+		if (rzg2l_validate_gpio_pin(pctrl, *pin_data,
+					    RZG2L_PIN_ID_TO_PORT(_pin), bit, true))
 			return -EINVAL;
 	}
 
@@ -617,7 +643,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 		port_offset = RZG2L_PIN_ID_TO_PORT_OFFSET(_pin);
 		bit = RZG2L_PIN_ID_TO_PIN(_pin);
 
-		if (rzg2l_validate_gpio_pin(pctrl, *pin_data, RZG2L_PIN_ID_TO_PORT(_pin), bit))
+		if (rzg2l_validate_gpio_pin(pctrl, *pin_data,
+					    RZG2L_PIN_ID_TO_PORT(_pin), bit, true))
 			return -EINVAL;
 	}
 
@@ -788,7 +815,7 @@ static int rzg2l_gpio_request(struct gpio_chip *chip, unsigned int offset)
 	u8 reg8;
 	int ret;
 
-	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit);
+	ret = rzg2l_validate_gpio_pin(pctrl, *pin_data, port, bit, false);
 	if (ret)
 		return ret;
 
@@ -1050,6 +1077,38 @@ static const u64 r9a07g043_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x22, RZG2L_MPXED_PIN_FUNCS),
 };
 
+static const u64 r9a07g043f_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x10, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x13, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x14, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x15, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x16, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x17, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x18, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x19, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x1a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x1b, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x1d, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x1e, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x1f, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x20, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x21, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x22, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x02, 1, 0x06, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
+	RZG2L_GPIO_PORT_PACK(0xff, 8, 0x07, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
+	RZG2L_GPIO_PORT_PACK(0x02, 1, 0x08, (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOGPIO)),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x09, (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOGPIO)),
+	RZG2L_GPIO_PORT_PACK(0x3e, 5, 0x0a, (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_PUPD | PIN_CFG_NOGPIO)),
+	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x0b, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
+	RZG2L_GPIO_PORT_PACK(0x02, 1, 0x0c, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
+	RZG2L_GPIO_PORT_PACK(0x00, 0, 0x0d, 0x0),
+	RZG2L_GPIO_PORT_PACK(0x00, 0, 0x0e, 0x0),
+	RZG2L_GPIO_PORT_PACK(0x3f, 6, 0x0f, RZG2L_MPXED_PIN_FUNCS | PIN_CFG_NOGPIO),
+};
+
 static struct {
 	struct rzg2l_dedicated_configs common[35];
 	struct rzg2l_dedicated_configs rzg2l_pins[7];
@@ -1534,6 +1593,16 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_RISCV
+static struct rzg2l_pinctrl_data r9a07g043_data = {
+	.port_pins = rzg2l_gpio_names,
+	.port_pin_configs = r9a07g043f_gpio_configs,
+	.n_ports = ARRAY_SIZE(r9a07g043f_gpio_configs),
+	.dedicated_pins = rzg2l_dedicated_pins.common,
+	.n_port_pins = ARRAY_SIZE(r9a07g043f_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
+};
+#else
 static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = r9a07g043_gpio_configs,
@@ -1542,6 +1611,7 @@ static struct rzg2l_pinctrl_data r9a07g043_data = {
 	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
 	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
 };
+#endif
 
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
-- 
2.34.1

