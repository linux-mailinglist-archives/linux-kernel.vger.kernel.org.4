Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F13A6D73BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbjDEF3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjDEF3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:29:42 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1340D9;
        Tue,  4 Apr 2023 22:29:40 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id nc3so8231437qvb.1;
        Tue, 04 Apr 2023 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680672579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRxGWYUK8WfuFyKNlFJaNShcMy/xAbYita9siz8HWfg=;
        b=Hujbg90jsQ2fNsn3gAWp0TouAZ5Ulb6a7jN6KNj9/ABoGlTfuiPeXQ5mzVpHB8Ac/y
         G+KMA3uuhwkwcyq0dN8bFwCQdSmrwFTshQcqNH2r6dZ9wwtO5c41iaVPRFkmkGvcvntm
         8eXMvmCrMWbmQe8pg0E7PotqNwd6Y/Sh/6ps0cECqfk8kZsO+QZGlydQylvyrapPmY1p
         3iXs3hJhBmBTQ+ZZrB0IfLO1eqTINw/VbwCEZho//aasDdR5wyd71hD2drEDiy4MKUOK
         qeF2uv0nriD4b5eM+aE1liniCACvmp49UxgXIebKp/1f+MpD1kGjbPp4wrAalUX6kKqP
         g+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRxGWYUK8WfuFyKNlFJaNShcMy/xAbYita9siz8HWfg=;
        b=CzSU3cvtaPmDGmCyMEjzUUqsF+CE1EEpOekQ9lmmAxSwQQCb7iIh8G0CIru3eNfH1o
         MOvi06sRaHl31S9eqJt6NrH9zNEVgd88wPge/m6cb0wfg0oUByJeYbDhHnd2e5J7gXLX
         VLcuOd8f9zfpf/5ZMw8apc7DrMAwLO37UkfkoPHGcFieDRGHAtxnr+EtalT/mLjhkAeG
         5x6M/ZDrSg/chgAlG1KWq8+kyRLzmvl1hftzQMaVjIA0TgVcODlMTc3NvtZW8CMQKeNA
         fJCqpBklIfKf47QKyHLJzAd+VU9KmwfQ3Yt0NEsoWzXcj6hiRmQ+smpnSDqLx3RS7zux
         /NMw==
X-Gm-Message-State: AAQBX9fOA2MYyPoE1j7TIQ18pfK0YP4F/9gljZJ0eyyZF4f44Uv9lk4O
        SO8yiBLR4P52HDiYxGGF1XXYsmde/JTxjA==
X-Google-Smtp-Source: AKy350aLwcK7T/0MfUAPzOtMZpNN9eMVdjhAU+9Zsro+9BBXPWiOTx5cVpJlTwko3QY1rjLKQ+/DPg==
X-Received: by 2002:a05:6214:2a8b:b0:5e1:d616:7b74 with SMTP id jr11-20020a0562142a8b00b005e1d6167b74mr2406878qvb.7.1680672579596;
        Tue, 04 Apr 2023 22:29:39 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id f12-20020ad4558c000000b005e16003edc9sm3881454qvx.104.2023.04.04.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 22:29:39 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 05 Apr 2023 07:29:07 +0200
Subject: [PATCH v2 1/3] regulator: da9063: add voltage monitoring registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-da9063-disable-unused-v2-1-2f1bd2a2434a@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
In-Reply-To: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Add the definitions for the registers responsible for voltage
monitoring. Add a voltage monitor enable bitfield per regulator.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/regulator/da9063-regulator.c | 29 +++++++++++++++++++++++++++++
 include/linux/mfd/da9063/registers.h | 23 +++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 82f52a2a031a..1c720fc595b3 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -83,6 +83,9 @@ struct da9063_regulator_info {
 
 	/* DA9063 event detection bit */
 	struct reg_field oc_event;
+
+	/* DA9063 voltage monitor bit */
+	struct reg_field vmon;
 };
 
 /* Macros for LDO */
@@ -148,6 +151,7 @@ struct da9063_regulator {
 	struct regmap_field			*suspend;
 	struct regmap_field			*sleep;
 	struct regmap_field			*suspend_sleep;
+	struct regmap_field			*vmon;
 };
 
 /* Encapsulates all information for the regulators driver */
@@ -581,36 +585,42 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BCORE1_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORE2, 300, 10, 1570,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE2_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BCORE2),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BCORE2_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BPRO, 530, 10, 1800,
 			    da9063_buck_a_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPRO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPRO),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BPRO_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BMEM_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BIO, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BIO_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BIO),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BIO_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BPERI, 800, 20, 3340,
 			    da9063_buck_b_limits,
 			    DA9063_REG_BUCK_ILIM_B, DA9063_BPERI_ILIM_MASK),
 		DA9063_BUCK_COMMON_FIELDS(BPERI),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BPERI_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BCORES_MERGED, 300, 10, 1570,
@@ -618,6 +628,7 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_C, DA9063_BCORE1_ILIM_MASK),
 		/* BCORES_MERGED uses the same register fields as BCORE1 */
 		DA9063_BUCK_COMMON_FIELDS(BCORE1),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BCORE1_MON_EN),
 	},
 	{
 		DA9063_BUCK(DA9063, BMEM_BIO_MERGED, 800, 20, 3340,
@@ -625,47 +636,59 @@ static const struct da9063_regulator_info da9063_regulator_info[] = {
 			    DA9063_REG_BUCK_ILIM_A, DA9063_BMEM_ILIM_MASK),
 		/* BMEM_BIO_MERGED uses the same register fields as BMEM */
 		DA9063_BUCK_COMMON_FIELDS(BMEM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_4, DA9063_BMEM_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO3, 900, 20, 3440),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO3_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO3_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO7, 900, 50, 3600),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO7_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO7_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO8, 900, 50, 3600),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO8_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO8_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO9, 950, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_3, DA9063_LDO9_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO11, 900, 50, 3600),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO11_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_3, DA9063_LDO11_MON_EN),
 	},
 
 	/* The following LDOs are present only on DA9063, not on DA9063L */
 	{
 		DA9063_LDO(DA9063, LDO1, 600, 20, 1860),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO1_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO2, 600, 20, 1860),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO2_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO4, 900, 20, 3440),
 		.oc_event = BFIELD(DA9063_REG_STATUS_D, DA9063_LDO4_LIM),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO4_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO5, 900, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO5_MON_EN),
 	},
 	{
 		DA9063_LDO(DA9063, LDO6, 900, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_2, DA9063_LDO6_MON_EN),
 	},
 
 	{
 		DA9063_LDO(DA9063, LDO10, 900, 50, 3600),
+		.vmon = BFIELD(DA9063_BB_REG_MON_REG_3, DA9063_LDO10_MON_EN),
 	},
 };
 
@@ -932,6 +955,12 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 			if (IS_ERR(regl->suspend_sleep))
 				return PTR_ERR(regl->suspend_sleep);
 		}
+		if (regl->info->vmon.reg) {
+			regl->vmon = devm_regmap_field_alloc(&pdev->dev,
+				da9063->regmap, regl->info->vmon);
+			if (IS_ERR(regl->vmon))
+				return PTR_ERR(regl->vmon);
+		}
 
 		/* Register regulator */
 		memset(&config, 0, sizeof(config));
diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
index 6e0f66a2e727..7b8364bd08a0 100644
--- a/include/linux/mfd/da9063/registers.h
+++ b/include/linux/mfd/da9063/registers.h
@@ -1040,6 +1040,29 @@
 /* DA9063_REG_CONFIG_J (addr=0x10F) */
 #define DA9063_TWOWIRE_TO			0x40
 
+/* DA9063_REG_MON_REG_2 (addr=0x115) */
+#define DA9063_LDO1_MON_EN			0x01
+#define DA9063_LDO2_MON_EN			0x02
+#define DA9063_LDO3_MON_EN			0x04
+#define DA9063_LDO4_MON_EN			0x08
+#define DA9063_LDO5_MON_EN			0x10
+#define DA9063_LDO6_MON_EN			0x20
+#define DA9063_LDO7_MON_EN			0x40
+#define DA9063_LDO8_MON_EN			0x80
+
+/* DA9063_REG_MON_REG_3 (addr=0x116) */
+#define DA9063_LDO9_MON_EN			0x01
+#define DA9063_LDO10_MON_EN			0x02
+#define DA9063_LDO11_MON_EN			0x04
+
+/* DA9063_REG_MON_REG_4 (addr=0x117) */
+#define DA9063_BCORE1_MON_EN			0x04
+#define DA9063_BCORE2_MON_EN			0x08
+#define DA9063_BPRO_MON_EN			0x10
+#define DA9063_BIO_MON_EN			0x20
+#define DA9063_BMEM_MON_EN			0x40
+#define DA9063_BPERI_MON_EN			0x80
+
 /* DA9063_REG_MON_REG_5 (addr=0x116) */
 #define DA9063_MON_A8_IDX_MASK			0x07
 #define		DA9063_MON_A8_IDX_NONE		0x00

-- 
2.34.1

