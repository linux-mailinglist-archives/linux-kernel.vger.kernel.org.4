Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E8C5FED9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJNLuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiJNLtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:49:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671D23E9D;
        Fri, 14 Oct 2022 04:48:34 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so4656770pfc.11;
        Fri, 14 Oct 2022 04:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFp7sZpbmzACh3dz+HyLe4tWGpY8odRoK5nBq/n0mVw=;
        b=U5HB23o63zR2lB3C/ynhcbw55a+Cyq+hLWostNhguBg3UHSOZhDMOGO0YOGFuDHtTz
         ZG34r0QO4QrQ6aA2gWgF7O74ux7Ry8pgaIo4q48qFBrPBOpIAjuLGMqmE2QBH6CaPuWR
         aNA90QFZ2kH2wmtRr3dzN5rqbZY4WvYN2D0fbO+UDAJooEGnAu1HDKyVl+cQXaDgt0U3
         U++h4ijAH7HD/AT3WMzv0Ba5AI6k6P9GOGg71IrNM5LYOelpFoUl59kRM3lq7cyoImKj
         CjR3OW4qoPD4mIZTxit1i+OEEyWz7RJSdyoGC4SSoHPz29e7AQkyOM7b6ZwqbS/8hyl8
         uo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFp7sZpbmzACh3dz+HyLe4tWGpY8odRoK5nBq/n0mVw=;
        b=tGqWJVHiFD4OG57AhdEJ+5CzjEWJXLYk/Y1kdQ0fJoE4Xsk6hIsOUVdf1zjm7naXs7
         vVOaj51Eqy6ZfUWKBbrIolhd3q1xjq9BbBW+K8yReEnbHGDDq5SCXPfVwmKETRbzk/X7
         om11jWPv0mUQzAoNYN/5o1C44xSUFp1KpUG9rPbAP9OmVPl+KQ5PkjTwbCY01aqaU9Z2
         X6O830uqxILlDaDJdi2ZZ6IQxroEEc68mM9Y9bjQPz9Luev8NTlWolaHph0w0s4ACvPe
         55TgrejEl0/IySlPuPi5vxnYGwg0Sjf0Yz26gNd4IxmaNw9MEHag8PmLD7NfrNHe/lXJ
         gQPw==
X-Gm-Message-State: ACrzQf0+lBrgvAyx2+aA34EZ5znxyWzkgda+35EF7mPNW/9tuGu46mhy
        3sgBudoahLmVms3cCK5aZa8=
X-Google-Smtp-Source: AMsMyM7aGUHX1Hw/hZnwIhe/XseQ9V4LTRKrN1Jaq0HRaIGq85SOSP8uW9cyxwm42ZAmGMaFSzHPdQ==
X-Received: by 2002:a63:235c:0:b0:459:5fef:88ab with SMTP id u28-20020a63235c000000b004595fef88abmr4332013pgm.312.1665748107822;
        Fri, 14 Oct 2022 04:48:27 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e282-2aaa-c1aa-06c8-0e68-c5ee.emome-ip6.hinet.net. [2001:b400:e282:2aaa:c1aa:6c8:e68:c5ee])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902ec8800b001746f66244asm1606678plg.18.2022.10.14.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:48:27 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
X-Google-Original-From: Victor Shih <victor.shih@genesyslogic.com.tw>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V5 26/26] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
Date:   Fri, 14 Oct 2022 19:46:01 +0800
Message-Id: <20221014114601.15594-27-victor.shih@genesyslogic.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
References: <20221014114601.15594-1-victor.shih@genesyslogic.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes are:
* Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
* Enable the internal clock when do reset on UHS-II mode.
* Set ZC to 0x0 for Sandisk cards and set ZC to 0xB for others.
* Increase timeout value before detecting UHS-II interface.
* Add vendor settings fro UHS-II mode.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/sdhci-pci-gli.c | 318 ++++++++++++++++++++++++++++++-
 2 files changed, 318 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d89e7bf91c35..28a686610607 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -102,6 +102,7 @@ config MMC_SDHCI_PCI
 	tristate "SDHCI support on PCI bus"
 	depends on MMC_SDHCI && PCI
 	select MMC_CQHCI
+	select MMC_SDHCI_UHS2
 	select IOSF_MBI if X86
 	select MMC_SDHCI_IO_ACCESSORS
 	help
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 607cf69f45d0..e909d33af7ab 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -17,6 +17,7 @@
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "cqhci.h"
+#include "sdhci-uhs2.h"
 
 /*  Genesys Logic extra registers */
 #define SDHCI_GLI_9750_WT         0x800
@@ -79,6 +80,42 @@
 #define   SDHCI_GLI_9750_TUNING_PARAMETERS_RX_DLY    GENMASK(2, 0)
 #define   GLI_9750_TUNING_PARAMETERS_RX_DLY_VALUE    0x1
 
+#define PCI_GLI_9755_WT       0x800
+#define   PCI_GLI_9755_WT_EN    BIT(0)
+#define   GLI_9755_WT_EN_ON	0x1
+#define   GLI_9755_WT_EN_OFF    0x0
+
+#define PCI_GLI_9755_PLLSSC                 0x68
+#define   PCI_GLI_9755_PLLSSC_RTL             BIT(24)
+#define   GLI_9755_PLLSSC_RTL_VALUE           0x1
+#define   PCI_GLI_9755_PLLSSC_TRANS_PASS      BIT(27)
+#define   GLI_9755_PLLSSC_TRANS_PASS_VALUE    0x1
+#define   PCI_GLI_9755_PLLSSC_RECV            GENMASK(29, 28)
+#define   GLI_9755_PLLSSC_RECV_VALUE          0x3
+#define   PCI_GLI_9755_PLLSSC_TRAN            GENMASK(31, 30)
+#define   GLI_9755_PLLSSC_TRAN_VALUE          0x3
+
+#define PCI_GLI_9755_UHS2_PLL            0x6C
+#define   PCI_GLI_9755_UHS2_PLL_SSC        GENMASK(9, 8)
+#define   GLI_9755_UHS2_PLL_SSC_VALUE      0x0
+#define   PCI_GLI_9755_UHS2_PLL_DELAY      BIT(18)
+#define   GLI_9755_UHS2_PLL_DELAY_VALUE    0x1
+#define   PCI_GLI_9755_UHS2_PLL_PDRST      BIT(27)
+#define   GLI_9755_UHS2_PLL_PDRST_VALUE    0x1
+
+#define PCI_GLI_9755_UHS2_SERDES	    0x70
+#define   PCI_GLI_9755_UHS2_SERDES_INTR       GENMASK(2, 0)
+#define   GLI_9755_UHS2_SERDES_INTR_VALUE     0x3
+#define   PCI_GLI_9755_UHS2_SERDES_ZC1        BIT(3)
+#define   GLI_9755_UHS2_SERDES_ZC1_VALUE      0x0
+#define   PCI_GLI_9755_UHS2_SERDES_ZC2        GENMASK(7, 4)
+#define   GLI_9755_UHS2_SERDES_ZC2_DEFAULT    0xB
+#define   GLI_9755_UHS2_SERDES_ZC2_SANDISK    0x0
+#define   PCI_GLI_9755_UHS2_SERDES_TRAN       GENMASK(27, 24)
+#define   GLI_9755_UHS2_SERDES_TRAN_VALUE     0xC
+#define   PCI_GLI_9755_UHS2_SERDES_RECV       GENMASK(31, 28)
+#define   GLI_9755_UHS2_SERDES_RECV_VALUE     0xF
+
 #define SDHCI_GLI_9763E_CTRL_HS400  0x7
 
 #define SDHCI_GLI_9763E_HS400_ES_REG      0x52C
@@ -692,6 +729,276 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	gl9755_wt_off(pdev);
 }
 
+static void gl9755_vendor_init(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 serdes;
+	u32 pllssc;
+	u32 uhs2_pll;
+
+	gl9755_wt_on(pdev);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, &serdes);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_TRAN;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_TRAN,
+			     GLI_9755_UHS2_SERDES_TRAN_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_RECV;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_RECV,
+			     GLI_9755_UHS2_SERDES_RECV_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_INTR;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_INTR,
+			     GLI_9755_UHS2_SERDES_INTR_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC1;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
+			     GLI_9755_UHS2_SERDES_ZC1_VALUE);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC2;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
+			     GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
+	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, serdes);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, &uhs2_pll);
+	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_SSC;
+	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_SSC,
+			  GLI_9755_UHS2_PLL_SSC_VALUE);
+	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_DELAY;
+	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_DELAY,
+			  GLI_9755_UHS2_PLL_DELAY_VALUE);
+	uhs2_pll &= ~PCI_GLI_9755_UHS2_PLL_PDRST;
+	uhs2_pll |= FIELD_PREP(PCI_GLI_9755_UHS2_PLL_PDRST,
+			  GLI_9755_UHS2_PLL_PDRST_VALUE);
+	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_PLL, uhs2_pll);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_PLLSSC, &pllssc);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_RTL;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_RTL,
+			  GLI_9755_PLLSSC_RTL_VALUE);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_TRANS_PASS;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_TRANS_PASS,
+			  GLI_9755_PLLSSC_TRANS_PASS_VALUE);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_RECV;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_RECV,
+			  GLI_9755_PLLSSC_RECV_VALUE);
+	pllssc &= ~PCI_GLI_9755_PLLSSC_TRAN;
+	pllssc |= FIELD_PREP(PCI_GLI_9755_PLLSSC_TRAN,
+			  GLI_9755_PLLSSC_TRAN_VALUE);
+	pci_write_config_dword(pdev, PCI_GLI_9755_PLLSSC, pllssc);
+
+	gl9755_wt_off(pdev);
+}
+
+static void gl9755_pre_detect_init(struct sdhci_host *host)
+{
+	/* GL9755 need more time on UHS2 detect flow */
+	sdhci_writeb(host, 0xA7, SDHCI_UHS2_TIMER_CTRL);
+}
+
+static void gl9755_post_attach_sd(struct sdhci_host *host)
+{
+	struct pci_dev *pdev;
+	struct sdhci_pci_chip *chip;
+	struct sdhci_pci_slot *slot;
+	u32 serdes;
+
+	slot = sdhci_priv(host);
+	chip = slot->chip;
+	pdev = chip->pdev;
+
+	gl9755_wt_on(pdev);
+
+	pci_read_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, &serdes);
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC1;
+	serdes &= ~PCI_GLI_9755_UHS2_SERDES_ZC2;
+	serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC1,
+			     GLI_9755_UHS2_SERDES_ZC1_VALUE);
+
+	/* the manfid of sandisk card is 0x3 */
+	if (host->mmc->card->cid.manfid == 0x3)
+		serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
+				     GLI_9755_UHS2_SERDES_ZC2_SANDISK);
+	else
+		serdes |= FIELD_PREP(PCI_GLI_9755_UHS2_SERDES_ZC2,
+				     GLI_9755_UHS2_SERDES_ZC2_DEFAULT);
+
+	pci_write_config_dword(pdev, PCI_GLI_9755_UHS2_SERDES, serdes);
+
+	gl9755_wt_off(pdev);
+}
+
+static void gl9755_overcurrent_event_enable(struct sdhci_host *host,
+					    bool enable)
+{
+	u32 mask;
+
+	mask = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
+	if (enable)
+		mask |= SDHCI_INT_BUS_POWER;
+	else
+		mask &= ~SDHCI_INT_BUS_POWER;
+
+	sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
+
+	mask = sdhci_readl(host, SDHCI_INT_ENABLE);
+	if (enable)
+		mask |= SDHCI_INT_BUS_POWER;
+	else
+		mask &= ~SDHCI_INT_BUS_POWER;
+
+	sdhci_writel(host, mask, SDHCI_INT_ENABLE);
+}
+
+static void gl9755_set_power(struct sdhci_host *host, unsigned char mode,
+			     unsigned short vdd)
+{
+	u8 pwr = 0;
+
+	if (mode != MMC_POWER_OFF) {
+		switch (1 << vdd) {
+		case MMC_VDD_165_195:
+		/*
+		 * Without a regulator, SDHCI does not support 2.0v
+		 * so we only get here if the driver deliberately
+		 * added the 2.0v range to ocr_avail. Map it to 1.8v
+		 * for the purpose of turning on the power.
+		 */
+		case MMC_VDD_20_21:
+			pwr = SDHCI_POWER_180;
+			break;
+		case MMC_VDD_29_30:
+		case MMC_VDD_30_31:
+			pwr = SDHCI_POWER_300;
+			break;
+		case MMC_VDD_32_33:
+		case MMC_VDD_33_34:
+			pwr = SDHCI_POWER_330;
+			break;
+		default:
+			WARN(1, "%s: Invalid vdd %#x\n",
+			     mmc_hostname(host->mmc), vdd);
+			break;
+		}
+
+		pwr |= SDHCI_VDD2_POWER_180;
+	}
+
+	if (host->pwr == pwr)
+		return;
+
+	host->pwr = pwr;
+
+	if (pwr == 0) {
+		gl9755_overcurrent_event_enable(host, false);
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+	} else {
+		gl9755_overcurrent_event_enable(host, false);
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+
+		pwr |= (SDHCI_POWER_ON | SDHCI_VDD2_POWER_ON);
+
+		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
+		/* wait stable */
+		mdelay(5);
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+		/* wait stable */
+		mdelay(5);
+		gl9755_overcurrent_event_enable(host, true);
+	}
+}
+
+static bool sdhci_wait_clock_stable(struct sdhci_host *host)
+{
+	u16 clk = 0;
+	ktime_t timeout;
+
+	/* Wait max 20 ms */
+	timeout = ktime_add_ms(ktime_get(), 20);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_INT_STABLE)
+			break;
+		if (timedout) {
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			return false;
+		}
+		udelay(10);
+	}
+	return true;
+}
+
+static void gl9755_uhs2_reset_sd_tran(struct sdhci_host *host)
+{
+	/* do this on UHS2 mode */
+	if (host->mmc->flags & MMC_UHS2_INITIALIZED) {
+		sdhci_uhs2_reset(host, SDHCI_UHS2_SW_RESET_SD);
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+		sdhci_uhs2_clear_set_irqs(host,
+					  SDHCI_INT_ALL_MASK,
+					  SDHCI_UHS2_ERR_INT_STATUS_MASK);
+	}
+}
+
+static void sdhci_gl9755_reset(struct sdhci_host *host, u8 mask)
+{
+	ktime_t timeout;
+	u16 ctrl2;
+	u16 clk_ctrl;
+
+	/* need internal clock */
+	if (mask & SDHCI_RESET_ALL) {
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		clk_ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+		if ((ctrl2 & SDHCI_CTRL_V4_MODE) &&
+		    (ctrl2 & SDHCI_CTRL_UHS2_INTERFACE_EN)) {
+			sdhci_writew(host,
+				     SDHCI_CLOCK_INT_EN,
+				     SDHCI_CLOCK_CONTROL);
+		} else {
+			sdhci_writew(host,
+				     SDHCI_CLOCK_INT_EN,
+				     SDHCI_CLOCK_CONTROL);
+			sdhci_wait_clock_stable(host);
+			sdhci_writew(host,
+				     SDHCI_CTRL_V4_MODE,
+				     SDHCI_HOST_CONTROL2);
+		}
+	}
+
+	sdhci_writeb(host, mask, SDHCI_SOFTWARE_RESET);
+
+	/* reset sd-tran on UHS2 mode if need to reset cmd/data */
+	if ((mask & SDHCI_RESET_CMD) | (mask & SDHCI_RESET_DATA))
+		gl9755_uhs2_reset_sd_tran(host);
+
+	if (mask & SDHCI_RESET_ALL)
+		host->clock = 0;
+
+	/* Wait max 100 ms */
+	timeout = ktime_add_ms(ktime_get(), 100);
+
+	/* hw clears the bit when it's done */
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		if (!(sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask))
+			break;
+		if (timedout) {
+			pr_err("%s: Reset 0x%x never completed.\n",
+			       mmc_hostname(host->mmc), (int)mask);
+			sdhci_dumpregs(host);
+			/* manual clear */
+			sdhci_writeb(host, 0, SDHCI_SOFTWARE_RESET);
+			return;
+		}
+		udelay(10);
+	}
+}
+
 static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_host *host = slot->host;
@@ -700,6 +1007,7 @@ static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
 	sdhci_enable_v4_mode(host);
+	gl9755_vendor_init(host);
 
 	return 0;
 }
@@ -1092,18 +1400,26 @@ static const struct sdhci_ops sdhci_gl9755_ops = {
 	.read_w			= sdhci_gli_readw,
 	.read_b			= sdhci_gli_readb,
 	.set_clock		= sdhci_gl9755_set_clock,
+	.set_power      = gl9755_set_power,
 	.enable_dma		= sdhci_pci_enable_dma,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_gl9755_reset,
 	.set_uhs_signaling	= sdhci_set_uhs_signaling,
 	.voltage_switch		= sdhci_gli_voltage_switch,
 	.uhs2_reset		= sdhci_uhs2_reset,
+	.dump_uhs2_regs	= sdhci_uhs2_dump_regs,
+	.set_timeout	= sdhci_uhs2_set_timeout,
+	.irq			= sdhci_uhs2_irq,
+	.uhs2_pre_detect_init   = gl9755_pre_detect_init,
+	.uhs2_post_attach_sd    = gl9755_post_attach_sd,
 };
 
 const struct sdhci_pci_fixes sdhci_gl9755 = {
 	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
 	.probe_slot	= gli_probe_slot_gl9755,
+	.add_host	= sdhci_pci_uhs2_add_host,
+	.remove_host	= sdhci_pci_uhs2_remove_host,
 	.ops            = &sdhci_gl9755_ops,
 #ifdef CONFIG_PM_SLEEP
 	.resume         = sdhci_pci_gli_resume,
-- 
2.25.1

