Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0B7251CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240612AbjFGBwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240640AbjFGBvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:51:53 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 703FA19AB;
        Tue,  6 Jun 2023 18:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=rL1HLDDH3DxRNYdCLi
        8SStgCPzr3ccNzmCjay25S1pI=; b=JhSJATmsxmhweNciXU4nx0M4bWnxbGMAPj
        hnc3z+n2qnVCThplNvPr1AsL13BZ7yrgJm1bOMaFNJsE5M6CwLH2EN1CjHbXkRal
        Uocr0fQJF7aKyXP4xtjXvnJ5OkzZekpuDFNNC4nvdTQkg4Nl8pwaIrQ3P86p+Ns0
        9stvxSbqI=
Received: from wh-chevronli-w10.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g1-1 (Coremail) with SMTP id _____wDnPj374X9k3iQtAw--.54119S3;
        Wed, 07 Jun 2023 09:48:44 +0800 (CST)
From:   Chevron Li <chevron_li@126.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, chevron.li@bayhubtech.com
Subject: [PATCH V1 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support
Date:   Wed,  7 Jun 2023 09:48:12 +0800
Message-Id: <20230607014812.30104-2-chevron_li@126.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20230607014812.30104-1-chevron_li@126.com>
References: <20230607014812.30104-1-chevron_li@126.com>
X-CM-TRANSID: _____wDnPj374X9k3iQtAw--.54119S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw47Jw4fJF1kCryUtw1rXrb_yoW5tFyfpF
        4Fvas8Gr4rKFW3Z39xGw4vvr1S9r1vvrWqkF43Jw4Fvw1jkF4rWr97CFy5XryUXrZaqw1f
        Xa1vqFyUGFyUAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCjgcUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: hfkh42xrqbzxa6rslhhfrp/1tbiFwCHAVpEGcH9fQAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chevron Li <chevron.li@bayhubtech.com>

Add Bayhub new chip GG8 support for SD express card.
This patch depends on patch 1/2.

Signed-off-by: Chevron Li <chevron.li@bayhubtech.com>
---
Change in V1:
1.Implement the SD express card callback routine.
2.Add SD express card support for Bayhub GG8 chip.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 61 +++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 8243a63b3c81..b2d8ddbb4095 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -21,6 +21,7 @@
  * O2Micro device registers
  */
 
+#define O2_SD_PCIE_SWITCH	0x54
 #define O2_SD_MISC_REG5		0x64
 #define O2_SD_LD0_CTRL		0x68
 #define O2_SD_DEV_CTRL		0x88
@@ -631,6 +632,63 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_o2_enable_clk(host, clk);
 }
 
+static u8 sdhci_o2_sd_express_clkq_assert(struct sdhci_host *host)
+{
+	return sdhci_readb(host, O2_SD_EXP_INT_REG);
+}
+
+static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
+	u8 scratch8 = 0;
+	u16 scratch16 = 0;
+	bool ret = false;
+
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+	/* Set VDD2 voltage*/
+	scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	scratch8 &= 0x0F;
+	if ((host->mmc->ios.timing == MMC_TIMING_SD_EXP_1_2V) &&
+		(host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V)) {
+		scratch8 |= BIT(4) | BIT(7);
+	} else
+		scratch8 |= BIT(4) | BIT(5) | BIT(7);
+	sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
+	scratch8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	ret = readx_poll_timeout(sdhci_o2_sd_express_clkq_assert, host,
+		scratch8, !(scratch8 & BIT(0)), 1, 30000) == 0 ? 0 : 1;
+
+	if (!ret) {
+		/* switch to PCIe mode */
+		scratch16 = sdhci_readw(host, O2_SD_PCIE_SWITCH);
+		scratch16 |= BIT(8);
+		sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
+	} else {
+		/* keep mode as USHI */
+		pci_read_config_word(chip->pdev,
+						O2_SD_PARA_SET_REG1, &scratch16);
+		scratch16 &= ~BIT(11);
+		pci_write_config_word(chip->pdev,
+						O2_SD_PARA_SET_REG1, scratch16);
+	}
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev,
+					O2_SD_LOCK_WP, &scratch8);
+	scratch8 |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	return ret;
+}
+
 static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -703,10 +761,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 	case PCI_DEVICE_ID_O2_GG8_9861:
 	case PCI_DEVICE_ID_O2_GG8_9862:
 	case PCI_DEVICE_ID_O2_GG8_9863:
-		host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+		host->mmc->caps2 |= MMC_CAP2_NO_SDIO | MMC_CAP2_SD_EXP | MMC_CAP2_SD_EXP_1_2V;
 		host->mmc->caps |= MMC_CAP_HW_RESET;
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		slot->host->mmc_host_ops.get_cd = sdhci_o2_get_cd;
+		host->mmc_host_ops.init_sd_express = sdhci_pci_o2_init_sd_express;
 		break;
 	default:
 		break;
-- 
2.25.1

