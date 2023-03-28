Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2695F6CB631
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC1Fmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjC1Fms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:42:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F991BF9;
        Mon, 27 Mar 2023 22:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679982168; x=1711518168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WnTCVxeo4ixouY0+xIT6aOWTUOXdySrVSf9qY5DLHao=;
  b=kSaUqUZ3exbJo0yQKYZIJxtJV5npx+wJkrnEb37Sd6ThsY3YoEF3hwfL
   Kl1A0a0Yshuz8aXuxm+xSf6jtzZaWIThXRiTzJ2jXxOQWNdFzcV8d4otg
   1tB/C/3DYcjFHK990E4h+AQFeI2jRkUmaEbt5pxvI9glYQaHX270W+xVJ
   +I9pAFwdSfWx+J8MvFFFCEUvmEnALfITjIwNYxAtPSiHGQFeNwxpX0V4K
   S9CGMwO4jdciWrPV2ZG/vMRDKjNYzMzReN/KqKYzFGe2xd53sVodimjU9
   nJpBCke00pkgL4kwwxPqzr8Z96jcVkouwika4H117eeDAHYKlEoC+xHQl
   w==;
X-IronPort-AV: E=Sophos;i="5.98,296,1673938800"; 
   d="scan'208";a="207012170"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 22:42:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 22:42:45 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 22:42:44 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: [PATCH SPI for-next] spi: microchip: pci1xxxx: Fix minor bugs in spi-pci1xxxx driver
Date:   Tue, 28 Mar 2023 11:12:12 +0530
Message-ID: <20230328054212.139312-1-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following bugs are fixed in this patch:
1. pci1xxxx_spi_resume API masks SPI interrupt bit which prohibits
firing of interrupt to the host at the end of the transaction after
suspend-resume. This patch unmasks this bit at resume.
2. In pci1xxxx_spi_transfer_one API, length of SPI transaction gets
cleared by unmasking length field. Set length of transaction after
unmasking length field.
3. Remove support for disabling chip select as hardware does not support
the same.

Fixes: 1cc0cbea7167 ("spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX PCIe switch")
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
---
 drivers/spi/spi-pci1xxxx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 1c5731641a04..9a044012aca7 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -58,7 +58,7 @@
 #define VENDOR_ID_MCHP 0x1055
 
 #define SPI_SUSPEND_CONFIG 0x101
-#define SPI_RESUME_CONFIG 0x303
+#define SPI_RESUME_CONFIG 0x203
 
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
@@ -114,16 +114,11 @@ static void pci1xxxx_spi_set_cs(struct spi_device *spi, bool enable)
 
 	/* Set the DEV_SEL bits of the SPI_MST_CTL_REG */
 	regval = readl(par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-	if (enable) {
+	if (!enable) {
 		regval &= ~SPI_MST_CTL_DEVSEL_MASK;
 		regval |= (spi_get_chipselect(spi, 0) << 25);
 		writel(regval,
 		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-	} else {
-		regval &= ~(spi_get_chipselect(spi, 0) << 25);
-		writel(regval,
-		       par->reg_base + SPI_MST_CTL_REG_OFFSET(p->hw_inst));
-
 	}
 }
 
@@ -199,8 +194,9 @@ static int pci1xxxx_spi_transfer_one(struct spi_controller *spi_ctlr,
 			else
 				regval &= ~SPI_MST_CTL_MODE_SEL;
 
-			regval |= ((clkdiv << 5) | SPI_FORCE_CE | (len << 8));
+			regval |= ((clkdiv << 5) | SPI_FORCE_CE);
 			regval &= ~SPI_MST_CTL_CMD_LEN_MASK;
+			regval |= (len << 8);
 			writel(regval, par->reg_base +
 			       SPI_MST_CTL_REG_OFFSET(p->hw_inst));
 			regval = readl(par->reg_base +
-- 
2.25.1

