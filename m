Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087456A49CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjB0Scr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjB0Scf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:32:35 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8599E1ABF3;
        Mon, 27 Feb 2023 10:32:33 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RESxPG010097;
        Mon, 27 Feb 2023 10:32:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=jDbE8v3rf+RJ+BclwtUNkLvJ/wtCjWMqhoplcULcO0o=;
 b=NqrrjiUInnntA5wh+nasg+UdVDSrmEOgVCbgKMhtOgoAuq0+ft4JhJWHg890mN/+JIw0
 uxlKV+LUR25aMuyy5spmswuLT0ucmq2dqDSPmLITFdyu7ByU3pETFOWw9whr1IT4FLBI
 doh4hfhs0B+Vs8UTKgHbwZsGyqbTJwCzQOQHQ2SSj2myjwxKcz6GxT9WFgUPKftUKgub
 H7azbEgZ6AdmR0vAjoNwVdhGMDb8TTUbGY75J58qKKqhVDWZA1c9tHRqyP4/UFXsmRRi
 SOw0YBdBm7hMc9H45FfhUpzRYmLP85qhj29aG7TwC/P+gQ8MI1KGBq+T9U4PWXeDAnDa 1w== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3nyjqtsbks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 10:32:25 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 27 Feb
 2023 10:32:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Mon, 27 Feb 2023 10:32:23 -0800
Received: from localhost.localdomain (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 29D113F7040;
        Mon, 27 Feb 2023 10:32:23 -0800 (PST)
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>
CC:     <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Dhananjay Kangude <dkangude@cadence.com>,
        Piyush Malgujar <pmalgujar@marvell.com>
Subject: [PATCH v3 2/6] mmc: sdhci-cadence: Restructure the code
Date:   Mon, 27 Feb 2023 10:31:47 -0800
Message-ID: <20230227183151.27912-3-pmalgujar@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227183151.27912-1-pmalgujar@marvell.com>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nynrHgX2lKnOQBJDpjbL5pGaYIwzAdQe
X-Proofpoint-GUID: nynrHgX2lKnOQBJDpjbL5pGaYIwzAdQe
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

Restructured the code, added new structures and functions for
SD4 operations. Also this adds some abstraction to the code
which will make it modular and adaptable for further SD6 operations.

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
---
 drivers/mmc/host/sdhci-cadence.c | 100 ++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 5276cdbc652f7faac13bb0244af4926b63dc119a..4f7e63c90e3d68da338b8964f08b7c65ebaf1ffd 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -59,16 +59,28 @@
  */
 #define SDHCI_CDNS_MAX_TUNING_LOOP	40
 
+struct sdhci_cdns_priv;
+
 struct sdhci_cdns_sd4_phy_param {
 	u8 addr;
 	u8 data;
 };
 
+struct sdhci_cdns_data {
+	int (*phy_init)(struct sdhci_cdns_priv *priv);
+	int (*set_tune_val)(struct sdhci_host *host, unsigned int val);
+};
+
+struct sdhci_cdns_sd4_phy {
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_sd4_phy_param phy_params[];
+};
+
 struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
-	unsigned int nr_phy_params;
-	struct sdhci_cdns_sd4_phy_param phy_params[];
+	const struct sdhci_cdns_data *cdns_data;
+	void *phy;
 };
 
 struct sdhci_cdns_sd4_phy_cfg {
@@ -76,6 +88,13 @@ struct sdhci_cdns_sd4_phy_cfg {
 	u8 addr;
 };
 
+struct sdhci_cdns_of_data {
+	const struct sdhci_pltfm_data *pltfm_data;
+	const struct sdhci_cdns_data *cdns_data;
+	int (*phy_probe)(struct platform_device *pdev,
+			 struct sdhci_cdns_priv *priv);
+};
+
 static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
 	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
 	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
@@ -135,9 +154,9 @@ static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
 }
 
 static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
-					   struct sdhci_cdns_priv *priv)
+					   struct sdhci_cdns_sd4_phy *phy)
 {
-	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
+	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
 	u32 val;
 	int ret, i;
 
@@ -156,10 +175,11 @@ static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
 static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
 {
 	int ret, i;
+	struct sdhci_cdns_sd4_phy *phy = priv->phy;
 
-	for (i = 0; i < priv->nr_phy_params; i++) {
-		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
-						   priv->phy_params[i].data);
+	for (i = 0; i < phy->nr_phy_params; i++) {
+		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
+						   phy->phy_params[i].data);
 		if (ret)
 			return ret;
 	}
@@ -202,6 +222,27 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
 }
 
+static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
+				    struct sdhci_cdns_priv *priv)
+{
+	unsigned int nr_phy_params;
+	struct sdhci_cdns_sd4_phy *phy;
+	struct device *dev = &pdev->dev;
+
+	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
+	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
+			   GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->nr_phy_params = nr_phy_params;
+
+	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
+	priv->phy = phy;
+
+	return 0;
+}
+
 static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
@@ -323,10 +364,25 @@ static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
+static const struct sdhci_cdns_of_data sdhci_cdns_uniphier_of_data = {
+	.pltfm_data = &sdhci_cdns_uniphier_pltfm_data,
+};
+
 static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
 	.ops = &sdhci_cdns_sd4_ops,
 };
 
+static const struct sdhci_cdns_data sdhci_cdns_sd4_data = {
+	.phy_init = sdhci_cdns_sd4_phy_init,
+	.set_tune_val = sdhci_cdns_sd4_set_tune_val,
+};
+
+static const struct sdhci_cdns_of_data sdhci_cdns_sd4_of_data = {
+	.pltfm_data = &sdhci_cdns_sd4_pltfm_data,
+	.cdns_data = &sdhci_cdns_sd4_data,
+	.phy_probe = sdhci_cdns_sd4_phy_probe,
+};
+
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
@@ -350,11 +406,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 static int sdhci_cdns_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
-	const struct sdhci_pltfm_data *data;
+	const struct sdhci_cdns_of_data *data;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_cdns_priv *priv;
 	struct clk *clk;
-	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
 	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
@@ -368,12 +423,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 		return ret;
 
 	data = of_device_get_match_data(dev);
-	if (!data)
-		data = &sdhci_cdns_sd4_pltfm_data;
+	if (!data) {
+		ret = -EINVAL;
+		goto disable_clk;
+	}
 
-	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
-	host = sdhci_pltfm_init(pdev, data,
-				struct_size(priv, phy_params, nr_phy_params));
+	host = sdhci_pltfm_init(pdev, data->pltfm_data, sizeof(*priv));
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto disable_clk;
@@ -383,9 +438,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	pltfm_host->clk = clk;
 
 	priv = sdhci_pltfm_priv(pltfm_host);
-	priv->nr_phy_params = nr_phy_params;
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
+	priv->cdns_data = data->cdns_data;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
@@ -398,9 +453,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	if (ret)
 		goto free;
 
-	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
+	ret = data->phy_probe(pdev, priv);
+	if (ret)
+		goto free;
 
-	ret = sdhci_cdns_sd4_phy_init(priv);
+	ret = priv->cdns_data->phy_init(priv);
 	if (ret)
 		goto free;
 
@@ -429,7 +486,7 @@ static int sdhci_cdns_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_cdns_sd4_phy_init(priv);
+	ret = priv->cdns_data->phy_init(priv);
 	if (ret)
 		goto disable_clk;
 
@@ -453,9 +510,12 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
 static const struct of_device_id sdhci_cdns_match[] = {
 	{
 		.compatible = "socionext,uniphier-sd4hc",
-		.data = &sdhci_cdns_uniphier_pltfm_data,
+		.data = &sdhci_cdns_uniphier_of_data,
+	},
+	{
+		.compatible = "cdns,sd4hc",
+		.data = &sdhci_cdns_sd4_of_data,
 	},
-	{ .compatible = "cdns,sd4hc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
-- 
2.17.1

