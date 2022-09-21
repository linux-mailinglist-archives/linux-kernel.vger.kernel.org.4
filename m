Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C395BFD43
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 13:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIULrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiIULrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 07:47:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A0890803
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:41 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id u18so8731941lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 04:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LLcoUfGxhi8reQQCpbbwos0jhsx1cQA+/9CD5zQKs0M=;
        b=ZvYzaoWIkLHxaHgb1owNhrW5mvjGeCP30MWPHhKZencsYNmoiCgM/qIN1b3Sdnav/8
         /y4mBwi/DT7YQX2WTYe370rl7zqprzYbjwebu7S4GjV2CkSMoFBlXKLm5Mu0WCbBJBVH
         ZRoRjLqlQrkKzsw4ErQmUUb6WAEuV7msR5NWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LLcoUfGxhi8reQQCpbbwos0jhsx1cQA+/9CD5zQKs0M=;
        b=jz/ENVa+X/N8tccz8l7EvpupsYKmu5ZLK8ZgDinVeklfWbiHYTxvHef75DTPqaT0tg
         RVuBOwGhjIMAB4n7Dsi3uZdTUhSakiI+7viZqBCPrdcdYUPQ6QsAHsTnxhWqXfzFz7Eh
         41+gbqEm30tJ3QD7GC67q/3H+Kt1MUDvi1lC12wW9SvH7pFTFSoycyDAXip+HY68ThOg
         UmD+BxSFAQcsZw4b2MUjLcCEEcS9hNRRQKVkPfYJnpq9T4FaVhF7bSYYBX1GbV20VxgZ
         fxGzaZLToeNHdjEy3aawp1KwPR5VOQ/E1As+e9qwM3/sY4HrkFBEeOaBhLZFdMhBCZiF
         k7Gw==
X-Gm-Message-State: ACrzQf1qEadajUF3QQTpmEDwKHa4kdkQxl0gzQHwMY4emBn/CmYjKFdo
        E0bgW4HvDl35Dbk7JW97gN5QCJuEUT72RM7wVzI=
X-Google-Smtp-Source: AMsMyM42zVJ/5O/dK+uV1a8A97tuD+lBAW/Jsfjfyc7+cyT/DkNvqZ89pb+KQYVTWfx54lzf7He9+Q==
X-Received: by 2002:a05:6512:3d2a:b0:49a:92d:cddd with SMTP id d42-20020a0565123d2a00b0049a092dcdddmr10220106lfv.590.1663760801021;
        Wed, 21 Sep 2022 04:46:41 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g4-20020a056512118400b00494618889c0sm405713lfr.42.2022.09.21.04.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 04:46:40 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] rtc: isl12022: switch to using regmap API
Date:   Wed, 21 Sep 2022 13:46:23 +0200
Message-Id: <20220921114624.3250848-9-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <20220921114624.3250848-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap abstraction allows us to avoid the private i2c transfer
helpers, and also offers some nice utility functions such as the
regmap_update_bits family.

While at it, simplify the code even more by not keeping track of
->write_enabled: rtc_set_time is not a hot path, so one extra i2c read
doesn't hurt (regmap_update_bits elides the write when the bits are
already as desired).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/Kconfig        |   1 +
 drivers/rtc/rtc-isl12022.c | 110 +++++++++----------------------------
 2 files changed, 26 insertions(+), 85 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b8de25118ad0..bb63edb507da 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -423,6 +423,7 @@ config RTC_DRV_ISL1208
 
 config RTC_DRV_ISL12022
 	tristate "Intersil ISL12022"
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the
 	  Intersil ISL12022 RTC chip.
diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 6fb13a5d17f1..ca677c4265e6 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/regmap.h>
 
 /* ISL register offsets */
 #define ISL12022_REG_SC		0x00
@@ -42,72 +43,21 @@ static struct i2c_driver isl12022_driver;
 
 struct isl12022 {
 	struct rtc_device *rtc;
-
-	bool write_enabled;	/* true if write enable is set */
+	struct regmap *regmap;
 };
 
-
-static int isl12022_read_regs(struct i2c_client *client, uint8_t reg,
-			      uint8_t *data, size_t n)
-{
-	struct i2c_msg msgs[] = {
-		{
-			.addr	= client->addr,
-			.flags	= 0,
-			.len	= 1,
-			.buf	= data
-		},		/* setup read ptr */
-		{
-			.addr	= client->addr,
-			.flags	= I2C_M_RD,
-			.len	= n,
-			.buf	= data
-		}
-	};
-
-	int ret;
-
-	data[0] = reg;
-	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
-	if (ret != ARRAY_SIZE(msgs)) {
-		dev_err(&client->dev, "%s: read error, ret=%d\n",
-			__func__, ret);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-
-static int isl12022_write_reg(struct i2c_client *client,
-			      uint8_t reg, uint8_t val)
-{
-	uint8_t data[2] = { reg, val };
-	int err;
-
-	err = i2c_master_send(client, data, sizeof(data));
-	if (err != sizeof(data)) {
-		dev_err(&client->dev,
-			"%s: err=%d addr=%02x, data=%02x\n",
-			__func__, err, data[0], data[1]);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-
 /*
  * In the routines that deal directly with the isl12022 hardware, we use
  * rtc_time -- month 0-11, hour 0-23, yr = calendar year-epoch.
  */
 static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
+	struct isl12022 *isl12022 = dev_get_drvdata(dev);
+	struct regmap *regmap = isl12022->regmap;
 	uint8_t buf[ISL12022_REG_INT + 1];
 	int ret;
 
-	ret = isl12022_read_regs(client, ISL12022_REG_SC, buf, sizeof(buf));
+	ret = regmap_bulk_read(regmap, ISL12022_REG_SC, buf, sizeof(buf));
 	if (ret)
 		return ret;
 
@@ -148,33 +98,18 @@ static int isl12022_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct i2c_client *client = to_i2c_client(dev);
 	struct isl12022 *isl12022 = dev_get_drvdata(dev);
-	size_t i;
+	struct regmap *regmap = isl12022->regmap;
 	int ret;
 	uint8_t buf[ISL12022_REG_DW + 1];
 
 	dev_dbg(dev, "%s: %ptR\n", __func__, tm);
 
-	if (!isl12022->write_enabled) {
-
-		ret = isl12022_read_regs(client, ISL12022_REG_INT, buf, 1);
-		if (ret)
-			return ret;
-
-		/* Check if WRTC (write rtc enable) is set factory default is
-		 * 0 (not set) */
-		if (!(buf[0] & ISL12022_INT_WRTC)) {
-			/* Set the write enable bit. */
-			ret = isl12022_write_reg(client,
-						 ISL12022_REG_INT,
-						 buf[0] | ISL12022_INT_WRTC);
-			if (ret)
-				return ret;
-		}
-
-		isl12022->write_enabled = true;
-	}
+	/* Ensure the write enable bit is set. */
+	ret = regmap_update_bits(regmap, ISL12022_REG_INT,
+				 ISL12022_INT_WRTC, ISL12022_INT_WRTC);
+	if (ret)
+		return ret;
 
 	/* hours, minutes and seconds */
 	buf[ISL12022_REG_SC] = bin2bcd(tm->tm_sec);
@@ -191,15 +126,8 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	buf[ISL12022_REG_DW] = tm->tm_wday & 0x07;
 
-	/* write register's data */
-	for (i = 0; i < ARRAY_SIZE(buf); i++) {
-		ret = isl12022_write_reg(client, ISL12022_REG_SC + i,
-					 buf[ISL12022_REG_SC + i]);
-		if (ret)
-			return -EIO;
-	}
-
-	return 0;
+	return regmap_bulk_write(isl12022->regmap, ISL12022_REG_SC,
+				 buf, sizeof(buf));
 }
 
 static const struct rtc_class_ops isl12022_rtc_ops = {
@@ -207,6 +135,12 @@ static const struct rtc_class_ops isl12022_rtc_ops = {
 	.set_time	= isl12022_rtc_set_time,
 };
 
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_write = true,
+};
+
 static int isl12022_probe(struct i2c_client *client)
 {
 	struct isl12022 *isl12022;
@@ -220,6 +154,12 @@ static int isl12022_probe(struct i2c_client *client)
 		return -ENOMEM;
 	dev_set_drvdata(&client->dev, isl12022);
 
+	isl12022->regmap = devm_regmap_init_i2c(client, &regmap_config);
+	if (IS_ERR(isl12022->regmap)) {
+		dev_err(&client->dev, "regmap allocation failed\n");
+		return PTR_ERR(isl12022->regmap);
+	}
+
 	isl12022->rtc = devm_rtc_allocate_device(&client->dev);
 	if (IS_ERR(isl12022->rtc))
 		return PTR_ERR(isl12022->rtc);
-- 
2.37.2

