Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAFF6BD99D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCPTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCPTzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:33 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709BCBBB16
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id i5so2986689pla.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aN/2yxZboB48VnM7tVK4uHzpBhouqNbdrG9gsezrWAY=;
        b=Kg2rFV191+QpIPoumZ7hufXSR/Z+zdbkGmGZjvwmFFR50U21dmGfafK64AeBJOYAfh
         k+0+sndtIXEe8i+DmoFCfmxTrtQUtoXHZi5XYE20Iju7Cgxh0ooIobnTCO7KllccUWb6
         Kv+QfAsYlt/g+5+TR/6ES8GfLLzZbortrJogA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aN/2yxZboB48VnM7tVK4uHzpBhouqNbdrG9gsezrWAY=;
        b=KprcQAJhKEpH9iu3syYMtiL/xZWzUbKbT6roNGTqiOwJAsXnSOqi4P1oq1emG1WRkV
         SlHezI/CqowBmdVQCt/UXFowE5WXG1O+KfEknT9KJbhLnuUyQ9UcZh0xD8q8JW8me+We
         2iyaQaIt1JKlv80dmL2jRRlCsoY2L7wIovIUXdy+Xz2ed49oMlUxTRDZ+ySFNMQJ3Try
         sHiehs278m6Pr2mJkioWtopwDWvOvtAImaYPAaXOy7E6JLEXv73WYDFBdRti4oVcDSjV
         C4NLyKYKuV3rtMUjJWAIQ8YVeFYvzhiHUl8OY01OB8qdM1uLGBGE+mLZ88BnIYAKy3En
         Ci2A==
X-Gm-Message-State: AO0yUKUROXxWYm8cEtUGmg8Q7pEGtET8hbyD2fTg8XSVYAJGwrbBiVA5
        R23Ze47UhQjQSb0o6KJJD1KHzQ==
X-Google-Smtp-Source: AK7set/7KC6KsdcAGQYjUxnx/bRvq+g+ApapEHiPKz1ABg5rFLxbXY1cfIHHWMs9LU5jHQHt+2nUMw==
X-Received: by 2002:a05:6a20:1327:b0:d3:72c6:b018 with SMTP id g39-20020a056a20132700b000d372c6b018mr3839283pzh.39.1678996524831;
        Thu, 16 Mar 2023 12:55:24 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 6/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.15 and 6.1
Date:   Thu, 16 Mar 2023 12:54:43 -0700
Message-Id: <20230316125351.6.Ibc8a86ddd5055ebbbe487a529199db7b36ccad1a@changeid>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230316195444.3946980-1-dianders@chromium.org>
References: <20230316195444.3946980-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This follows on the change ("regulator: Set PROBE_PREFER_ASYNCHRONOUS
for drivers that existed in 4.14") but changes regulators didn't exist
in Linux 5.15 but did exist in Linux 6.1.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/max20086-regulator.c | 1 +
 drivers/regulator/max597x-regulator.c  | 1 +
 drivers/regulator/mt6331-regulator.c   | 1 +
 drivers/regulator/mt6332-regulator.c   | 1 +
 drivers/regulator/mt6370-regulator.c   | 1 +
 drivers/regulator/rt5120-regulator.c   | 1 +
 drivers/regulator/rt5190a-regulator.c  | 1 +
 drivers/regulator/rt5759-regulator.c   | 1 +
 drivers/regulator/sm5703-regulator.c   | 1 +
 drivers/regulator/tps6286x-regulator.c | 1 +
 drivers/regulator/tps65219-regulator.c | 1 +
 drivers/regulator/tps68470-regulator.c | 1 +
 12 files changed, 12 insertions(+)

diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index c98a72f43935..ace1d582a191 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -320,6 +320,7 @@ MODULE_DEVICE_TABLE(of, max20086_dt_ids);
 static struct i2c_driver max20086_regulator_driver = {
 	.driver = {
 		.name = "max20086",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(max20086_dt_ids),
 	},
 	.probe_new = max20086_i2c_probe,
diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
index 648e3641885a..7873a5267555 100644
--- a/drivers/regulator/max597x-regulator.c
+++ b/drivers/regulator/max597x-regulator.c
@@ -501,6 +501,7 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 static struct platform_driver max597x_regulator_driver = {
 	.driver = {
 		.name = "max597x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = max597x_regulator_probe,
 };
diff --git a/drivers/regulator/mt6331-regulator.c b/drivers/regulator/mt6331-regulator.c
index 56be9a3a84ab..0059f88c6fd7 100644
--- a/drivers/regulator/mt6331-regulator.c
+++ b/drivers/regulator/mt6331-regulator.c
@@ -495,6 +495,7 @@ MODULE_DEVICE_TABLE(platform, mt6331_platform_ids);
 static struct platform_driver mt6331_regulator_driver = {
 	.driver = {
 		.name = "mt6331-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6331_regulator_probe,
 	.id_table = mt6331_platform_ids,
diff --git a/drivers/regulator/mt6332-regulator.c b/drivers/regulator/mt6332-regulator.c
index 77a27d8127a3..8d8331a2aca5 100644
--- a/drivers/regulator/mt6332-regulator.c
+++ b/drivers/regulator/mt6332-regulator.c
@@ -410,6 +410,7 @@ MODULE_DEVICE_TABLE(platform, mt6332_platform_ids);
 static struct platform_driver mt6332_regulator_driver = {
 	.driver = {
 		.name = "mt6332-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6332_regulator_probe,
 	.id_table = mt6332_platform_ids,
diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
index e73f5a46cb9a..27cb32b726e0 100644
--- a/drivers/regulator/mt6370-regulator.c
+++ b/drivers/regulator/mt6370-regulator.c
@@ -379,6 +379,7 @@ MODULE_DEVICE_TABLE(platform, mt6370_devid_table);
 static struct platform_driver mt6370_regulator_driver = {
 	.driver = {
 		.name = "mt6370-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table = mt6370_devid_table,
 	.probe = mt6370_regulator_probe,
diff --git a/drivers/regulator/rt5120-regulator.c b/drivers/regulator/rt5120-regulator.c
index 8173ede09414..a388ac70865f 100644
--- a/drivers/regulator/rt5120-regulator.c
+++ b/drivers/regulator/rt5120-regulator.c
@@ -409,6 +409,7 @@ MODULE_DEVICE_TABLE(platform, rt5120_regulator_dev_table);
 static struct platform_driver rt5120_regulator_driver = {
 	.driver = {
 		.name = "rt5120-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table = rt5120_regulator_dev_table,
 	.probe = rt5120_regulator_probe,
diff --git a/drivers/regulator/rt5190a-regulator.c b/drivers/regulator/rt5190a-regulator.c
index 4a3397b32582..f6c12f87fb8d 100644
--- a/drivers/regulator/rt5190a-regulator.c
+++ b/drivers/regulator/rt5190a-regulator.c
@@ -505,6 +505,7 @@ MODULE_DEVICE_TABLE(of, rt5190a_device_table);
 static struct i2c_driver rt5190a_driver = {
 	.driver = {
 		.name = "rt5190a",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rt5190a_device_table,
 	},
 	.probe_new = rt5190a_probe,
diff --git a/drivers/regulator/rt5759-regulator.c b/drivers/regulator/rt5759-regulator.c
index 8488417f4b2c..d5a42ad21a9a 100644
--- a/drivers/regulator/rt5759-regulator.c
+++ b/drivers/regulator/rt5759-regulator.c
@@ -359,6 +359,7 @@ MODULE_DEVICE_TABLE(of, rt5759_device_table);
 static struct i2c_driver rt5759_driver = {
 	.driver = {
 		.name = "rt5759",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(rt5759_device_table),
 	},
 	.probe_new = rt5759_probe,
diff --git a/drivers/regulator/sm5703-regulator.c b/drivers/regulator/sm5703-regulator.c
index 05ad28fc4da8..38e66df378a5 100644
--- a/drivers/regulator/sm5703-regulator.c
+++ b/drivers/regulator/sm5703-regulator.c
@@ -155,6 +155,7 @@ MODULE_DEVICE_TABLE(platform, sm5703_regulator_id);
 static struct platform_driver sm5703_regulator_driver = {
 	.driver = {
 		.name = "sm5703-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= sm5703_regulator_probe,
 	.id_table	= sm5703_regulator_id,
diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index 207ac1d1d88d..f92e7649d0a0 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -147,6 +147,7 @@ MODULE_DEVICE_TABLE(i2c, tps6286x_i2c_id);
 static struct i2c_driver tps6286x_regulator_driver = {
 	.driver = {
 		.name = "tps6286x",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(tps6286x_dt_ids),
 	},
 	.probe_new = tps6286x_i2c_probe,
diff --git a/drivers/regulator/tps65219-regulator.c b/drivers/regulator/tps65219-regulator.c
index 4b5acaa45049..b1719ee990ab 100644
--- a/drivers/regulator/tps65219-regulator.c
+++ b/drivers/regulator/tps65219-regulator.c
@@ -380,6 +380,7 @@ MODULE_DEVICE_TABLE(platform, tps65219_regulator_id_table);
 static struct platform_driver tps65219_regulator_driver = {
 	.driver = {
 		.name = "tps65219-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps65219_regulator_probe,
 	.id_table = tps65219_regulator_id_table,
diff --git a/drivers/regulator/tps68470-regulator.c b/drivers/regulator/tps68470-regulator.c
index 4bca7c4128ab..de7db7690f6b 100644
--- a/drivers/regulator/tps68470-regulator.c
+++ b/drivers/regulator/tps68470-regulator.c
@@ -175,6 +175,7 @@ static int tps68470_regulator_probe(struct platform_device *pdev)
 static struct platform_driver tps68470_regulator_driver = {
 	.driver = {
 		.name = "tps68470-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps68470_regulator_probe,
 };
-- 
2.40.0.rc1.284.g88254d51c5-goog

