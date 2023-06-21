Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05C0738EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjFUS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjFUS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760751BFE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-311167ba376so6207971f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371987; x=1689963987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwyUb1LcLxFuKvlYDOLM+hUXxmW+mTunlzrn4iVWnOo=;
        b=boN5Wecqu/zA+UEwtUa4Aoml/2yCbwhKRxRfb5rOLyKwLaoKa58ptvFtU3Qx2jCceU
         3+8vDuDuUrQZJ06Vu1speeZqUAVDwwGO6lyhuOaAbUGhDUL6yqpkqJB1Pf5TmA0eOpWz
         eRnwmany7hYV7wAV5ktHqY+Q1Kvoe+ZNHdyNLPYphC77shw4bYJw3thFnfmxfYeonCWq
         hT9oD2Q9IOZCHKcig9cw1VvBkfOx/AAI96BNjF7SW6HMEXp8KZZZ14fvOHRgapia2ksj
         O9fzy5zhPYJg246QedmUb2UbqjplFaF3rK8ryeZRjPKoieB04ifPgQv5ScK353VxSYQy
         5XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371987; x=1689963987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwyUb1LcLxFuKvlYDOLM+hUXxmW+mTunlzrn4iVWnOo=;
        b=MYp5JYLY/f1r0ctRjVZdxaKsAH4XX5KnI5QV4e8FnVUtON0cTEpDO4uSlz6JRJC403
         A8Z/zQ1A3Q7Z/cl5ivLKn8XfVyDCw/pyzJzcqKfynU9N8UlKkyL0z9vg6Zvx/h4hM0X1
         r9n2KYJSpN3NwLEJEgbLXazhjW+1cUwqtlZ92Pn+JqZZ4biEmEMLbujTHqQCt6pc3IvA
         OpTkT0xhBFINDjyirOnoAMITVOr1DNpc1Cwc9vnlC/q6zivvYv3djknXXAFNlQ/8Lrh2
         8qkKyPriH9j5JvEqgHO8kWz5fjNfw3mfZVv3SOs37Ygg1uOuF6NA3EU1tXi1VLsnJpda
         Y3TQ==
X-Gm-Message-State: AC+VfDzp+IJP59hohvIHf+EMZ+24GCUVjGsTFUTvZZtn+z+veA3cfH8l
        MVEDyNx7dqexYuaDCJexoEMCWg==
X-Google-Smtp-Source: ACHHUZ4fDyzUF2+3iPLY0BziOFpFgzjxW7uoq1bB0cyrCC50xRJ1EXO/ysLqYUgmuqATxsM3yuLRoQ==
X-Received: by 2002:adf:f406:0:b0:30f:c933:49b2 with SMTP id g6-20020adff406000000b0030fc93349b2mr13223537wro.24.1687371986863;
        Wed, 21 Jun 2023 11:26:26 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:26 -0700 (PDT)
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
Subject: [PATCH net-next 11/12] net: stmmac: replace the rx_clk_runs_in_lpi field with a flag
Date:   Wed, 21 Jun 2023 20:25:57 +0200
Message-Id: <20230621182558.544417-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230621182558.544417-1-brgl@bgdev.pl>
References: <20230621182558.544417-1-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 3 ++-
 include/linux/stmmac.h                                  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 79e196397aea..743f2261b964 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -790,7 +790,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "snps,tso"))
 		plat_dat->flags |= STMMAC_FLAG_TSO_EN;
 	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
-		plat_dat->rx_clk_runs_in_lpi = 1;
+		plat_dat->flags |= STMMAC_FLAG_RX_CLK_RUNS_IN_LPI;
 	if (data->has_integrated_pcs)
 		plat_dat->flags |= STMMAC_FLAG_HAS_INTEGRATED_PCS;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ebe82e7b50fc..2d68a6e84b0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1085,7 +1085,8 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
 		priv->eee_active =
-			phy_init_eee(phy, !priv->plat->rx_clk_runs_in_lpi) >= 0;
+			phy_init_eee(phy, !(priv->plat->flags &
+				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
 		priv->eee_enabled = stmmac_eee_init(priv);
 		priv->tx_lpi_enabled = priv->eee_enabled;
 		stmmac_set_eee_pls(priv, priv->hw, true);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 47708ddd57fd..c3769dad8238 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -214,6 +214,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
+#define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -280,7 +281,6 @@ struct plat_stmmacenet_data {
 	int rss_en;
 	int mac_port_sel_speed;
 	bool en_tx_lpi_clockgating;
-	bool rx_clk_runs_in_lpi;
 	int has_xgmac;
 	u8 vlan_fail_q;
 	unsigned int eee_usecs_rate;
-- 
2.39.2

