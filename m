Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A24F678659
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjAWT26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjAWT2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:28:51 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3972ED40;
        Mon, 23 Jan 2023 11:28:49 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NG9DnR006282;
        Mon, 23 Jan 2023 11:28:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=f19bJWOwuOGAdVq6SjX4quL3G6PBHiyNNksjs48/3T8=;
 b=DyV23PcUCbKLVn/tR3Kcd8OQ7h1WWPtFRGxhVDMo0vMxvoxuSfTOJbxbk3RF0kQdx/4n
 +GtafjtgMYeCzRW1nsxTgh2CNcUE3u0/AqU5XlZE3KX6+O2+Dl4OigDhIB5NlaW3mPhf
 XvazPtD5O5Y3uhlKeqS2dQ0nAmbNlNQBR/9/eW9XQPXvRlwZd5i1JO1yfLTcpDoDIsWw
 8xeSNT6q0sH6e3rT2qkIvsflkv97RNsV9CnmHy+DLtiwpeXIlGtY+K65AYCzMT/O2IGM
 hLGZoJzL5nwZoWCsER32pi5sKuS+v7uFWozgs1783ogqCX9Bc+IJhvAJ4XYeli1jVblK Ng== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3n8gerbera-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 11:28:40 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 23 Jan
 2023 11:28:38 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 23 Jan 2023 11:28:38 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 4FA3A3F7050;
        Mon, 23 Jan 2023 11:28:38 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v2 5/5] drivers: mmc: sdhci-cadence: Add debug option for sdhci-cadence driver.
Date:   Mon, 23 Jan 2023 11:27:35 -0800
Message-ID: <20230123192735.21136-6-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230123192735.21136-1-pmalgujar@marvell.com>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NXglohanLBhp88FdfpmMZooIdL-m0u2W
X-Proofpoint-ORIG-GUID: NXglohanLBhp88FdfpmMZooIdL-m0u2W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
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
 drivers/mmc/host/sdhci-cadence.c | 104 +++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index baee0f98deac975ab92cf3e09a1edec5d3a59021..9aad7468ee9b7fe2755f343ac7ab1f5da8c63947 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -115,6 +115,10 @@
 #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_CLK_WR_DELAY		GENMASK(15, 8)
 #define	SDHCI_CDNS_SD6_PHY_DLL_SLAVE_READ_DQS_DELAY		GENMASK(7, 0)
 
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG0				0x201C
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG1				0x2020
+#define SDHCI_CDNS_SD6_PHY_DLL_OBS_REG2				0x2024
+
 #define SDHCI_CDNS_SD6_PHY_CTRL					0x2080
 #define	SDHCI_CDNS_SD6_PHY_CTRL_PHONY_DQS_TIMING		GENMASK(9, 4)
 
@@ -969,6 +973,104 @@ static void sdhci_cdns_sd6_calc_phy(struct sdhci_cdns_sd6_phy *phy)
 	}
 }
 
+#ifdef CONFIG_MMC_DEBUG
+
+#define DEBUG_DRV       pr_info
+
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
+static void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv)
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
+
+#else
+
+static inline void sdhci_cdns_sd6_dump(struct sdhci_cdns_priv *priv)
+{
+}
+
+#endif
+
 static int sdhci_cdns_sd6_get_delay_params(struct device *dev, struct sdhci_cdns_priv *priv)
 {
 	struct sdhci_cdns_sd6_phy *phy = priv->phy;
@@ -1373,6 +1475,8 @@ static void sdhci_cdns_sd6_set_clock(struct sdhci_host *host,
 		pr_debug("%s: phy init failed\n", __func__);
 
 	sdhci_set_clock(host, clock);
+
+	sdhci_cdns_sd6_dump(priv);
 }
 
 static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
-- 
2.17.1

