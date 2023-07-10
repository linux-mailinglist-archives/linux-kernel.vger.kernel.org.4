Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3748674D0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGJJBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjGJJA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:00:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF121B4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so43128415e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979627; x=1691571627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0rWskzXieUZbB116gf4yd7qvzoiqPrQgJ7WLt8WOY8=;
        b=kIhb6iVdgmZpI7b/3LkKN5H64ZHm72dF2AwRuA6RGp0LXEGkOBGORKjJVJAXV7GOCk
         cwLbqzHRwnfceM08unaFdJqsXZ6lrLJUnDoHFMutQiU7LCItZgXEM72L3GZVhoytyusH
         1NMpP+7IXokgxZjtgoi6vdUkIojJWsA6dN3kMB1lmMRaBjOTgeVgkTySpHN3rydyM117
         M6hWbp+IkDxKUeRimHNGazAijGXbtdZpUz72cPzNhbL5YNMgneYi+J5M6yulXJ7wpWuz
         yqSYn+SXiB+TfnV/Hi2B4qETNQ+bBzv4rbubW27wqmaFDY77Ncp7c/Cy2pp5eNucZ0hh
         Bqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979627; x=1691571627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0rWskzXieUZbB116gf4yd7qvzoiqPrQgJ7WLt8WOY8=;
        b=UH4MvMeRqjG+cN6M9BoWRvQWU5D9P7pL+XckDWeTqyTf/LZPCazJjrvcSuinFdb3Tr
         lwpOlUv/exyDU5vE9QU6JnXfk2l1KWclKJWk7QDBnLrc5+NY59uMyHpWut/V7V54Sg7W
         zdZ1FsCOWUYfvkR8U+mM7QgIdZLWqWLcRn0warkIXqsHoqjMku4glkpm3ugHxIg8vDRT
         8y5up0lFPLmKcnE8OxoWPaAiCQndXvN1fDPWmK98H4luJxRV4PGv02UP3aHnGCVCw1Ej
         4xP0axApKLWrRvtv9MGDzLkqOlFcAQLOMGmoV5ueEMvtgB58mzNyfpDLJb/zKjiCeKjb
         Ip1g==
X-Gm-Message-State: ABy/qLaA39U7g/sq93WlNnwcDZqhHe16tyWfiDOvnTzmoZZuGX4iF5aC
        HI04y9tG5SqLe50Ba5k+KzTUHg==
X-Google-Smtp-Source: APBJJlFVEFLv7NsAd9bHXGtmkXrMxRkAN54ouiP3rIZwa1lYBs3dSXHMX0+nk9m4mDprFRyW2m0WTw==
X-Received: by 2002:a1c:7206:0:b0:3fb:8284:35b0 with SMTP id n6-20020a1c7206000000b003fb828435b0mr9602632wmc.30.1688979627723;
        Mon, 10 Jul 2023 02:00:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:27 -0700 (PDT)
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
Subject: [PATCH net-next v3 12/12] net: stmmac: replace the en_tx_lpi_clockgating field with a flag
Date:   Mon, 10 Jul 2023 11:00:01 +0200
Message-Id: <20230710090001.303225-13-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 4 ++--
 include/linux/stmmac.h                                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2d68a6e84b0e..efe85b086abe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -421,7 +421,7 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
 	/* Check and enter in LPI mode */
 	if (!priv->tx_path_in_lpi_mode)
 		stmmac_set_eee_mode(priv, priv->hw,
-				priv->plat->en_tx_lpi_clockgating);
+			priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGATING);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index f51522cb0061..23d53ea04b24 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -466,8 +466,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->force_sf_dma_mode =
 		of_property_read_bool(np, "snps,force_sf_dma_mode");
 
-	plat->en_tx_lpi_clockgating =
-		of_property_read_bool(np, "snps,en-tx-lpi-clockgating");
+	if (of_property_read_bool(np, "snps,en-tx-lpi-clockgating"))
+		plat->flags |= STMMAC_FLAG_EN_TX_LPI_CLOCKGATING;
 
 	/* Set the maxmtu to a default of JUMBO_LEN in case the
 	 * parameter is not present in the device tree.
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index c3769dad8238..ef67dba775d0 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -215,6 +215,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_EXT_SNAPSHOT_EN		BIT(8)
 #define STMMAC_FLAG_INT_SNAPSHOT_EN		BIT(9)
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
+#define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -280,7 +281,6 @@ struct plat_stmmacenet_data {
 	int has_gmac4;
 	int rss_en;
 	int mac_port_sel_speed;
-	bool en_tx_lpi_clockgating;
 	int has_xgmac;
 	u8 vlan_fail_q;
 	unsigned int eee_usecs_rate;
-- 
2.39.2

