Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4576BD99A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjCPTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjCPTzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5BDB860E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id ay18so1845398pfb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3t/jItNjTE9Uo1kXr2gMEyZhp0UaGPmc1CCRCQCkq0=;
        b=P+gSqt8otS5D73fJ1ed2+kwelZdkJn2XVP8ZaIr2RiHkghfQZUhUKIz1NFVM66DfZM
         G3KnBtlv4nGvUXE/i6Ibm/vE6CHo8vRMU6SwuHp7Y6maH5DPwWgftiDbnpVBx4DUEQ4O
         6ltwTm/kqSoT88wyIFLwwT7gl6I2J777DkCwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3t/jItNjTE9Uo1kXr2gMEyZhp0UaGPmc1CCRCQCkq0=;
        b=RV4NqDpsuGyhLLjAGFfUqkJYXthZqDvthGmnYkqoAlsAMxFfeNH5axNMin7abKfgpT
         rC9ijTh60VTX3JrrHx1coyow5BmxZTpg5EsfOSbMSKbjo/DJNJ3dv3+u+bnDdUDz21kp
         FI3eool5T+4Vbtns6b2a+e5esDIb0pPDII7ZF3WGzZQCSG0qpetXDK2RXPxZJuueqT5T
         e3kKHQeEAaO2cFmH7bRkP+NcTubDYZD2BwOC/8gEfcmPQrcmZjhJ5gZKM7u6hzTtqlBD
         JbdtMmdUsV5aqNSJATnZ73swsuizdAmMD039wgq9UULLjvpVrAftVHd9DxJ+JZnzb51y
         OhGg==
X-Gm-Message-State: AO0yUKXeX96IXgHSUoi3OmOR/q9SJDjvUAoqp0YC9yRLjzc+3TZj/hhZ
        EdxYykzxx+g05FvQ3fY8MwX5p2EHqRTou1xDLH4=
X-Google-Smtp-Source: AK7set8D+bTJNBxGyTjOdva2l/l4XIZmz7vHYrVH2REO4eSKfT7Obh9Pa+gqG1qhO0ajEMWJbA6VXQ==
X-Received: by 2002:a62:5205:0:b0:623:53bc:c9a0 with SMTP id g5-20020a625205000000b0062353bcc9a0mr4984306pfb.19.1678996518696;
        Thu, 16 Mar 2023 12:55:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:18 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 3/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers between 4.19 and 5.4
Date:   Thu, 16 Mar 2023 12:54:40 -0700
Message-Id: <20230316125351.3.I45bf925ca9537da5f647e2acb0ad207c0c98af81@changeid>
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
in Linux 4.19 but did exist in Linux 5.4.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/arizona-ldo1.c        | 1 +
 drivers/regulator/arizona-micsupp.c     | 1 +
 drivers/regulator/lochnagar-regulator.c | 1 +
 drivers/regulator/max77650-regulator.c  | 1 +
 drivers/regulator/mcp16502.c            | 1 +
 drivers/regulator/mt6358-regulator.c    | 1 +
 drivers/regulator/slg51000-regulator.c  | 1 +
 drivers/regulator/stm32-booster.c       | 1 +
 drivers/regulator/stm32-pwr.c           | 1 +
 drivers/regulator/stpmic1_regulator.c   | 1 +
 drivers/regulator/sy8824x.c             | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index cabc9e6374a8..a53d8441702a 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -389,6 +389,7 @@ static struct platform_driver madera_ldo1_driver = {
 	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "madera-ldo1",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index a9fdb342efcf..ffd8416487eb 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -373,6 +373,7 @@ static struct platform_driver madera_micsupp_driver = {
 	.probe = madera_micsupp_probe,
 	.driver		= {
 		.name	= "madera-micsupp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index cb71fa5f43c3..11b358efbc92 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -272,6 +272,7 @@ static int lochnagar_regulator_probe(struct platform_device *pdev)
 static struct platform_driver lochnagar_regulator_driver = {
 	.driver = {
 		.name = "lochnagar-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(lochnagar_of_match),
 	},
 
diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index ca08f94a368d..f6539b945037 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -395,6 +395,7 @@ MODULE_DEVICE_TABLE(of, max77650_regulator_of_match);
 static struct platform_driver max77650_regulator_driver = {
 	.driver = {
 		.name = "max77650-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = max77650_regulator_of_match,
 	},
 	.probe = max77650_regulator_probe,
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index abee1b09008d..3a6d79556942 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -587,6 +587,7 @@ static struct i2c_driver mcp16502_drv = {
 	.probe_new	= mcp16502_probe,
 	.driver		= {
 		.name	= "mcp16502-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= of_match_ptr(mcp16502_ids),
 #ifdef CONFIG_PM
 		.pm = &mcp16502_pm_ops,
diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 8a5ce990f1bf..c9e16bd092f6 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -733,6 +733,7 @@ MODULE_DEVICE_TABLE(platform, mt6358_platform_ids);
 static struct platform_driver mt6358_regulator_driver = {
 	.driver = {
 		.name = "mt6358-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6358_regulator_probe,
 	.id_table = mt6358_platform_ids,
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 1b2eee95ad3f..559ae031010f 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -505,6 +505,7 @@ MODULE_DEVICE_TABLE(i2c, slg51000_i2c_id);
 static struct i2c_driver slg51000_regulator_driver = {
 	.driver = {
 		.name = "slg51000-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new = slg51000_i2c_probe,
 	.id_table = slg51000_i2c_id,
diff --git a/drivers/regulator/stm32-booster.c b/drivers/regulator/stm32-booster.c
index 3136ea8a35d5..b64dc5a497fa 100644
--- a/drivers/regulator/stm32-booster.c
+++ b/drivers/regulator/stm32-booster.c
@@ -117,6 +117,7 @@ static struct platform_driver stm32_booster_driver = {
 	.probe = stm32_booster_probe,
 	.driver = {
 		.name  = "stm32-booster",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(stm32_booster_of_match),
 	},
 };
diff --git a/drivers/regulator/stm32-pwr.c b/drivers/regulator/stm32-pwr.c
index 2a42acb7c24e..2803a199826f 100644
--- a/drivers/regulator/stm32-pwr.c
+++ b/drivers/regulator/stm32-pwr.c
@@ -176,6 +176,7 @@ static struct platform_driver stm32_pwr_driver = {
 	.probe = stm32_pwr_regulator_probe,
 	.driver = {
 		.name  = "stm32-pwr-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(stm32_pwr_of_match),
 	},
 };
diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index d04759b56a95..79d1a3eb18d4 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -638,6 +638,7 @@ MODULE_DEVICE_TABLE(of, of_pmic_regulator_match);
 static struct platform_driver stpmic1_regulator_driver = {
 	.driver = {
 		.name = "stpmic1-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(of_pmic_regulator_match),
 	},
 	.probe = stpmic1_regulator_probe,
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 2a81519bdf67..c327ad69f676 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -233,6 +233,7 @@ MODULE_DEVICE_TABLE(i2c, sy8824_id);
 static struct i2c_driver sy8824_regulator_driver = {
 	.driver = {
 		.name = "sy8824-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sy8824_dt_ids,
 	},
 	.probe_new = sy8824_i2c_probe,
-- 
2.40.0.rc1.284.g88254d51c5-goog

