Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D366BD99B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCPTzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCPTzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:55:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE520B79E6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso6468281pjf.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678996515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pw9RcMpYtV5Mg9QZGrhkX53C9/T/7Uta7MVr/jkzI3Y=;
        b=UJq1MJJ2DCEoo1Pgsv+3c3tTPu294xWcHoaWgkZVsvc+ZiaazncwQzYcKX5el2Rc56
         rXnxAohXSvHlTao/wDLIw7Rnv8WXtr9UW9v4UE9rY/wPnZbcmBDMEQjXnOnCC7oOb0E9
         otwdRXTC6EHDACW6MzR24ctQQ+k8fARnRNkNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pw9RcMpYtV5Mg9QZGrhkX53C9/T/7Uta7MVr/jkzI3Y=;
        b=Te96uG2nqo2GTKiGGP82m1RGs3phqUcNfydfwAXI+tnbJy/yp7lc9NNRF8igHFZrOY
         xX1qEk2kTwn1gLcJAm6OFCd06vcRJfA65xQtcnLF0PyF0jBlQyEHuKNPez/uJXvDQVjL
         4ldloFV0UewhX1MUnYL6KRZEaiEJgBXEHNkvOcgKHcyN989QQpP4BaeKXGbMS9KqAw3g
         WzQNXujQzY/vbw1ysMLlrPlX1CEyDTyrzTd5A/uGWnfKBpXOVEQyZOs4EdnCHn1f/0av
         ey2Vk6P/ymDG5SDPga1w3z8UlGCTwBH3dGR8tPhDs4FiY3RL2oVajAtrHaMw6JN7n5r1
         Mxbw==
X-Gm-Message-State: AO0yUKUMo+IzruoKEnJ5a0HOBCrxq0Nod57kypI8n+ZRlmY4dgmNYB0E
        w50YjBjvRasXdnhPi7dcUQD8AQ==
X-Google-Smtp-Source: AK7set/CQd9gAZnuJnX7mF0+9BXwziOZOZ0AOohD+5R17qc1rtmA2/viIbzqZaQm4MUtqyOIY0+sxA==
X-Received: by 2002:a05:6a20:e20:b0:d4:b0c9:ac29 with SMTP id ej32-20020a056a200e2000b000d4b0c9ac29mr4170080pzb.22.1678996514928;
        Thu, 16 Mar 2023 12:55:14 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4db6:6f23:6ad2:998d])
        by smtp.gmail.com with ESMTPSA id c18-20020a62e812000000b006227c3d5e29sm110303pfi.16.2023.03.16.12.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:55:14 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in 4.14
Date:   Thu, 16 Mar 2023 12:54:38 -0700
Message-Id: <20230316125351.1.I2a4677392a38db5758dee0788b2cea5872562a82@changeid>
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

Probing of regulators can be a slow operation and can contribute to
slower boot times. This is especially true if a regulator is turned on
at probe time (with regulator-boot-on or regulator-always-on) and the
regulator requires delays (off-on-time, ramp time, etc).

While the overall kernel is not ready to switch to async probe by
default, as per the discussion on the mailing lists [1] it is believed
that the regulator subsystem is in good shape and we can move
regulator drivers over wholesale. There is no way to just magically
opt in all regulators (regulators are just normal drivers like
platform_driver), so we set PROBE_PREFER_ASYNCHRONOUS for all
regulators found in 'drivers/regulator' individually.

Given the number of drivers touched and the impossibility to test this
ahead of time, it wouldn't be shocking at all if this caused a
regression for someone. If there is a regression caused by this patch,
it's likely to be one of the cases talked about in [1]. As a "quick
fix", drivers involved in the regression could be fixed by changing
them to PROBE_FORCE_SYNCHRONOUS. That being said, the correct fix
would be to directly fix the problem that caused the issue with async
probe.

The approach here follows a similar approach that was used for the mmc
subsystem several years ago [2]. In fact, I ran nearly the same python
script to auto-generate the changes. The only thing I changed was to
search for "i2c_driver", "spmi_driver", and "spi_driver" in addition
to "platform_driver".

[1] https://lore.kernel.org/r/06db017f-e985-4434-8d1d-02ca2100cca0@sirena.org.uk
[2] https://lore.kernel.org/r/20200903232441.2694866-1-dianders@chromium.org/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/regulator/88pm800-regulator.c    | 1 +
 drivers/regulator/88pm8607.c             | 1 +
 drivers/regulator/aat2870-regulator.c    | 1 +
 drivers/regulator/ab8500-ext.c           | 1 +
 drivers/regulator/ab8500.c               | 1 +
 drivers/regulator/act8865-regulator.c    | 1 +
 drivers/regulator/act8945a-regulator.c   | 1 +
 drivers/regulator/ad5398.c               | 1 +
 drivers/regulator/anatop-regulator.c     | 1 +
 drivers/regulator/arizona-ldo1.c         | 1 +
 drivers/regulator/arizona-micsupp.c      | 1 +
 drivers/regulator/as3711-regulator.c     | 1 +
 drivers/regulator/as3722-regulator.c     | 1 +
 drivers/regulator/axp20x-regulator.c     | 1 +
 drivers/regulator/bcm590xx-regulator.c   | 1 +
 drivers/regulator/bd9571mwv-regulator.c  | 1 +
 drivers/regulator/cpcap-regulator.c      | 1 +
 drivers/regulator/da903x-regulator.c     | 1 +
 drivers/regulator/da9052-regulator.c     | 1 +
 drivers/regulator/da9055-regulator.c     | 1 +
 drivers/regulator/da9062-regulator.c     | 1 +
 drivers/regulator/da9063-regulator.c     | 1 +
 drivers/regulator/da9210-regulator.c     | 1 +
 drivers/regulator/da9211-regulator.c     | 1 +
 drivers/regulator/db8500-prcmu.c         | 1 +
 drivers/regulator/dummy.c                | 1 +
 drivers/regulator/fan53555.c             | 1 +
 drivers/regulator/fixed.c                | 1 +
 drivers/regulator/gpio-regulator.c       | 1 +
 drivers/regulator/hi6421-regulator.c     | 1 +
 drivers/regulator/hi6421v530-regulator.c | 1 +
 drivers/regulator/hi655x-regulator.c     | 1 +
 drivers/regulator/isl6271a-regulator.c   | 1 +
 drivers/regulator/isl9305.c              | 1 +
 drivers/regulator/lm363x-regulator.c     | 1 +
 drivers/regulator/lp3971.c               | 1 +
 drivers/regulator/lp3972.c               | 1 +
 drivers/regulator/lp872x.c               | 1 +
 drivers/regulator/lp873x-regulator.c     | 1 +
 drivers/regulator/lp8755.c               | 1 +
 drivers/regulator/lp87565-regulator.c    | 1 +
 drivers/regulator/lp8788-buck.c          | 1 +
 drivers/regulator/lp8788-ldo.c           | 2 ++
 drivers/regulator/ltc3589.c              | 1 +
 drivers/regulator/ltc3676.c              | 1 +
 drivers/regulator/max14577-regulator.c   | 1 +
 drivers/regulator/max1586.c              | 1 +
 drivers/regulator/max77620-regulator.c   | 1 +
 drivers/regulator/max77686-regulator.c   | 1 +
 drivers/regulator/max77693-regulator.c   | 1 +
 drivers/regulator/max77802-regulator.c   | 1 +
 drivers/regulator/max8649.c              | 1 +
 drivers/regulator/max8660.c              | 1 +
 drivers/regulator/max8907-regulator.c    | 1 +
 drivers/regulator/max8925-regulator.c    | 1 +
 drivers/regulator/max8952.c              | 1 +
 drivers/regulator/max8973-regulator.c    | 1 +
 drivers/regulator/max8997-regulator.c    | 1 +
 drivers/regulator/max8998.c              | 1 +
 drivers/regulator/mc13783-regulator.c    | 1 +
 drivers/regulator/mc13892-regulator.c    | 1 +
 drivers/regulator/mt6311-regulator.c     | 1 +
 drivers/regulator/mt6323-regulator.c     | 1 +
 drivers/regulator/mt6380-regulator.c     | 1 +
 drivers/regulator/mt6397-regulator.c     | 1 +
 drivers/regulator/palmas-regulator.c     | 1 +
 drivers/regulator/pbias-regulator.c      | 1 +
 drivers/regulator/pcap-regulator.c       | 1 +
 drivers/regulator/pcf50633-regulator.c   | 1 +
 drivers/regulator/pfuze100-regulator.c   | 1 +
 drivers/regulator/pv88060-regulator.c    | 1 +
 drivers/regulator/pv88080-regulator.c    | 1 +
 drivers/regulator/pv88090-regulator.c    | 1 +
 drivers/regulator/pwm-regulator.c        | 1 +
 drivers/regulator/qcom_rpm-regulator.c   | 1 +
 drivers/regulator/qcom_smd-regulator.c   | 1 +
 drivers/regulator/qcom_spmi-regulator.c  | 1 +
 drivers/regulator/rc5t583-regulator.c    | 1 +
 drivers/regulator/rk808-regulator.c      | 3 ++-
 drivers/regulator/rn5t618-regulator.c    | 1 +
 drivers/regulator/rt5033-regulator.c     | 1 +
 drivers/regulator/s2mpa01.c              | 1 +
 drivers/regulator/s2mps11.c              | 1 +
 drivers/regulator/s5m8767.c              | 1 +
 drivers/regulator/sky81452-regulator.c   | 1 +
 drivers/regulator/stm32-vrefbuf.c        | 1 +
 drivers/regulator/stw481x-vmmc.c         | 1 +
 drivers/regulator/ti-abb-regulator.c     | 1 +
 drivers/regulator/tps51632-regulator.c   | 1 +
 drivers/regulator/tps6105x-regulator.c   | 1 +
 drivers/regulator/tps62360-regulator.c   | 1 +
 drivers/regulator/tps65023-regulator.c   | 1 +
 drivers/regulator/tps6507x-regulator.c   | 1 +
 drivers/regulator/tps65086-regulator.c   | 1 +
 drivers/regulator/tps65090-regulator.c   | 1 +
 drivers/regulator/tps65132-regulator.c   | 1 +
 drivers/regulator/tps65217-regulator.c   | 1 +
 drivers/regulator/tps65218-regulator.c   | 1 +
 drivers/regulator/tps6524x-regulator.c   | 1 +
 drivers/regulator/tps6586x-regulator.c   | 1 +
 drivers/regulator/tps65910-regulator.c   | 1 +
 drivers/regulator/tps65912-regulator.c   | 1 +
 drivers/regulator/twl-regulator.c        | 1 +
 drivers/regulator/twl6030-regulator.c    | 1 +
 drivers/regulator/userspace-consumer.c   | 1 +
 drivers/regulator/vctrl-regulator.c      | 1 +
 drivers/regulator/vexpress-regulator.c   | 1 +
 drivers/regulator/virtual.c              | 1 +
 drivers/regulator/wm831x-dcdc.c          | 4 ++++
 drivers/regulator/wm831x-isink.c         | 1 +
 drivers/regulator/wm831x-ldo.c           | 3 +++
 drivers/regulator/wm8350-regulator.c     | 1 +
 drivers/regulator/wm8400-regulator.c     | 1 +
 drivers/regulator/wm8994-regulator.c     | 1 +
 114 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/88pm800-regulator.c b/drivers/regulator/88pm800-regulator.c
index d08ee81ed1ac..83e8860309dc 100644
--- a/drivers/regulator/88pm800-regulator.c
+++ b/drivers/regulator/88pm800-regulator.c
@@ -274,6 +274,7 @@ static int pm800_regulator_probe(struct platform_device *pdev)
 static struct platform_driver pm800_regulator_driver = {
 	.driver		= {
 		.name	= "88pm80x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= pm800_regulator_probe,
 };
diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 1d1c4a7ec3e2..e6c436955e25 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -383,6 +383,7 @@ MODULE_DEVICE_TABLE(platform, pm8607_regulator_driver_ids);
 static struct platform_driver pm8607_regulator_driver = {
 	.driver		= {
 		.name	= "88pm860x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= pm8607_regulator_probe,
 	.id_table	= pm8607_regulator_driver_ids,
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index d6ed5bf9235e..970d86f2bbb8 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -178,6 +178,7 @@ static int aat2870_regulator_probe(struct platform_device *pdev)
 static struct platform_driver aat2870_regulator_driver = {
 	.driver = {
 		.name	= "aat2870-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= aat2870_regulator_probe,
 };
diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 4f26952caa56..b9955aa4e0d1 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -446,6 +446,7 @@ static struct platform_driver ab8500_ext_regulator_driver = {
 	.probe = ab8500_ext_regulator_probe,
 	.driver         = {
 		.name   = "ab8500-ext-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 23a401734a98..6b4a3a3d8385 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -1737,6 +1737,7 @@ static struct platform_driver ab8500_regulator_driver = {
 	.probe = ab8500_regulator_probe,
 	.driver         = {
 		.name   = "ab8500-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 53f2c75cdeb4..5c409ff4aa99 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -789,6 +789,7 @@ MODULE_DEVICE_TABLE(i2c, act8865_ids);
 static struct i2c_driver act8865_pmic_driver = {
 	.driver	= {
 		.name	= "act8865",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new	= act8865_pmic_probe,
 	.id_table	= act8865_ids,
diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 1db1c6423779..e26264529b74 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -348,6 +348,7 @@ static void act8945a_pmic_shutdown(struct platform_device *pdev)
 static struct platform_driver act8945a_pmic_driver = {
 	.driver = {
 		.name = "act8945a-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm = &act8945a_pm,
 	},
 	.probe = act8945a_pmic_probe,
diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 2ba8ac1773d1..c228cf6956d1 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -257,6 +257,7 @@ static struct i2c_driver ad5398_driver = {
 	.probe_new = ad5398_probe,
 	.driver		= {
 		.name	= "ad5398",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table	= ad5398_id,
 };
diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index f9856d4e295f..700bd0343196 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -328,6 +328,7 @@ MODULE_DEVICE_TABLE(of, of_anatop_regulator_match_tbl);
 static struct platform_driver anatop_regulator_driver = {
 	.driver = {
 		.name	= "anatop_regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_anatop_regulator_match_tbl,
 	},
 	.probe	= anatop_regulator_probe,
diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index ade0bef4569d..cabc9e6374a8 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -380,6 +380,7 @@ static struct platform_driver arizona_ldo1_driver = {
 	.remove = arizona_ldo1_remove,
 	.driver		= {
 		.name	= "arizona-ldo1",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 596ecd8041cd..a9fdb342efcf 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -365,6 +365,7 @@ static struct platform_driver arizona_micsupp_driver = {
 	.probe = arizona_micsupp_probe,
 	.driver		= {
 		.name	= "arizona-micsupp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/as3711-regulator.c b/drivers/regulator/as3711-regulator.c
index b6b9206969ae..0431a732cd78 100644
--- a/drivers/regulator/as3711-regulator.c
+++ b/drivers/regulator/as3711-regulator.c
@@ -243,6 +243,7 @@ static int as3711_regulator_probe(struct platform_device *pdev)
 static struct platform_driver as3711_regulator_driver = {
 	.driver	= {
 		.name	= "as3711-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= as3711_regulator_probe,
 };
diff --git a/drivers/regulator/as3722-regulator.c b/drivers/regulator/as3722-regulator.c
index 7bebf9ce6271..da378bfdba40 100644
--- a/drivers/regulator/as3722-regulator.c
+++ b/drivers/regulator/as3722-regulator.c
@@ -831,6 +831,7 @@ MODULE_DEVICE_TABLE(of, of_as3722_regulator_match);
 static struct platform_driver as3722_regulator_driver = {
 	.driver = {
 		.name = "as3722-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_as3722_regulator_match,
 	},
 	.probe = as3722_regulator_probe,
diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index d260c442b788..943172b19722 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1364,6 +1364,7 @@ static struct platform_driver axp20x_regulator_driver = {
 	.probe	= axp20x_regulator_probe,
 	.driver	= {
 		.name		= "axp20x-regulator",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 65e23fc5f9c3..9f0cda46b015 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -354,6 +354,7 @@ static int bcm590xx_probe(struct platform_device *pdev)
 static struct platform_driver bcm590xx_regulator_driver = {
 	.driver = {
 		.name = "bcm590xx-vregs",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = bcm590xx_probe,
 };
diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index ba020a45f238..d469481d8442 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -353,6 +353,7 @@ MODULE_DEVICE_TABLE(platform, bd9571mwv_regulator_id_table);
 static struct platform_driver bd9571mwv_regulator_driver = {
 	.driver = {
 		.name = "bd9571mwv-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm = DEV_PM_OPS,
 	},
 	.probe = bd9571mwv_regulator_probe,
diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index b0c225d98631..1fd79fb17303 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -553,6 +553,7 @@ static struct platform_driver cpcap_regulator_driver = {
 	.probe		= cpcap_regulator_probe,
 	.driver		= {
 		.name	= "cpcap-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(cpcap_regulator_id_table),
 	},
 };
diff --git a/drivers/regulator/da903x-regulator.c b/drivers/regulator/da903x-regulator.c
index 770e694824ac..f79337079a45 100644
--- a/drivers/regulator/da903x-regulator.c
+++ b/drivers/regulator/da903x-regulator.c
@@ -471,6 +471,7 @@ static int da903x_regulator_probe(struct platform_device *pdev)
 static struct platform_driver da903x_regulator_driver = {
 	.driver	= {
 		.name	= "da903x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= da903x_regulator_probe,
 };
diff --git a/drivers/regulator/da9052-regulator.c b/drivers/regulator/da9052-regulator.c
index 23fa429ebe76..ab6f5d61b173 100644
--- a/drivers/regulator/da9052-regulator.c
+++ b/drivers/regulator/da9052-regulator.c
@@ -438,6 +438,7 @@ static struct platform_driver da9052_regulator_driver = {
 	.probe = da9052_regulator_probe,
 	.driver = {
 		.name = "da9052-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/da9055-regulator.c b/drivers/regulator/da9055-regulator.c
index 73ff5fc7d8d7..8fd9ac787588 100644
--- a/drivers/regulator/da9055-regulator.c
+++ b/drivers/regulator/da9055-regulator.c
@@ -576,6 +576,7 @@ static struct platform_driver da9055_regulator_driver = {
 	.probe = da9055_regulator_probe,
 	.driver = {
 		.name = "da9055-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 1a6324001027..c28b061eef02 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1033,6 +1033,7 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 static struct platform_driver da9062_regulator_driver = {
 	.driver = {
 		.name = "da9062-regulators",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = da9062_regulator_probe,
 };
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 82f52a2a031a..e092e4df86ab 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -971,6 +971,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 static struct platform_driver da9063_regulator_driver = {
 	.driver = {
 		.name = DA9063_DRVNAME_REGULATORS,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = da9063_regulator_probe,
 };
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 7493af0b5c04..4332a3b8a672 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -221,6 +221,7 @@ MODULE_DEVICE_TABLE(i2c, da9210_i2c_id);
 static struct i2c_driver da9210_regulator_driver = {
 	.driver = {
 		.name = "da9210",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(da9210_dt_ids),
 	},
 	.probe_new = da9210_i2c_probe,
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 00828f5baa97..a2b4f6f1e34b 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -552,6 +552,7 @@ MODULE_DEVICE_TABLE(of, da9211_dt_ids);
 static struct i2c_driver da9211_regulator_driver = {
 	.driver = {
 		.name = "da9211",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(da9211_dt_ids),
 	},
 	.probe_new = da9211_i2c_probe,
diff --git a/drivers/regulator/db8500-prcmu.c b/drivers/regulator/db8500-prcmu.c
index 0ce6ec4933af..34c5e485d0af 100644
--- a/drivers/regulator/db8500-prcmu.c
+++ b/drivers/regulator/db8500-prcmu.c
@@ -479,6 +479,7 @@ static int db8500_regulator_remove(struct platform_device *pdev)
 static struct platform_driver db8500_regulator_driver = {
 	.driver = {
 		.name = "db8500-prcmu-regulators",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = db8500_regulator_probe,
 	.remove = db8500_regulator_remove,
diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 24e586f93855..5b9b9e4e762d 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -60,6 +60,7 @@ static struct platform_driver dummy_regulator_driver = {
 	.probe		= dummy_regulator_probe,
 	.driver		= {
 		.name		= "reg-dummy",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 529963a7e4f5..d0c678767294 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -663,6 +663,7 @@ MODULE_DEVICE_TABLE(i2c, fan53555_id);
 static struct i2c_driver fan53555_regulator_driver = {
 	.driver = {
 		.name = "fan53555-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(fan53555_dt_ids),
 	},
 	.probe_new = fan53555_regulator_probe,
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index 7c3add05be15..e3436f49dea4 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -334,6 +334,7 @@ static struct platform_driver regulator_fixed_voltage_driver = {
 	.probe		= reg_fixed_voltage_probe,
 	.driver		= {
 		.name		= "reg-fixed-voltage",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(fixed_of_match),
 	},
 };
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 7602d48609df..65927fa2ef16 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -368,6 +368,7 @@ static struct platform_driver gpio_regulator_driver = {
 	.probe		= gpio_regulator_probe,
 	.driver		= {
 		.name		= "gpio-regulator",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(regulator_gpio_of_match),
 	},
 };
diff --git a/drivers/regulator/hi6421-regulator.c b/drivers/regulator/hi6421-regulator.c
index d144a4bdb76d..1b52423598d3 100644
--- a/drivers/regulator/hi6421-regulator.c
+++ b/drivers/regulator/hi6421-regulator.c
@@ -579,6 +579,7 @@ static struct platform_driver hi6421_regulator_driver = {
 	.id_table = hi6421_regulator_table,
 	.driver = {
 		.name	= "hi6421-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= hi6421_regulator_probe,
 };
diff --git a/drivers/regulator/hi6421v530-regulator.c b/drivers/regulator/hi6421v530-regulator.c
index 988115f9b594..23924ff0c7b2 100644
--- a/drivers/regulator/hi6421v530-regulator.c
+++ b/drivers/regulator/hi6421v530-regulator.c
@@ -200,6 +200,7 @@ static struct platform_driver hi6421v530_regulator_driver = {
 	.id_table = hi6421v530_regulator_table,
 	.driver = {
 		.name	= "hi6421v530-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= hi6421v530_regulator_probe,
 };
diff --git a/drivers/regulator/hi655x-regulator.c b/drivers/regulator/hi655x-regulator.c
index 556bb73f3329..1d8211f635b7 100644
--- a/drivers/regulator/hi655x-regulator.c
+++ b/drivers/regulator/hi655x-regulator.c
@@ -206,6 +206,7 @@ static struct platform_driver hi655x_regulator_driver = {
 	.id_table = hi655x_regulator_table,
 	.driver = {
 		.name	= "hi655x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= hi655x_regulator_probe,
 };
diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index b23b052eab10..3c37c4de1d82 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -147,6 +147,7 @@ MODULE_DEVICE_TABLE(i2c, isl6271a_id);
 static struct i2c_driver isl6271a_i2c_driver = {
 	.driver = {
 		.name = "isl6271a",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new = isl6271a_probe,
 	.id_table = isl6271a_id,
diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index cfb765986d0d..90bc8d054304 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -195,6 +195,7 @@ MODULE_DEVICE_TABLE(i2c, isl9305_i2c_id);
 static struct i2c_driver isl9305_regulator_driver = {
 	.driver = {
 		.name = "isl9305",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= of_match_ptr(isl9305_dt_ids),
 	},
 	.probe_new = isl9305_i2c_probe,
diff --git a/drivers/regulator/lm363x-regulator.c b/drivers/regulator/lm363x-regulator.c
index 4b9f618b07e9..7531b2c37f95 100644
--- a/drivers/regulator/lm363x-regulator.c
+++ b/drivers/regulator/lm363x-regulator.c
@@ -355,6 +355,7 @@ static struct platform_driver lm363x_regulator_driver = {
 	.probe = lm363x_regulator_probe,
 	.driver = {
 		.name = "lm363x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index 8be252f81b09..e06f2a092b89 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -447,6 +447,7 @@ MODULE_DEVICE_TABLE(i2c, lp3971_i2c_id);
 static struct i2c_driver lp3971_i2c_driver = {
 	.driver = {
 		.name = "LP3971",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new = lp3971_i2c_probe,
 	.id_table = lp3971_i2c_id,
diff --git a/drivers/regulator/lp3972.c b/drivers/regulator/lp3972.c
index 27b216bf18fc..edacca8e14af 100644
--- a/drivers/regulator/lp3972.c
+++ b/drivers/regulator/lp3972.c
@@ -545,6 +545,7 @@ MODULE_DEVICE_TABLE(i2c, lp3972_i2c_id);
 static struct i2c_driver lp3972_i2c_driver = {
 	.driver = {
 		.name = "lp3972",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new = lp3972_i2c_probe,
 	.id_table = lp3972_i2c_id,
diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index 26ed989460c0..a8b0969d4f31 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -944,6 +944,7 @@ MODULE_DEVICE_TABLE(i2c, lp872x_ids);
 static struct i2c_driver lp872x_driver = {
 	.driver = {
 		.name = "lp872x",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(lp872x_dt_ids),
 	},
 	.probe_new = lp872x_probe,
diff --git a/drivers/regulator/lp873x-regulator.c b/drivers/regulator/lp873x-regulator.c
index d6e597922cb5..8dfdd1db2070 100644
--- a/drivers/regulator/lp873x-regulator.c
+++ b/drivers/regulator/lp873x-regulator.c
@@ -187,6 +187,7 @@ MODULE_DEVICE_TABLE(platform, lp873x_regulator_id_table);
 static struct platform_driver lp873x_regulator_driver = {
 	.driver = {
 		.name = "lp873x-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = lp873x_regulator_probe,
 	.id_table = lp873x_regulator_id_table,
diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 467dfdcebc91..37b51b94fb5a 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -440,6 +440,7 @@ MODULE_DEVICE_TABLE(i2c, lp8755_id);
 static struct i2c_driver lp8755_i2c_driver = {
 	.driver = {
 		   .name = LP8755_NAME,
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   },
 	.probe_new = lp8755_probe,
 	.remove = lp8755_remove,
diff --git a/drivers/regulator/lp87565-regulator.c b/drivers/regulator/lp87565-regulator.c
index d059ae85047a..bdb60d8a7f3d 100644
--- a/drivers/regulator/lp87565-regulator.c
+++ b/drivers/regulator/lp87565-regulator.c
@@ -237,6 +237,7 @@ MODULE_DEVICE_TABLE(platform, lp87565_regulator_id_table);
 static struct platform_driver lp87565_regulator_driver = {
 	.driver = {
 		.name = "lp87565-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = lp87565_regulator_probe,
 	.id_table = lp87565_regulator_id_table,
diff --git a/drivers/regulator/lp8788-buck.c b/drivers/regulator/lp8788-buck.c
index 74b7b496b12d..e97ade09dede 100644
--- a/drivers/regulator/lp8788-buck.c
+++ b/drivers/regulator/lp8788-buck.c
@@ -531,6 +531,7 @@ static struct platform_driver lp8788_buck_driver = {
 	.probe = lp8788_buck_probe,
 	.driver = {
 		.name = LP8788_DEV_BUCK,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/lp8788-ldo.c b/drivers/regulator/lp8788-ldo.c
index 00e9bb92c326..8e45b7b99556 100644
--- a/drivers/regulator/lp8788-ldo.c
+++ b/drivers/regulator/lp8788-ldo.c
@@ -564,6 +564,7 @@ static struct platform_driver lp8788_dldo_driver = {
 	.probe = lp8788_dldo_probe,
 	.driver = {
 		.name = LP8788_DEV_DLDO,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -611,6 +612,7 @@ static struct platform_driver lp8788_aldo_driver = {
 	.probe = lp8788_aldo_probe,
 	.driver = {
 		.name = LP8788_DEV_ALDO,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 460d34c50fb0..359b534d8c70 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -474,6 +474,7 @@ MODULE_DEVICE_TABLE(of, ltc3589_of_match);
 static struct i2c_driver ltc3589_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(ltc3589_of_match),
 	},
 	.probe_new = ltc3589_probe,
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index eb3d6bed6d54..a28e6c3460f1 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -371,6 +371,7 @@ MODULE_DEVICE_TABLE(of, ltc3676_of_match);
 static struct i2c_driver ltc3676_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(ltc3676_of_match),
 	},
 	.probe_new = ltc3676_regulator_probe,
diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index e34face736f4..5e7171b9065a 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -241,6 +241,7 @@ MODULE_DEVICE_TABLE(platform, max14577_regulator_id);
 static struct platform_driver max14577_regulator_driver = {
 	.driver = {
 		   .name = "max14577-regulator",
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   },
 	.probe		= max14577_regulator_probe,
 	.id_table	= max14577_regulator_id,
diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index a00aa2e8ff3f..5d8852b2c168 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -292,6 +292,7 @@ static struct i2c_driver max1586_pmic_driver = {
 	.probe_new = max1586_pmic_probe,
 	.driver		= {
 		.name	= "max1586",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(max1586_of_match),
 	},
 	.id_table	= max1586_id,
diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 3cf8f085170a..7bc87d8e9f68 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -916,6 +916,7 @@ static struct platform_driver max77620_regulator_driver = {
 	.id_table = max77620_regulator_devtype,
 	.driver = {
 		.name = "max77620-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm = &max77620_regulator_pm_ops,
 	},
 };
diff --git a/drivers/regulator/max77686-regulator.c b/drivers/regulator/max77686-regulator.c
index 55a07d3f3ee2..c7b270fd9e0c 100644
--- a/drivers/regulator/max77686-regulator.c
+++ b/drivers/regulator/max77686-regulator.c
@@ -525,6 +525,7 @@ MODULE_DEVICE_TABLE(platform, max77686_pmic_id);
 static struct platform_driver max77686_pmic_driver = {
 	.driver = {
 		.name = "max77686-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = max77686_pmic_probe,
 	.id_table = max77686_pmic_id,
diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
index 077ecbbfdf76..72a67d0c5f1e 100644
--- a/drivers/regulator/max77693-regulator.c
+++ b/drivers/regulator/max77693-regulator.c
@@ -281,6 +281,7 @@ MODULE_DEVICE_TABLE(platform, max77693_pmic_id);
 static struct platform_driver max77693_pmic_driver = {
 	.driver = {
 		   .name = "max77693-pmic",
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   },
 	.probe = max77693_pmic_probe,
 	.id_table = max77693_pmic_id,
diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index befe5f319819..69eb6abd2551 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -554,6 +554,7 @@ MODULE_DEVICE_TABLE(platform, max77802_pmic_id);
 static struct platform_driver max77802_pmic_driver = {
 	.driver = {
 		.name = "max77802-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = max77802_pmic_probe,
 	.id_table = max77802_pmic_id,
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index aed5443d88e1..a517fb4e3669 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -249,6 +249,7 @@ static struct i2c_driver max8649_driver = {
 	.probe_new	= max8649_regulator_probe,
 	.driver		= {
 		.name	= "max8649",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table	= max8649_id,
 };
diff --git a/drivers/regulator/max8660.c b/drivers/regulator/max8660.c
index 711623be8eb5..d6b89f07ae9e 100644
--- a/drivers/regulator/max8660.c
+++ b/drivers/regulator/max8660.c
@@ -506,6 +506,7 @@ static struct i2c_driver max8660_driver = {
 	.probe_new = max8660_probe,
 	.driver		= {
 		.name	= "max8660",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table	= max8660_id,
 };
diff --git a/drivers/regulator/max8907-regulator.c b/drivers/regulator/max8907-regulator.c
index 1a6fd68f3fb1..e59aa7a3ee54 100644
--- a/drivers/regulator/max8907-regulator.c
+++ b/drivers/regulator/max8907-regulator.c
@@ -372,6 +372,7 @@ static int max8907_regulator_probe(struct platform_device *pdev)
 static struct platform_driver max8907_regulator_driver = {
 	.driver = {
 		   .name = "max8907-regulator",
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   },
 	.probe = max8907_regulator_probe,
 };
diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index d953b6b0db77..c1532db0a4ee 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -263,6 +263,7 @@ static int max8925_regulator_probe(struct platform_device *pdev)
 static struct platform_driver max8925_regulator_driver = {
 	.driver		= {
 		.name	= "max8925-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= max8925_regulator_probe,
 };
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 360a33ecc093..8ad8fe7fd263 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -316,6 +316,7 @@ static struct i2c_driver max8952_pmic_driver = {
 	.probe_new	= max8952_pmic_probe,
 	.driver		= {
 		.name	= "max8952",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(max8952_dt_match),
 	},
 	.id_table	= max8952_ids,
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 7e00a45db26a..e6dc3d40da3d 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -804,6 +804,7 @@ MODULE_DEVICE_TABLE(i2c, max8973_id);
 static struct i2c_driver max8973_i2c_driver = {
 	.driver = {
 		.name = "max8973",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_max8973_match_tbl,
 	},
 	.probe_new = max8973_probe,
diff --git a/drivers/regulator/max8997-regulator.c b/drivers/regulator/max8997-regulator.c
index 829c3d9542af..0b38eaa73597 100644
--- a/drivers/regulator/max8997-regulator.c
+++ b/drivers/regulator/max8997-regulator.c
@@ -1197,6 +1197,7 @@ MODULE_DEVICE_TABLE(platform, max8997_pmic_id);
 static struct platform_driver max8997_pmic_driver = {
 	.driver = {
 		.name = "max8997-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = max8997_pmic_probe,
 	.id_table = max8997_pmic_id,
diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 7f254066237d..fadb4717384a 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -803,6 +803,7 @@ MODULE_DEVICE_TABLE(platform, max8998_pmic_id);
 static struct platform_driver max8998_pmic_driver = {
 	.driver = {
 		.name = "max8998-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = max8998_pmic_probe,
 	.id_table = max8998_pmic_id,
diff --git a/drivers/regulator/mc13783-regulator.c b/drivers/regulator/mc13783-regulator.c
index ab558b26cd7c..fb3aa1cec1f2 100644
--- a/drivers/regulator/mc13783-regulator.c
+++ b/drivers/regulator/mc13783-regulator.c
@@ -455,6 +455,7 @@ static int mc13783_regulator_probe(struct platform_device *pdev)
 static struct platform_driver mc13783_regulator_driver = {
 	.driver	= {
 		.name	= "mc13783-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= mc13783_regulator_probe,
 };
diff --git a/drivers/regulator/mc13892-regulator.c b/drivers/regulator/mc13892-regulator.c
index 5221f7a9df91..b29cf6ba6f12 100644
--- a/drivers/regulator/mc13892-regulator.c
+++ b/drivers/regulator/mc13892-regulator.c
@@ -629,6 +629,7 @@ static int mc13892_regulator_probe(struct platform_device *pdev)
 static struct platform_driver mc13892_regulator_driver = {
 	.driver	= {
 		.name	= "mc13892-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= mc13892_regulator_probe,
 };
diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 69e6af3cd505..a9f0c9f725d4 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -151,6 +151,7 @@ MODULE_DEVICE_TABLE(of, mt6311_dt_ids);
 static struct i2c_driver mt6311_regulator_driver = {
 	.driver = {
 		.name = "mt6311",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mt6311_dt_ids),
 	},
 	.probe_new = mt6311_i2c_probe,
diff --git a/drivers/regulator/mt6323-regulator.c b/drivers/regulator/mt6323-regulator.c
index ff9016170db3..b43da848a06e 100644
--- a/drivers/regulator/mt6323-regulator.c
+++ b/drivers/regulator/mt6323-regulator.c
@@ -409,6 +409,7 @@ MODULE_DEVICE_TABLE(platform, mt6323_platform_ids);
 static struct platform_driver mt6323_regulator_driver = {
 	.driver = {
 		.name = "mt6323-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = mt6323_regulator_probe,
 	.id_table = mt6323_platform_ids,
diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index 43234296df36..83e50df7f7c3 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -328,6 +328,7 @@ MODULE_DEVICE_TABLE(of, mt6380_of_match);
 static struct platform_driver mt6380_regulator_driver = {
 	.driver = {
 		.name = "mt6380-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mt6380_of_match),
 	},
 	.probe = mt6380_regulator_probe,
diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 526acc8fbe80..92a2d92f84f9 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -406,6 +406,7 @@ MODULE_DEVICE_TABLE(of, mt6397_of_match);
 static struct platform_driver mt6397_regulator_driver = {
 	.driver = {
 		.name = "mt6397-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(mt6397_of_match),
 	},
 	.probe = mt6397_regulator_probe,
diff --git a/drivers/regulator/palmas-regulator.c b/drivers/regulator/palmas-regulator.c
index 337dd614695e..076966366b60 100644
--- a/drivers/regulator/palmas-regulator.c
+++ b/drivers/regulator/palmas-regulator.c
@@ -1666,6 +1666,7 @@ static int palmas_regulators_probe(struct platform_device *pdev)
 static struct platform_driver palmas_driver = {
 	.driver = {
 		.name = "palmas-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_palmas_match_tbl,
 	},
 	.probe = palmas_regulators_probe,
diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index 4eccf12f39de..0c9873e9abdc 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -231,6 +231,7 @@ static struct platform_driver pbias_regulator_driver = {
 	.probe		= pbias_regulator_probe,
 	.driver		= {
 		.name		= "pbias-regulator",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pbias_of_match),
 	},
 };
diff --git a/drivers/regulator/pcap-regulator.c b/drivers/regulator/pcap-regulator.c
index 0345f38f6f78..319a88412154 100644
--- a/drivers/regulator/pcap-regulator.c
+++ b/drivers/regulator/pcap-regulator.c
@@ -251,6 +251,7 @@ static int pcap_regulator_probe(struct platform_device *pdev)
 static struct platform_driver pcap_regulator_driver = {
 	.driver = {
 		.name	= "pcap-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe	= pcap_regulator_probe,
 };
diff --git a/drivers/regulator/pcf50633-regulator.c b/drivers/regulator/pcf50633-regulator.c
index f40e3bb303d6..9f08a62c800e 100644
--- a/drivers/regulator/pcf50633-regulator.c
+++ b/drivers/regulator/pcf50633-regulator.c
@@ -101,6 +101,7 @@ static int pcf50633_regulator_probe(struct platform_device *pdev)
 static struct platform_driver pcf50633_regulator_driver = {
 	.driver = {
 		.name = "pcf50633-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = pcf50633_regulator_probe,
 };
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 9ab604289b5c..a9fcf6a41494 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -845,6 +845,7 @@ static int pfuze100_regulator_probe(struct i2c_client *client)
 static struct i2c_driver pfuze_driver = {
 	.driver = {
 		.name = "pfuze100-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = pfuze_dt_ids,
 	},
 	.probe_new = pfuze100_regulator_probe,
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 48238846f45c..f170e0dd1819 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -376,6 +376,7 @@ MODULE_DEVICE_TABLE(of, pv88060_dt_ids);
 static struct i2c_driver pv88060_regulator_driver = {
 	.driver = {
 		.name = "pv88060",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pv88060_dt_ids),
 	},
 	.probe_new = pv88060_i2c_probe,
diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 15a67c05f519..133b89d5215c 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -557,6 +557,7 @@ MODULE_DEVICE_TABLE(i2c, pv88080_i2c_id);
 static struct i2c_driver pv88080_regulator_driver = {
 	.driver = {
 		.name = "pv88080",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pv88080_dt_ids),
 	},
 	.probe_new = pv88080_i2c_probe,
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index a80176bdf8ec..1bc33bc10992 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -397,6 +397,7 @@ MODULE_DEVICE_TABLE(of, pv88090_dt_ids);
 static struct i2c_driver pv88090_regulator_driver = {
 	.driver = {
 		.name = "pv88090",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pv88090_dt_ids),
 	},
 	.probe_new = pv88090_i2c_probe,
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 214ea866742d..b64d99695b84 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -393,6 +393,7 @@ MODULE_DEVICE_TABLE(of, pwm_of_match);
 static struct platform_driver pwm_regulator_driver = {
 	.driver = {
 		.name		= "pwm-regulator",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pwm_of_match),
 	},
 	.probe = pwm_regulator_probe,
diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 3c41b71a1f52..f95bc9208c13 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -991,6 +991,7 @@ static struct platform_driver rpm_reg_driver = {
 	.probe          = rpm_reg_probe,
 	.driver  = {
 		.name  = "qcom_rpm_reg",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(rpm_of_match),
 	},
 };
diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9f2b58458841..6f722b2d682e 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -1440,6 +1440,7 @@ static struct platform_driver rpm_reg_driver = {
 	.probe = rpm_reg_probe,
 	.driver = {
 		.name  = "qcom_rpm_smd_regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = rpm_of_match,
 	},
 };
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 3e312729741e..c95f6e9c7ab5 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2484,6 +2484,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 static struct platform_driver qcom_spmi_regulator_driver = {
 	.driver		= {
 		.name	= "qcom-spmi-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = qcom_spmi_regulator_match,
 	},
 	.probe		= qcom_spmi_regulator_probe,
diff --git a/drivers/regulator/rc5t583-regulator.c b/drivers/regulator/rc5t583-regulator.c
index 62641b08b88a..a5afca73715d 100644
--- a/drivers/regulator/rc5t583-regulator.c
+++ b/drivers/regulator/rc5t583-regulator.c
@@ -149,6 +149,7 @@ static int rc5t583_regulator_probe(struct platform_device *pdev)
 static struct platform_driver rc5t583_regulator_driver = {
 	.driver	= {
 		.name	= "rc5t583-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= rc5t583_regulator_probe,
 };
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index fa9fc1aa1ae3..3637e81654a8 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1354,7 +1354,8 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 static struct platform_driver rk808_regulator_driver = {
 	.probe = rk808_regulator_probe,
 	.driver = {
-		.name = "rk808-regulator"
+		.name = "rk808-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/rn5t618-regulator.c b/drivers/regulator/rn5t618-regulator.c
index 5c12d57be040..91808e0735b3 100644
--- a/drivers/regulator/rn5t618-regulator.c
+++ b/drivers/regulator/rn5t618-regulator.c
@@ -143,6 +143,7 @@ static struct platform_driver rn5t618_regulator_driver = {
 	.probe = rn5t618_regulator_probe,
 	.driver = {
 		.name	= "rn5t618-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/rt5033-regulator.c b/drivers/regulator/rt5033-regulator.c
index da4cf5a6acc2..2ba74f205543 100644
--- a/drivers/regulator/rt5033-regulator.c
+++ b/drivers/regulator/rt5033-regulator.c
@@ -124,6 +124,7 @@ MODULE_DEVICE_TABLE(platform, rt5033_regulator_id);
 static struct platform_driver rt5033_regulator_driver = {
 	.driver = {
 		.name = "rt5033-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= rt5033_regulator_probe,
 	.id_table	= rt5033_regulator_id,
diff --git a/drivers/regulator/s2mpa01.c b/drivers/regulator/s2mpa01.c
index 28b424fe7bea..b147ff6a16b1 100644
--- a/drivers/regulator/s2mpa01.c
+++ b/drivers/regulator/s2mpa01.c
@@ -376,6 +376,7 @@ MODULE_DEVICE_TABLE(platform, s2mpa01_pmic_id);
 static struct platform_driver s2mpa01_pmic_driver = {
 	.driver = {
 		.name = "s2mpa01-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = s2mpa01_pmic_probe,
 	.id_table = s2mpa01_pmic_id,
diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index ebc67e3ddd4f..570b61420f3a 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -1238,6 +1238,7 @@ MODULE_DEVICE_TABLE(platform, s2mps11_pmic_id);
 static struct platform_driver s2mps11_pmic_driver = {
 	.driver = {
 		.name = "s2mps11-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = s2mps11_pmic_probe,
 	.id_table = s2mps11_pmic_id,
diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 3122ca7de8f5..bfc0e143bf40 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -999,6 +999,7 @@ MODULE_DEVICE_TABLE(platform, s5m8767_pmic_id);
 static struct platform_driver s5m8767_pmic_driver = {
 	.driver = {
 		.name = "s5m8767-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = s5m8767_pmic_probe,
 	.id_table = s5m8767_pmic_id,
diff --git a/drivers/regulator/sky81452-regulator.c b/drivers/regulator/sky81452-regulator.c
index 37658affe072..359e83e37d2d 100644
--- a/drivers/regulator/sky81452-regulator.c
+++ b/drivers/regulator/sky81452-regulator.c
@@ -79,6 +79,7 @@ static int sky81452_reg_probe(struct platform_device *pdev)
 static struct platform_driver sky81452_reg_driver = {
 	.driver = {
 		.name = "sky81452-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sky81452_reg_probe,
 };
diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 7a454b7b6eab..f5ccc7dd309a 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -285,6 +285,7 @@ static struct platform_driver stm32_vrefbuf_driver = {
 	.remove = stm32_vrefbuf_remove,
 	.driver = {
 		.name  = "stm32-vrefbuf",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(stm32_vrefbuf_of_match),
 		.pm = &stm32_vrefbuf_pm_ops,
 	},
diff --git a/drivers/regulator/stw481x-vmmc.c b/drivers/regulator/stw481x-vmmc.c
index 127ab43add49..3958d906bd77 100644
--- a/drivers/regulator/stw481x-vmmc.c
+++ b/drivers/regulator/stw481x-vmmc.c
@@ -95,6 +95,7 @@ static const struct of_device_id stw481x_vmmc_match[] = {
 static struct platform_driver stw481x_vmmc_regulator_driver = {
 	.driver = {
 		.name  = "stw481x-vmmc-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = stw481x_vmmc_match,
 	},
 	.probe = stw481x_vmmc_regulator_probe,
diff --git a/drivers/regulator/ti-abb-regulator.c b/drivers/regulator/ti-abb-regulator.c
index 115345e9fded..86d2d80b4b41 100644
--- a/drivers/regulator/ti-abb-regulator.c
+++ b/drivers/regulator/ti-abb-regulator.c
@@ -865,6 +865,7 @@ static struct platform_driver ti_abb_driver = {
 	.probe = ti_abb_probe,
 	.driver = {
 		   .name = "ti_abb",
+		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		   .of_match_table = of_match_ptr(ti_abb_of_match),
 		   },
 };
diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index 152c5ad6709c..9bd4e72914ed 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -351,6 +351,7 @@ MODULE_DEVICE_TABLE(i2c, tps51632_id);
 static struct i2c_driver tps51632_i2c_driver = {
 	.driver = {
 		.name = "tps51632",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(tps51632_of_match),
 	},
 	.probe_new = tps51632_probe,
diff --git a/drivers/regulator/tps6105x-regulator.c b/drivers/regulator/tps6105x-regulator.c
index a6469fe05635..a09c6ae6a0ce 100644
--- a/drivers/regulator/tps6105x-regulator.c
+++ b/drivers/regulator/tps6105x-regulator.c
@@ -93,6 +93,7 @@ static int tps6105x_regulator_probe(struct platform_device *pdev)
 static struct platform_driver tps6105x_regulator_driver = {
 	.driver = {
 		.name  = "tps6105x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps6105x_regulator_probe,
 };
diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index a7019e869f50..65cc08d1a67d 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -488,6 +488,7 @@ MODULE_DEVICE_TABLE(i2c, tps62360_id);
 static struct i2c_driver tps62360_i2c_driver = {
 	.driver = {
 		.name = "tps62360",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(tps62360_of_match),
 	},
 	.probe_new = tps62360_probe,
diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
index 680a57ff0837..d87cac63f346 100644
--- a/drivers/regulator/tps65023-regulator.c
+++ b/drivers/regulator/tps65023-regulator.c
@@ -334,6 +334,7 @@ MODULE_DEVICE_TABLE(i2c, tps_65023_id);
 static struct i2c_driver tps_65023_i2c_driver = {
 	.driver = {
 		.name = "tps65023",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(tps65023_of_match),
 	},
 	.probe_new = tps_65023_probe,
diff --git a/drivers/regulator/tps6507x-regulator.c b/drivers/regulator/tps6507x-regulator.c
index b83816ee6867..6655d9c31187 100644
--- a/drivers/regulator/tps6507x-regulator.c
+++ b/drivers/regulator/tps6507x-regulator.c
@@ -438,6 +438,7 @@ static int tps6507x_pmic_probe(struct platform_device *pdev)
 static struct platform_driver tps6507x_pmic_driver = {
 	.driver = {
 		.name = "tps6507x-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps6507x_pmic_probe,
 };
diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index f1bc54c825dd..663789198ba5 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -235,6 +235,7 @@ MODULE_DEVICE_TABLE(platform, tps65086_regulator_id_table);
 static struct platform_driver tps65086_regulator_driver = {
 	.driver = {
 		.name = "tps65086-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps65086_regulator_probe,
 	.id_table = tps65086_regulator_id_table,
diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index 1d2e04f452d4..8f916ee366e5 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -511,6 +511,7 @@ static int tps65090_regulator_probe(struct platform_device *pdev)
 static struct platform_driver tps65090_regulator_driver = {
 	.driver	= {
 		.name	= "tps65090-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= tps65090_regulator_probe,
 };
diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 0edc83089ba2..d4b02ee791d1 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -270,6 +270,7 @@ MODULE_DEVICE_TABLE(i2c, tps65132_id);
 static struct i2c_driver tps65132_i2c_driver = {
 	.driver = {
 		.name = "tps65132",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe_new = tps65132_probe,
 	.id_table = tps65132_id,
diff --git a/drivers/regulator/tps65217-regulator.c b/drivers/regulator/tps65217-regulator.c
index 6bb5b02e19e2..b167ba22fe16 100644
--- a/drivers/regulator/tps65217-regulator.c
+++ b/drivers/regulator/tps65217-regulator.c
@@ -258,6 +258,7 @@ static int tps65217_regulator_probe(struct platform_device *pdev)
 static struct platform_driver tps65217_regulator_driver = {
 	.driver = {
 		.name = "tps65217-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps65217_regulator_probe,
 };
diff --git a/drivers/regulator/tps65218-regulator.c b/drivers/regulator/tps65218-regulator.c
index 48809c3b3abc..13985883e5f0 100644
--- a/drivers/regulator/tps65218-regulator.c
+++ b/drivers/regulator/tps65218-regulator.c
@@ -349,6 +349,7 @@ MODULE_DEVICE_TABLE(platform, tps65218_regulator_id_table);
 static struct platform_driver tps65218_regulator_driver = {
 	.driver = {
 		.name = "tps65218-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps65218_regulator_probe,
 	.id_table = tps65218_regulator_id_table,
diff --git a/drivers/regulator/tps6524x-regulator.c b/drivers/regulator/tps6524x-regulator.c
index 740aeccdfb1f..3fee7e38c68b 100644
--- a/drivers/regulator/tps6524x-regulator.c
+++ b/drivers/regulator/tps6524x-regulator.c
@@ -628,6 +628,7 @@ static struct spi_driver pmic_driver = {
 	.probe		= pmic_probe,
 	.driver		= {
 		.name	= "tps6524x",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/tps6586x-regulator.c
index 18bf4b885b08..1ab5767590f3 100644
--- a/drivers/regulator/tps6586x-regulator.c
+++ b/drivers/regulator/tps6586x-regulator.c
@@ -520,6 +520,7 @@ static int tps6586x_regulator_probe(struct platform_device *pdev)
 static struct platform_driver tps6586x_regulator_driver = {
 	.driver	= {
 		.name	= "tps6586x-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= tps6586x_regulator_probe,
 };
diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 06cbe60c990f..2a0965ba1570 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1255,6 +1255,7 @@ static void tps65910_shutdown(struct platform_device *pdev)
 static struct platform_driver tps65910_driver = {
 	.driver = {
 		.name = "tps65910-pmic",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps65910_probe,
 	.shutdown = tps65910_shutdown,
diff --git a/drivers/regulator/tps65912-regulator.c b/drivers/regulator/tps65912-regulator.c
index 76f90202ae09..7ff7877a2e09 100644
--- a/drivers/regulator/tps65912-regulator.c
+++ b/drivers/regulator/tps65912-regulator.c
@@ -150,6 +150,7 @@ MODULE_DEVICE_TABLE(platform, tps65912_regulator_id_table);
 static struct platform_driver tps65912_regulator_driver = {
 	.driver = {
 		.name = "tps65912-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = tps65912_regulator_probe,
 	.id_table = tps65912_regulator_id_table,
diff --git a/drivers/regulator/twl-regulator.c b/drivers/regulator/twl-regulator.c
index e2a20d512152..3e724f5345de 100644
--- a/drivers/regulator/twl-regulator.c
+++ b/drivers/regulator/twl-regulator.c
@@ -656,6 +656,7 @@ static struct platform_driver twlreg_driver = {
 	 */
 	.driver  = {
 		.name  = "twl4030_reg",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(twl_of_match),
 	},
 };
diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index d94e61aa1b84..f9c695f9bde8 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -765,6 +765,7 @@ static struct platform_driver twlreg_driver = {
 	 */
 	.driver  = {
 		.name  = "twl6030_reg",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(twl_of_match),
 	},
 };
diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 402c8037cf39..97f075ed68c9 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -216,6 +216,7 @@ static struct platform_driver regulator_userspace_consumer_driver = {
 	.remove		= regulator_userspace_consumer_remove,
 	.driver		= {
 		.name		= "reg-userspace-consumer",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= regulator_userspace_consumer_of_match,
 	},
 };
diff --git a/drivers/regulator/vctrl-regulator.c b/drivers/regulator/vctrl-regulator.c
index aac7be3b33f7..85dca90233f6 100644
--- a/drivers/regulator/vctrl-regulator.c
+++ b/drivers/regulator/vctrl-regulator.c
@@ -543,6 +543,7 @@ static struct platform_driver vctrl_driver = {
 	.probe		= vctrl_probe,
 	.driver		= {
 		.name		= "vctrl-regulator",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(vctrl_of_match),
 	},
 };
diff --git a/drivers/regulator/vexpress-regulator.c b/drivers/regulator/vexpress-regulator.c
index 5d39663efcaa..b545dbc70a4d 100644
--- a/drivers/regulator/vexpress-regulator.c
+++ b/drivers/regulator/vexpress-regulator.c
@@ -88,6 +88,7 @@ static struct platform_driver vexpress_regulator_driver = {
 	.probe = vexpress_regulator_probe,
 	.driver	= {
 		.name = DRVNAME,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = vexpress_regulator_of_match,
 	},
 };
diff --git a/drivers/regulator/virtual.c b/drivers/regulator/virtual.c
index 5d32628a5011..d5a160efdae6 100644
--- a/drivers/regulator/virtual.c
+++ b/drivers/regulator/virtual.c
@@ -362,6 +362,7 @@ static struct platform_driver regulator_virtual_consumer_driver = {
 	.remove		= regulator_virtual_remove,
 	.driver		= {
 		.name		= "reg-virt-consumer",
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(regulator_virtual_consumer_of_match),
 	},
 };
diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index e43ed4d93f71..834d7c181971 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -505,6 +505,7 @@ static struct platform_driver wm831x_buckv_driver = {
 	.probe = wm831x_buckv_probe,
 	.driver		= {
 		.name	= "wm831x-buckv",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -632,6 +633,7 @@ static struct platform_driver wm831x_buckp_driver = {
 	.probe = wm831x_buckp_probe,
 	.driver		= {
 		.name	= "wm831x-buckp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -747,6 +749,7 @@ static struct platform_driver wm831x_boostp_driver = {
 	.probe = wm831x_boostp_probe,
 	.driver		= {
 		.name	= "wm831x-boostp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -822,6 +825,7 @@ static struct platform_driver wm831x_epe_driver = {
 	.probe = wm831x_epe_probe,
 	.driver		= {
 		.name	= "wm831x-epe",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/wm831x-isink.c b/drivers/regulator/wm831x-isink.c
index eade3ae3e333..ed5e191e8896 100644
--- a/drivers/regulator/wm831x-isink.c
+++ b/drivers/regulator/wm831x-isink.c
@@ -189,6 +189,7 @@ static struct platform_driver wm831x_isink_driver = {
 	.probe = wm831x_isink_probe,
 	.driver		= {
 		.name	= "wm831x-isink",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index e091b189ecc0..76b89b1cd519 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -303,6 +303,7 @@ static struct platform_driver wm831x_gp_ldo_driver = {
 	.probe = wm831x_gp_ldo_probe,
 	.driver		= {
 		.name	= "wm831x-ldo",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -512,6 +513,7 @@ static struct platform_driver wm831x_aldo_driver = {
 	.probe = wm831x_aldo_probe,
 	.driver		= {
 		.name	= "wm831x-aldo",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
@@ -645,6 +647,7 @@ static struct platform_driver wm831x_alive_ldo_driver = {
 	.probe = wm831x_alive_ldo_probe,
 	.driver		= {
 		.name	= "wm831x-alive-ldo",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index b1d5aac8917d..1445bafcab40 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -1309,6 +1309,7 @@ static struct platform_driver wm8350_regulator_driver = {
 	.remove = wm8350_regulator_remove,
 	.driver		= {
 		.name	= "wm8350-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/regulator/wm8400-regulator.c b/drivers/regulator/wm8400-regulator.c
index e9fd13707721..c4a229f66dec 100644
--- a/drivers/regulator/wm8400-regulator.c
+++ b/drivers/regulator/wm8400-regulator.c
@@ -223,6 +223,7 @@ static int wm8400_regulator_probe(struct platform_device *pdev)
 static struct platform_driver wm8400_regulator_driver = {
 	.driver = {
 		.name = "wm8400-regulator",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = wm8400_regulator_probe,
 };
diff --git a/drivers/regulator/wm8994-regulator.c b/drivers/regulator/wm8994-regulator.c
index 40befdd9dfa9..8921051a00e9 100644
--- a/drivers/regulator/wm8994-regulator.c
+++ b/drivers/regulator/wm8994-regulator.c
@@ -227,6 +227,7 @@ static struct platform_driver wm8994_ldo_driver = {
 	.probe = wm8994_ldo_probe,
 	.driver		= {
 		.name	= "wm8994-ldo",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-- 
2.40.0.rc1.284.g88254d51c5-goog

