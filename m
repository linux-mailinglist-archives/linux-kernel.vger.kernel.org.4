Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77D6717DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbjEaLRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 07:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjEaLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 07:17:29 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6662E8;
        Wed, 31 May 2023 04:17:27 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53f8da65701so1958369a12.1;
        Wed, 31 May 2023 04:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685531847; x=1688123847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tb1mDFhM0TkiZ/6VHU0sssZ9OqNe3tnE049NIDGtjqw=;
        b=OEI8YciaXeED8NCobDYU+SD6+VCc4qN3JTZcV5SZlXeOL3ZpS8Hpb1XH1dk8yQ/KLk
         iO6/kChjU9u5tBybByZuCz8U66TvWv0I8qppakqQTUUJqt45PXo0LIWkduacBI4SKpjl
         bLqwYGUA5c33HRZAmMOzZ2rnTpOh4hX1k/TgcbFGiobRrci9V1nWSQzKI3B3Jh4MGE2P
         MyBmdRmtrFU9ifqrIwtwOjs1vKrEYAh+CvT+m1c9y3YJnSXktscraCiXpzHHVpGoZWuM
         yOxCtQXE3FNgVDtkvFGldgNHkge/ACe8hhLSg3xgkM8Votc3G8dz5IjsI6wFFp6rVQlh
         JJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685531847; x=1688123847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tb1mDFhM0TkiZ/6VHU0sssZ9OqNe3tnE049NIDGtjqw=;
        b=JJoGrSjlOTZecn4KCTdFQAM5ssI4Y8wZlSngDxcymsjITDhojh3wkF24ImRlbKeWqf
         yMWCxK7uKJFTKkpzTJnzwua5Scr7UFx5qPuhP4OPohjPTktVtOVDZviCxuUzk8ISToty
         zAUMPUKln1sqH/QIQBIc9eHewX0Fu8YKyCJ1/SzL8c+41FDQs9LVoqSfDgdIBSADqzZL
         30BNDrrP2RA4FvasidHGL2gE6w5Ft061InenIfm8dF/k2QH0XMZF2gu8IjPVSl5bs2SN
         kfXkQxJzj/MbWrI+XcNSnwUozCQZ/ZYoxz3BrBRHbiiQJfBsKbpwZN94eCMqy09O98yU
         WfJw==
X-Gm-Message-State: AC+VfDywR918efMt8WooNm+yrlVoJM/IcuFaZrnXt37t/8+GiWOc4Ifa
        xhMO3g0/z0JcLfbSJCs0Jn8=
X-Google-Smtp-Source: ACHHUZ5hsUKglYL9HdKxa98rpDwMxVBJ6euVbUhP3GAiR1SSeP8dKREuAP7ot86dtKPlcfhJ1SnAJQ==
X-Received: by 2002:a05:6a20:4288:b0:10c:5ff4:8bc6 with SMTP id o8-20020a056a20428800b0010c5ff48bc6mr5114685pzj.38.1685531847104;
        Wed, 31 May 2023 04:17:27 -0700 (PDT)
Received: from localhost.localdomain (111-82-252-250.emome-ip.hinet.net. [111.82.252.250])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001b0aec3ed59sm1076588plh.256.2023.05.31.04.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 04:17:26 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V4 1/4] mmc: sdhci-pci-gli: Add Genesys Logic GL9767 support
Date:   Wed, 31 May 2023 19:15:15 +0800
Message-Id: <20230531111518.396868-2-victorshihgli@gmail.com>
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

