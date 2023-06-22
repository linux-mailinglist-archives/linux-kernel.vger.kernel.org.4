Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A932A739800
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjFVHQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjFVHQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:16:38 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA3E69;
        Thu, 22 Jun 2023 00:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fFVRpThLopAOrI7yVx0trLMYaXbzsG/TuaZoGCChqNw=; b=fSkCGMLx+NtSIbxhA4neDCIrap
        qFGe6/138gRm4hZ/6lRTphSY3opopD9feU9LWWb9jYjHb1/rSQlwXXewKzfOGRBe5EfEAHHpuK2s/
        mDoohjOQJn+9LlH1lPSF5wTOqw0Br0Fgu2JWbKa6kRQkI7ROWwFEdAb8E9OK2JiYaQg1emlKZSj0x
        bhZZBs0r9SI2De+otddX/HV171HjAlQolyOEt7SqTeqzWB9xX6H4cn8P3M4G3zt3izODvQUhIeLZh
        57GCiIy4UqTmLbfAkDmlQKhJTvlPMXM+DGgeZVKExbygfhDdvSZknk26suzIjPGf7YuXUl5HhppKf
        S7VK528g==;
Received: from [89.212.21.243] (port=50578 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1qCEYN-00GUK0-2G;
        Thu, 22 Jun 2023 09:16:27 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@phytec.de
Subject: [PATCH v2] rtc: rv3028: Improve trickle charger logic
Date:   Thu, 22 Jun 2023 09:16:09 +0200
Message-Id: <20230622071609.4032736-1-andrej.picej@norik.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property "trickle-resistor-ohms" allows us to set trickle charger
resistor. However there is no possibility to disable it afterwards.

From now on, disable trickle charger circuit in case device-tree
property "trickle-resistor-ohms" is set to -1.

Additionally, lets make sure we only update internal EEPROM in case of a
change. This prevents wear due to excessive EEPROM writes on each probe.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
Changes in v2:
- disable trickle charger if device tree property trickle-resistor-ohms
  is set to -1.
---
 drivers/rtc/rtc-rv3028.c | 45 +++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index ec5d7a614e2d..da2ae81fe7c8 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -859,7 +859,8 @@ static int rv3028_probe(struct i2c_client *client)
 {
 	struct rv3028_data *rv3028;
 	int ret, status;
-	u32 ohms;
+	s32 ohms;
+	int val_old, val;
 	struct nvmem_config nvmem_cfg = {
 		.name = "rv3028_nvram",
 		.word_size = 1,
@@ -937,22 +938,42 @@ static int rv3028_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	/* setup trickle charger */
-	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
-				      &ohms)) {
-		int i;
+	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
+	if (ret < 0)
+		return ret;
+
+	/* mask out only trickle charger bits */
+	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
 
-		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
-			if (ohms == rv3028_trickle_resistors[i])
-				break;
+	/* setup trickle charger */
+	if (!of_property_read_s32(client->dev.of_node, "trickle-resistor-ohms",
+				  &ohms)) {
+		/* disable trickle charger if trickle-resistor-ohms = <(-1)>; */
+		if (ohms == -1) {
+			val = val_old & ~RV3028_BACKUP_TCE;
+		} else {
+			int i;
+
+			for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
+				if (ohms == rv3028_trickle_resistors[i])
+					break;
+
+			if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
+				/* enable trickle charger and its resistor */
+				val = RV3028_BACKUP_TCE | i;
+			} else {
+				dev_warn(&client->dev, "invalid trickle resistor value\n");
+				/* don't update the trickle charger regs */
+				val = val_old;
+			}
+		}
 
-		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
+		/* only update EEPROM if changes are necessary */
+		if (val_old != val) {
 			ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
-						 RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | i);
+						RV3028_BACKUP_TCR_MASK, val);
 			if (ret)
 				return ret;
-		} else {
-			dev_warn(&client->dev, "invalid trickle resistor value\n");
 		}
 	}
 
-- 
2.25.1

