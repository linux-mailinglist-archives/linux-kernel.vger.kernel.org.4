Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E992A6B1BAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCIGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCIGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:41:57 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E51F6A04D;
        Wed,  8 Mar 2023 22:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1678344103;
  x=1709880103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YyvA9TXPf9GVqen8uKIEeEetOR39Q5lxbugDfV9IAuc=;
  b=WlSuLXXbAIv7652tAqjpynfaYlGLuyUIQ7uJU3b14IEGTsHBKfZNCYTl
   p4BOUvjvw2nqOSLiJEJK/+3ZwYA+7d3FtrSkD8P5lzIKdDEpu2VDpsUYk
   xVLaGCrvB0n4OX4P/aEstAZrgsrHGdGi/oVxUL+5gKV0jyvMrOOQeroM2
   AHVWrZIyScsWQtRROV809ObdH/7oJStNVeyvgzWVcq35yHaqkuCVbnM7M
   H9OaZDwqJZQ02iaz1nXhxqzwXvFssqzIi6ojr0nU5LnbdoUTqmYxLF8jg
   YHA9KRgfM+4Y12J+c26rlBImzCPkU8ZGgO+LHa5gyc3vS4T22/7JcT/NU
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: bq256xx: Support to disable charger
Date:   Thu, 9 Mar 2023 14:41:03 +0800
Message-ID: <20230309064104.79005-1-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to control the charging process flexible, we need to able to
disable the charger. This commit will allow to disable the charger by
"echo 1 > /sys/class/power_supply/bq256xx-charger/charge_type"
(1 = POWER_SUPPLY_CHARGE_TYPE_NONE) and enable the charger by set it to
2/3 (POWER_SUPPLY_CHARGE_TYPE_TRICKLE/POWER_SUPPLY_CHARGE_TYPE_FAST)

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 9cf4936440c9..e624834ae66c 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -70,6 +70,9 @@
 #define BQ25611D_VBATREG_THRESH_uV	4290000
 #define BQ25618_VBATREG_THRESH_uV	4300000
 
+#define BQ256XX_CHG_CONFIG_MASK		BIT(4)
+#define BQ256XX_CHG_CONFIG_BIT_SHIFT	4
+
 #define BQ256XX_ITERM_MASK		GENMASK(3, 0)
 #define BQ256XX_ITERM_STEP_uA		60000
 #define BQ256XX_ITERM_OFFSET_uA		60000
@@ -259,6 +262,7 @@ struct bq256xx_device {
  * @bq256xx_set_iterm: pointer to instance specific set_iterm function
  * @bq256xx_set_iprechg: pointer to instance specific set_iprechg function
  * @bq256xx_set_vindpm: pointer to instance specific set_vindpm function
+ * @bq256xx_set_charge_type: pointer to instance specific set_charge_type function
  *
  * @bq256xx_def_ichg: default ichg value in microamps
  * @bq256xx_def_iindpm: default iindpm value in microamps
@@ -290,6 +294,7 @@ struct bq256xx_chip_info {
 	int (*bq256xx_set_iterm)(struct bq256xx_device *bq, int iterm);
 	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
 	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
+	int (*bq256xx_set_charge_type)(struct bq256xx_device *bq, int type);
 
 	int bq256xx_def_ichg;
 	int bq256xx_def_iindpm;
@@ -449,6 +454,27 @@ static int bq256xx_get_state(struct bq256xx_device *bq,
 	return 0;
 }
 
+static int bq256xx_set_charge_type(struct bq256xx_device *bq, int type)
+{
+	int chg_config = 0;
+
+	switch (type) {
+	case POWER_SUPPLY_CHARGE_TYPE_NONE:
+		chg_config = 0x0;
+		break;
+	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
+		chg_config = 0x1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_0,
+				BQ256XX_CHG_CONFIG_MASK,
+				(chg_config ? 1 : 0) << BQ256XX_CHG_CONFIG_BIT_SHIFT);
+}
+
 static int bq256xx_get_ichg_curr(struct bq256xx_device *bq)
 {
 	unsigned int charge_current_limit;
@@ -915,6 +941,12 @@ static int bq256xx_set_charger_property(struct power_supply *psy,
 			return ret;
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = bq->chip_info->bq256xx_set_charge_type(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		break;
 	}
@@ -1197,6 +1229,7 @@ static int bq256xx_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
 		return true;
 	default:
 		return false;
@@ -1286,6 +1319,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1316,6 +1350,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1346,6 +1381,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1376,6 +1412,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1406,6 +1443,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ25611D_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1436,6 +1474,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1466,6 +1505,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_charge_type = bq256xx_set_charge_type,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
-- 
2.30.2

