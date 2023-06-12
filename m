Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0E72BCA9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjFLJcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjFLJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:30:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5B35B1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f63006b4e3so4777088e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561892; x=1689153892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRB5rCUQICPP4KdYl/nzNPsexRgByDiqLi2dGSM6LQs=;
        b=wki9pfOT5Rxd5I9FVQ1tRg38zuoF06hGoB1Obw/n5Dat40yAA3EhR9Z0NsWmcyoRqW
         vQyNN2w2lHRcUgiG1L332CkRuWKahCVsNNsrZv5eNwW8gCsYqzw1Thzr5uyHZFzdU2L4
         R7UVTsB1Dp1LYr35Igwj8+TEs389mw3klOojuK2W5JThLmNPLnC3tMYuuLyJ3Gp6zCG/
         qEcP61vcWik5dCgYIOPqXuug1GJFZUuqfw8tCK6B4Pkjc+BH8zPcoLzziPa8F0Qnz+ca
         ViB763l7KUgMeerwWnhj0R3xgWRs8nSt3qCvm/3rh1uZ+miXI5BfQi7gRLCTXh6Ux3Ff
         c3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561892; x=1689153892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRB5rCUQICPP4KdYl/nzNPsexRgByDiqLi2dGSM6LQs=;
        b=PVq7tVwfe8a+PormfdOAEZznYYGN2s99ePAGJhlbGFDMrma516Jruw3gqbC3O9IC24
         S4wLaEA5lpLBcJcxH/GZZrMZ1RG0kBn1wxxeA5SIWT8xavacqYfmRAcfKk7sHik4qQAp
         MoBgjIL9MPXxUfkWtaWxaoaBeg3EYhEd3nwhXPSC9YxYNNkCOe4lfRhOXE6mXctiz8Vs
         i9YrDlls5t7TyaXhr5ETey4xMJ3BVW27b0bmTu6KHvIKM64PQmiQEHY3HUPBdcoTt7Rh
         uyvomhxTvD/aHSM/4uM5RQlpM8cHVSXtFG9UCt9LX3XqhsGj9p2TtBxn56/6dZKBp874
         Rj8A==
X-Gm-Message-State: AC+VfDz9iBkeJTvDu8yBIebr6IS7qyaQfiQ4Zc+wOyV8S2L62C02mvu6
        pyHi7O1B8j952X4OQmF035NE/w==
X-Google-Smtp-Source: ACHHUZ6MsoAALe/nXViObuQKYmMum7GoTveImC1ZSm+c8DJ1aav0op6ATtx6I9EHAENx6igoyGBseA==
X-Received: by 2002:a05:6512:2e2:b0:4f6:2233:6d27 with SMTP id m2-20020a05651202e200b004f622336d27mr3519648lfq.31.1686561892365;
        Mon, 12 Jun 2023 02:24:52 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:51 -0700 (PDT)
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
Subject: [PATCH 18/26] net: stmmac: add new switch to struct plat_stmmacenet_data
Date:   Mon, 12 Jun 2023 11:23:47 +0200
Message-Id: <20230612092355.87937-19-brgl@bgdev.pl>
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

On some platforms, the PCS can be integrated in the MAC so the driver
will not see any PCS link activity. Add a switch that allows the platform
drivers to let the core code know.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 include/linux/stmmac.h                            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fa07b0d50b46..fdcf1684487c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5793,7 +5793,7 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 		}
 
 		/* PCS link status */
-		if (priv->hw->pcs) {
+		if (priv->hw->pcs && !priv->plat->has_integrated_pcs) {
 			if (priv->xstats.pcs_link)
 				netif_carrier_on(priv->dev);
 			else
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 225751a8fd8e..06090538fe2d 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -293,5 +293,6 @@ struct plat_stmmacenet_data {
 	bool sph_disable;
 	bool serdes_up_after_phy_linkup;
 	const struct dwmac4_addrs *dwmac4_addrs;
+	bool has_integrated_pcs;
 };
 #endif
-- 
2.39.2

