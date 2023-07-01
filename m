Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F186A744794
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGAHMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjGAHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:11:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD3846A6;
        Sat,  1 Jul 2023 00:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688195299; x=1719731299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7/Yy4Wi6zOp+hW93KNGDH0RJq2Se/QRRSPysIoU/LPk=;
  b=Rshz0cPNqrfH5raoy2TzTBpnXwLe3pGi1Xv2pCrhstrlD61MwgxQwkq4
   SZG7mVuhURJC2Im56LzO80TKgM+2apNrRBQbJUWRM1bDOu/N6aBWnIfsg
   xZK30yUDSTBVABU8JTTUNvhMucLYj95SwTI4jUwGra4LxkSVCTTOh92CC
   QLjpiRDXk/+rSDa3GPlQ5R/XOuHbx8A2Hbfjn3EcHRexfmYTnIIQkll8B
   hhKNpS853ktJiHgu4pJ8txgaQX9wG+aglsFO6d4Gv91xypgPOicpfQxV3
   Fvd7qqjvOHw958vaHLt8qg7pF2ONlOZpw98N6ojZywI9sRyYaHhdE3NzL
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="221530249"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2023 00:08:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 1 Jul 2023 00:08:14 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sat, 1 Jul 2023 00:08:11 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kumaravel.thiagarajan@microchip.com>,
        <tharunkumar.pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <michael@walle.cc>,
        "Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>
Subject: [PATCH RESEND v13 char-misc-next 2/2] misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX EEPROM via NVMEM sysfs
Date:   Sat, 1 Jul 2023 12:38:19 +0530
Message-ID: <20230701070819.3992094-3-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230701070819.3992094-1-kumaravel.thiagarajan@microchip.com>
References: <20230701070819.3992094-1-kumaravel.thiagarajan@microchip.com>
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

Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
industrial, and automotive applications. This switch integrates OTP
and EEPROM to enable customization of the part in the field.
This patch adds support to read and write into PCI1XXXX EEPROM
via NVMEM sysfs.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Co-developed-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
index d3aa5664f0b0..3d3d1578119a 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
@@ -11,19 +11,30 @@
 #include "mchp_pci1xxxx_gp.h"
 
 #define AUX_DRIVER_NAME			"PCI1xxxxOTPE2P"
+#define EEPROM_NAME			"pci1xxxx_eeprom"
 #define OTP_NAME			"pci1xxxx_otp"
 
 #define PERI_PF3_SYSTEM_REG_ADDR_BASE	0x2000
 #define PERI_PF3_SYSTEM_REG_LENGTH	0x4000
 
+#define EEPROM_SIZE_BYTES		8192
 #define OTP_SIZE_BYTES			8192
 
 #define CONFIG_REG_ADDR_BASE		0
+#define EEPROM_REG_ADDR_BASE		0x0E00
 #define OTP_REG_ADDR_BASE		0x1000
 
 #define MMAP_OTP_OFFSET(x)		(OTP_REG_ADDR_BASE + (x))
+#define MMAP_EEPROM_OFFSET(x)		(EEPROM_REG_ADDR_BASE + (x))
 #define MMAP_CFG_OFFSET(x)		(CONFIG_REG_ADDR_BASE + (x))
 
+#define EEPROM_CMD_REG			0x00
+#define EEPROM_DATA_REG			0x04
+
+#define EEPROM_CMD_EPC_WRITE		(BIT(29) | BIT(28))
+#define EEPROM_CMD_EPC_TIMEOUT_BIT	BIT(17)
+#define EEPROM_CMD_EPC_BUSY_BIT		BIT(31)
+
 #define STATUS_READ_DELAY_US		1
 #define STATUS_READ_TIMEOUT_US		20000
 
@@ -56,6 +67,8 @@
 struct pci1xxxx_otp_eeprom_device {
 	struct auxiliary_device *pdev;
 	void __iomem *reg_base;
+	struct nvmem_config nvmem_config_eeprom;
+	struct nvmem_device *nvmem_eeprom;
 	struct nvmem_config nvmem_config_otp;
 	struct nvmem_device *nvmem_otp;
 };
@@ -81,6 +94,115 @@ static void release_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
 	writel(0, sys_lock);
 }
 
+static bool is_eeprom_responsive(struct pci1xxxx_otp_eeprom_device *priv)
+{
+	void __iomem *rb = priv->reg_base;
+	u32 regval;
+	int ret;
+
+	writel(EEPROM_CMD_EPC_TIMEOUT_BIT,
+	       rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+	writel(EEPROM_CMD_EPC_BUSY_BIT,
+	       rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+
+	/* Wait for the EPC_BUSY bit to get cleared or timeout bit to get set*/
+	ret = read_poll_timeout(readl, regval, !(regval & EEPROM_CMD_EPC_BUSY_BIT),
+				STATUS_READ_DELAY_US, STATUS_READ_TIMEOUT_US,
+				true, rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+
+	/* Return failure if either of software or hardware timeouts happen */
+	if (ret < 0 || (!ret && (regval & EEPROM_CMD_EPC_TIMEOUT_BIT)))
+		return false;
+
+	return true;
+}
+
+static int pci1xxxx_eeprom_read(void *priv_t, unsigned int off,
+				void *buf_t, size_t count)
+{
+	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
+	void __iomem *rb = priv->reg_base;
+	char *buf = buf_t;
+	u32 regval;
+	u32 byte;
+	int ret;
+
+	if (off >= priv->nvmem_config_eeprom.size)
+		return -EFAULT;
+
+	if ((off + count) > priv->nvmem_config_eeprom.size)
+		count = priv->nvmem_config_eeprom.size - off;
+
+	ret = set_sys_lock(priv);
+	if (ret)
+		return ret;
+
+	for (byte = 0; byte < count; byte++) {
+		writel(EEPROM_CMD_EPC_BUSY_BIT | (off + byte), rb +
+		       MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+
+		ret = read_poll_timeout(readl, regval,
+					!(regval & EEPROM_CMD_EPC_BUSY_BIT),
+					STATUS_READ_DELAY_US,
+					STATUS_READ_TIMEOUT_US, true,
+					rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+		if (ret < 0 || (!ret && (regval & EEPROM_CMD_EPC_TIMEOUT_BIT))) {
+			ret = -EIO;
+			goto error;
+		}
+
+		buf[byte] = readl(rb + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));
+	}
+	ret = byte;
+error:
+	release_sys_lock(priv);
+	return ret;
+}
+
+static int pci1xxxx_eeprom_write(void *priv_t, unsigned int off,
+				 void *value_t, size_t count)
+{
+	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
+	void __iomem *rb = priv->reg_base;
+	char *value = value_t;
+	u32 regval;
+	u32 byte;
+	int ret;
+
+	if (off >= priv->nvmem_config_eeprom.size)
+		return -EFAULT;
+
+	if ((off + count) > priv->nvmem_config_eeprom.size)
+		count = priv->nvmem_config_eeprom.size - off;
+
+	ret = set_sys_lock(priv);
+	if (ret)
+		return ret;
+
+	for (byte = 0; byte < count; byte++) {
+		writel(*(value + byte), rb + MMAP_EEPROM_OFFSET(EEPROM_DATA_REG));
+		regval = EEPROM_CMD_EPC_TIMEOUT_BIT | EEPROM_CMD_EPC_WRITE |
+			 (off + byte);
+		writel(regval, rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+		writel(EEPROM_CMD_EPC_BUSY_BIT | regval,
+		       rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+
+		ret = read_poll_timeout(readl, regval,
+					!(regval & EEPROM_CMD_EPC_BUSY_BIT),
+					STATUS_READ_DELAY_US,
+					STATUS_READ_TIMEOUT_US, true,
+					rb + MMAP_EEPROM_OFFSET(EEPROM_CMD_REG));
+		if (ret < 0 || (!ret && (regval & EEPROM_CMD_EPC_TIMEOUT_BIT))) {
+			ret = -EIO;
+			goto error;
+		}
+	}
+	ret = byte;
+error:
+	release_sys_lock(priv);
+	return ret;
+}
+
 static void otp_device_set_address(struct pci1xxxx_otp_eeprom_device *priv,
 				   u16 address)
 {
@@ -243,6 +365,24 @@ static int pci1xxxx_otp_eeprom_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(&aux_dev->dev, priv);
 
+	if (is_eeprom_responsive(priv)) {
+		priv->nvmem_config_eeprom.type = NVMEM_TYPE_EEPROM;
+		priv->nvmem_config_eeprom.name = EEPROM_NAME;
+		priv->nvmem_config_eeprom.dev = &aux_dev->dev;
+		priv->nvmem_config_eeprom.owner = THIS_MODULE;
+		priv->nvmem_config_eeprom.reg_read = pci1xxxx_eeprom_read;
+		priv->nvmem_config_eeprom.reg_write = pci1xxxx_eeprom_write;
+		priv->nvmem_config_eeprom.priv = priv;
+		priv->nvmem_config_eeprom.stride = 1;
+		priv->nvmem_config_eeprom.word_size = 1;
+		priv->nvmem_config_eeprom.size = EEPROM_SIZE_BYTES;
+
+		priv->nvmem_eeprom = devm_nvmem_register(&aux_dev->dev,
+							 &priv->nvmem_config_eeprom);
+		if (!priv->nvmem_eeprom)
+			return -ENOMEM;
+	}
+
 	release_sys_lock(priv);
 
 	priv->nvmem_config_otp.type = NVMEM_TYPE_OTP;
-- 
2.34.1

