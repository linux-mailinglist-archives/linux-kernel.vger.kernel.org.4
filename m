Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F56D6A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbjDDRRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbjDDRQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:16:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF66D3;
        Tue,  4 Apr 2023 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680628616; x=1712164616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Z6kt8KKvWipPWeST1v16fNQUW3GnVVk+Du/WWg0CeI=;
  b=CRkjgRxyV5GCAMxf453Wt1lCdtw9xJUdboUaI+apiSUTXf39yBdICYqG
   VwtKqLXas84sOKikgAk2woGdXFgnV6Vo1PwJn33ajtM3ZnDjkQVy4VU3t
   yw/VxpLV0SEQimnJmND/D6qQk8WANO4t/EHlndD0CYA9rNoTR0/gJMGbz
   +QILxiCf2knqaXRXw/XGUKopfgOmwCAUl3XxtxTGLaINOpOJCYjYBHKRz
   qe/orz3A07MFLTMBws2i8CWIP3llqfwPUZkei0klArXZ/m7Nvaut2x4fs
   I99WStVLitWjeZM/Lh4Y6+TsU3lqJOtJB5OEVJWuBUf918lrld9qwVs9s
   w==;
X-IronPort-AV: E=Sophos;i="5.98,318,1673938800"; 
   d="scan'208";a="145482306"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2023 10:16:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 10:16:56 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 10:16:54 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: [PATCH SPI for-next 3/3] spi: mchp-pci1xxxx: Fix improper implementation of disabling chip select lines
Date:   Tue, 4 Apr 2023 22:46:13 +0530
Message-ID: <20230404171613.1336093-4-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
References: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware does not have support to disable individual chip select lines.
Disable all chip select lines by using SPI_FORCE_CE bit.

Fixes: 1cc0cbea7167 ("spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch")
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 82d4bfeea1fa..4445d82409d6 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -114,17 +114,14 @@ static void pci1xxxx_spi_set_cs(struct spi_device *spi, bool enable)
 
 	/* Set the DEV_SEL bits of the SPI_MST_CTL_REG */
 	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-	if (enable) {
+	if (!enable) {
+		regval |= SPI_FORCE_CE;
 		regval &= ~SPI_MST_CTL_DEVSEL_MASK;
 		regval |= (spi_get_chipselect(spi, 0) << 25);
-		writel(regval,
-		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 	} else {
-		regval &= ~(spi_get_chipselect(spi, 0) << 25);
-		writel(regval,
-		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-
+		regval &= ~SPI_FORCE_CE;
 	}
+	writel(regval, par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 }
 
 static u8 pci1xxxx_get_clock_div(u32 hz)
@@ -199,7 +196,7 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 			else
 				regval &= ~SPI_MST_CTL_MODE_SEL;
 
-			regval |= ((clkdiv << 5) | SPI_FORCE_CE);
+			regval |= (clkdiv << 5);
 			regval &= ~SPI_MST_CTL_CMD_LEN_MASK;
 			regval |= (len << 8);
 			writel(regval, par->reg_base +
@@ -223,10 +220,6 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 			}
 		}
 	}
-
-	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-	regval &= ~SPI_FORCE_CE;
-	writel(regval, par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 	p->spi_xfer_in_progress = false;
 
 	return 0;
-- 
2.25.1

