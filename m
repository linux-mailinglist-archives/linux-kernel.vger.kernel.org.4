Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89D7738EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjFUS0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjFUS0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B58172C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30fbf253dc7so5156073f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371980; x=1689963980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNP6LkxylJsTZb04Lj9SoU8dCYBcHfZtyvvvsQ9AlHo=;
        b=Rg+Bb+MLsFTmBNxnLDtdRie8ZGj4jTuLI/dFep5lH5WU8TXD5G3EWoTWZzwjjVhWxI
         i+zAdLcYv/Bjxm5hgDDbdAsNtzdOoMTllxb/7/A1j8YcnC4XkIfOenypAWD9VDpcmwDC
         80hjUoKWLzzUVbfSCQvZ4jtN6GT86xalg1UYf1Ti0Y1qV1ov5ac0MA+hodpy9wHTtfBE
         KYvmNnueyZxvLyqx+rIoBHnxnkfGE4M9CDpO32r1ikF1/mz/NvnddFaKHOpSFQD6UVuc
         Ttbvr56A+YSnin2aHa+ogToq4wVLcKVI6Z7bsF+1WlWVhoW1t8v4TAT/pqI7vHaeG3ap
         4TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371980; x=1689963980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNP6LkxylJsTZb04Lj9SoU8dCYBcHfZtyvvvsQ9AlHo=;
        b=cmDuXfPkvjZTBrjj7wBeFj5q0W/X7OO/rDPqwZEt/gEidBfSSMSXRwoaGxwtqLHzhE
         YxUNJdSSkyh5+RjDTNoR9BnDDhTzsXi9/0b2Do51ooOylicjlzcL/qkXrEZDv5YDkgI6
         6iUh1YfLza1vP04FHVS/erjdj4KlTPMCHpUQEJP2RfyHomcI6GMWNS5UUzxqAUz1K1h8
         +wXKUcSzTRKiLUyF2w6NdIHCPBCiPPjHEyQJo4Eenkp5g2ND+6QpsYvmdmYofifA+ZyA
         hUYVLKB9lr0XRx+ihDo38hWDjwwsDAGae49If/eJ75BxkuH9D3UMSlWszXF1fDW13h50
         hKQw==
X-Gm-Message-State: AC+VfDyQfHLfPnD7wg1l6e9SDTPtFiIdxeEqsmC30hDunMbrsN36b08N
        elWdPEoqhVQHrrpk7OeS4f48BA==
X-Google-Smtp-Source: ACHHUZ5RVDJPKQgkikq7EQp55z2qtjpBNvLgslOl1M+TCNFqZpVkV7H2qkXeYGK4VW1bpr6W+PsINQ==
X-Received: by 2002:a05:6000:12c8:b0:311:2888:9f95 with SMTP id l8-20020a05600012c800b0031128889f95mr13417832wrx.23.1687371979554;
        Wed, 21 Jun 2023 11:26:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:19 -0700 (PDT)
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
Subject: [PATCH net-next 06/12] net: stmmac: replace the serdes_up_after_phy_linkup field with a flag
Date:   Wed, 21 Jun 2023 20:25:52 +0200
Message-Id: <20230621182558.544417-7-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ++++++---
 include/linux/stmmac.h                            | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
index 5e8aa03cffae..99e2e5a5cd60 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c
@@ -337,7 +337,7 @@ static int tegra_mgbe_probe(struct platform_device *pdev)
 	/* Program SID */
 	writel(MGBE_SID, mgbe->hv + MGBE_WRAP_AXI_ASID0_CTRL);
 
-	plat->serdes_up_after_phy_linkup = 1;
+	plat->flags |= STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP;
 
 	err = stmmac_dvr_probe(&pdev->dev, plat, &res);
 	if (err < 0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 73002ed923aa..d444514db07e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -991,7 +991,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 	u32 old_ctrl, ctrl;
 
-	if (priv->plat->serdes_up_after_phy_linkup && priv->plat->serdes_powerup)
+	if ((priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
+	    priv->plat->serdes_powerup)
 		priv->plat->serdes_powerup(priv->dev, priv->plat->bsp_priv);
 
 	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
@@ -3838,7 +3839,8 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_reset_queues_param(priv);
 
-	if (!priv->plat->serdes_up_after_phy_linkup && priv->plat->serdes_powerup) {
+	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
+	    priv->plat->serdes_powerup) {
 		ret = priv->plat->serdes_powerup(dev, priv->plat->bsp_priv);
 		if (ret < 0) {
 			netdev_err(priv->dev, "%s: Serdes powerup failed\n",
@@ -7623,7 +7625,8 @@ int stmmac_resume(struct device *dev)
 			stmmac_mdio_reset(priv->mii);
 	}
 
-	if (!priv->plat->serdes_up_after_phy_linkup && priv->plat->serdes_powerup) {
+	if (!(priv->plat->flags & STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP) &&
+	    priv->plat->serdes_powerup) {
 		ret = priv->plat->serdes_powerup(ndev,
 						 priv->plat->bsp_priv);
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 47ae29a98835..aeb3e75dc748 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -209,6 +209,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_USE_PHY_WOL			BIT(2)
 #define STMMAC_FLAG_HAS_SUN8I			BIT(3)
 #define STMMAC_FLAG_TSO_EN			BIT(4)
+#define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -293,7 +294,6 @@ struct plat_stmmacenet_data {
 	int msi_sfty_ue_vec;
 	int msi_rx_base_vec;
 	int msi_tx_base_vec;
-	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
 	unsigned int flags;
 };
-- 
2.39.2

