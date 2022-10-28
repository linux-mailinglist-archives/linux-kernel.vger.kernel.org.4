Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F52E610F29
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJ1K46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiJ1K4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:56:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFA5C09A0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:56:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g12so6082997wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mybn9+3Djhak9wQ9DmBiM46mD4JHeRWPgXYCo3h5f5w=;
        b=Q/+GNkhTtkLn0ybO6bFbX3iOCxcV5fyw/9MuV0v5MMjsp1XDrO2Y+EC0A2RNJnA2VJ
         JHpf46HOduMlEnYgixSscesqrTf0CKNYeLEWYG4s6cv+C8eCrPSSaxB9/AK05v8wl5z1
         iX5HAxVOVXLJiLwslWeHm/k96HNDP5E/viZco55XgIXkjit2T/8LqwpFTSfrb5jJdg5Z
         VI3YSW0GFIFRZVnqpguoipul3MqI1w8wdHUqmHH2I/+PuX565O9E38CIgrkhSkHdHJXT
         Kj7RFVUdld2LRUrlA0+pj8l3ogDAkGKt2WVkj/2qXb9LEZ2kyg61jC+oBh7ENelylDY0
         kSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mybn9+3Djhak9wQ9DmBiM46mD4JHeRWPgXYCo3h5f5w=;
        b=aBdxRfQjVL2fxzM14QN1DI2GxBWnkNU+OatikYVpqktUsqmXDncbDl+oxemDAFoknS
         4UCby9fk6qI2JDymsPvV93Kf6n8DyH+0TQKtc6bOlbZQ8JLvVddxl/K1mZflqf5veTMg
         HJ+bwJ6E40cPpgSPRNl1HZTEJDNq/71YkjDFNlQ2ozqzK/FmdLyETWKl3bzI0tTrVdc5
         O0tgMuvkWg42Akgn31X75oBnIDlmTknNrzt8YnupdBuzlibUCf0cQX7L/Ajd1KTsi0LP
         yJ46czj0UVo0NtRORtOiLXNOeQVCYeH/vfqQ7r0zsGvzDNyPu+3cV9uL6ToNoJhFCznd
         mjKw==
X-Gm-Message-State: ACrzQf3cXqXRPvSCfPzDf148mdC+S6B0wT1j8t6AYuA0WjD6z9Av51ar
        xCxmYl/GeyKCVb7k4ZtmdlSNgw==
X-Google-Smtp-Source: AMsMyM7MpmCsvPQEd7FYVkmRjOE4Wft0AXUPXYN8BOmP4u7Qym5ebJPKeWw3IzetZWbGmly5kygvTQ==
X-Received: by 2002:a05:6000:1a8d:b0:236:4810:9966 with SMTP id f13-20020a0560001a8d00b0023648109966mr27100200wry.366.1666954608551;
        Fri, 28 Oct 2022 03:56:48 -0700 (PDT)
Received: from dtpc.zanders.be (78-22-137-109.access.telenet.be. [78.22.137.109])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b003cf4ec90938sm4375956wmq.21.2022.10.28.03.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:56:48 -0700 (PDT)
From:   Maarten Zanders <maarten.zanders@mind.be>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Maarten Zanders <maarten.zanders@mind.be>,
        Arne Staessen <a.staessen@televic.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] leds: lp5523: fix out-of-bounds bug in lp5523_selftest()
Date:   Fri, 28 Oct 2022 12:56:43 +0200
Message-Id: <20221028105643.45300-1-maarten.zanders@mind.be>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When not all LED channels of the led chip are configured, the
sysfs selftest functionality gives erroneous results and tries to
test all channels of the chip.
There is a potential for LED overcurrent conditions since the
test current will be set to values from out-of-bound regions.

It is wrong to use pdata->led_config[i].led_current to skip absent
channels as led_config[] only contains the configured LED channels.

Instead of iterating over all the physical channels of the device,
loop over the available LED configurations and use led->chan_nr to
access the correct i2c registers. Keep the zero-check for the LED
current as existing users might depend on this to disable a channel.

Reported-by: Arne Staessen <a.staessen@televic.com>
Signed-off-by: Maarten Zanders <maarten.zanders@mind.be>
---
 drivers/leds/leds-lp5523.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/leds/leds-lp5523.c b/drivers/leds/leds-lp5523.c
index 369d40b0b65b..e08e3de1428d 100644
--- a/drivers/leds/leds-lp5523.c
+++ b/drivers/leds/leds-lp5523.c
@@ -581,8 +581,8 @@ static ssize_t lp5523_selftest(struct device *dev,
 	struct lp55xx_led *led = i2c_get_clientdata(to_i2c_client(dev));
 	struct lp55xx_chip *chip = led->chip;
 	struct lp55xx_platform_data *pdata = chip->pdata;
-	int i, ret, pos = 0;
-	u8 status, adc, vdd;
+	int ret, pos = 0;
+	u8 status, adc, vdd, i;
 
 	mutex_lock(&chip->lock);
 
@@ -612,20 +612,21 @@ static ssize_t lp5523_selftest(struct device *dev,
 
 	vdd--;	/* There may be some fluctuation in measurement */
 
-	for (i = 0; i < LP5523_MAX_LEDS; i++) {
-		/* Skip non-existing channels */
+	for (i = 0; i < pdata->num_channels; i++) {
+		/* Skip disabled channels */
 		if (pdata->led_config[i].led_current == 0)
 			continue;
 
 		/* Set default current */
-		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + i,
+		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + led->chan_nr,
 			pdata->led_config[i].led_current);
 
-		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + i, 0xff);
+		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + led->chan_nr,
+			     0xff);
 		/* let current stabilize 2 - 4ms before measurements start */
 		usleep_range(2000, 4000);
 		lp55xx_write(chip, LP5523_REG_LED_TEST_CTRL,
-			     LP5523_EN_LEDTEST | i);
+			     LP5523_EN_LEDTEST | led->chan_nr);
 		/* ADC conversion time is 2.7 ms typically */
 		usleep_range(3000, 6000);
 		ret = lp55xx_read(chip, LP5523_REG_STATUS, &status);
@@ -633,20 +634,22 @@ static ssize_t lp5523_selftest(struct device *dev,
 			goto fail;
 
 		if (!(status & LP5523_LEDTEST_DONE))
-			usleep_range(3000, 6000);/* Was not ready. Wait. */
+			usleep_range(3000, 6000); /* Was not ready. Wait. */
 
 		ret = lp55xx_read(chip, LP5523_REG_LED_TEST_ADC, &adc);
 		if (ret < 0)
 			goto fail;
 
 		if (adc >= vdd || adc < LP5523_ADC_SHORTCIRC_LIM)
-			pos += sprintf(buf + pos, "LED %d FAIL\n", i);
+			pos += sprintf(buf + pos, "LED %d FAIL\n",
+				       led->chan_nr);
 
-		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + i, 0x00);
+		lp55xx_write(chip, LP5523_REG_LED_PWM_BASE + led->chan_nr,
+			     0x00);
 
 		/* Restore current */
-		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + i,
-			led->led_current);
+		lp55xx_write(chip, LP5523_REG_LED_CURRENT_BASE + led->chan_nr,
+			     led->led_current);
 		led++;
 	}
 	if (pos == 0)
-- 
2.37.3

