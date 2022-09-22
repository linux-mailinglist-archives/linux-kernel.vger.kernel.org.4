Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7670D5E5CD7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIVIEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIVIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:04:21 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED32B0895;
        Thu, 22 Sep 2022 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1663833860;
  x=1695369860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y7PksKknbCBSfoeFeaMHMaUOZcKfqwkfUuwxPKFRFE4=;
  b=oFtMewDYQpVirNgGhMHzzJP4qlNVGCDkYYirx5Fo8MpQi3W2fu6sejDn
   5+3CC9NXjomtoptH8ooSzno+wYl4DJi5dNAttrYWYZccXkjJaX2LDOH0q
   O7xs8IbYz/9wQk9kac7GhaHoxA6pYMgX+fjYknm2WPyQwmi2QXEBbJaft
   TZQf9X0+rc6IH4M5yzoQy9g+d8bfhQMahllH9gGe21wCK2bVUXVmEeEEu
   nqTu8E7gP9COCqY1CTVJXbRd3jjbldrhWA8YmBc1UE0GOfFhqcVWLg9h7
   tm4SXncMVSTsd2QgyhYYym70BkAfIkVFUhrCX5PVVk1cTMaRz3iFGv3jj
   w==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: bq256xx: Support enter ship mode
Date:   Thu, 22 Sep 2022 15:38:23 +0800
Message-ID: <20220922073823.1175772-1-chenhuiz@axis.com>
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

Support to enter ship mode by setting value to POWER_SUPPLY_PROP_ONLINE
which is same way as in bq24296.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 35 +++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 01ad84fd147c..35b9e1b733fe 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -141,6 +141,9 @@
 #define BQ256XX_WATCHDOG_DIS	0
 #define BQ256XX_WDT_BIT_SHIFT	4
 
+#define BQ256XX_BATFET_DISABLE_MASK		BIT(5)
+#define BQ256XX_BATFET_DISABLE_BIT_SHIFT	5
+
 #define BQ256XX_REG_RST		BIT(7)
 
 /**
@@ -259,6 +262,7 @@ struct bq256xx_device {
  * @bq256xx_set_iterm: pointer to instance specific set_iterm function
  * @bq256xx_set_iprechg: pointer to instance specific set_iprechg function
  * @bq256xx_set_vindpm: pointer to instance specific set_vindpm function
+ * @bq256xx_set_online: pointer to instance specific set_online function
  *
  * @bq256xx_def_ichg: default ichg value in microamps
  * @bq256xx_def_iindpm: default iindpm value in microamps
@@ -290,6 +294,7 @@ struct bq256xx_chip_info {
 	int (*bq256xx_set_iterm)(struct bq256xx_device *bq, int iterm);
 	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
 	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
+	int (*bq256xx_set_online)(struct bq256xx_device *bq, bool online);
 
 	int bq256xx_def_ichg;
 	int bq256xx_def_iindpm;
@@ -425,6 +430,7 @@ static int bq256xx_get_state(struct bq256xx_device *bq,
 {
 	unsigned int charger_status_0;
 	unsigned int charger_status_1;
+	unsigned int charger_control_3;
 	int ret;
 
 	ret = regmap_read(bq->regmap, BQ256XX_CHARGER_STATUS_0,
@@ -437,9 +443,15 @@ static int bq256xx_get_state(struct bq256xx_device *bq,
 	if (ret)
 		return ret;
 
+	ret = regmap_read(bq->regmap, BQ256XX_CHARGER_CONTROL_3,
+						&charger_control_3);
+	if (ret)
+		return ret;
+
 	state->vbus_stat = charger_status_0 & BQ256XX_VBUS_STAT_MASK;
 	state->chrg_stat = charger_status_0 & BQ256XX_CHRG_STAT_MASK;
-	state->online = charger_status_0 & BQ256XX_PG_STAT_MASK;
+	state->online = (charger_status_0 & BQ256XX_PG_STAT_MASK)
+			&& !(charger_control_3 & BQ256XX_BATFET_DISABLE_MASK);
 
 	state->wdt_fault = charger_status_1 & BQ256XX_WDT_FAULT_MASK;
 	state->bat_fault = charger_status_1 & BQ256XX_BAT_FAULT_MASK;
@@ -702,6 +714,13 @@ static int bq256xx_set_prechrg_curr(struct bq256xx_device *bq, int iprechg)
 				BQ256XX_IPRECHG_MASK, iprechg_reg_code);
 }
 
+static int bq256xx_set_online(struct bq256xx_device *bq, bool online)
+{
+	return regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_3,
+				BQ256XX_BATFET_DISABLE_MASK,
+				(online ? 0 : 1) << BQ256XX_BATFET_DISABLE_BIT_SHIFT);
+}
+
 static int bq25618_619_get_prechrg_curr(struct bq256xx_device *bq)
 {
 	unsigned int prechg_and_term_curr_lim;
@@ -915,6 +934,12 @@ static int bq256xx_set_charger_property(struct power_supply *psy,
 			return ret;
 		break;
 
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = bq->chip_info->bq256xx_set_online(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
+
 	default:
 		break;
 	}
@@ -1197,6 +1222,7 @@ static int bq256xx_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+	case POWER_SUPPLY_PROP_ONLINE:
 		return true;
 	default:
 		return false;
@@ -1286,6 +1312,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1316,6 +1343,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1346,6 +1374,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1376,6 +1405,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1406,6 +1436,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ25611D_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1436,6 +1467,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1466,6 +1498,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
-- 
2.30.2

