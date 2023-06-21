Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E054738EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjFUS0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFUS0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:21 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7821710
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3113675d582so3828614f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371978; x=1689963978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HRVKBhefxoQaIrrk1E+lF53Gj3p4Z+uWDwMbBoofOY=;
        b=sqmethSCf2xOuZRs/yqXfT9FW0TfEx0Z2WpwYOnm/36HW9D5GQClc4pnRWtCY593HC
         3CT7YLTHG511kU4VsmoNzfq+Fp/EA4eo+9YA5D3T1lNKLyQ0/vscZX5lFJplU6WA9iYj
         /eZzHGoJVXCggTYA1IRKAuTo4xsFS0NrCYdY4daomC5POJLRfqN+k0nAFXFQyBcp/o1p
         g+JIWjr+idoAmNiEn2odRogzeIfceOLdz2F8+0vaDibviutnugLsFDKKsChUkqXf8YOL
         Q/7/0sdF2SMO1S2e+scwJJaKnBNTAN8SuZGs7Q/PdBqb5q2vIBUk7dWkpzFKkHLX7zrF
         ZUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371978; x=1689963978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HRVKBhefxoQaIrrk1E+lF53Gj3p4Z+uWDwMbBoofOY=;
        b=CM5NyVb/ZqaIp8CPVi5ExH4VXm0R+m1xlxK8ubPvy0kLSFa9h8AZLy8aeCM1nQjGCW
         cwLmkStQgCEzUilpUyDzg/waPFZO9bfUIIiotuEgzgf+eG+uDESWmVg/0CJ6X795yBtN
         R1/2sDXK3wABybLxMo7A+auFIe83+AkGE9m/X6A8F6q+pfEzGn+nVfTDNtV5nUuR8Jcv
         Sa6MgefDHT0DNNnmg/C/M/LVjlC6ClwueriA9qCVEUaIfckTsv2DjBxkb6/RY14u/aiB
         POiiHKabwvO9pUQ17mZckjpepn4cVqqNTNh0S+XWxmvO5Mk7aDGsh2g0lGodt7OGfDZP
         NuTw==
X-Gm-Message-State: AC+VfDwaoQs3SLOZHLf6baPn01w3elNVmRcE6egBmNPx0U0iTRHTxWrY
        DmntS1qJJFNqTPKb/K2GX6sVHw==
X-Google-Smtp-Source: ACHHUZ796SsTD4oRLyqFw96CluzbNM80YkfbJzDyC80N2T8s5cRqBzXiypqgXt9r86/GSMf9RacQ5g==
X-Received: by 2002:adf:f7cb:0:b0:305:ed26:8576 with SMTP id a11-20020adff7cb000000b00305ed268576mr11189932wrq.9.1687371978218;
        Wed, 21 Jun 2023 11:26:18 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:17 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next 05/12] net: stmmac: replace the tso_en field with a flag
Date:   Wed, 21 Jun 2023 20:25:51 +0200
Message-Id: <20230621182558.544417-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621182558.544417-1-brgl@bgdev.pl>
References: <20230621182558.544417-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the boolean field of the plat_stmmacenet_data structure in favor of a
simple bitfield flag.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c       | 3 +--
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 3 ++-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 6 ++++--
 include/linux/stmmac.h                                  | 2 +-
 8 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 0c12ab67c27b..b5efd9c2eac7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -113,7 +113,7 @@ static int dwc_eth_dwmac_config_dt(struct platform_device *pdev,
 	/* dwc-qos needs GMAC4, AAL, TSO and PMT */
 	plat_dat->has_gmac4 = 1;
 	plat_dat->dma_cfg->aal = 1;
-	plat_dat->tso_en = 1;
+	plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	plat_dat->pmt = 1;
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 44a84a6c18ce..faa6f4ec6838 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -458,8 +458,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->has_gmac = 0;
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 0;
-	plat->tso_en = 1;
-	data->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat->flags |= (STMMAC_FLAG_TSO_EN | STMMAC_FLAG_SPH_DISABLE);
 
 	/* Multiplying factor to the clk_eee_i clock time
 	 * period to make it closer to 100 ns. This value
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 44151e69f9ce..79e196397aea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -787,7 +787,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
-	plat_dat->tso_en = of_property_read_bool(np, "snps,tso");
+	if (of_property_read_bool(np, "snps,tso"))
+		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
 		plat_dat->rx_clk_runs_in_lpi = 1;
 	if (data->has_integrated_pcs)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index f8367c5b490b..5e8aa03cffae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -290,7 +290,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	}
 
 	plat->has_xgmac = 1;
-	plat->tso_en = 1;
+	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 	plat->bsp_priv = mgbe;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3df32658b5bb..73002ed923aa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5677,7 +5677,7 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_CSUM_MASK;
 
 	/* Disable tso if asked by ethtool */
-	if ((priv->plat->tso_en) && (priv->dma_cap.tsoen)) {
+	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
 		if (features & NETIF_F_TSO)
 			priv->tso = true;
 		else
@@ -7250,7 +7250,7 @@ int stmmac_dvr_probe(struct device *device,
 		ndev->hw_features |= NETIF_F_HW_TC;
 	}
 
-	if ((priv->plat->tso_en) && (priv->dma_cap.tsoen)) {
+	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
 		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
 		if (priv->plat->has_gmac4)
 			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 644bb54f5f02..352b01678c22 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -77,7 +77,7 @@ static int snps_gmac5_default_data(struct pci_dev *pdev,
 	plat->clk_csr = 5;
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 1;
-	plat->tso_en = 1;
+	plat->flags |= STMMAC_FLAG_TSO_EN;
 	plat->pmt = 1;
 
 	/* Set default value for multicast hash bins */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3c6b55b60461..5a67af4526c7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -524,7 +524,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-		plat->tso_en = of_property_read_bool(np, "snps,tso");
+		if (of_property_read_bool(np, "snps,tso"))
+			plat->flags |= STMMAC_FLAG_TSO_EN;
 	}
 
 	if (of_device_is_compatible(np, "snps,dwmac-3.610") ||
@@ -537,7 +538,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (of_device_is_compatible(np, "snps,dwxgmac")) {
 		plat->has_xgmac = 1;
 		plat->pmt = 1;
-		plat->tso_en = of_property_read_bool(np, "snps,tso");
+		if (of_property_read_bool(np, "snps,tso"))
+			plat->flags |= STMMAC_FLAG_TSO_EN;
 	}
 
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 66dcf84d024a..47ae29a98835 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -208,6 +208,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
 #define STMMAC_FLAG_USE_PHY_WOL			BIT(2)
 #define STMMAC_FLAG_HAS_SUN8I			BIT(3)
+#define STMMAC_FLAG_TSO_EN			BIT(4)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -271,7 +272,6 @@ struct plat_stmmacenet_data {
 	struct reset_control *stmmac_ahb_rst;
 	struct stmmac_axi *axi;
 	int has_gmac4;
-	bool tso_en;
 	int rss_en;
 	int mac_port_sel_speed;
 	bool en_tx_lpi_clockgating;
-- 
2.39.2

