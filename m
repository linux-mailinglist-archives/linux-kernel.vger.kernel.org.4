Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933176C609E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjCWHY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjCWHYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 03:24:53 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FEFEF86;
        Thu, 23 Mar 2023 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1679556269;
  x=1711092269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U5FeI+aG2h+MviWYRg4Ym0QkhQ+gjHx8yklsv2kVRUc=;
  b=gYGzml+KO+WdWAGIFt4B33LOUGoktl5pCg5Rgz4U7ztxIcWToTOSPg8k
   asqtqKtzW07r9nAS/pFPM0shybX7l38gb3D0JF+/5Rvbtreuy9DFi8HYb
   gYOzQSeZa6c70ykovWAZnJ4osCRytOxf91b/7M7TWnVT+unkq0apVnCjO
   /IwA8Z0AFT0Di/48fIgK2eqzyFVo/aorQnylZ0I8UU5SvgZ/ZcY5/QGwW
   xmFvaaPE7Qja22PonX1K4KY2ZrAZGCdx3PiZ+pHcnjbmuUqLpIQbNMc6F
   Tm9xnEP/u1hJ30Pb8TLwRHMky9vvQVqdK3YBrPMf78dj/vG112JqbWIQl
   A==;
From:   Hermes Zhang <chenhuiz@axis.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 2/2] power: supply: bq256xx: Apply TS_IGNORE from devicetree
Date:   Thu, 23 Mar 2023 15:23:47 +0800
Message-ID: <20230323072347.438932-2-chenhuiz@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230323072347.438932-1-chenhuiz@axis.com>
References: <20230323072347.438932-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
@@ -153,6 +156,7 @@
  * @vindpm: input voltage limit
  * @ichg_max: maximum fast charge current
  * @vbatreg_max: maximum charge voltage
+ * @ts_ignore: TS_IGNORE flag
  */
 struct bq256xx_init_data {
 	u32 ichg;
@@ -163,6 +167,7 @@ struct bq256xx_init_data {
 	u32 vindpm;
 	u32 ichg_max;
 	u32 vbatreg_max;
+	bool ts_ignore;
 };
 
 /**
@@ -259,6 +264,7 @@ struct bq256xx_device {
  * @bq256xx_set_iterm: pointer to instance specific set_iterm function
  * @bq256xx_set_iprechg: pointer to instance specific set_iprechg function
  * @bq256xx_set_vindpm: pointer to instance specific set_vindpm function
+ * @bq256xx_set_ts_ignore: pointer to instance specific set_ts_ignore function
  *
  * @bq256xx_def_ichg: default ichg value in microamps
  * @bq256xx_def_iindpm: default iindpm value in microamps
@@ -290,6 +296,7 @@ struct bq256xx_chip_info {
 	int (*bq256xx_set_iterm)(struct bq256xx_device *bq, int iterm);
 	int (*bq256xx_set_iprechg)(struct bq256xx_device *bq, int iprechg);
 	int (*bq256xx_set_vindpm)(struct bq256xx_device *bq, int vindpm);
+	int (*bq256xx_set_ts_ignore)(struct bq256xx_device *bq, bool ts_ignore);
 
 	int bq256xx_def_ichg;
 	int bq256xx_def_iindpm;
@@ -670,6 +677,12 @@ static int bq25601d_set_chrg_volt(struct bq256xx_device *bq, int vbatreg)
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
@@ -1279,6 +1292,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_get_iterm = bq256xx_get_term_curr,
 		.bq256xx_get_iprechg = bq256xx_get_prechrg_curr,
 		.bq256xx_get_vindpm = bq256xx_get_input_volt_lim,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_set_ichg = bq256xx_set_ichg_curr,
 		.bq256xx_set_iindpm = bq256xx_set_input_curr_lim,
@@ -1316,6 +1330,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1346,6 +1361,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1376,6 +1392,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_ts_ignore = NULL,
 
 		.bq256xx_def_ichg = BQ2560X_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1406,6 +1423,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq256xx_set_term_curr,
 		.bq256xx_set_iprechg = bq256xx_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_ts_ignore = bq256xx_set_ts_ignore,
 
 		.bq256xx_def_ichg = BQ25611D_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1436,6 +1454,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_ts_ignore = bq256xx_set_ts_ignore,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1466,6 +1485,7 @@ static const struct bq256xx_chip_info bq256xx_chip_info_tbl[] = {
 		.bq256xx_set_iterm = bq25618_619_set_term_curr,
 		.bq256xx_set_iprechg = bq25618_619_set_prechrg_curr,
 		.bq256xx_set_vindpm = bq256xx_set_input_volt_lim,
+		.bq256xx_set_ts_ignore = bq256xx_set_ts_ignore,
 
 		.bq256xx_def_ichg = BQ25618_ICHG_DEF_uA,
 		.bq256xx_def_iindpm = BQ256XX_IINDPM_DEF_uA,
@@ -1582,6 +1602,12 @@ static int bq256xx_hw_init(struct bq256xx_device *bq)
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
@@ -1616,6 +1642,8 @@ static int bq256xx_parse_dt(struct bq256xx_device *bq,
 	if (ret)
 		bq->init_data.iindpm = bq->chip_info->bq256xx_def_iindpm;
 
+	bq->init_data.ts_ignore = device_property_read_bool(bq->dev, "ti,no-thermistor");
+
 	return 0;
 }
 
-- 
2.30.2

