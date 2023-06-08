Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF82727D67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235787AbjFHLAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFHLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:00:11 -0400
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0E11A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 04:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GMxYhkc1VAN6YvzxDxUID5gzfvinfcgW0ko7ik3lln8=; b=GEMHS/USCzB14ZEJ4dE1ihPswr
        sqIhALd+xoeXPiSDsghHKisxV8XrLDTf8lFXrjPJUao0ayE2ulzMXTjh2pgjLQ/YiH5xknP6Wuh87
        zJddKFt9BfGJdsuyBqLPsep+9gMN6s6PB95xbTGD4duoBM11C7PQW43MSQWn00wjbSN5I3g/gJtYJ
        EF+YfnQ8OI31b6ZVrkJuFffAtikqByGIfXnC2ILGVPAstHrXOKkGSg+3tRlmYsws8ETdMU06+j+G6
        e5ETd25tBHvyvZMpG6VPaN8s3d4kd5exdmLYyueS5SZ/ovkGIVQS9L1R1sOLSd9cjeoZh68URsQyP
        uHdp4Ofw==;
Received: from [89.212.21.243] (port=58494 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <andrej.picej@norik.com>)
        id 1q7BZf-00CHxg-0m;
        Thu, 08 Jun 2023 11:04:54 +0200
From:   Andrej Picej <andrej.picej@norik.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@phytec.de
Subject: [PATCH] rtc: rv3028: Improve trickle charger logic
Date:   Thu,  8 Jun 2023 11:04:46 +0200
Message-Id: <20230608090446.2899646-1-andrej.picej@norik.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Property "trickle-resistor-ohms" allows us to set trickle charger
resistor. However there is no possibility to disable it afterwards.

From now on, disable trickle charger circuit in case device-tree
property "trickle-resistor-ohms" is not present. RV3029 RTC driver uses
the same trickle charger disable logic.

Additionally, lets make sure we only update internal EEPROM in case of a
change. This prevents wear due to excessive EEPROM writes on each probe.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 drivers/rtc/rtc-rv3028.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index ec5d7a614e2d..190507bf97d0 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -860,6 +860,7 @@ static int rv3028_probe(struct i2c_client *client)
 	struct rv3028_data *rv3028;
 	int ret, status;
 	u32 ohms;
+	int val_old, val;
 	struct nvmem_config nvmem_cfg = {
 		.name = "rv3028_nvram",
 		.word_size = 1,
@@ -937,9 +938,18 @@ static int rv3028_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
+	if (ret < 0)
+		return ret;
+
+	/* mask out only trickle charger bits */
+	val_old = val_old & (RV3028_BACKUP_TCE | RV3028_BACKUP_TCR_MASK);
+
 	/* setup trickle charger */
-	if (!device_property_read_u32(&client->dev, "trickle-resistor-ohms",
-				      &ohms)) {
+	if (device_property_read_u32(&client->dev, "trickle-resistor-ohms", &ohms)) {
+		/* disable the trickle charger */
+		val = 0;
+	} else {
 		int i;
 
 		for (i = 0; i < ARRAY_SIZE(rv3028_trickle_resistors); i++)
@@ -947,15 +957,21 @@ static int rv3028_probe(struct i2c_client *client)
 				break;
 
 		if (i < ARRAY_SIZE(rv3028_trickle_resistors)) {
-			ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
-						 RV3028_BACKUP_TCR_MASK, RV3028_BACKUP_TCE | i);
-			if (ret)
-				return ret;
+			/* enable the trickle charger and setup its resistor accordingly */
+			val = RV3028_BACKUP_TCE | i;
 		} else {
 			dev_warn(&client->dev, "invalid trickle resistor value\n");
 		}
 	}
 
+	/* only update EEPROM if changes are necessary */
+	if (val_old != val) {
+		ret = rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_TCE |
+					RV3028_BACKUP_TCR_MASK, val);
+		if (ret)
+			return ret;
+	}
+
 	ret = rtc_add_group(rv3028->rtc, &rv3028_attr_group);
 	if (ret)
 		return ret;
-- 
2.25.1

