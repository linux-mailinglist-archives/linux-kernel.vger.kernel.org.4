Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FE7734FF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjFSJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjFSJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:24:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD8E73
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9083d8849so24444365e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166669; x=1689758669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djSwdyLw8xp+3Hm8dkeIbLA/6vtbTk1lxohdgQnQb6c=;
        b=bO9aSgZagrEBEIkG1MmJMrxVAwa3ITE67+vzozCxbo5GX2JvX6IfKatyAJc5WJTIvm
         gxOMs82gAZNA9K/kxyH7hJ0VA6YfM2ZcesWir5TIPi/SZK0J0TVI9ojxjAVP37+mIOww
         esqOSUtqQ3974YYJGBFNxj2Oy+mGr8sfCcEgJOlHJkJe/w5ntjLWJBao0H95atJpHDN9
         XmtC25ManCI1DayUnp8V3MT+CiMzz3jAjofZoWchpuKpuZmtAWK370xvuOe8+AEc7pr3
         LgrDipRfrSjXz5I75C18iGOW7ToIphj14Bt5hYJCYlwepgEAPJEp3v/Q6y1r3YVHTBJa
         TZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166669; x=1689758669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djSwdyLw8xp+3Hm8dkeIbLA/6vtbTk1lxohdgQnQb6c=;
        b=cd7+2VvxsGo1DAUXBTfOfp5adfUmBDu0m6FIisSRwEzetF3ZStuosThZZEAlI8GLFZ
         gG5H/NPaxzuLtOyxDUH9QgQZRsXAG9qhGolxFGNNJVijJ3tP2frLz6BeFChEtOyzu+nZ
         bgoO/slemwV5SlVx8gwaOmzVboBGaH/naZfaucbc7NKKpcJcl7xugiGWoXW9MwHPLBV5
         wozTxGKMQ5xxWycWve6o5dyU6x1uTO0CHLM/PUKixYKQ2Q1HZgQai1hovn7bCtU4HTB6
         DaDx9YtuHwzLyeL0axXWfEEnKlSgFfmE+Jlt6nace6PQdJJqxRmxF/0ff2NHmoi3run5
         i6sQ==
X-Gm-Message-State: AC+VfDypLIecxt7jy/3UpUa2hm3RkFQH/9iJGxe0idQRRmwCwbzbIsf7
        8eld+EJp9I3q3lXsMDMQvjlweg==
X-Google-Smtp-Source: ACHHUZ55yZarh34rxCXvP4nDHHz58CibAdCjSGMHZcCrATZRRuYKSxCHkofo7a1tu72C48EhXAMc9g==
X-Received: by 2002:a05:600c:b4e:b0:3f7:fcca:5e32 with SMTP id k14-20020a05600c0b4e00b003f7fcca5e32mr8241646wmr.17.1687166668922;
        Mon, 19 Jun 2023 02:24:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm10045229wmj.42.2023.06.19.02.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:28 -0700 (PDT)
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
Subject: [RESEND PATCH v2 14/14] net: stmmac: dwmac-qcom-ethqos: add support for emac4 on sa8775p platforms
Date:   Mon, 19 Jun 2023 11:24:02 +0200
Message-Id: <20230619092402.195578-15-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619092402.195578-1-brgl@bgdev.pl>
References: <20230619092402.195578-1-brgl@bgdev.pl>
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

sa8775p uses EMAC version 4, add the relevant defines, rename the
has_emac3 switch to has_emac_ge_3 (has emac greater-or-equal than 3)
and add the new compatible.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 65 +++++++++++++++----
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index bdf59a179f87..fa0fc53c56a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -88,8 +88,9 @@ struct ethqos_emac_driver_data {
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
-	bool has_emac3;
+	bool has_emac_ge_3;
 	const char *link_clk_name;
+	bool has_integrated_pcs;
 	struct dwmac4_addrs dwmac4_addrs;
 };
 
@@ -108,7 +109,7 @@ struct qcom_ethqos {
 	const struct ethqos_emac_por *por;
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
-	bool has_emac3;
+	bool has_emac_ge_3;
 };
 
 static int rgmii_readl(struct qcom_ethqos *ethqos, unsigned int offset)
@@ -202,7 +203,7 @@ static const struct ethqos_emac_driver_data emac_v2_3_0_data = {
 	.por = emac_v2_3_0_por,
 	.num_por = ARRAY_SIZE(emac_v2_3_0_por),
 	.rgmii_config_loopback_en = true,
-	.has_emac3 = false,
+	.has_emac_ge_3 = false,
 };
 
 static const struct ethqos_emac_por emac_v2_1_0_por[] = {
@@ -218,7 +219,7 @@ static const struct ethqos_emac_driver_data emac_v2_1_0_data = {
 	.por = emac_v2_1_0_por,
 	.num_por = ARRAY_SIZE(emac_v2_1_0_por),
 	.rgmii_config_loopback_en = false,
-	.has_emac3 = false,
+	.has_emac_ge_3 = false,
 };
 
 static const struct ethqos_emac_por emac_v3_0_0_por[] = {
@@ -234,7 +235,41 @@ static const struct ethqos_emac_driver_data emac_v3_0_0_data = {
 	.por = emac_v3_0_0_por,
 	.num_por = ARRAY_SIZE(emac_v3_0_0_por),
 	.rgmii_config_loopback_en = false,
-	.has_emac3 = true,
+	.has_emac_ge_3 = true,
+	.dwmac4_addrs = {
+		.dma_chan = 0x00008100,
+		.dma_chan_offset = 0x1000,
+		.mtl_chan = 0x00008000,
+		.mtl_chan_offset = 0x1000,
+		.mtl_ets_ctrl = 0x00008010,
+		.mtl_ets_ctrl_offset = 0x1000,
+		.mtl_txq_weight = 0x00008018,
+		.mtl_txq_weight_offset = 0x1000,
+		.mtl_send_slp_cred = 0x0000801c,
+		.mtl_send_slp_cred_offset = 0x1000,
+		.mtl_high_cred = 0x00008020,
+		.mtl_high_cred_offset = 0x1000,
+		.mtl_low_cred = 0x00008024,
+		.mtl_low_cred_offset = 0x1000,
+	},
+};
+
+static const struct ethqos_emac_por emac_v4_0_0_por[] = {
+	{ .offset = RGMII_IO_MACRO_CONFIG,	.value = 0x40c01343 },
+	{ .offset = SDCC_HC_REG_DLL_CONFIG,	.value = 0x2004642c },
+	{ .offset = SDCC_HC_REG_DDR_CONFIG,	.value = 0x80040800 },
+	{ .offset = SDCC_HC_REG_DLL_CONFIG2,	.value = 0x00200000 },
+	{ .offset = SDCC_USR_CTL,		.value = 0x00010800 },
+	{ .offset = RGMII_IO_MACRO_CONFIG2,	.value = 0x00002060 },
+};
+
+static const struct ethqos_emac_driver_data emac_v4_0_0_data = {
+	.por = emac_v4_0_0_por,
+	.num_por = ARRAY_SIZE(emac_v3_0_0_por),
+	.rgmii_config_loopback_en = false,
+	.has_emac_ge_3 = true,
+	.link_clk_name = "phyaux",
+	.has_integrated_pcs = true,
 	.dwmac4_addrs = {
 		.dma_chan = 0x00008100,
 		.dma_chan_offset = 0x1000,
@@ -275,7 +310,7 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 	rgmii_updatel(ethqos, SDCC_DLL_CONFIG_DLL_EN,
 		      SDCC_DLL_CONFIG_DLL_EN, SDCC_HC_REG_DLL_CONFIG);
 
-	if (!ethqos->has_emac3) {
+	if (!ethqos->has_emac_ge_3) {
 		rgmii_updatel(ethqos, SDCC_DLL_MCLK_GATING_EN,
 			      0, SDCC_HC_REG_DLL_CONFIG);
 
@@ -316,7 +351,7 @@ static int ethqos_dll_configure(struct qcom_ethqos *ethqos)
 	rgmii_updatel(ethqos, SDCC_DLL_CONFIG2_DDR_CAL_EN,
 		      SDCC_DLL_CONFIG2_DDR_CAL_EN, SDCC_HC_REG_DLL_CONFIG2);
 
-	if (!ethqos->has_emac3) {
+	if (!ethqos->has_emac_ge_3) {
 		rgmii_updatel(ethqos, SDCC_DLL_CONFIG2_DLL_CLOCK_DIS,
 			      0, SDCC_HC_REG_DLL_CONFIG2);
 
@@ -386,7 +421,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos)
 		/* PRG_RCLK_DLY = TCXO period * TCXO_CYCLES_CNT / 2 * RX delay ns,
 		 * in practice this becomes PRG_RCLK_DLY = 52 * 4 / 2 * RX delay ns
 		 */
-		if (ethqos->has_emac3) {
+		if (ethqos->has_emac_ge_3) {
 			/* 0.9 ns */
 			rgmii_updatel(ethqos, SDCC_DDR_CONFIG_PRG_RCLK_DLY,
 				      115, SDCC_HC_REG_DDR_CONFIG);
@@ -421,7 +456,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos)
 		rgmii_updatel(ethqos, RGMII_CONFIG2_RSVD_CONFIG15,
 			      0, RGMII_IO_MACRO_CONFIG2);
 
-		if (ethqos->has_emac3)
+		if (ethqos->has_emac_ge_3)
 			rgmii_updatel(ethqos, RGMII_CONFIG2_RX_PROG_SWAP,
 				      RGMII_CONFIG2_RX_PROG_SWAP,
 				      RGMII_IO_MACRO_CONFIG2);
@@ -461,7 +496,7 @@ static int ethqos_rgmii_macro_init(struct qcom_ethqos *ethqos)
 			      RGMII_IO_MACRO_CONFIG);
 		rgmii_updatel(ethqos, RGMII_CONFIG2_RSVD_CONFIG15,
 			      0, RGMII_IO_MACRO_CONFIG2);
-		if (ethqos->has_emac3)
+		if (ethqos->has_emac_ge_3)
 			rgmii_updatel(ethqos, RGMII_CONFIG2_RX_PROG_SWAP,
 				      RGMII_CONFIG2_RX_PROG_SWAP,
 				      RGMII_IO_MACRO_CONFIG2);
@@ -510,7 +545,7 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
 	rgmii_updatel(ethqos, SDCC_DLL_CONFIG_PDN,
 		      SDCC_DLL_CONFIG_PDN, SDCC_HC_REG_DLL_CONFIG);
 
-	if (ethqos->has_emac3) {
+	if (ethqos->has_emac_ge_3) {
 		if (ethqos->speed == SPEED_1000) {
 			rgmii_writel(ethqos, 0x1800000, SDCC_TEST_CTL);
 			rgmii_writel(ethqos, 0x2C010800, SDCC_USR_CTL);
@@ -540,7 +575,7 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
 			      SDCC_HC_REG_DLL_CONFIG);
 
 		/* Set USR_CTL bit 26 with mask of 3 bits */
-		if (!ethqos->has_emac3)
+		if (!ethqos->has_emac_ge_3)
 			rgmii_updatel(ethqos, GENMASK(26, 24), BIT(26),
 				      SDCC_USR_CTL);
 
@@ -719,7 +754,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->por = data->por;
 	ethqos->num_por = data->num_por;
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
-	ethqos->has_emac3 = data->has_emac3;
+	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
 	if (IS_ERR(ethqos->link_clk)) {
@@ -749,12 +784,13 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->fix_mac_speed = ethqos_fix_mac_speed;
 	plat_dat->dump_debug_regs = rgmii_dump;
 	plat_dat->has_gmac4 = 1;
-	if (ethqos->has_emac3)
+	if (ethqos->has_emac_ge_3)
 		plat_dat->dwmac4_addrs = &data->dwmac4_addrs;
 	plat_dat->pmt = 1;
 	plat_dat->tso_en = of_property_read_bool(np, "snps,tso");
 	if (of_device_is_compatible(np, "qcom,qcs404-ethqos"))
 		plat_dat->rx_clk_runs_in_lpi = 1;
+	plat_dat->has_integrated_pcs = data->has_integrated_pcs;
 
 	if (ethqos->serdes_phy) {
 		plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
@@ -775,6 +811,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 static const struct of_device_id qcom_ethqos_match[] = {
 	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
+	{ .compatible = "qcom,sa8775p-ethqos", .data = &emac_v4_0_0_data},
 	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
 	{ .compatible = "qcom,sm8150-ethqos", .data = &emac_v2_1_0_data},
 	{ }
-- 
2.39.2

