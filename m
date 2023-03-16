Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E636BD99C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjCPTzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCPTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0BAB78B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cn6so2786958pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbpvfVLvNypD0qOELLFfukTbZqcwnB7TBm1h1DwpsgE=;
        b=i6mwoWd8QrhdXtyg+h9faFuBWAGT9si6KasfgYgb6S2mv9AdlAYRIOakoDvstgVNRh
         uUKlGzs2tR1QTRlHDA0VlIUyCVdYwYU1FDcnrror9NQZaWs0CsD0OpW3HNMjZo3qnl7b
         2WuooSvZWIRJOv9wNhI/E46jeqFbD7/0+lmBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbpvfVLvNypD0qOELLFfukTbZqcwnB7TBm1h1DwpsgE=;
        b=LZ50lJ+HEEzezLA6lH54gzc06oUjyGhId7YeggpR6/HGAVfTwwEWebPZYDm/G6EyFU
         xnFKd0hQV+wyzsa/fndjYx05vcso81X98C4cOYsu4XBUuq/Jcvp0G+eOQXtvFMsnEPl5
         PL4DY/a+tyqWDUh/A/yGkmS/LoFNU4/eopi7YGpTrc5tB9kY823VqJeBBjGLi/pRa7NM
         rE4h3IQ1XP8+ZLcz41wNzaHoJOXOCQL1LAzuEEKLJGxSTWpaYEe1RY5QKxU1TLMSqpt8
         vq06PKlzw+WZWcoyiU1IxZ2S2/Opy7maBpkaf6yuK3oCxkTL3pPVBbhrc0p7MuOZQvig
         w9sw==
X-Gm-Message-State: AO0yUKXwbaWZtsBJw/k3MTxO6NDXcm0q/oSnKUKiniirIgg51U9i3Eb4
        xOFWrEVUsjAn20vgpoZusoSM/A==
X-Google-Smtp-Source: AK7set8J+TcOpnUTOdnYvRr1V2vAKKL/RN0Y44pPfS/8fU/zX4bO6kqO31d1+sv7UH/LbPt6hxaQuQ==
X-Received: by 2002:a05:6a20:734b:b0:d5:74f:37a1 with SMTP id v11-20020a056a20734b00b000d5074f37a1mr5429602pzc.27.1678996521247;
        Thu, 16 Mar 2023 12:55:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 4/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.4 and 5.10
Date:   Thu, 16 Mar 2023 12:54:41 -0700
Message-Id: <20230316125351.4.I01f21c98901641a009890590ddc1354c0f294e5e@changeid>
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
in Linux 5.4 but did exist in Linux 5.10.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/bd71828-regulator.c          | 3 ++-
 drivers/regulator/bd9576-regulator.c           | 1 +
 drivers/regulator/cros-ec-regulator.c          | 1 +
 drivers/regulator/fan53880.c                   | 1 +
 drivers/regulator/max77826-regulator.c         | 1 +
 drivers/regulator/mp5416.c                     | 1 +
 drivers/regulator/mp8859.c                     | 1 +
 drivers/regulator/mp886x.c                     | 1 +
 drivers/regulator/mpq7920.c                    | 1 +
 drivers/regulator/mt6360-regulator.c           | 1 +
 drivers/regulator/pca9450-regulator.c          | 1 +
 drivers/regulator/qcom-labibb-regulator.c      | 1 +
 drivers/regulator/qcom_usb_vbus-regulator.c    | 1 +
 drivers/regulator/rpi-panel-attiny-regulator.c | 1 +
 drivers/regulator/rt4801-regulator.c           | 1 +
 drivers/regulator/rtmv20-regulator.c           | 1 +
 drivers/regulator/sy8827n.c                    | 1 +
 drivers/regulator/vqmmc-ipq4019-regulator.c    | 1 +
 18 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index ad728f4f2241..f3205dc9d4fc 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -771,7 +771,8 @@ static int bd71828_probe(struct platform_device *pdev)
 
 static struct platform_driver bd71828_regulator = {
 	.driver = {
-		.name = "bd71828-pmic"
+		.name = "bd71828-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = bd71828_probe,
 };
diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index 02c70768652b..d4ca7b3f4036 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -1126,6 +1126,7 @@ MODULE_DEVICE_TABLE(platform, bd957x_pmic_id);
 static struct platform_driver bd957x_regulator = {
 	.driver = {
 		.name = "bd957x-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = bd957x_probe,
 	.id_table = bd957x_pmic_id,
diff --git a/drivers/regulator/cros-ec-regulator.c b/drivers/regulator/cros-ec-regulator.c
index 1591636f86c3..fb9643ed7a49 100644
--- a/drivers/regulator/cros-ec-regulator.c
+++ b/drivers/regulator/cros-ec-regulator.c
@@ -215,6 +215,7 @@ static struct platform_driver cros_ec_regulator_driver = {
 	.probe		= cros_ec_regulator_probe,
 	.driver		= {
 		.name		= "cros-ec-regulator",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = regulator_cros_ec_of_match,
 	},
 };
diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index 1d88d5381544..a3bebdee570e 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -172,6 +172,7 @@ MODULE_DEVICE_TABLE(i2c, fan53880_i2c_id);
 static struct i2c_driver fan53880_regulator_driver = {
 	.driver = {
 		.name = "fan53880",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= fan53880_dt_ids,
 	},
 	.probe_new = fan53880_i2c_probe,
diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/max77826-regulator.c
index f9e2e884ff54..ea5d4b18b464 100644
--- a/drivers/regulator/max77826-regulator.c
+++ b/drivers/regulator/max77826-regulator.c
@@ -289,6 +289,7 @@ MODULE_DEVICE_TABLE(i2c, max77826_id);
 static struct i2c_driver max77826_regulator_driver = {
 	.driver = {
 		.name = "max77826",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(max77826_of_match),
 	},
 	.probe_new = max77826_i2c_probe,
diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 82892d71c2c9..91e9019430b8 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -237,6 +237,7 @@ MODULE_DEVICE_TABLE(i2c, mp5416_id);
 static struct i2c_driver mp5416_regulator_driver = {
 	.driver = {
 		.name = "mp5416",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mp5416_of_match),
 	},
 	.probe_new = mp5416_i2c_probe,
diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index f893dadf2abb..b968a682f38a 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -144,6 +144,7 @@ MODULE_DEVICE_TABLE(i2c, mp8859_i2c_id);
 static struct i2c_driver mp8859_regulator_driver = {
 	.driver = {
 		.name = "mp8859",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mp8859_dt_id),
 	},
 	.probe_new = mp8859_i2c_probe,
diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 6a0c94c15027..250c27e462f1 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -362,6 +362,7 @@ MODULE_DEVICE_TABLE(i2c, mp886x_id);
 static struct i2c_driver mp886x_regulator_driver = {
 	.driver = {
 		.name = "mp886x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = mp886x_dt_ids,
 	},
 	.probe_new = mp886x_i2c_probe,
diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index 54c862edf571..544d41b88514 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -318,6 +318,7 @@ MODULE_DEVICE_TABLE(i2c, mpq7920_id);
 static struct i2c_driver mpq7920_regulator_driver = {
 	.driver = {
 		.name = "mpq7920",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mpq7920_of_match),
 	},
 	.probe_new = mpq7920_i2c_probe,
diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
index 4d34be94d166..ad6587a378d0 100644
--- a/drivers/regulator/mt6360-regulator.c
+++ b/drivers/regulator/mt6360-regulator.c
@@ -446,6 +446,7 @@ MODULE_DEVICE_TABLE(platform, mt6360_regulator_id_table);
 static struct platform_driver mt6360_regulator_driver = {
 	.driver = {
 		.name = "mt6360-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6360_regulator_probe,
 	.id_table = mt6360_regulator_id_table,
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index c6351fac9f4d..87a746dcb516 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -872,6 +872,7 @@ MODULE_DEVICE_TABLE(of, pca9450_of_match);
 static struct i2c_driver pca9450_i2c_driver = {
 	.driver = {
 		.name = "nxp-pca9450",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = pca9450_of_match,
 	},
 	.probe_new = pca9450_i2c_probe,
diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
index bcf7140f3bc9..a8698ca61143 100644
--- a/drivers/regulator/qcom-labibb-regulator.c
+++ b/drivers/regulator/qcom-labibb-regulator.c
@@ -894,6 +894,7 @@ static int qcom_labibb_regulator_probe(struct platform_device *pdev)
 static struct platform_driver qcom_labibb_regulator_driver = {
 	.driver	= {
 		.name = "qcom-lab-ibb-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= qcom_labibb_match,
 	},
 	.probe = qcom_labibb_regulator_probe,
diff --git a/drivers/regulator/qcom_usb_vbus-regulator.c b/drivers/regulator/qcom_usb_vbus-regulator.c
index 2e627c2b6c51..57ec613f4a0a 100644
--- a/drivers/regulator/qcom_usb_vbus-regulator.c
+++ b/drivers/regulator/qcom_usb_vbus-regulator.c
@@ -100,6 +100,7 @@ MODULE_DEVICE_TABLE(of, qcom_usb_vbus_regulator_match);
 static struct platform_driver qcom_usb_vbus_regulator_driver = {
 	.driver		= {
 		.name	= "qcom-usb-vbus-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = qcom_usb_vbus_regulator_match,
 	},
 	.probe		= qcom_usb_vbus_regulator_probe,
diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 34514976475e..9afe961a87f1 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -396,6 +396,7 @@ MODULE_DEVICE_TABLE(of, attiny_dt_ids);
 static struct i2c_driver attiny_regulator_driver = {
 	.driver = {
 		.name = "rpi_touchscreen_attiny",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(attiny_dt_ids),
 	},
 	.probe_new = attiny_i2c_probe,
diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
index 563d79196fdd..be3dc981195c 100644
--- a/drivers/regulator/rt4801-regulator.c
+++ b/drivers/regulator/rt4801-regulator.c
@@ -239,6 +239,7 @@ MODULE_DEVICE_TABLE(of, rt4801_of_id);
 static struct i2c_driver rt4801_driver = {
 	.driver = {
 		.name = "rt4801",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(rt4801_of_id),
 	},
 	.probe_new = rt4801_probe,
diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 2ee334174e2b..7cbb812477e1 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -425,6 +425,7 @@ MODULE_DEVICE_TABLE(of, rtmv20_of_id);
 static struct i2c_driver rtmv20_driver = {
 	.driver = {
 		.name = "rtmv20",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(rtmv20_of_id),
 		.pm = &rtmv20_pm,
 	},
diff --git a/drivers/regulator/sy8827n.c b/drivers/regulator/sy8827n.c
index 936a94b6df5b..99ca08cc3a6a 100644
--- a/drivers/regulator/sy8827n.c
+++ b/drivers/regulator/sy8827n.c
@@ -187,6 +187,7 @@ MODULE_DEVICE_TABLE(i2c, sy8827n_id);
 static struct i2c_driver sy8827n_regulator_driver = {
 	.driver = {
 		.name = "sy8827n-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sy8827n_dt_ids,
 	},
 	.probe_new = sy8827n_i2c_probe,
diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index c4213f096fe5..086da36abc0b 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -89,6 +89,7 @@ static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
 	.driver = {
 		.name = "vqmmc-ipq4019-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(regulator_ipq4019_of_match),
 	},
 };
-- 
2.40.0.rc1.284.g88254d51c5-goog

