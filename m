Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504F573189B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjFOMP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbjFOMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:15:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6AF1FF9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f7677a94d1so2603960e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831293; x=1689423293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8IJKtNsdBW540hrOificFtv5+xZ0NqYlT5TEOHx1Rg=;
        b=hWbCXGcv61TNwzMbg1XoJftMz5eDZjIKkarh2w/UlhGsbyobt6DtN5q3Rf0TnJtwVc
         SQhUtL+U/IB2D7suFH8Hwx51xIdC3SyINWGSnpj10yzHz0rBBtyL+g4SFF1XM1gz1O58
         Vj+U+igTIiYVeRAQIDpf3c1fSCsnx1cNKZcTj6Ud3gTLuXZ+lRkyshuUzFTR2eY/lazd
         scl2cmv+E+TzQLbZYM19LKWYKluERyjmW2H3rFQlsy/qLIoAjOpc8VwrLLqMXx7eeqmC
         AtMllLAc4AqmcyiDg2Vm/0FteXUqZ/hw/TeGpCJdJFqgxaoKfBWA9MU1/JQ62Ja68L12
         uuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831293; x=1689423293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8IJKtNsdBW540hrOificFtv5+xZ0NqYlT5TEOHx1Rg=;
        b=dfC/56qbbacTOmYSW90o5SS8SdmFZXm3If5iw7ZAmaeDT6ptyev2jzdf2c/INsBnSL
         f0Wt8ag8lSGzTCE3SjLMFXy+U/RqTkAtqx7MEiy5U/BCqKDapdzLsnAU6jFB97fPyCaI
         6N/XOMgahhSJ35oA/9gzf0dYYauFwcj5Ow3Xo205M/bRdiFzN9JQI9SX86hkRjXymVTi
         1U3MLiZEKN/RP5UEqa0GnDuhd782kxO28JrhyHG4rKFz3dgu7hlVurRM4V5PtRsPCVQT
         dWAEBobpJOituqyrhCvEkWTvU/p/QAC8N7+ijax36j/1ELyyyrQwkTIwg+KQhUMUjYT5
         79CQ==
X-Gm-Message-State: AC+VfDxRcqmZtGz0nCbfAMpbJZkMpsoNQzW9zuaDd3PBjqJAbDrDe5Fc
        dtjh9eQAqW6hjgCfi3f/1ASKJw==
X-Google-Smtp-Source: ACHHUZ7XruAIF0Kx9k8rfaa+hqAvt+jzQnQco8XpTV0z6tAB1miHHB04Cy/KHjOiLoWqUteF97rVfw==
X-Received: by 2002:a19:6706:0:b0:4f7:68eb:7c27 with SMTP id b6-20020a196706000000b004f768eb7c27mr3013726lfc.29.1686831293307;
        Thu, 15 Jun 2023 05:14:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:52 -0700 (PDT)
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
Subject: [PATCH v2 15/23] net: stmmac: dwmac-qcom-ethqos: add support for SGMII
Date:   Thu, 15 Jun 2023 14:14:11 +0200
Message-Id: <20230615121419.175862-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
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

