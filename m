Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153A973B286
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjFWIQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjFWIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:16:36 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A968210E;
        Fri, 23 Jun 2023 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VJa9shLHgF87H+WGyUBUS4yjhDCJzJnbfY3ES+cpUvE=; b=VW9bWuUWk8OJfrMF7XZtZB5x8z
        YFksN8qW8H3p1tOTIHOPuidAmPEmtYiGbhfJhGv80P5BxsU+ysafHsMDyHmnqupYQU4eEP83X8lJX
        zGK/dhHO1asw0R5b1H4vWoHQwId1ubvRn3qx3UsHuZQY664VlysOwUAXvN1nEgntOEMiJWzwfsHa/
        SPKXq0iTc8BYZZaEw/w0E934gXDqkl8LpAF4d5W7EO/fYUy5+BoPPBzfx02YED8ijajClLw7KE86L
        Y9Oi0Q+36BME5nyz+2HgDrdCAOk9YqpDYXQNwWsU6LTsWiIVo68d1IPlj0czOS80ZSwjKkBX+3pQm
        9d9zMKuQ==;
Received: from [89.212.21.243] (port=33802 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qCbxq-002YUK-0s;
        Fri, 23 Jun 2023 10:16:18 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@phytec.de
Subject: [PATCH v3] rtc: rv3028: Add support for "aux-voltage-chargeable" property
Date:   Fri, 23 Jun 2023 10:15:33 +0200
Message-Id: <20230623081533.76334-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property "trickle-resistor-ohms" allows us to set trickle charger
resistor. However there is no possibility to disable it afterwards.

Add support for "aux-voltage-chargeable" property which can be used to
enable/disable the trickle charger circuit explicitly. The default
behavior of the code is kept as it is!

Additionally, lets make sure we only update internal EEPROM in case of a
change. This prevents wear due to excessive EEPROM writes on each probe.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v3:
- use "aux-voltage-chargeable" to enable/disable trickle charger,
- put trickle charger init code in a separate function.
---
 drivers/rtc/rtc-rv3028.c | 80 ++++++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index ec5d7a614e2d..e3338765c687 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -855,11 +855,68 @@ static const struct regmap_config regmap_config = {
         .max_register = 0x37,
 };
 
+static u8 rv3028_set_trickle_charger(struct rv3028_data *rv3028,
+				     struct i2c_client *client)
+{
+	int ret, val_old, val;
+	u32 ohms, chargeable;
+
+	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
+	if (ret < 0)
+		return ret;
+
+	/* mask out only trickle charger bits */
+	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
+	val = val_old;
+
+	/* setup trickle charger */
+	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
+				      &ohms)) {
+		int i;
+
+		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
+			if (ohms == rv3028_trickle_resistors[i])
+				break;
+
+		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
+			/* enable trickle charger and its resistor */
+			val = RV3028_BACKUP_TCE | i;
+		} else {
+			dev_warn(&client->dev, "invalid trickle resistor value\n");
+		}
+	}
+
+	if (!device_property_read_u32(&client->dev, "aux-voltage-chargeable",
+				      &chargeable)) {
+		switch (chargeable) {
+		case 0:
+			val &= ~RV3028_BACKUP_TCE;
+			break;
+		case 1:
+			val |= RV3028_BACKUP_TCE;
+			break;
+		default:
+			dev_warn(&client->dev,
+				 "unsupported aux-voltage-chargeable value\n");
+			break;
+		}
+	}
+
+	/* only update EEPROM if changes are necessary */
+	if (val_old != val) {
+		ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
+						RV3028_BACKUP_TCR_MASK, val);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int rv3028_probe(struct i2c_client *client)
 {
 	struct rv3028_data *rv3028;
 	int ret, status;
-	u32 ohms;
 	struct nvmem_config nvmem_cfg = {
 		.name = "rv3028_nvram",
 		.word_size = 1,
@@ -937,24 +994,9 @@ static int rv3028_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	/* setup trickle charger */
-	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
-				      &ohms)) {
-		int i;
-
-		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
-			if (ohms == rv3028_trickle_resistors[i])
-				break;
-
-		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
-			ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
-						 RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | i);
-			if (ret)
-				return ret;
-		} else {
-			dev_warn(&client->dev, "invalid trickle resistor value\n");
-		}
-	}
+	ret = rv3028_set_trickle_charger(rv3028, client);
+	if (ret)
+		return ret;
 
 	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
 	if (ret)
-- 
2.25.1

