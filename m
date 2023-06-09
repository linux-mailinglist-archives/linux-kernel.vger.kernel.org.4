Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5472933D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240932AbjFIIcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbjFIIbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:31:21 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93803A9F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 01:30:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-651e298be3fso1570316b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686299447; x=1688891447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y20hfxdBlfIy/ItHN/HqfoEN5rlOgkF1Vq6pZHwBBZQ=;
        b=b1z1ImptZRD1QiXEaYQtBkKMiaM1FzlNwl9m2l0/VOouTX+wm5uYRm2cqqdIywDi3P
         wzrJ7EddFJviATlgeX9kWgCVwZciNX1ZoNozWzT9lc9gWLb6dNIASTx2pNtphn3V/ple
         MVgElzNSNJNs36hcTdccf0alSjZNX1fHWvlzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686299447; x=1688891447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y20hfxdBlfIy/ItHN/HqfoEN5rlOgkF1Vq6pZHwBBZQ=;
        b=hs/ezg/+nYPuv6bA16DjGvnsFMBwcUaoa26nltkJKlN+2PhXfn6roJwafFJgZnMGEZ
         hGsvKeh0wPEsjl9mKuRqrK8sgsNhAAOV5qBTKVecRzVoQWJ4CFmvOcE0L0aqIm2o3tcM
         DLsbtpDTQavcU0pxjU2wNeTA35rG0lKEcm7rdBJD12gW2XkCwvdKe3UN5FHJcgIR50Yn
         NaGr2H2fGI7OTKS3NVwu7c7by7xWfTzXsuQnVawMW7vJsUuMmQYdlllxW+q9h4MiIdV0
         1EIJ4Zu7TLkqV3lQ8OYRZgd1zbZuP93guC3Rtwp/3LT8OPaFTp9IrvOhU1rrvNtJoJjz
         /cvg==
X-Gm-Message-State: AC+VfDzaHC/2nwD2DT2QWXRUemeXi3XCGnzGeKt4wofF+dWD52jSGd5K
        PQNN5UBwAa7WEzy6k1K8wEHeEQ==
X-Google-Smtp-Source: ACHHUZ5Put2IsUN+JeMEl0ftnTU8g4YJZw9JRRCey+z+DaRPLycmDKsBgW74WLrRp8KgF+PhgfXgTg==
X-Received: by 2002:a05:6a20:1606:b0:10f:708b:bb28 with SMTP id l6-20020a056a20160600b0010f708bbb28mr797120pzj.7.1686299447295;
        Fri, 09 Jun 2023 01:30:47 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:c2ea:d8e4:1fe8:21f0])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm2184327pfi.169.2023.06.09.01.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:30:46 -0700 (PDT)
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
Subject: [PATCH 5/9] regulator: mt6358: Const-ify mt6358_regulator_info data structures
Date:   Fri,  9 Jun 2023 16:30:02 +0800
Message-ID: <20230609083009.2822259-6-wenst@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
In-Reply-To: <20230609083009.2822259-1-wenst@chromium.org>
References: <20230609083009.2822259-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the MT6358 regulator driver, each regulator is described by a
|struct regulator_desc| wrapped by a |struct mt6358_regulator_info|.
The latter was tied to the regulator device using the config's
driver_data field, which meant that the variables could not be constant.

Since each regulator device has a pointer to its regulator_desc, and
mt6358_regulator_info wraps that, the driver could use container_of()
to retrieve it instead.

Switch to using container_of(), drop tha driver_data setting, and
const-ify all the regulator descriptions.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/regulator/mt6358-regulator.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
index 946a251a8b3a..2851ef53ac63 100644
--- a/drivers/regulator/mt6358-regulator.c
+++ b/drivers/regulator/mt6358-regulator.c
@@ -34,6 +34,8 @@ struct mt6358_regulator_info {
 	u32 modeset_mask;
 };
 
+#define to_regulator_info(x) container_of((x), struct mt6358_regulator_info, desc)
+
 #define MT6358_BUCK(match, vreg, min, max, step,		\
 	volt_ranges, vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
 	_modeset_reg, _modeset_shift)		\
@@ -342,9 +344,9 @@ static unsigned int mt6358_map_mode(unsigned int mode)
 static int mt6358_set_voltage_sel(struct regulator_dev *rdev,
 				  unsigned int selector)
 {
+	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int idx, ret;
 	const u32 *pvol;
-	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
 
 	pvol = info->index_table;
 
@@ -358,9 +360,9 @@ static int mt6358_set_voltage_sel(struct regulator_dev *rdev,
 
 static int mt6358_get_voltage_sel(struct regulator_dev *rdev)
 {
+	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int idx, ret;
 	u32 selector;
-	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
 	const u32 *pvol;
 
 	ret = regmap_read(rdev->regmap, info->desc.vsel_reg, &selector);
@@ -384,8 +386,8 @@ static int mt6358_get_voltage_sel(struct regulator_dev *rdev)
 
 static int mt6358_get_buck_voltage_sel(struct regulator_dev *rdev)
 {
+	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int ret, regval;
-	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
 
 	ret = regmap_read(rdev->regmap, info->da_vsel_reg, &regval);
 	if (ret != 0) {
@@ -402,9 +404,9 @@ static int mt6358_get_buck_voltage_sel(struct regulator_dev *rdev)
 
 static int mt6358_get_status(struct regulator_dev *rdev)
 {
+	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int ret;
 	u32 regval;
-	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
 
 	ret = regmap_read(rdev->regmap, info->status_reg, &regval);
 	if (ret != 0) {
@@ -418,7 +420,7 @@ static int mt6358_get_status(struct regulator_dev *rdev)
 static int mt6358_regulator_set_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
 {
-	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
+	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int val;
 
 	switch (mode) {
@@ -443,7 +445,7 @@ static int mt6358_regulator_set_mode(struct regulator_dev *rdev,
 
 static unsigned int mt6358_regulator_get_mode(struct regulator_dev *rdev)
 {
-	struct mt6358_regulator_info *info = rdev_get_drvdata(rdev);
+	const struct mt6358_regulator_info *info = to_regulator_info(rdev->desc);
 	int ret, regval;
 
 	ret = regmap_read(rdev->regmap, info->modeset_reg, &regval);
@@ -498,7 +500,7 @@ static const struct regulator_ops mt6358_volt_fixed_ops = {
 };
 
 /* The array is indexed by id(MT6358_ID_XXX) */
-static struct mt6358_regulator_info mt6358_regulators[] = {
+static const struct mt6358_regulator_info mt6358_regulators[] = {
 	MT6358_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
 		    buck_volt_range2, 0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f,
 		    MT6358_VDRAM1_ANA_CON0, 8),
@@ -589,7 +591,7 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
 };
 
 /* The array is indexed by id(MT6366_ID_XXX) */
-static struct mt6358_regulator_info mt6366_regulators[] = {
+static const struct mt6358_regulator_info mt6366_regulators[] = {
 	MT6366_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
 		    buck_volt_range2, 0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f,
 		    MT6358_VDRAM1_ANA_CON0, 8),
@@ -712,7 +714,7 @@ static int mt6358_regulator_probe(struct platform_device *pdev)
 	struct mt6397_chip *mt6397 = dev_get_drvdata(pdev->dev.parent);
 	struct regulator_config config = {};
 	struct regulator_dev *rdev;
-	struct mt6358_regulator_info *mt6358_info;
+	const struct mt6358_regulator_info *mt6358_info;
 	int i, max_regulator, ret;
 
 	ret = mt6358_sync_vcn33_setting(&pdev->dev);
@@ -729,7 +731,6 @@ static int mt6358_regulator_probe(struct platform_device *pdev)
 
 	for (i = 0; i < max_regulator; i++) {
 		config.dev = &pdev->dev;
-		config.driver_data = &mt6358_info[i];
 		config.regmap = mt6397->regmap;
 
 		rdev = devm_regulator_register(&pdev->dev,
-- 
2.41.0.162.gfafddb0af9-goog

