Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC965ED396
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiI1Dn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiI1Dno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:43:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727EEF5083;
        Tue, 27 Sep 2022 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664336623; x=1695872623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BFYWGW8K3bIDy5Ql/rcg4K4rlvjhOLOijgenCiffFdc=;
  b=MxAlnBd7EI/qnnkIAMLS0BkYxRgR0d/gZVg5QJW3gv9l7xP6Lw9Q+3yk
   3kdrICoa1mXXL6fy27YENk9GXAcH3HCfmjC1VEkETlzdXQ8EE7SF5sfZq
   v+twIPW0N8TvMtP80ijCy/3vu5P7EwVOJ8Uk9buXXnfK1ui4M05wj1q+I
   FErmOIXOnqcfVhBtrCFeOOZRF63FF4dEczyGcKVCym5reM1A6u33QVKXA
   3WXkayJNoF5GAPybq6FGjNIBaAsXrsgpO3EU31JUXMQYvf1vzgvoh8s7R
   bFCqsZmf+xdw69KBTDahwXxw/XzeHgze2tF3ziER7xpyki9Brrs33fJf7
   g==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="115744159"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 20:43:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 20:43:41 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 27 Sep 2022 20:43:39 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH RFC SPI for-next 2/2] spi: microchip: pci1xxxx: Add suspend and resume support for PCI1XXXX SPI driver
Date:   Wed, 28 Sep 2022 09:13:36 +0530
Message-ID: <20220928034336.2939265-3-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
References: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement suspend, resume callbacks, store config at suspend and restore
config at time of resume

Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>

---
 drivers/spi/spi-pci1xxxx.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/spi/spi-pci1xxxx.c b/drivers/spi/spi-pci1xxxx.c
index 0b6ba8108d19..072549231e11 100644
--- a/drivers/spi/spi-pci1xxxx.c
+++ b/drivers/spi/spi-pci1xxxx.c
@@ -58,6 +58,9 @@
 #define SPI_CHIP_SEL_COUNT 7
 #define VENDOR_ID_MCHP 0x1055
 
+#define SPI_SUSPEND_CONFIG 0x101
+#define SPI_RESUME_CONFIG 0x303
+
 struct pci1xxxx_spi_internal {
 	u8 hw_inst;
 	int irq;
@@ -364,10 +367,82 @@ static int pci1xxxx_spi_probe(struct pci_dev *pdev, const struct pci_device_id *
 	return ret;
 }
 
+static void store_restore_config(struct pci1xxxx_spi *spi_ptr,
+				 struct pci1xxxx_spi_internal *spi_sub_ptr,
+				 u8 inst, bool store)
+{
+	u32 regval;
+
+	if (store) {
+		regval = readl(spi_ptr->reg_base +
+			       SPI_MST_CTL_REG_OFFSET(spi_sub_ptr->hw_inst));
+		regval &= SPI_MST_CTL_DEVSEL_MASK;
+		spi_sub_ptr->prev_val.dev_sel = (regval >> 25) & 7;
+		regval = readl(spi_ptr->reg_base +
+			       SPI_PCI_CTRL_REG_OFFSET(spi_sub_ptr->hw_inst));
+		regval &= SPI_MSI_VECTOR_SEL_MASK;
+		spi_sub_ptr->prev_val.msi_vector_sel = (regval >> 4) & 1;
+	} else {
+		regval = readl(spi_ptr->reg_base + SPI_MST_CTL_REG_OFFSET(inst));
+		regval &= ~SPI_MST_CTL_DEVSEL_MASK;
+		regval |= (spi_sub_ptr->prev_val.dev_sel << 25);
+		writel(regval,
+		       spi_ptr->reg_base + SPI_MST_CTL_REG_OFFSET(inst));
+		writel((spi_sub_ptr->prev_val.msi_vector_sel << 4),
+			spi_ptr->reg_base + SPI_PCI_CTRL_REG_OFFSET(inst));
+	}
+}
+
+static int pci1xxxx_spi_resume(struct device *dev)
+{
+	struct pci1xxxx_spi *spi_ptr = dev_get_drvdata(dev);
+	struct pci1xxxx_spi_internal *spi_sub_ptr;
+	u32 regval = SPI_RESUME_CONFIG;
+	u8 iter;
+
+	for (iter = 0; iter < spi_ptr->total_hw_instances; iter++) {
+		spi_sub_ptr = spi_ptr->spi_int[iter];
+		spi_master_resume(spi_sub_ptr->spi_host);
+		writel(regval, spi_ptr->reg_base +
+		       SPI_MST_EVENT_MASK_REG_OFFSET(iter));
+
+		/* Restore config at resume */
+		store_restore_config(spi_ptr, spi_sub_ptr, iter, 0);
+	}
+
+	return 0;
+}
+
+static int pci1xxxx_spi_suspend(struct device *dev)
+{
+	struct pci1xxxx_spi *spi_ptr = dev_get_drvdata(dev);
+	struct pci1xxxx_spi_internal *spi_sub_ptr;
+	u32 reg1 = SPI_SUSPEND_CONFIG;
+	u8 iter;
+
+	for (iter = 0; iter < spi_ptr->total_hw_instances; iter++) {
+		spi_sub_ptr = spi_ptr->spi_int[iter];
+
+		/* Store existing config before suspend */
+		store_restore_config(spi_ptr, spi_sub_ptr, iter, 1);
+		spi_master_suspend(spi_sub_ptr->spi_host);
+		writel(reg1, spi_ptr->reg_base +
+		       SPI_MST_EVENT_MASK_REG_OFFSET(iter));
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(spi_pm_ops, pci1xxxx_spi_suspend,
+				pci1xxxx_spi_resume);
+
 static struct pci_driver pci1xxxx_spi_driver = {
 	.name		= DRV_NAME,
 	.id_table	= pci1xxxx_spi_pci_id_table,
 	.probe		= pci1xxxx_spi_probe,
+	.driver		=	{
+		.pm = pm_sleep_ptr(&spi_pm_ops),
+	},
 };
 
 module_pci_driver(pci1xxxx_spi_driver);
-- 
2.25.1

