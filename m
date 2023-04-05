Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3866D7E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238468AbjDEOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbjDEODU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:03:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E27272AE;
        Wed,  5 Apr 2023 07:01:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so4118981wmb.3;
        Wed, 05 Apr 2023 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CFv3XBpVecjFAWjZh9EMMv7oN85dxMWirjY5MCFhvU=;
        b=WVIqZzsxIOJEdoj0PJDwxV1df1OqJEQyAhxFdT6lPYDCYxgpW+2PpQqKiAnco4k4OS
         TWisiU6ATOa+TSuCXloWUBKgWPgQdEsDHIoFVaZ7DQn/dqywAMAKvkf3l5OvqldEC0Q4
         FH9sst45KoVUNbnj4MFpySdgCurtB/AkNRg4yzvsXRFfQMOMasdZV+kxEyhXbKgY7wHd
         IdjbTzqfDCIvOgOvdEX4HOPZdu6BYONt7TV+sRzxvYJMXzJqBRfx2Tcqepz4MeVsMKIS
         OIjMsDkPmY8z+Shvmy2FOZmUE+EQiTy+Kg0DvWLsjZYIoa6O10eeJBEdMjoM+F6jP017
         LLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CFv3XBpVecjFAWjZh9EMMv7oN85dxMWirjY5MCFhvU=;
        b=lqSwgS9ZhTviV2puEAz748vTN7jhodzWyI//PT8uQHKOEHkMgzG0Xc1DZPt6NNIkhD
         FPJ0PTX9BwmFl2XbYDBEP0ETeYe2iPAeF+1DmirJmnY2SL4l0lc7MJF1C0ysqos9HGyK
         didlX9xbRPNar957EcFnIqnLjFI7HiO7e+lxgwFnYpjPQI0OjHpZt5dLCNxlB9q3slOO
         jnsHTAWukkOdwL5DukrMWNxqzVjIxVaApFcKy2erXxz/bvvbxBV2tfHobaI2roIbSs59
         VXg2lTLfYpoZQLIfDT0oi2Z3RuF+mJQVL5DJA2gmyL0h5VM7HmKOhhF6oGzBqLt45i0u
         XsnQ==
X-Gm-Message-State: AAQBX9etHo2Mvp0X9Sa51/W880yhMMLyI5QaiAMjHNuKI0ABoonQG/MK
        RN7+KWCD8IwVwgaAohSAdYnlP1ctLyc=
X-Google-Smtp-Source: AKy350aoBKQ5WcUBLLoMcISoYoLTHapk0BsZwpRzrmDuR0H3qdk5yJysE/7kWUnWXtOucbAX7Mr+Aw==
X-Received: by 2002:a1c:4c16:0:b0:3ee:1084:aa79 with SMTP id z22-20020a1c4c16000000b003ee1084aa79mr1724440wmf.20.1680703295301;
        Wed, 05 Apr 2023 07:01:35 -0700 (PDT)
Received: from archbox.v.cablecom.net (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b003edc4788fa0sm2412383wmq.2.2023.04.05.07.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:01:34 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: dac: mcp4922: add support for mcp48xx series chips
Date:   Wed,  5 Apr 2023 16:01:14 +0200
Message-Id: <20230405140114.99011-5-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
References: <20230405140114.99011-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MCP4801, MCP4802, MCP4811, MCP4812, MCP4821 and MCP4822
DACs are analogous to their MCP49XX counterparts, but contain
an internal 2.048V voltage reference. Add support for them by
refactoring the driver to allow for chips without a vref supply,
and add the necessary device IDs.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/iio/dac/mcp4922.c | 112 ++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
index 0b9458cbbcff..56dcb90c8464 100644
--- a/drivers/iio/dac/mcp4922.c
+++ b/drivers/iio/dac/mcp4922.c
@@ -3,7 +3,8 @@
  * mcp4922.c
  *
  * Driver for Microchip Digital to Analog Converters.
- * Supports MCP4902, MCP4912, and MCP4922.
+ * Supports MCP4902, MCP4912, MCP4921, MCP4922, MCP4801, MCP4802, MCP4811,
+ * MCP4812, MCP4821, and MCP4822.
  *
  * Copyright (c) 2014 EMAC Inc.
  */
@@ -16,14 +17,21 @@
 #include <linux/regulator/consumer.h>
 #include <linux/bitops.h>
 
-#define MCP4922_NUM_CHANNELS	2
-#define MCP4921_NUM_CHANNELS	1
+#define MCP4922_NUM_CHANNELS		2
+#define MCP4921_NUM_CHANNELS		1
+#define MCP48XX_INTERNAL_VREF_MV	2048
 
 enum mcp4922_supported_device_ids {
 	ID_MCP4902,
 	ID_MCP4912,
 	ID_MCP4921,
 	ID_MCP4922,
+	ID_MCP4801,
+	ID_MCP4802,
+	ID_MCP4811,
+	ID_MCP4812,
+	ID_MCP4821,
+	ID_MCP4822,
 };
 
 struct mcp4922_state {
@@ -50,6 +58,35 @@ struct mcp4922_state {
 	},						\
 }
 
+static bool mcp4922_needs_vref(int device_id)
+{
+	switch (device_id) {
+	case ID_MCP4902:
+	case ID_MCP4912:
+	case ID_MCP4921:
+	case ID_MCP4922:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int mcp4922_num_channels(int device_id)
+{
+	switch (device_id) {
+	case ID_MCP4902:
+	case ID_MCP4912:
+	case ID_MCP4922:
+	case ID_MCP4802:
+	case ID_MCP4812:
+	case ID_MCP4822:
+		return MCP4922_NUM_CHANNELS;
+	default:
+		return MCP4921_NUM_CHANNELS;
+	}
+
+}
+
 static int mcp4922_spi_write(struct mcp4922_state *state, u8 addr, u32 val)
 {
 	state->mosi[1] = val & 0xff;
@@ -108,11 +145,17 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static const struct iio_chan_spec mcp4922_channels[4][MCP4922_NUM_CHANNELS] = {
+static const struct iio_chan_spec mcp4922_channels[10][MCP4922_NUM_CHANNELS] = {
 	[ID_MCP4902] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
 	[ID_MCP4912] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
 	[ID_MCP4921] = { MCP4922_CHAN(0, 12),	{} },
 	[ID_MCP4922] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
+	[ID_MCP4801] = { MCP4922_CHAN(0, 8),	{} },
+	[ID_MCP4802] = { MCP4922_CHAN(0, 8),	MCP4922_CHAN(1, 8) },
+	[ID_MCP4811] = { MCP4922_CHAN(0, 10),	{} },
+	[ID_MCP4812] = { MCP4922_CHAN(0, 10),	MCP4922_CHAN(1, 10) },
+	[ID_MCP4821] = { MCP4922_CHAN(0, 12),	{} },
+	[ID_MCP4822] = { MCP4922_CHAN(0, 12),	MCP4922_CHAN(1, 12) },
 };
 
 static const struct iio_info mcp4922_info = {
@@ -133,25 +176,31 @@ static int mcp4922_probe(struct spi_device *spi)
 
 	state = iio_priv(indio_dev);
 	state->spi = spi;
-	state->vref_reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(state->vref_reg))
-		return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
-				     "Vref regulator not specified\n");
+	id = spi_get_device_id(spi);
+	if (mcp4922_needs_vref(id->driver_data)) {
+		state->vref_reg = devm_regulator_get(&spi->dev, "vref");
+		if (IS_ERR(state->vref_reg))
+			return dev_err_probe(&spi->dev, PTR_ERR(state->vref_reg),
+					"Vref regulator not specified\n");
 
-	ret = regulator_enable(state->vref_reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable vref regulator: %d\n",
-				ret);
-		return ret;
-	}
+		ret = regulator_enable(state->vref_reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable vref regulator: %d\n",
+					ret);
+			return ret;
+		}
 
-	ret = regulator_get_voltage(state->vref_reg);
-	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
-				ret);
-		goto error_disable_vref_reg;
+		ret = regulator_get_voltage(state->vref_reg);
+		if (ret < 0) {
+			dev_err(&spi->dev, "Failed to read vref regulator: %d\n",
+					ret);
+			goto error_disable_vref_reg;
+		}
+		state->vref_mv = ret / 1000;
+	} else {
+		state->vref_mv = MCP48XX_INTERNAL_VREF_MV;
 	}
-	state->vref_mv = ret / 1000;
+
 
 	state->vdd_reg = devm_regulator_get(&spi->dev, "vdd");
 	if (IS_ERR(state->vdd_reg)) {
@@ -167,14 +216,10 @@ static int mcp4922_probe(struct spi_device *spi)
 	}
 
 	spi_set_drvdata(spi, indio_dev);
-	id = spi_get_device_id(spi);
 	indio_dev->info = &mcp4922_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = mcp4922_channels[id->driver_data];
-	if (id->driver_data == ID_MCP4921)
-		indio_dev->num_channels = MCP4921_NUM_CHANNELS;
-	else
-		indio_dev->num_channels = MCP4922_NUM_CHANNELS;
+	indio_dev->num_channels = mcp4922_num_channels(id->driver_data);
 	indio_dev->name = id->name;
 
 	ret = iio_device_register(indio_dev);
@@ -188,7 +233,9 @@ static int mcp4922_probe(struct spi_device *spi)
 error_disable_vdd_reg:
 	regulator_disable(state->vdd_reg);
 error_disable_vref_reg:
-	regulator_disable(state->vref_reg);
+	if (mcp4922_needs_vref(id->driver_data))
+		regulator_disable(state->vref_reg);
+
 
 	return ret;
 }
@@ -197,11 +244,14 @@ static void mcp4922_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct mcp4922_state *state;
+	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	iio_device_unregister(indio_dev);
 	state = iio_priv(indio_dev);
 	regulator_disable(state->vdd_reg);
-	regulator_disable(state->vref_reg);
+	if (mcp4922_needs_vref(id->driver_data)) {
+		regulator_disable(state->vref_reg);
+	}
 }
 
 static const struct spi_device_id mcp4922_id[] = {
@@ -209,6 +259,12 @@ static const struct spi_device_id mcp4922_id[] = {
 	{"mcp4912", ID_MCP4912},
 	{"mcp4921", ID_MCP4921},
 	{"mcp4922", ID_MCP4922},
+	{"mcp4801", ID_MCP4801},
+	{"mcp4802", ID_MCP4802},
+	{"mcp4811", ID_MCP4811},
+	{"mcp4812", ID_MCP4812},
+	{"mcp4821", ID_MCP4821},
+	{"mcp4822", ID_MCP4822},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, mcp4922_id);
@@ -224,5 +280,5 @@ static struct spi_driver mcp4922_driver = {
 module_spi_driver(mcp4922_driver);
 
 MODULE_AUTHOR("Michael Welling <mwelling@ieee.org>");
-MODULE_DESCRIPTION("Microchip MCP4902, MCP4912, MCP4922 DAC");
+MODULE_DESCRIPTION("Microchip MCP49XX and MCP48XX DAC");
 MODULE_LICENSE("GPL v2");
-- 
2.40.0

