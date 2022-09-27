Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FF75EBC41
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiI0H5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiI0H4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:56:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5131C8050B
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id ay36so6005347wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UGbdJwhNtYNfg6qIard96SGzNtmQLkXSB3qcyDfr1D0=;
        b=oJ1V7ClH/AxqFsip+Snl9v8pZ3quO3ZUVr2JKxgO/s+X8KKUFRT6eXqmLeRsBKUV+S
         7dxCj7gqXUPZs7CjKFJ9pQn2CcbApzGeKH/9pCZF2GGSiij+xFaCZY9hhyFZXAPaU+MK
         ZdwEiA7p5MT5pAwxf5xBp21GiJxvMg0FaNEbvtY3Sh5FUomwM73EUKW5GCzfWDgMZMxt
         Foc6fvkXgvb4oeV9NonPouZXSeDg/BJhZFtLb35BZPcax4UwhE0SqBIzSbthWLcHhRA6
         UEwTeP1K4uJlZwPMmisUjO/n0JIlegHqUV+owv/PfLUkt2exHgMHqWo6NPtvM0t/aEGI
         njGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UGbdJwhNtYNfg6qIard96SGzNtmQLkXSB3qcyDfr1D0=;
        b=P4gN2VmwEwkfb7P5b90g8u3Qrtsd7y4yytVnfereaUf3udjBgaQ3vD+p5JkZU3qcYc
         Yj2q9U6Riet/zGaNVD+FB0Kjy9IQAHWGos5MXL8mWvjjhtc//Ry8iyxxEVegYloCdJYh
         rUiHsHfxqZgwmlO1OuLvHF2ULrllmT+JLdQjAX3wy4wfHsOGJL6UR7YhOle/Xt/Pw1N7
         EwaeS5S+Gv1X0i/BFglWrmb6kuYMEGrbm1NDieU50fv0YhkNVUV+ejGrG9cgBNc2Bds0
         fyfP7217BYe3Tug1FHvuGLYtp3n/ypFIrJb1FpC+VD5fvnK9uUvp6Q/9jvrwNNVLkWpv
         VO5Q==
X-Gm-Message-State: ACrzQf03ODzAPmYYJ7P6dscWwEIljZfXObtS33Va1bJerOFwX+PrqfD/
        0ODTjUOgoU2wx1X/v+kJvWAjcw==
X-Google-Smtp-Source: AMsMyM4bzqnDK4LTxi2vGiu4E7Q4X7uUBhhe14IwJVcXvStrXPgAVdY5OvOZgVsUz1NGFhvIgYQbvg==
X-Received: by 2002:a05:600c:4e52:b0:3b4:91ec:b15d with SMTP id e18-20020a05600c4e5200b003b491ecb15dmr1591518wmq.119.1664265349794;
        Tue, 27 Sep 2022 00:55:49 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x8-20020adfdcc8000000b0022afbd02c69sm1076654wrm.56.2022.09.27.00.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 00:55:49 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, davem@davemloft.net,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH v10 15/33] crypto: rockchip: use clk_bulk to simplify clock management
Date:   Tue, 27 Sep 2022 07:54:53 +0000
Message-Id: <20220927075511.3147847-16-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927075511.3147847-1-clabbe@baylibre.com>
References: <20220927075511.3147847-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3328 does not have the same clock names than rk3288, instead of using a complex
clock management, let's use clk_bulk to simplify their handling.

Reviewed-by: John Keeping <john@metanate.com>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 66 ++++---------------------
 drivers/crypto/rockchip/rk3288_crypto.h |  6 +--
 2 files changed, 11 insertions(+), 61 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 399829ef92e0..a635029ac71d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -22,47 +22,16 @@ static int rk_crypto_enable_clk(struct rk_crypto_info *dev)
 {
 	int err;
 
-	err = clk_prepare_enable(dev->sclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock sclk\n",
-			__func__, __LINE__);
-		goto err_return;
-	}
-	err = clk_prepare_enable(dev->aclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock aclk\n",
-			__func__, __LINE__);
-		goto err_aclk;
-	}
-	err = clk_prepare_enable(dev->hclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock hclk\n",
-			__func__, __LINE__);
-		goto err_hclk;
-	}
-	err = clk_prepare_enable(dev->dmaclk);
-	if (err) {
-		dev_err(dev->dev, "[%s:%d], Couldn't enable clock dmaclk\n",
-			__func__, __LINE__);
-		goto err_dmaclk;
-	}
-	return err;
-err_dmaclk:
-	clk_disable_unprepare(dev->hclk);
-err_hclk:
-	clk_disable_unprepare(dev->aclk);
-err_aclk:
-	clk_disable_unprepare(dev->sclk);
-err_return:
+	err = clk_bulk_prepare_enable(dev->num_clks, dev->clks);
+	if (err)
+		dev_err(dev->dev, "Could not enable clock clks\n");
+
 	return err;
 }
 
 static void rk_crypto_disable_clk(struct rk_crypto_info *dev)
 {
-	clk_disable_unprepare(dev->dmaclk);
-	clk_disable_unprepare(dev->hclk);
-	clk_disable_unprepare(dev->aclk);
-	clk_disable_unprepare(dev->sclk);
+	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
 }
 
 /*
@@ -266,27 +235,10 @@ static int rk_crypto_probe(struct platform_device *pdev)
 		goto err_crypto;
 	}
 
-	crypto_info->aclk = devm_clk_get(&pdev->dev, "aclk");
-	if (IS_ERR(crypto_info->aclk)) {
-		err = PTR_ERR(crypto_info->aclk);
-		goto err_crypto;
-	}
-
-	crypto_info->hclk = devm_clk_get(&pdev->dev, "hclk");
-	if (IS_ERR(crypto_info->hclk)) {
-		err = PTR_ERR(crypto_info->hclk);
-		goto err_crypto;
-	}
-
-	crypto_info->sclk = devm_clk_get(&pdev->dev, "sclk");
-	if (IS_ERR(crypto_info->sclk)) {
-		err = PTR_ERR(crypto_info->sclk);
-		goto err_crypto;
-	}
-
-	crypto_info->dmaclk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(crypto_info->dmaclk)) {
-		err = PTR_ERR(crypto_info->dmaclk);
+	crypto_info->num_clks = devm_clk_bulk_get_all(&pdev->dev,
+						      &crypto_info->clks);
+	if (crypto_info->num_clks < 3) {
+		err = -EINVAL;
 		goto err_crypto;
 	}
 
diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index ddbb9246ce16..28bf09fe1c1d 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -190,10 +190,8 @@
 
 struct rk_crypto_info {
 	struct device			*dev;
-	struct clk			*aclk;
-	struct clk			*hclk;
-	struct clk			*sclk;
-	struct clk			*dmaclk;
+	struct clk_bulk_data		*clks;
+	int num_clks;
 	struct reset_control		*rst;
 	void __iomem			*reg;
 	int				irq;
-- 
2.35.1

