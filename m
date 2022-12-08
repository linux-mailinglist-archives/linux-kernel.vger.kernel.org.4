Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1139647862
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLHV63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLHV6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:58:06 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7615214D;
        Thu,  8 Dec 2022 13:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7mVkAmDWoHLTK1bm8c0nwGU18XHm9AdQyd1P1ZMmedo=; b=7svQe4mVPjR86ZvGGgn9pXOeQK
        DH1tngBx2A1YPHnkGOISZ0LIYOvMw4FykoAVxwbHjJpUS84/5c0aBQMC9Gq1f+4yPxtTlr081VdsO
        tIfF81ifLri8eBItymduq9Aq3+SjItMQ5IaBMTpChyiQqYV/r5jzTKTMw3Unxp14P+pmOVcuGEpUk
        wXbxJ6kp83+NfMwwyv34JJzjvlmXeFVFXXZvo8edek9c3+vU8sFEU+S0dAQ8r1Lp9I13f538up90r
        F2Y4imWys0684v5fKI4HtL5hWJMFxwBe65/Als3DUhLm4Zuk0VUxFM7LL7S3e+0oTADCsL/DRxpzE
        7PftGs+w==;
Received: from p200300ccff13ea001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff13:ea00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1p3Otg-0003FV-2b; Thu, 08 Dec 2022 22:57:44 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1p3Ota-000ubq-DI; Thu, 08 Dec 2022 22:57:34 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lee@kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>
Subject: [PATCH v2] mfd: twl: fix TWL6032 phy vbus detection
Date:   Thu,  8 Dec 2022 22:57:23 +0100
Message-Id: <20221208215723.217557-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWL6032 has a few charging registers prepended before the charging
registers the TWL6030 has. To be able to use common register defines
declare the additional registers as additional module.
At the moment this affects the access to CHARGERUSB_CTRL1 in
phy-twl6030-usb.  Without this patch, it is accessing the wrong register
on TWL6032.
The consequence is that presence of Vbus is not reported.

Cc: Bin Liu <b-liu@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 - remove comment
 drivers/mfd/twl-core.c  | 9 ++++-----
 include/linux/mfd/twl.h | 2 ++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f6b4b9d94bbd..240e63949e10 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -110,8 +110,8 @@
 #define TWL6030_BASEADD_PWM		0x00BA
 #define TWL6030_BASEADD_GASGAUGE	0x00C0
 #define TWL6030_BASEADD_PIH		0x00D0
-#define TWL6030_BASEADD_CHARGER		0x00E0
 #define TWL6032_BASEADD_CHARGER		0x00DA
+#define TWL6030_BASEADD_CHARGER		0x00E0
 #define TWL6030_BASEADD_LED		0x00F4
 
 /* subchip/slave 2 0x4A - DFT */
@@ -353,6 +353,9 @@ static struct twl_mapping twl6030_map[] = {
 	{ 2, TWL6030_BASEADD_ZERO },
 	{ 1, TWL6030_BASEADD_GPADC_CTRL },
 	{ 1, TWL6030_BASEADD_GASGAUGE },
+
+	/* TWL6032 specific charger registers */
+	{ 1, TWL6032_BASEADD_CHARGER },
 };
 
 static const struct regmap_config twl6030_regmap_config[3] = {
@@ -802,10 +805,6 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if ((id->driver_data) & TWL6030_CLASS) {
 		twl_priv->twl_id = TWL6030_CLASS_ID;
 		twl_priv->twl_map = &twl6030_map[0];
-		/* The charger base address is different in twl6032 */
-		if ((id->driver_data) & TWL6032_SUBCLASS)
-			twl_priv->twl_map[TWL_MODULE_MAIN_CHARGE].base =
-							TWL6032_BASEADD_CHARGER;
 		twl_regmap_config = twl6030_regmap_config;
 	} else {
 		twl_priv->twl_id = TWL4030_CLASS_ID;
diff --git a/include/linux/mfd/twl.h b/include/linux/mfd/twl.h
index eaa233038254..6e3d99b7a0ee 100644
--- a/include/linux/mfd/twl.h
+++ b/include/linux/mfd/twl.h
@@ -69,6 +69,8 @@ enum twl6030_module_ids {
 	TWL6030_MODULE_GPADC,
 	TWL6030_MODULE_GASGAUGE,
 
+	/* A few extra registers before the registers shared with the 6030 */
+	TWL6032_MODULE_CHARGE,
 	TWL6030_MODULE_LAST,
 };
 
-- 
2.30.2

