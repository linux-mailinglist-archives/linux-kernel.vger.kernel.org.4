Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26866839C7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAaW5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjAaW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:57:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ECA410AE;
        Tue, 31 Jan 2023 14:57:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 5so16666849plo.3;
        Tue, 31 Jan 2023 14:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q69dgLqN6kO5gAwOLys8/HsP5kHBTFUQsrWWIDgTKOA=;
        b=WlyQM2M1BRD/grSwpqjxowafQRbiTF3h/qMkf/UVUkLbjBuEdMjv/YbDWF3nXuur7J
         JCEAelUYFgODW5vL5AuDv6QOf0M3DbsAD/JGdQPzHgmeE7ntQ5+7RGUhF/4zRQ90Wicq
         n4jHkleJL3sHGKF/VrjyrrxqRNpKig2VyaDskDKO5fLtRJYZadqIYNMS0GHYQA+dRicp
         LPV2tCE3RYgEdwlxXKY4TucbW1z0acQjT0v9qi9MmWqjZY0XwdhXjjErQCugoCq9+jHa
         WGk7K3pdwkd0bkwOntpa0dCzo5qCLmdpYm03D8NPTFlk6NF8jwS67G0IcfsSt6bajPOJ
         5NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q69dgLqN6kO5gAwOLys8/HsP5kHBTFUQsrWWIDgTKOA=;
        b=KCWvAg6lVeBCu+rO8Hzry20IZ40vAGuObSkEGTU6lzFUHQIOFlFbxN6sBH3O6nmuKu
         rW3so0wYBJ1+zWmcTueOc8ydDfHbAGk4R4m78Efhb+R6YK5GqtMGN8yFKlwMVwsU2nh7
         pxJJ3F/P7TK2g7ZOs+7ed49jpQxOeZm+kRtseAMKD68QuI/RaLGrTfuszUhWGDDDbEpu
         aCEGHZf1sz/pNreGtiyS2iHkpn2+Ng5M80Q1mAjJpED9Xe2x8H1fZMh+mHtiqe6fR6+o
         NJkbMxbkOggRPdbownEopCdLpfYkAfoSKzJnFdCWh5YLzH2CFmjB8YzDvsHrmfkjdkKb
         1gcw==
X-Gm-Message-State: AO0yUKX6yfwzB33i+s829htob6LhUcECkOKZoBEELP5Kg6GAwp6rN4wL
        zze2humOWHtRVrkL72a+sEQ=
X-Google-Smtp-Source: AK7set9PKo7V/pKdXXqVAGSTAu7KzGfvjB03OhbiIWYP7LFi7RALAmjSfrliCkYrGmvTRSQ1DeTDpw==
X-Received: by 2002:a17:903:2053:b0:194:3cef:31 with SMTP id q19-20020a170903205300b001943cef0031mr487814pla.49.1675205835275;
        Tue, 31 Jan 2023 14:57:15 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:effb:a74f:225a:28ef])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001963bc7bdb8sm10229945plr.274.2023.01.31.14.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:57:13 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc:     Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] backlight: hx8357: stop using of-specific APIs
Date:   Tue, 31 Jan 2023 14:57:07 -0800
Message-Id: <20230131225707.3599889-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
References: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
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

There is no need for this driver to be OF-specific, so switch it to
use device_get_match_data() and stop including various of-related
headers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/video/backlight/hx8357.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index a93e14adb846..2e162a70c1ce 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -10,8 +10,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 
 #define HX8357_NUM_IM_PINS	3
@@ -581,11 +581,15 @@ MODULE_DEVICE_TABLE(of, hx8357_dt_ids);
 
 static int hx8357_probe(struct spi_device *spi)
 {
+	int (*lcd_init_fn)(struct lcd_device *);
 	struct lcd_device *lcdev;
 	struct hx8357_data *lcd;
-	const struct of_device_id *match;
 	int i, ret;
 
+	lcd_init_fn = device_get_match_data(&spi->dev);
+	if (!lcd_init_fn)
+		return -EINVAL;
+
 	lcd = devm_kzalloc(&spi->dev, sizeof(*lcd), GFP_KERNEL);
 	if (!lcd)
 		return -ENOMEM;
@@ -598,10 +602,6 @@ static int hx8357_probe(struct spi_device *spi)
 
 	lcd->spi = spi;
 
-	match = of_match_device(hx8357_dt_ids, &spi->dev);
-	if (!match || !match->data)
-		return -EINVAL;
-
 	lcd->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
 	ret = PTR_ERR_OR_ZERO(lcd->reset);
 	if (ret) {
@@ -647,7 +647,7 @@ static int hx8357_probe(struct spi_device *spi)
 
 	hx8357_lcd_reset(lcdev);
 
-	ret = ((int (*)(struct lcd_device *))match->data)(lcdev);
+	ret = lcd_init_fn(lcdev);
 	if (ret) {
 		dev_err(&spi->dev, "Couldn't initialize panel\n");
 		return ret;
-- 
2.39.1.456.gfc5497dd1b-goog

