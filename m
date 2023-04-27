Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5176F0424
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243521AbjD0KXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbjD0KX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:23:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044AB5BA3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:23:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f09b4a1527so84786625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682590987; x=1685182987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CubuGcbwXeFBLcUNK4YyLRx2VBVqe+QN+l3sJog4zY=;
        b=bCqww9nyxL+Djx65AgoDKYTYi8AXeYeh4DWBTu0fcnHgrXoHpyBVb18se0YkLZKc4N
         1IR/6bwG+r0v7kCUjY0vAeEV+2/Ax5ryXk8WLfW5PCpiyUHD+7YSN3rXQP1IRM/5Dikc
         wTiqFZnWqeMwuysz1IuG1ZT0LMXZxXc6qVhsyuNzI0ELPPRrz+J7uvfKse/uKqkugmls
         /XgIwyAUniQIbTaCj5DhG9vicjoh6Z8MN/ptRTCiB6t5YqO3LUKSNoa5+P7UkGEXRVZV
         mWPuxIU1+1mt2usyeLe+nR+FrhPGGWzo1Xukuut9K8gd6SWMxWOs9DyzW4KOogM8maLq
         PQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590987; x=1685182987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CubuGcbwXeFBLcUNK4YyLRx2VBVqe+QN+l3sJog4zY=;
        b=ZoBFqTCbalDr9wWxqSCW/dEk/cj+sSC1z71OHQ0PjnRMor3UkGA4hmOjbGn9Ho4hBi
         hXlJB4NNGAJM8PuoXynThusj7YdNGybNS/0UUNxwgiOUuzl0uxH3VdhEL8+nYX66fRPS
         hABRoT2ItV031irxnsdvrBfpIua9OLBPrl8RK6AamfndSWn0G1Dx9KVHFH4q/FvVtTfH
         OcCLCIBWcSs56zn+CB/lzeLEZkitVNlFX2UfGo9ty+ZqjCzOJuZKZoYToYCOOl0rvNZB
         y+V6CDGBbnfFK6jLnRfZBReJ+EzEr/qTAAHaXUX3pBjGoXRbt844KZIMjcfGMO6XgS0f
         U8lg==
X-Gm-Message-State: AC+VfDwbjIjbQI4w8lIUBzQyGt+INW5PZtvAyZA0KcP491A3Dr90MqWx
        A54FuhipI70dAaVF0dJ/kLIGq6orFRZK6w7HPRmffQ==
X-Google-Smtp-Source: ACHHUZ4M6FL4109YdR2DZrzpoZT53rQz22ffecrIFHsCQtkN+E9rJ+ZrPKwxuODrEw6ZDg/osKFikg==
X-Received: by 2002:a1c:7413:0:b0:3f1:8372:d575 with SMTP id p19-20020a1c7413000000b003f18372d575mr1192849wmc.38.1682590987332;
        Thu, 27 Apr 2023 03:23:07 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c450e00b003f0a6a1f969sm24371172wmo.46.2023.04.27.03.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:23:07 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
Date:   Thu, 27 Apr 2023 12:22:53 +0200
Message-Id: <20230427102254.3864526-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of this driver included wildcards in file names
and descriptions. This patch renames the driver to only support MAX5970
and MAX5978, which are the only chips that the driver actually supports.

Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/mfd/Kconfig                        |  4 ++--
 drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
 include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
 3 files changed, 19 insertions(+), 19 deletions(-)
 rename include/linux/mfd/{max597x.h => max5970.h} (92%)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e90463c4441c..71231388e03c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -266,8 +266,8 @@ config MFD_MADERA_SPI
 	  Support for the Cirrus Logic Madera platform audio SoC
 	  core functionality controlled via SPI.
 
-config MFD_MAX597X
-	tristate "Maxim 597x power switch and monitor"
+config MFD_MAX5970
+	tristate "Maxim 5970/5978 power switch and monitor"
 	depends on (I2C && OF)
 	select MFD_SIMPLE_MFD_I2C
 	help
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 20782b4dd172..1f1c007560d8 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -72,22 +72,22 @@ static const struct simple_mfd_data silergy_sy7636a = {
 	.mfd_cell_size = ARRAY_SIZE(sy7636a_cells),
 };
 
-static const struct mfd_cell max597x_cells[] = {
-	{ .name = "max597x-regulator", },
-	{ .name = "max597x-iio", },
-	{ .name = "max597x-led", },
+static const struct mfd_cell max5970_cells[] = {
+	{ .name = "max5970-regulator", },
+	{ .name = "max5970-iio", },
+	{ .name = "max5970-led", },
 };
 
-static const struct simple_mfd_data maxim_max597x = {
-	.mfd_cell = max597x_cells,
-	.mfd_cell_size = ARRAY_SIZE(max597x_cells),
+static const struct simple_mfd_data maxim_max5970 = {
+	.mfd_cell = max5970_cells,
+	.mfd_cell_size = ARRAY_SIZE(max5970_cells),
 };
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
 	{ .compatible = "kontron,sl28cpld" },
 	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
-	{ .compatible = "maxim,max5970", .data = &maxim_max597x},
-	{ .compatible = "maxim,max5978", .data = &maxim_max597x},
+	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
+	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
diff --git a/include/linux/mfd/max597x.h b/include/linux/mfd/max5970.h
similarity index 92%
rename from include/linux/mfd/max597x.h
rename to include/linux/mfd/max5970.h
index a850b2e02e6a..762a7d40c843 100644
--- a/include/linux/mfd/max597x.h
+++ b/include/linux/mfd/max5970.h
@@ -7,25 +7,25 @@
  * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
  */
 
-#ifndef _MFD_MAX597X_H
-#define _MFD_MAX597X_H
+#ifndef _MFD_MAX5970_H
+#define _MFD_MAX5970_H
 
 #include <linux/regmap.h>
 
 #define MAX5970_NUM_SWITCHES 2
 #define MAX5978_NUM_SWITCHES 1
-#define MAX597X_NUM_LEDS     4
+#define MAX5970_NUM_LEDS     4
 
-struct max597x_data {
+struct max5970_data {
 	int num_switches;
 	u32 irng[MAX5970_NUM_SWITCHES];
 	u32 mon_rng[MAX5970_NUM_SWITCHES];
 	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
 };
 
-enum max597x_chip_type {
-	MAX597x_TYPE_MAX5978 = 1,
-	MAX597x_TYPE_MAX5970,
+enum max5970_chip_type {
+	TYPE_MAX5978 = 1,
+	TYPE_MAX5970,
 };
 
 #define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
@@ -93,4 +93,4 @@ enum max597x_chip_type {
 #define MAX_REGISTERS			0x49
 #define ADC_MASK			0x3FF
 
-#endif				/* _MFD_MAX597X_H */
+#endif				/* _MFD_MAX5970_H */

base-commit: b4c288cfd2f84c44994330c408e14645d45dee5b
-- 
2.39.1

