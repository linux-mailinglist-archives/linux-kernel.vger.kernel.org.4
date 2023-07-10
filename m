Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D5074D0D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjGJJAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjGJJAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:00:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109ABF1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so51069591fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979616; x=1691571616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlS2w38hffS8t4N6lUNAXq/+lMan+tZQyWGhu3FkWxA=;
        b=0yJeyY12y2yMBYTKnaWk2D4D45ts2C7hpFy2VklnAx7gax/7Er05BJfkDhAxyNh+wr
         pcMaEoft3w+ZM197/AX7iA7lRncxslHNX5hzYSlf9xJ4bADIRmV1TmTUKnJ+rzLsScqr
         NI8hChAuw1W2DALoI8XZw8mlwVCIc2IrgYI/ygruQglANToUr4tZ+YIBlH0XKPvQvOJp
         xDl+Z5G0Z8kfkQSOAsLYwdXhS/fawjXgkIShEbiQbCHLsxPIBERF7gg6W8larfQkrb0W
         TjrPc9bttebVYlIhbAT/a82z9Bd7geef2qkkTR1CFwk51iQgwRjig7IsRu1yjflhYWVX
         BMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979616; x=1691571616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlS2w38hffS8t4N6lUNAXq/+lMan+tZQyWGhu3FkWxA=;
        b=GNqXD+bt9725UNfVcgNBGCrEJZcRRl9BTW+yoAysau5qf1xFM7YwMKdXTllp1KGjx0
         Id7/ocpqohjQeTF/QTdty+6HtkNbEIcHSFlvLDDMNSikHTopk3K3tIUoT5sYEYtD9Hyn
         rU98HxJl/0OqCjw0XDe7nkevZ+5Tivh+PoDu+mTjHYZhXTwxjcru+FxvzDX5WQB8kZkq
         Ho/M0Dxx+GPD/ZcSzAzUXi4TaSjI2UlAS7ugZIw+DXPxAJKv8zraF87vUABMheDnRDhX
         TK3MM6YT8HPwPYlp6vn9jmUqvdJj/JeauFoTmLyFpsAhTvYhz/SxQkZFJOd2Y8x8EGjK
         fPNA==
X-Gm-Message-State: ABy/qLbuKnVC1yX7TDNKbrguo5qFRneulw/ybtKLRXY50bt7c3d+tSBo
        VSn63CzVxosCCZ0MSMUfNwGrAQ==
X-Google-Smtp-Source: APBJJlHNASJzAedMGym24eWQIWNlYk7Nuh0RZzw0WLGWmWCrcXMuL0a9kaTNNidQnkYaIL3HruML+g==
X-Received: by 2002:a2e:98c7:0:b0:2b7:7c:d5a1 with SMTP id s7-20020a2e98c7000000b002b7007cd5a1mr9541393ljj.23.1688979616273;
        Mon, 10 Jul 2023 02:00:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:15 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/12] net: stmmac: replace the has_sun8i field with a flag
Date:   Mon, 10 Jul 2023 10:59:53 +0200
Message-Id: <20230710090001.303225-5-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 include/linux/stmmac.h                            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 1e714380d125..2b5ebb15bfda 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1227,7 +1227,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	plat_dat->interface = interface;
 	plat_dat->rx_coe = STMMAC_RX_COE_TYPE2;
 	plat_dat->tx_coe = 1;
-	plat_dat->has_sun8i = true;
+	plat_dat->flags |= STMMAC_FLAG_HAS_SUN8I;
 	plat_dat->bsp_priv = gmac;
 	plat_dat->init = sun8i_dwmac_init;
 	plat_dat->exit = sun8i_dwmac_exit;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a1a59af3961d..3df32658b5bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -325,7 +325,7 @@ static void stmmac_clk_csr_set(struct stmmac_priv *priv)
 			priv->clk_csr = STMMAC_CSR_250_300M;
 	}
 
-	if (priv->plat->has_sun8i) {
+	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
 		if (clk_rate > 160000000)
 			priv->clk_csr = 0x03;
 		else if (clk_rate > 80000000)
@@ -6856,7 +6856,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	int ret;
 
 	/* dwmac-sun8i only work in chain mode */
-	if (priv->plat->has_sun8i)
+	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I)
 		chain_mode = 1;
 	priv->chain_mode = chain_mode;
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 15fb07cc89c8..66dcf84d024a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -207,6 +207,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_HAS_INTEGRATED_PCS		BIT(0)
 #define STMMAC_FLAG_SPH_DISABLE			BIT(1)
 #define STMMAC_FLAG_USE_PHY_WOL			BIT(2)
+#define STMMAC_FLAG_HAS_SUN8I			BIT(3)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -270,7 +271,6 @@ struct plat_stmmacenet_data {
 	struct reset_control *stmmac_ahb_rst;
 	struct stmmac_axi *axi;
 	int has_gmac4;
-	bool has_sun8i;
 	bool tso_en;
 	int rss_en;
 	int mac_port_sel_speed;
-- 
2.39.2

