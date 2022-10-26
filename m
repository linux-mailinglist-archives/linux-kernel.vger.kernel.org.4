Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694C60E0E3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbiJZMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbiJZMjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:39:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D04EA35E;
        Wed, 26 Oct 2022 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666787946; x=1698323946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Et6DbHOQfQvVXSeGo8MZr/RFIzGdENddbRTKj1v4eH8=;
  b=Ar3elSDmPFxk39ylX2jaPFQP68VSG49j1ko+bBSL/dBBwpdBxQD6i5yU
   99wvOlh1wBqWd993FlFWu/v8tEGlXHq0KZk328846OYBO7AWcHX2WpK1T
   tZQS2HmZeIY93AwdNsL+oPQDE6DqWZG4JaLsP8CXAAfP3WFVyYpmzSqj8
   b/6cnB72YotUIxzPzoxjdLRJ7v+s+ViBq8JNfQztk53m0rAMZCLS72Lxy
   yDHH7tnT/jgpOf1hAwb6wEjWftfMh+3Wk0+DLNOFUyE3m7rAeLGPEmj2D
   /7l6oJSe6vkxWaHVYNfdEeYiP+x7mZqREv04H2GxP98sF1TTLVGsbLX4w
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="186355796"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Oct 2022 05:39:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 26 Oct 2022 05:39:05 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 26 Oct 2022 05:39:03 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux@armlinux.org.uk>, <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 01/11] ARM: at91: pm: avoid soft resetting AC DLL
Date:   Wed, 26 Oct 2022 15:41:04 +0300
Message-ID: <20221026124114.985876-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221026124114.985876-1-claudiu.beznea@microchip.com>
References: <20221026124114.985876-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not soft reset AC DLL as controller is buggy and this operation my
introduce glitches in the controller leading to undefined behavior.

Fixes: f0bbf17958e8 ("ARM: at91: pm: add self-refresh support for sama7g5")
Depends-on: a02875c4cbd6 ("ARM: at91: pm: fix self-refresh for sama7g5")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 7 ++++++-
 include/soc/at91/sama7-ddr.h    | 5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index ffed4d949042..e4904faf1753 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -169,10 +169,15 @@ sr_ena_2:
 	cmp	tmp1, #UDDRC_STAT_SELFREF_TYPE_SW
 	bne	sr_ena_2
 
-	/* Put DDR PHY's DLL in bypass mode for non-backup modes. */
+	/* Disable DX DLLs for non-backup modes. */
 	cmp	r7, #AT91_PM_BACKUP
 	beq	sr_ena_3
 
+	/* Do not soft reset the AC DLL. */
+	ldr	tmp1, [r3, DDR3PHY_ACDLLCR]
+	bic	tmp1, tmp1, DDR3PHY_ACDLLCR_DLLSRST
+	str	tmp1, [r3, DDR3PHY_ACDLLCR]
+
 	/* Disable DX DLLs. */
 	ldr	tmp1, [r3, #DDR3PHY_DX0DLLCR]
 	orr	tmp1, tmp1, #DDR3PHY_DXDLLCR_DLLDIS
diff --git a/include/soc/at91/sama7-ddr.h b/include/soc/at91/sama7-ddr.h
index 6ce3bd22f6c6..5ad7ac2e3a7c 100644
--- a/include/soc/at91/sama7-ddr.h
+++ b/include/soc/at91/sama7-ddr.h
@@ -26,7 +26,10 @@
 #define	DDR3PHY_PGSR				(0x0C)		/* DDR3PHY PHY General Status Register */
 #define		DDR3PHY_PGSR_IDONE		(1 << 0)	/* Initialization Done */
 
-#define DDR3PHY_ACIOCR				(0x24)		/*  DDR3PHY AC I/O Configuration Register */
+#define	DDR3PHY_ACDLLCR				(0x14)		/* DDR3PHY AC DLL Control Register */
+#define		DDR3PHY_ACDLLCR_DLLSRST		(1 << 30)	/* DLL Soft Reset */
+
+#define DDR3PHY_ACIOCR				(0x24)		/* DDR3PHY AC I/O Configuration Register */
 #define		DDR3PHY_ACIOCR_CSPDD_CS0	(1 << 18)	/* CS#[0] Power Down Driver */
 #define		DDR3PHY_ACIOCR_CKPDD_CK0	(1 << 8)	/* CK[0] Power Down Driver */
 #define		DDR3PHY_ACIORC_ACPDD		(1 << 3)	/* AC Power Down Driver */
-- 
2.34.1

