Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64443738EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjFUS0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjFUS0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:26:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B45119AB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-311099fac92so7227611f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687371982; x=1689963982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZwW4TXAaWjhQ6+iv6Z0bS3QoIIROteF83Ru7jzSEKU=;
        b=GbTgFCVd1tdUEHxmXzLzGsC7KBQ9AOE9OZH0cZVB6VBsnWHETNhKPwi878p8/m3N1G
         uQ6lv4OCnPWo1r6BRIztplO/hPM6ggKt7ECwgg/NiOz2SGJnAfvXcrjBQsc4x5KBFgKW
         74WXH/7vYNCtEbZIJQ12CeGlOKNX4l6jGk3MDYfKJQdjUGu6F5PiYFAjc7O3Mba8OOXd
         a6AwIRqvOg32No9ckClr2SIr52+fFPX+hNrbcj4b35vlxVSFm7/FHSU90o1DjuVhcomd
         wmF+pd9OLYKIS45INcugUZoTbhJsxt0PURWG7p2MR7WKweDeQ0Yl5NKuvFXLjLd+Zmd8
         11ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371982; x=1689963982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZwW4TXAaWjhQ6+iv6Z0bS3QoIIROteF83Ru7jzSEKU=;
        b=WI8fmiiGeeHSMkKa7HlU6F7zP0mcZ/juN+wXRnR6RG+l7LfkdxZXn6uyP5v5OcqdQA
         rbQATx9+Himu/fryl3nLADMX5gxusterEG3OywQuQp0Zvfy/kwxwuOKhG2mOaGJmFFCl
         cpNx+mxySiKoYQONEoJCyjo3xo06fOtCBanSWp/jBcyepslBn4l8tRodZQEyL9+3XP57
         zzD4b/9Cphw2O142d4WWmCRSUYflLdwfBseLiJT6Z/qFxeSOq4SnR/MqZ/bkct132heB
         o+K8Dvm/U2gnI+FlsJBum94jMEDTrDTibj2h/HYdzQMhutbFicQzfkID2XWL7nN1Cb5f
         D39Q==
X-Gm-Message-State: AC+VfDzmndMFBF2zog+9X3WU5TCnmUOOdWXoOLt/QvNWEYWAjNP2h0kj
        TijYax0SBE2FgWw/Ld8OESatkw==
X-Google-Smtp-Source: ACHHUZ5lhrxZGE0GMPB49d/8xed3TiXOYGYu4W0eGNKwP7981xUvEUCMdbw51l7mZU6pq0QAf4kcDg==
X-Received: by 2002:adf:efd1:0:b0:30f:c65a:c00 with SMTP id i17-20020adfefd1000000b0030fc65a0c00mr13306185wrp.26.1687371982580;
        Wed, 21 Jun 2023 11:26:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a69f:8ee3:6907:ccdf])
        by smtp.gmail.com with ESMTPSA id z13-20020adff74d000000b0030af15d7e41sm5176994wrp.4.2023.06.21.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 11:26:22 -0700 (PDT)
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
Subject: [PATCH net-next 08/12] net: stmmac: replace the multi_msi_en field with a flag
Date:   Wed, 21 Jun 2023 20:25:54 +0200
Message-Id: <20230621182558.544417-9-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++++---
 include/linux/stmmac.h                            | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 1f1bc99571a5..d8bcf9452197 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -953,7 +953,7 @@ static int stmmac_config_single_msi(struct pci_dev *pdev,
 
 	res->irq = pci_irq_vector(pdev, 0);
 	res->wol_irq = res->irq;
-	plat->multi_msi_en = 0;
+	plat->flags &= ~STMMAC_FLAG_MULTI_MSI_EN;
 	dev_info(&pdev->dev, "%s: Single IRQ enablement successful\n",
 		 __func__);
 
@@ -1005,7 +1005,7 @@ static int stmmac_config_multi_msi(struct pci_dev *pdev,
 	if (plat->msi_sfty_ue_vec < STMMAC_MSI_VEC_MAX)
 		res->sfty_ue_irq = pci_irq_vector(pdev, plat->msi_sfty_ue_vec);
 
-	plat->multi_msi_en = 1;
+	plat->flags |= STMMAC_FLAG_MULTI_MSI_EN;
 	dev_info(&pdev->dev, "%s: multi MSI enablement successful\n", __func__);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c5763f60c6ef..ebe82e7b50fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3711,7 +3711,7 @@ static int stmmac_request_irq(struct net_device *dev)
 	int ret;
 
 	/* Request the IRQ lines */
-	if (priv->plat->multi_msi_en)
+	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN)
 		ret = stmmac_request_irq_multi_msi(dev);
 	else
 		ret = stmmac_request_irq_single(dev);
@@ -5954,7 +5954,7 @@ static void stmmac_poll_controller(struct net_device *dev)
 	if (test_bit(STMMAC_DOWN, &priv->state))
 		return;
 
-	if (priv->plat->multi_msi_en) {
+	if (priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN) {
 		for (i = 0; i < priv->plat->rx_queues_to_use; i++)
 			stmmac_msi_intr_rx(0, &priv->dma_conf.rx_queue[i]);
 
@@ -7169,7 +7169,8 @@ int stmmac_dvr_probe(struct device *device,
 	priv->plat = plat_dat;
 	priv->ioaddr = res->addr;
 	priv->dev->base_addr = (unsigned long)res->addr;
-	priv->plat->dma_cfg->multi_msi_en = priv->plat->multi_msi_en;
+	priv->plat->dma_cfg->multi_msi_en =
+		(priv->plat->flags & STMMAC_FLAG_MULTI_MSI_EN);
 
 	priv->dev->irq = res->irq;
 	priv->wol_irq = res->wol_irq;
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 155cb11b1c8a..3365b8071686 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -211,6 +211,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_TSO_EN			BIT(4)
 #define STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP	BIT(5)
 #define STMMAC_FLAG_VLAN_FAIL_Q_EN		BIT(6)
+#define STMMAC_FLAG_MULTI_MSI_EN		BIT(7)
 
 struct plat_stmmacenet_data {
 	int bus_id;
@@ -286,7 +287,6 @@ struct plat_stmmacenet_data {
 	int ext_snapshot_num;
 	bool int_snapshot_en;
 	bool ext_snapshot_en;
-	bool multi_msi_en;
 	int msi_mac_vec;
 	int msi_wol_vec;
 	int msi_lpi_vec;
-- 
2.39.2

