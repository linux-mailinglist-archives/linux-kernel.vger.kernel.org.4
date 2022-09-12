Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8C5B6456
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiILXrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiILXrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:47:17 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D55142B;
        Mon, 12 Sep 2022 16:47:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so8337933wmb.4;
        Mon, 12 Sep 2022 16:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BBGOgVrUiy0a1XBEu0PtIGZlxACNZi6E3IjT9we3Sfo=;
        b=YQNeMbrKGhm5uI0t8tLcsmEt3VrDPTYB3zpDKdDaxM8huQOoWisAMLp7os7p1Ljrsw
         2yCMCbyt258HZnXft2xHiTzfV67FTTnPC+MlbxOxNZPoaBHm83oat24fytSkY5wLikIB
         Fu7i61E63RT4Aukd8nKfEKHA0d9kO4FSJUrkRsV8FPdp7IufZT1ACZHkr/k2CYZWAqrF
         +ZJk1bmKuE/274IicdMBUfaf6pNM7lx1+oGsaksJzMvObliscQBQx3BTpBMKBau6kMsS
         UZcNpm4raC7BIoXEZc0WAwawy5gjzLU475k587hj6jL8o9k6kyGnzrZjlSK+T5bWYj/W
         i1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BBGOgVrUiy0a1XBEu0PtIGZlxACNZi6E3IjT9we3Sfo=;
        b=NteakX6vRWicGyZuv/QwTFQYT1yTFLlJsXjRZdFZFOrfWqETKuuYhHp4YseaRRtSsp
         BRRPzLV8ixxZCJLYKMJu+sQgmNF4l0VAoFGB65JSAF1aCeDRN1sdrLMfFLFtKe4WGa7n
         H3DEhAbW6RSkffZp5tJho3Yv95e2XFQRvHLwDb/6cAN1tBW3Kzu8CzjsFSvDjFfi4Z/Q
         bEbPcRfAPPOL9pLoj3PCk/aR2wCxhWHehekAka4qnbTUayqYDdqOuWHFuN7bwJzKZu1P
         bWQVjCzhCsfOu+Pr2w3UclBPULUu31cCP9hDJ0PH9/8CC/fb/LKospw3mLevhVtCTwrs
         68mw==
X-Gm-Message-State: ACgBeo2D+vxQ8hARYmkk15Xq952FvY+BylfUwS1JGtdRjOq0jn/ya5xS
        HgMgyF/kTjlvlCT4xS1If2un3VZZdFI=
X-Google-Smtp-Source: AA6agR7Z717oujmIr0ZgG1AbPzzKtMQ6aHMOJcRuUnSAx3/NHiJoPbHVtmZ7OvM0E8ENrkf2KGk1Jg==
X-Received: by 2002:a05:600c:3b25:b0:3b3:1f73:daff with SMTP id m37-20020a05600c3b2500b003b31f73daffmr459684wms.129.1663026433094;
        Mon, 12 Sep 2022 16:47:13 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d6a06000000b0021badf3cb26sm10523188wru.63.2022.09.12.16.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:47:12 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] iio: pressure: bmp280: Simplify bmp280 calibration data reading
Date:   Tue, 13 Sep 2022 01:46:42 +0200
Message-Id: <96d81282c95006d857f4d836d2ff3ee0740a85a0.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
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

On bmp280 and bme280, the temperature and pressure calibration parameters
are available on a contiguous memory region. Considering this arrangement,
simplified the calibration reading function by using only one buffer
to read in batch temperature and pressure registers.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 58 ++++++++++++------------------
 drivers/iio/pressure/bmp280.h      |  3 ++
 2 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 0ba4ff999f33..4793bcd9f0b3 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -128,8 +128,7 @@ struct bmp280_chip_info {
  * These enums are used for indexing into the array of compensation
  * parameters for BMP280.
  */
-enum { T1, T2, T3 };
-enum { P1, P2, P3, P4, P5, P6, P7, P8, P9 };
+enum { T1, T2, T3, P1, P2, P3, P4, P5, P6, P7, P8, P9 };
 
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
@@ -153,8 +152,7 @@ static int bmp280_read_calib(struct bmp280_data *data,
 			     struct bmp280_calib *calib,
 			     unsigned int chip)
 {
-	__le16 p_buf[BMP280_COMP_PRESS_REG_COUNT / 2];
-	__le16 t_buf[BMP280_COMP_TEMP_REG_COUNT / 2];
+	__le16 c_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 	struct device *dev = data->dev;
 	unsigned int tmp;
 	__le16 l16;
@@ -162,43 +160,33 @@ static int bmp280_read_calib(struct bmp280_data *data,
 	int ret;
 
 
-	/* Read temperature calibration values. */
+	/* Read temperature and pressure calibration values. */
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
-			       t_buf, BMP280_COMP_TEMP_REG_COUNT);
+			       c_buf, sizeof(c_buf));
 	if (ret < 0) {
 		dev_err(data->dev,
-			"failed to read temperature calibration parameters\n");
+			"failed to read temperature and pressure calibration parameters\n");
 		return ret;
 	}
 
-	/* Toss the temperature calibration data into the entropy pool */
-	add_device_randomness(t_buf, sizeof(t_buf));
-
-	calib->T1 = le16_to_cpu(t_buf[T1]);
-	calib->T2 = le16_to_cpu(t_buf[T2]);
-	calib->T3 = le16_to_cpu(t_buf[T3]);
-
-	/* Read pressure calibration values. */
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_PRESS_START,
-			       p_buf, BMP280_COMP_PRESS_REG_COUNT);
-	if (ret < 0) {
-		dev_err(data->dev,
-			"failed to read pressure calibration parameters\n");
-		return ret;
-	}
-
-	/* Toss the pressure calibration data into the entropy pool */
-	add_device_randomness(p_buf, sizeof(p_buf));
-
-	calib->P1 = le16_to_cpu(p_buf[P1]);
-	calib->P2 = le16_to_cpu(p_buf[P2]);
-	calib->P3 = le16_to_cpu(p_buf[P3]);
-	calib->P4 = le16_to_cpu(p_buf[P4]);
-	calib->P5 = le16_to_cpu(p_buf[P5]);
-	calib->P6 = le16_to_cpu(p_buf[P6]);
-	calib->P7 = le16_to_cpu(p_buf[P7]);
-	calib->P8 = le16_to_cpu(p_buf[P8]);
-	calib->P9 = le16_to_cpu(p_buf[P9]);
+	/* Toss the temperature and pressure calibration data into the entropy pool */
+	add_device_randomness(c_buf, sizeof(c_buf));
+
+	/* Parse temperature calibration values. */
+	calib->T1 = le16_to_cpu(c_buf[T1]);
+	calib->T2 = le16_to_cpu(c_buf[T2]);
+	calib->T3 = le16_to_cpu(c_buf[T3]);
+
+	/* Parse pressure calibration values. */
+	calib->P1 = le16_to_cpu(c_buf[P1]);
+	calib->P2 = le16_to_cpu(c_buf[P2]);
+	calib->P3 = le16_to_cpu(c_buf[P3]);
+	calib->P4 = le16_to_cpu(c_buf[P4]);
+	calib->P5 = le16_to_cpu(c_buf[P5]);
+	calib->P6 = le16_to_cpu(c_buf[P6]);
+	calib->P7 = le16_to_cpu(c_buf[P7]);
+	calib->P8 = le16_to_cpu(c_buf[P8]);
+	calib->P9 = le16_to_cpu(c_buf[P9]);
 
 	/*
 	 * Read humidity calibration values.
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 4a501836d27a..03a539223417 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -37,6 +37,9 @@
 
 #define BMP280_COMP_H5_MASK		GENMASK(15, 4)
 
+#define BMP280_CONTIGUOUS_CALIB_REGS	(BMP280_COMP_TEMP_REG_COUNT + \
+					 BMP280_COMP_PRESS_REG_COUNT)
+
 #define BMP280_FILTER_MASK		GENMASK(4, 2)
 #define BMP280_FILTER_OFF		0
 #define BMP280_FILTER_2X		1
-- 
2.37.3

