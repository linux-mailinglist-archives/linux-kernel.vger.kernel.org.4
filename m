Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539E734FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjFSJZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFSJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:24:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBEB1A3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:26 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso3999873e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166665; x=1689758665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8IJKtNsdBW540hrOificFtv5+xZ0NqYlT5TEOHx1Rg=;
        b=zzGOUZ2uzsuPMUj7xgWml1QV/Tr6XdMyXmX+xc7AZMeyVzpd1Th/8FJfRjlZ6b/Uq/
         yd4EJjeffDrgCmQDIGR0pr9ZiQvZWe+HA2qtXVrxVCh7/mD/wsEn0fQfZnwDCkYwyM6L
         fBJSc0nl9690FCVc7nwMmmckb/MTr8dby/FMQCLaNvowlkJBNVOwKp05zJ1E8vhUPKna
         UTwVvG7tUC7R85ULg2ypelbyIxlnqpSSYMHTr85wDJ6h59nAlVONIgJtfu0twFOD4djT
         07J8Krl5X42jZW97hTmWad2tLrnGOeEMKJyd4zXwM22fGU9oF5i0/K+qXseiInCCOJSO
         60kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166665; x=1689758665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8IJKtNsdBW540hrOificFtv5+xZ0NqYlT5TEOHx1Rg=;
        b=kfTjJH9W6fmWtykx6225+KFin7045JK4946fLY+lh5m5H6lFmRfoao3tv1Lp5iGpxa
         ZXqUzjkXzGagHRVxhFsbID2p1a4bLnth3GCd3jvzAYy6VCTntGMy52P/prhqlfalcDqr
         8JWFm4VhGfzUaTMJcIpMAWIYNUUrddB4IgphjsAiH8dA1vRzPELPFTC3ehhV6lT9/gNk
         cMcdbNaTRb24ftklucXmJpEUXX8SjM1PuoikXAxmyu1cLFMiJ31UgY97D1ypr/WK1nHV
         LCF3ko2X1Im9pP/Hg3kxMt8CmSTSVQMEn4A6CnI4zxsvnX1A/IcWSG9GghwIB1AUH2aL
         L1zA==
X-Gm-Message-State: AC+VfDx2/tHdDeu6lHA6G5zpcHUdme6qEwRU6RDcPwsxQE+jpy9tBobG
        9SRl2PzNhG9l4fGETBAefGf9Nw==
X-Google-Smtp-Source: ACHHUZ6Tcbw6KE5SoygObxk8oAVfpAVRz4iKBToqkTlVGVNorPJd1Ll1aCOQBwTd8HhnaFWn+tOQbw==
X-Received: by 2002:a19:7718:0:b0:4f8:6d54:72f9 with SMTP id s24-20020a197718000000b004f86d5472f9mr1308228lfc.61.1687166665212;
        Mon, 19 Jun 2023 02:24:25 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm10045229wmj.42.2023.06.19.02.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:24 -0700 (PDT)
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
Subject: [RESEND PATCH v2 11/14] net: stmmac: dwmac-qcom-ethqos: add support for SGMII
Date:   Mon, 19 Jun 2023 11:23:59 +0200
Message-Id: <20230619092402.195578-12-brgl@bgdev.pl>
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

On sa8775p the MAC is connected to the external PHY over SGMII so add
support for it to the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 0ececc951528..bdf59a179f87 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -75,6 +75,10 @@
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
 
 	unsigned int link_clk_rate;
@@ -559,6 +564,33 @@ static int ethqos_configure_rgmii(struct qcom_ethqos *ethqos)
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
@@ -663,6 +695,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		ethqos->configure_func = ethqos_configure_rgmii;
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		ethqos->configure_func = ethqos_configure_sgmii;
+		break;
 	case -ENODEV:
 		ret = -ENODEV;
 		goto out_config_dt;
@@ -678,6 +713,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		goto out_config_dt;
 	}
 
+	ethqos->mac_base = stmmac_res.addr;
+
 	data = of_device_get_match_data(dev);
 	ethqos->por = data->por;
 	ethqos->num_por = data->num_por;
-- 
2.39.2

