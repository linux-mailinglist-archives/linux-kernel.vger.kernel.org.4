Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24172BC96
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjFLJbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjFLJaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:30:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9CC30DB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so4904744e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561885; x=1689153885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jrHnz846sKSAurRWEc8dAdWpKHrp05uQC5lgmZ9ncs=;
        b=Wv5XrDDvy4LtM5L7MWCbVK9pWAo3LoUNOvZQEasGmTIxOi38BcIRca8Fde80aXxOwM
         aXfV6t3++WM8D2t43nXQPbThzdlcHTowM1+1hywltCEBkdLNk5WIBKbHdgnFrbTu6NN6
         G7hD3xTxSxdg2OJyJhkZKd/bIlY8HQYl9S3d+OKQOv7jN/dCgI9Jja2/dN9fpneUfi06
         MbuoGh0EvHikS8mSs/EC9zdBr5OUOZtHEXtCxm4XNW8D1WYAC2ZSXNjfDklDyA/HF1uk
         rv1AHJwKXY2AlZUFovyBCJwKKAz5+/DTFFMP1V3lPGCXMSQIXrZnHCpFQWA4YSRq5Alp
         0QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561885; x=1689153885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jrHnz846sKSAurRWEc8dAdWpKHrp05uQC5lgmZ9ncs=;
        b=a+Fz+0Wv9ny5F5lJS3memlZjK/yVAlHIiBjh+6+9tc5/WTQ1p0QjunxHA65Sxf7L8n
         j9CE/1AGeZWwrD7vTEwtUoILK3ToahcpxNbGJNPElpSsh3/rb2DQwXm9hI4WT7+srM+I
         wqRnCHmOm/BPLtzB41XlKrOIL2mD53Oi0wI1vKIkbokbBNI41PSyo3jt0klSKOsGDu7L
         5qUyx/AbNW2DvUPUgX0JUCEhQrFj3jhis4qhQkMF29atrg4LL7DghMxMpsI2gfpyzvLY
         7/nYG8+647c16Qk2F4WFabXhpCWeHihlMma48op80x/mfIbTWFcecFFdYrCG73tavhx4
         Wrww==
X-Gm-Message-State: AC+VfDwMxPWEqhCOsiFg6i/RhBxvw5MDdhWWrZswtrQGmcgWyBspWRE3
        fHCiWiH1frDCTHS9FOVgt0/ECQ==
X-Google-Smtp-Source: ACHHUZ6uIGRfB9PUuO1IdV3Ad+qQfGck8wohxMrNY4KVFcykXH7H2id2cyMCwfjwU4a96k2jo3xMxA==
X-Received: by 2002:a19:6706:0:b0:4f4:2b83:f4a3 with SMTP id b6-20020a196706000000b004f42b83f4a3mr3564114lfc.51.1686561885364;
        Mon, 12 Jun 2023 02:24:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:44 -0700 (PDT)
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
Subject: [PATCH 13/26] net: stmmac: dwmac-qcom-ethqos: make the rgmii clock optional
Date:   Mon, 12 Jun 2023 11:23:42 +0200
Message-Id: <20230612092355.87937-14-brgl@bgdev.pl>
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

On sa8775p there's no RGMII clock so make it optional in the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 3438b6229351..252dca400071 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -663,7 +663,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
 	ethqos->has_emac3 = data->has_emac3;
 
-	ethqos->rgmii_clk = devm_clk_get(dev, "rgmii");
+	ethqos->rgmii_clk = devm_clk_get_optional(dev, "rgmii");
 	if (IS_ERR(ethqos->rgmii_clk)) {
 		ret = PTR_ERR(ethqos->rgmii_clk);
 		goto out_config_dt;
-- 
2.39.2

