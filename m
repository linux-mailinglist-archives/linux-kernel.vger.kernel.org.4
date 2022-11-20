Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C594D6316C0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 23:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKTWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 17:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKTWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 17:12:24 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAF626552;
        Sun, 20 Nov 2022 14:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/bcYYEBupthiwQFde2svNyfveIgcGiNItZQIVI9J6Ss=; b=Bg5jbkqHupRZJTsHapmaeOsvZu
        LI4K4Y8mGOaSMFKqz5evy0COP2ho8d+q8mprBht9AgcaCGFKGllwhdifTJwEjEwhK/Nt+/sN1wbGN
        ukDZ821qV4C40N3IEbjBWAmiAnfEhQ9PYWLwITdcAUPFcUVYHbQTJY+c4VyZrHNUKbl6fktJv7DXs
        b71/72DRPJywmI4p//ikfup3Hxj6D5Fqn7oDhTFqAMAoSbotFcDNYKyx99RBlrPQlXl7DEqZmUhI2
        0JU3HqPd5Cs0mThu8P1skZ5/WDMkYnPdNIh45ki/alZXXCux9+znFmKRHIPZaRSSMDuvOOQYtJt/f
        j7Ruz+fA==;
Received: from p200300ccff43b2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff43:b200:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1owsXw-00069B-6U; Sun, 20 Nov 2022 23:12:16 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1owsXv-00Cypm-CX; Sun, 20 Nov 2022 23:12:15 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lgirdwood@gmail.com, broonie@kernel.org,
        Nicolae_Rosia@mentor.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] regulator: twl6030: fix get status of twl6032 regulators
Date:   Sun, 20 Nov 2022 23:12:08 +0100
Message-Id: <20221120221208.3093727-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120221208.3093727-1-andreas@kemnade.info>
References: <20221120221208.3093727-1-andreas@kemnade.info>
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

Status is reported as always off in the 6032 case. Status
reporting now matches the logic in the setters. Once of
the differences to the 6030 is that there are no groups,
therefore the state needs to be read out in the lower bits.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/regulator/twl6030-regulator.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 7c7e3648ea4b..f3856750944f 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -67,6 +67,7 @@ struct twlreg_info {
 #define TWL6030_CFG_STATE_SLEEP	0x03
 #define TWL6030_CFG_STATE_GRP_SHIFT	5
 #define TWL6030_CFG_STATE_APP_SHIFT	2
+#define TWL6030_CFG_STATE_MASK		0x03
 #define TWL6030_CFG_STATE_APP_MASK	(0x03 << TWL6030_CFG_STATE_APP_SHIFT)
 #define TWL6030_CFG_STATE_APP(v)	(((v) & TWL6030_CFG_STATE_APP_MASK) >>\
 						TWL6030_CFG_STATE_APP_SHIFT)
@@ -128,13 +129,14 @@ static int twl6030reg_is_enabled(struct regulator_dev *rdev)
 		if (grp < 0)
 			return grp;
 		grp &= P1_GRP_6030;
+		val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+		val = TWL6030_CFG_STATE_APP(val);
 	} else {
+		val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
+		val &= TWL6030_CFG_STATE_MASK;
 		grp = 1;
 	}
 
-	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
-	val = TWL6030_CFG_STATE_APP(val);
-
 	return grp && (val == TWL6030_CFG_STATE_ON);
 }
 
@@ -187,7 +189,12 @@ static int twl6030reg_get_status(struct regulator_dev *rdev)
 
 	val = twlreg_read(info, TWL_MODULE_PM_RECEIVER, VREG_STATE);
 
-	switch (TWL6030_CFG_STATE_APP(val)) {
+	if (info->features & TWL6032_SUBCLASS)
+		val &= TWL6030_CFG_STATE_MASK;
+	else
+		val = TWL6030_CFG_STATE_APP(val);
+
+	switch (val) {
 	case TWL6030_CFG_STATE_ON:
 		return REGULATOR_STATUS_NORMAL;
 
-- 
2.30.2

