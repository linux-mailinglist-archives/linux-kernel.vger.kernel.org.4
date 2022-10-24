Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6210F60B31D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJXQ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiJXQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:55:38 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FBC1C9040
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:36:35 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so10213743wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wg8m4GG4QjexJtQ30uCclpZbT7iCGr4ggTfboiYgY7w=;
        b=W0aOZLMhucJGkDWFZ4eLo90W7KJSaOP4g5shimjmGiPnHWVRLfBBjrRLoSODsg8dq0
         xrLJ3Z755FPKU1WQxarAGiMXvi8RX+0JoM5em8BbtYKHKLPAXM9dFDbVbFcQHhvbThut
         VbZ7y5XQ6aJlXy3cb7DJu8iGvR7L3v2aeVIW/sSJ7jfeRdsa3LlfVjRlOkpr/6UU6EK3
         e7ru/CixxS1601VgYzo3glYEZrxDkJ/HbIGGG0doobG8avEEHQYhvkjm0kB18NozqrWi
         OKVhFW9wYfP0Rz5jaipJJUTB6Xff9U8U3pBrhTmXd7kjKebaAIEI/QC3Sio+ha1RT8by
         xZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wg8m4GG4QjexJtQ30uCclpZbT7iCGr4ggTfboiYgY7w=;
        b=4iaPomot1TpsHX1bxa59j58O8zXNaxF4ep0gsvnu9EK6dL4HDlnIhfpUQXdH844PyZ
         Mn2n0gtJLcgXXrBAxd44XD5wFMlLCLZE8xbN9yvMFsRHipIuvxs9P9FecUJhHd+grenC
         WM75QWj9FJVPVmcLx596tnCjnvVzK8SHIDaqJLjE759tHbquiqsdbua5jJPLtbxdNTLZ
         N2EkHzJoKhfDYMKQO9iGCc4bOVLPU6x3MyqC6XajrtXWeUJdA8hZ3VGcjMI9B4rXSFbw
         4MFZeHlMcKFvR+T3/zEPF07GiAzC5htNm6WCQRhNqxNhL6kTU8t3EZRhOVX4BLqzXCeC
         bcXg==
X-Gm-Message-State: ACrzQf0aVPCsMD6NJcnMTU9Kz75Mc8tOQ1ynbKZVpd4Hanw8baHar4ES
        Y/HaycYz7Teh3DCGLHsfuAZyCe+OnAoEA5oN
X-Google-Smtp-Source: AMsMyM540QyJygyyI1aVFU3oRNSF3FU9t13sfAoCzM4zbaT4cykElqhdjbjaVQODkTz+W8n50nxENw==
X-Received: by 2002:a05:600c:5252:b0:3c6:f478:96e6 with SMTP id fc18-20020a05600c525200b003c6f47896e6mr29614762wmb.75.1666617383603;
        Mon, 24 Oct 2022 06:16:23 -0700 (PDT)
Received: from fadwachiby.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l24-20020a056000023800b00236627c078esm6322307wrz.110.2022.10.24.06.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:16:22 -0700 (PDT)
From:   Fadwa CHIBY <fchiby@baylibre.com>
X-Google-Original-From: Fadwa CHIBY
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Fadwa CHIBY <fchiby@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/3] soc: mediatek: pwrap: add support for sys & tmr clocks
Date:   Mon, 24 Oct 2022 15:15:42 +0200
Message-Id: <20221024131544.31219-3-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024131544.31219-1-fchiby@baylibre.com>
References: <20221024131544.31219-1-fchiby@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

MT8365 requires an extra 2 clocks to be enabled to behave correctly.
Add support these 2 clocks, they are made optional since they seem to
be present only on MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 36 ++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index eb82ae06697f..d56b00023ccd 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1171,6 +1171,8 @@ struct pmic_wrapper {
 	const struct pwrap_slv_type *slave;
 	struct clk *clk_spi;
 	struct clk *clk_wrap;
+	struct clk *clk_sys;
+	struct clk *clk_tmr;
 	struct reset_control *rstc;
 
 	struct reset_control *rstc_bridge;
@@ -2214,6 +2216,20 @@ static int pwrap_probe(struct platform_device *pdev)
 		return PTR_ERR(wrp->clk_wrap);
 	}
 
+	wrp->clk_sys = devm_clk_get_optional(wrp->dev, "sys");
+	if (IS_ERR(wrp->clk_sys)) {
+		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_sys),
+				     "failed to get clock: %pe\n",
+				     wrp->clk_sys);
+	}
+
+	wrp->clk_tmr = devm_clk_get_optional(wrp->dev, "tmr");
+	if (IS_ERR(wrp->clk_tmr)) {
+		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_tmr),
+				     "failed to get clock: %pe\n",
+				     wrp->clk_tmr);
+	}
+
 	ret = clk_prepare_enable(wrp->clk_spi);
 	if (ret)
 		return ret;
@@ -2222,6 +2238,14 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_out1;
 
+	ret = clk_prepare_enable(wrp->clk_sys);
+	if (ret)
+		goto err_out2;
+
+	ret = clk_prepare_enable(wrp->clk_tmr);
+	if (ret)
+		goto err_out3;
+
 	/* Enable internal dynamic clock */
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
 		pwrap_writel(wrp, 1, PWRAP_DCM_EN);
@@ -2236,7 +2260,7 @@ static int pwrap_probe(struct platform_device *pdev)
 		ret = pwrap_init(wrp);
 		if (ret) {
 			dev_dbg(wrp->dev, "init failed with %d\n", ret);
-			goto err_out2;
+			goto err_out4;
 		}
 	}
 
@@ -2250,7 +2274,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
 		dev_dbg(wrp->dev, "initialization isn't finished\n");
 		ret = -ENODEV;
-		goto err_out2;
+		goto err_out4;
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
@@ -2288,7 +2312,7 @@ static int pwrap_probe(struct platform_device *pdev)
 			       IRQF_TRIGGER_HIGH,
 			       "mt-pmic-pwrap", wrp);
 	if (ret)
-		goto err_out2;
+		goto err_out4;
 
 	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regops->regmap);
 	if (IS_ERR(wrp->regmap)) {
@@ -2300,11 +2324,15 @@ static int pwrap_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_dbg(wrp->dev, "failed to create child devices at %pOF\n",
 				np);
-		goto err_out2;
+		goto err_out4;
 	}
 
 	return 0;
 
+err_out4:
+	clk_disable_unprepare(wrp->clk_tmr);
+err_out3:
+	clk_disable_unprepare(wrp->clk_sys);
 err_out2:
 	clk_disable_unprepare(wrp->clk_wrap);
 err_out1:
-- 
2.25.1

