Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45B97290AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjFIHO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238071AbjFIHOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:14:52 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B802D7F;
        Fri,  9 Jun 2023 00:14:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6563ccf5151so1551510b3a.0;
        Fri, 09 Jun 2023 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686294890; x=1688886890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb1mDFhM0TkiZ/6VHU0sssZ9OqNe3tnE049NIDGtjqw=;
        b=iMTDYmCMhvcAKDU2jwsY9pG69DwHtgSi0flG2Uqh31kfoXL8ZkoPrjYMDF4iL0fvlN
         fn0trlmfEY/lZrp4Qpx7CxZI7RYNxy58bwEtkK9Mu901YsLhN4xhpKiR9zav7MYoB+h/
         ttdpm1UY0m+JjOnYMTsmZYAfeBSuHYLgPnbm22Zz6nrHGHrvFcjBv8ox67k8996rLt1y
         HcmvAOH13ZkpA6DJJwVV/4HwfCCUtza4AkrM7b8Rl9fe7SurjmVGivQtCI4BPpH/70Sp
         lQif/Epet+kiuKw9+k3KcNOSOkGjxLEznahJmTID2zCyda3wiAjGaHXOZ63W7FBQTPYn
         flbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686294890; x=1688886890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb1mDFhM0TkiZ/6VHU0sssZ9OqNe3tnE049NIDGtjqw=;
        b=Dz1dj3WYtry6S/LpQwNygmsH9Z0HHmdc/OkImcx1O3A13kzi5JbbYqumFN79AEr1vk
         jr9wVboUkDAUgA4vHBZVo3vzQZuxq0NIP4VIs8vEITov5dJl49g54Gd7Z/lmK/inj4uK
         wOOykAAujmgOenv9JJfBo5bfAp6s571SBSwvFOabSak1abzJmPW1uzU0ELgnmbV2HVdo
         zsHIMQsbYGHipYGAoB8qGeddCOHEV9WuTcmPTrS/mjW3x9oyymOyvkjZbfIZEqkABqsv
         3t90ZmLaaochYnJ7gq0+i08vxvoJlahR8GM+xR4gmQlGtwxs7ldJnae51j8Wk7H3lgi7
         NCZw==
X-Gm-Message-State: AC+VfDwJxaJq5j5+9t3HcXIU+gTozTWvfHNUUX/V3rfu4P/6vZw1mfh0
        hk6yIDIsxv42hsW32VoiMu4=
X-Google-Smtp-Source: ACHHUZ5566vuK95/3//JBiWjvFu+JrVCQXHPxp8eiRLD1jUE2aWIBiBg4G1g+gJ3OBYsdRymsKBTdg==
X-Received: by 2002:a05:6a21:680d:b0:100:3964:6cb with SMTP id wr13-20020a056a21680d00b00100396406cbmr505564pzb.40.1686294889879;
        Fri, 09 Jun 2023 00:14:49 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-07a7-2523-0b40-49e4-7cbb.emome-ip6.hinet.net. [2001:b400:e282:7a7:2523:b40:49e4:7cbb])
        by smtp.gmail.com with ESMTPSA id f3-20020a656283000000b005308b255502sm2085196pgv.68.2023.06.09.00.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:14:49 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V6 1/4] mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
Date:   Fri,  9 Jun 2023 15:14:38 +0800
Message-Id: <20230609071441.451464-2-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230609071441.451464-1-victorshihgli@gmail.com>
References: <20230609071441.451464-1-victorshihgli@gmail.com>
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

Add support for the GL9767 chipset. GL9767 supports
SD3 mode likes UHS-I SDR50, SDR104.
Enable MSI interrupt for GL9767. Some platform do not
support PCI INTx and devices can not work without
interrupt.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c |   1 +
 drivers/mmc/host/sdhci-pci-gli.c  | 160 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   2 +
 3 files changed, 163 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 01975d145200..1c2572c0f012 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1903,6 +1903,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
 	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
 	SDHCI_PCI_DEVICE(GLI, 9763E, gl9763e),
+	SDHCI_PCI_DEVICE(GLI, 9767, gl9767),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 633a8ee8f8c5..3ed207b89d1a 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -149,6 +149,32 @@
 #define PCI_GLI_9755_PM_CTRL     0xFC
 #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
 
+#define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
+#define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
+
+#define PCIE_GLI_9767_VHS	0x884
+#define   GLI_9767_VHS_REV	  GENMASK(19, 16)
+#define   GLI_9767_VHS_REV_R	  0x0
+#define   GLI_9767_VHS_REV_M	  0x1
+#define   GLI_9767_VHS_REV_W	  0x2
+
+#define PCIE_GLI_9767_PWR_MACRO_CTL					0x8D0
+#define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE			  GENMASK(3, 0)
+#define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE		  GENMASK(15, 12)
+#define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE_VALUE	  0x7
+#define   PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL		  GENMASK(29, 28)
+#define   PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL_VALUE		  0x3
+
+#define PCIE_GLI_9767_SCR				0x8E0
+#define   PCIE_GLI_9767_SCR_AUTO_AXI_W_BURST		  BIT(6)
+#define   PCIE_GLI_9767_SCR_AUTO_AXI_R_BURST		  BIT(7)
+#define   PCIE_GLI_9767_SCR_AXI_REQ			  BIT(9)
+#define   PCIE_GLI_9767_SCR_CARD_DET_PWR_SAVING_EN	  BIT(10)
+#define   PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE0	  BIT(16)
+#define   PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE1	  BIT(17)
+#define   PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF		  BIT(21)
+#define   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN	  BIT(30)
+
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
@@ -693,6 +719,89 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	gl9755_wt_off(pdev);
 }
 
+static inline void gl9767_vhs_read(struct pci_dev *pdev)
+{
+	u32 vhs_enable;
+	u32 vhs_value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &vhs_value);
+	vhs_enable = FIELD_GET(GLI_9767_VHS_REV, vhs_value);
+
+	if (vhs_enable == GLI_9767_VHS_REV_R)
+		return;
+
+	vhs_value &= ~GLI_9767_VHS_REV;
+	vhs_value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_R);
+
+	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, vhs_value);
+}
+
+static inline void gl9767_vhs_write(struct pci_dev *pdev)
+{
+	u32 vhs_enable;
+	u32 vhs_value;
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_VHS, &vhs_value);
+	vhs_enable = FIELD_GET(GLI_9767_VHS_REV, vhs_value);
+
+	if (vhs_enable == GLI_9767_VHS_REV_W)
+		return;
+
+	vhs_value &= ~GLI_9767_VHS_REV;
+	vhs_value |= FIELD_PREP(GLI_9767_VHS_REV, GLI_9767_VHS_REV_W);
+
+	pci_write_config_dword(pdev, PCIE_GLI_9767_VHS, vhs_value);
+}
+
+static void gli_set_9767(struct sdhci_host *host)
+{
+	u32 value;
+
+	value = sdhci_readl(host, SDHCI_GLI_9767_GM_BURST_SIZE);
+	value &= ~SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET;
+	sdhci_writel(host, value, SDHCI_GLI_9767_GM_BURST_SIZE);
+}
+
+static void gl9767_hw_setting(struct sdhci_pci_slot *slot)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 value;
+
+	gl9767_vhs_write(pdev);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_PWR_MACRO_CTL, &value);
+	value &= ~(PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE |
+		   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE |
+		   PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL);
+
+	value |= PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE |
+		 FIELD_PREP(PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE,
+			    PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE_VALUE) |
+		 FIELD_PREP(PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL,
+			    PCIE_GLI_9767_PWR_MACRO_CTL_RCLK_AMPLITUDE_CTL_VALUE);
+	pci_write_config_dword(pdev, PCIE_GLI_9767_PWR_MACRO_CTL, value);
+
+	pci_read_config_dword(pdev, PCIE_GLI_9767_SCR, &value);
+	value &= ~(PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE0 |
+		   PCIE_GLI_9767_SCR_SYSTEM_CLK_SELECT_MODE1 |
+		   PCIE_GLI_9767_SCR_CFG_RST_DATA_LINK_DOWN);
+
+	value |= PCIE_GLI_9767_SCR_AUTO_AXI_W_BURST |
+		 PCIE_GLI_9767_SCR_AUTO_AXI_R_BURST |
+		 PCIE_GLI_9767_SCR_AXI_REQ |
+		 PCIE_GLI_9767_SCR_CARD_DET_PWR_SAVING_EN |
+		 PCIE_GLI_9767_SCR_CORE_PWR_D3_OFF;
+	pci_write_config_dword(pdev, PCIE_GLI_9767_SCR, value);
+
+	gl9767_vhs_read(pdev);
+}
+
+static void sdhci_gl9767_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+	gli_set_9767(host);
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -717,6 +826,19 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
 	return 0;
 }
 
+static int gli_probe_slot_gl9767(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_host *host = slot->host;
+
+	gli_set_9767(host);
+	gl9767_hw_setting(slot);
+	gli_pcie_enable_msi(slot);
+	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static void sdhci_gli_voltage_switch(struct sdhci_host *host)
 {
 	/*
@@ -740,6 +862,25 @@ static void sdhci_gli_voltage_switch(struct sdhci_host *host)
 	usleep_range(100000, 110000);
 }
 
+static void sdhci_gl9767_voltage_switch(struct sdhci_host *host)
+{
+	/*
+	 * According to Section 3.6.1 signal voltage switch procedure in
+	 * SD Host Controller Simplified Spec. 4.20, steps 6~8 are as
+	 * follows:
+	 * (6) Set 1.8V Signal Enable in the Host Control 2 register.
+	 * (7) Wait 5ms. 1.8V voltage regulator shall be stable within this
+	 *     period.
+	 * (8) If 1.8V Signal Enable is cleared by Host Controller, go to
+	 *     step (12).
+	 *
+	 * Wait 5ms after set 1.8V signal enable in Host Control 2 register
+	 * to ensure 1.8V signal enable bit is set by GL9767.
+	 *
+	 */
+	usleep_range(5000, 5500);
+}
+
 static void sdhci_gl9750_reset(struct sdhci_host *host, u8 mask)
 {
 	sdhci_reset(host, mask);
@@ -1150,3 +1291,22 @@ const struct sdhci_pci_fixes sdhci_gl9763e = {
 #endif
 	.add_host       = gl9763e_add_host,
 };
+
+static const struct sdhci_ops sdhci_gl9767_ops = {
+	.set_clock		 = sdhci_set_clock,
+	.enable_dma		 = sdhci_pci_enable_dma,
+	.set_bus_width		 = sdhci_set_bus_width,
+	.reset			 = sdhci_gl9767_reset,
+	.set_uhs_signaling	 = sdhci_set_uhs_signaling,
+	.voltage_switch		 = sdhci_gl9767_voltage_switch,
+};
+
+const struct sdhci_pci_fixes sdhci_gl9767 = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
+	.probe_slot	= gli_probe_slot_gl9767,
+	.ops		= &sdhci_gl9767_ops,
+#ifdef CONFIG_PM_SLEEP
+	.resume		= sdhci_pci_gli_resume,
+#endif
+};
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 3661a224fb04..9c8863956381 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -76,6 +76,7 @@
 #define PCI_DEVICE_ID_GLI_9755		0x9755
 #define PCI_DEVICE_ID_GLI_9750		0x9750
 #define PCI_DEVICE_ID_GLI_9763E		0xe763
+#define PCI_DEVICE_ID_GLI_9767		0x9767
 
 /*
  * PCI device class and mask
@@ -195,5 +196,6 @@ extern const struct sdhci_pci_fixes sdhci_o2;
 extern const struct sdhci_pci_fixes sdhci_gl9750;
 extern const struct sdhci_pci_fixes sdhci_gl9755;
 extern const struct sdhci_pci_fixes sdhci_gl9763e;
+extern const struct sdhci_pci_fixes sdhci_gl9767;
 
 #endif /* __SDHCI_PCI_H */
-- 
2.25.1

