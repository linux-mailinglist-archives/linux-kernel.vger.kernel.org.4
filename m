Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209CB73B4E1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjFWKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjFWKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:03 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071FB2D77
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:08:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f9ede60140so5385945e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514935; x=1690106935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HRVKBhefxoQaIrrk1E+lF53Gj3p4Z+uWDwMbBoofOY=;
        b=OemuTJCWfC5VWij5fB4MS4ju7PFwOzlbykJyaXqedjZ+76URX44WT/HdxYIMwy8WVb
         EDioSsGVE22zZ24I2YyJsgPd0ATIyEY50xkU+Xm39nJ1MjkhgwS3owOV8EuYxKHPpETc
         aIpWXmGrn2GCP3/abQ40aC/U4dE46esG0ULnxgiK8YLcwxNbNDx98asXbZ/a3dMa94Lr
         4uYdP+lELTweB056/N/i52IkUKzRSMZ/u5uLn/vDZAcVv7r+CJQbV4T22wvCixtIGOFQ
         pHHUjz1Q3xlpIhavVcBeihW/cgN2j4yCrGpT3thENVf81rckuX3uPt7wXPvI+N3P2R0h
         yZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514935; x=1690106935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HRVKBhefxoQaIrrk1E+lF53Gj3p4Z+uWDwMbBoofOY=;
        b=iYXI50u+R1EMDuRdJo74be4ATP4kwE0Xw2FumpzYAfAEPeFh0kCREk7UT+EUPFpOTs
         5V7SBbrXKpWZtTHbf7ZfF5+p12PLtg2P/Qeqgpx4wsXbcOQDSKT/lVRlB3kAZ7yUoai5
         53gR3FrE0toAHHd6eNS58+I9K0DNEH+tuRFc/IXAKQ4Ss+hrJdqPk3uTJMrimq2tTnMu
         capzV+2MPz+BPFlro1lZRsLObhr/840mST+SehRhMacP5UQgTfoMa0s8beWU1/Fzq567
         SzeVKjaQ+SsyQXDjwFMT+M/RUgcfWE01M2748c4WwToNgxiSrVWnG1IEhg216WaEc4mx
         Qycg==
X-Gm-Message-State: AC+VfDxFV6PcpmKaoXDlPYX3vVyB7vqreLymx6AhTi7FV+dM3F0+pReo
        DhqIc/BsxA9fS2hIXrMb2ORCMg==
X-Google-Smtp-Source: ACHHUZ6DlvdaPd+U5SDulK33NhxI1nKFSmpmi/GYBjmKv0HD9ZzOduqx5doEBd+NCwuHjt1hIwG0ig==
X-Received: by 2002:a1c:7c17:0:b0:3fa:76e2:e6e3 with SMTP id x23-20020a1c7c17000000b003fa76e2e6e3mr2712678wmc.34.1687514935529;
        Fri, 23 Jun 2023 03:08:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:08:55 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 05/12] net: stmmac: replace the tso_en field with a flag
Date:   Fri, 23 Jun 2023 12:08:38 +0200
Message-Id: <20230623100845.114085-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

