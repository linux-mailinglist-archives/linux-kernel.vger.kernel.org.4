Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B1072BC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjFLJb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjFLJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:30:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7413C3580
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7353993cbso29796885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686561888; x=1689153888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjVXwVFp50u0PUxr/5pPlG4sgNjLclV10ezIygBZf1w=;
        b=2LxLhnK7e46mui8dhof9QAMYFAXj+RyNY51koDXFIyUq+oeAgfB5Yunm2wkRuj1JMn
         kZaCwUavQC6RW+LqMlWJwEmkbL8jYXkjd+0ANuO3gB4RfugPiO63GVGDem2oaXmUGXY6
         eAlLWzfGQJsrYyk6s/qe+xejpzIL2oEbCV4biO8JIzCtGSZlK2U1RNqppXvdTzoPFYj1
         3uySIa1BuTRWIipEsHrVcQc4yvQ9rYYM8rlnBgv7OYXKE2GKN9SYzVWyi+JBty3FKAs6
         AGFFcXEHyxxr14wTLOjNholiBRGWtf+J2xMsFuYww1sG2cHVlfE8DjukIKEYzRH+nuip
         3ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686561888; x=1689153888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjVXwVFp50u0PUxr/5pPlG4sgNjLclV10ezIygBZf1w=;
        b=WUqqrd0H53M2CVjv3MOsUdHjYY0ROTLA/I+RdjvztT/ZWpaeSfQEtqjpMCOu/4fkJT
         mkZ3qRjdHL9T+/uUZUWXZPUoeLaxzvJonndUZSGlM2effnjn6+x2S2X7LH5/M88v3Och
         iHAYUi2gp9AobD/YVW+f3QkHGcTw0qMZNRrzf0RLG2GpmXpvoEPtNq5tMErUIHg/nFdY
         ePRrQvrqTfRpB2s2wzJMJG4pR+fwhlrxDg0Ur4MF61gwN2CVoHYcL053uBSNN2fjd1a+
         2BF78FIf0j6UyDuF6Kn3CU0Tsja5SlCDauc28QLGZ1yk8yW33yyg8HafhWZkmUgr3OjG
         LbTg==
X-Gm-Message-State: AC+VfDwUCq8FcoRqmP/vylYctpbj0HEGNhm5eMpoqksxuFHbB/Lif1/R
        8/AvM3ywg7w+YmarFrgRKR36OA==
X-Google-Smtp-Source: ACHHUZ5VMYcwm8OhSaptz22TDIOQZKg2qtYe5RLNTkB2yZzQSZhIqFe5Wt+EaJyET4ed5soNUXNxKQ==
X-Received: by 2002:a05:600c:880f:b0:3f7:148b:c310 with SMTP id gy15-20020a05600c880f00b003f7148bc310mr8862440wmb.13.1686561888007;
        Mon, 12 Jun 2023 02:24:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:a222:bbe9:c688:33ae])
        by smtp.gmail.com with ESMTPSA id p14-20020a7bcc8e000000b003f727764b10sm10892044wma.4.2023.06.12.02.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:24:47 -0700 (PDT)
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
Subject: [PATCH 15/26] net: stmmac: dwmac-qcom-ethqos: add support for the optional phy-supply
Date:   Mon, 12 Jun 2023 11:23:44 +0200
Message-Id: <20230612092355.87937-16-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612092355.87937-1-brgl@bgdev.pl>
References: <20230612092355.87937-1-brgl@bgdev.pl>
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

On sa8775p-ride we need to enable the power supply for the external PHY.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2f6b9b419601..21f329d2f7eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -8,6 +8,7 @@
 #include <linux/phy.h>
 #include <linux/phy/phy.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
@@ -692,6 +693,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_config_dt;
 
+	ret = devm_regulator_get_enable_optional(dev, "phy");
+	if (ret < 0 && ret != -ENODEV)
+		goto out_config_dt;
+
 	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
 	if (IS_ERR(ethqos->serdes_phy)) {
 		ret = PTR_ERR(ethqos->serdes_phy);
-- 
2.39.2

