Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0242D650D42
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiLSO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiLSO0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:26:02 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97041C3B;
        Mon, 19 Dec 2022 06:25:44 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJAR3YQ006554;
        Mon, 19 Dec 2022 06:25:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=KuP8NpPDBWhX77mKMbWAKTy7A4aer4UO3cZcZzz+FLU=;
 b=SN0lfiHEUZ1M7mOG7IDIY1lkZT1uGsi+3RoV8IarSeAh4exaWOTdq6LpnExjAx1s1zDz
 vqwXKSNjGcBmT6wpMM5b04kKAdH9ER+Y2AC3F+1evCqbmd5D0iY55HZxJYS96yDz2tpE
 DVLSfHqT4BO2XVw1b8ow7RTRYZpj7IjlJ/3h+eKPkBD8NK8nj3cRsnO0zwgxh7qehu9P
 8r8W5n8lmYqXQ7w/1xZX3BFOu5jK1x1Ng6p/QicduqoJRiUMLioR9StQG3gv5TatbkVw
 WA031U6DfBrbRb+Rni0ipeh0DmPbWeC4Om31FJs9W64F/V6yrbwCQoh9ScsXYZ+OMbYL Fw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3mjnans1vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 06:25:40 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Dec
 2022 06:25:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 19 Dec 2022 06:25:38 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 7EAAA3F7087;
        Mon, 19 Dec 2022 06:25:38 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH 5/5] drivers: mmc: sdhci-cadence: Add debug option for sdhci-cadence driver.
Date:   Mon, 19 Dec 2022 06:24:18 -0800
Message-ID: <20221219142418.27949-6-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221219142418.27949-1-pmalgujar@marvell.com>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Bv0OsHvksL4ZF-SD5XvkkIIi0a8xDo6j
X-Proofpoint-ORIG-GUID: Bv0OsHvksL4ZF-SD5XvkkIIi0a8xDo6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jayanthi Annadurai <jannadurai@marvell.com>

Use Kernel config CONFIG_MMC_DEBUG to support dumping PHY and host
controller register configuration for debug.

Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 100 +++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6bf703f15bc5be7e3be4cb1144b78ec3585ec540..75363aabce9228755c4abed08fe17e57d1a44b23 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -15,6 +15,10 @@
 
 #include "sdhci-pltfm.h"
 
+#ifdef CONFIG_MMC_DEBUG
+#define DEBUG_DRV	pr_info
+#endif
+
 #define SDMCLK_MAX_FREQ		200000000
 
 #define DEFAULT_CMD_DELAY		16
@@ -115,6 +119,10 @@
 #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
 #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
 
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0				0x201C
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1				0x2020
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2				0x2024
+
 #define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
 #define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
 
@@ -969,6 +977,94 @@ static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
 	}
 }
 
+#ifdef CONFIG_MMC_DEBUG
+static void sdhci_cdns_sd6_phy_dump(struct sdhci_cdns_sd6_phy *phy)
+{
+	DEBUG_DRV("PHY Timings\n");
+	DEBUG_DRV("mode %d t_sdclk %d\n", phy->mode, phy->t_sdclk);
+
+	DEBUG_DRV("cp_clk_wr_delay %d\n", phy->settings.cp_clk_wr_delay);
+	DEBUG_DRV("cp_clk_wrdqs_delay %d\n", phy->settings.cp_clk_wrdqs_delay);
+	DEBUG_DRV("cp_data_select_oe_end %d\n", phy->settings.cp_data_select_oe_end);
+	DEBUG_DRV("cp_dll_bypass_mode %d\n", phy->settings.cp_dll_bypass_mode);
+	DEBUG_DRV("cp_dll_locked_mode %d\n", phy->settings.cp_dll_locked_mode);
+	DEBUG_DRV("cp_dll_start_point %d\n", phy->settings.cp_dll_start_point);
+	DEBUG_DRV("cp_io_mask_always_on %d\n", phy->settings.cp_io_mask_always_on);
+	DEBUG_DRV("cp_io_mask_end %d\n", phy->settings.cp_io_mask_end);
+	DEBUG_DRV("cp_io_mask_start %d\n", phy->settings.cp_io_mask_start);
+	DEBUG_DRV("cp_rd_del_sel %d\n", phy->settings.cp_rd_del_sel);
+	DEBUG_DRV("cp_read_dqs_cmd_delay %d\n", phy->settings.cp_read_dqs_cmd_delay);
+	DEBUG_DRV("cp_read_dqs_delay %d\n", phy->settings.cp_read_dqs_delay);
+	DEBUG_DRV("cp_sw_half_cycle_shift %d\n", phy->settings.cp_sw_half_cycle_shift);
+	DEBUG_DRV("cp_sync_method %d\n", phy->settings.cp_sync_method);
+	DEBUG_DRV("cp_use_ext_lpbk_dqs %d\n", phy->settings.cp_use_ext_lpbk_dqs);
+	DEBUG_DRV("cp_use_lpbk_dqs %d\n", phy->settings.cp_use_lpbk_dqs);
+	DEBUG_DRV("cp_use_phony_dqs %d\n", phy->settings.cp_use_phony_dqs);
+	DEBUG_DRV("cp_use_phony_dqs_cmd %d\n", phy->settings.cp_use_phony_dqs_cmd);
+	DEBUG_DRV("sdhc_extended_rd_mode %d\n", phy->settings.sdhc_extended_rd_mode);
+	DEBUG_DRV("sdhc_extended_wr_mode %d\n", phy->settings.sdhc_extended_wr_mode);
+
+	DEBUG_DRV("sdhc_hcsdclkadj %d\n", phy->settings.sdhc_hcsdclkadj);
+	DEBUG_DRV("sdhc_idelay_val %d\n", phy->settings.sdhc_idelay_val);
+	DEBUG_DRV("sdhc_rdcmd_en %d\n", phy->settings.sdhc_rdcmd_en);
+	DEBUG_DRV("sdhc_rddata_en %d\n", phy->settings.sdhc_rddata_en);
+	DEBUG_DRV("sdhc_rw_compensate %d\n", phy->settings.sdhc_rw_compensate);
+	DEBUG_DRV("sdhc_sdcfsh %d\n", phy->settings.sdhc_sdcfsh);
+	DEBUG_DRV("sdhc_sdcfsl %d\n", phy->settings.sdhc_sdcfsl);
+	DEBUG_DRV("sdhc_wrcmd0_dly %d %d\n",
+		  phy->settings.sdhc_wrcmd0_dly, phy->settings.sdhc_wrcmd0_sdclk_dly);
+	DEBUG_DRV("sdhc_wrcmd1_dly %d %d\n",
+		  phy->settings.sdhc_wrcmd1_dly, phy->settings.sdhc_wrcmd1_sdclk_dly);
+	DEBUG_DRV("sdhc_wrdata0_dly %d %d\n",
+		  phy->settings.sdhc_wrdata0_dly, phy->settings.sdhc_wrdata0_sdclk_dly);
+
+	DEBUG_DRV("sdhc_wrdata1_dly %d %d\n",
+		  phy->settings.sdhc_wrdata1_dly, phy->settings.sdhc_wrdata1_sdclk_dly);
+	DEBUG_DRV("hs200_tune_val %d\n", phy->settings.hs200_tune_val);
+}
+
+void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv)
+{
+	struct sdhci_cdns_sd6_phy *phy = priv->phy;
+	int id;
+
+	sdhci_cdns_sd6_phy_dump(phy);
+
+	DEBUG_DRV("Host controller Register Dump\n");
+	for (id = 0; id < 14; id++)
+		DEBUG_DRV("HRS%d 0x%x\n", id, readl(priv->hrs_addr + (id * 4)));
+
+	id = 29;
+	DEBUG_DRV("HRS%d 0x%x\n", id, readl(priv->hrs_addr + (id * 4)));
+	id = 30;
+	DEBUG_DRV("HRS%d 0x%x\n", id, readl(priv->hrs_addr + (id * 4)));
+
+	for (id = 0; id < 27; id++)
+		DEBUG_DRV("SRS%d 0x%x\n", id, readl(priv->hrs_addr + 0x200 + (id * 4)));
+
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DQS_TIMING 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQS_TIMING));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_GATE_LPBK 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GATE_LPBK));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_MASTER 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_MASTER));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_SLAVE 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_SLAVE));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_CTRL 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_CTRL));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_GPIO_CTRL0 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_GPIO_CTRL0));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DQ_TIMING 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DQ_TIMING));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1));
+	DEBUG_DRV("SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2 0x%x\n",
+		  sdhci_cdns_sd6_read_phy_reg(priv, SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2));
+}
+#endif
+
 static int sdhci_cdns_sd6_get_delay_params(struct device *dev, struct sdhci_cdns_priv *priv)
 {
 	struct sdhci_cdns_sd6_phy *phy = priv->phy;
@@ -1373,6 +1469,10 @@ static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
 		pr_debug("%s: phy init failed\n", __func__);
 
 	sdhci_set_clock(host, clock);
+
+#ifdef CONFIG_MMC_DEBUG
+	sdhci_cdns_sd6_dump(priv);
+#endif
 }
 
 static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
-- 
2.17.1

