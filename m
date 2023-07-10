Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C8574D0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGJJAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjGJJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:00:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61D103
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so40381375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1688979620; x=1691571620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqDy168k4TnvbweySqHfEZPadstBh9VaBWlyLgmDoG4=;
        b=4XppJ28QA7t1JSx0zGkQYQE+lcFRMRgyUHUeOKT+Xb+l3oojEo474/baSa9CEHJVne
         46K5dUKzG2MlT2LlVRJ0H3VLK8/N6g7abwGtGNIt6+86GEtrq+WfFChXBlEH3JEzc2GJ
         8B/OV4JOl7El3bon1Tay6tQJaN5Pxb4P+TGVcZQeMta3xTx7KUmSPulUle2T9DZ50ECR
         M2EahG5SrsyoXTudBFezKfkh15XlnV5D9LVqXJrY7OfTkvhaOcpd6I37kqOqwKr2oRnq
         JQhwD/InEs072T6LGrq39NcYZaCXUr1gyUwSQVCPX6GXfQa74MrVmCDsIemdY7LkSd3l
         Pq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688979620; x=1691571620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqDy168k4TnvbweySqHfEZPadstBh9VaBWlyLgmDoG4=;
        b=Gp9HXv5lCO2o1flpxOwVm9Se5QBjsaHPAHgXE7YQfgTsWo+HbVEgea7w+PFE3f0uEk
         7H4Y+yQFZirJouWYjmZPo/LPlt3Cdes8r4uFRcePWornB062IXPK5Sz6muYMeGD8YJdy
         lCBfXlFUaa9V3kcQLwnSGRydUMnRaKMHPT/D3LeuMVljnPfca4sp+bkITsZFim8jQzNw
         IJutsqF9iBg2S0HN6IuADtZxec+3W1M/GjvvUfJPNyhB1pZrBtJaWyA7beTKAhttyee1
         +HCKRWARouO9K/nBt78k0RzKhTgqqG1EyUvvtV2TjvGCayZp6Xib7l2QlJNt+XG9m8eG
         i0eA==
X-Gm-Message-State: ABy/qLbZ08nJKF3gXqRyF1BKVtiZxc0CnOjVmmxPYpuy0shifvNhbu17
        mNzBJCr8Xo2Ndk9uKmKfm2QKPA==
X-Google-Smtp-Source: APBJJlGujN4ftiSWThZXtM38s/Sf7sj7je+92ZALarqYsh+BvUKgcmZFzFsl5agwyjWOpH818Z6ueA==
X-Received: by 2002:a1c:cc02:0:b0:3fb:4064:7e22 with SMTP id h2-20020a1ccc02000000b003fb40647e22mr4839145wmb.19.1688979620728;
        Mon, 10 Jul 2023 02:00:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6002:540:6954:abdd])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm8581045wmr.46.2023.07.10.02.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 02:00:20 -0700 (PDT)
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
Subject: [PATCH net-next v3 07/12] net: stmmac: replace the vlan_fail_q_en field with a flag
Date:   Mon, 10 Jul 2023 10:59:56 +0200
Message-Id: <20230710090001.303225-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230710090001.303225-1-brgl@bgdev.pl>
References: <20230710090001.303225-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
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
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
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

