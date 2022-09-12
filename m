Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4B65B645E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 01:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiILXuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 19:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiILXul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 19:50:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D8BCE15;
        Mon, 12 Sep 2022 16:50:39 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n8so763288wmr.5;
        Mon, 12 Sep 2022 16:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pTwEbLMCbyaVyzl18JN6kaVw/KjPPzqoeRa5qDh+anw=;
        b=jpLJJxqzXXZCRZ6jDfG+yZnGjF2xpWcYwOAcnFsX37LHrmNTXoo1HC8v4dnmTEY/y3
         4JEAbq+ell0/JyOC0+qmW7UsdP9D6ek9z28TrTN4b2dnUFn+iTfC9k1W60ceCnxLk5Iu
         rAZ4M4P5C2qTu/asuiIpSAiFHrFlGaU8dBznvOcheO8m9PWZJ2g5FROIXA6uSN4SywV1
         NF6Py4fCN1KxLb/B+BJI+pQN+WCGIbTMSZMappWNTjUczqi9+szjYRJrs9S7jplJ2fxM
         sNRkFFXPeBBiNcsCH95kGot6G4IbEoi6fcW1r5FZOUtHCCFhMi4IIxsvAj3kEcXRyIZa
         0kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pTwEbLMCbyaVyzl18JN6kaVw/KjPPzqoeRa5qDh+anw=;
        b=dE3hJ+0G7VwGLhNOgHb7jJEJHfg/ULsgFdN1l1aVw9I+qtxau24zkw5DoFRcGHEVZl
         L9hWjq1HzFs/MgDyJKm4p0AGk9r/JccHQX+tu+96fcniIuskvDoBppEd1a3Av6VlyYir
         eWhBuSI1HnU3/iyWr4p7nsD948N7GBmgq8Viz0b+CZqyM7gufmUGJ09VpKYaj1NnqPc4
         MgMwPnFYcBG4K88Y7YpFVx+t6PERJMhDrbuNd9O3fqHtiBRBx7Nhq+r41kp/+xT+o0FK
         OzTxXnyesvrNMr/WJOXyz/FsGK6OcLTAMffsgknPJxr0UW5lLSsNV/EgNMIqV6WgLHcj
         pxlQ==
X-Gm-Message-State: ACgBeo1Zyze/lzXAE5Wk93GsmyHGDr3JE3MuX51/2UJTMA5xyn49AqkX
        qt2sT3tL1Bk6LhBWzW0aeqRm5S+OmE0=
X-Google-Smtp-Source: AA6agR4V9+MEFsvGmio6pzKM/iVACRqMQhmI3T0R1t6+iAye3epQ54b2i7FrT/FT4e09MtVAeiXIJg==
X-Received: by 2002:a7b:cbd0:0:b0:3a6:9f6:a3e8 with SMTP id n16-20020a7bcbd0000000b003a609f6a3e8mr462354wmi.13.1663026637938;
        Mon, 12 Sep 2022 16:50:37 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c1d1300b003b476cabf1csm8434073wms.26.2022.09.12.16.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 16:50:37 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 6/9] iio: pressure: bmp280: reorder i2c device tables declarations
Date:   Tue, 13 Sep 2022 01:50:07 +0200
Message-Id: <a3969b60e428b9bd29ea1ebc6dd69aa5bbe59da0.1663025017.git.ang.iglesiasg@gmail.com>
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

Change device tables declarations to forward order like in SPI codepath.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-i2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index bf4a7a617537..5b51ebfc6f2b 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -37,18 +37,18 @@ static int bmp280_i2c_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id bmp280_of_i2c_match[] = {
-	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
-	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
-	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
 	{ .compatible = "bosch,bmp085", .data = (void *)BMP180_CHIP_ID },
+	{ .compatible = "bosch,bmp180", .data = (void *)BMP180_CHIP_ID },
+	{ .compatible = "bosch,bmp280", .data = (void *)BMP280_CHIP_ID },
+	{ .compatible = "bosch,bme280", .data = (void *)BME280_CHIP_ID },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
-	{"bmp280", BMP280_CHIP_ID },
-	{"bmp180", BMP180_CHIP_ID },
 	{"bmp085", BMP180_CHIP_ID },
+	{"bmp180", BMP180_CHIP_ID },
+	{"bmp280", BMP280_CHIP_ID },
 	{"bme280", BME280_CHIP_ID },
 	{ },
 };
-- 
2.37.3

