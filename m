Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5739E71903B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjFABvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFABvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:51:39 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E71B13E;
        Wed, 31 May 2023 18:51:34 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af6b5cf489so389299a34.3;
        Wed, 31 May 2023 18:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685584293; x=1688176293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0YtnC+ivRd+yaQNSAJHN92lBak7PFbLa8TMCQnN22IM=;
        b=DKvtGGxEaMnOdL/XwVM6RiZkNbUSuNVVlWfkUr4X9VCBpAxajivEH/kuQjtoo9scih
         pfrYkI0yCQLic0lWxH5/Wmt+DWNOz8YihfhWrQRC4i/NlbCcoAR8gjhT+pWbPPi25T4M
         Z+HqZ4mIxkDq3XiF3xkqlJRLT4z5GVNi76oSSm+0VXu8CzA+iHX6BIUfGvaGbr3VSlhs
         FaWnqiT3ta52aAfsz+Pw5/d6GgvAYWfjIqPj2sabMovv3yBEJqDQLd3BoBpCiCX4JaFd
         Hp/icFF/E6JP49punPL03v5oMtiUJsgxA5nz2mL/pTC8UtlJweBIFglbe8XK/f0LcShZ
         oOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685584293; x=1688176293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YtnC+ivRd+yaQNSAJHN92lBak7PFbLa8TMCQnN22IM=;
        b=SRnL14r11W7eL4ZN4lftqb1GLQXPeQl3c7pYpwLBwh8U8hzmQhi11sZHvv38cUZ9pd
         j8ph2QiM9NHqFvGyH6kG/INqQGmmCSbL61Nba3HiCKLqhHpFrD3YwQpbIUePftpf8FGs
         19UhNmROS0eJbY8oIgdKL6vn45Qblhgc52MBe/bC2tMgQrTI0X7v76Cbo6CoyjWe+8Tq
         ggepDsA1WuB8jr3gg7kRk5p+t5QKJxwTujlJgDg/UJu9/tI4kHepozPAinJWhznAz3Db
         /gp5wDD2oTVXchTVhEvw+Wo4n+8o9sUVV4nrKRThKx0PtFpFcnafHmurmlzz81Bd9i0D
         KCOQ==
X-Gm-Message-State: AC+VfDx+9cAVYEU7t3+XdIfrHkhImE8T2pKTndv7Ph2vi6qfGwIP6kDo
        0r0jDzf9eFARyvwsd19ngnI=
X-Google-Smtp-Source: ACHHUZ4FjTS075j1+edA3Axy4/z/baiDda1ULnMGIgukUoAE2iFq2y2A+W3q+INzZey7ye+cKqvG+Q==
X-Received: by 2002:a05:6358:ce1a:b0:127:d8c1:b829 with SMTP id gt26-20020a056358ce1a00b00127d8c1b829mr679039rwb.27.1685584293599;
        Wed, 31 May 2023 18:51:33 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e454-8dbb-0377-d3ab-ebce-7b9b.emome-ip6.hinet.net. [2001:b400:e454:8dbb:377:d3ab:ebce:7b9b])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a7c4200b00253239144c5sm165795pjl.42.2023.05.31.18.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 18:51:33 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 4/4] mmc: sdhci-pci-gli: Add support SD Express card for GL9767
Date:   Thu,  1 Jun 2023 09:51:15 +0800
Message-Id: <20230601015115.406002-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601015115.406002-1-victorshihgli@gmail.com>
References: <20230601015115.406002-1-victorshihgli@gmail.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

