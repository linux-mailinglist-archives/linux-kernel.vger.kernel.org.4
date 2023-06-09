Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D1729339
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240509AbjFIIcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240885AbjFIIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:31:19 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0052134
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:30:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-662b85f4640so1253686b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686299442; x=1688891442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqxK91xXLVCmyIE2hj+zcOaCJHi9/iXuXSTsY2AWMsY=;
        b=HKEhHSvW+XGShwykMDWBYvXaSN432HhV7S+TskFxFGAV689Sin+0Aiws8R8dDhC0r0
         zuujnLGLNb9rG4YjqWbnoNFd/CJUWeKsYvVlA262xSTmlmzf5YM1R6JpLf6C6Q+r+ndG
         xlqCBMsM7tDYqAEkvAuoe4vxLMbOQXrlxn5EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299442; x=1688891442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqxK91xXLVCmyIE2hj+zcOaCJHi9/iXuXSTsY2AWMsY=;
        b=gU6vPu1GFfvOn7UuTamTz7Qvbfq/g17YMjTI2oz7SqnKfFRR5d2B3LodCi7RZmn+2Z
         o5Nl6Z79jI0J5hqASXCGwh3S5i8zp8PXMEUuq/k9x0sR38ZTkNvoReyrIE0IE0Pd6fBZ
         sovDtCZu1wLoSWdVc2R6sUNW/rysWNf+EuxgXO2VaxjhNwRrISvA+H+YUm+dxpjxr9L3
         y7CsNeMj19hhFwl+z4u60hg7XaxQqYrkhrViTBs1wGJkbDRHw4iA0pqVJg7/cI1RmvTv
         S7Wy1jLMI5g+eadYQQACSAj67OfMWxveZm7MVwcx5F98AvkwAxAs/6/PV/JG54j+2+bI
         nCRQ==
X-Gm-Message-State: AC+VfDz4DxQKuTelLTew5wfKt9JDXN8VG6PFLxT6P09OSJgA3EazWF2f
        Bsot9yp3Ksq7X8DkqFJfzI4Ryg==
X-Google-Smtp-Source: ACHHUZ6YMqjtq8gGiDzkbMNQ/MHSSYVCOEJDCYDPRfCczx0TmFk+RepR0z45VJZLZcnHXWZANi7t9A==
X-Received: by 2002:a05:6a00:21d6:b0:644:d775:60bb with SMTP id t22-20020a056a0021d600b00644d77560bbmr508528pfj.20.1686299442388;
        Fri, 09 Jun 2023 01:30:42 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm2184327pfi.169.2023.06.09.01.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:30:42 -0700 (PDT)
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
Subject: [PATCH 3/9] regulator: mt6358: Merge VCN33_* regulators
Date:   Fri,  9 Jun 2023 16:30:00 +0800
Message-ID: <20230609083009.2822259-4-wenst@chromium.org>
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

The VCN33_BT and VCN33_WIFI regulators are actually the same regulator,
having the same voltage setting and output pin. There are simply two
enable bits that are ORed together to enable the regulator.

Having two regulators representing the same output pin is misleading
from a design matching standpoint, and also error-prone in driver
implementations. If consumers try to set different voltages on either
regulator, the one set later would override the one set before. There
are ways around this, such as chaining them together and having the
downstream one act as a switch. But given there's only one output pin,
such a workaround doesn't match reality.

Remove the VCN33_WIFI regulator. During the probe phase, have the driver
sync the enable status of VCN33_WIFI to VCN33_BT. Also drop the suffix
so that the regulator name matches the pin name in the datasheet.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c       | 65 +++++++++++++++++-----
 include/linux/regulator/mt6358-regulator.h |  6 +-
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index c9e16bd092f6..faf6b0757019 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -277,7 +277,7 @@ static const unsigned int vcama_voltages[] = {
 	2800000, 2900000, 3000000,
 };
 
-static const unsigned int vcn33_bt_wifi_voltages[] = {
+static const unsigned int vcn33_voltages[] = {
 	3300000, 3400000, 3500000,
 };
 
@@ -321,7 +321,7 @@ static const u32 vcama_idx[] = {
 	0, 7, 9, 10, 11, 12,
 };
 
-static const u32 vcn33_bt_wifi_idx[] = {
+static const u32 vcn33_idx[] = {
 	1, 2, 3,
 };
 
@@ -566,12 +566,8 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
 		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6358_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
-		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
-		   0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6358_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
-		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
-		   0, MT6358_VCN33_ANA_CON0, 0x300),
+	MT6358_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
+		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
 	MT6358_LDO("ldo_vcama2", VCAMA2, vcama_voltages, vcama_idx,
 		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00),
 	MT6358_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
@@ -662,12 +658,8 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
 		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
 	MT6366_LDO("ldo_vemc", VEMC, vmch_vemc_voltages, vmch_vemc_idx,
 		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
-	MT6366_LDO("ldo_vcn33_bt", VCN33_BT, vcn33_bt_wifi_voltages,
-		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_0,
-		   0, MT6358_VCN33_ANA_CON0, 0x300),
-	MT6366_LDO("ldo_vcn33_wifi", VCN33_WIFI, vcn33_bt_wifi_voltages,
-		   vcn33_bt_wifi_idx, MT6358_LDO_VCN33_CON0_1,
-		   0, MT6358_VCN33_ANA_CON0, 0x300),
+	MT6366_LDO("ldo_vcn33", VCN33, vcn33_voltages, vcn33_idx,
+		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
 	MT6366_LDO("ldo_vmc", VMC, vmc_voltages, vmc_idx,
 		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
 	MT6366_LDO("ldo_vsim2", VSIM2, vsim_voltages, vsim_idx,
@@ -690,13 +682,56 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
 		    MT6358_LDO_VSRAM_CON1, 0x7f),
 };
 
+static int mt6358_sync_vcn33_setting(struct device *dev)
+{
+	struct mt6397_chip *mt6397 = dev_get_drvdata(dev->parent);
+	unsigned int val;
+	int ret;
+
+	/*
+	 * VCN33_WIFI and VCN33_BT are two separate enable bits for the same
+	 * regulator. They share the same voltage setting and output pin.
+	 * Instead of having two potentially conflicting regulators, just have
+	 * one VCN33 regulator. Sync the two enable bits and only use one in
+	 * the regulator device.
+	 */
+	ret = regmap_read(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, &val);
+	if (ret) {
+		dev_err(dev, "Failed to read VCN33_WIFI setting\n");
+		return ret;
+	}
+
+	if (!(val & BIT(0)))
+		return 0;
+
+	/* Sync VCN33_WIFI enable status to VCN33_BT */
+	ret = regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_0, BIT(0), BIT(0));
+	if (ret) {
+		dev_err(dev, "Failed to sync VCN33_WIFI setting to VCN33_BT\n");
+		return ret;
+	}
+
+	/* Disable VCN33_WIFI */
+	ret = regmap_update_bits(mt6397->regmap, MT6358_LDO_VCN33_CON0_1, BIT(0), 0);
+	if (ret) {
+		dev_err(dev, "Failed to disable VCN33_BT\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mt6358_regulator_probe(struct platform_device *pdev)
 {
 	struct mt6397_chip *mt6397 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
 	struct mt6358_regulator_info *mt6358_info;
-	int i, max_regulator;
+	int i, max_regulator, ret;
+
+	ret = mt6358_sync_vcn33_setting(&pdev->dev);
+	if (ret)
+		return ret;
 
 	if (mt6397->chip_id == MT6366_CHIP_ID) {
 		max_regulator = MT6366_MAX_REGULATOR;
diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux/regulator/mt6358-regulator.h
index bdcf83cd719e..a4307cd9edd6 100644
--- a/include/linux/regulator/mt6358-regulator.h
+++ b/include/linux/regulator/mt6358-regulator.h
@@ -41,8 +41,7 @@ enum {
 	MT6358_ID_VIO28,
 	MT6358_ID_VA12,
 	MT6358_ID_VRF18,
-	MT6358_ID_VCN33_BT,
-	MT6358_ID_VCN33_WIFI,
+	MT6358_ID_VCN33,
 	MT6358_ID_VCAMA2,
 	MT6358_ID_VMC,
 	MT6358_ID_VLDO28,
@@ -85,8 +84,7 @@ enum {
 	MT6366_ID_VIO28,
 	MT6366_ID_VA12,
 	MT6366_ID_VRF18,
-	MT6366_ID_VCN33_BT,
-	MT6366_ID_VCN33_WIFI,
+	MT6366_ID_VCN33,
 	MT6366_ID_VMC,
 	MT6366_ID_VAUD28,
 	MT6366_ID_VSIM2,
-- 
2.41.0.162.gfafddb0af9-goog

