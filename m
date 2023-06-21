Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E27738EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFUS0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjFUS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC5198E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f8467e39cfso8443212e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371981; x=1689963981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYsPM0znkqN61dd+ZblYn0iKga8HXqcuyw6SkrjlQfc=;
        b=WaV00h9Ssbh1d35mpEEZh/vg7J88cASFS+N4Gt4IzpiiGSULOes7Mjim1d22/Ve4OO
         Y7LOuR+MPo2ccwycUhyFIA75fGCnTbJcmglt1IAkijGB8KYrzkEpHxPwoPmrqpxSgNG0
         UGZXUpO8uXW0F9yol3+LL912TuadXXHvOgOHaBtmM0iswCcGa3oTvNDMLl9bkqWJXsRh
         OY+6LYE+06FrbrKmHTU4YF8bJaHzuPmFVdfWgdWSQa6Uglwzro1xa81DsgTE+sEMZfRy
         g4pwpvfeBfo+XPKb7N1QI37GfAqvAWjxeAyW4OdHugeHxVy7zwrvRx79Ko8TyMC/jBcg
         WCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371981; x=1689963981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYsPM0znkqN61dd+ZblYn0iKga8HXqcuyw6SkrjlQfc=;
        b=lH0ZgLzojLcGd5+kSk6HR0WsxUttXD1Ki6+AeqTqGAt1OoduNbAxoi2VHG3p/91zVX
         LBy0mcqr8C8iWDRniduaL+pNKwszt4yRe/v5zfMbDaOucx9OVIYVvw+s8UikrgVX4XF9
         ZOHJLERe9Px2CQbyisghY7d90wRU7gqAqbzmVjlfKtwMQ5W2jdGsNFXcHl8EJrMcsaoo
         qdVg5F6Ye2Wqrlf4qIUagPvi3YzD/nXior/WavWOkGzXrpG3PaV56kgZ2Ua5HCT58NIG
         yEkLX9+Jei9N4OrDAmgte3UFaeHX5ErESyaJCSJvNBur0GNkF784cgW3Q78CCnLyFTsR
         y8iA==
X-Gm-Message-State: AC+VfDx5j8QDMKsxN/y+pseZ5Biqjegld9eZU2w/milGuSgD6S17huu2
        aOIuxcBpdUIvs7gWG33uYIucpQ==
X-Google-Smtp-Source: ACHHUZ6ovuRqbuJKItHPPlkyENMjA6UFt3MUskyFWk/0pA+0HJnvdMYDu0iWAB8bemRdLstLQdKB8Q==
X-Received: by 2002:a05:6512:39c4:b0:4f9:5a0c:85b8 with SMTP id k4-20020a05651239c400b004f95a0c85b8mr1885681lfu.36.1687371981057;
        Wed, 21 Jun 2023 11:26:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:20 -0700 (PDT)
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
Subject: [PATCH net-next 07/12] net: stmmac: replace the vlan_fail_q_en field with a flag
Date:   Wed, 21 Jun 2023 20:25:53 +0200
Message-Id: <20230621182558.544417-8-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 include/linux/stmmac.h                            | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index faa6f4ec6838..1f1bc99571a5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -560,7 +560,7 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	/* Set the maxmtu to a default of JUMBO_LEN */
 	plat->maxmtu = JUMBO_LEN;
 
-	plat->vlan_fail_q_en = true;
+	plat->flags |= STMMAC_FLAG_VLAN_FAIL_Q_EN;
 
 	/* Use the last Rx queue */
 	plat->vlan_fail_q = plat->rx_queues_to_use - 1;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d444514db07e..c5763f60c6ef 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6923,7 +6923,8 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 	if (priv->dma_cap.tsoen)
 		dev_info(priv->device, "TSO supported\n");
 
-	priv->hw->vlan_fail_q_en = priv->plat->vlan_fail_q_en;
+	priv->hw->vlan_fail_q_en =
+		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
 
 	/* Run HW quirks, if any */
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index aeb3e75dc748..155cb11b1c8a 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -210,6 +210,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_HAS_SUN8I			BIT(3)
 #define STMMAC_FLAG_TSO_EN			BIT(4)
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
+#define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -278,7 +279,6 @@ struct plat_stmmacenet_data {
 	bool en_tx_lpi_clockgating;
 	bool rx_clk_runs_in_lpi;
 	int has_xgmac;
-	bool vlan_fail_q_en;
 	u8 vlan_fail_q;
 	unsigned int eee_usecs_rate;
 	struct pci_dev *pdev;
-- 
2.39.2

