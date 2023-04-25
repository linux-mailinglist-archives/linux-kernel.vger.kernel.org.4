Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0F86EDA4C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 04:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjDYCpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 22:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjDYCpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 22:45:34 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D55C49F8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:45:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b5c48ea09so4436600b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 19:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682390732; x=1684982732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nC2IqhvlF0pFbQKP0fIsWzyAhd8byyjLQUY72kObHDM=;
        b=nNaSTF9ueEBG8BHtyG8bSbPZ3SwUl3u+EWmSnJM0UAI8zeIANwqQYq3C1OHCd1pHh0
         JWVpj2nL6rxvrpEPUG3F/DHbzNedTRu2OHOFLLH3o+FQD8MlZ/Ndu1KvUijbLPzysMkd
         9Q2CvIWAdWIQ1khgSKMMd9ucfiVWnis/yWQD52RtggvEcqKeHLoF+L54YiJliSpAbSOm
         9bhW93DAAcTtJAVYZAQIL7SoAtx9qXF+Tm4v+1mwZmDID18Ekg1QKmRvf56d08y14vkT
         ok+gvOHr8xi+gVeofgh4KZ+YtcuuGYpvg73PT2LigrXNvcu9vA4us+5zIqY0rDFG103z
         3uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682390732; x=1684982732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nC2IqhvlF0pFbQKP0fIsWzyAhd8byyjLQUY72kObHDM=;
        b=HgrwH6qyeNiI7LDBuFYeMyw4JCNJKIZYivHVjo5gVXdSPh6dKEsLZga7okzeJTdpZb
         Ze9SRAwvjAOWf0AkH3gmtJOn6Ejpp0aGiQYl6cwezODCzifTgEaMyzkymnAKB06AIYTK
         86CFcDgioMVO/ibBpPb8hLgjmqNmzOXExZTXxSFZaQK+ZITjnVMnxqyPkWoOLB9+H+sS
         n7EKZC6fbfAAy6dY45Qs8GiKLf3DeXd/ekOrtaUtfH69Dp+51h/IW+Ava6Rsps76XxAk
         qoeNNrvxKcce59FH/zN1Q3XEV616lV7XAVgCegz8Vb6qZ49OzFJEVU4kY0f/UmbDVxVI
         YgRQ==
X-Gm-Message-State: AAQBX9cTOrbPiNGuyWQQ3NCKdXVsouCKQKj6gZUmIMrCBfWxEAXh7BB8
        hDtm7W//lGRnYFa7zvEQGsI2dY+zqCTILA==
X-Google-Smtp-Source: AKy350ZHcZI50h6gVuu1ZuDYPtdXykDQYrFt2PLnHKl72fd64YvsYM8plRB9F6q7g/B6WwUCdC7OWw==
X-Received: by 2002:a05:6a00:2193:b0:63d:27a1:d578 with SMTP id h19-20020a056a00219300b0063d27a1d578mr20837015pfi.20.1682390732534;
        Mon, 24 Apr 2023 19:45:32 -0700 (PDT)
Received: from aaron-shen.localdomain ([183.63.252.58])
        by smtp.gmail.com with ESMTPSA id o23-20020a637e57000000b0050bf1d1cdc8sm6997312pgn.21.2023.04.24.19.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 19:45:32 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        Guiting Shen <aarongt.shen@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 RESEND] mfd: remove redundant dev_set_drvdata() from i2c drivers
Date:   Tue, 25 Apr 2023 10:45:26 +0800
Message-Id: <20230425024526.6443-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

the i2c_set_clientdata() is the inline function which is complemented by
the dev_set_drvdata() internally. Do not need to use i2c_set_clientdata()
and dev_set_drvdata() at the same time.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
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

