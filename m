Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DA73B4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFWKKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFWKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDE52D67
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:08:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9c2913133so5916955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514932; x=1690106932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew/OjzgYg2nsW0kAROkz29zhVp2ggSYw8qH9w/3MfWE=;
        b=C8u+ZXCHQdPKodiM5v7/b2mSTYm4069RdqKcGt2d3qQ3M0hMOVzAtCHLEGcydsb9H5
         ezLk1y5ZIDblnE7dNeLg+BehZmNh49pBMfSPETU+4kQXzgpcU5iGT1L5ytBxl4yG3z11
         3zfOvc8zrbW74LSoOg4yEjoy7nK6pBCWG+1owflHbdBU36HiEZhbhvmFXzwR21kn7RGx
         hsJiHOWrOuxoFTE7cie99DPxLl6R3ced0Nrc9TX3PA/Oa+/fa5uiyuZf3B2apnzOrHLZ
         ucec1zb/DS7XqppiySHzdUpwHpzH3jOZvIVEi9t6dm1B/YpVhZcULrDKxp75c8pR7DNO
         85oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514932; x=1690106932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew/OjzgYg2nsW0kAROkz29zhVp2ggSYw8qH9w/3MfWE=;
        b=l+OgvHPH+FOK2Bi8d/kpXkmvGfC+AGu2QEuo4F3EVHqg/zCn/8SBO4m0/nXX9UCHus
         pY2ddOtGZktYMSwdOQHkMBXlLFumjd6VVLKgeTaVjG6+CpN18+3qoXK1Bthjqm1wIX6v
         eWwmfG59dCwnx+u7QIV+Vc1HoQ/S3lgSkYcknIE1/BzArwmc/ix1AXDMaPGiZVGKl6PO
         pY01f2tnxB1Z4ducjT7FFQ9u69J/5WiWNJ16UMsw5XWrm2pZqDVO0JuM2MUm8Kr9Mzmf
         6je0AJtFuzbSSzYg9DSMuydcsMcA8k0ZerTy8ddlI7XVg77uuGrdxdeg2Bxd4sTpYv9r
         7zrQ==
X-Gm-Message-State: AC+VfDwWOJO7SGgKVpSG3HfkW32fqwfHFp77PpSSgKdehg4eFS7Dy9rt
        TfP3C2EEugI3vMDUKFm9iHm0tA==
X-Google-Smtp-Source: ACHHUZ71+U53koIeVd6HcBoAAxnwXclqi3Dgq8ZgYmlNoX3pgWmdescemRu5qaQBqUT4Fm8/LU0+Gw==
X-Received: by 2002:a05:600c:248:b0:3f9:b3b4:4367 with SMTP id 8-20020a05600c024800b003f9b3b44367mr9685508wmj.15.1687514931873;
        Fri, 23 Jun 2023 03:08:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:08:51 -0700 (PDT)
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
Subject: [PATCH net-next v2 02/12] net: stmmac: replace the sph_disable field with a flag
Date:   Fri, 23 Jun 2023 12:08:35 +0200
Message-Id: <20230623100845.114085-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 3 ++-
 include/linux/stmmac.h                                  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 9f88530c5e8c..0c12ab67c27b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -359,7 +359,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	data->fix_mac_speed = tegra_eqos_fix_speed;
 	data->init = tegra_eqos_init;
 	data->bsp_priv = eqos;
-	data->sph_disable = 1;
+	data->flags |= STMMAC_FLAG_SPH_DISABLE;
 
 	err = tegra_eqos_init(pdev, eqos);
 	if (err < 0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ab9f876b6df7..70e91bbef2a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -459,7 +459,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	plat->has_gmac4 = 1;
 	plat->force_sf_dma_mode = 0;
 	plat->tso_en = 1;
-	plat->sph_disable = 1;
+	data->flags |= STMMAC_FLAG_SPH_DISABLE;
 
 	/* Multiplying factor to the clk_eee_i clock time
 	 * period to make it closer to 100 ns. This value
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 38b6cbd8a133..18e56299363d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7258,7 +7258,8 @@ int stmmac_dvr_probe(struct device *device,
 		dev_info(priv->device, "TSO feature enabled\n");
 	}
 
-	if (priv->dma_cap.sphen && !priv->plat->sph_disable) {
+	if (priv->dma_cap.sphen &&
+	    !(priv->plat->flags & STMMAC_FLAG_SPH_DISABLE)) {
 		ndev->hw_features |= NETIF_F_GRO;
 		priv->sph_cap = true;
 		priv->sph = priv->sph_cap;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 8e7511071ef1..1b02f866316c 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -205,6 +205,7 @@ struct dwmac4_addrs {
 };
 
 #define STMMAC_FLAG_HAS_INTEGRATED_PCS		BIT(0)
+#define STMMAC_FLAG_SPH_DISABLE			BIT(1)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -292,7 +293,6 @@ struct plat_stmmacenet_data {
 	int msi_rx_base_vec;
 	int msi_tx_base_vec;
 	bool use_phy_wol;
-	bool sph_disable;
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	unsigned int flags;
-- 
2.39.2

