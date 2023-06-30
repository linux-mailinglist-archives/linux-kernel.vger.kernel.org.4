Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379C743B84
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 14:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjF3MGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 08:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjF3MGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 08:06:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A4B3C32;
        Fri, 30 Jun 2023 05:05:26 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so2759630e87.3;
        Fri, 30 Jun 2023 05:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688126717; x=1690718717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=samC88JToQJggQkwPP9LLv4m1XMmLyVNduLSuH7L0a8=;
        b=XyNzagDVD/naZSkDvfGdbA70OJsmTZFqdPh6Nr9bijz7op3b4yt7JA0T3D/rRXD502
         wAU1ZaPGpySUwosUCRSsBnpOZgiYN4rhWT1+w86IJxdIp4gIB8M04P5PMMtKPSJvpaqc
         rwRcM5SJ9bxpGGT8i0p2CU5LD+Fo/8dtlJBvUg0GJkYCMKV2Xx7YlUS9UePYChEl0Osm
         jGEn8JhZOCyDvfrK/6gxaDBUsD4ZhpSTxfUxc/htYHT5XZxHrmwOeNGQOjt1v/LQzc5N
         Cyx879x3kG2mDMLfVhu5TCh27NOXot+r5P7eHogD9ukPSwwLLRoVIZYeX/XD2an+1f0Y
         rHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126717; x=1690718717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=samC88JToQJggQkwPP9LLv4m1XMmLyVNduLSuH7L0a8=;
        b=KyE6iUxxRixHn1aaBa+i1Pe4FRMwZXaQzJgYPL41VIEgn8ECDF3JIPKf9NknWqtUk6
         jGeFI2h7Oxep1mxi6k9rAyn9719cak4JQ7pyrBzW8bPv7hwDZV9UfyxAujnnpM8/PXuB
         VtH2M5x6nvyx8Y/K763yxtVjmxwbxQX6YhfftfHl662Ex7cnJz9rSnCu3BcXJRG9i2Ec
         W7xjljB0GjxEx+nWcLGf0UtwpSMD298QgScq+wnoOrmNE8/F7CWpjB7tkjU8tBqAI9wW
         +y/yaFFSjCQzN4enu6b4OJaBKhqTlN85DsDj+iRmc58EqMtMu2BYKKtNRAcvvG6V/vV8
         MYQg==
X-Gm-Message-State: ABy/qLatJpTEmpAHvadEz3iOVIPBIuAi5a6jY60FVtyOMv7vhPLW5R/1
        CeyYqREE61hMGjE7B+ovTaM=
X-Google-Smtp-Source: APBJJlE3MQJuYMRXaNzEM2zttqvBq8/eyH6Ou3PiGuPN8WwweXXoi1zOQp6h43G3b9iibjKumF5ClQ==
X-Received: by 2002:a19:675a:0:b0:4f8:6d99:f4f3 with SMTP id e26-20020a19675a000000b004f86d99f4f3mr1919162lfj.52.1688126717020;
        Fri, 30 Jun 2023 05:05:17 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:dbbb:7082:18ec:f407])
        by smtp.gmail.com with ESMTPSA id k22-20020a05600c0b5600b003fb40f5f553sm11766912wmr.31.2023.06.30.05.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:05:16 -0700 (PDT)
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
Subject: [RFC PATCH 1/4] pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() macro
Date:   Fri, 30 Jun 2023 13:04:30 +0100
Message-Id: <20230630120433.49529-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230630120433.49529-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Currently we assume all the port pins are sequential ie always PX_0 to
PX_n (n=1..7) exist, but on RZ/Five SoC we have additional pins P19_1 to
P28_5 which have holes in them, for example only one pin on port19 is
available and that is P19_1 and not P19_0.

So to handle such cases include pinmap for each port which would indicate
the pin availability on each port. With this we also get additional pin
validation, for example on the RZ/G2L SOC P0 has two pins P0_1 and P0_0
but with DT/SYSFS could use the P0_2-P0_7.

While at it, update rzg2l_validate_gpio_pin() to use the port pinmap to
validate the gpio pin.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 167 ++++++++++++------------
 1 file changed, 86 insertions(+), 81 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 9511d920565e..a0c2e585e765 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -67,10 +67,12 @@
 					 PIN_CFG_FILCLKSEL)
 
 /*
- * n indicates number of pins in the port, a is the register index
- * and f is pin configuration capabilities supported.
+ * m indicates the bitmap of supported pins, n indicates number
+ * of pins in the port, a is the register index and f is pin
+ * configuration capabilities supported.
  */
-#define RZG2L_GPIO_PORT_PACK(n, a, f)	(((n) << 28) | ((a) << 20) | (f))
+#define RZG2L_GPIO_PORT_PACK(m, n, a, f)	((UL(m) << 32) | (UL(n) << 28) | ((a) << 20) | (f))
+#define RZG2L_GPIO_PORT_GET_PINMAP(x)	(((x) & GENMASK(39, 32)) >> 32)
 #define RZG2L_GPIO_PORT_GET_PINCNT(x)	(((x) & GENMASK(30, 28)) >> 28)
 #define RZG2L_GPIO_PORT_GET_INDEX(x)	(((x) & GENMASK(26, 20)) >> 20)
 #define RZG2L_GPIO_PORT_GET_CFGS(x)	((x) & GENMASK(19, 0))
@@ -129,7 +131,7 @@ struct rzg2l_dedicated_configs {
 
 struct rzg2l_pinctrl_data {
 	const char * const *port_pins;
-	const u32 *port_pin_configs;
+	const u64 *port_pin_configs;
 	unsigned int n_ports;
 	struct rzg2l_dedicated_configs *dedicated_pins;
 	unsigned int n_port_pins;
@@ -445,13 +447,16 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 }
 
 static int rzg2l_validate_gpio_pin(struct rzg2l_pinctrl *pctrl,
-				   u32 cfg, u32 port, u8 bit)
+				   u64 cfg, u32 port, u8 bit)
 {
-	u8 pincount = RZG2L_GPIO_PORT_GET_PINCNT(cfg);
 	u32 port_index = RZG2L_GPIO_PORT_GET_INDEX(cfg);
-	u32 data;
+	u8 pinmap = RZG2L_GPIO_PORT_GET_PINMAP(cfg);
+	u64 data;
 
-	if (bit >= pincount || port >= pctrl->data->n_port_pins)
+	if (port >= pctrl->data->n_port_pins)
+		return -EINVAL;
+
+	if (!(pinmap & BIT(bit)))
 		return -EINVAL;
 
 	data = pctrl->data->port_pin_configs[port];
@@ -501,7 +506,7 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	enum pin_config_param param = pinconf_to_config_param(*config);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	unsigned int arg = 0;
 	unsigned long flags;
 	void __iomem *addr;
@@ -591,7 +596,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 {
 	struct rzg2l_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
 	const struct pinctrl_pin_desc *pin = &pctrl->desc.pins[_pin];
-	unsigned int *pin_data = pin->drv_data;
+	u64 *pin_data = pin->drv_data;
 	enum pin_config_param param;
 	unsigned long flags;
 	void __iomem *addr;
@@ -965,78 +970,78 @@ static const char * const rzg2l_gpio_names[] = {
 	"P48_0", "P48_1", "P48_2", "P48_3", "P48_4", "P48_5", "P48_6", "P48_7",
 };
 
-static const u32 rzg2l_gpio_configs[] = {
-	RZG2L_GPIO_PORT_PACK(2, 0x10, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x11, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x12, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x13, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x14, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x15, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x16, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x17, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x18, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x19, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x21, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x22, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x23, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x28, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x29, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(3, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(2, 0x36, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x37, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x38, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x39, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
+static const u64 rzg2l_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x10, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x11, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x12, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x13, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x14, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x15, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x16, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x17, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x18, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x19, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1a, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1b, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x1d, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1e, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x1f, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x20, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x21, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x22, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x23, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x24, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x25, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x26, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x27, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x28, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x29, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2b, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2c, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2d, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2e, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x2f, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x30, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x31, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x32, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x33, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x34, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x35, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x36, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x37, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x07, 3, 0x38, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x03, 2, 0x39, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x3a, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3b, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3c, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3d, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3e, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x0f, 4, 0x3f, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(0x1f, 5, 0x40, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static const u32 r9a07g043_gpio_configs[] = {
-	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(4, 0x13, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(6, 0x14, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
-	RZG2L_GPIO_PORT_PACK(5, 0x15, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x16, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x17, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(5, 0x18, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(4, 0x19, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(5, 0x1a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
-	RZG2L_GPIO_PORT_PACK(4, 0x1b, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(5, 0x1d, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(3, 0x1e, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x1f, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(4, 0x21, RZG2L_MPXED_PIN_FUNCS),
-	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
+static const u64 r9a07g043_gpio_configs[] = {
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
 };
 
 static struct {
@@ -1396,7 +1401,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 {
 	struct pinctrl_pin_desc *pins;
 	unsigned int i, j;
-	u32 *pin_data;
+	u64 *pin_data;
 	int ret;
 
 	pctrl->desc.name = DRV_NAME;
-- 
2.34.1

