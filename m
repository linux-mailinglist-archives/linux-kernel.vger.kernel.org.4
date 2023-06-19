Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B86734FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjFSJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjFSJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:24:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1886EB0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f63ab1ac4aso3946949e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166653; x=1689758653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fg9HPnaQs4uw+/BUPOC0tDtzoyUDTGe4TgouVRsxWgE=;
        b=ocglfYYfqa/esuJaIEFrBWiWSewxOHkZ7OEhJHLgI5q8jKaLsSyw8JW04olIdi2aup
         ANPQQzkk7ovLeeBJnUPq++WlWepM8c8hOsK/VertiQZfktne6BR+JSZldM0hyTybZZGG
         PyxaqYCyOqyOjY497idphdkO3chcuC1xGEhZt+janAipYdunTLLmGfhh5ljjJMOIct4d
         M60COR6lJlIiSSMzNiGkWbog7Q1hiUdBIgCElSYiUn1vHTXw3XoYhdGyo+WRHPvWJwo6
         SG4e5xlVURsBPEbPwH65Y1DKxU7FSlraZRtFHXgEn0AVqAnYIPRHgTFWNG8EO6Ni+3uH
         eAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166653; x=1689758653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fg9HPnaQs4uw+/BUPOC0tDtzoyUDTGe4TgouVRsxWgE=;
        b=UxVo9NyzVgO+qwqDjF06yMdzp0qB960MuCIeS5YnHwPOMb0XXSj4aEU5ygCNTdJnck
         shPvvDZpCFXWe40zm7pfV+16mx4ZyrzGcNVldE2LNOlgFSvHa6GFswFy0nxmQAREa9kj
         /w7GUMcHeQgLPgNM/AfNA0vl3SSwUixfVZDCQFV++i/kmnaM+6YzBwkJDuL7PBDHy5YL
         irSal1dNs4P8L20sjrgPAbIgzI5/HvQb6PLav/HJhOwRuG4BldFNL9iwAIXfnAd2Jr/w
         VaHvvaG/axV/tZKDEYZZOyF7kIRWFqPBs2FU4SxY3QNY4NU3A/VjIwG49Ez3VbVw3dA2
         Q2qg==
X-Gm-Message-State: AC+VfDx+dChj7gABuyFTPx3YOVva2ReFYUc5gff6ST4IUN2n2T7zERzI
        V5pi0MBjZ3Laz19KzU8dOb0U9g==
X-Google-Smtp-Source: ACHHUZ50KTGQ8uOARkF0XdY7qCU86fgrDX9isO/ItNJnjN9lmgPmxRhe+lHdUd5ugqf+B76ovYaoHQ==
X-Received: by 2002:a19:f201:0:b0:4f7:b640:fa40 with SMTP id q1-20020a19f201000000b004f7b640fa40mr4151520lfh.43.1687166653342;
        Mon, 19 Jun 2023 02:24:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm10045229wmj.42.2023.06.19.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:12 -0700 (PDT)
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
Subject: [RESEND PATCH v2 01/14] net: stmmac: dwmac-qcom-ethqos: shrink clock code with devres
Date:   Mon, 19 Jun 2023 11:23:49 +0200
Message-Id: <20230619092402.195578-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230619092402.195578-1-brgl@bgdev.pl>
References: <20230619092402.195578-1-brgl@bgdev.pl>
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

We can use a devm action to completely drop the remove callback and use
stmmac_pltfr_remove() directly for remove. We can also drop one of the
goto labels.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index c801838fae2a..2da0738eed24 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -586,6 +586,11 @@ static int ethqos_clks_config(void *priv, bool enabled)
 	return ret;
 }
 
+static void ethqos_clks_disable(void *data)
+{
+	ethqos_clks_config(data, false);
+}
+
 static int qcom_ethqos_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -636,6 +641,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_mem;
 
+	ret = devm_add_action_or_reset(&pdev->dev, ethqos_clks_disable, ethqos);
+	if (ret)
+		goto err_mem;
+
 	ethqos->speed = SPEED_1000;
 	ethqos_update_rgmii_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);
@@ -653,27 +662,16 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-		goto err_clk;
+		goto err_mem;
 
 	return ret;
 
-err_clk:
-	ethqos_clks_config(ethqos, false);
-
 err_mem:
 	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
 }
 
-static void qcom_ethqos_remove(struct platform_device *pdev)
-{
-	struct qcom_ethqos *ethqos = get_stmmac_bsp_priv(&pdev->dev);
-
-	stmmac_pltfr_remove(pdev);
-	ethqos_clks_config(ethqos, false);
-}
-
 static const struct of_device_id qcom_ethqos_match[] = {
 	{ .compatible = "qcom,qcs404-ethqos", .data = &emac_v2_3_0_data},
 	{ .compatible = "qcom,sc8280xp-ethqos", .data = &emac_v3_0_0_data},
@@ -684,7 +682,7 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
 
 static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
-	.remove_new = qcom_ethqos_remove,
+	.remove_new = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "qcom-ethqos",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.39.2

