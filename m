Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0426BD99E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCPTzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C9CBBB04
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bj12so1828885pfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJSbhHV1Q0FrAeOqUGtYfvxCngRVZe75zrLMqpQaq8o=;
        b=E6wJ8J7u3i09RdDP9yqfkt8aGNY1gK6Ly3JWNGVNTxUbQlYcSSkI3b7MFu1BL3lxGV
         xGBYR/E9Tph6fgj46lIeBI2t6cHbQhiKIrkPkCRst886QSkLctKbPc5w5/c9ZjVFPWOi
         I31saHTKos9hLF/mcj84hUUizI+3+Q/kk3ZWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJSbhHV1Q0FrAeOqUGtYfvxCngRVZe75zrLMqpQaq8o=;
        b=f9ql4eR2wnqwCCXwfOv2qylKbbkjiSkvnxizrFMcfnL8P3H7KJabgAmrKSLASSaWGm
         yS0xqYOYPJXWt9ZtvleVqv0NbfLqHytiAQIqSwaaNpamvJkjI9TCntFXbjVOv3OgJGxe
         7n6FmKZnxWahFK29jlVpT9CHzCDuRF3zuYttPNZZPqaiOpKTcHR+YKyP5eBRKksee99A
         +BLQOecPAC8oZPi2B9KzsgUHmsYhJns/dUHDT/VYAuLw9bxXYOFal+q5FmrOx9HpZBKe
         LxunuHJNG1moDlqhncIeEcPk+cFQhaLf83Ptwzoidv0IEtN9g+XLYFsriQaRmT6c1H+v
         FTPQ==
X-Gm-Message-State: AO0yUKW+QVZUrnTidfrtJaUGxVHOnDnP+PLldKI9vBUJ6c8olHreY22J
        Fij4XRLtR5p9bJgy7S+d5Uxs6g==
X-Google-Smtp-Source: AK7set+WHK49NCSw1XPvRYD3u5J9KrgItHRp9ckBuZbA2JmgiYFsqR1OhvUZth2eYhXhQEBmM1gzBQ==
X-Received: by 2002:a05:6a00:13a4:b0:5a8:c469:e47c with SMTP id t36-20020a056a0013a400b005a8c469e47cmr666456pfg.10.1678996522828;
        Thu, 16 Mar 2023 12:55:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 5/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 5.10 and 5.15
Date:   Thu, 16 Mar 2023 12:54:42 -0700
Message-Id: <20230316125351.5.Ia0e6d859bdfe42ea5c187fb1eb4705c1b5ea23a1@changeid>
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
in Linux 5.10 but did exist in Linux 5.15.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/atc260x-regulator.c    | 1 +
 drivers/regulator/bd71815-regulator.c    | 1 +
 drivers/regulator/da9121-regulator.c     | 1 +
 drivers/regulator/hi6421v600-regulator.c | 1 +
 drivers/regulator/max8893.c              | 1 +
 drivers/regulator/mt6315-regulator.c     | 1 +
 drivers/regulator/mt6359-regulator.c     | 1 +
 drivers/regulator/mtk-dvfsrc-regulator.c | 1 +
 drivers/regulator/pf8x00-regulator.c     | 1 +
 drivers/regulator/rt4831-regulator.c     | 1 +
 drivers/regulator/rt6160-regulator.c     | 1 +
 drivers/regulator/rt6245-regulator.c     | 1 +
 drivers/regulator/rtq2134-regulator.c    | 1 +
 drivers/regulator/rtq6752-regulator.c    | 1 +
 drivers/regulator/sy7636a-regulator.c    | 1 +
 15 files changed, 15 insertions(+)

diff --git a/drivers/regulator/atc260x-regulator.c b/drivers/regulator/atc260x-regulator.c
index 485e58b264c0..87e237d740bc 100644
--- a/drivers/regulator/atc260x-regulator.c
+++ b/drivers/regulator/atc260x-regulator.c
@@ -530,6 +530,7 @@ static struct platform_driver atc260x_regulator_driver = {
 	.probe = atc260x_regulator_probe,
 	.driver = {
 		.name = "atc260x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index f4eaea732de7..475b1e0110e7 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -619,6 +619,7 @@ MODULE_DEVICE_TABLE(platform, bd7181x_pmic_id);
 static struct platform_driver bd7181x_regulator = {
 	.driver = {
 		.name = "bd7181x-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = bd7181x_probe,
 	.id_table = bd7181x_pmic_id,
diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index d016e049d264..6ce0fdc18b9c 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1194,6 +1194,7 @@ MODULE_DEVICE_TABLE(i2c, da9121_i2c_id);
 static struct i2c_driver da9121_regulator_driver = {
 	.driver = {
 		.name = "da9121",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(da9121_dt_ids),
 	},
 	.probe_new = da9121_i2c_probe,
diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index 4671678f6b19..4e10daa1e689 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -284,6 +284,7 @@ static struct platform_driver hi6421_spmi_regulator_driver = {
 	.id_table = hi6421_spmi_regulator_table,
 	.driver = {
 		.name = "hi6421v600-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= hi6421_spmi_regulator_probe,
 };
diff --git a/drivers/regulator/max8893.c b/drivers/regulator/max8893.c
index 1519bf760da7..10ffd77828b7 100644
--- a/drivers/regulator/max8893.c
+++ b/drivers/regulator/max8893.c
@@ -171,6 +171,7 @@ static struct i2c_driver max8893_driver = {
 	.probe_new	= max8893_probe_new,
 	.driver		= {
 		.name	= "max8893",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(max8893_dt_match),
 	},
 	.id_table	= max8893_ids,
diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index 284c229e1aa4..8047081ea2f7 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -287,6 +287,7 @@ static void mt6315_regulator_shutdown(struct spmi_device *pdev)
 static struct spmi_driver mt6315_regulator_driver = {
 	.driver		= {
 		.name	= "mt6315-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = mt6315_of_match,
 	},
 	.probe = mt6315_regulator_probe,
diff --git a/drivers/regulator/mt6359-regulator.c b/drivers/regulator/mt6359-regulator.c
index de3b0462832c..1849566784ab 100644
--- a/drivers/regulator/mt6359-regulator.c
+++ b/drivers/regulator/mt6359-regulator.c
@@ -982,6 +982,7 @@ MODULE_DEVICE_TABLE(platform, mt6359_platform_ids);
 static struct platform_driver mt6359_regulator_driver = {
 	.driver = {
 		.name = "mt6359-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6359_regulator_probe,
 	.id_table = mt6359_platform_ids,
diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
index 234af3a66c77..efca67207a5a 100644
--- a/drivers/regulator/mtk-dvfsrc-regulator.c
+++ b/drivers/regulator/mtk-dvfsrc-regulator.c
@@ -194,6 +194,7 @@ static int dvfsrc_vcore_regulator_probe(struct platform_device *pdev)
 static struct platform_driver mtk_dvfsrc_regulator_driver = {
 	.driver = {
 		.name  = "mtk-dvfsrc-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = dvfsrc_vcore_regulator_probe,
 };
diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 5d319fb81288..99a15c3be396 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -607,6 +607,7 @@ static struct i2c_driver pf8x00_regulator_driver = {
 	.id_table = pf8x00_i2c_id,
 	.driver = {
 		.name = "pf8x00",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = pf8x00_dt_ids,
 	},
 	.probe_new = pf8x00_i2c_probe,
diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
index 2016062cd7ef..97e6f7e2a0ba 100644
--- a/drivers/regulator/rt4831-regulator.c
+++ b/drivers/regulator/rt4831-regulator.c
@@ -194,6 +194,7 @@ MODULE_DEVICE_TABLE(platform, rt4831_regulator_match);
 static struct platform_driver rt4831_regulator_driver = {
 	.driver = {
 		.name = "rt4831-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table = rt4831_regulator_match,
 	.probe = rt4831_regulator_probe,
diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index 5d7b0e7ad69a..8990dac23460 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -308,6 +308,7 @@ MODULE_DEVICE_TABLE(of, rt6160_of_match_table);
 static struct i2c_driver rt6160_driver = {
 	.driver = {
 		.name = "rt6160",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rt6160_of_match_table,
 	},
 	.probe_new = rt6160_probe,
diff --git a/drivers/regulator/rt6245-regulator.c b/drivers/regulator/rt6245-regulator.c
index cb22a207e9ff..8721d11c7964 100644
--- a/drivers/regulator/rt6245-regulator.c
+++ b/drivers/regulator/rt6245-regulator.c
@@ -243,6 +243,7 @@ MODULE_DEVICE_TABLE(of, rt6245_of_match_table);
 static struct i2c_driver rt6245_driver = {
 	.driver = {
 		.name = "rt6245",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rt6245_of_match_table,
 	},
 	.probe_new = rt6245_probe,
diff --git a/drivers/regulator/rtq2134-regulator.c b/drivers/regulator/rtq2134-regulator.c
index 8e13dea354a2..ee1577dc3cfc 100644
--- a/drivers/regulator/rtq2134-regulator.c
+++ b/drivers/regulator/rtq2134-regulator.c
@@ -363,6 +363,7 @@ MODULE_DEVICE_TABLE(of, rtq2134_device_tables);
 static struct i2c_driver rtq2134_driver = {
 	.driver = {
 		.name = "rtq2134",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rtq2134_device_tables,
 	},
 	.probe_new = rtq2134_probe,
diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
index dfe45fb67353..8559a266a7eb 100644
--- a/drivers/regulator/rtq6752-regulator.c
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -278,6 +278,7 @@ MODULE_DEVICE_TABLE(of, rtq6752_device_table);
 static struct i2c_driver rtq6752_driver = {
 	.driver = {
 		.name = "rtq6752",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rtq6752_device_table,
 	},
 	.probe_new = rtq6752_probe,
diff --git a/drivers/regulator/sy7636a-regulator.c b/drivers/regulator/sy7636a-regulator.c
index 29fc27c2cda0..d1e7ba1fb3e1 100644
--- a/drivers/regulator/sy7636a-regulator.c
+++ b/drivers/regulator/sy7636a-regulator.c
@@ -127,6 +127,7 @@ MODULE_DEVICE_TABLE(platform, sy7636a_regulator_id_table);
 static struct platform_driver sy7636a_regulator_driver = {
 	.driver = {
 		.name = "sy7636a-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sy7636a_regulator_probe,
 	.id_table = sy7636a_regulator_id_table,
-- 
2.40.0.rc1.284.g88254d51c5-goog

