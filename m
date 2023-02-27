Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D66A49C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjB0Sce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjB0Scb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:32:31 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E65233D9;
        Mon, 27 Feb 2023 10:32:26 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RCtrGg024141;
        Mon, 27 Feb 2023 10:32:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=RHzj6uyWx8SH0FRtFBz8mmCK+chcvMg5DLn8MtS4kKU=;
 b=W9RbYZjuC0/jRUVoBqNWtfxhk5wG8xPhrzD9VJgbiuqPTwZ9MWcz1nYx6qeYJOj5hUoP
 hIMSX4aTkTJZt1/O4r7E2xEC6+JjQbKkKXqqUcyq+5cM3+IneQo0DI3CbqyW7I3adxDj
 3Kg9ISS5rEmymjrsmIEY69InmmK0QMItj/lHzzJpBGI2m6+qXcdGI83jaNi6J1U4hKnV
 ZSIRoVwKzqjcv6JRMbHvsfCdYAwGEd041YlbRr9OvtF8TFvywhGP7PCRMLFjItgMbKh+
 0/KSnE/6Y9OO15ugp0anWvcj3DXJj7GPm09tXy1pHNpxYb3jS3J4kjJbAxbeATkDJRcV jg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nyjqtsbk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:32:16 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 10:32:13 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 27 Feb 2023 10:32:13 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 79B213F7059;
        Mon, 27 Feb 2023 10:32:13 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Dhananjay Kangude <dkangude@cadence.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v3 1/6] mmc: sdhci-cadence: Rename functions to SD4 specific
Date:   Mon, 27 Feb 2023 10:31:46 -0800
Message-ID: <20230227183151.27912-2-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227183151.27912-1-pmalgujar@marvell.com>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: N1GlcsgcbJPSjiybBQGV-qOefFf3X9EB
X-Proofpoint-GUID: N1GlcsgcbJPSjiybBQGV-qOefFf3X9EB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_15,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dhananjay Kangude <dkangude@cadence.com>

Renaming the functions and structures specific to SD4 so
that it can be separated from upcoming SD6 related
functionality.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 96 ++++++++++++++++----------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a598773879bf339aae8450f63e1251509..5276cdbc652f7faac13bb0244af4926b63dc119a 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -15,16 +15,16 @@
 
 #include "sdhci-pltfm.h"
 
-/* HRS - Host Register Set (specific to Cadence) */
-#define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
-#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
-#define   SDHCI_CDNS_HRS04_RD			BIT(25)
-#define   SDHCI_CDNS_HRS04_WR			BIT(24)
-#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
-#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
-#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
-
-#define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
+/* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */
+#define SDHCI_CDNS_HRS04			0x10	/* PHY access port */
+#define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
+#define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
+#define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
+#define SDHCI_CDNS_SD4_HRS04_RDATA		GENMASK(23, 16)
+#define SDHCI_CDNS_SD4_HRS04_WDATA		GENMASK(15, 8)
+#define SDHCI_CDNS_SD4_HRS04_ADDR		GENMASK(5, 0)
+
+#define SDHCI_CDNS_HRS06			0x18	/* eMMC control */
 #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
 #define   SDHCI_CDNS_HRS06_TUNE			GENMASK(13, 8)
 #define   SDHCI_CDNS_HRS06_MODE			GENMASK(2, 0)
@@ -38,7 +38,7 @@
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
 
-/* PHY */
+/* PHY registers for SD4 controller */
 #define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
 #define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
 #define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
@@ -59,7 +59,7 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
-struct sdhci_cdns_phy_param {
+struct sdhci_cdns_sd4_phy_param {
 	u8 addr;
 	u8 data;
 };
@@ -68,15 +68,15 @@ struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
 	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[];
+	struct sdhci_cdns_sd4_phy_param phy_params[];
 };
 
-struct sdhci_cdns_phy_cfg {
+struct sdhci_cdns_sd4_phy_cfg {
 	const char *property;
 	u8 addr;
 };
 
-static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
+static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
 	{ "cdns,phy-input-delay-sd-uhs-sdr12", SDHCI_CDNS_PHY_DLY_UHS_SDR12, },
@@ -90,76 +90,76 @@ static const struct sdhci_cdns_phy_cfg sdhci_cdns_phy_cfgs[] = {
 	{ "cdns,phy-dll-delay-strobe", SDHCI_CDNS_PHY_DLY_STROBE, },
 };
 
-static int sdhci_cdns_write_phy_reg(struct sdhci_cdns_priv *priv,
-				    u8 addr, u8 data)
+static int sdhci_cdns_sd4_write_phy_reg(struct sdhci_cdns_priv *priv,
+					u8 addr, u8 data)
 {
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS04;
 	u32 tmp;
 	int ret;
 
-	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
 				 0, 10);
 	if (ret)
 		return ret;
 
-	tmp = FIELD_PREP(SDHCI_CDNS_HRS04_WDATA, data) |
-	      FIELD_PREP(SDHCI_CDNS_HRS04_ADDR, addr);
+	tmp = FIELD_PREP(SDHCI_CDNS_SD4_HRS04_WDATA, data) |
+	      FIELD_PREP(SDHCI_CDNS_SD4_HRS04_ADDR, addr);
 	writel(tmp, reg);
 
-	tmp |= SDHCI_CDNS_HRS04_WR;
+	tmp |= SDHCI_CDNS_SD4_HRS04_WR;
 	writel(tmp, reg);
 
-	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_HRS04_ACK, 0, 10);
+	ret = readl_poll_timeout(reg, tmp, tmp & SDHCI_CDNS_SD4_HRS04_ACK, 0, 10);
 	if (ret)
 		return ret;
 
-	tmp &= ~SDHCI_CDNS_HRS04_WR;
+	tmp &= ~SDHCI_CDNS_SD4_HRS04_WR;
 	writel(tmp, reg);
 
-	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_HRS04_ACK),
+	ret = readl_poll_timeout(reg, tmp, !(tmp & SDHCI_CDNS_SD4_HRS04_ACK),
 				 0, 10);
 
 	return ret;
 }
 
-static unsigned int sdhci_cdns_phy_param_count(struct device_node *np)
+static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
 {
 	unsigned int count = 0;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++)
-		if (of_property_read_bool(np, sdhci_cdns_phy_cfgs[i].property))
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++)
+		if (of_property_read_bool(np, sdhci_cdns_sd4_phy_cfgs[i].property))
 			count++;
 
 	return count;
 }
 
-static void sdhci_cdns_phy_param_parse(struct device_node *np,
-				       struct sdhci_cdns_priv *priv)
+static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
+					   struct sdhci_cdns_priv *priv)
 {
-	struct sdhci_cdns_phy_param *p = priv->phy_params;
+	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
 	u32 val;
 	int ret, i;
 
-	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_phy_cfgs); i++) {
-		ret = of_property_read_u32(np, sdhci_cdns_phy_cfgs[i].property,
+	for (i = 0; i < ARRAY_SIZE(sdhci_cdns_sd4_phy_cfgs); i++) {
+		ret = of_property_read_u32(np, sdhci_cdns_sd4_phy_cfgs[i].property,
 					   &val);
 		if (ret)
 			continue;
 
-		p->addr = sdhci_cdns_phy_cfgs[i].addr;
+		p->addr = sdhci_cdns_sd4_phy_cfgs[i].addr;
 		p->data = val;
 		p++;
 	}
 }
 
-static int sdhci_cdns_phy_init(struct sdhci_cdns_priv *priv)
+static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
 
 	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns_write_phy_reg(priv, priv->phy_params[i].addr,
-					       priv->phy_params[i].data);
+		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
+						   priv->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -202,7 +202,7 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
 }
 
-static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
+static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
 	void __iomem *reg = priv->hrs_addr + SDHCI_CDNS_HRS06;
@@ -255,7 +255,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return 0;
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
-		if (sdhci_cdns_set_tune_val(host, i) ||
+		if (sdhci_cdns_sd4_set_tune_val(host, i) ||
 		    mmc_send_tuning(host->mmc, opcode, NULL)) { /* bad */
 			cur_streak = 0;
 		} else { /* good */
@@ -272,7 +272,7 @@ static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	return sdhci_cdns_sd4_set_tune_val(host, end_of_streak - max_streak / 2);
 }
 
 static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
@@ -309,7 +309,7 @@ static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
 		sdhci_set_uhs_signaling(host, timing);
 }
 
-static const struct sdhci_ops sdhci_cdns_ops = {
+static const struct sdhci_ops sdhci_cdns_sd4_ops = {
 	.set_clock = sdhci_set_clock,
 	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -319,12 +319,12 @@ static const struct sdhci_ops sdhci_cdns_ops = {
 };
 
 static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+	.ops = &sdhci_cdns_sd4_ops,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
+static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
+	.ops = &sdhci_cdns_sd4_ops,
 };
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
@@ -369,9 +369,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 
 	data = of_device_get_match_data(dev);
 	if (!data)
-		data = &sdhci_cdns_pltfm_data;
+		data = &sdhci_cdns_sd4_pltfm_data;
 
-	nr_phy_params = sdhci_cdns_phy_param_count(dev->of_node);
+	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
 	host = sdhci_pltfm_init(pdev, data,
 				struct_size(priv, phy_params, nr_phy_params));
 	if (IS_ERR(host)) {
@@ -398,9 +398,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	sdhci_cdns_phy_param_parse(dev->of_node, priv);
+	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns_sd4_phy_init(priv);
 	if (ret)
 		goto free;
 
@@ -429,7 +429,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_phy_init(priv);
+	ret = sdhci_cdns_sd4_phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
-- 
2.17.1

