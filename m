Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061CB5B97D9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiIOJqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiIOJpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:45:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D917E806;
        Thu, 15 Sep 2022 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663235135; x=1694771135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yir8sOB3cIJ+v8+fyCMR0QkfizXk9GkcT8rpd1Qbm2k=;
  b=119l48cKQCO0//BMf2m9cZ34LS3uxtwNIk47mt6+hZBUcvkmZTnbOgUH
   dycv9jH8Qe9P+jjeH5fA3VadAEuTakdNWnSvd66e9oNwpJ//zji9OqdAk
   ESU5aEYRt5tq8cYrN0uHTN9INlE4HHECZCq+2SRaaJ22YjPIPJVuK66t9
   uNxpjbOqu/67NEfHbmJVZxeaRv9DKxI8VXbKclG76k1Bat/tsLmZRa4Lm
   RJJXF6vRN2IxcCoNI3NCVBqTOa9BUq+FKsK66ecbHf+iwiLxzfkYszrQc
   ywW/3aSjSk45yg2HaDGPak0Egenn+IrTtBtXASa0aT0I16Z9edpSoFxu4
   A==;
X-IronPort-AV: E=Sophos;i="5.93,317,1654585200"; 
   d="scan'208";a="180492722"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 02:45:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 02:45:29 -0700
Received: from kavya.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 02:45:25 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <lee@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [RESEND PATCH v8 3/3] mfd: atmel-flexcom: Add support for lan966x flexcom chip-select configuration
Date:   Thu, 15 Sep 2022 07:44:53 -0200
Message-ID: <20220915094453.1872798-4-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
References: <20220915094453.1872798-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN966x SoC have 5 flexcoms. Each flexcom has 2 chip-selects
which are optional I/O lines. For each chip select of each
flexcom there is a configuration register FLEXCOM_SHARED[0-4]:SS_MASK[0-1].
The width of configuration register is 21 because there are
21 shared pins on each of which the chip select can be mapped.
Each bit of the register represents a different FLEXCOM_SHARED pin.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
v7 -> v8:
 - Changed compatible string to microchip,lan9668-flexcom.

v6 -> v7:
 - No changes.

v5 -> v6:
 - No changes.

v4 -> v5:
 - No changes.

v3 -> v4:
 - Add condition for a flexcom whether to configure chip-select lines
   or not, based on "microchip,flx-shrd-pins" property existence because
   chip-select lines are optional.

v2 -> v3:
 - used goto label for clk_disable in error cases.

v1 -> v2:
 - use GENMASK for mask, macros for maximum allowed values.
 - use u32 values for flexcom chipselects instead of strings.
 - disable clock in case of errors.

 drivers/mfd/atmel-flexcom.c | 94 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
index 33caa4fba6af..92ea15d5fd72 100644
--- a/drivers/mfd/atmel-flexcom.c
+++ b/drivers/mfd/atmel-flexcom.c
@@ -28,15 +28,68 @@
 #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
 				 FLEX_MR_OPMODE_MASK)
 
+/* LAN966x flexcom shared register offsets */
+#define FLEX_SHRD_SS_MASK_0	0x0
+#define FLEX_SHRD_SS_MASK_1	0x4
+#define FLEX_SHRD_PIN_MAX	20
+#define FLEX_CS_MAX		1
+#define FLEX_SHRD_MASK		GENMASK(20, 0)
+
+struct atmel_flex_caps {
+	bool has_flx_cs;
+};
+
 struct atmel_flexcom {
 	void __iomem *base;
+	void __iomem *flexcom_shared_base;
 	u32 opmode;
 	struct clk *clk;
 };
 
+static int atmel_flexcom_lan966x_cs_config(struct platform_device *pdev)
+{
+	struct atmel_flexcom *ddata = dev_get_drvdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 flx_shrd_pins[2], flx_cs[2], val;
+	int err, i, count;
+
+	count = of_property_count_u32_elems(np, "microchip,flx-shrd-pins");
+	if (count <= 0 || count > 2) {
+		dev_err(&pdev->dev, "Invalid %s property (%d)\n", "flx-shrd-pins",
+				count);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32_array(np, "microchip,flx-shrd-pins", flx_shrd_pins, count);
+	if (err)
+		return err;
+
+	err = of_property_read_u32_array(np, "microchip,flx-cs", flx_cs, count);
+	if (err)
+		return err;
+
+	for (i = 0; i < count; i++) {
+		if (flx_shrd_pins[i] > FLEX_SHRD_PIN_MAX)
+			return -EINVAL;
+
+		if (flx_cs[i] > FLEX_CS_MAX)
+			return -EINVAL;
+
+		val = ~(1 << flx_shrd_pins[i]) & FLEX_SHRD_MASK;
+
+		if (flx_cs[i] == 0)
+			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_0);
+		else
+			writel(val, ddata->flexcom_shared_base + FLEX_SHRD_SS_MASK_1);
+	}
+
+	return 0;
+}
+
 static int atmel_flexcom_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	const struct atmel_flex_caps *caps;
 	struct resource *res;
 	struct atmel_flexcom *ddata;
 	int err;
@@ -76,13 +129,52 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
 	 */
 	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
 
+	caps = of_device_get_match_data(&pdev->dev);
+	if (!caps) {
+		dev_err(&pdev->dev, "Could not retrieve flexcom caps\n");
+		err = -EINVAL;
+		goto clk_disable;
+	}
+
+	if (caps->has_flx_cs && of_property_read_bool(np, "microchip,flx-shrd-pins")) {
+		ddata->flexcom_shared_base = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+		if (IS_ERR(ddata->flexcom_shared_base)) {
+			err = dev_err_probe(&pdev->dev,
+					PTR_ERR(ddata->flexcom_shared_base),
+					"failed to get flexcom shared base address\n");
+			goto clk_disable;
+		}
+
+		err = atmel_flexcom_lan966x_cs_config(pdev);
+		if (err)
+			goto clk_disable;
+	}
+
+clk_disable:
 	clk_disable_unprepare(ddata->clk);
+	if (err)
+		return err;
 
 	return devm_of_platform_populate(&pdev->dev);
 }
 
+static const struct atmel_flex_caps atmel_flexcom_caps = {};
+
+static const struct atmel_flex_caps lan966x_flexcom_caps = {
+	.has_flx_cs = true,
+};
+
 static const struct of_device_id atmel_flexcom_of_match[] = {
-	{ .compatible = "atmel,sama5d2-flexcom" },
+	{
+		.compatible = "atmel,sama5d2-flexcom",
+		.data = &atmel_flexcom_caps,
+	},
+
+	{
+		.compatible = "microchip,lan9668-flexcom",
+		.data = &lan966x_flexcom_caps,
+	},
+
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
-- 
2.25.1

