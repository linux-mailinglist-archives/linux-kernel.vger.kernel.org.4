Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33BC67D8AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjAZWk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjAZWkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:40:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE1959EF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:40:50 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g16so2659847qtu.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2rA8r1vRndMpn7srMUnFhgGhzOj7xn+WluRQ5bsA4A=;
        b=hHESNKH7+BH8Nu6BjIYJ1gEOlbYflfEjHQTILo/jF9vJ24+b9od0zBE14J4xQFcLY3
         570w3EbkvYhJ6W6QNzYBZiYfNEpRSk5ISk7VFtj2ZQ8y8bCu7pK5O0yZvyBKfByZ+ZQH
         7TgTNM63gtWTvMVYQtszzKp6k2mTwdSoJITlW71be9pe5gshJLuQDUmzM0m5KwIHqZ7e
         hqdna5h4VYG9nze0xfCm9pS3L2N5Wf/60d8MQncN9Dc3TfY7bdJCiP9yzWTws1vQWWBl
         q0KnJVuQV28Nx7Warw6RzYL32H4ILV+HP6dVIc8L+f295HLtZDiGCD1Z9CQr6W1TnrRN
         eZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2rA8r1vRndMpn7srMUnFhgGhzOj7xn+WluRQ5bsA4A=;
        b=N7PfABJ6t06hZLz2RhnAWilIuWO4/sKkhkUoIOoBlr3RgI3ILxINXmtkKEfpxBRVjz
         79Lu4+fiudcdBiP5LLrFM+guhvZQ6d2p9vS2jaQfhdCXBmd0uugnLbo/8X2zr/CNo+8x
         TBtF2gFmHnXls2kvhgc/J9Th1CcverahA0flHx5MWhprsCDH83eyrYhwo1Hu4cJTBOsa
         kH/yXWX2g9rmEdKgUp6NjgaO2bHMRnuXFsBcEfbGxKX0DGwwhiNYLgrf/OUnnFQzDumn
         9KoAxzypvRQbfTKxx+W7RewDa2llbNu5TYpSJSfgx5SmsDF0SySuCNY1bbGadATPVpja
         av9A==
X-Gm-Message-State: AO0yUKVyB76ZJfEl6oAwVZlmb5lJYKJM2VXYI6fonE39Zz1lIQI6lJEF
        6CVk5Q6nB2/wggAhb1J8FpDiHg==
X-Google-Smtp-Source: AK7set8GglUb+KEVnfGXMRMLas1z0r+f5X6T17D+/o2O+yJbBD8eW/ls/xC0KZWyWzTd5/h3P3samQ==
X-Received: by 2002:a05:622a:1443:b0:3b6:3697:63fa with SMTP id v3-20020a05622a144300b003b6369763famr14779135qtx.28.1674772849326;
        Thu, 26 Jan 2023 14:40:49 -0800 (PST)
Received: from [127.0.1.1] (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id ek3-20020a05622a4fc300b003b68ea3d5c8sm1505678qtb.41.2023.01.26.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 14:40:49 -0800 (PST)
From:   Jonathan Cormier <jcormier@criticallink.com>
Date:   Thu, 26 Jan 2023 17:40:43 -0500
Subject: [PATCH v2 2/4] drm/bridge: tfp410: Support basic I2C interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-tfp410_i2c-v2-2-bf22f4dcbcea@criticallink.com>
References: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
In-Reply-To: <20230125-tfp410_i2c-v2-0-bf22f4dcbcea@criticallink.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Williamson <michael.williamson@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6492;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=XWThcU4Z36mFj7a764RgSd+QtYAddWcIDsaMnqm/1io=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBj0wFu0nfKBjU/FSlWT9m7wefZDzy53qLToZJ8CX3h
 sOGelZiJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCY9MBbgAKCRDc1/0uCzbrqrUyEA
 Cwzc7d7tH3He5RfIoqtNRKHNlpzLiqb+DN3hWjuxmtdV6827n8KvFm0Lb+SF+sPatVzSBXeOU5mU1g
 O0cH4tc7c1qI2RLXUuRwE3Hex0C2uaAYbvZWJVs2qKlntORGaLSXsrskNYvWypvK5bY9jcoPbgPrsS
 oLkJmii6cVXvHd3ojIEabzlJWcWD80G4lpdEQRqlODSahDKY4v54juDzf2WlzBn71Y9K+sWZRevPAi
 zSOktGGRovRs3O/BR5dsv/zChqLpUvw9EnRep9gsFGyyQvNFnJ4rxNENiu6OQR4zmhOixDgCYl0St7
 uBLZ4WOzLcMUSgq3NyYxux9Y2ZkmCNLjfKtWjKHhaYcPKw5TG9HkTvyYKy+m2bcsv82CMP2A/7svM2
 k5o2IvUcOnp8fH5+7HUMrdLfimrKEAVSPqkbMSxrl7I0p2RDLF999YrOXXGe/itrP/kfI12/IL6rKq
 4wJP6uP02GD70ybGh130Si9h7ej+AAT0xY9XEc850WyLW8jyyPFT1rm5sW6YY96HdmeFlARsFJ/Wd5
 HNZNcqAuKMZFdvI4tMf1nbGjIV/cJ4f03Juny0Sb7aGlDND9vuP4iaJhBbCZr1yGDH9TggXYjXUiIk
 HKf0R214Jih07nEXPyuYZsZp+p2MjoMUT/mWcz8vV2XRF+bGMk2kP9tbyDdA==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Williamson <michael.williamson@criticallink.com>

The TFP410 driver does not support I2C.  As such, the device remains in
Power Down if the I2C is enabled by the bootstrap pins.

Add basic support for the I2C interface, and provide support to take
the device out of power down when enabled.  Also read the bootstrap mode
pins via the CTL_1_MODE register when using the I2C bus.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 93 +++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index b9635abbad16..bb3f8d0ff207 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -6,6 +6,7 @@
 
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
+#include <linux/regmap.h>
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
@@ -21,6 +22,20 @@
 
 #define HOTPLUG_DEBOUNCE_MS		1100
 
+#define TFP410_REG_CTL_1_MODE	0x08
+#define TFP410_BIT_PD   BIT(0)
+#define TFP410_BIT_EDGE BIT(1)
+#define TFP410_BIT_BSEL BIT(2)
+#define TFP410_BIT_DSEL BIT(3)
+
+static const struct regmap_config tfp410_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = 0xff,
+	.cache_type = REGCACHE_NONE,
+};
+
 struct tfp410 {
 	struct drm_bridge	bridge;
 	struct drm_connector	connector;
@@ -33,6 +48,8 @@ struct tfp410 {
 	struct drm_bridge	*next_bridge;
 
 	struct device *dev;
+	struct i2c_client *i2c;
+	struct regmap *regmap;
 };
 
 static inline struct tfp410 *
@@ -183,6 +200,9 @@ static void tfp410_enable(struct drm_bridge *bridge)
 {
 	struct tfp410 *dvi = drm_bridge_to_tfp410(bridge);
 
+	if (dvi->i2c)
+		regmap_set_bits(dvi->regmap, TFP410_REG_CTL_1_MODE, TFP410_BIT_PD);
+
 	gpiod_set_value_cansleep(dvi->powerdown, 0);
 }
 
@@ -190,6 +210,9 @@ static void tfp410_disable(struct drm_bridge *bridge)
 {
 	struct tfp410 *dvi = drm_bridge_to_tfp410(bridge);
 
+	if (dvi->i2c)
+		regmap_clear_bits(dvi->regmap, TFP410_REG_CTL_1_MODE, TFP410_BIT_PD);
+
 	gpiod_set_value_cansleep(dvi->powerdown, 1);
 }
 
@@ -221,38 +244,48 @@ static const struct drm_bridge_timings tfp410_default_timings = {
 	.hold_time_ps = 1300,
 };
 
-static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
+static int tfp410_parse_timings(struct tfp410 *dvi)
 {
 	struct drm_bridge_timings *timings = &dvi->timings;
 	struct device_node *ep;
 	u32 pclk_sample = 0;
 	u32 bus_width = 24;
 	u32 deskew = 0;
+	unsigned int val = 0;
+	int ret = 0;
 
 	/* Start with defaults. */
 	*timings = tfp410_default_timings;
 
-	if (i2c)
+	if (dvi->i2c) {
 		/*
-		 * In I2C mode timings are configured through the I2C interface.
-		 * As the driver doesn't support I2C configuration yet, we just
-		 * go with the defaults (BSEL=1, DSEL=1, DKEN=0, EDGE=1).
+		 * For now, assume settings are latched from pins on reset / power up.
+		 * Should add options to optionally set them out of DT properties.
 		 */
-		return 0;
-
-	/*
-	 * In non-I2C mode, timings are configured through the BSEL, DSEL, DKEN
-	 * and EDGE pins. They are specified in DT through endpoint properties
-	 * and vendor-specific properties.
-	 */
-	ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
-	if (!ep)
-		return -EINVAL;
-
-	/* Get the sampling edge from the endpoint. */
-	of_property_read_u32(ep, "pclk-sample", &pclk_sample);
-	of_property_read_u32(ep, "bus-width", &bus_width);
-	of_node_put(ep);
+		ret = regmap_read(dvi->regmap, TFP410_REG_CTL_1_MODE, &val);
+		if (ret) {
+			dev_err(dvi->dev, "Read failed on CTL_1_MODE\n");
+			return ret;
+		}
+		pclk_sample = (val & TFP410_BIT_EDGE) ? 1 : 0;
+		bus_width = (val & TFP410_BIT_BSEL) ? 24 : 12;
+		dev_dbg(dvi->dev, "(0x%02X) : detected %d bus width, %s edge sampling\n",
+			val, bus_width, pclk_sample ? "positive" : "negative");
+	} else {
+		/*
+		 * In non-I2C mode, timings are configured through the BSEL, DSEL, DKEN
+		 * and EDGE pins. They are specified in DT through endpoint properties
+		 * and vendor-specific properties.
+		 */
+		ep = of_graph_get_endpoint_by_regs(dvi->dev->of_node, 0, 0);
+		if (!ep)
+			return -EINVAL;
+
+		/* Get the sampling edge from the endpoint. */
+		of_property_read_u32(ep, "pclk-sample", &pclk_sample);
+		of_property_read_u32(ep, "bus-width", &bus_width);
+		of_node_put(ep);
+	}
 
 	timings->input_bus_flags = DRM_BUS_FLAG_DE_HIGH;
 
@@ -291,7 +324,7 @@ static int tfp410_parse_timings(struct tfp410 *dvi, bool i2c)
 	return 0;
 }
 
-static int tfp410_init(struct device *dev, bool i2c)
+static int tfp410_init(struct device *dev, struct i2c_client *i2c)
 {
 	struct device_node *node;
 	struct tfp410 *dvi;
@@ -313,15 +346,24 @@ static int tfp410_init(struct device *dev, bool i2c)
 	dvi->bridge.of_node = dev->of_node;
 	dvi->bridge.timings = &dvi->timings;
 	dvi->bridge.type = DRM_MODE_CONNECTOR_DVID;
+	dvi->i2c = i2c;
+
+	if (i2c) {
+		dvi->regmap = devm_regmap_init_i2c(i2c, &tfp410_regmap_config);
+		if (IS_ERR(dvi->regmap))
+			return PTR_ERR(dvi->regmap);
+	}
 
-	ret = tfp410_parse_timings(dvi, i2c);
+	ret = tfp410_parse_timings(dvi);
 	if (ret)
 		return ret;
 
 	/* Get the next bridge, connected to port@1. */
 	node = of_graph_get_remote_node(dev->of_node, 1, -1);
-	if (!node)
+	if (!node) {
+		dev_err(dev, "Could not find remote node\n");
 		return -ENODEV;
+	}
 
 	dvi->next_bridge = of_drm_find_bridge(node);
 	of_node_put(node);
@@ -352,7 +394,7 @@ static void tfp410_fini(struct device *dev)
 
 static int tfp410_probe(struct platform_device *pdev)
 {
-	return tfp410_init(&pdev->dev, false);
+	return tfp410_init(&pdev->dev, NULL);
 }
 
 static int tfp410_remove(struct platform_device *pdev)
@@ -378,7 +420,6 @@ static struct platform_driver tfp410_platform_driver = {
 };
 
 #if IS_ENABLED(CONFIG_I2C)
-/* There is currently no i2c functionality. */
 static int tfp410_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
@@ -391,7 +432,7 @@ static int tfp410_i2c_probe(struct i2c_client *client,
 		return -ENXIO;
 	}
 
-	return tfp410_init(&client->dev, true);
+	return tfp410_init(&client->dev, client);
 }
 
 static void tfp410_i2c_remove(struct i2c_client *client)

-- 
2.25.1

