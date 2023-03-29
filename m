Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB936CD1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjC2F6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2F6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:58:03 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E30326A4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:58:01 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f22so9807795plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 22:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680069481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fd1nJiea4bT0nI1496bu6RJpEi0V2ouY5yB3uiUlal4=;
        b=gCyDUriAVjMLuZL0HLZwk/EYvfUODKTVSMFSygazcYv+ory4nCQI+QBq5VWqCnIkZb
         xYr4E9BTTfhtxcnS7YUBUeevnSlyqyKamvbo886PEiV587WDJEZxR4acnWLN1Y0lx+3a
         C9EQnMt3tVoNeFuDO6+HrnjTHpi7rJiCOAQRonvIAMMAs+WSb2S5R7oBrHTSzjqeJFOD
         Cc9YBBXva/oCLEgJn2nN6fLH+pF6ho5zCBuKIKgBEATYnKphhNq5s+giVWzflm4yd6dh
         K+eOJTEnU6dbFcxU4Omn6u8MA75+3V00Kn9kh7Mg61r11HJQtMmLKR3dCcCiaKICa2vS
         jvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680069481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fd1nJiea4bT0nI1496bu6RJpEi0V2ouY5yB3uiUlal4=;
        b=kMxUnzC8fJc9LgHeLubIrwtLFRaOhfWMVKnFFcTI6e+xSTh7whkvKAi0klVgLYxSm/
         KZCym68BWfh4k92bJxMtf4VkEEXYbZZHdr3jeJD9l2jL9UP+DWnCCsNY4BjyBSyaSNJp
         hb9KfoVqQ8R4iczAmKpGDCszfU6j5Z4M1HsE/wAK0KrJJTiLgy4yuFonae55iSYPlZaQ
         Rg4OWaUVzCyws4fJQky6Y0TXUYSqy9o+3+Mvek59EfNaAHObdRA1oTcZKgx/rkCfcmoP
         HAw7WxJEIx83Sx0rkyEXgxo7trt70Ozzxwz33tDX7m4EKl9vSSqrnZzpwDLCaKmgKs7R
         jzNg==
X-Gm-Message-State: AAQBX9fzhrj3sBjB1PwfdUYy9Zk7txdkjKIZfMJNdEhjhP2rGGVslskh
        aWLx0vuiRbvoFiEl9kF2qo7H2bg1x0br5f066iA=
X-Google-Smtp-Source: AKy350ZpTKAg/KUhmxXkQLQ59VtQtefEao/KsENlyHpPTN8xG2EFY24RgY8J6ivbK1p+hAcuQ/4Znw==
X-Received: by 2002:a17:902:fa43:b0:1a1:a8db:495d with SMTP id lb3-20020a170902fa4300b001a1a8db495dmr13548176plb.4.1680069480957;
        Tue, 28 Mar 2023 22:58:00 -0700 (PDT)
Received: from aaron-shen.localdomain (vps-44f54abf.vps.ovh.us. [51.81.202.223])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902b70200b0019e31e5f7f9sm22146379pls.71.2023.03.28.22.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 22:58:00 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH] mfd:i2c: remove redundant dev_set_drvdata() function
Date:   Wed, 29 Mar 2023 13:57:24 +0800
Message-Id: <20230329055724.43998-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

the i2c_set_clientdata() is the inline function which is
complemented by the dev_set_drvdata() internally. Do not
need to use the i2c_set_clientdata() and dev_set_drvdata()
at the same time.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/mfd/88pm80x.c       | 1 -
 drivers/mfd/88pm860x-core.c | 1 -
 drivers/mfd/aat2870-core.c  | 2 --
 drivers/mfd/lm3533-core.c   | 2 --
 drivers/mfd/max8907.c       | 2 --
 drivers/mfd/max8925-i2c.c   | 1 -
 drivers/mfd/wm8400-core.c   | 2 --
 drivers/mfd/wm8994-core.c   | 2 --
 8 files changed, 13 deletions(-)

diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
index ac4f08565f29..bbc1a87f0c8f 100644
--- a/drivers/mfd/88pm80x.c
+++ b/drivers/mfd/88pm80x.c
@@ -74,7 +74,6 @@ int pm80x_init(struct i2c_client *client)
 	chip->irq = client->irq;
 
 	chip->dev = &client->dev;
-	dev_set_drvdata(chip->dev, chip);
 	i2c_set_clientdata(chip->client, chip);
 
 	ret = regmap_read(chip->regmap, PM80X_CHIP_ID, &val);
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index aabac37c3502..26d1ffefadc1 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1166,7 +1166,6 @@ static int pm860x_probe(struct i2c_client *client)
 	chip->client = client;
 	i2c_set_clientdata(client, chip);
 	chip->dev = &client->dev;
-	dev_set_drvdata(chip->dev, chip);
 
 	/*
 	 * Both client and companion client shares same platform driver.
diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index f253da5b246b..5ff0f1ed7a15 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -345,8 +345,6 @@ static int aat2870_i2c_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	aat2870->dev = &client->dev;
-	dev_set_drvdata(aat2870->dev, aat2870);
-
 	aat2870->client = client;
 	i2c_set_clientdata(client, aat2870);
 
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 946f94f3a3c3..03830aa4979a 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -485,8 +485,6 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533->gpio_hwen = pdata->gpio_hwen;
 
-	dev_set_drvdata(lm3533->dev, lm3533);
-
 	if (gpio_is_valid(lm3533->gpio_hwen)) {
 		ret = devm_gpio_request_one(lm3533->dev, lm3533->gpio_hwen,
 					GPIOF_OUT_INIT_LOW, "lm3533-hwen");
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index a69b865c6eac..0b8f6c298f97 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -201,8 +201,6 @@ static int max8907_i2c_probe(struct i2c_client *i2c)
 	}
 
 	max8907->dev = &i2c->dev;
-	dev_set_drvdata(max8907->dev, max8907);
-
 	max8907->i2c_gen = i2c;
 	i2c_set_clientdata(i2c, max8907);
 	max8907->regmap_gen = devm_regmap_init_i2c(i2c,
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index 4057fd15c29e..c8761003c716 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -172,7 +172,6 @@ static int max8925_probe(struct i2c_client *client)
 	chip->i2c = client;
 	chip->dev = &client->dev;
 	i2c_set_clientdata(client, chip);
-	dev_set_drvdata(chip->dev, chip);
 	mutex_init(&chip->io_lock);
 
 	chip->rtc = i2c_new_dummy_device(chip->i2c->adapter, RTC_I2C_ADDR);
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index 5e1599ac9abc..b572966e1ff6 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -54,8 +54,6 @@ static int wm8400_init(struct wm8400 *wm8400,
 	unsigned int reg;
 	int ret;
 
-	dev_set_drvdata(wm8400->dev, wm8400);
-
 	/* Check that this is actually a WM8400 */
 	ret = regmap_read(wm8400->regmap, WM8400_RESET_ID, &reg);
 	if (ret != 0) {
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index c419ab0c0eae..1b769ac3e53b 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -320,8 +320,6 @@ static int wm8994_device_init(struct wm8994 *wm8994, int irq)
 	if (ret != 0)
 		return ret;
 
-	dev_set_drvdata(wm8994->dev, wm8994);
-
 	/* Add the on-chip regulators first for bootstrapping */
 	ret = mfd_add_devices(wm8994->dev, 0,
 			      wm8994_regulator_devs,
-- 
2.34.1

