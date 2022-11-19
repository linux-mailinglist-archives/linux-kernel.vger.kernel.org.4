Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E2630DFC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 11:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiKSKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 05:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiKSKEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 05:04:11 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5832193DE;
        Sat, 19 Nov 2022 02:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RMNXYrumhI3yLofiZI7k3r2DEJ+lXONtPLs3WFv5g+o=; b=5SsmuCcG6tK82cWqUfyg9d5Eck
        KksnUD/SWupHQBxwWvOf/0nvvNjb6cxknUFGI+j80Y9R+kKA/6TKtoWvbPIjZozzgbKWomxQtfNYz
        Y7uImLQblBjsKTvabMuZOzRF6QZXYiD9m1tWIClhx0oG+Dre6nBQGhQ6IaVRacUi7WtYThIiwmPW2
        zt1GSi5mnynxPaPOPRzphluF4GIu9yPBGCqOTV4QlYwvIppsaJXq/pRX/mr0vBIQGJcB4WBJ4c6ub
        dN+1SjblSLACfPUtXxXovJu1FyAVtaUAK2wtbvtEB3YZDBxfxxVNKOzPAXUjehDaF/wHtF5TT4izx
        4xs+cLfA==;
Received: from p200300ccff2ff3001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2f:f300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1owKhf-0000Nr-Oi; Sat, 19 Nov 2022 11:04:04 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1owKhe-00CIPK-Qp; Sat, 19 Nov 2022 11:04:02 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lee@kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>, Bin Liu <b-liu@ti.com>
Subject: [PATCH] mfd: twl: fix TWL6032 phy vbus detection
Date:   Sat, 19 Nov 2022 11:03:41 +0100
Message-Id: <20221119100341.2930647-1-andreas@kemnade.info>
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
 drivers/mfd/twl-core.c  | 8 ++++----
 include/linux/mfd/twl.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index f6b4b9d94bbd..5a7ed71d0e30 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -111,6 +111,7 @@
 #define TWL6030_BASEADD_GASGAUGE	0x00C0
 #define TWL6030_BASEADD_PIH		0x00D0
 #define TWL6030_BASEADD_CHARGER		0x00E0
+/* A few regs prepended before the 6030 regs */
 #define TWL6032_BASEADD_CHARGER		0x00DA
 #define TWL6030_BASEADD_LED		0x00F4
 
@@ -353,6 +354,9 @@ static struct twl_mapping twl6030_map[] = {
 	{ 2, TWL6030_BASEADD_ZERO },
 	{ 1, TWL6030_BASEADD_GPADC_CTRL },
 	{ 1, TWL6030_BASEADD_GASGAUGE },
+
+	/* TWL6032 specific charger registers */
+	{ 1, TWL6032_BASEADD_CHARGER },
 };
 
 static const struct regmap_config twl6030_regmap_config[3] = {
@@ -802,10 +806,6 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
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

