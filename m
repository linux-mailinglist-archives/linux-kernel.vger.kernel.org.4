Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA9717DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjEaLRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjEaLRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:17:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F04E12B;
        Wed, 31 May 2023 04:17:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b04949e5baso25210405ad.0;
        Wed, 31 May 2023 04:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685531855; x=1688123855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtPxOefjM4ZZdvGD2evpcXztukQ57ylG6FBkyjgKbVM=;
        b=JWFKoinsE2V/9SpLB1uLSEP86duqVBAZ9I67W7uyZykLSs7tBifZq9sfPF24MTKJs1
         S8VuuqV4snWsZ9nDKArd2telquFglvduMk4QPZ9BCVWCWpGNA78UbqeWChucVQ4QU7zQ
         qk1mrfzgWu6Q9PXT7ryOqB9VHOzeSn4/6H/uKb542v9YJ1iDxGoiGdKY0xOgWRvTrcDP
         JEPs4z5Gx7hRPTTAGN8wVl6pV9IfY3ZjPKJaP0lCUHxOQWRqgi53wI/ur/PsV0zx4x0Q
         GjuyN+gF1W0FvXYLmEn1Pr/Vb/B2NdoZyMTwbjP/qc/SZnd8V/O0OmghgJHkbLTm13MS
         H7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531855; x=1688123855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtPxOefjM4ZZdvGD2evpcXztukQ57ylG6FBkyjgKbVM=;
        b=PdhzClLK1RY+lSKiAhZrPqoU+/TOVpVMciBMdnLbVkGSKSqifMFZBhpACM2vNG3t+S
         1QaScFmhVsB2PCe8BviH1dyu3DNJjzpoXwKeB4lkoJxSXTxGF6GTC2l2DeMxgag25jwZ
         Q+MnhTokoyruTfGNuLtSbv431VrXXJ6Cd8hnnI5rSLck9Cs5FG3yODcfDYQluuUaGrer
         OG91TfJiCuiY9e/RQTOcRbR3VgPJKH/nHEkroksfZxsJ1tDHVJYd5rpmzmeqVTwNjqUO
         uVrYHFImIOOPmUPNNSd4uFxUA2yDSbVlN5mF86E2pxvWbWM89qGcT6kg5D7nL3HIM/l1
         24Dw==
X-Gm-Message-State: AC+VfDw5vXicdCBThibWE+87j4Ij/v+TvxQM+wOl8cAIRxJLd/nFIibc
        Tmf+FtUm2TSQdkTtypVcfU4=
X-Google-Smtp-Source: ACHHUZ62NF0GSp+/rxBFAyMqdzACWR+qHcswz2cx1e2vqQmWlGEVLzJB7HxJPzfBK0mP7VUM/Sa6hg==
X-Received: by 2002:a17:903:22cb:b0:1b0:bf80:d1f2 with SMTP id y11-20020a17090322cb00b001b0bf80d1f2mr3365069plg.49.1685531854654;
        Wed, 31 May 2023 04:17:34 -0700 (PDT)
Received: from localhost.localdomain (111-82-252-250.emome-ip.hinet.net. [111.82.252.250])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001b0aec3ed59sm1076588plh.256.2023.05.31.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:17:34 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V4 4/4] mmc: sdhci-pci-gli: Add support SD Express card for GL9767
Date:   Wed, 31 May 2023 19:15:18 +0800
Message-Id: <20230531111518.396868-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531111518.396868-1-victorshihgli@gmail.com>
References: <20230531111518.396868-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add support SD Express card for GL9767. The workflow of the
SD Express card in GL9767 is as below.
1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
2. If card is inserted, Host send CMD8 to ask the capabilities
   of the card.
3. If the card has PCIe capability, then init_sd_express()
   will be invoked.
4. If the card has been put in write protect state then the
   SD features supported by SD mode but not supported by
   PCIe mode, therefore GL9767 switch to SD mode.
5. If the card has not been put in write protect state then
   GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
   handover control to NVMe driver.
6. If card is removed, GL9767 will return to SD mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 113 +++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 392a106cea18..e47236e3b89a 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -164,6 +164,10 @@
 #define PCIE_GLI_9767_CFG		0x8A0
 #define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
 
+#define PCIE_GLI_9767_COMBO_MUX_CTL			0x8C8
+#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
+#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
+
 #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
@@ -181,6 +185,9 @@
 #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
 #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
 
+#define PCIE_GLI_9767_SDHC_CAP			0x91C
+#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
+
 #define PCIE_GLI_9767_SD_PLL_CTL			0x938
 #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV		  GENMASK(9, 0)
 #define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV		  GENMASK(15, 12)
@@ -191,6 +198,23 @@
 #define PCIE_GLI_9767_SD_PLL_CTL2		0x93C
 #define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM	  GENMASK(31, 16)
 
+#define PCIE_GLI_9767_SD_EXPRESS_CTL			0x940
+#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE		  BIT(0)
+#define   PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE	  BIT(1)
+
+#define PCIE_GLI_9767_SD_DATA_MULTI_CTL				0x944
+#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME	  GENMASK(23, 16)
+#define   PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE	  0x64
+
+#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2			0x950
+#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE	  BIT(0)
+
+#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2				0x954
+#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN	  BIT(0)
+
+#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
+#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  BIT(0)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -935,6 +959,93 @@ static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
 	gli_set_9767(host);
 }
 
+static int gl9767_init_sd_express(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev;
+	u32 value;
+	int i;
+
+	pdev = slot->chip->pdev;
+
+	if (mmc->ops->get_ro(mmc)) {
+		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
+		return 0;
+	}
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, &value);
+	value &= ~(PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN | PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_COMBO_MUX_CTL, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, &value);
+	value &= ~PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME;
+	value |= FIELD_PREP(PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME,
+			    PCIE_GLI_9767_SD_DATA_MULTI_CTL_DISCONNECT_TIME_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_DATA_MULTI_CTL, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
+	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, &value);
+	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, &value);
+	value |= PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
+
+	value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	value &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
+	sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
+
+	value = sdhci_readb(host, SDHCI_POWER_CONTROL);
+	value |= (SDHCI_VDD2_POWER_180 | SDHCI_VDD2_POWER_ON);
+	sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
+	value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
+
+	for (i = 0; i < 2; i++) {
+		msleep(10);
+		pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
+		if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE) {
+			pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2,
+					       value);
+			break;
+		}
+	}
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
+	if (value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) {
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
+		value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
+	} else {
+		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
+
+		value = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		value &= ~(SDHCI_VDD2_POWER_180 | SDHCI_VDD2_POWER_ON);
+		sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
+
+		value = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		value |= (SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_PLL_EN);
+		sdhci_writew(host, value, SDHCI_CLOCK_CONTROL);
+	}
+
+	gl9767_vhs_read(pdev);
+
+	return 0;
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -967,6 +1078,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
 	gl9767_hw_setting(slot);
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
+	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
 	sdhci_enable_v4_mode(host);
 
 	return 0;
-- 
2.25.1

