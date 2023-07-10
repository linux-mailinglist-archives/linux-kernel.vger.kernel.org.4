Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AF774D0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjGJJBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjGJJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:00:58 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A7FE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso65167111fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979626; x=1691571626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVtFhd0Km8syItagysZcPYxDGwV5P+/dGFTOfEg0+Yc=;
        b=CddbWTskACPRtMQSrRi4hJeH5Iup7rrWzy4Y8GGk40YSMoIVZ0micpUHWhleaEjv+U
         wKS3OBd0Nl397l8bwV8e9M1orYGwEMc0VG4rCfFxqiHRmVhQGKLtknOwXuDKrva7rglX
         ecl89XAzYl15aSaP8fCzOsRoecFyyGAu1YUaZr3d89Mfdb8ZmSgxo8+ONF6EVPjlJFPd
         OV+5BOOxYHddIf1neWL3qxjyUfhAEVkA3qZqZlwQt1hSI/UXdRieUC/ZQQvRVA7FEz4o
         +mAK24YMtG1mgMKy7fLp4WmXKocn32um2M+EeyMIzwCrCYQZ30cjEt/orHyh2Y1Cw7c7
         6pGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979626; x=1691571626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVtFhd0Km8syItagysZcPYxDGwV5P+/dGFTOfEg0+Yc=;
        b=gI2T1/uTsZUvZy9fWcV7Qk2W/Im5ka6Kk3xA0c09TGce0M5utYZmXQHlwO9or6X2/Y
         5yRsdKLzFIEIZk3KLtR/CeKuq1c2zSiU0fgGn0kZhvpE+H8fG4SSDlM0sjU9gxYoD02s
         lLeshvDciI7WTS/4Unhs0lJmc9xjn4SIsyCG1Bb+ymTL8Gc/T5lcfBjZp5mc2C4XdvcV
         imJ3UXLcchb2fb64BsRADmIqksRkwhdvas1zfG5q/iusZVHiVt+YWf5X8u2/1pi0UwNz
         zB7oUmVaKrKviWL4YWsh1ROFj67rIwfDa3MV93g3Z0p72MwlE11Pgt/8U/Il225zkLFx
         2oGg==
X-Gm-Message-State: ABy/qLbpR04NpGXXL9kJICR7jZxbMxSSbLrGoNPlOPvbr0U008ShBcbe
        Hv/2xKigQEZuDf5pLKoJqVpxWQ==
X-Google-Smtp-Source: APBJJlEP8RjYI6mEVqb8E5PCwkoT0tyhZKt8ufMjMDNngPcNAkchhf2+a4Mz1t5LkL2DBdggALs1DA==
X-Received: by 2002:a2e:9815:0:b0:2b6:d8d5:15b1 with SMTP id a21-20020a2e9815000000b002b6d8d515b1mr8428218ljj.50.1688979625880;
        Mon, 10 Jul 2023 02:00:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 11/12] net: stmmac: replace the rx_clk_runs_in_lpi field with a flag
Date:   Mon, 10 Jul 2023 11:00:00 +0200
Message-Id: <20230710090001.303225-12-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c       | 3 ++-
 include/linux/stmmac.h                                  | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2692ccebea50..fb593250c2e8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -780,7 +780,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
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

