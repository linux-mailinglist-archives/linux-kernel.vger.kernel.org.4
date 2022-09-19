Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF445BC4AF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiISItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiISIso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:48:44 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46985222B2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:48:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id m3so20386183eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YBK40qG0NEVptByWXofU5yPXJ5EcAhbzDdsSmVzZVWQ=;
        b=ZEXJNLE+iuZu7HMb0I1C+psMYksJDe9kUEfsowKNzgkgZ08Wg86f8VlRGuP2pS7MB6
         8ZA2CZiAfgGZR3rpc3vWOP6bjIdM4a5oxmEo0QMygDYXyHZYGP1CqgZXTiypCpBF/RNy
         yLJrsamyiFS86DDuxfOo2AaFSR+ykwyTAbp3GW/PBbbDPRb41OzE6FbEMmmkb9ZxZcFy
         dYfwH0TXEcYQLmVQYxbwcwtvNoJFg7i7f8IoF5uEhzTG8+nMjcuQFajQE+Zm9BnRWQaC
         ykMDJD7FYsxbX+OcOdl5kACkxsO0RlwoEi8ydatUSmT56PebVkeqkw97wY8CoF+KQCud
         ZKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YBK40qG0NEVptByWXofU5yPXJ5EcAhbzDdsSmVzZVWQ=;
        b=MSd/SBetfBoZpJrDnXcrnE8ZTcXim/TKu4kKrsPSpCAMLEaK+mDes6jMbZ+zUPFLQ2
         InKkQN4BrI2FedyD74wsPhxOS6v5IjPLpsVf/7M6nuGelbaU+olwwDHsxbyP/Qv3W0rP
         3xD6czfxwfFPG/L45pJtuWjKzS3pggcPekNoCBjVSpuXEHqxZMRnMnpG63U0Or8XywAk
         VatNBEd5u9ueSf6gG/++CYxNmHCSuMzbm4gohGssW0C3Ht71sGl2k68nSAL4jNhO8BNk
         twubQ6XPH9y4/jE7gQA1VY9HNd0HEnZtZPjZZjaUx+JUiZDxzSCLljwvCfxSTnqNnPDw
         Ys+A==
X-Gm-Message-State: ACrzQf1G4x7wxTrOkCuW+3oaygGQgj3vVFb6/TJRP6nCZE8pGl+5SXCU
        jp7s5HD4por0ai7YKH57WxlzTg==
X-Google-Smtp-Source: AMsMyM5IRrrL4q34j+l47JwB06+4HxrbzD8lo23xhgl2VfiuOJxv0KxnNEUWuFLBq5OVnywjxHJ97g==
X-Received: by 2002:a05:6402:5290:b0:453:5942:4ef8 with SMTP id en16-20020a056402529000b0045359424ef8mr13329409edb.180.1663577320752;
        Mon, 19 Sep 2022 01:48:40 -0700 (PDT)
Received: from cmo-ThinkPad-T495.telenet.be (ptr-4xh0y3vyam57ypepalv.18120a2.ip6.access.telenet.be. [2a02:1810:a44c:8f00:d368:146c:ce83:b3f3])
        by smtp.gmail.com with ESMTPSA id r20-20020aa7d594000000b0044e9a3690e0sm20081326edq.9.2022.09.19.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 01:48:40 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v5 2/3] iio: temperature: mlx90632 Read sampling frequency
Date:   Mon, 19 Sep 2022 10:48:17 +0200
Message-Id: <b5adfe34f3e2eeedaff182d90206c8364008ab62.1663577091.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663577091.git.cmo@melexis.com>
References: <cover.1663577091.git.cmo@melexis.com>
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
index 68093639d0e9..c0bf385ebd6c 100644
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
 
 static void mlx90632_sleep(void *_data)
-- 
2.34.1

