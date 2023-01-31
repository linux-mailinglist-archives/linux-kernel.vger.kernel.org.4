Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4182568356A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjAaSd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjAaSde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:33:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D3F59576;
        Tue, 31 Jan 2023 10:32:28 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q10so15112389wrm.4;
        Tue, 31 Jan 2023 10:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joPXQ6wYClhDY3/egPBgCi3+iP2sIkNtds1ZBnCCiUA=;
        b=arS0DBnFummOn8rqX103Sb008UJiykybiA8lEVUlxvYkVXgPfTR+73AQaBMpVlLs1c
         /iJ/Q4cVNZBvg5CPGdqCTMkI93O2atUrYgsBkkOZCAwkV5uGeydjwZPF6iJsY8HETTeU
         asBH9oPgMOnRSMe3MLQnCLPk3EkpjxPRCWOhquMgI9QlGCjwXcr480AP8Aq7VkglzD0t
         5fZ+k9ztHAwMbBm69nUYZ1iNP3Q7/cTOR6np71Qatyb8J0b94jPgAghNGmJEzYTA8vOx
         Ujz7rSvvSDdN0lWLwCJmOauqWA2d1AaZSj2dniqP9DtMb5sPRqTUt2rHSrliRwXIQn4k
         QG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joPXQ6wYClhDY3/egPBgCi3+iP2sIkNtds1ZBnCCiUA=;
        b=2YbIfeIBwvoNwyJumn/HBA2SSCDAJLsdibZwXubz4WoIBV0Ny9fdMcZUTYZwKSQu+X
         zKMCP/4E039QB6JPPUUjPUO07vo6mtRPI1z1kyOH57WbgGuKH5cfKpTFjmmVSlz06uzK
         SnZIBwsOAvhP1ayfjtmkuEXD7YHlspoPjoCKWiouigld8hEgN4k3CQdKZyIu7cHsNeuB
         BedKK9RsbTImc7wpwMMD+pgdPpPSIgDViQT2+RcqQY0EBiH1R9pk2eTkFdKwlg3YVsSJ
         POJNkVMFE9PhTfHsNfXqtV8twJ4z1NV6OfMPe9WpMQmfP9PYawxJApaqTCM2csObgt+x
         kxsQ==
X-Gm-Message-State: AO0yUKWiHJVaMJDRDyU4SMl2bhEy/2AaNxsab2LN6Thx00xm6A+jGtDt
        7RMhYsPMvTssrdVlkQMmalk=
X-Google-Smtp-Source: AK7set8yTTaoVAQPxiwOtJlBbyWDfoHQeE2FurAi6JY7pKqpBLSQgiarKJzTSBDXn20Gbl3rNMVT6w==
X-Received: by 2002:a05:6000:54a:b0:2bf:ec0f:af79 with SMTP id b10-20020a056000054a00b002bfec0faf79mr7928600wrf.63.1675189946567;
        Tue, 31 Jan 2023 10:32:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id c7-20020adffb47000000b002ba2646fd30sm17307311wrs.36.2023.01.31.10.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:32:26 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: [PATCH 1/2] mfd: sec: Remove PMICs without compatibles
Date:   Tue, 31 Jan 2023 19:30:06 +0100
Message-Id: <20230131183008.4451-2-virag.david003@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230131183008.4451-1-virag.david003@gmail.com>
References: <20230131183008.4451-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S5M8751 and S5M8763 PMIC chips have no corresponding compatible
values, so since board file support was removed for this driver, there
is no way to specify these PMICs as present in boards anymore.
Remove leftovers of these chips since it's dead code.

Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/mfd/sec-core.c              | 46 ---------------
 drivers/mfd/sec-irq.c               | 89 ----------------------------
 include/linux/mfd/samsung/core.h    |  1 -
 include/linux/mfd/samsung/s5m8763.h | 90 -----------------------------
 4 files changed, 226 deletions(-)
 delete mode 100644 include/linux/mfd/samsung/s5m8763.h

diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index b03edda56009..c2d0ed496959 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -24,22 +24,9 @@
 #include <linux/mfd/samsung/s2mps14.h>
 #include <linux/mfd/samsung/s2mps15.h>
 #include <linux/mfd/samsung/s2mpu02.h>
-#include <linux/mfd/samsung/s5m8763.h>
 #include <linux/mfd/samsung/s5m8767.h>
 #include <linux/regmap.h>
 
-static const struct mfd_cell s5m8751_devs[] = {
-	{ .name = "s5m8751-pmic", },
-	{ .name = "s5m-charger", },
-	{ .name = "s5m8751-codec", },
-};
-
-static const struct mfd_cell s5m8763_devs[] = {
-	{ .name = "s5m8763-pmic", },
-	{ .name = "s5m-rtc", },
-	{ .name = "s5m-charger", },
-};
-
 static const struct mfd_cell s5m8767_devs[] = {
 	{ .name = "s5m8767-pmic", },
 	{ .name = "s5m-rtc", },
@@ -158,19 +145,6 @@ static bool s2mpu02_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static bool s5m8763_volatile(struct device *dev, unsigned int reg)
-{
-	switch (reg) {
-	case S5M8763_REG_IRQM1:
-	case S5M8763_REG_IRQM2:
-	case S5M8763_REG_IRQM3:
-	case S5M8763_REG_IRQM4:
-		return false;
-	default:
-		return true;
-	}
-}
-
 static const struct regmap_config sec_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -230,15 +204,6 @@ static const struct regmap_config s2mpu02_regmap_config = {
 	.cache_type = REGCACHE_FLAT,
 };
 
-static const struct regmap_config s5m8763_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-
-	.max_register = S5M8763_REG_LBCNFG2,
-	.volatile_reg = s5m8763_volatile,
-	.cache_type = REGCACHE_FLAT,
-};
-
 static const struct regmap_config s5m8767_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
@@ -348,9 +313,6 @@ static int sec_pmic_probe(struct i2c_client *i2c)
 	case S2MPS15X:
 		regmap = &s2mps15_regmap_config;
 		break;
-	case S5M8763X:
-		regmap = &s5m8763_regmap_config;
-		break;
 	case S5M8767X:
 		regmap = &s5m8767_regmap_config;
 		break;
@@ -375,14 +337,6 @@ static int sec_pmic_probe(struct i2c_client *i2c)
 	pm_runtime_set_active(sec_pmic->dev);
 
 	switch (sec_pmic->device_type) {
-	case S5M8751X:
-		sec_devs = s5m8751_devs;
-		num_sec_devs = ARRAY_SIZE(s5m8751_devs);
-		break;
-	case S5M8763X:
-		sec_devs = s5m8763_devs;
-		num_sec_devs = ARRAY_SIZE(s5m8763_devs);
-		break;
 	case S5M8767X:
 		sec_devs = s5m8767_devs;
 		num_sec_devs = ARRAY_SIZE(s5m8767_devs);
diff --git a/drivers/mfd/sec-irq.c b/drivers/mfd/sec-irq.c
index f5f59fdc72fe..e191aeb0c07c 100644
--- a/drivers/mfd/sec-irq.c
+++ b/drivers/mfd/sec-irq.c
@@ -14,7 +14,6 @@
 #include <linux/mfd/samsung/s2mps11.h>
 #include <linux/mfd/samsung/s2mps14.h>
 #include <linux/mfd/samsung/s2mpu02.h>
-#include <linux/mfd/samsung/s5m8763.h>
 #include <linux/mfd/samsung/s5m8767.h>
 
 static const struct regmap_irq s2mps11_irqs[] = {
@@ -297,81 +296,6 @@ static const struct regmap_irq s5m8767_irqs[] = {
 	},
 };
 
-static const struct regmap_irq s5m8763_irqs[] = {
-	[S5M8763_IRQ_DCINF] = {
-		.reg_offset = 0,
-		.mask = S5M8763_IRQ_DCINF_MASK,
-	},
-	[S5M8763_IRQ_DCINR] = {
-		.reg_offset = 0,
-		.mask = S5M8763_IRQ_DCINR_MASK,
-	},
-	[S5M8763_IRQ_JIGF] = {
-		.reg_offset = 0,
-		.mask = S5M8763_IRQ_JIGF_MASK,
-	},
-	[S5M8763_IRQ_JIGR] = {
-		.reg_offset = 0,
-		.mask = S5M8763_IRQ_JIGR_MASK,
-	},
-	[S5M8763_IRQ_PWRONF] = {
-		.reg_offset = 0,
-		.mask = S5M8763_IRQ_PWRONF_MASK,
-	},
-	[S5M8763_IRQ_PWRONR] = {
-		.reg_offset = 0,
-		.mask = S5M8763_IRQ_PWRONR_MASK,
-	},
-	[S5M8763_IRQ_WTSREVNT] = {
-		.reg_offset = 1,
-		.mask = S5M8763_IRQ_WTSREVNT_MASK,
-	},
-	[S5M8763_IRQ_SMPLEVNT] = {
-		.reg_offset = 1,
-		.mask = S5M8763_IRQ_SMPLEVNT_MASK,
-	},
-	[S5M8763_IRQ_ALARM1] = {
-		.reg_offset = 1,
-		.mask = S5M8763_IRQ_ALARM1_MASK,
-	},
-	[S5M8763_IRQ_ALARM0] = {
-		.reg_offset = 1,
-		.mask = S5M8763_IRQ_ALARM0_MASK,
-	},
-	[S5M8763_IRQ_ONKEY1S] = {
-		.reg_offset = 2,
-		.mask = S5M8763_IRQ_ONKEY1S_MASK,
-	},
-	[S5M8763_IRQ_TOPOFFR] = {
-		.reg_offset = 2,
-		.mask = S5M8763_IRQ_TOPOFFR_MASK,
-	},
-	[S5M8763_IRQ_DCINOVPR] = {
-		.reg_offset = 2,
-		.mask = S5M8763_IRQ_DCINOVPR_MASK,
-	},
-	[S5M8763_IRQ_CHGRSTF] = {
-		.reg_offset = 2,
-		.mask = S5M8763_IRQ_CHGRSTF_MASK,
-	},
-	[S5M8763_IRQ_DONER] = {
-		.reg_offset = 2,
-		.mask = S5M8763_IRQ_DONER_MASK,
-	},
-	[S5M8763_IRQ_CHGFAULT] = {
-		.reg_offset = 2,
-		.mask = S5M8763_IRQ_CHGFAULT_MASK,
-	},
-	[S5M8763_IRQ_LOBAT1] = {
-		.reg_offset = 3,
-		.mask = S5M8763_IRQ_LOBAT1_MASK,
-	},
-	[S5M8763_IRQ_LOBAT2] = {
-		.reg_offset = 3,
-		.mask = S5M8763_IRQ_LOBAT2_MASK,
-	},
-};
-
 static const struct regmap_irq_chip s2mps11_irq_chip = {
 	.name = "s2mps11",
 	.irqs = s2mps11_irqs,
@@ -425,16 +349,6 @@ static const struct regmap_irq_chip s5m8767_irq_chip = {
 	.ack_base = S5M8767_REG_INT1,
 };
 
-static const struct regmap_irq_chip s5m8763_irq_chip = {
-	.name = "s5m8763",
-	.irqs = s5m8763_irqs,
-	.num_irqs = ARRAY_SIZE(s5m8763_irqs),
-	.num_regs = 4,
-	.status_base = S5M8763_REG_IRQ1,
-	.mask_base = S5M8763_REG_IRQM1,
-	.ack_base = S5M8763_REG_IRQ1,
-};
-
 int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 {
 	int ret = 0;
@@ -448,9 +362,6 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
 	}
 
 	switch (type) {
-	case S5M8763X:
-		sec_irq_chip = &s5m8763_irq_chip;
-		break;
 	case S5M8767X:
 		sec_irq_chip = &s5m8767_irq_chip;
 		break;
diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
index f92fe090473d..07aae649a86f 100644
--- a/include/linux/mfd/samsung/core.h
+++ b/include/linux/mfd/samsung/core.h
@@ -36,7 +36,6 @@
 struct gpio_desc;
 
 enum sec_device_type {
-	S5M8751X,
 	S5M8763X,
 	S5M8767X,
 	S2MPA01,
diff --git a/include/linux/mfd/samsung/s5m8763.h b/include/linux/mfd/samsung/s5m8763.h
deleted file mode 100644
index c534f086ca16..000000000000
--- a/include/linux/mfd/samsung/s5m8763.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (c) 2011 Samsung Electronics Co., Ltd
- *              http://www.samsung.com
- */
-
-#ifndef __LINUX_MFD_S5M8763_H
-#define __LINUX_MFD_S5M8763_H
-
-/* S5M8763 registers */
-enum s5m8763_reg {
-	S5M8763_REG_IRQ1,
-	S5M8763_REG_IRQ2,
-	S5M8763_REG_IRQ3,
-	S5M8763_REG_IRQ4,
-	S5M8763_REG_IRQM1,
-	S5M8763_REG_IRQM2,
-	S5M8763_REG_IRQM3,
-	S5M8763_REG_IRQM4,
-	S5M8763_REG_STATUS1,
-	S5M8763_REG_STATUS2,
-	S5M8763_REG_STATUSM1,
-	S5M8763_REG_STATUSM2,
-	S5M8763_REG_CHGR1,
-	S5M8763_REG_CHGR2,
-	S5M8763_REG_LDO_ACTIVE_DISCHARGE1,
-	S5M8763_REG_LDO_ACTIVE_DISCHARGE2,
-	S5M8763_REG_BUCK_ACTIVE_DISCHARGE3,
-	S5M8763_REG_ONOFF1,
-	S5M8763_REG_ONOFF2,
-	S5M8763_REG_ONOFF3,
-	S5M8763_REG_ONOFF4,
-	S5M8763_REG_BUCK1_VOLTAGE1,
-	S5M8763_REG_BUCK1_VOLTAGE2,
-	S5M8763_REG_BUCK1_VOLTAGE3,
-	S5M8763_REG_BUCK1_VOLTAGE4,
-	S5M8763_REG_BUCK2_VOLTAGE1,
-	S5M8763_REG_BUCK2_VOLTAGE2,
-	S5M8763_REG_BUCK3,
-	S5M8763_REG_BUCK4,
-	S5M8763_REG_LDO1_LDO2,
-	S5M8763_REG_LDO3,
-	S5M8763_REG_LDO4,
-	S5M8763_REG_LDO5,
-	S5M8763_REG_LDO6,
-	S5M8763_REG_LDO7,
-	S5M8763_REG_LDO7_LDO8,
-	S5M8763_REG_LDO9_LDO10,
-	S5M8763_REG_LDO11,
-	S5M8763_REG_LDO12,
-	S5M8763_REG_LDO13,
-	S5M8763_REG_LDO14,
-	S5M8763_REG_LDO15,
-	S5M8763_REG_LDO16,
-	S5M8763_REG_BKCHR,
-	S5M8763_REG_LBCNFG1,
-	S5M8763_REG_LBCNFG2,
-};
-
-/* S5M8763 regulator ids */
-enum s5m8763_regulators {
-	S5M8763_LDO1,
-	S5M8763_LDO2,
-	S5M8763_LDO3,
-	S5M8763_LDO4,
-	S5M8763_LDO5,
-	S5M8763_LDO6,
-	S5M8763_LDO7,
-	S5M8763_LDO8,
-	S5M8763_LDO9,
-	S5M8763_LDO10,
-	S5M8763_LDO11,
-	S5M8763_LDO12,
-	S5M8763_LDO13,
-	S5M8763_LDO14,
-	S5M8763_LDO15,
-	S5M8763_LDO16,
-	S5M8763_BUCK1,
-	S5M8763_BUCK2,
-	S5M8763_BUCK3,
-	S5M8763_BUCK4,
-	S5M8763_AP_EN32KHZ,
-	S5M8763_CP_EN32KHZ,
-	S5M8763_ENCHGVI,
-	S5M8763_ESAFEUSB1,
-	S5M8763_ESAFEUSB2,
-};
-
-#define S5M8763_ENRAMP                  (1 << 4)
-#endif /* __LINUX_MFD_S5M8763_H */
-- 
2.39.0

