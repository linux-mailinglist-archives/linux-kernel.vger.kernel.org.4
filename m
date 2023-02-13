Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CE1694BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjBMQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjBMQAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:00:05 -0500
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA741E5E5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:00:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44F21BFC15;
        Mon, 13 Feb 2023 16:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1676304000; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=puyx+iiRxk3cL3YhVNnHADs9ip7L0cjTR7aBYLsdwyo=;
        b=tmp9fOASxyTRGGPhZxA+uJ0cpOaxeKHEW7pENeYZ2WDn4rMWliOwJ3O7kG1j342DA7FyNy
        RZOLozTbA2I5K6Q4b1MHUWN1Zl2IEUH965pSkIwnUPJJBaQQP5nKqtiUo2oBiaTjrQOPwd
        eeUKCbdp1G29MGQz+n2lWzvurenzsPS3aSty2HDdjiLq5hxdBNCBhD/evPzxeZab//S09j
        AFakjs0zCwqgKVI/ggtzhJUpU3XrYYS8qXhmOjqNmYTh2qrk5hp/J39kc2AUFAi4rKDyI7
        9kXiMB/JZLoJMO8S8DNGH3nBCtKRY8UwEJr9iM34MYsOY21N2y6/zDNctmHE8Q==
From:   Frieder Schrempf <frieder@fris.de>
To:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4/6] regulator: Add operation to let drivers select vsel register
Date:   Mon, 13 Feb 2023 16:58:22 +0100
Message-Id: <20230213155833.1644366-5-frieder@fris.de>
In-Reply-To: <20230213155833.1644366-1-frieder@fris.de>
References: <20230213155833.1644366-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There are regulators that use multiple registers for storing the
voltage. Add a get_reg_voltage_sel member to struct regulator_ops in
order to let drivers register a function that returns the currently
used register.

The pca9450 driver will be a user of this as the LDO5 regulator of
that chip uses two different control registers depending on the
state of an external signal.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/regulator/helpers.c      | 16 ++++++++++++++--
 include/linux/regulator/driver.h |  5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index ad2237a95572..e629b0bea3d0 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -223,6 +223,16 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_pickable_regmap);
 
+unsigned int regulator_get_hwreg_voltage_sel_regmap(struct regulator_dev *rdev)
+{
+	const struct regulator_ops *ops = rdev->desc->ops;
+
+	if (ops->get_reg_voltage_sel)
+		return ops->get_reg_voltage_sel(rdev);
+
+	return rdev->desc->vsel_reg;
+}
+
 /**
  * regulator_get_voltage_sel_regmap - standard get_voltage_sel for regmap users
  *
@@ -234,10 +244,11 @@ EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_pickable_regmap);
  */
 int regulator_get_voltage_sel_regmap(struct regulator_dev *rdev)
 {
+	unsigned int vsel_reg = regulator_get_hwreg_voltage_sel_regmap(rdev);
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	ret = regmap_read(rdev->regmap, vsel_reg, &val);
 	if (ret != 0)
 		return ret;
 
@@ -260,11 +271,12 @@ EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_regmap);
  */
 int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned sel)
 {
+	unsigned int vsel_reg = regulator_get_hwreg_voltage_sel_regmap(rdev);
 	int ret;
 
 	sel <<= ffs(rdev->desc->vsel_mask) - 1;
 
-	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+	ret = regmap_update_bits(rdev->regmap, vsel_reg,
 				  rdev->desc->vsel_mask, sel);
 	if (ret)
 		return ret;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index d3b4a3d4514a..c9953b2f63d5 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -77,6 +77,10 @@ enum regulator_detection_severity {
  * @get_voltage_sel: Return the currently configured voltage selector for the
  *                   regulator; return -ENOTRECOVERABLE if regulator can't
  *                   be read at bootup and hasn't been set yet.
+ * @get_reg_voltage_sel: Return the register used for getting/setting the
+ *                       voltage of the regulator. This is useful if the
+ *                       regulator uses multiple registers internally, switched
+ *                       by some condition like the state of an external signal.
  * @list_voltage: Return one of the supported voltages, in microvolts; zero
  *	if the selector indicates a voltage that is unusable on this system;
  *	or negative errno.  Selectors range from zero to one less than
@@ -168,6 +172,7 @@ struct regulator_ops {
 	int (*set_voltage_sel) (struct regulator_dev *, unsigned selector);
 	int (*get_voltage) (struct regulator_dev *);
 	int (*get_voltage_sel) (struct regulator_dev *);
+	unsigned int (*get_reg_voltage_sel) (struct regulator_dev *);
 
 	/* get/set regulator current  */
 	int (*set_current_limit) (struct regulator_dev *,
-- 
2.39.1

