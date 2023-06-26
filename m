Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB273E808
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjFZSVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjFZSUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:20:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8C8E7F;
        Mon, 26 Jun 2023 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687803635; x=1719339635;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ocIkXRYDE2Ci9W3TOmiMIPb9bxSCddVwIw/OcWkYvkM=;
  b=gQdWyrYfTJgd0MMbTwNQMnkeX3Vw0n95VtoeBFh34CAcy6A49mwfvO68
   RmZQml+RdDN635ajTfvKtzIBy68txAbRVzq3GAc8NeNy0S7C0B3q5/ezd
   3D+E6xFBc6rwv7A+CLig+X/oKzN3+roGfHFxYpn7q4C3YpnAdsua7LZ+U
   X2s8z/VEu0TH2iVVc8/p+3luW7sgtQLPFMyaWOvm2owuGzb9SBMANByYX
   Zmw+ryi/Ezqgj/EOOByv+vj5OwaqC9ozyCVOTt6yD9rJKPTwSBkjtkpbg
   7fedAtyhxmZOZ+nI6f4hS73UF2PON7K6rt22FGMN+scJaoH2f2XId0GJX
   A==;
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="220598045"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 11:20:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 11:20:32 -0700
Received: from chn-vm-ungsw-01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 26 Jun 2023 11:20:32 -0700
From:   Jerry Ray <jerry.ray@microchip.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] net: dsa: microchip: phy reg access 0x10-0x1f
Date:   Mon, 26 Jun 2023 11:20:32 -0700
Message-ID: <20230626182032.2079497-1-jerry.ray@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent patch to promote phy register accesses to 32-bits for the
range >=0x10, it is also necessary to expand the allowed register address
table for the affected devices.  These three register sets use
ksz9477_dev_ops and are therefore affected by the change. The address
ranges 0xN120-0xN13f map to the phy register address 0x10-0x1f. There is
no reason to exclude any register accesses within this space.

on June 20, 2023
commit 5c844d57aa78    ("net: dsa: microchip: fix writes to phy registers >= 0x10")

Signed-off-by: Jerry Ray <jerry.ray@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 65 ++++++--------------------
 1 file changed, 13 insertions(+), 52 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 813b91a816bb..b7ce48147a38 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -509,10 +509,7 @@ static const struct regmap_range ksz8563_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1111),
 	regmap_reg_range(0x111a, 0x111d),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -539,10 +536,7 @@ static const struct regmap_range ksz8563_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2111),
 	regmap_reg_range(0x211a, 0x211d),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
@@ -635,10 +629,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1115),
 	regmap_reg_range(0x111a, 0x111f),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -669,10 +660,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2115),
 	regmap_reg_range(0x211a, 0x211f),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
@@ -703,10 +691,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x3030, 0x3030),
 	regmap_reg_range(0x3100, 0x3115),
 	regmap_reg_range(0x311a, 0x311f),
-	regmap_reg_range(0x3122, 0x3127),
-	regmap_reg_range(0x312a, 0x312b),
-	regmap_reg_range(0x3136, 0x3139),
-	regmap_reg_range(0x313e, 0x313f),
+	regmap_reg_range(0x3120, 0x313f),
 	regmap_reg_range(0x3400, 0x3401),
 	regmap_reg_range(0x3403, 0x3403),
 	regmap_reg_range(0x3410, 0x3417),
@@ -737,10 +722,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x4030, 0x4030),
 	regmap_reg_range(0x4100, 0x4115),
 	regmap_reg_range(0x411a, 0x411f),
-	regmap_reg_range(0x4122, 0x4127),
-	regmap_reg_range(0x412a, 0x412b),
-	regmap_reg_range(0x4136, 0x4139),
-	regmap_reg_range(0x413e, 0x413f),
+	regmap_reg_range(0x4120, 0x413f),
 	regmap_reg_range(0x4400, 0x4401),
 	regmap_reg_range(0x4403, 0x4403),
 	regmap_reg_range(0x4410, 0x4417),
@@ -771,10 +753,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x5030, 0x5030),
 	regmap_reg_range(0x5100, 0x5115),
 	regmap_reg_range(0x511a, 0x511f),
-	regmap_reg_range(0x5122, 0x5127),
-	regmap_reg_range(0x512a, 0x512b),
-	regmap_reg_range(0x5136, 0x5139),
-	regmap_reg_range(0x513e, 0x513f),
+	regmap_reg_range(0x5120, 0x513f),
 	regmap_reg_range(0x5400, 0x5401),
 	regmap_reg_range(0x5403, 0x5403),
 	regmap_reg_range(0x5410, 0x5417),
@@ -897,10 +876,7 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x1030, 0x1030),
 	regmap_reg_range(0x1100, 0x1115),
 	regmap_reg_range(0x111a, 0x111f),
-	regmap_reg_range(0x1122, 0x1127),
-	regmap_reg_range(0x112a, 0x112b),
-	regmap_reg_range(0x1136, 0x1139),
-	regmap_reg_range(0x113e, 0x113f),
+	regmap_reg_range(0x1120, 0x113f),
 	regmap_reg_range(0x1400, 0x1401),
 	regmap_reg_range(0x1403, 0x1403),
 	regmap_reg_range(0x1410, 0x1417),
@@ -927,10 +903,7 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x2030, 0x2030),
 	regmap_reg_range(0x2100, 0x2115),
 	regmap_reg_range(0x211a, 0x211f),
-	regmap_reg_range(0x2122, 0x2127),
-	regmap_reg_range(0x212a, 0x212b),
-	regmap_reg_range(0x2136, 0x2139),
-	regmap_reg_range(0x213e, 0x213f),
+	regmap_reg_range(0x2120, 0x213f),
 	regmap_reg_range(0x2400, 0x2401),
 	regmap_reg_range(0x2403, 0x2403),
 	regmap_reg_range(0x2410, 0x2417),
@@ -957,10 +930,7 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x3030, 0x3030),
 	regmap_reg_range(0x3100, 0x3115),
 	regmap_reg_range(0x311a, 0x311f),
-	regmap_reg_range(0x3122, 0x3127),
-	regmap_reg_range(0x312a, 0x312b),
-	regmap_reg_range(0x3136, 0x3139),
-	regmap_reg_range(0x313e, 0x313f),
+	regmap_reg_range(0x3120, 0x313f),
 	regmap_reg_range(0x3400, 0x3401),
 	regmap_reg_range(0x3403, 0x3403),
 	regmap_reg_range(0x3410, 0x3417),
@@ -987,10 +957,7 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x4030, 0x4030),
 	regmap_reg_range(0x4100, 0x4115),
 	regmap_reg_range(0x411a, 0x411f),
-	regmap_reg_range(0x4122, 0x4127),
-	regmap_reg_range(0x412a, 0x412b),
-	regmap_reg_range(0x4136, 0x4139),
-	regmap_reg_range(0x413e, 0x413f),
+	regmap_reg_range(0x4120, 0x413f),
 	regmap_reg_range(0x4400, 0x4401),
 	regmap_reg_range(0x4403, 0x4403),
 	regmap_reg_range(0x4410, 0x4417),
@@ -1017,10 +984,7 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x5030, 0x5030),
 	regmap_reg_range(0x5100, 0x5115),
 	regmap_reg_range(0x511a, 0x511f),
-	regmap_reg_range(0x5122, 0x5127),
-	regmap_reg_range(0x512a, 0x512b),
-	regmap_reg_range(0x5136, 0x5139),
-	regmap_reg_range(0x513e, 0x513f),
+	regmap_reg_range(0x5120, 0x513f),
 	regmap_reg_range(0x5400, 0x5401),
 	regmap_reg_range(0x5403, 0x5403),
 	regmap_reg_range(0x5410, 0x5417),
@@ -1047,10 +1011,7 @@ static const struct regmap_range ksz9896_valid_regs[] = {
 	regmap_reg_range(0x6030, 0x6030),
 	regmap_reg_range(0x6100, 0x6115),
 	regmap_reg_range(0x611a, 0x611f),
-	regmap_reg_range(0x6122, 0x6127),
-	regmap_reg_range(0x612a, 0x612b),
-	regmap_reg_range(0x6136, 0x6139),
-	regmap_reg_range(0x613e, 0x613f),
+	regmap_reg_range(0x6120, 0x613f),
 	regmap_reg_range(0x6300, 0x6301),
 	regmap_reg_range(0x6400, 0x6401),
 	regmap_reg_range(0x6403, 0x6403),
-- 
2.25.1

