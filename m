Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB9712958
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjEZPYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbjEZPXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:23:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A47187;
        Fri, 26 May 2023 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685114614; x=1716650614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6Lj4cCQO0hpQQIuUyCo7QR5SV7U6uxhVeQqcFsGgVo=;
  b=Q7AcLrFUPkQUqbcYL2aakinWjF3r+1KtaY9NP6aEQdKc3yKB1AvDmG2B
   VGSV5G0vCI7plDqkeCVrzlD5iQuLmI8QQ1L6WxRCz9BS9AwMIDBNKSypY
   dZIxgAIqxHKIZ3ZvOM4LA4t0zNBddqLoPrzACmW52Ms1x1Yu0iwSby03Z
   9t3ADmobIURae/jeHLsIz7giFb7CRhjL2jdzlLunhxO07Nt8H7y8LhnFQ
   GE4YFLTH8NyY4egK7lvMNt3FiU1ti/vBBouRFKnQeLAEnta2QaKBguK1z
   PMzP/Zqk3jJTVchNrGeNGn0DfbGlkrTWjQWpl1vFk/0mGxiVgmTBfPwLo
   w==;
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="scan'208";a="217486036"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 08:23:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 08:22:52 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 26 May 2023 08:22:47 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <ramon.nordin.rodriguez@ferroamp.se>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        "Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v4 2/6] net: phy: microchip_t1s: replace read-modify-write code with phy_modify_mmd
Date:   Fri, 26 May 2023 20:53:44 +0530
Message-ID: <20230526152348.70781-3-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
References: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace read-modify-write code in the lan867x_config_init function to
avoid handling data type mismatch and to simplify the code.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 41 +++++++++++----------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index a42a6bb6e3bd..fd27e94c9ee5 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -31,19 +31,19 @@
  * W   0x1F 0x0099 0x7F80 ------
  */
 
-static const int lan867x_fixup_registers[12] = {
+static const u32 lan867x_fixup_registers[12] = {
 	0x00D0, 0x00D1, 0x0084, 0x0085,
 	0x008A, 0x0087, 0x0088, 0x008B,
 	0x0080, 0x00F1, 0x0096, 0x0099,
 };
 
-static const int lan867x_fixup_values[12] = {
+static const u16 lan867x_fixup_values[12] = {
 	0x0002, 0x0000, 0x3380, 0x0006,
 	0xC000, 0x801C, 0x033F, 0x0404,
 	0x0600, 0x2400, 0x2000, 0x7F80,
 };
 
-static const int lan867x_fixup_masks[12] = {
+static const u16 lan867x_fixup_masks[12] = {
 	0x0E03, 0x0300, 0xFFC0, 0x000F,
 	0xF800, 0x801C, 0x1FFF, 0xFFFF,
 	0x0600, 0x7F00, 0x2000, 0xFFFF,
@@ -51,35 +51,20 @@ static const int lan867x_fixup_masks[12] = {
 
 static int lan867x_config_init(struct phy_device *phydev)
 {
-	/* HW quirk: Microchip states in the application note (AN1699) for the phy
-	 * that a set of read-modify-write (rmw) operations has to be performed
-	 * on a set of seemingly magic registers.
-	 * The result of these operations is just described as 'optimal performance'
-	 * Microchip gives no explanation as to what these mmd regs do,
-	 * in fact they are marked as reserved in the datasheet.
-	 * It is unclear if phy_modify_mmd would be safe to use or if a write
-	 * really has to happen to each register.
-	 * In order to exactly conform to what is stated in the AN phy_write_mmd is
-	 * used, which might then write the same value back as read + modified.
-	 */
-
-	int reg_value;
 	int err;
-	int reg;
 
-	/* Read-Modified Write Pseudocode (from AN1699)
-	 * current_val = read_register(mmd, addr) // Read current register value
-	 * new_val = current_val AND (NOT mask) // Clear bit fields to be written
-	 * new_val = new_val OR value // Set bits
-	 * write_register(mmd, addr, new_val) // Write back updated register value
+	/* Reference to AN1699
+	 * https://ww1.microchip.com/downloads/aemDocuments/documents/AIS/ProductDocuments/SupportingCollateral/AN-LAN8670-1-2-config-60001699.pdf
+	 * AN1699 says Read, Modify, Write, but the Write is not required if the
+	 * register already has the required value. So it is safe to use
+	 * phy_modify_mmd here.
 	 */
 	for (int i = 0; i < ARRAY_SIZE(lan867x_fixup_registers); i++) {
-		reg = lan867x_fixup_registers[i];
-		reg_value = phy_read_mmd(phydev, MDIO_MMD_VEND2, reg);
-		reg_value &= ~lan867x_fixup_masks[i];
-		reg_value |= lan867x_fixup_values[i];
-		err = phy_write_mmd(phydev, MDIO_MMD_VEND2, reg, reg_value);
-		if (err != 0)
+		err = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				     lan867x_fixup_registers[i],
+				     lan867x_fixup_masks[i],
+				     lan867x_fixup_values[i]);
+		if (err)
 			return err;
 	}
 
-- 
2.34.1

