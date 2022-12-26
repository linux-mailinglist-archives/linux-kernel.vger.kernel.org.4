Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED996656366
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiLZOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiLZOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:32:01 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A693F37;
        Mon, 26 Dec 2022 06:32:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so7597556wms.2;
        Mon, 26 Dec 2022 06:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+RDFj6BpHhJ2bFeylBpDtFtMyr1ovdocCHUnTCQ0GU=;
        b=R+RbaKWcEPEaEJRWYAOfU62ZnTF43IYlLUI+l7k5l0mbGpzMevRNvBGKxH6CtmU72L
         p0sGXZpRA1o+ESMmXCb2eWhwn//uDjyvQcukA+j9ZfJuKuFLsDWJIWwy/oq57pZmUd6j
         dtQw8+hQ8pgDVGUpq1U/VnJW7Rs5DSToYw1sroK64yoNOLgs+8MJ2GaKHj+7IHSOeLGd
         xZln/5HqQtrMbHF4+kw4qaS5QkK6ZLVDRXZ/hJP3LoIF7/Bya4u9YvNBrZRq5QygKD9v
         /w94QlbbYIhqSssg9Easny8lc4gC2dePdnbkVF2sugG5ypz9wu3fPQ6PDMuRjyy6nORP
         LVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+RDFj6BpHhJ2bFeylBpDtFtMyr1ovdocCHUnTCQ0GU=;
        b=q58PXCJhivIcnRqpC/2s3xyxW9GQ/LVLktnbaXM7Q3mfEvOZ2VrGPZ2IX575peGukv
         u0s/GdnQqsYS6xehispY6XgfkAtKL0y2OBZAb8wZ7DSg5obggj9pD0GJdU9jJ3oklbat
         Lgyxo1AsYmin0UVEzEVn+lTiTC+MEXt2SbUo0FtQC2kDXH4f9OtDO4X5BuadaHl6fF4c
         xgJjDJ1PIRYtGGT8W0isX1UkItzHW+CiJrC1Lq8juHzXKjJETMC/lFliNSYI8FyxrPBq
         05e/FAZ01GB0Q6pMKaVIaG2Fbc2D9x2cjTr2GIa/lx5Z9Jips611zNA0L/WQ22q194z0
         2k8w==
X-Gm-Message-State: AFqh2kojEdvpiHICzRElxq26TEzaWf8tj07mrEBvTcqMl7VACAdarm6Z
        YvVx7Ex2gm+zNQsT105jTItcRT9YlmY=
X-Google-Smtp-Source: AMrXdXtQ/bOIqk2uGai2bCZO57k1vhJW5z+X/RmIzfHDwnJcjd4rCx+plKX4cqdNlOfLRNVqiHJyfA==
X-Received: by 2002:a05:600c:538a:b0:3d9:67e3:87d3 with SMTP id hg10-20020a05600c538a00b003d967e387d3mr12728605wmb.25.1672065118652;
        Mon, 26 Dec 2022 06:31:58 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b003cf75213bb9sm21511754wmq.8.2022.12.26.06.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 06:31:58 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] iio: pressure: bmp280: Add preinit callback
Date:   Mon, 26 Dec 2022 15:29:21 +0100
Message-Id: <724e92e64e6d91d48d762e804b430c716679bccb.1672062380.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672062380.git.ang.iglesiasg@gmail.com>
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
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

Adds preinit callback to execute operations on probe before applying
initial configuration.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 46959a91408f..c37cf2caec68 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -217,6 +217,7 @@ struct bmp280_chip_info {
 	int (*read_press)(struct bmp280_data *, int *, int *);
 	int (*read_humid)(struct bmp280_data *, int *, int *);
 	int (*read_calib)(struct bmp280_data *);
+	int (*preinit)(struct bmp280_data *);
 };
 
 /*
@@ -935,6 +936,7 @@ static const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.preinit = NULL,
 };
 
 static int bme280_chip_config(struct bmp280_data *data)
@@ -979,6 +981,7 @@ static const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bmp280_read_humid,
 	.read_calib = bme280_read_calib,
+	.preinit = NULL,
 };
 
 /*
@@ -1220,6 +1223,12 @@ static const int bmp380_odr_table[][2] = {
 	[BMP380_ODR_0_0015HZ]	= {0, 1526},
 };
 
+static int bmp380_preinit(struct bmp280_data *data)
+{
+	/* BMP3xx requires soft-reset as part of initialization */
+	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
+}
+
 static int bmp380_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -1349,6 +1358,7 @@ static const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.preinit = bmp380_preinit,
 };
 
 static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
@@ -1604,6 +1614,7 @@ static const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.preinit = NULL,
 };
 
 static irqreturn_t bmp085_eoc_irq(int irq, void *d)
@@ -1762,9 +1773,13 @@ int bmp280_common_probe(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* BMP3xx requires soft-reset as part of initialization */
-	if (chip_id == BMP380_CHIP_ID) {
-		ret = bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
+	/*
+	 * Some chips like the BMP3xx have preinit tasks to run
+	 * before applying the initial configuration.
+	 */
+	if (data->chip_info->preinit) {
+		ret = data->chip_info->preinit(data);
+		dev_err(dev, "error running preinit tasks");
 		if (ret < 0)
 			return ret;
 	}
-- 
2.39.0

