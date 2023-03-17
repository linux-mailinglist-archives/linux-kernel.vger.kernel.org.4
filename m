Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013B86BE5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCQJjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCQJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:39:16 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17689265AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:39:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j2so3830300wrh.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devialet.com; s=google; t=1679045953;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kU889Qh9rHAQWYG1+vFuFluII986uJTI+qL6sjqYuPc=;
        b=PKH3F3FlA4R3WQAku266/iZ2sC9jZ3RAuu0anE29HTuFfalLN8Jk/qgKDZI8glh8ub
         SBfM2T4m1v7SDMvucQM9fdDcwigYxMlRn2Ml8iavtqzLc4m4E5sEiqKUgY76RG2l/9NF
         iIpkOaFMWHYaEl6i3lc9wJHdm8FcEQ9Ep6jC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045953;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kU889Qh9rHAQWYG1+vFuFluII986uJTI+qL6sjqYuPc=;
        b=ET9I7w7mwvibNpknG5M3vHQac7Cskz4LOivbnNzS8vTDhU8qD165vYsjxGdHr+3RKt
         guY7j/RlALCfUD388jcp1RMvgbT1QcO1UN71/UtV2yI9BC5bMGBXEGv0OoE65aIv6Xh7
         NrVj+7HKoJex8TkHkM5ow9NTabT1W03SFPeePXdbThL0m6g6+R7fjm17kmyOJDduEPSp
         BcuAjYumiz8FcQNBym7eTTqY+t7hwVdEJskAyTyiJmq6H5dzrPQQeazVJf1W9XkMLQYI
         HnoMWfpD+D3I9yIs5ylQ5jifRjmEz7jS7lNlXbatu8/CkV9t3pAHBCgMlZGFGMgmSX30
         927A==
X-Gm-Message-State: AO0yUKXB2zhXOTv5Au/r9Vua6bJD7To8arTxMvD4VCrO4Q7MfuuvDnGt
        dgJf7NDXFz5REet6n7m2z5U7QEvcTC4InP3uZLNKq6WRDGWhaBBkEjxcdFv7kpr6QPE7v3PFRVl
        PaLI9lVmOF6Ed3GNzvg==
X-Google-Smtp-Source: AK7set+t6k3z5VsJP70zYRlyJDtyl9C0cC4pyWUKawV7wdvlzLMJp03aZH/KQDoO7KmU1c56A6GJXQ==
X-Received: by 2002:a5d:55cb:0:b0:2d1:21a1:742d with SMTP id i11-20020a5d55cb000000b002d121a1742dmr3890263wrw.6.1679045953599;
        Fri, 17 Mar 2023 02:39:13 -0700 (PDT)
Received: from nicolas-laptop.devialet.com (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b002c592535839sm1530823wrr.17.2023.03.17.02.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:39:13 -0700 (PDT)
From:   Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
Subject: [PATCH 1/2] regulator: pca9450: Add LOADSW regulator
Date:   Fri, 17 Mar 2023 10:39:10 +0100
Message-Id: <20230317093911.1254530-2-nicolas.heemeryck@devialet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230317093911.1254530-1-nicolas.heemeryck@devialet.com>
References: <20230317093911.1254530-1-nicolas.heemeryck@devialet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the load switch present in the PCA9450 accessible and configurable
from the devicetree. Note that the SWIn for the load switch is
connected to BUCK4.

Signed-off-by: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
---
 drivers/regulator/pca9450-regulator.c | 32 +++++++++++++++++++++++++++
 include/linux/regulator/pca9450.h     |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index c6351fac9f4d..ccb61fc73a59 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -99,6 +99,12 @@ static const struct regulator_ops pca9450_ldo_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
+static const struct regulator_ops pca9450_loadsw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
 /*
  * BUCK1/2/3
  * 0.60 to 2.1875V (12.5mV step)
@@ -452,6 +458,19 @@ static const struct pca9450_regulator_desc pca9450a_regulators[] = {
 			.owner = THIS_MODULE,
 		},
 	},
+	{
+		.desc = {
+			.name = "loadsw",
+			.of_match = of_match_ptr("LOADSW"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LOADSW,
+			.ops = &pca9450_loadsw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PCA9450_REG_LOADSW_CTRL,
+			.enable_mask = LOADSW_CTRL_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
 };
 
 /*
@@ -661,6 +680,19 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 			.owner = THIS_MODULE,
 		},
 	},
+	{
+		.desc = {
+			.name = "loadsw",
+			.of_match = of_match_ptr("LOADSW"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LOADSW,
+			.ops = &pca9450_loadsw_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.enable_reg = PCA9450_REG_LOADSW_CTRL,
+			.enable_mask = LOADSW_CTRL_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
 };
 
 static irqreturn_t pca9450_irq_handler(int irq, void *data)
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 3c01c2bf84f5..4e922d6010cb 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -24,6 +24,7 @@ enum {
 	PCA9450_LDO3,
 	PCA9450_LDO4,
 	PCA9450_LDO5,
+	PCA9450_LOADSW,
 	PCA9450_REGULATOR_CNT,
 };
 
@@ -209,6 +210,9 @@ enum {
 #define LDO5H_EN_MASK			0xC0
 #define LDO5HOUT_MASK			0x0F
 
+/* PCA9450_REG_LOADSW_CTRL bits */
+#define LOADSW_CTRL_EN_MASK		0x03
+
 /* PCA9450_REG_IRQ bits */
 #define IRQ_PWRON			0x80
 #define IRQ_WDOGB			0x40
-- 
2.34.1


-- 
- Confidential -
