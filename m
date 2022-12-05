Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44814642349
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiLEHBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiLEHB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:01:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88296A466
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670223685; x=1701759685;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lukaDYMLzzU8O7+ynR8srq7QmQB19CkmS/LulZdvcl8=;
  b=TjfdJohRhf2fTM32g/hSuM5u23iPZ+xDZDW82WTRXbal2jKC++NQk+L3
   ygR11XZeYmur7pbAMa5NGkV1AyXPX8zm4Q0P8gFHmLP4oKBJO0DdGhfxu
   bBmUOd+EtqF4feVJCmZ38tM93YLU8xabtLNQknGCwDNVC1I54jWkvaCtO
   enaw/4Aw5T7yOMcscDWNU+F1A+Meke+ElHXc8zw95aVhj53DTWJz1u8jH
   0kQs6SyDeAIWzkqTG41auSxAypjWRXto0WGPtsousIVbzUPqLzf7FoHD3
   p3680iYmb6Cv4m8NXpKHrp9nhBvkQO8gzVw8O8YtFJuEIBSiqplNhRSB1
   A==;
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="191694346"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Dec 2022 00:01:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Dec 2022 00:01:23 -0700
Received: from virtualbox.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 5 Dec 2022 00:01:21 -0700
From:   Mihai Sain <mihai.sain@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] ARM: at91: add support in soc driver for new SAMA7G54 SiPs
Date:   Mon, 5 Dec 2022 09:01:08 +0200
Message-ID: <20221205070108.42624-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add detection of new SAMA7G54 System-In-Package (SIP) by the SoC driver:
SAMA7G54D1G, SAMA7G54D2G, SAMA7G54D4G.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 drivers/soc/atmel/soc.c | 9 +++++++++
 drivers/soc/atmel/soc.h | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index dae8a2e0f745..cc9a3e107479 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -235,6 +235,15 @@ static const struct at91_soc socs[] __initconst = {
 	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
 		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G54_EXID_MATCH,
 		 "sama7g54", "sama7g5"),
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G54_D1G_EXID_MATCH,
+		 "SAMA7G54 1Gb DDR3L SiP", "sama7g5"),
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G54_D2G_EXID_MATCH,
+		 "SAMA7G54 2Gb DDR3L SiP", "sama7g5"),
+	AT91_SOC(SAMA7G5_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
+		 AT91_CIDR_VERSION_MASK_SAMA7G5, SAMA7G54_D4G_EXID_MATCH,
+		 "SAMA7G54 4Gb DDR3L SiP", "sama7g5"),
 #endif
 	{ /* sentinel */ },
 };
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 2ecaa75b00f0..7a9f47ce85fb 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -70,6 +70,9 @@ at91_soc_init(const struct at91_soc *socs);
 #define SAMA7G52_EXID_MATCH		0x2
 #define SAMA7G53_EXID_MATCH		0x1
 #define SAMA7G54_EXID_MATCH		0x0
+#define SAMA7G54_D1G_EXID_MATCH		0x00000018
+#define SAMA7G54_D2G_EXID_MATCH		0x00000020
+#define SAMA7G54_D4G_EXID_MATCH		0x00000028
 
 #define AT91SAM9XE128_CIDR_MATCH	0x329973a0
 #define AT91SAM9XE256_CIDR_MATCH	0x329a93a0
-- 
2.38.1

