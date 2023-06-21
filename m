Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271CC738147
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFUJcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjFUJbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:31:18 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C2319AF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3112f256941so3627681f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687339874; x=1689931874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9i7Uk9aCK3lESxenmpxDJxkyZ2pr8k/0UfT23fdTCU=;
        b=HMgfcToT+99atd0bEiOKT3uanwqjHO/q5VjUGAtCm8HErnMups9azwMX8fcFcKdIQl
         6lyWoxMdiAxsrjuZTTGn98YG1dCeeQRiGOqr6gcjASDjukONjjHPxvtsQfhUiVcBIDcY
         EhtHaUF0BIw8TWhppvIrNxdkl48e7fD9VY+rn6oEwpktSkLwEeiq5G3B+KIle89b2Q8+
         UTI0aXxydtrWn6JMb2tGM/tdzMRShsIpVFgravjjptsWm3WaWZxCU1BvlU75zWFr2llR
         vNltpYb/766oVwx5ICst7gjtM02ZNO79qA822hHN0W0MyEPHUzfKsTiIWeX3RXkHxh+8
         wmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687339874; x=1689931874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9i7Uk9aCK3lESxenmpxDJxkyZ2pr8k/0UfT23fdTCU=;
        b=kLDFXVkVSdTw3VzbChcBPDZq6/jCflqhHKXwpmFzbByHJbdXvQlQnGyel/5mAMkPjZ
         un/sesB+w86GUBZYQn2qFZ8qV/MDZm3uUcFHKnMy7Hu+iuap2e0MNKNRtAlRjOg77uq5
         xggiNtKtn1KYXcGeBYF2g6A3T2cktuZri8W/He1DG7rzW/PgUa8JP7oMDsm0D1hI4Pzw
         yY6XkZwOJC5Pgl5CICx0SglKZCSXk5k5QN4CyVjN7S/fiw5N7ZP53o9wevlMhkteT6yA
         qiCOp7+S8+EaSKLnaK1kSemGpkdnojWn6rGmQGNWES9Nxi7gV9m298hChGcNjbxgn1Ue
         eqpg==
X-Gm-Message-State: AC+VfDz5l3uLeEhjEmwC6f3iq91RJN36nGRzmT7um/3UcCz9pZ6ItDNu
        0r0Gc1rLxNx4jXPZ6RNX4ZYflg==
X-Google-Smtp-Source: ACHHUZ7Pu7OaqYZZMO9Cjox1GAG9gZTMhbuui5bdyWhgpv6HpGu/DrL+U5iPrc3XAkpwSKqppaw1rw==
X-Received: by 2002:adf:e489:0:b0:311:d3c:df0 with SMTP id i9-20020adfe489000000b003110d3c0df0mr9514734wrm.43.1687339874666;
        Wed, 21 Jun 2023 02:31:14 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b002fe96f0b3acsm3977344wrs.63.2023.06.21.02.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:31:14 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Date:   Wed, 21 Jun 2023 11:31:02 +0200
Message-Id: <20230621093103.3134655-6-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230621093103.3134655-1-msp@baylibre.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcan4552 and tcan4553 do not have wake or state pins, so they are
currently not compatible with the generic driver. The generic driver
uses tcan4x5x_disable_state() and tcan4x5x_disable_wake() if the gpios
are not defined. These functions use register bits that are not
available in tcan4552/4553.

This patch adds support by introducing version information to reflect if
the chip has wake and state pins. Also the version is now checked.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 128 +++++++++++++++++++++-----
 1 file changed, 104 insertions(+), 24 deletions(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index fb9375fa20ec..756acd122075 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -7,6 +7,7 @@
 #define TCAN4X5X_EXT_CLK_DEF 40000000
 
 #define TCAN4X5X_DEV_ID1 0x00
+#define TCAN4X5X_DEV_ID1_TCAN 0x4e414354 /* ASCII TCAN */
 #define TCAN4X5X_DEV_ID2 0x04
 #define TCAN4X5X_REV 0x08
 #define TCAN4X5X_STATUS 0x0C
@@ -103,6 +104,13 @@
 #define TCAN4X5X_WD_3_S_TIMER BIT(29)
 #define TCAN4X5X_WD_6_S_TIMER (BIT(28) | BIT(29))
 
+struct tcan4x5x_version_info {
+	u32 id2_register;
+
+	bool has_wake_pin;
+	bool has_state_pin;
+};
+
 static inline struct tcan4x5x_priv *cdev_to_priv(struct m_can_classdev *cdev)
 {
 	return container_of(cdev, struct tcan4x5x_priv, cdev);
@@ -254,18 +262,68 @@ static int tcan4x5x_disable_state(struct m_can_classdev *cdev)
 				  TCAN4X5X_DISABLE_INH_MSK, 0x01);
 }
 
-static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
+static const struct tcan4x5x_version_info tcan4x5x_generic;
+static const struct of_device_id tcan4x5x_of_match[];
+
+static const struct tcan4x5x_version_info
+*tcan4x5x_find_version_info(struct tcan4x5x_priv *priv, u32 id2_value)
+{
+	for (int i = 0; tcan4x5x_of_match[i].data; ++i) {
+		const struct tcan4x5x_version_info *vinfo =
+			tcan4x5x_of_match[i].data;
+		if (!vinfo->id2_register || id2_value == vinfo->id2_register) {
+			dev_warn(&priv->spi->dev, "TCAN device is %s, please use it in DT\n",
+				 tcan4x5x_of_match[i].compatible);
+			return vinfo;
+		}
+	}
+
+	return &tcan4x5x_generic;
+}
+
+static int tcan4x5x_verify_version(struct tcan4x5x_priv *priv,
+				   const struct tcan4x5x_version_info **info)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, TCAN4X5X_DEV_ID1, &val);
+	if (ret)
+		return ret;
+
+	if (val != TCAN4X5X_DEV_ID1_TCAN) {
+		dev_err(&priv->spi->dev, "Not a tcan device %x\n", val);
+		return -ENODEV;
+	}
+
+	if (!(*info)->id2_register)
+		return 0;
+
+	ret = regmap_read(priv->regmap, TCAN4X5X_DEV_ID2, &val);
+	if (ret)
+		return ret;
+
+	if ((*info)->id2_register != val)
+		*info = tcan4x5x_find_version_info(priv, val);
+
+	return 0;
+}
+
+static int tcan4x5x_get_gpios(struct m_can_classdev *cdev,
+			      const struct tcan4x5x_version_info *version_info)
 {
 	struct tcan4x5x_priv *tcan4x5x = cdev_to_priv(cdev);
 	int ret;
 
-	tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
-						    GPIOD_OUT_HIGH);
-	if (IS_ERR(tcan4x5x->device_wake_gpio)) {
-		if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+	if (version_info->has_wake_pin) {
+		tcan4x5x->device_wake_gpio = devm_gpiod_get(cdev->dev, "device-wake",
+							    GPIOD_OUT_HIGH);
+		if (IS_ERR(tcan4x5x->device_wake_gpio)) {
+			if (PTR_ERR(tcan4x5x->device_wake_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 
-		tcan4x5x_disable_wake(cdev);
+			tcan4x5x_disable_wake(cdev);
+		}
 	}
 
 	tcan4x5x->reset_gpio = devm_gpiod_get_optional(cdev->dev, "reset",
@@ -277,12 +335,14 @@ static int tcan4x5x_get_gpios(struct m_can_classdev *cdev)
 	if (ret)
 		return ret;
 
-	tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
-							      "device-state",
-							      GPIOD_IN);
-	if (IS_ERR(tcan4x5x->device_state_gpio)) {
-		tcan4x5x->device_state_gpio = NULL;
-		tcan4x5x_disable_state(cdev);
+	if (version_info->has_state_pin) {
+		tcan4x5x->device_state_gpio = devm_gpiod_get_optional(cdev->dev,
+								      "device-state",
+								      GPIOD_IN);
+		if (IS_ERR(tcan4x5x->device_state_gpio)) {
+			tcan4x5x->device_state_gpio = NULL;
+			tcan4x5x_disable_state(cdev);
+		}
 	}
 
 	return 0;
@@ -299,10 +359,15 @@ static struct m_can_ops tcan4x5x_ops = {
 
 static int tcan4x5x_can_probe(struct spi_device *spi)
 {
+	const struct tcan4x5x_version_info *version_info;
 	struct tcan4x5x_priv *priv;
 	struct m_can_classdev *mcan_class;
 	int freq, ret;
 
+	version_info = of_device_get_match_data(&spi->dev);
+	if (!version_info)
+		version_info = (void *)spi_get_device_id(spi)->driver_data;
+
 	mcan_class = m_can_class_allocate_dev(&spi->dev,
 					      sizeof(struct tcan4x5x_priv));
 	if (!mcan_class)
@@ -361,7 +426,11 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 	if (ret)
 		goto out_m_can_class_free_dev;
 
-	ret = tcan4x5x_get_gpios(mcan_class);
+	ret = tcan4x5x_verify_version(priv, &version_info);
+	if (ret)
+		goto out_power;
+
+	ret = tcan4x5x_get_gpios(mcan_class, version_info);
 	if (ret)
 		goto out_power;
 
@@ -394,21 +463,32 @@ static void tcan4x5x_can_remove(struct spi_device *spi)
 	m_can_class_free_dev(priv->cdev.net);
 }
 
+static const struct tcan4x5x_version_info tcan4x5x_generic = {
+	.has_state_pin = true,
+	.has_wake_pin = true,
+};
+
+static const struct tcan4x5x_version_info tcan4x5x_tcan4552 = {
+	.id2_register = 0x32353534, /* ASCII = 4552 */
+};
+
+static const struct tcan4x5x_version_info tcan4x5x_tcan4553 = {
+	.id2_register = 0x33353534, /* ASCII = 4553 */
+};
+
 static const struct of_device_id tcan4x5x_of_match[] = {
-	{
-		.compatible = "ti,tcan4x5x",
-	}, {
-		/* sentinel */
-	},
+	{ .compatible = "ti,tcan4552", .data = &tcan4x5x_tcan4552 },
+	{ .compatible = "ti,tcan4553", .data = &tcan4x5x_tcan4553 },
+	{ .compatible = "ti,tcan4x5x", .data = &tcan4x5x_generic },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tcan4x5x_of_match);
 
 static const struct spi_device_id tcan4x5x_id_table[] = {
-	{
-		.name = "tcan4x5x",
-	}, {
-		/* sentinel */
-	},
+	{ .name = "tcan4x5x", .driver_data = (unsigned long)&tcan4x5x_generic, },
+	{ .name = "tcan4552", .driver_data = (unsigned long)&tcan4x5x_tcan4552, },
+	{ .name = "tcan4553", .driver_data = (unsigned long)&tcan4x5x_tcan4553, },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, tcan4x5x_id_table);
 
-- 
2.40.1

