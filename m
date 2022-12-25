Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAD655DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiLYQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLYQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:57:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FC626CC;
        Sun, 25 Dec 2022 08:57:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso6474391wmp.3;
        Sun, 25 Dec 2022 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+RDFj6BpHhJ2bFeylBpDtFtMyr1ovdocCHUnTCQ0GU=;
        b=OSW8iD6WXPGvrQcrcNlE8p0s0EDbg4nn1UNBqG0fOPZqiPtLdFkIodXaJGdImqr1d0
         rrUhBQkKBOAS+PKD+1v5GrM9d6RD1VT/KIxqW/XhYnuGTh7e7/P4Q0l37oEri5s3RIOD
         tjCW/6taMRV+dSfECCKRLsPHolKcpWivufnnMNs88EJMXKJLzinf8LCHSw+5+47KMVCs
         n+MnjWXv/ktKg/AE7B7lalZTYCgDqhKXlE5zOSvsJzdCOtXbTrbRkhas9ELSRtxLKV1R
         s5ezJEL+z6EX+Ac9gg35ekzuVRrJtpa67koBvDa4Er+DBupLGugUYzv0obp2QWN3xgxr
         hFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+RDFj6BpHhJ2bFeylBpDtFtMyr1ovdocCHUnTCQ0GU=;
        b=MsLe6sw/fFUYG8grlqFyqFZLT/9SO7F/UWxKxP6tz2BRde92iI7/1DGnDZaEnx8Uww
         t75BIgxI6O3stPMhMu8FDdETPUB4dFNosBXF4tUYo0Mq0OmDf6TlwmfJkgKtn9uLQlCQ
         R1GF+lh+FdbFCyGdkEXdkhuyZOCPVjUi1GANZgi+8o8cJeAOOHsWyOl7Bx3C5qHU8IX3
         6+un1Mx/0Q9DcXFW5IlowhsG3puRqgD3XIvLpE6yrxFVzdnwaWYKf3nVEJTCkIfgo7en
         PKun5DDOnk5PjSr56fjDWtpOsMXuChd7pcZnjIMlLQCS5rCZ0ZwPvauWnfCF9HxlhgK4
         IHkQ==
X-Gm-Message-State: AFqh2kqmrQdH/SrDvC3b1FMlcR9b+9FgGJOl9/gMUq3FZujBQa2XFiv2
        dVB+I06VSlfG2AkIwSSe8g4rfx0DSkw=
X-Google-Smtp-Source: AMrXdXuSTG+HJ0QJ16TOi/V7iahI/zTXvm945PzwqPqMJkk0YVJiGn9Nz0gdY/xzUODBJ6L/F8Pcrg==
X-Received: by 2002:a05:600c:4920:b0:3d3:39a9:e659 with SMTP id f32-20020a05600c492000b003d339a9e659mr12174659wmp.21.1671987461917;
        Sun, 25 Dec 2022 08:57:41 -0800 (PST)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c4f8900b003d1b4d957aasm12610058wmq.36.2022.12.25.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 08:57:41 -0800 (PST)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] iio: pressure: bmp280: Add preinit callback
Date:   Sun, 25 Dec 2022 17:57:06 +0100
Message-Id: <724e92e64e6d91d48d762e804b430c716679bccb.1671986815.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1671986815.git.ang.iglesiasg@gmail.com>
References: <cover.1671986815.git.ang.iglesiasg@gmail.com>
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

