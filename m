Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90E7005F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbjELKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 06:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240892AbjELKra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:47:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D28AFE;
        Fri, 12 May 2023 03:47:15 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-52c6504974dso8897018a12.2;
        Fri, 12 May 2023 03:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683888434; x=1686480434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5wxPW18b4R0sRXPhoTakncl9njdflZ8y6zNcQOexJI=;
        b=Z7k82tc2HoQiz2Y+96UNv7Gma09OEv5PLhls+jCo9aEUte0iTPhxbotyN+DXIUBMue
         Y6Aev3n2O7roahg7/7l73/5kAWs5HqOLRfDnXCQcd7hCaP1ywIO+R8fIXO+0TrTErBB7
         cgY2uOyQHwr5gCNCgtO79cU66o4+cAnMw8Zc7SGcgJRfqzazi21jdsuwyHftM3cHezg7
         d922Bl3ZWM9n9sDK9X4SPUAeUm8urFCKzff6fyyoo7wDTnIUFt7NQ8rQrLIp+GprtJe7
         k39EjFxVHPcGAm3EhGaX0ZFDS/WvgHRJm/SfVxoe6bQKDCHeu5t/4S39Ns9cKrSjQ7vh
         rRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683888434; x=1686480434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5wxPW18b4R0sRXPhoTakncl9njdflZ8y6zNcQOexJI=;
        b=ctAEBSOr93dyjbqKW6P+oYIGX59kvTyLFsZiUzTsB/xVnZWtUw7TK7Jqjpvm+0RWXD
         I+nXu6Kuxu/ACH5cI1OMhP9sOndTWs50hy7NdLSkJ+ZNvbMR+lK5070xojbpMpkjIulN
         VJjhQRXKO3zi9y2t47rmRLDrnYjWbfTkl9r661h+icC7r8vMwvcF136QT74LPv54aVzw
         pVoc/nCpEPj9m9RJkrUkz/sy4hpXjJ1T+cwLRbwpspS/VuSSgRs0KH5okIgBWiUyJuKH
         Kqq0DGPh3trFwoE/w4ltAPA48fSxbNzg8YY0GN21vJHoz5J4faLI7iCOPjJWsyofDmgj
         f3UA==
X-Gm-Message-State: AC+VfDxjZ7sTp5z9EtfMAnf6/Se6tNtU0OFlhfnQmGmFFdqjY6RvoOEV
        Ryb2gI1fEBJAgHWWU3Zuc20=
X-Google-Smtp-Source: ACHHUZ4Bz89gnOwzGUX1G4Kyjn0//tzAicFQ9M2ExkdgqPkSqq4LDUZB6pp1iHaot/bqyz+yHvEYNw==
X-Received: by 2002:a05:6a21:7881:b0:103:8590:bb50 with SMTP id bf1-20020a056a21788100b001038590bb50mr10019257pzc.44.1683888434485;
        Fri, 12 May 2023 03:47:14 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2ae-0f1d-f6c2-46f4-c62f-3944.emome-ip6.hinet.net. [2001:b400:e2ae:f1d:f6c2:46f4:c62f:3944])
        by smtp.gmail.com with ESMTPSA id g17-20020aa78751000000b0064358d032a4sm7019268pfo.145.2023.05.12.03.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:47:14 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V1 3/3] mmc: sdhci-pci-gli: Add support SD Express card for GL9767
Date:   Fri, 12 May 2023 18:45:59 +0800
Message-Id: <20230512104559.11218-4-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
References: <20230512104559.11218-1-victor.shih@genesyslogic.com.tw>
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

Add support SD Express card for GL9767. The workflow of the
SD Express card in GL9767 is as below.
1. GL9767 operates in SD mode and set MMC_CAP2_SD_EXP flag.
2. If card is inserted, Host send CMD8 to ask the capabilities
   of the card.
3. If the card has PCIe capability and write protect is not
   enable, then init_sd_express() will be invoked.
4. GL9767 switch from SD mode to PCIe/NVMe mode and mmc driver
   handover control to NVMe driver.
5. If card is removed, GL9767 will return to SD mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-pci-gli.c | 115 +++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 300512740cb0..a0f9c24439be 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -158,6 +158,13 @@
 #define   GLI_9767_VHS_REV_M	  0x1
 #define   GLI_9767_VHS_REV_W	  0x2
 
+#define PCIE_GLI_9767_CFG		0x8A0
+#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
+
+#define PCIE_GLI_9767_COMBO_MUX_CTL			0x8C8
+#define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN		  BIT(6)
+#define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN	  BIT(10)
+
 #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
@@ -175,6 +182,27 @@
 #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
 #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
 
+#define PCIE_GLI_9767_SDHC_CAP			0x91C
+#define   PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT	  BIT(5)
+
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
+#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER	  GENMASK(1, 0)
+
+#define PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2				0x954
+#define   PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_EN_REG2_SDEI_COMPLETE_STATUS_EN	  GENMASK(1, 0)
+
+#define PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2				0x958
+#define   PCIE_GLI_9767_NORMAL_ERR_INT_SIGNAL_EN_REG2_SDEI_COMPLETE_SIGNAL_EN	  GENMASK(1, 0)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -774,6 +802,91 @@ static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
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
+	if (sdhci_check_ro(host)) {
+		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
+		return 0;
+	}
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
+	value &= ~GLI_9767_VHS_REV;
+	value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
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
+	value |= PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_GEN_TIMER;
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
+	value |= ((SDHCI_POWER_180 | SDHCI_POWER_ON) << 4);
+	sdhci_writeb(host, value, SDHCI_POWER_CONTROL);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
+	value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SDEI_EXE;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
+
+	for (i = 0; i < 10; i++) {
+		mdelay(10);
+		pci_read_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2, &value);
+		if (value & PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2_SDEI_COMPLETE) {
+			pci_write_config_dword(pdev, PCIE_GLI_9767_NORMAL_ERR_INT_STATUS_REG2,
+					       value);
+			break;
+		}
+	}
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SDHC_CAP, &value);
+	if ((value & PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) == PCIE_GLI_9767_SDHC_CAP_SDEI_RESULT) {
+		pci_read_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, &value);
+		value |= PCIE_GLI_9767_SD_EXPRESS_CTL_SD_EXPRESS_MODE;
+		pci_write_config_dword(pdev, PCIE_GLI_9767_SD_EXPRESS_CTL, value);
+	} else {
+		mmc->ios.timing &= ~(MMC_TIMING_SD_EXP | MMC_TIMING_SD_EXP_1_2V);
+	}
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &value);
+	value &= ~GLI_9767_VHS_REV;
+	value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, value);
+
+	return 0;
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -806,6 +919,8 @@ static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
 	gl9767_hw_setting(slot);
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	host->mmc->caps2 |= MMC_CAP2_SD_EXP;
+	host->mmc_host_ops.init_sd_express = gl9767_init_sd_express;
 	sdhci_enable_v4_mode(host);
 
 	return 0;
-- 
2.25.1

