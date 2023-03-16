Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5DA6BD99F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjCPTzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbjCPTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5032BAD04
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:27 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id y2so2776760pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRgpdkOamLgCCdZ3PhPSjocowBQyfYKeht0LHhwDJpI=;
        b=PdR0XSlvTBn9kI6w59TW0AKBQOJ6vHplCBpgtXNeeia2o5HaTD4Q6s4zIG/rCF9GzA
         IDcXr8YpF599GfqXKu5RlM5Sr1ldLxm2qG0iCYQLIjs4F9uS5buXukPyz8Z0pWUZuHLi
         iUKhbrj1b4Y5AkihWmw2RiLUew45noOOYJupc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRgpdkOamLgCCdZ3PhPSjocowBQyfYKeht0LHhwDJpI=;
        b=ZPW/n6TfTSJufHOungGmaCxO4qv5+YioTr5TsEkJbwRtQIhAGGPsZwXKj9R1ouzjNu
         COLR1vtrl6ziAPyyOFEwxWBtWoE+T91lu+rJlT/zyxcMTqnSNNbQSHUCz1RclmanKdnP
         rA4Sz5YXUndhKufma8zuF/Y2zJZtuuRPZP8N90RmBf6ZuUCixLMf/ra+uPBYuchuTd44
         khtTGtA/PDDD/04SO1rOwBXzr7Lc9oGA2p6noxf0ldpi06lUdF4vztD2Bw62H8+bYxdO
         lEilUCBu1o5hhh8N3p01sU/zkgD3uhEY6JxWAqblsAbvsF9LddDBcABXyAxWCl7PLhAe
         2Q1w==
X-Gm-Message-State: AO0yUKVIIIwLMGuhHnSneJYxXuXQPwcdvVsKl868TEFoRqvr0zYd0sxX
        Jrby9BPGGBrpXwcu5smQyjvBUQ==
X-Google-Smtp-Source: AK7set91fH2QQZa8njW1Cl7zfMPWlq9R6/06thAAqw6N/+6Eumw3IXhPJoStI0REW+R0PH6JCvVufg==
X-Received: by 2002:a05:6a20:4321:b0:cb:aacb:312c with SMTP id h33-20020a056a20432100b000cbaacb312cmr5473848pzk.27.1678996526468;
        Thu, 16 Mar 2023 12:55:26 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:25 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 7/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that are newer than 6.1
Date:   Thu, 16 Mar 2023 12:54:44 -0700
Message-Id: <20230316125351.7.I31771918f1d8dbe4bfb9f1fef7ff987f2b7504b5@changeid>
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
for drivers that existed in 4.14") but changes regulators that were
not present in kernel 6.1.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/max20411-regulator.c | 1 +
 drivers/regulator/mt6357-regulator.c   | 1 +
 drivers/regulator/rt5739.c             | 1 +
 drivers/regulator/rt6190-regulator.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index 83dacb4ff173..be8169b86a89 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -153,6 +153,7 @@ MODULE_DEVICE_TABLE(i2c, max20411_id);
 static struct i2c_driver max20411_i2c_driver = {
 	.driver	= {
 		.name = "max20411",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= of_max20411_match_tbl,
 	},
 	.probe_new = max20411_probe,
diff --git a/drivers/regulator/mt6357-regulator.c b/drivers/regulator/mt6357-regulator.c
index b2352b96aed2..c0439a4e0b50 100644
--- a/drivers/regulator/mt6357-regulator.c
+++ b/drivers/regulator/mt6357-regulator.c
@@ -439,6 +439,7 @@ MODULE_DEVICE_TABLE(platform, mt6357_platform_ids);
 static struct platform_driver mt6357_regulator_driver = {
 	.driver = {
 		.name = "mt6357-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6357_regulator_probe,
 	.id_table = mt6357_platform_ids,
diff --git a/drivers/regulator/rt5739.c b/drivers/regulator/rt5739.c
index 0a9e1023d025..74fc5bf6d87e 100644
--- a/drivers/regulator/rt5739.c
+++ b/drivers/regulator/rt5739.c
@@ -279,6 +279,7 @@ MODULE_DEVICE_TABLE(of, rt5739_device_table);
 static struct i2c_driver rt5739_driver = {
 	.driver = {
 		.name = "rt5739",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rt5739_device_table,
 	},
 	.probe_new = rt5739_probe,
diff --git a/drivers/regulator/rt6190-regulator.c b/drivers/regulator/rt6190-regulator.c
index 995e028abdd7..ca91a1f6d3c8 100644
--- a/drivers/regulator/rt6190-regulator.c
+++ b/drivers/regulator/rt6190-regulator.c
@@ -483,6 +483,7 @@ MODULE_DEVICE_TABLE(of, rt6190_of_dev_table);
 static struct i2c_driver rt6190_driver = {
 	.driver = {
 		.name = "rt6190",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rt6190_of_dev_table,
 		.pm = pm_ptr(&rt6190_dev_pm),
 	},
-- 
2.40.0.rc1.284.g88254d51c5-goog

