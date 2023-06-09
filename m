Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E211C72933E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbjFIIc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240970AbjFIIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:31:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A272C4204
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:30:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-65311774e52so1158190b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686299449; x=1688891449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfBApkKJFoC1LAXLIDHIMvLkHHtkxFJ1T+708z95fzw=;
        b=l8aMM0p/UA1wQFt8yk6HMlhCR9W3WJlICkTKzNmjrwrJw4MI54RIo/Ai1uOkPIo9D3
         BMSy+9T+qP1txmuTuyeqHPzHJZLsqfZZbcMjpZF4DIJxVqsoQvNms0QMvgOdCpAG76gG
         uHzlwXr88LeEhaaxSoQ6wWPbYBzv8RXREuOow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299449; x=1688891449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfBApkKJFoC1LAXLIDHIMvLkHHtkxFJ1T+708z95fzw=;
        b=VsswOXc0zefPCcuUAMY6AiB799F18HCBOqV2U+aBrk2VVwV2Ll9pQvHL6v3Lj5Elke
         dMd801UoYgVjrxQFD4+wJ8vDC+LKRfGS5cX4h5QvRsDh9MES56AXFTHDL+0yObFDnWJ/
         SFDnKN7Tb8NZuOwM1G0DE3F0TbPhjm0vsMkvLQlAvESOgaM8ePI0ZrVJcIE3uZTdbDTt
         AxLePS5jBF4rM+eaTyl40vBvpfdqMQ5RoZ/YR39ulogrFjc+AnrBve3SSSMbiVuqYUxS
         WLTLajGdKOIauxScTrQvH1paViPRv75pGD3EohQfPfbrmRxyGAWYeg1a/Jx1IJf9fL4Y
         Nuww==
X-Gm-Message-State: AC+VfDxhLwT2CY1pjY4ccZWvB/nPTlOVPrYWRk7D8FivYUciO7Ib78RH
        QVKuxf9yuzq1pVRaGjDuUOb6Pg==
X-Google-Smtp-Source: ACHHUZ7vJ9BIbKrQXjopUBUG+0xKj1EqO3eRRU94itAGa4DToaoaq9ACVKLMXxLV0j4CWSWbQ5Jd/Q==
X-Received: by 2002:a05:6a00:13a9:b0:65a:cbf3:4687 with SMTP id t41-20020a056a0013a900b0065acbf34687mr708335pfg.0.1686299449617;
        Fri, 09 Jun 2023 01:30:49 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm2184327pfi.169.2023.06.09.01.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:30:49 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] regulator: mt6358: Use linear voltage helpers for single range regulators
Date:   Fri,  9 Jun 2023 16:30:03 +0800
Message-ID: <20230609083009.2822259-7-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609083009.2822259-1-wenst@chromium.org>
References: <20230609083009.2822259-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the regulators on the MT6358/MT6366 PMICs have just one linear
voltage range. These are the bulk regulators and VSRAM_* LDOs. Currently
they are modeled with one linear range, but also have their minimum,
maximum, and step voltage described.

Convert them to the linear voltage helpers. These helpers are a bit
simpler, and we can also drop the linear range definitions. Also reflow
the touched lines now that they are shorter.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 121 +++++++++------------------
 1 file changed, 40 insertions(+), 81 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 2851ef53ac63..31a16fb28ecd 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -37,7 +37,7 @@ struct mt6358_regulator_info {
 #define to_regulator_info(x) container_of((x), struct mt6358_regulator_info, desc)
 
 #define MT6358_BUCK(match, vreg, min, max, step,		\
-	volt_ranges, vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
+	vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
 	_modeset_reg, _modeset_shift)		\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
@@ -48,8 +48,8 @@ struct mt6358_regulator_info {
 		.id = MT6358_ID_##vreg,		\
 		.owner = THIS_MODULE,		\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
-		.linear_ranges = volt_ranges,		\
-		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
 		.vsel_reg = MT6358_BUCK_##vreg##_ELR0,	\
 		.vsel_mask = vosel_mask,	\
 		.enable_reg = MT6358_BUCK_##vreg##_CON0,	\
@@ -89,7 +89,7 @@ struct mt6358_regulator_info {
 }
 
 #define MT6358_LDO1(match, vreg, min, max, step,	\
-	volt_ranges, _da_vsel_reg, _da_vsel_mask,	\
+	_da_vsel_reg, _da_vsel_mask,	\
 	vosel, vosel_mask)	\
 [MT6358_ID_##vreg] = {	\
 	.desc = {	\
@@ -100,8 +100,8 @@ struct mt6358_regulator_info {
 		.id = MT6358_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
-		.linear_ranges = volt_ranges,	\
-		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
 		.vsel_reg = vosel,	\
 		.vsel_mask = vosel_mask,	\
 		.enable_reg = MT6358_LDO_##vreg##_CON0,	\
@@ -133,7 +133,7 @@ struct mt6358_regulator_info {
 }
 
 #define MT6366_BUCK(match, vreg, min, max, step,		\
-	volt_ranges, vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
+	vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
 	_modeset_reg, _modeset_shift)		\
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
@@ -144,8 +144,8 @@ struct mt6358_regulator_info {
 		.id = MT6366_ID_##vreg,		\
 		.owner = THIS_MODULE,		\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
-		.linear_ranges = volt_ranges,		\
-		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
 		.vsel_reg = MT6358_BUCK_##vreg##_ELR0,	\
 		.vsel_mask = vosel_mask,	\
 		.enable_reg = MT6358_BUCK_##vreg##_CON0,	\
@@ -185,7 +185,7 @@ struct mt6358_regulator_info {
 }
 
 #define MT6366_LDO1(match, vreg, min, max, step,	\
-	volt_ranges, _da_vsel_reg, _da_vsel_mask,	\
+	_da_vsel_reg, _da_vsel_mask,	\
 	vosel, vosel_mask)	\
 [MT6366_ID_##vreg] = {	\
 	.desc = {	\
@@ -196,8 +196,8 @@ struct mt6358_regulator_info {
 		.id = MT6366_ID_##vreg,	\
 		.owner = THIS_MODULE,	\
 		.n_voltages = ((max) - (min)) / (step) + 1,	\
-		.linear_ranges = volt_ranges,	\
-		.n_linear_ranges = ARRAY_SIZE(volt_ranges),	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
 		.vsel_reg = vosel,	\
 		.vsel_mask = vosel_mask,	\
 		.enable_reg = MT6358_LDO_##vreg##_CON0,	\
@@ -228,21 +228,6 @@ struct mt6358_regulator_info {
 	.qi = BIT(15),							\
 }
 
-static const struct linear_range buck_volt_range1[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 6250),
-};
-
-static const struct linear_range buck_volt_range2[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 0x7f, 12500),
-};
-
-static const struct linear_range buck_volt_range3[] = {
-	REGULATOR_LINEAR_RANGE(500000, 0, 0x3f, 50000),
-};
-
-static const struct linear_range buck_volt_range4[] = {
-	REGULATOR_LINEAR_RANGE(1000000, 0, 0x7f, 12500),
-};
 
 static const unsigned int vdram2_voltages[] = {
 	600000, 1800000,
@@ -466,8 +451,8 @@ static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops mt6358_volt_range_ops = {
-	.list_voltage = regulator_list_voltage_linear_range,
-	.map_voltage = regulator_map_voltage_linear_range,
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = mt6358_get_buck_voltage_sel,
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
@@ -502,32 +487,23 @@ static const struct regulator_ops mt6358_volt_fixed_ops = {
 /* The array is indexed by id(MT6358_ID_XXX) */
 static const struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
-		    buck_volt_range2, 0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f,
-		    MT6358_VDRAM1_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f, MT6358_VDRAM1_ANA_CON0, 8),
 	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
-		    MT6358_VCORE_VGPU_ANA_CON0, 1),
+		    0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 1),
 	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
-		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
-		    MT6358_VPA_ANA_CON0, 3),
+		    0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, MT6358_VPA_ANA_CON0, 3),
 	MT6358_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f,
-		    MT6358_VPROC_ANA_CON0, 1),
+		    0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 1),
 	MT6358_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f,
-		    MT6358_VPROC_ANA_CON0, 2),
+		    0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 2),
 	MT6358_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f,
-		    MT6358_VCORE_VGPU_ANA_CON0, 2),
+		    0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 2),
 	MT6358_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
-		    buck_volt_range2, 0x7f, MT6358_BUCK_VS2_DBG0, 0x7f,
-		    MT6358_VS2_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, MT6358_VS2_ANA_CON0, 8),
 	MT6358_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f,
-		    MT6358_VMODEM_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
 	MT6358_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
-		    buck_volt_range4, 0x7f, MT6358_BUCK_VS1_DBG0, 0x7f,
-		    MT6358_VS1_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
 	MT6358_REG_FIXED("ldo_vrf12", VRF12,
 			 MT6358_LDO_VRF12_CON0, 0, 1200000),
 	MT6358_REG_FIXED("ldo_vio18", VIO18,
@@ -577,48 +553,35 @@ static const struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
 	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON0, 0x7f),
+		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
 	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON2, 0x7f),
+		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
 	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON3, 0x7f),
+		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
 	MT6358_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON1, 0x7f),
+		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
 };
 
 /* The array is indexed by id(MT6366_ID_XXX) */
 static const struct mt6358_regulator_info mt6366_regulators[] = {
 	MT6366_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
-		    buck_volt_range2, 0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f,
-		    MT6358_VDRAM1_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f, MT6358_VDRAM1_ANA_CON0, 8),
 	MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
-		    MT6358_VCORE_VGPU_ANA_CON0, 1),
+		    0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 1),
 	MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
-		    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
-		    MT6358_VPA_ANA_CON0, 3),
+		    0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, MT6358_VPA_ANA_CON0, 3),
 	MT6366_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f,
-		    MT6358_VPROC_ANA_CON0, 1),
+		    0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 1),
 	MT6366_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f,
-		    MT6358_VPROC_ANA_CON0, 2),
+		    0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 2),
 	MT6366_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f,
-		    MT6358_VCORE_VGPU_ANA_CON0, 2),
+		    0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 2),
 	MT6366_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
-		    buck_volt_range2, 0x7f, MT6358_BUCK_VS2_DBG0, 0x7f,
-		    MT6358_VS2_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, MT6358_VS2_ANA_CON0, 8),
 	MT6366_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
-		    buck_volt_range1, 0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f,
-		    MT6358_VMODEM_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
 	MT6366_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
-		    buck_volt_range4, 0x7f, MT6358_BUCK_VS1_DBG0, 0x7f,
-		    MT6358_VS1_ANA_CON0, 8),
+		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
 	MT6366_REG_FIXED("ldo_vrf12", VRF12,
 			 MT6358_LDO_VRF12_CON0, 0, 1200000),
 	MT6366_REG_FIXED("ldo_vio18", VIO18,
@@ -657,17 +620,13 @@ static const struct mt6358_regulator_info mt6366_regulators[] = {
 	MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
 		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
 	MT6366_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON0, 0x7f),
+		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
 	MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON2, 0x7f),
+		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
 	MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON3, 0x7f),
+		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
 	MT6366_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
-		    buck_volt_range1, MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00,
-		    MT6358_LDO_VSRAM_CON1, 0x7f),
+		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
 };
 
 static int mt6358_sync_vcn33_setting(struct device *dev)
-- 
2.41.0.162.gfafddb0af9-goog

