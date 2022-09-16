Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760E35BABDF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiIPK76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiIPK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 06:58:31 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43A9B72B3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:46:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lh5so6754098ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JjQOhi02C9AekeMj3LYkyFRWD9UJCpdDKlRtlWP9Usk=;
        b=omNLplgDHrKq1w8UB4XTWEQZ2Oc3qXewRfnZafK5pYTGg8Jn6oTQ06R2ncNeMCxMsg
         P+zN81GPV7k5bl12cevmgqi4NMuoZqPybBxFXVgqqHLqoftCz9oBMaGshHVEhcEpDruu
         FiOEK3ZgcHW5maYNdNTAmrT9Ua0dqKcyEN5kSi+FYIopPi7np874/4cOKnTKTlNKKQm8
         e57cW7yocKw3DNTwsAUuWKOHl6AvVBtnkapSK9+ziELauchMj/nlnQWrxEf9rL6aLROM
         JKjAnB9UQpyZSIAIMj9lLVF828ci4h9YKdjyS8obTiOQg2e0PQ4IuZZ9qYtWbyKHrOwf
         JFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JjQOhi02C9AekeMj3LYkyFRWD9UJCpdDKlRtlWP9Usk=;
        b=lg9MeKx2pm7auUHMpKEaS1ROqWSG4zNTy9Gmx2HUmojuAxvTUoyIMn8o0vHQgJ67tx
         FHBM8Qt9WhA3IjxWnvDM00+g/h0jzNxt3+MC2FQWo0JyQ5Xu6eTRbsmYzJjAUj474oWT
         yv+Q+B0jBCC2ByXBovPGlUACDiuR19JRSopO2kE2yp6m7eh3ZFLaBbo6T5dLrNjKCSTD
         qC/eGQmXTp8TTu2IdBNjRVEmb0p/yJwkjn51nvA1fcHI76uGxfSLjmIEQjfR6R/nxM3O
         zdV5bYvqtZogz/OSC0fBGYmTBBRaIGlj0kNL6Aq1INx9pf9YRy/GQtzsxamQowi4vOxW
         WyAw==
X-Gm-Message-State: ACrzQf0ieZ6TTX4zPsyX1ZhAWTw12bh7qeoX8qCyXbepoVJv0mnq4aaq
        zQvJs6khkrk8H1HLVyolkxwKtQ==
X-Google-Smtp-Source: AMsMyM7UMdzea5at4yQKZx2yvom3LFjH7jTUideb9x9xxxdGoJLea3GoFR0RXxKAYkBW3iEpWq4wSQ==
X-Received: by 2002:a17:907:a4c:b0:77b:ba98:d3e with SMTP id be12-20020a1709070a4c00b0077bba980d3emr3192132ejc.13.1663325178383;
        Fri, 16 Sep 2022 03:46:18 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3vvunoijj2gi1k.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:cef1:93b4:727b:dd58])
        by smtp.gmail.com with ESMTPSA id fi24-20020a1709073ad800b0072af4af2f46sm10148434ejc.74.2022.09.16.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 03:46:17 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v4 2/3] iio: temperature: mlx90632 Read sampling frequency
Date:   Fri, 16 Sep 2022 12:45:51 +0200
Message-Id: <651b3659f574f9b17de34b774f94c895cbd00dfd.1663324968.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663324968.git.cmo@melexis.com>
References: <cover.1663324968.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Crt Mori <cmo@melexis.com>

Allow users to read sensor sampling frequency to better plan the
application measurement requests.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/temperature/mlx90632.c | 59 ++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 80497d9bc4e9..e7946e3ed4fb 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -81,6 +81,9 @@
 #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous */
 
 #define MLX90632_EE_RR GENMASK(10, 8) /* Only Refresh Rate bits */
+#define MLX90632_REFRESH_RATE(ee_val) FIELD_GET(MLX90632_EE_RR, ee_val)
+					/* Extract Refresh Rate from ee register */
+#define MLX90632_REFRESH_RATE_STATUS(refresh_rate) (refresh_rate << 8)
 
 /* Measurement types */
 #define MLX90632_MTYP_MEDICAL 0
@@ -914,6 +917,32 @@ static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
 	return ret;
 }
 
+static int mlx90632_get_refresh_rate(struct mlx90632_data *data,
+				     int *refresh_rate)
+{
+	unsigned int meas1;
+	int ret;
+
+	ret = regmap_read(data->regmap, MLX90632_EE_MEDICAL_MEAS1, &meas1);
+	if (ret < 0)
+		return ret;
+
+	*refresh_rate = MLX90632_REFRESH_RATE(meas1);
+
+	return ret;
+}
+
+static const int mlx90632_freqs[][2] = {
+	{0, 500000},
+	{1, 0},
+	{2, 0},
+	{4, 0},
+	{8, 0},
+	{16, 0},
+	{32, 0},
+	{64, 0}
+};
+
 /**
  * mlx90632_pm_interraction_wakeup() - Measure time between user interactions to change powermode
  * @data: pointer to mlx90632_data object containing interaction_ts information
@@ -992,6 +1021,15 @@ static int mlx90632_read_raw(struct iio_dev *indio_dev,
 		*val = data->object_ambient_temperature;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = mlx90632_get_refresh_rate(data, &cr);
+		if (ret < 0)
+			goto mlx90632_read_raw_pm;
+
+		*val = mlx90632_freqs[cr][0];
+		*val2 = mlx90632_freqs[cr][1];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -1025,12 +1063,30 @@ static int mlx90632_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int mlx90632_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)mlx90632_freqs;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = 2 * ARRAY_SIZE(mlx90632_freqs);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_chan_spec mlx90632_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.modified = 1,
 		.channel2 = IIO_MOD_TEMP_AMBIENT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 	{
 		.type = IIO_TEMP,
@@ -1038,12 +1094,15 @@ static const struct iio_chan_spec mlx90632_channels[] = {
 		.channel2 = IIO_MOD_TEMP_OBJECT,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
 			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) | BIT(IIO_CHAN_INFO_CALIBAMBIENT),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	},
 };
 
 static const struct iio_info mlx90632_info = {
 	.read_raw = mlx90632_read_raw,
 	.write_raw = mlx90632_write_raw,
+	.read_avail = mlx90632_read_avail,
 };
 
 static int mlx90632_sleep(struct mlx90632_data *data)
-- 
2.34.1

