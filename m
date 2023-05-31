Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68422717DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbjEaLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjEaLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:17:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C5E8;
        Wed, 31 May 2023 04:17:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b01bd7093aso30912345ad.1;
        Wed, 31 May 2023 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685531849; x=1688123849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6dq4b1xhx1Qx+qJ9zV/ekRGtlRq1SNTzaOgEH+kK1Q=;
        b=XRG1NrvybCnz3yu3PTXa6PqJMpCdluAtmempM8w3+LJYHL9CJHZcs/NWOjhvi1dJ1c
         0uPaaiLgv980At7I3jHAoJtu1FE7UcnRfo7afMHM7QJvKuk4aYtzwYjmAkul04kopXXw
         +fpvi7Rmd/HUUvxaZjyS1QM7KkEZx/AVvejSivegCS9LlCAy2OX8AlwSvYfkUwlVFnfq
         uoyIk0SaWxx06NffVv5VS0sRUhXfoPPfra2hNzTgGa+BdyKNh6GEL0KUPASIVFl7CijE
         8JaRUFDl4ZuIvDRDe31IxkUV2ckDaFifbs0TAqfR2MGlE8Y3rp1g5fnR/1AHko0BSGQ7
         oV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531849; x=1688123849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6dq4b1xhx1Qx+qJ9zV/ekRGtlRq1SNTzaOgEH+kK1Q=;
        b=DdJJUfxHHPjw3WivvlnbgRP3UTFuibijE8SL+/vrfu4PLjFSpu4a1ttprQm98XhMpx
         budzY8YuqgO2ci20OjSgWLqfgwjnEvWhidg0wF+WfLcJHltUxqviwnt6mjBNFCa41zAw
         xnQLTYri6wr1dM7YFXLcQN98aMyXtKO2S1tTEj8DDtQBkVgY25PaCM1vyL0/vYxkk/Yb
         mShwA1fbDcVXGbir8ibuzB6DtNVZmneNngCkPF2zEfN2eBUsgLRWcKUjgc/SzRrH1JQ8
         ny4EQl4jwbsWa//DxFwizb8FlCbHqlo9Wt2lj0xcfRfZi68ieRwwW9DDZe7kA2xcjxzo
         qwWg==
X-Gm-Message-State: AC+VfDwND0w+szjn9sQwh7MobBsJFeO39B8oqTM5LlPaxVQ+P/U2OUlt
        OrmdNZ+c5lKvYDQBv0xGdwI=
X-Google-Smtp-Source: ACHHUZ4k5xr+L40r/CFkzSXPXAbIae98vwKPXrLVJhdGtow8pjwPUtBJcDlQ+db40wXRl9TYXVHz0g==
X-Received: by 2002:a17:902:d2ca:b0:1b1:7890:ff48 with SMTP id n10-20020a170902d2ca00b001b17890ff48mr620520plc.5.1685531849548;
        Wed, 31 May 2023 04:17:29 -0700 (PDT)
Received: from localhost.localdomain (111-82-252-250.emome-ip.hinet.net. [111.82.252.250])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001b0aec3ed59sm1076588plh.256.2023.05.31.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:17:29 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V4 2/4] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767
Date:   Wed, 31 May 2023 19:15:16 +0800
Message-Id: <20230531111518.396868-3-victorshihgli@gmail.com>
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

Set GL9767 SDR104's clock to 205MHz and enable SSC feature
depend on register 0x888 BIT(1).

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 135 ++++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 3ed207b89d1a..392a106cea18 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -158,6 +158,12 @@
 #define   GLI_9767_VHS_REV_M	  0x1
 #define   GLI_9767_VHS_REV_W	  0x2
 
+#define PCIE_GLI_9767_COM_MAILBOX		0x888
+#define   PCIE_GLI_9767_COM_MAILBOX_SSC_EN	  BIT(1)
+
+#define PCIE_GLI_9767_CFG		0x8A0
+#define   PCIE_GLI_9767_CFG_LOW_PWR_OFF	  BIT(12)
+
 #define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
 #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
@@ -175,6 +181,16 @@
 #define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
 #define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
 
+#define PCIE_GLI_9767_SD_PLL_CTL			0x938
+#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV		  GENMASK(9, 0)
+#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV		  GENMASK(15, 12)
+#define   PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN		  BIT(16)
+#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_EN		  BIT(19)
+#define   PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING	  GENMASK(28, 24)
+
+#define PCIE_GLI_9767_SD_PLL_CTL2		0x93C
+#define   PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM	  GENMASK(31, 16)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -753,6 +769,123 @@ static inline void gl9767_vhs_write(struct pci_dev *pdev)
 	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, vhs_value);
 }
 
+static bool gl9767_ssc_enable(struct pci_dev *pdev)
+{
+	u32 value;
+	u8 enable;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_COM_MAILBOX, &value);
+	enable = FIELD_GET(PCIE_GLI_9767_COM_MAILBOX_SSC_EN, value);
+
+	gl9767_vhs_read(pdev);
+
+	return enable;
+}
+
+static void gl9767_set_ssc(struct pci_dev *pdev, u8 enable, u8 step, u16 ppm)
+{
+	u32 pll;
+	u32 ssc;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, &ssc);
+	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING |
+		 PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
+	ssc &= ~PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM;
+	pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_STEP_SETTING, step) |
+	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_SSC_EN, enable);
+	ssc |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL2_PLLSSC_PPM, ppm);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL2, ssc);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
+
+	gl9767_vhs_read(pdev);
+}
+
+static void gl9767_set_pll(struct pci_dev *pdev, u8 dir, u16 ldiv, u8 pdiv)
+{
+	u32 pll;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
+	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV |
+		 PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV |
+		 PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN);
+	pll |= FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_LDIV, ldiv) |
+	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_PDIV, pdiv) |
+	       FIELD_PREP(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN, dir);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
+
+	gl9767_vhs_read(pdev);
+
+	/* wait for pll stable */
+	msleep(1);
+}
+
+static void gl9767_set_ssc_pll_205mhz(struct pci_dev *pdev)
+{
+	bool enable = gl9767_ssc_enable(pdev);
+
+	/* set pll to 205MHz and ssc */
+	gl9767_set_ssc(pdev, enable, 0x1F, 0xF5C3);
+	gl9767_set_pll(pdev, 0x1, 0x246, 0x0);
+}
+
+static void gl9767_disable_ssc_pll(struct pci_dev *pdev)
+{
+	u32 pll;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, &pll);
+	pll &= ~(PCIE_GLI_9767_SD_PLL_CTL_PLL_DIR_EN | PCIE_GLI_9767_SD_PLL_CTL_SSC_EN);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SD_PLL_CTL, pll);
+
+	gl9767_vhs_read(pdev);
+}
+
+static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct mmc_ios *ios = &host->mmc->ios;
+	struct pci_dev *pdev;
+	u32 value;
+	u16 clk;
+
+	pdev = slot->chip->pdev;
+	host->mmc->actual_clock = 0;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
+
+	gl9767_disable_ssc_pll(pdev);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		return;
+
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+	if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
+		host->mmc->actual_clock = 205000000;
+		gl9767_set_ssc_pll_205mhz(pdev);
+	}
+
+	sdhci_enable_clk(host, clk);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_CFG, &value);
+	value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value);
+
+	gl9767_vhs_read(pdev);
+}
+
 static void gli_set_9767(struct sdhci_host *host)
 {
 	u32 value;
@@ -1293,7 +1426,7 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 };
 
 static const struct sdhci_ops sdhci_gl9767_ops = {
-	.set_clock		 = sdhci_set_clock,
+	.set_clock		 = sdhci_gl9767_set_clock,
 	.enable_dma		 = sdhci_pci_enable_dma,
 	.set_bus_width		 = sdhci_set_bus_width,
 	.reset			 = sdhci_gl9767_reset,
-- 
2.25.1

