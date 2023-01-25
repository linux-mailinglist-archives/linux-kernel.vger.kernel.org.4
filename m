Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D7C67AB63
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjAYILR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjAYILN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:11:13 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3B4709B;
        Wed, 25 Jan 2023 00:11:12 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30P8Axjh100110;
        Wed, 25 Jan 2023 02:10:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674634259;
        bh=jJEIxkjBuCyQ2kRnrK0zrFDRWiVOz4giHjGrLWfCLP8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Bxb/TfHtczeBJO1G9NyNjHiXwFWGiFv1R+tMxcfyxWkOtJXoOrA2iJ8GJ2xxgiqWW
         3YakzbG0LKPOrRlvWVtSkOWzKED0JlVE8R9uLwuCY6iT+jKp5TnDaWaohOmKuTZ6dD
         HBluk+cp/NPJVlvX0/7KOT8evurI37h89CDUxh7s=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30P8Ax9L027212
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jan 2023 02:10:59 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 25
 Jan 2023 02:10:59 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 25 Jan 2023 02:10:59 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30P8AvTW033327;
        Wed, 25 Jan 2023 02:10:58 -0600
From:   Dhruva Gole <d-gole@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Dhruva Gole <d-gole@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Takahiro.Kuwano@infineon.com>, Pratyush Yadav <ptyadav@amazon.de>
Subject: [PATCH v2 2/4] spi: cadence-quadspi: Add flag for direct mode writes
Date:   Wed, 25 Jan 2023 13:40:21 +0530
Message-ID: <20230125081023.1573712-3-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125081023.1573712-1-d-gole@ti.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new flag inorder to avoid playing with use_direct_mode
flag currently being used throughout the driver.
Disable DAC write if auto polling is disabled or CQSPI_DISABLE_DAC_MODE
is set.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 6030da942c6e..4bbf6e3ad34a 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -84,6 +84,7 @@ struct cqspi_st {
 	u32			trigger_address;
 	u32			wr_delay;
 	bool			use_direct_mode;
+	bool			use_direct_mode_wr;
 	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
 	bool			use_dma_read;
 	u32			pd_dev_id;
@@ -945,6 +946,12 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
 		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
 		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+		/*
+		 * DAC mode require auto polling as flash needs to be polled
+		 * for write completion in case of bubble in SPI transaction
+		 * due to slow CPU/DMA master.
+		 */
+		cqspi->use_direct_mode_wr = false;
 	}

 	reg = readl(reg_base + CQSPI_REG_SIZE);
@@ -1230,7 +1237,7 @@ static ssize_t cqspi_write(struct cqspi_flash_pdata *f_pdata,
 	 * data.
 	 */
 	if (!op->cmd.dtr && cqspi->use_direct_mode &&
-	    ((to + len) <= cqspi->ahb_size)) {
+	    cqspi->use_direct_mode_wr && ((to + len) <= cqspi->ahb_size)) {
 		memcpy_toio(cqspi->ahb_base + to, buf, len);
 		return cqspi_wait_idle(cqspi);
 	}
@@ -1700,8 +1707,10 @@ static int cqspi_probe(struct platform_device *pdev)
 						cqspi->master_ref_clk_hz);
 		if (ddata->hwcaps_mask & CQSPI_SUPPORTS_OCTAL)
 			master->mode_bits |= SPI_RX_OCTAL | SPI_TX_OCTAL;
-		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE))
+		if (!(ddata->quirks & CQSPI_DISABLE_DAC_MODE)) {
 			cqspi->use_direct_mode = true;
+			cqspi->use_direct_mode_wr = true;
+		}
 		if (ddata->quirks & CQSPI_SUPPORT_EXTERNAL_DMA)
 			cqspi->use_dma_read = true;
 		if (ddata->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
--
2.25.1

