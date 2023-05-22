Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40F770BBE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbjEVLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjEVLdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:33:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C469011A;
        Mon, 22 May 2023 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684755174; x=1716291174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cMNKUVrbwwm3gcDpaWnJnkp3baZQOOY4BVDOj1Otex4=;
  b=2htP3ycJvW8uCL3p19RLT0u6fHLmiE97yMtxyNOUWmL4NaMIWa6a5BfI
   AOnjmYiAqJfT25xiuharLc9ks29OtYQY6Fm4SgC1c4TsF1hs3wy4ClthF
   7+FUO0u+EQQehsAacxAIik+q14OG+LXlet1KvMtjDQiF7VNeHTETu6YHr
   NX0H01nv1w7tpwclW7InFcEez681BWzafeZZjlA3S3qZsE9ZIFVkRoXjA
   21TnU++GmuPB5EdDWRLR4fPRCxF+rvZHy9Akgt8/SUT3Rm9dSrFxzOYw8
   5zR6lXHEtByT36jrC5oMbC44BuBbXmoAVaJ/YUjjOwnZSno4C/YrtgiRd
   w==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="226384790"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 04:32:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 04:32:53 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 04:32:49 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <ramon.nordin.rodriguez@ferroamp.se>
CC:     <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        "Parthiban Veerasooran" <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2 5/6] net: phy: microchip_t1s: remove unnecessary interrupts disabling code
Date:   Mon, 22 May 2023 17:03:30 +0530
Message-ID: <20230522113331.36872-6-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
References: <20230522113331.36872-1-Parthiban.Veerasooran@microchip.com>
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

By default, except Reset Complete interrupt in the Interrupt Mask 2
Register all other interrupts are disabled/masked. As Reset Complete
status is already handled, it doesn't make sense to disable it.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 2f22a1954c09..a612f7867df8 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -12,8 +12,6 @@
 
 #define PHY_ID_LAN867X_REVB1 0x0007C162
 
-#define LAN867X_REG_IRQ_1_CTL 0x001C
-#define LAN867X_REG_IRQ_2_CTL 0x001D
 #define LAN867X_REG_STS2 0x0019
 
 #define LAN867x_RESET_COMPLETE_STS BIT(11)
@@ -104,17 +102,7 @@ static int lan867x_revb1_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	/* None of the interrupts in the lan867x phy seem relevant.
-	 * Other phys inspect the link status and call phy_trigger_machine
-	 * in the interrupt handler.
-	 * This phy does not support link status, and thus has no interrupt
-	 * for it either.
-	 * So we'll just disable all interrupts on the chip.
-	 */
-	err = phy_write_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_IRQ_1_CTL, 0xFFFF);
-	if (err != 0)
-		return err;
-	return phy_write_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_IRQ_2_CTL, 0xFFFF);
+	return 0;
 }
 
 static int lan867x_read_status(struct phy_device *phydev)
-- 
2.34.1

