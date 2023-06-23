Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4794473B4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjFWKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjFWKKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FD2D6B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:08:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31114b46d62so516439f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514933; x=1690106933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0OwBqk57PhsZ04IZ/thQPvSHwVfxueGqzoT1EHd/f0=;
        b=nsJ3vuYI6e3FoAMZ0apcFXcPaydnCwLytfC1cTdjOXl92U2Np0gHmmBW4gDWn/eTli
         g+70iNTnVMDiA0/HTa3nxxwbmFyYVXq2uPFpOv8qojKmDSbivCbwbrSysMUSgRJH7OJj
         uU0WGv0mz9Jd37gLORq9fuoUSavJ/vGaTqDF0zrASI1eiv/tD2Uxn+j68dHedd9ksHUf
         qClIx49hXVA4QgUhbLtIzJdjzQZfC5AGId4mQ8wXVD3yNq02NS4gHjfUQebERnPc9QeC
         14VEFLVpn7z27xlMrvOOsu8xnhm8DkkOkXILwevML/r1M7HYuaNRjPye1+5cP+99Niel
         FjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514933; x=1690106933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0OwBqk57PhsZ04IZ/thQPvSHwVfxueGqzoT1EHd/f0=;
        b=OmOwC/5yZNC/IAqXR9irDfxIvk5NsMLnEpLrZ8i9m7zBWbgSUJzW9NTsFuuLPUQmBC
         Ecua1m2OKcSpOa9v4XZWwj6y1O7LwMKnfK4BIeC2/BlkuGwTNrni2Y629kQT7gkHURYF
         VWZsDKh1SVK3pJOIm5pAGlMgdkjoHx1vVzFa7IcoBr8UyT8G1QyOiCCN0P/N/kwrRSq/
         i7SIA8dXPm21Z8IEiY5Ik+T6/x56f1Rax2Pe/kb24E/tbL9nkxnDVI7WRetkmTxx9vZG
         LrdbDlx/btVYTPRLFGHWcc/wyTnaj7Sy2dnSmra9BeWP66359tds5qEYK4iwOdWtk1mp
         x2hg==
X-Gm-Message-State: AC+VfDyhQQBsCAmZvPPSMEyLS0uxknav7smYuCFcHCvmgcVYVhGNORPQ
        7Gu94+rRXId6J9tgbGOHZCqdoA==
X-Google-Smtp-Source: ACHHUZ7sJmbVhtzDUmXAGvHonpXa0OHNwD2kUMCVH7fy4znQWCo+q0eqaif0U/AizZEc7ylA+KrEPQ==
X-Received: by 2002:adf:d848:0:b0:309:3bb5:7968 with SMTP id k8-20020adfd848000000b003093bb57968mr19091200wrl.16.1687514933088;
        Fri, 23 Jun 2023 03:08:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:08:52 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 03/12] net: stmmac: replace the use_phy_wol field with a flag
Date:   Fri, 23 Jun 2023 12:08:36 +0200
Message-Id: <20230623100845.114085-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 5 ++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 +-
 include/linux/stmmac.h                               | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 70e91bbef2a6..44a84a6c18ce 100644
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

