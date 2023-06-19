Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D072E734FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjFSJYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjFSJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:24:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC0512B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:16 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f8fe9dc27aso18850775e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687166654; x=1689758654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kqkS8wBl8PLRWJLFm1wypKtzLGR0zlssSDIjkM/ys4k=;
        b=Qos2IkA8ZAsADGu19H9PZy/5OjA+THOvzQdLHdLMnfKM6C9WgWeB0cX2h/gQI//18O
         4if1A4xBamh4uv99ZPTqoKTuFA4IIUkZSmDhHBputotWzNV49DEz+X1P9Xi4hjdgSAj7
         nVMdtprKu8rb77R5wb8w4kNkSZl4AynnDKa4viVHi4TeeT45ZxW6hB8X+4S/GAnBSYY6
         WjrWvv8POPWbGJscaHvwf27j7SvPQd4UQAm0ns2kKBfWLj6jELlu08H8UZhSaHvqynly
         F/J/IOPL7OFGnQYQUFloDt/KluYdeLdtCKjlToY7YXbF5UYZIDhLYqV+J7bF9rC9rWtq
         KKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687166654; x=1689758654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqkS8wBl8PLRWJLFm1wypKtzLGR0zlssSDIjkM/ys4k=;
        b=O5Im5zeA8hnxs96023ME/WbAhw5kyAHG0C6jV8mq51ht7oUO1MBet1wRqgEp0AAYk3
         6W0IJvbHMyQZpxish0p82UnI+Lhat3xIJxAwqJXZfjLQVlLXTujibrh4VUWpLAI8cLvG
         WoNnT5E6SdK7Ync6haHDiX6VVBmxiFYAgJmsU9nXhYHgsSxu3I3Z7ZItiowbOoTnCoLX
         JSQOCEkzGIPx1flcN1Kom0FdGWeZe5GeV5A3Rz9bjHAtKo5NsEBrSPiTS1mObdqHoqgp
         0rkpu++08+2eoBKKz3X820qZ4ptAXfkxXTN4xGvQrtRQTRT4IxrIquV2Dc3a3+Tgmkii
         V3Ww==
X-Gm-Message-State: AC+VfDxcsRDvRgv4tUuA8zBChCuhpXOPw6ltfaSXCcdZE9UuF1p6Suss
        1QFM35ejcQQ9Nhqz5rUskywWxA==
X-Google-Smtp-Source: ACHHUZ5nrI1ToJX1lF60t4H/hldIC6GXtkZvoSNtU8CXZk9iEQ2Ix3iq7IHZj9CpVyTfdBYlNjb0bA==
X-Received: by 2002:a1c:6a0a:0:b0:3f9:2c0:b58 with SMTP id f10-20020a1c6a0a000000b003f902c00b58mr3664302wmc.4.1687166654511;
        Mon, 19 Jun 2023 02:24:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d9e8:ddbf:7391:a0b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a7bce89000000b003f7cb42fa20sm10045229wmj.42.2023.06.19.02.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:24:14 -0700 (PDT)
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
Subject: [RESEND PATCH v2 02/14] net: stmmac: dwmac-qcom-ethqos: rename a label in probe()
Date:   Mon, 19 Jun 2023 11:23:50 +0200
Message-Id: <20230619092402.195578-3-brgl@bgdev.pl>
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

The err_mem label's name is unclear. It actually should be reached on
any error after stmmac_probe_config_dt() succeeds. Name it after the
cleanup action that needs to be called before exiting.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
---
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 2da0738eed24..16e856861558 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -615,14 +615,14 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos = devm_kzalloc(&pdev->dev, sizeof(*ethqos), GFP_KERNEL);
 	if (!ethqos) {
 		ret = -ENOMEM;
-		goto err_mem;
+		goto out_config_dt;
 	}
 
 	ethqos->pdev = pdev;
 	ethqos->rgmii_base = devm_platform_ioremap_resource_byname(pdev, "rgmii");
 	if (IS_ERR(ethqos->rgmii_base)) {
 		ret = PTR_ERR(ethqos->rgmii_base);
-		goto err_mem;
+		goto out_config_dt;
 	}
 
 	data = of_device_get_match_data(&pdev->dev);
@@ -634,16 +634,16 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	ethqos->rgmii_clk = devm_clk_get(&pdev->dev, "rgmii");
 	if (IS_ERR(ethqos->rgmii_clk)) {
 		ret = PTR_ERR(ethqos->rgmii_clk);
-		goto err_mem;
+		goto out_config_dt;
 	}
 
 	ret = ethqos_clks_config(ethqos, true);
 	if (ret)
-		goto err_mem;
+		goto out_config_dt;
 
 	ret = devm_add_action_or_reset(&pdev->dev, ethqos_clks_disable, ethqos);
 	if (ret)
-		goto err_mem;
+		goto out_config_dt;
 
 	ethqos->speed = SPEED_1000;
 	ethqos_update_rgmii_clk(ethqos, SPEED_1000);
@@ -662,11 +662,11 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-		goto err_mem;
+		goto out_config_dt;
 
 	return ret;
 
-err_mem:
+out_config_dt:
 	stmmac_remove_config_dt(pdev, plat_dat);
 
 	return ret;
-- 
2.39.2

