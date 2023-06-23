Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F173B4E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjFWKLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjFWKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:10:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9BB3A8E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:09:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3113da5260dso443023f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514946; x=1690106946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwyUb1LcLxFuKvlYDOLM+hUXxmW+mTunlzrn4iVWnOo=;
        b=0mmVBYGrvOJOt+Jg5VZ0+zKW+YJWPhN5BKjhv/JMmHRQ99euFJfiQ7hDBHFm8wxebQ
         x9x3aNpCzEamSQrRKJBoatuR16RXW0X0LVYv0toaMt/AijJGi6BNlS+aG1iuPW6WAZu3
         5MURUoFjAQLiREdG+zzRQ5v9m/sc4rrD6uzBuGvVydh+4Adk0pn0Wkn3sjGblzXQAmki
         I0o+KmZru/W8iSIyURvKsEtkhcVoS7MpfRS4V41ILnn6IfuVYT46pRIM9gqAaUIlvs2I
         7CAZQiPTPKtuMhKui7b1fBzbVppytynni412lmmMYFToE3aNbmR5dbsiZ/1QPVCdNUDE
         AswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514946; x=1690106946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwyUb1LcLxFuKvlYDOLM+hUXxmW+mTunlzrn4iVWnOo=;
        b=i+eX1VNUBR+tdM62Cv2+qIGz4zAWzi6nQw37hLjUm2MVJDUmgVraKD0aT6Fu6POr6i
         hn8KR7EmPG9dzUBLhp/9boK9TV4abNB2S8c2KT6EEVL/Jes5MyOqfWXNvzv+1EdUi6nr
         2kY7C6Q8Lb2QUv1rP/PPZBTC9leoJzpgPTy7OnspzsrQVh9ICAhRnANfo3PLEpUDnV5r
         /vABqxuQd5XhOdY6N6N0G2nxlExAXY5jS38OoYrX6chwKE+j0lzr7C6JtjdBMjI83jhw
         d49z2MYmqFhmhXTaZ8zSPKIij1okjeAdrflTnzkIBgmQI62EAeCaWCTG2lX9KnljY0aT
         Qvew==
X-Gm-Message-State: AC+VfDyplQtqakXrAPnKN3/dWOPb3JDBNckhxam8UntkpLdcPrKcOTxB
        kLwogikYlmph0OzowSQOMazsWw==
X-Google-Smtp-Source: ACHHUZ6Yfbx0ZEsY9mqVJJgEUR3r5qG9URJm//hluEHwrdGGaVMBXDJc7spRqAxURWphyNTAVEpZTQ==
X-Received: by 2002:a5d:43c2:0:b0:30f:c00d:8a7 with SMTP id v2-20020a5d43c2000000b0030fc00d08a7mr3285754wrr.44.1687514946092;
        Fri, 23 Jun 2023 03:09:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe8d2000000b0030ae3a6be4asm9278100wrn.72.2023.06.23.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:09:05 -0700 (PDT)
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
Subject: [PATCH net-next v2 11/12] net: stmmac: replace the rx_clk_runs_in_lpi field with a flag
Date:   Fri, 23 Jun 2023 12:08:44 +0200
Message-Id: <20230623100845.114085-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100845.114085-1-brgl@bgdev.pl>
References: <20230623100845.114085-1-brgl@bgdev.pl>
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

