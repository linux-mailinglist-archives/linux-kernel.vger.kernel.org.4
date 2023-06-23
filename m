Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5685073B47F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjFWKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjFWKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:04:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58441211D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so469843e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514671; x=1690106671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tzkZoWqIdrFL84uinSijWf7BmQOJpWDfpkjROxZd1c8=;
        b=4RrfktXNAJwAB4YKI7AhrOTkkSSFAJtDqMbawS4RLXRU5DinHjF7CTFSigQBHC7iun
         +YDIaduuKs4+CPc704rh4dOqG2+uib8T2ARzA+eYiQpVsSrDsoHs5MhJ92gGnEQWWCOU
         ws1GuZVq7hs+GHqFW8H2gdvjHti3LyRGY/fB9UNR8ukBvoeAFkKUQS18FrBNBD+svGeE
         FD+xzGUuAWQZ668fyg/Kh1z3zUkfkgGZ2GTc/DuKGntnrIMl/fhhxWGStGXzDoGTUyFP
         +DFDoVMcbMNEp7XnnEpjRW3tZSOkz9TNN7fEiGQi1Imc6TrAGY8bKuiDqI2DoGqUfSls
         zczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514671; x=1690106671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzkZoWqIdrFL84uinSijWf7BmQOJpWDfpkjROxZd1c8=;
        b=Ma4OFkBct9dvpOiqzT9CeYVTPFIIY4UxayqhDraKFKTuD257fbifb8c7RL42/inv7i
         B7j8fy2UcBW1kolHZvHoKpWAhKWsZKo4k2Q8IzOfQ5Bvdsoy/XEm7MGomWoyHwoXm+L9
         JlrM5/eURXR0V8N6zwkaKXN2N6392UhEEYzTHuPaHBQG5f8GrpfK+QVXz6k/uEbFlMRO
         eE0sWkA3DHWxcYBO3Srq6x8keCN0z25VCO4nKvhTUimFDflUczAqX4OmCRCgy+cVAEzA
         s3IGovAnqUCo3ozq24R0Sef9iHr1AIk8i1/4RNpEXYjntPrC6Y6p+epVsaMIZ7LNRn2N
         fguQ==
X-Gm-Message-State: AC+VfDw/PXqkbMX1CxyJsYb+6djWLl382vE7h5xc82fviZel+s+q4v54
        TcqPUxdKG/lnXuDy3i5nscrBSB4wDcNwC8m5kkc=
X-Google-Smtp-Source: ACHHUZ4hc5yse0n/OkIOTa2lRRWP3QII9JIGZqIe33wxnA+Dle/2IPmFy08WfsqOBtiEmCK5yv4D2g==
X-Received: by 2002:a05:6512:2213:b0:4f9:657e:3ea4 with SMTP id h19-20020a056512221300b004f9657e3ea4mr4547946lfu.43.1687514671192;
        Fri, 23 Jun 2023 03:04:31 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 09/11] net: stmmac: dwmac-qco-ethqos: use devm_stmmac_probe_config_dt()
Date:   Fri, 23 Jun 2023 12:04:15 +0200
Message-Id: <20230623100417.93592-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
References: <20230623100417.93592-1-brgl@bgdev.pl>
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

Significantly simplify the driver's probe() function by using the devres
variant of stmmac_probe_config_dt(). This allows to drop the goto jumps
entirely.

The remove_new() callback now needs to be switched to
stmmac_pltfr_remove_no_dt().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 49 ++++++-------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index fa0fc53c56a3..7b9fbcb8d84d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -708,7 +708,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	plat_dat = stmmac_probe_config_dt(pdev, stmmac_res.mac);
+	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
 	if (IS_ERR(plat_dat)) {
 		dev_err(dev, "dt configuration failed\n");
 		return PTR_ERR(plat_dat);
@@ -717,10 +717,8 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	plat_dat->clks_config = ethqos_clks_config;
 
 	ethqos = devm_kzalloc(dev, sizeof(*ethqos), GFP_KERNEL);
-	if (!ethqos) {
-		ret = -ENOMEM;
-		goto out_config_dt;
-	}
+	if (!ethqos)
+		return -ENOMEM;
 
 	ethqos->phy_mode = device_get_phy_mode(dev);
 	switch (ethqos->phy_mode) {
@@ -734,19 +732,15 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
 	case -ENODEV:
-		ret = -ENODEV;
-		goto out_config_dt;
+		return -ENODEV;
 	default:
-		ret = -EINVAL;
-		goto out_config_dt;
+		return -EINVAL;
 	}
 
 	ethqos->pdev = pdev;
 	ethqos->rgmii_base = devm_platform_ioremap_resource_byname(pdev, "rgmii");
-	if (IS_ERR(ethqos->rgmii_base)) {
-		ret = PTR_ERR(ethqos->rgmii_base);
-		goto out_config_dt;
-	}
+	if (IS_ERR(ethqos->rgmii_base))
+		return PTR_ERR(ethqos->rgmii_base);
 
 	ethqos->mac_base = stmmac_res.addr;
 
@@ -757,24 +751,20 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->has_emac_ge_3 = data->has_emac_ge_3;
 
 	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
-	if (IS_ERR(ethqos->link_clk)) {
-		ret = PTR_ERR(ethqos->link_clk);
-		goto out_config_dt;
-	}
+	if (IS_ERR(ethqos->link_clk))
+		return PTR_ERR(ethqos->link_clk);
 
 	ret = ethqos_clks_config(ethqos, true);
 	if (ret)
-		goto out_config_dt;
+		return ret;
 
 	ret = devm_add_action_or_reset(dev, ethqos_clks_disable, ethqos);
 	if (ret)
-		goto out_config_dt;
+		return ret;
 
 	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
-	if (IS_ERR(ethqos->serdes_phy)) {
-		ret = PTR_ERR(ethqos->serdes_phy);
-		goto out_config_dt;
-	}
+	if (IS_ERR(ethqos->serdes_phy))
+		return PTR_ERR(ethqos->serdes_phy);
 
 	ethqos->speed = SPEED_1000;
 	ethqos_update_link_clk(ethqos, SPEED_1000);
@@ -797,16 +787,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 		plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
 	}
 
-	ret = stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto out_config_dt;
-
-	return ret;
-
-out_config_dt:
-	stmmac_remove_config_dt(pdev, plat_dat);
-
-	return ret;
+	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id qcom_ethqos_match[] = {
@@ -820,7 +801,7 @@ MODULE_DEVICE_TABLE(of, qcom_ethqos_match);
 
 static struct platform_driver qcom_ethqos_driver = {
 	.probe  = qcom_ethqos_probe,
-	.remove_new = stmmac_pltfr_remove,
+	.remove_new = stmmac_pltfr_remove_no_dt,
 	.driver = {
 		.name           = "qcom-ethqos",
 		.pm		= &stmmac_pltfr_pm_ops,
-- 
2.39.2

