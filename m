Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8890562B2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiKPFis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiKPFi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:38:29 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB151025
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gw22so15564851pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 21:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFQW6v1diH1VyW+sL8lBdAoomh7zxMpXfwnkxl/32zA=;
        b=naf7hHO3UWHjpNpfDT7zWp+/pfz24/zpiVMv5vvpOmtsjD71TdXVOQuWTrXQlGW3DT
         k6OQyzXbC33xTJ4vWRBVu9j4bmDx6F7NtWWOnhPf1MyyzqTcFrH8M3c7v3m1bpJmKh15
         gL9KA6gm3URmDKumwfAsxlyem/35OjO3zoRfYkjUdt1JcHyccj00Eyx9Bi9uSIWdF7ZT
         +Wr5OWMJKXnCwh7W+QWb/80dPzmO5u+N6SqhYvU0Q3tpeaFNhACn2zodPNtlWRQxqwEk
         vdXf+yZqTNcpyU304fRnPyvbpukwqcaJt1vFvtUYIM7XdVNYYbPvJ1oGfq6acSrI+9hU
         43MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFQW6v1diH1VyW+sL8lBdAoomh7zxMpXfwnkxl/32zA=;
        b=eTujegalUN94Owi/VeROpFV8483WUVr6PXo0zKVDRtTAnZs+pVTZt3q4fOhbrLlWWn
         wPl81HOl88eArrEocwkbAOoD2ANXpE5r/v1C0jgvMs9E8Bjau9dZhmsU576JUeHi4Riz
         N4MGp/2Umjp9sYxlZyIxsb+YnuGDCuR91WWMjwIRq1NXtwzPtx89ciGCFgj2yxBMNFBi
         96W5pHIEUphMQ3iY9p2dfueEWn41FziwCeZ1/RJM3IJcuJgbuCmVG2oAUVkqsHEepX79
         AD1APByJKf5uV5N4unkIK6MVIl4SJrOehOxW9D01KrYwfNtHoPHP+1eKbNPeze+lyCoo
         spLw==
X-Gm-Message-State: ANoB5pmDmf6jf9wFqNfynyeVUH2AGfbwbzDmIc2TXd4OJvOY2zaJGo/o
        uVnPMfQRa9FG26nBP/zIbwE=
X-Google-Smtp-Source: AA0mqf4eBMXcBzdwJ5mtVoL0fxjZ7psKH+U4U0xM8+RXDkiJthcyDXK7qNiV0gPyIWmCuY6dETT4gA==
X-Received: by 2002:a17:902:e546:b0:188:4ea8:a685 with SMTP id n6-20020a170902e54600b001884ea8a685mr7509296plf.71.1668577107897;
        Tue, 15 Nov 2022 21:38:27 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id ik13-20020a170902ab0d00b0017834a6966csm10881038plb.176.2022.11.15.21.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:38:27 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 04/11] ASoC: tpa6130a2: remove support for platform data
Date:   Tue, 15 Nov 2022 21:38:10 -0800
Message-Id: <20221116053817.2929810-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
References: <20221116053817.2929810-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users of tpa6130a2_platform_data in the mainline kernel,
remove it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/sound/tpa6130a2-plat.h | 17 -----------------
 sound/soc/codecs/tpa6130a2.c   | 18 ++++--------------
 2 files changed, 4 insertions(+), 31 deletions(-)
 delete mode 100644 include/sound/tpa6130a2-plat.h

diff --git a/include/sound/tpa6130a2-plat.h b/include/sound/tpa6130a2-plat.h
deleted file mode 100644
index a60930e36e93..000000000000
--- a/include/sound/tpa6130a2-plat.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * TPA6130A2 driver platform header
- *
- * Copyright (C) Nokia Corporation
- *
- * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
- */
-
-#ifndef TPA6130A2_PLAT_H
-#define TPA6130A2_PLAT_H
-
-struct tpa6130a2_platform_data {
-	int power_gpio;
-};
-
-#endif
diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
index 8c00db32996b..5f00bfc32917 100644
--- a/sound/soc/codecs/tpa6130a2.c
+++ b/sound/soc/codecs/tpa6130a2.c
@@ -14,7 +14,6 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <sound/tpa6130a2-plat.h>
 #include <sound/soc.h>
 #include <sound/tlv.h>
 #include <linux/of.h>
@@ -218,16 +217,15 @@ MODULE_DEVICE_TABLE(i2c, tpa6130a2_id);
 
 static int tpa6130a2_probe(struct i2c_client *client)
 {
-	struct device *dev;
+	struct device *dev = &client->dev;
 	struct tpa6130a2_data *data;
-	struct tpa6130a2_platform_data *pdata = client->dev.platform_data;
-	struct device_node *np = client->dev.of_node;
 	const struct i2c_device_id *id;
 	const char *regulator;
 	unsigned int version;
 	int ret;
 
-	dev = &client->dev;
+	if (!dev->of_node)
+		return -ENODEV;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -239,15 +237,7 @@ static int tpa6130a2_probe(struct i2c_client *client)
 	if (IS_ERR(data->regmap))
 		return PTR_ERR(data->regmap);
 
-	if (pdata) {
-		data->power_gpio = pdata->power_gpio;
-	} else if (np) {
-		data->power_gpio = of_get_named_gpio(np, "power-gpio", 0);
-	} else {
-		dev_err(dev, "Platform data not set\n");
-		dump_stack();
-		return -ENODEV;
-	}
+	data->power_gpio = of_get_named_gpio(dev->of_node, "power-gpio", 0);
 
 	i2c_set_clientdata(client, data);
 
-- 
2.38.1.431.g37b22c650d-goog

