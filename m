Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C801074D0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjGJJA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjGJJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:00:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED8C9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso65699751fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979615; x=1691571615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSnjKOf9Ci1FVeqy2LquGwISKwhbeR055QIMuK7mc3Y=;
        b=5RNccCXJfgkU78ySq0JxTV7ZDkoePCzI4Hd3vmiYzokIy5xif5Ld1OgWceqXDnAOXx
         vsglSW572uQA6EyDjJUbeLXAASUP3pBzLTcLNRA2aqCvQsXgow6NVJQntG34phwd2quO
         HfQ09b/ietm+rHchyF5K3HIaTkmADw2xIk1i6JGT7k2+DKAtpi+thSbSiR+8ph185M9w
         nu91mRtbZ6qUhYC6rR1BLIPyhvbVvQSO1OCUhYyPc9DHSOofHToNYesvUqOmlilfZRU0
         fjl/jgb5eNP/wa9CMqgHmvwoaPnz0QI/EyILqlZ0IiE/Hv+a4GvyNwULKuI8rx3TSs8n
         Rc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979615; x=1691571615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSnjKOf9Ci1FVeqy2LquGwISKwhbeR055QIMuK7mc3Y=;
        b=aQQ8uLuLsQ0wpedn2MpEHCIba4nLWtnmdO5+nWy7kRNBLUYAlgkiBOhez7wM1bVaGZ
         unZ+4k0TxLEnKeKiYkVW7pgu6B07fkd1HYnYaZNQT05IBRDANMciZzAI15awW9HXgW1a
         3isn2bD1Yr4SY1BMMe3MeFCkZSlGMQJgk4fsNZFSM8W94Kz0AVH3528/j6lW7Xh6kk5G
         VuOC/lt2ztSsSbBG8f1FvBVMdxPFp8RBxtqljxUy/O1IF+S5zANMYykbCtBCPSX3+u8J
         PQnqBX2hO4B7uhp4B8gkQ6kbHzLJQEHBMRRPJdvyx/xiQh8EsIEQZVEE/Ud+M4YtEvla
         e6sA==
X-Gm-Message-State: ABy/qLZ8gVAf+2EkB4GlUITcSKo+gDV/D1pE1uh98aS37QXfu43GlsNC
        SqF1bypE5za8NjYnF3a4jgUTvQ==
X-Google-Smtp-Source: APBJJlGrmMHbn5NWmO1YYJIzI2TwRS9P95sAVzPdhjld7BDQunPplwuCb9f+WXNybWCnGYh+SMKk/w==
X-Received: by 2002:a2e:8909:0:b0:2b6:9f5d:e758 with SMTP id d9-20020a2e8909000000b002b69f5de758mr10327512lji.9.1688979614960;
        Mon, 10 Jul 2023 02:00:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:14 -0700 (PDT)
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
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v3 03/12] net: stmmac: replace the use_phy_wol field with a flag
Date:   Mon, 10 Jul 2023 10:59:52 +0200
Message-Id: <20230710090001.303225-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710090001.303225-1-brgl@bgdev.pl>
References: <20230710090001.303225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
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
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 5 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 +-
 include/linux/stmmac.h                               | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index ae5db39a3f1b..c690ec1b9bab 100644
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

