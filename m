Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049E5738EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFUS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjFUS0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06681731
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so7124320f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371975; x=1689963975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0OwBqk57PhsZ04IZ/thQPvSHwVfxueGqzoT1EHd/f0=;
        b=gXdVXlJTcS5XYEo51rAA4JlwFbLrG4KYmIfKfFEMJfyjsCe39ue7rCvQCs/Gm47qB4
         bJrItSEK/CqlAUvrHnlGOshz1H7uqWkLRLQ8Hj23JDUdJgq6Tsau8Vj8Uzo3FDatkAut
         IDPiT9Il41Ab78s7xFRHzIBBL3ETf77C/+RcY3ZhokR2PcPkVhlTOWiK8b7xJ/3jCp1b
         USWaPGQNNwGxg5YfdCVVVv7Mm/LCG5PI3sG1b6IpB0V+U38EObFZbjVIcgccKX79bJAY
         b98y6vu2+0g9+LmJ+iIK/AsxM47nRu8w6leDmRCw8VUeE/yr4cmqQZjgwzfKorxVjm1c
         ybow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371975; x=1689963975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0OwBqk57PhsZ04IZ/thQPvSHwVfxueGqzoT1EHd/f0=;
        b=GY4hXhngetsLieAXcWW3TZwAUX/LmaqtgwthHKW/7aTFHOGAvmuBJW4bjVcTMELnCg
         dHQopuV0ZvApdAId+pa5iu7dYXpVUoe/2xtPpPI9AgLXJOb3J2NlqqTreJ4iumZ9QigR
         1/SClxHMLU7gu4TdisoDHWZuB7XKuqogCmSOn6HcOV3z83Y6JQXyuSIXujV80iLn35VU
         yTXwq+8ixkz8jzI+XVeusjZ/HJh478zqvI/F1E99OeVPZNJGkmByVyLMSlQwOHKK0qoN
         c+2rDdd2kRJhAWuhv+U0niZb4hyo94SXd3gwoi/YlWKmV8Y39tIAGpR+Q+Xl+ADK3rg2
         fWIA==
X-Gm-Message-State: AC+VfDybw/jAo3871ssKo+yIYLVehAmnUc/wMsHlb5s8Fm943ZttXW6q
        o51l0FSLjJWg9PoKtSodAliffQ==
X-Google-Smtp-Source: ACHHUZ6ro2dY8kK22wivgUJLDisEOfpm9abhyjxSzeV3udAHBYE7eMFpsn15ij2gBjweFqUIcAwI4w==
X-Received: by 2002:adf:fe48:0:b0:311:1b34:a7c9 with SMTP id m8-20020adffe48000000b003111b34a7c9mr14485298wrs.12.1687371975524;
        Wed, 21 Jun 2023 11:26:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:15 -0700 (PDT)
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
Subject: [PATCH net-next 03/12] net: stmmac: replace the use_phy_wol field with a flag
Date:   Wed, 21 Jun 2023 20:25:49 +0200
Message-Id: <20230621182558.544417-4-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 5 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 +-
 include/linux/stmmac.h                               | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 70e91bbef2a6..44a84a6c18ce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -628,7 +628,7 @@ static int ehl_common_data(struct pci_dev *pdev,
 {
 	plat->rx_queues_to_use = 8;
 	plat->tx_queues_to_use = 8;
-	plat->use_phy_wol = 1;
+	plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
 
 	plat->safety_feat_cfg->tsoee = 1;
 	plat->safety_feat_cfg->mrxpee = 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 73c1dfa7ecb1..4d877d75642d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -588,7 +588,10 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 	int i;
 
 	plat->interface = priv_plat->phy_mode;
-	plat->use_phy_wol = priv_plat->mac_wol ? 0 : 1;
+	if (priv_plat->mac_wol)
+		plat->flags |= STMMAC_FLAG_USE_PHY_WOL;
+	else
+		plat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
 	plat->riwt_off = 1;
 	plat->maxmtu = ETH_DATA_LEN;
 	plat->host_dma_width = priv_plat->variant->dma_bit_mask;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 18e56299363d..a1a59af3961d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6877,7 +6877,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		 */
 		priv->plat->enh_desc = priv->dma_cap.enh_desc;
 		priv->plat->pmt = priv->dma_cap.pmt_remote_wake_up &&
-				!priv->plat->use_phy_wol;
+				!(priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL);
 		priv->hw->pmt = priv->plat->pmt;
 		if (priv->dma_cap.hash_tb_sz) {
 			priv->hw->multicast_filter_bins =
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 1b02f866316c..15fb07cc89c8 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -206,6 +206,7 @@ struct dwmac4_addrs {
 
 #define STMMAC_FLAG_HAS_INTEGRATED_PCS		BIT(0)
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
+#define STMMAC_FLAG_USE_PHY_WOL			BIT(2)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -292,7 +293,6 @@ struct plat_stmmacenet_data {
 	int msi_sfty_ue_vec;
 	int msi_rx_base_vec;
 	int msi_tx_base_vec;
-	bool use_phy_wol;
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	unsigned int flags;
-- 
2.39.2

