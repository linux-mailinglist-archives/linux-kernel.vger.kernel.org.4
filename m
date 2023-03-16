Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B806BD999
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCPTzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCPTzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8409DB7DB0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:17 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id ay18so1845360pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjr+gXHm35kttLAQbcxv5jvVAZGlMQj437/DpZS9kCw=;
        b=Yq6hIiT3lgxYr3EjtX9auqNjNCS39l/n7k1AC0ccNY/9UpWb2PjguZyAAPhwzVJT/Q
         qdt3RDn3QNQRwRlAlzGDRRvTTMRKn5kqZ9bYDjLH984meTi245FuCh/Z6/Or0XMUEqWn
         yZPq6NpKZkQPFbInMebiFc50eOOu4+vzUSup0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjr+gXHm35kttLAQbcxv5jvVAZGlMQj437/DpZS9kCw=;
        b=mamSVgSA8sdWdm65BXjkykOSdsLKf8xSSAnkDPcGMSUaXbifKJD1JSoR3gOs4F0K/C
         y+7TkpHd50QvGGmyc7YW6BShjhUGXyd5DsJjRq4KhXkGHCjYgsDufuYgFWki/ksSJ+3D
         xYyc6LC46CnOgaQIzYIA6vYmqJzjVztIcPN0FvR3WyaQeJvoYGiZkKk1fKBPnimK7x2d
         H75iD4zZ14qDf0KaZ65MPKiig0VePilB/4pRfbWyx6WaaVJkZt6nNgt+ckKPXCruA0e0
         aNkbinJ+GFaAS5ASW/8cqCwzjRTlCW5BMctUWyof2+rCYWvXS4N3XNwketi2MXR/8ky9
         xZFg==
X-Gm-Message-State: AO0yUKXl32Ll+hXBDQua6EQxtZItjjlKvI2bQLsdLLhjnT819u+EZAKD
        v2VLBvNsbA+LKdU4sxLJR1F1ag==
X-Google-Smtp-Source: AK7set80VHkOUO9+WmcjEbKnZXnGaA1sd8hbrFTaR4z/uLmlnNf3r8COQqL3nWKGn94bF/8AQuoJRw==
X-Received: by 2002:a05:6a00:11:b0:625:498b:88c8 with SMTP id h17-20020a056a00001100b00625498b88c8mr4096838pfk.26.1678996517048;
        Thu, 16 Mar 2023 12:55:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 2/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.14 and 4.19
Date:   Thu, 16 Mar 2023 12:54:39 -0700
Message-Id: <20230316125351.2.Iad1f25517bb46a6c7fca8d8c80ed4fc258a79ed9@changeid>
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
in Linux 4.14 but did exist in Linux 4.19.

NOTE: from a quick "git cherry-pick" it looks as if
"bd718x7-regulator.c" didn't actually exist in v4.19. In 4.19 it was
named "bd71837-regulator.c". See commit 2ece646c90c5 ("regulator:
bd718xx: rename bd71837 to 718xx")

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/88pg86x.c             | 1 +
 drivers/regulator/bd718x7-regulator.c   | 1 +
 drivers/regulator/qcom-rpmh-regulator.c | 1 +
 drivers/regulator/sc2731-regulator.c    | 1 +
 drivers/regulator/sy8106a-regulator.c   | 1 +
 drivers/regulator/uniphier-regulator.c  | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/regulator/88pg86x.c b/drivers/regulator/88pg86x.c
index e91d5885c5ef..74275b681f46 100644
--- a/drivers/regulator/88pg86x.c
+++ b/drivers/regulator/88pg86x.c
@@ -101,6 +101,7 @@ MODULE_DEVICE_TABLE(i2c, pg86x_i2c_id);
 static struct i2c_driver pg86x_regulator_driver = {
 	.driver = {
 		.name = "88pg86x",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pg86x_dt_ids),
 	},
 	.probe_new = pg86x_i2c_probe,
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 894fab0d53d0..b0b9938c20a1 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1829,6 +1829,7 @@ MODULE_DEVICE_TABLE(platform, bd718x7_pmic_id);
 static struct platform_driver bd718xx_regulator = {
 	.driver = {
 		.name = "bd718xx-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = bd718xx_probe,
 	.id_table = bd718x7_pmic_id,
diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index ae6021390143..4826d60e5d95 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -1462,6 +1462,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
 static struct platform_driver rpmh_regulator_driver = {
 	.driver = {
 		.name = "qcom-rpmh-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= of_match_ptr(rpmh_regulator_match_table),
 	},
 	.probe = rpmh_regulator_probe,
diff --git a/drivers/regulator/sc2731-regulator.c b/drivers/regulator/sc2731-regulator.c
index 71e5ceb679f4..5447e1a47d15 100644
--- a/drivers/regulator/sc2731-regulator.c
+++ b/drivers/regulator/sc2731-regulator.c
@@ -245,6 +245,7 @@ static int sc2731_regulator_probe(struct platform_device *pdev)
 static struct platform_driver sc2731_regulator_driver = {
 	.driver = {
 		.name = "sc27xx-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sc2731_regulator_probe,
 };
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index b10bd99768a3..e3c753986309 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -138,6 +138,7 @@ MODULE_DEVICE_TABLE(i2c, sy8106a_i2c_id);
 static struct i2c_driver sy8106a_regulator_driver = {
 	.driver = {
 		.name = "sy8106a",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= sy8106a_i2c_of_match,
 	},
 	.probe_new = sy8106a_i2c_probe,
diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index 39a68b01fc38..7e2785e10dc6 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -212,6 +212,7 @@ static struct platform_driver uniphier_regulator_driver = {
 	.remove = uniphier_regulator_remove,
 	.driver = {
 		.name  = "uniphier-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = uniphier_regulator_match,
 	},
 };
-- 
2.40.0.rc1.284.g88254d51c5-goog

