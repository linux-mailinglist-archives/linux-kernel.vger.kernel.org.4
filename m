Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26AB719038
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 03:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjFABvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 21:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjFABvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 21:51:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A008134;
        Wed, 31 May 2023 18:51:29 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75b14216386so22845485a.0;
        Wed, 31 May 2023 18:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685584288; x=1688176288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6dq4b1xhx1Qx+qJ9zV/ekRGtlRq1SNTzaOgEH+kK1Q=;
        b=knWH0ze5tDjW2LCZUgDZcXCQ+z4BMXqhXIKNFwmJvnHmwAsx3OjW7/FR9eLG2w78AX
         UtlpGYIuTelxOdj5l3w1BiDuGWuvyZFYUWxGwJ4akH0QafMvXvlv6ujE4AL8q3OxjULl
         f0IyBZ+FuxCZB05+d3+sZHoP7/mP1E51FIIJxn1B3pk3duNt19ZEqTugn+dtPunwdj2x
         V3n+SYpjQBNlncBQ70yGWoWqppTFTBRxjB2y2K8UDvOBPOoEMndoTdAw0Jk9SmaTpmS2
         51JohUQuyO5+M8zAjbTIQKBSjp5T3oiU8YD/loSSTqSHGTSjAlJ4K8rRj5FkuF9bpijD
         tvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685584288; x=1688176288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6dq4b1xhx1Qx+qJ9zV/ekRGtlRq1SNTzaOgEH+kK1Q=;
        b=kR88ZW/g4Wpi6Cc/Il9BtxGnmZaIHgROtesFK1WuNBFhb9UeHJOh1F4BsQ678HaPJ8
         hJa5jzbALMMp0OLA4gLeamC8f/NZYaytx/WDntTOJN4Va+su8M/KNbQ9lCSH0DJVNAyC
         TeOswuP98pmyrxolfNhRa3yK5gsCMeUQt9LFmjw8YRVcEMVaQaMvMcvAGPE+2nS3pGVh
         TytikhZiLIb3z6KXkAvcKhBO6gPNKtVGH7Z0uRswqH5B/ufL8YExLOpjo+FsIc9Kc5fp
         JfufZfUs6kYK0ytgwbVrG5tR1N/3Ra6RnhwKEiqbHzjcF8SuXoNS63l/D+fEn/Q1LHvX
         VzPA==
X-Gm-Message-State: AC+VfDwx6dG+OLW9O6XUTaw0PP5lOc8LYY44cX8qWf/kY0a8ifguAsFe
        wAcrsvvTXS5KQ0R5UOU9SSglqKuTm0g=
X-Google-Smtp-Source: ACHHUZ6Hx4jR7NCwcryduFW07aQb8J5R9OiSkK6veJwPfLTEyo9MlbhbPMBkNglkuTFmwe9d3uyvfQ==
X-Received: by 2002:a05:620a:f01:b0:75b:23a0:e7cd with SMTP id v1-20020a05620a0f0100b0075b23a0e7cdmr9567356qkl.46.1685584288451;
        Wed, 31 May 2023 18:51:28 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e454-8dbb-0377-d3ab-ebce-7b9b.emome-ip6.hinet.net. [2001:b400:e454:8dbb:377:d3ab:ebce:7b9b])
        by smtp.gmail.com with ESMTPSA id e2-20020a17090a7c4200b00253239144c5sm165795pjl.42.2023.05.31.18.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 18:51:28 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V5 2/4] mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767
Date:   Thu,  1 Jun 2023 09:51:13 +0800
Message-Id: <20230601015115.406002-3-victorshihgli@gmail.com>
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

