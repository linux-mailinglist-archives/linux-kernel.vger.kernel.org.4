Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533EB70F8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234995AbjEXOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEXOo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:44:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40100194;
        Wed, 24 May 2023 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684939495; x=1716475495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CP5atzyDeT3lvfQYbricTCjhs9mi8Czt0hAXYPTLMKY=;
  b=zpZ0vP04zqLLjOf4UU3UBkt4Qfq8fmSpQPooB5M4xunoPJahS7AYVkIu
   crmgtggLRbnnJQI936tH4NSMhmqm9qTMJ98oXvEUt1alOT1ulqxDFLN9D
   3v7d3PKvMo6DyOMAxQxv7cGosX2BcqDaJB5+opbnsXiiK6V6zpotnpCNH
   wLjiCnsW8Sj+w5jcQEYlUtkkV0eJuyayJ54940ySwLHGOCnT7K4ANdYp/
   g6rp5eFgtzTszUpMjuOrc2RtYPH6K7b6zYCEudlNK/CledLcUatvOy915
   M8nFzKrIftqnMkRwmFPc0uMKcMIhB20xeMw4Y9uyTH81uF9fJwruKvr4l
   w==;
X-IronPort-AV: E=Sophos;i="6.00,189,1681196400"; 
   d="scan'208";a="212864734"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 07:44:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 07:44:53 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 24 May 2023 07:44:49 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <ramon.nordin.rodriguez@ferroamp.se>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        "Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v3 4/6] net: phy: microchip_t1s: fix reset complete status handling
Date:   Wed, 24 May 2023 20:15:37 +0530
Message-ID: <20230524144539.62618-5-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the datasheet DS-LAN8670-1-2-60001573C.pdf, the Reset Complete
status bit in the STS2 register has to be checked before proceeding to
the initial configuration. Reading STS2 register will also clear the
Reset Complete interrupt which is non-maskable.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 8f29d9802131..05a88b561993 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -14,6 +14,9 @@
 
 #define LAN867X_REG_IRQ_1_CTL 0x001C
 #define LAN867X_REG_IRQ_2_CTL 0x001D
+#define LAN867X_REG_STS2 0x0019
+
+#define LAN867x_RESET_COMPLETE_STS BIT(11)
 
 /* The arrays below are pulled from the following table from AN1699
  * Access MMD Address Value Mask
@@ -65,6 +68,27 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 
 	int err;
 
+	/* Read STS2 register and check for the Reset Complete status to do the
+	 * init configuration. If the Reset Complete is not set, wait for 5us
+	 * and then read STS2 register again and check for Reset Complete status.
+	 * Still if it is failed then declare PHY reset error or else proceed
+	 * for the PHY initial register configuration.
+	 */
+	err = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_STS2);
+	if (err < 0)
+		return err;
+
+	if (!(err & LAN867x_RESET_COMPLETE_STS)) {
+		udelay(5);
+		err = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_STS2);
+		if (err < 0)
+			return err;
+		if (!(err & LAN867x_RESET_COMPLETE_STS)) {
+			phydev_err(phydev, "PHY reset failed\n");
+			return -ENODEV;
+		}
+	}
+
 	/* Read-Modified Write Pseudocode (from AN1699)
 	 * current_val = read_register(mmd, addr) // Read current register value
 	 * new_val = current_val AND (NOT mask) // Clear bit fields to be written
-- 
2.34.1

