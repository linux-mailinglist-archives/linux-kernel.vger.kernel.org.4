Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB05B9182
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIOAMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIOAMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:12:46 -0400
Received: from spamfilter.jmicron.com (spamfilter.jmicron.com [220.130.51.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA294454D;
        Wed, 14 Sep 2022 17:12:43 -0700 (PDT)
Received: from JMEH602.jmicron.com (jmeh602.jmicron.com [10.88.10.18])
        by spamfilter.jmicron.com with ESMTP id 28F0CioR002300;
        Thu, 15 Sep 2022 08:12:44 +0800 (+08)
        (envelope-from mdlin@jmicron.com)
Received: from JMEH601.jmicron.com (10.88.10.17) by JMEH602.jmicron.com
 (10.88.10.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2375.28; Thu, 15
 Sep 2022 08:12:27 +0800
Received: from localhost.localdomain (10.88.20.234) by JMEH601.jmicron.com
 (10.88.10.17) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Thu, 15 Sep 2022 08:12:27 +0800
From:   MD Lin <mdlin@jmicron.com>
To:     <damien.lemoal@opensource.wdc.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mdlin@jmicron.com>, <kevinliu@jmicron.com>,
        <charonchen@jmicron.com>, <corahuang@jmicron.com>,
        <mhchen@jmicron.com>, <georgechao@jmicron.com>,
        <banks@jmicron.com>, <tzuwei@jmicron.com>
Subject: [PATCH] ata: ahci: Add initialization quirk for JMicron JMB585/JMB582 controllers
Date:   Thu, 15 Sep 2022 00:11:49 +0000
Message-ID: <20220915001149.24241-1-mdlin@jmicron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-DNSRBL: 
X-MAIL: spamfilter.jmicron.com 28F0CioR002300
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

JMicron JMB585/JMB582 does not enable specific error bit handling functions
by default so this patch enable these functions for better compatibility.
Besides, these patches also adjust SATA RX/TX_GEN1/TX_GEN2 parameters for
better compatibility. These patches had been tested in JMicron Test
Laboratory and been implemented to our customers.

Signed-off-by: MD Lin <mdlin@jmicron.com>
---
 drivers/ata/ahci.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/ahci.h | 23 +++++++++++++++
 2 files changed, 94 insertions(+)
 mode change 100755 => 100644 drivers/ata/ahci.h

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 505920d45..3e9e3b8f8 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1657,6 +1657,75 @@ static void ahci_intel_pcs_quirk(struct pci_dev *pdev, struct ahci_host_priv *hp
 	}
 }
 
+static void ahci_jmb58x_write_sata(void __iomem *mmio, u32 addr, u32 data)
+{
+	writel((addr & 0x01FFFUL) + (1UL << 18UL), mmio + 0xC0);
+	writel(data, mmio + 0xC8);
+}
+
+static void ahci_jmb58x_quirk(void __iomem *mmio)
+{
+	u32 pi = readl(mmio + HOST_PORTS_IMPL);
+	u32 b8_data;
+
+	/*
+	 * JMB582: PI is 0x03
+	 * JMB585: PI is 0x1f
+	 */
+
+	/*
+	 * enable error bit handling functions, these might overwrite
+	 * the setting which loads from external SPI flash.
+	 * the address and value are defined in adapter specs.
+	 */
+	b8_data = (pi > 3) ? 0x13 : 0x92;
+	writel(JMB58X_EH_MODIFY_ON + b8_data,  mmio + 0xB8);
+	writel(JMB58X_EH_GENERAL,              mmio + 0x30);
+	writel(JMB58X_EH_CFIS_RETRY,           mmio + 0x34);
+	writel(JMB58X_EH_DROP_D2H,             mmio + 0x38);
+	writel(JMB58X_EH_MODIFY_OFF + b8_data, mmio + 0xB8);
+	writel(JMB58X_EH_TX_LOCK,              mmio + 0xB0);
+
+	/*
+	 * set SATA configuration, these might overwrite
+	 * the setting which loads from external SPI flash.
+	 * the address and value are defined in adapter specs.
+	 */
+	ahci_jmb58x_write_sata(mmio, 0x06, JMB58X_SATA0_RX);
+	ahci_jmb58x_write_sata(mmio, 0x13, JMB58X_SATA1_RX);
+	ahci_jmb58x_write_sata(mmio, 0x73, JMB58X_SATA0_TX_GEN2);
+	ahci_jmb58x_write_sata(mmio, 0x75, JMB58X_SATA1_TX_GEN2);
+	ahci_jmb58x_write_sata(mmio, 0x74, JMB58X_SATA0_TX_GEN1);
+	ahci_jmb58x_write_sata(mmio, 0x80, JMB58X_SATA1_TX_GEN1);
+	if (pi > 3) {
+		ahci_jmb58x_write_sata(mmio, 0x20, JMB58X_SATA2_RX);
+		ahci_jmb58x_write_sata(mmio, 0x2D, JMB58X_SATA3_RX);
+		ahci_jmb58x_write_sata(mmio, 0x3A, JMB58X_SATA4_RX);
+		ahci_jmb58x_write_sata(mmio, 0x79, JMB58X_SATA3_TX_GEN2);
+		ahci_jmb58x_write_sata(mmio, 0x83, JMB58X_SATA3_TX_GEN2_EXT);
+		ahci_jmb58x_write_sata(mmio, 0x7A, JMB58X_SATA3_TX_GEN1);
+		ahci_jmb58x_write_sata(mmio, 0x84, JMB58X_SATA3_TX_GEN1_EXT);
+	}
+}
+
+static void ahci_jmicron_quirk(struct pci_dev *pdev,
+			struct ahci_host_priv *hpriv)
+{
+	void __iomem *mmio = hpriv->mmio;
+	u8 tmp8;
+
+	if (pdev->vendor != PCI_VENDOR_ID_JMICRON)
+		return;
+
+	switch (pdev->device) {
+	case 0x585:
+		tmp8 = readb(mmio + 0x44);
+		if (tmp8)  /* check controller version */
+			ahci_jmb58x_quirk(mmio);
+		break;
+	}
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1775,6 +1844,8 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 */
 	ahci_intel_pcs_quirk(pdev, hpriv);
 
+	ahci_jmicron_quirk(pdev, hpriv);
+
 	/* prepare host */
 	if (hpriv->cap & HOST_CAP_NCQ) {
 		pi.flags |= ATA_FLAG_NCQ;
diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
old mode 100755
new mode 100644
index 9290e787a..82ecc6f2c
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -52,6 +52,29 @@
 #define EM_MSG_LED_VALUE_OFF          0xfff80000
 #define EM_MSG_LED_VALUE_ON           0x00010000
 
+/* JMicron JMB585/JMB582 Error Bit Handling Register Value */
+#define JMB58X_EH_MODIFY_ON           0x03060004
+#define JMB58X_EH_MODIFY_OFF          0x03060000
+#define JMB58X_EH_GENERAL             0x00FF0B01
+#define JMB58X_EH_CFIS_RETRY          0x0000003F
+#define JMB58X_EH_DROP_D2H            0x0000001F
+#define JMB58X_EH_TX_LOCK             0xF9E4EFBF
+
+/* JMicron JMB585/JMB582 SATA PHY Register Value */
+#define JMB58X_SATA0_RX               0x70005BE3
+#define JMB58X_SATA1_RX               0x70005BE3
+#define JMB58X_SATA2_RX               0x70005BE3
+#define JMB58X_SATA3_RX               0x70005BE3
+#define JMB58X_SATA4_RX               0x70005BE3
+#define JMB58X_SATA0_TX_GEN1          0x00000024
+#define JMB58X_SATA1_TX_GEN1          0x250B0003
+#define JMB58X_SATA3_TX_GEN1          0x00000024
+#define JMB58X_SATA3_TX_GEN1_EXT      0x250B0003
+#define JMB58X_SATA0_TX_GEN2          0x000001E5
+#define JMB58X_SATA1_TX_GEN2          0x000001E5
+#define JMB58X_SATA3_TX_GEN2          0x000001E5
+#define JMB58X_SATA3_TX_GEN2_EXT      0x250B0003
+
 enum {
 	AHCI_MAX_PORTS		= 32,
 	AHCI_MAX_CLKS		= 5,
-- 
2.17.1

