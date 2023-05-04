Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F506F6852
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjEDJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjEDJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:31:24 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B1449CA;
        Thu,  4 May 2023 02:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683192670;
  x=1714728670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jjCnpEYTLJY9M80b6fAjW9uq9fqde0uLR4TTY9DxBBs=;
  b=BaiDI1GD17l24nYK+kL+uAhIUfZsl5QMWimGxidbj4Cx8Lyt+9K8xm8p
   gQusaz+12tbc9/7ZNceXlCR20lfq2AKSLgcabrLjEOcxnp6dEVgqnEcYd
   Xto0e7ycDd5DB43/MzZqV5TDUiTrUiY49R4RjlMWddk9hgu343EDVPA7v
   g8+2kHwrb6LCwLrLY4//YYAdpRNAmLOy3osekFRwGfTMUt2hkJQF9g1r+
   0iULrPz1KHPzPUcdSRc/ieL1bs4RzZap/bFvhxHPz5tgoKNOQDp9sPUOd
   eS+N0L3m4DxIc5RaKJrx4Fc4XcnOH3xP3RHPxyRDwbdm6TdwI8vsr/OpK
   Q==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH v5 2/2] power: supply: bq256xx: Apply TS_IGNORE from devicetree
Date:   Thu, 4 May 2023 17:30:37 +0800
Message-ID: <20230504093037.2056146-3-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230504093037.2056146-1-chenhuiz@axis.com>
References: <20230504093037.2056146-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TS_IGNORE is default off in bq256xx chip. For some HW which doesn't have
the NTC, we need to set TS_IGNORE to 1 to make the charge work. The new
"ti,no-thermistor" is introduced to toggle it.

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    v2: change property name to ti,no-thermistor
    
    v3: drop "|" in property description

    v4: rebase bq256xx_charger.c

    v5: add Reviewed-by tag from Krzysztof Kozlowski

 drivers/power/supply/bq256xx_charger.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 9cf4936440c9..cacaae1d559b 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -41,6 +41,9 @@
 #define BQ256XX_IINDPM_MAX_uA		3200000
 #define BQ256XX_IINDPM_DEF_uA		2400000
 
+#define BQ256XX_TS_IGNORE		BIT(6)
+#define BQ256XX_TS_IGNORE_SHIFT		6
+
 #define BQ256XX_VINDPM_MASK		GENMASK(3, 0)
 #define BQ256XX_VINDPM_STEP_uV		100000
 #define BQ256XX_VINDPM_OFFSET_uV	3900000
@@ -156,6 +159,7 @@
  * @vindpm: input voltage limit
  * @ichg_max: maximum fast charge current
  * @vbatreg_max: maximum charge voltage
+ * @ts_ignore: TS_IGNORE flag
  */
 struct bq256xx_init_data {
 	u32 ichg;
@@ -166,6 +170,7 @@ struct bq256xx_init_data {
 	u32 vindpm;
 	u32 ichg_max;
 	u32 vbatreg_max;
+	bool ts_ignore;
 };
 
 /**
@@ -263,6 +268,7 @@ struct bq256xx_device {
  * @bq256xx_set_iprechg: pointer to instance specific set_iprechg function
  * @bq256xx_set_vindpm: pointer to instance specific set_vindpm function
  * @bq256xx_set_charge_type: pointer to instance specific set_charge_type function
+ * @bq256xx_set_ts_ignore: pointer to instance specific set_ts_ignore function
  *
  * @bq256xx_def_ichg: default ichg value in microamps
  * @bq256xx_def_iindpm: default iindpm value in microamps
@@ -295,6 +301,7 @@ struct bq256xx_chip_info {
 	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
 	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
 	int (*bq256xx_set_charge_type)(struct bq256xx_device *bq, int type);
+	int (*bq256xx_set_ts_ignore)(struct bq256xx_device *bq, bool ts_ignore);
 
 	int bq256xx_def_ichg;
 	int bq256xx_def_iindpm;
@@ -696,6 +703,12 @@ static int bq25601d_set_chrg_volt(struct bq256xx_device *bq, int vbatreg)
 						BQ256XX_VBATREG_BIT_SHIFT);
 }
 
+static int bq256xx_set_ts_ignore(struct bq256xx_device *bq, bool ts_ignore)
+{
+	return regmap_update_bits(bq->regmap, BQ256XX_INPUT_CURRENT_LIMIT,
+				BQ256XX_TS_IGNORE, (ts_ignore ? 1 : 0) << BQ256XX_TS_IGNORE_SHIFT);
+}
+
 static int bq256xx_get_prechrg_curr(struct bq256xx_device *bq)
 {
 	unsigned int prechg_and_term_curr_lim;
@@ -1312,6 +1325,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_get_iterm = bq256xx_get_term_curr,
 		.bq256xx_get_iprechg = bq256xx_get_prechrg_curr,
 		.bq256xx_get_vindpm = bq256xx_get_input_volt_lim,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_set_ichg = bq256xx_set_ichg_curr,
 		.bq256xx_set_iindpm = bq256xx_set_input_curr_lim,
@@ -1351,6 +1365,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
 		.bq256xx_set_charge_type = bq256xx_set_charge_type,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1382,6 +1397,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
 		.bq256xx_set_charge_type = bq256xx_set_charge_type,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1413,6 +1429,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
 		.bq256xx_set_charge_type = bq256xx_set_charge_type,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1444,6 +1461,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
 		.bq256xx_set_charge_type = bq256xx_set_charge_type,
+		.bq256xx_set_ts_ignore = bq256xx_set_ts_ignore,
 
 		.bq256xx_def_ichg = BQ25611D_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1475,6 +1493,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
 		.bq256xx_set_charge_type = bq256xx_set_charge_type,
+		.bq256xx_set_ts_ignore = bq256xx_set_ts_ignore,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1506,6 +1525,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
 		.bq256xx_set_charge_type = bq256xx_set_charge_type,
+		.bq256xx_set_ts_ignore = bq256xx_set_ts_ignore,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1622,6 +1642,12 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
 	if (ret)
 		return ret;
 
+	if (bq->chip_info->bq256xx_set_ts_ignore) {
+		ret = bq->chip_info->bq256xx_set_ts_ignore(bq, bq->init_data.ts_ignore);
+		if (ret)
+			return ret;
+	}
+
 	power_supply_put_battery_info(bq->charger, bat_info);
 
 	return 0;
@@ -1656,6 +1682,8 @@ static int bq256xx_parse_dt(struct bq256xx_device *bq,
 	if (ret)
 		bq->init_data.iindpm = bq->chip_info->bq256xx_def_iindpm;
 
+	bq->init_data.ts_ignore = device_property_read_bool(bq->dev, "ti,no-thermistor");
+
 	return 0;
 }
 
-- 
2.30.2

