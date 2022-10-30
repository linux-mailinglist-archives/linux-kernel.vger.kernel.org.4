Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064CD612C0C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ3Rxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3Rxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:53:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7537A462;
        Sun, 30 Oct 2022 10:53:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so1435601wrb.9;
        Sun, 30 Oct 2022 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh99+98k9DjiwRCEQNWBVpY/+xrac0K5mOZC2PhRLgk=;
        b=ejW67cUc978YaFYovxPuidvFmLZpzJiHzXjm5a2qGRTyOBt2JXcH9CJJgBz862Xo0o
         Bvc2yA/T92e8xjkoS0JWE6YyS6vtQ4i/hqmm30/q6/sDPBe8/bkb/3GLFv7v/3uegzwD
         09PDOS/S5/G+LcwBAXNLuExYOJKzV+HD1FXzCMWlaetC9AR9pA9FVPyMkbvcWfCtXBQP
         0zdLGOtD5IJ/ORuqGaHmKiJ8JqsVKKVj41Q931KZg6F//Pje/y9iH17AwuOAtggjH1MJ
         n7hdVbKxfLni/gknE4n/5PXhrWnp6PN4OMjf2dpxLqjGveJXilVwPCIZw1nfxMAS8BTs
         tlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uh99+98k9DjiwRCEQNWBVpY/+xrac0K5mOZC2PhRLgk=;
        b=dLxuaVSxkL6K6IaDAPxMifVyfYo0Xf5AiTYHxZNzZ2rJCSGFKvjQAym+xUT0dUUIYr
         cy49tSLS7xvOaVS3LDKhYvxBWghGgtZC2JVd2nVa3Z8I0yCUR+pcGDSgiXggbBLnBx3Y
         ulop5ai6usz05nfLEgHzt/fvyAuOT1n4oZN9Cilb9odE1Xgt0Q4jSCzFq1lYXTSlZrEC
         pcan3YP97ZfVd1K7oSDIuNSuJqeDVQGzt7KNIcLiIAbE9UbGafiqYg+f8YXHHqIFtZAD
         MUYVx08jtRAIR9iyHpYcMvmoqcxpnzb3/e/2UrdYfpmRsAgEr150jmBz8mbOM1I6R8ls
         nb+A==
X-Gm-Message-State: ACrzQf0ivusPPKHB3Kt4Vw7SkUE/xVh5F+YOqk2062krlIBajiuEFfka
        WQyGK+8+PRshrtj2M9zvxHiepR5Q2Xc=
X-Google-Smtp-Source: AMsMyM5PGlZg3od3i7+EKna5RUd+ykP954zC/EqwpeGpw5it30+xH9uv+tZ9mZOOcJFwxZOP0dqb7Q==
X-Received: by 2002:adf:e405:0:b0:236:6e0d:6ed2 with SMTP id g5-20020adfe405000000b002366e0d6ed2mr5661404wrm.338.1667152423307;
        Sun, 30 Oct 2022 10:53:43 -0700 (PDT)
Received: from localhost.localdomain (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003a83ca67f73sm5111182wmb.3.2022.10.30.10.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:53:43 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] iio: pressure: bmp280: convert to i2c's .probe_new()
Date:   Sun, 30 Oct 2022 18:53:11 +0100
Message-Id: <af8ed10a85d48531c50823163e6c55b2a72371ef.1667151588.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1667151588.git.ang.iglesiasg@gmail.com>
References: <cover.1667151588.git.ang.iglesiasg@gmail.com>
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

Use i2c_client_get_device_id() to get the i2c_device_id* parameter in the
.new_probe() callback.

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
---
 drivers/iio/pressure/bmp280-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 0c27211f3ea0..20073b09b3e3 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -5,11 +5,11 @@
 
 #include "bmp280.h"
 
-static int bmp280_i2c_probe(struct i2c_client *client,
-			    const struct i2c_device_id *id)
+static int bmp280_i2c_probe(struct i2c_client *client)
 {
-	struct regmap *regmap;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	const struct regmap_config *regmap_config;
+	struct regmap *regmap;
 
 	switch (id->driver_data) {
 	case BMP180_CHIP_ID:
@@ -65,7 +65,7 @@ static struct i2c_driver bmp280_i2c_driver = {
 		.of_match_table = bmp280_of_i2c_match,
 		.pm = pm_ptr(&bmp280_dev_pm_ops),
 	},
-	.probe		= bmp280_i2c_probe,
+	.probe_new	= bmp280_i2c_probe,
 	.id_table	= bmp280_i2c_id,
 };
 module_i2c_driver(bmp280_i2c_driver);
-- 
2.38.1

