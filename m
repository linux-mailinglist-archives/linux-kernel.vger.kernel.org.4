Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1ED731591
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbjFOKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjFOKjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:39:03 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3BC81BC;
        Thu, 15 Jun 2023 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ICJ8jrZM5TZc06mcNR
        wgdYz21JS3FDfS+zR+SSr2uX0=; b=Dm6XiM0x6u0I47bSW4ta3xriY6/hCStCi0
        vcCYBefzLQewoAWuRc/iaV0s//rBBhRGiblekuaEufJVZJ0OkXuHYGLqJ5u6L70g
        4mTUBrN7MAKHKRKy/eNaC4aVpkBtAd9xj0yB44qa+ywKEhpbXderXZn75672NFoK
        niMESZ5kI=
Received: from wh-chevronli-w10.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3BSr43opk8WKiAA--.50068S3;
        Thu, 15 Jun 2023 17:50:49 +0800 (CST)
From:   Chevron Li <chevron_li@126.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, chevron.li@bayhubtech.com
Subject: [PATCH V2 2/2] mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 support for express card
Date:   Thu, 15 Jun 2023 17:50:12 +0800
Message-Id: <20230615095012.30856-2-chevron_li@126.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20230615095012.30856-1-chevron_li@126.com>
References: <20230615095012.30856-1-chevron_li@126.com>
X-CM-TRANSID: _____wD3BSr43opk8WKiAA--.50068S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw47JF4rJF4rAr1xKw1UGFg_yoWrZFy7pF
        sYvas8Cr4UtFW3Z39rGw4kur1Ygr4vk3ykKFsxX3yFv3WUCr95WFn7CFy5XryUXrZ3tw1f
        Xa1vqFyUGry5AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYNtxUUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: hfkh42xrqbzxa6rslhhfrp/1tbiFx6PAVpEGgA+wgAAs-
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

Change in V2:
1.updated some typo in patch and modified title.
2.updated patch format according to reviewer's comments.
3.updated the logical to try UHSI when express card initializatio failed.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 65 +++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h             |  3 ++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 539bbafb3ff7..ad5502f3aa95 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -21,6 +21,7 @@
  * O2Micro device registers
  */
 
+#define O2_SD_PCIE_SWITCH	0x54
 #define O2_SD_MISC_REG5		0x64
 #define O2_SD_LD0_CTRL		0x68
 #define O2_SD_DEV_CTRL		0x88
@@ -631,6 +632,67 @@ static void sdhci_pci_o2_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_o2_enable_clk(host, clk);
 }
 
+static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip = slot->chip;
+	u8 scratch8;
+	u16 scratch16;
+	int ret;
+
+	/* Disable clock */
+	sdhci_writeb(host, 0, SDHCI_CLOCK_CONTROL);
+
+	/* Set VDD2 voltage*/
+	scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	scratch8 &= 0x0F;
+	if (host->mmc->ios.timing == MMC_TIMING_SD_EXP_1_2V &&
+	    host->mmc->caps2 & MMC_CAP2_SD_EXP_1_2V) {
+		scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_120;
+	} else {
+		scratch8 |= SDHCI_VDD2_POWER_ON | SDHCI_VDD2_POWER_180;
+	}
+
+	sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
+
+	/* UnLock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
+	scratch8 &= 0x7f;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	/* Wait for express card clkreqn assert */
+	ret = read_poll_timeout(sdhci_readb, scratch8, !(scratch8 & BIT(0)),
+				1, 30000, false, host, O2_SD_EXP_INT_REG);
+
+	if (!ret) {
+		/* Switch to PCIe mode */
+		scratch16 = sdhci_readw(host, O2_SD_PCIE_SWITCH);
+		scratch16 |= BIT(8);
+		sdhci_writew(host, scratch16, O2_SD_PCIE_SWITCH);
+	} else {
+		/* Power off VDD2 voltage*/
+		scratch8 = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		scratch8 &= 0x0F;
+		sdhci_writeb(host, scratch8, SDHCI_POWER_CONTROL);
+
+		/* Keep mode as UHSI */
+		pci_read_config_word(chip->pdev, O2_SD_PARA_SET_REG1, &scratch16);
+		scratch16 &= ~BIT(11);
+		pci_write_config_word(chip->pdev, O2_SD_PARA_SET_REG1, scratch16);
+
+		host->mmc->ios.timing = MMC_TIMING_LEGACY;
+		pr_info("%s: Express card initialization failed, falling back to Legacy\n",
+			mmc_hostname(host->mmc));
+	}
+	/* Lock WP */
+	pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch8);
+	scratch8 |= 0x80;
+	pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch8);
+
+	return 0;
+}
+
 static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -703,10 +765,11 @@ static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
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
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f4f2085c274c..d09640840171 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -99,6 +99,9 @@
 #define  SDHCI_POWER_180	0x0A
 #define  SDHCI_POWER_300	0x0C
 #define  SDHCI_POWER_330	0x0E
+#define  SDHCI_VDD2_POWER_ON	0x10
+#define  SDHCI_VDD2_POWER_180	0xA0
+#define  SDHCI_VDD2_POWER_120	0x80
 
 #define SDHCI_BLOCK_GAP_CONTROL	0x2A
 
-- 
2.25.1

