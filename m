Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE66D84B2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjDERPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDERPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:15:07 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27CB2;
        Wed,  5 Apr 2023 10:15:04 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id cu4so26661954qvb.3;
        Wed, 05 Apr 2023 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680714903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmWjp1WFSH1Z18O7dKkAHmW0FKJldpCbVGltErgPl7A=;
        b=qzalmI/Wjgc4RNBYA61mVjJMwDCC7p4gfR9VNjpBi1F2hL7u9H3f0wPrSPJZezJreJ
         MzTzNZ3rpEEG80XyaIH3AjYouDMK9dv3uspX/tMLVdvKjBFCYgFqJ2AgoIFnu/hfLzas
         lrETsmS5Yopdn+XuxbvfcFyU+HdUpOa6ztn/pg+JOVDI65Cih7BbK33/IOTTtcNLbztO
         ky3EM6ddJruP4wLuL4fNz3p8PPIgTguuW76DgLJwNSAWuJC1Yw6bmUVVJAuGjNjZyRO/
         DDKs6UHgot2mlYYNzeOluFNtEWvEzpxHD7p6T1bckhS7SVCy7e1IjbWRdSzTJjp2LI1A
         th6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmWjp1WFSH1Z18O7dKkAHmW0FKJldpCbVGltErgPl7A=;
        b=Iqxb+N4i8g4YLvD4Oj/A0nMETbNO1qmgfEudg3yAaigap5BumR6A7xywp4wcgOSf88
         dxFIs05UiAjDcWAVAF7bNG8aHLY3ntK4hOd1/NpwPyGUYAywwWC9N/+MLVuiQAD80lJr
         1mYuxjbjsgFuMEI1RyN0MBm5ZsYwKKkClkWwBXy/naAOshXs5ubMMJXqhFLWIVD+LOC6
         dNmFAmhKY5v3m1lSM2S/ui0Clh2xdKTkN2muy2Jq+ao9NUrKnvZZvQ/5505QKRPfdT5g
         Xla0PcAz9ZBXo2lQLWuTa2wmXC6fKVfNvm97SNrLf5INzS3LytISwUtcUv79PagvE1Qv
         SQCA==
X-Gm-Message-State: AAQBX9fswSDcs1HHCpCS7GQwTbA/W1fjWteTWZqPXRnos49+NduWzYPw
        iB+hWpw8WDpNK4E8ckAowUk=
X-Google-Smtp-Source: AKy350a54+2SsGhkwHs5I0YLIayUj5seTSMdskIpd+YAtzIN3tHnWjMxrgVfUS43ekUHZgpnp67pLg==
X-Received: by 2002:a05:6214:29e8:b0:5bf:370e:f446 with SMTP id jv8-20020a05621429e800b005bf370ef446mr9763539qvb.17.1680714903611;
        Wed, 05 Apr 2023 10:15:03 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id ct9-20020a056214178900b005dd8b934571sm4403209qvb.9.2023.04.05.10.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:15:03 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 05 Apr 2023 19:14:34 +0200
Subject: [PATCH v3 1/3] regulator: da9063: add voltage monitoring registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-da9063-disable-unused-v3-1-cc4dc698864c@skidata.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
In-Reply-To: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
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

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
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

