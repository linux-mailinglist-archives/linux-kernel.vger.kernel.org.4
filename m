Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C375A72BCA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjFLJcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbjFLJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:30:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38B04EC5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso4792336e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561891; x=1689153891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu6Hj8PYw+w5Smr4EMXMmc+WADcALPo6VlL++XAkFkQ=;
        b=KgztPCwzL7tQDDy797REtkk6bu9zfPBV1CItjq2k4V9QtMfVqe7RQDCXQ+XLPJ+Tnu
         as8pYDlZiiycSsvjx0FeTP5FWiqBhfePAPUFcTmRWIbqULZz4GzxMxSYa6wh8l/ZdnX8
         19eJideh6H6lNdJyPVL8ku4IHc43sCPTWCXZwSYq9N9lKCdNc1tcn/DsRUUbRH4jkopC
         4m3O+6XeduNEMSUdeIrKAAqOR2554WPPuGg8oI5fw2O+aNCrNLvyIgTVYq+T3am/k4Ak
         GtUlY9r08SUm7vHfrQ4KlyXcElHqGru24EzP2b4Dg5v4sIQkXWI9ZdASbzNYVUtZhgM6
         Y07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561891; x=1689153891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gu6Hj8PYw+w5Smr4EMXMmc+WADcALPo6VlL++XAkFkQ=;
        b=QQuUDLE6nuRFk36J7txZ/esZ9JvwbxEkM9HujbkvSL4/TNBVizT+7ccB2aetnhHUcO
         CiPyCALy/rJ1TPyu1YID45BMBxU2v1fsWdzQRLQnT42dIbyui13l50Myj7fM8gxiqCGp
         5ZDMC0bze567+ZY6ns1Z4EqHSCa7QOqW5CG+2bIK9mxtI7BNDg+BYXWKkpd+NN4UL+1N
         xWqR7GBWWZN/62erdy6L6vF0EccrhtCQjVVrcNpkQyRncE+ev7zyOfRhDPnM+yvXBa8I
         Fz1jClDgZ4KX6FsjGw5mBsWsB2V2EamuxNfmBCq3PxLWtE5FDw9DXYowxGSFr9lFe26S
         XRcw==
X-Gm-Message-State: AC+VfDw11ebUr66DakQ4VrmaFl5mj3daJb6uE3IFrhYmnz6S+Q5MY8bn
        ZTEH6D/6BdB8wg0r1XoU36m2iA==
X-Google-Smtp-Source: ACHHUZ5PHuc52bGQHAJIwWPqQKW+7sxCfjsz+LzdXKKiWQG+l/yIe4x3JNrpAOl59yTb3Z2wEnrkzw==
X-Received: by 2002:ac2:5b11:0:b0:4f3:b32d:f739 with SMTP id v17-20020ac25b11000000b004f3b32df739mr4457643lfn.19.1686561891077;
        Mon, 12 Jun 2023 02:24:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:50 -0700 (PDT)
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
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 17/26] net: stmmac: dwmac-qcom-ethqos: add support for SGMII
Date:   Mon, 12 Jun 2023 11:23:46 +0200
Message-Id: <20230612092355.87937-18-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
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

On sa8775p the MAC is connected to the external PHY over SGMII so add
support for it to the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2f96f2c11278..247e3888cca0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -76,6 +76,10 @@
 #define RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL	BIT(6)
 #define RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN	BIT(5)
 
+/* MAC_CTRL_REG bits */
+#define ETHQOS_MAC_CTRL_SPEED_MODE		BIT(14)
+#define ETHQOS_MAC_CTRL_PORT_SEL		BIT(15)
+
 struct ethqos_emac_por {
 	unsigned int offset;
 	unsigned int value;
@@ -92,6 +96,7 @@ struct ethqos_emac_driver_data {
 struct qcom_ethqos {
 	struct platform_device *pdev;
 	void __iomem *rgmii_base;
+	void __iomem *mac_base;
 	int (*configure_func)(struct qcom_ethqos *ethqos);
 
 	unsigned int rgmii_clk_rate;
@@ -561,6 +566,33 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
 	return 0;
 }
 
+static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
+{
+	int val;
+
+	val = readl(ethqos->mac_base + MAC_CTRL_REG);
+
+	switch (ethqos->speed) {
+	case SPEED_1000:
+		val &= ~ETHQOS_MAC_CTRL_PORT_SEL;
+		rgmii_updatel(ethqos, RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_CONFIG2_RGMII_CLK_SEL_CFG,
+			      RGMII_IO_MACRO_CONFIG2);
+		break;
+	case SPEED_100:
+		val |= ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE;
+		break;
+	case SPEED_10:
+		val |= ETHQOS_MAC_CTRL_PORT_SEL;
+		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
+		break;
+	}
+
+	writel(val, ethqos->mac_base + MAC_CTRL_REG);
+
+	return val;
+}
+
 static int ethqos_configure(struct qcom_ethqos *ethqos)
 {
 	return ethqos->configure_func(ethqos);
@@ -673,6 +705,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		ethqos->configure_func = ethqos_configure_rgmii;
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		ethqos->configure_func = ethqos_configure_sgmii;
+		break;
 	case -ENODEV:
 		ret = -ENODEV;
 		goto out_config_dt;
@@ -688,6 +723,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		goto out_config_dt;
 	}
 
+	ethqos->mac_base = stmmac_res.addr;
+
 	data = of_device_get_match_data(dev);
 	ethqos->por = data->por;
 	ethqos->num_por = data->num_por;
-- 
2.39.2

