Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38969C61B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjBTHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBTHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:46:17 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C48C155;
        Sun, 19 Feb 2023 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1676879175;
  x=1708415175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5yPWroyn3aNHh9K3OX8yo+biaUW5/hlX8pX089G89tg=;
  b=VtAOtBOKlFiKbvfzfhjHy+lWcsU1oJQgZAlgGE7VOWgPgtqnflpNT/UX
   Nbc/EsxcyFFoNjxK+ufVlnHRgbl/Ugqf1TrWpo27xEBAkrsUQS52pxzRj
   2u9CgvZjYBqsgKslt/o3ijrRGoY7aw7bRBunAIJzOfLEbNDsw5wa9pYY8
   7rijzzImeLbLglYegY28gkgQzun+MQwEXgMcOy23KG3HTBJPEtIuZZ8lu
   DsWOZ/cRlr8MUMsgqS3yF7v7u7Bvm+RDwDGwpZDGw9mMgZDaORUo/o/IG
   Xc9vIM8uByR/x444DvWh/sWmIxI547uNCxfr5vUxZ242J3PIwyhIjy8gR
   w==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <kernel@axis.com>, Hermes Zhang <chenhuiz@axis.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] power: supply: bq256xx: Support enter shipping mode
Date:   Mon, 20 Feb 2023 15:45:30 +0800
Message-ID: <20230220074531.2092495-1-chenhuiz@axis.com>
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

Enable shipping mode for bq256xx chip. The shipping mode can be enabled
by echo 0 > /sys/class/power_supply/bq256xx-charger/online.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---
 drivers/power/supply/bq256xx_charger.c | 35 ++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index db13e288e439..c01ef9d26d31 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -115,6 +115,9 @@
 #define BQ256XX_VBUS_STAT_USB_DCP	(BIT(6) | BIT(5))
 #define BQ256XX_VBUS_STAT_USB_OTG	(BIT(7) | BIT(6) | BIT(5))
 
+#define BQ256XX_BATFET_DISABLE_MASK		BIT(5)
+#define BQ256XX_BATFET_DISABLE_BIT_SHIFT	5
+
 #define BQ256XX_CHRG_STAT_MASK		GENMASK(4, 3)
 #define BQ256XX_CHRG_STAT_NOT_CHRGING	0
 #define BQ256XX_CHRG_STAT_PRECHRGING	BIT(3)
@@ -290,6 +293,7 @@ struct bq256xx_chip_info {
 	int (*bq256xx_set_iterm)(struct bq256xx_device *bq, int iterm);
 	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
 	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
+	int (*bq256xx_set_online)(struct bq256xx_device *bq, bool online);
 
 	int bq256xx_def_ichg;
 	int bq256xx_def_iindpm;
@@ -425,6 +429,7 @@ static int bq256xx_get_state(struct bq256xx_device *bq,
 {
 	unsigned int charger_status_0;
 	unsigned int charger_status_1;
+	unsigned int charger_control_3;
 	int ret;
 
 	ret = regmap_read(bq->regmap, BQ256XX_CHARGER_STATUS_0,
@@ -437,9 +442,15 @@ static int bq256xx_get_state(struct bq256xx_device *bq,
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
@@ -702,6 +713,13 @@ static int bq256xx_set_prechrg_curr(struct bq256xx_device *bq, int iprechg)
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
@@ -915,6 +933,11 @@ static int bq256xx_set_charger_property(struct power_supply *psy,
 			return ret;
 		break;
 
+	case POWER_SUPPLY_PROP_ONLINE:
+		ret = bq->chip_info->bq256xx_set_online(bq, val->intval);
+		if (ret)
+			return ret;
+		break;
 	default:
 		break;
 	}
@@ -1197,6 +1220,7 @@ static int bq256xx_property_is_writeable(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT:
 	case POWER_SUPPLY_PROP_STATUS:
 	case POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT:
+	case POWER_SUPPLY_PROP_ONLINE:
 		return true;
 	default:
 		return false;
@@ -1229,7 +1253,7 @@ static bool bq256xx_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case BQ256XX_INPUT_CURRENT_LIMIT:
-	case BQ256XX_CHARGER_STATUS_0...BQ256XX_CHARGER_STATUS_2:
+	case BQ256XX_CHARGER_CONTROL_3...BQ256XX_CHARGER_STATUS_2:
 		return true;
 	default:
 		return false;
@@ -1286,6 +1310,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1316,6 +1341,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1346,6 +1372,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1376,6 +1403,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1406,6 +1434,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ25611D_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1436,6 +1465,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1466,6 +1496,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_online = bq256xx_set_online,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
-- 
2.30.2

