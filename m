Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1A738EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjFUS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjFUS0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227F1988
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3110a5f2832so5946117f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371976; x=1689963976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzNmZCXlSWOYlmr4PSAR1znItM6ZQApvKlAxUdPBEws=;
        b=lhB4O4R+QgPqC82mKzgnaE06t2sQ47iDhSESMJWL1zy6rkjIOJWFo5+Gwh6GhWI+uz
         ey65qccVH09imlh0PF+C414coaq8d9BYz6AGcWp+N1TjTa527238y6siI9gidbDAeCDU
         76zOQT5G9rsHAIoAkaGK9dcjoG8hZTytnrA2W4ANsAAHwDkNGjkdecHfvL4ZQMlhU19k
         1Amyr57UncHC2/RYS3R31PHdyz3pgXXYZbKG+kkOvYDCysRw6TqqPSl2OFHKmQs8I75+
         DmuchEoqtEMw9cVFWpn2neqSd0vqINszD70ESXoz5UALEbRcehho/0PpCMbvdpjZEcX2
         AiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371976; x=1689963976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzNmZCXlSWOYlmr4PSAR1znItM6ZQApvKlAxUdPBEws=;
        b=MOybw/jUi5bgZg/qOO4T5DAjtIxP//NJGqbvzr/TKFYcq2g6LaLG8nbEtTXLVyiFP9
         YI19GJ1QDht3+q32nXATz92bOqb9hCPQo8qpgGucDo2taKD7nZw6JoSG7GH80TfeFr5p
         ndM7Y98XlydkLmQRQQy5QcFEr8irqySWBbZyOyEpJmqeUT6vw3BrbtKmRbIeEpfogc6y
         3RCBabWvwmDfDAvI2riC2Y7R+9Noa89eCu1lgw1kzeIyo7s9vhQXTi84L9zDaK/uAVNN
         gKT+2ocVEqdx3AVVW8TUSepxJKHhHgkm+Rq7wR7RuZ7+5r7fI+tYJ8O4RsHSVGdcyo1k
         J2LQ==
X-Gm-Message-State: AC+VfDyw8Y+MdetaLyZU3ZQtnuRi4Ighv//T+0i5ZXvsag+NqvnxNoWe
        HErFKBG43OyXKC/faM4pvZrQUg==
X-Google-Smtp-Source: ACHHUZ4HCkDRLe8HCWmsjiSHsLkUzqg1IZqv9rJNe6nBf1jtTA0Q2s1/Z9TWBYU3unjBDb78RiLtCg==
X-Received: by 2002:a5d:620e:0:b0:30f:c050:88dd with SMTP id y14-20020a5d620e000000b0030fc05088ddmr18903240wru.8.1687371976794;
        Wed, 21 Jun 2023 11:26:16 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:16 -0700 (PDT)
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
Subject: [PATCH net-next 04/12] net: stmmac: replace the has_sun8i field with a flag
Date:   Wed, 21 Jun 2023 20:25:50 +0200
Message-Id: <20230621182558.544417-5-brgl@bgdev.pl>
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

