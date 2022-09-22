Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018F45E5D44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiIVIRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiIVIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:17:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E558AA370
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:17:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z13so81192ejp.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kGmdgZAxEzWsZ+lVFMydjFzpxJ4LCN+30EELj9QAOus=;
        b=V3Z6FvGW5QWr4F2CFl2J+wE/HRBkYyUI71Ng6h+eAhC/96ZrYKgv4fnEuenrl/6545
         IjX9ReGKe58WagVbHLzZZPivZDtSk0pTVesdItw3NTynAePbbGLn15m8QWs0XdEMtli+
         h4qEoAcqER5g7R0EAjsMgzWt6upWNEldDWS2onFL/YZTcpfGFs97UgL4Irn1sjReNGiw
         l8+uSYdPDN0JerPFi4Ozc7FEUj0/oPdNAJ/aQZ6FN4599ejay0+nGAY/8eS9TQok+he5
         n+ObUN30nDxffoJ2oHZBODgWG4uek6Xb8qonK268i0VUnGnVmu50Q9Yw16D7iGEMQcCv
         owtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kGmdgZAxEzWsZ+lVFMydjFzpxJ4LCN+30EELj9QAOus=;
        b=fkVU42ZnyOBZdqOHilCm5QYmoRfyTZdH5XsJ4mRMZCGmdHH17ZwWZmuA9DlNZtDMuO
         08PFK7wvmRJ/8zttEBVM7E49+SDIHFWMsub5MGxFVhyzfJ6y9SML/Q32Ti5ctzOE8iFM
         dCC1kgxQDBBtFP+tqOWzTPLzvjLcjPIpyjnI9/2gku1GmrgTMywK13+vcrCWjfdUp2Xd
         f+u/r8OQpidcpz0nlDYBoN58l/u/MQj8E7ujxw1pPjIf3/DGGE0QKrx/577FmjjySH0a
         wVEKYh180+LEnWY0t3dubs5mRrnjrXgDH3yWcmALAOpaLaXSAJyZmIIjFO24A3YgSmY9
         TqJg==
X-Gm-Message-State: ACrzQf0YkW3M/W8DTPKNErRQ7iP8MdDeZOC+aP4jv5huU/C9BWtfQvPN
        ev2zRQlqZQP7dATVaikUh/5hQJyH3f3nnA==
X-Google-Smtp-Source: AMsMyM61Bsc48N5hFrtxDMTWbwNEpxL8efYBx7AzksRGEjLcdS3EiAofxqMkLuvp4K4/nDpohV2RZg==
X-Received: by 2002:a17:907:7607:b0:770:7ec4:fb41 with SMTP id jx7-20020a170907760700b007707ec4fb41mr1655028ejc.685.1663834649047;
        Thu, 22 Sep 2022 01:17:29 -0700 (PDT)
Received: from cmo-ThinkPad-T495.tess.elex.be ([194.150.35.21])
        by smtp.gmail.com with ESMTPSA id b10-20020aa7df8a000000b0044e01e2533asm3301303edy.43.2022.09.22.01.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:17:28 -0700 (PDT)
From:   cmo@melexis.com
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v6 2/3] iio: temperature: mlx90632 Read sampling frequency
Date:   Thu, 22 Sep 2022 10:13:23 +0200
Message-Id: <0bd6d6d665b4bd39e4565f6f44cb1bdc03386e23.1663834141.git.cmo@melexis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1663834141.git.cmo@melexis.com>
References: <cover.1663834141.git.cmo@melexis.com>
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
index 71130d237a69..081803940261 100644
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

