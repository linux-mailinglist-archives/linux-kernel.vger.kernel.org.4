Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7A6F0507
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243706AbjD0Lax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243416AbjD0Law (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:30:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ACDE4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:30:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-2f6401ce8f8so5239241f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682595049; x=1685187049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1CubuGcbwXeFBLcUNK4YyLRx2VBVqe+QN+l3sJog4zY=;
        b=LVrp7vGF3CUYyzvJGaEPnJ9qBMt8abFPt4qExoLXlGM6g4aRYNvJ3s0ffkxY6LEjD+
         ot5guIIZZhHz5wTtl+f1sOzHPKgrXUKCqtSUfDlAQQXI+6+bEeuTOybhVUgnevc8/mrI
         vaMrPNRyy7Pp5H7GaeOBLM0dXhlkzJYUKFRz0HVTt/nFbdWMqNuUH4YzfZTkq3VUpBIx
         Kbk+BGcaNNZrARquNBVuyaVVkHD05n/nMSAJiaMJJEZIN/dlDScn1/MDcUhMbfR7V1lm
         WMHO0sRFNy5cNcFj5Ro1AXjXW4kHIf9iOQEAAs0dCXR02hyd8qd+8KUkEqZyASjc0AbV
         cTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682595049; x=1685187049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CubuGcbwXeFBLcUNK4YyLRx2VBVqe+QN+l3sJog4zY=;
        b=AZTfQH6KYe+NF9imxnBWd7lRbeH+M2heMxXPEpWyUTXg8wlP9l9i99CL1PWqgedzhl
         p7rWBiW1FdYP3LGtGLyz4hrqVxB2ejDlF3Mv+wPh0fGITrW/KlIE/V6eY1PX1/OpzACd
         b00aOSJpb8aaxtJ/O/DpAjAeKV0yOCVpt4VgkLjepX9WLvIv1n4SGlQcY6PgnlsHtBlB
         7wg29tt6JXmesU9q//pm1AEzKAzJngv+cvFeVFY7THauN12XufE1whNOuMvK80/6ityR
         Dkd/QKRcQLdnCurHD9CQWLWVgehYdvib15A7vFx4vKdqpUucQO6DU2p/NBMK2AxuoXab
         bogg==
X-Gm-Message-State: AC+VfDx2VxL/Kn1JO+y/qAUbhAdz7hG+25dlGTfLozF8IgNA1oEfVCsr
        rizICFVGD9c2LIjDFVQ52L2YNQ==
X-Google-Smtp-Source: ACHHUZ6MrQ9OyVFWuXl8U7G0Dy1siPbT/pv4K6+sbHQiIyU/SLU9QYc3u1p96QdMJBcGliUkwL8XIw==
X-Received: by 2002:a5d:56ca:0:b0:2f9:c2ab:e1de with SMTP id m10-20020a5d56ca000000b002f9c2abe1demr1055366wrw.14.1682595049246;
        Thu, 27 Apr 2023 04:30:49 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002f9e04459desm18224499wru.109.2023.04.27.04.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 04:30:49 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
Date:   Thu, 27 Apr 2023 13:30:45 +0200
Message-Id: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
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

