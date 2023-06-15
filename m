Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A4731895
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344797AbjFOMPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbjFOMPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:15:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8352977
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3111547c8f9so553957f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686831290; x=1689423290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JbQYFD4SJ55C6wrt2tec2lUW3s94uPPtSv2iGx8v1A=;
        b=NPRslouCBXzk7SIrAljKn7IyR9xqIXtfGiJZL/4apJ5e6x6I8VFJ/ocSyGJTYPwF3q
         QQIX8eoP5A52pDtTrvGo7go45WlUZ+Ek5hAjy3eR+Qr7/F8cAqcCeDQXlZrRaYRQhtpI
         tJk5L6l5JY+EJ61fDvSKe254zSYWxhdgwJgQjul+DU519Uw+UhKg2WFebmtOX/uBLrgv
         ESk4W+ofQ0Q4Ylkk4OLAxqC2xXk4Wi5+s9L3yeL55I9Uh4XK4+ShvanEtcuPOjwHfw+l
         /6S7unmyhIDQHcmSejeahvZ+Hm3YP1oupbGT7leLkHOYNnSJNLppsnsRzdHzd1nvvTC9
         0KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686831290; x=1689423290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JbQYFD4SJ55C6wrt2tec2lUW3s94uPPtSv2iGx8v1A=;
        b=SuYLSMX1HuK6a7TdzLJADAh1VLv/Mhb4JShkgs/+EMTTVerjoJmmPg8qcyWDj91Ax4
         miixxc+h/loc1rD0k9re1IeldfhH2/MzF1pRu3YV+BfI72nEwLi+/Ql8ADyn75oZ2Vl8
         1SkY4Yms7aKLk69gkEEhHht1gdj386O6YJkQVipAm/Vmf+TWwzbQjhTMvJUUT13jasCS
         vJxf+x1BSY9kH/8ija3bbryXY8ZRhaKXDFBfO1a6fr4IrVLburlW1kMdgVcmqzTP/o77
         O8a82WYgyoGb8X1vrwD7uxC3qQ7jnsVW7vPFpxn37FFHJHkAJY5VFmiSn21Te31VkeHy
         zzJw==
X-Gm-Message-State: AC+VfDzb1xMw9pWdlbt2UqDX/d4/7+iMEpSuDU7o5dDVrMpq9q8vrbU/
        5vSzRjRklAqqMGRMgIxhxrdsbQ==
X-Google-Smtp-Source: ACHHUZ6pIzCDZgXXG2fkbuMhxenIfdIzLNXZCGgDERQxbzMLj9r96wuVCu262cAJSZ+uUYudMcWoWg==
X-Received: by 2002:adf:ee0a:0:b0:309:38af:d300 with SMTP id y10-20020adfee0a000000b0030938afd300mr11842861wrn.33.1686831290598;
        Thu, 15 Jun 2023 05:14:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2ad4:65a7:d9f3:a64e])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d4291000000b003047ea78b42sm20918012wrq.43.2023.06.15.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:14:50 -0700 (PDT)
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
Subject: [PATCH v2 13/23] net: stmmac: dwmac-qcom-ethqos: add support for the phyaux clock
Date:   Thu, 15 Jun 2023 14:14:09 +0200
Message-Id: <20230615121419.175862-14-brgl@bgdev.pl>
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

On sa8775p, the EMAC revision is 4 and we use SGMII instead of RGMII.
There's no "rgmii" clock but there's a fourth clock under a different
name: "phyaux". Add a new field to the chip data struct that specifies
the link clock name. Default to "rgmii" for backward compatibility.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 042733b5e80b..a739e1d5c046 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -85,6 +85,7 @@ struct ethqos_emac_driver_data {
 	unsigned int num_por;
 	bool rgmii_config_loopback_en;
 	bool has_emac3;
+	const char *link_clk_name;
 	struct dwmac4_addrs dwmac4_addrs;
 };
 
@@ -92,8 +93,8 @@ struct qcom_ethqos {
 	struct platform_device *pdev;
 	void __iomem *rgmii_base;
 
-	unsigned int rgmii_clk_rate;
-	struct clk *rgmii_clk;
+	unsigned int link_clk_rate;
+	struct clk *link_clk;
 	struct phy *serdes_phy;
 	unsigned int speed;
 
@@ -156,23 +157,23 @@ static void rgmii_dump(void *priv)
 #define RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ	  (5 * 1000 * 1000UL)
 
 static void
-ethqos_update_rgmii_clk(struct qcom_ethqos *ethqos, unsigned int speed)
+ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
 {
 	switch (speed) {
 	case SPEED_1000:
-		ethqos->rgmii_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
+		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
 		break;
 
 	case SPEED_100:
-		ethqos->rgmii_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
+		ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
 		break;
 
 	case SPEED_10:
-		ethqos->rgmii_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
+		ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
 		break;
 	}
 
-	clk_set_rate(ethqos->rgmii_clk, ethqos->rgmii_clk_rate);
+	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
 }
 
 static void ethqos_set_func_clk_en(struct qcom_ethqos *ethqos)
@@ -563,7 +564,7 @@ static void ethqos_fix_mac_speed(void *priv, unsigned int speed)
 	struct qcom_ethqos *ethqos = priv;
 
 	ethqos->speed = speed;
-	ethqos_update_rgmii_clk(ethqos, speed);
+	ethqos_update_link_clk(ethqos, speed);
 	ethqos_configure(ethqos);
 }
 
@@ -597,9 +598,9 @@ static int ethqos_clks_config(void *priv, bool enabled)
 	int ret = 0;
 
 	if (enabled) {
-		ret = clk_prepare_enable(ethqos->rgmii_clk);
+		ret = clk_prepare_enable(ethqos->link_clk);
 		if (ret) {
-			dev_err(&ethqos->pdev->dev, "rgmii_clk enable failed\n");
+			dev_err(&ethqos->pdev->dev, "link_clk enable failed\n");
 			return ret;
 		}
 
@@ -610,7 +611,7 @@ static int ethqos_clks_config(void *priv, bool enabled)
 		 */
 		ethqos_set_func_clk_en(ethqos);
 	} else {
-		clk_disable_unprepare(ethqos->rgmii_clk);
+		clk_disable_unprepare(ethqos->link_clk);
 	}
 
 	return ret;
@@ -662,9 +663,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
 	ethqos->has_emac3 = data->has_emac3;
 
-	ethqos->rgmii_clk = devm_clk_get(dev, "rgmii");
-	if (IS_ERR(ethqos->rgmii_clk)) {
-		ret = PTR_ERR(ethqos->rgmii_clk);
+	ethqos->link_clk = devm_clk_get(dev, data->link_clk_name ?: "rgmii");
+	if (IS_ERR(ethqos->link_clk)) {
+		ret = PTR_ERR(ethqos->link_clk);
 		goto out_config_dt;
 	}
 
@@ -683,7 +684,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	}
 
 	ethqos->speed = SPEED_1000;
-	ethqos_update_rgmii_clk(ethqos, SPEED_1000);
+	ethqos_update_link_clk(ethqos, SPEED_1000);
 	ethqos_set_func_clk_en(ethqos);
 
 	plat_dat->bsp_priv = ethqos;
-- 
2.39.2

