Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92476132CE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiJaJeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJaJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:34:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615EA10C6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:34:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so10402883wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9+9zCegsUCIRIE3UD2cb0S32Fqr93kkv8zeVXoYmsQ=;
        b=nUwU40ZbSQQiiXmbuNHJK3uPUKBsu4RliRC4hTNLUhK98Ss8hzzdT7OiLOmb7FmJBf
         gSvqshhyvQIvg1ydoz2Jkijz72epbTZdOacS/GymSrj47SWRiJHo3rQ9vF4Ad2WMSv/1
         l2bz0Q4hAtVLD2eTS/bZHJ/YUrwN1gIoIoRqZigKtZwUapkeTm39DfSsTeOSamvsjtXU
         wDE6vhGIFtFmI6Tjk4zsLli4427TjK+TmMH5PtQSHPM0uOnPjFDB0nqO8vb7CgP8TwFw
         ZGx7EX1qir8C83A4z5O5ZJxiVwH3Dm2HpAV3dp5VGfH0xR3BdaBKokBnpDN01nKfMeYG
         1Y/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9+9zCegsUCIRIE3UD2cb0S32Fqr93kkv8zeVXoYmsQ=;
        b=Rs18C1mFJgvqeTgtZBhIY8KoQy5IodArLAQr1vS4/MNU0F5kL4Tc9ZoQK+t27oMRK7
         ILhnOojK9OCBVFCgsgYL0R2FDFY3WIVu03z0X0G3U5LejKJyPnMevvw3kE2Wu9CGyeHU
         ztPbHLFsCyOdUpQl0ipEd1dHIpVrASU8ML0KS8UiYVMg3q1zW8ZiGPkDeG8LXTfKnQ11
         hoEgk9Z7y5Nt9ar5G8NIgo3sP4oBQSJETRgOJFNGIkkAfSU+n+3EWuc1HkLB/kwxiQC2
         wWCN1ehjkgX4lAtNZpNnoCPH7fpdmDBK5G3kUPn7c0MIaQ7b9idGK3Ty7g4TmBxoIzX1
         gVeg==
X-Gm-Message-State: ACrzQf1VQS73yxoIBaGh6W2xtuoj+YLlryclmS0VW+yq3SQvMs4I3DOn
        hydVj8d/PZqJ3M2NVI4y61kUAw==
X-Google-Smtp-Source: AMsMyM5i4Jyy7DPwTD7FxJPx/hdZH5LYR2iYSU4sakPywzmez3E5HPoJ4cNum+Rt+v4uBRFtNQC+6w==
X-Received: by 2002:a05:600c:92a:b0:3cf:6264:f2a7 with SMTP id m42-20020a05600c092a00b003cf6264f2a7mr7695880wmp.131.1667208872711;
        Mon, 31 Oct 2022 02:34:32 -0700 (PDT)
Received: from fadwachiby.lan ([2001:861:3104:1980:6db3:63f:b30d:9361])
        by smtp.gmail.com with ESMTPSA id t16-20020adff610000000b0023538fb27c1sm6547566wrp.85.2022.10.31.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 02:34:32 -0700 (PDT)
From:   fchiby@baylibre.com
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
Subject: [PATCH v3 2/3] soc: mediatek: pwrap: add support for sys & tmr clocks
Date:   Mon, 31 Oct 2022 10:33:57 +0100
Message-Id: <20221031093401.22916-3-fchiby@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031093401.22916-1-fchiby@baylibre.com>
References: <20221031093401.22916-1-fchiby@baylibre.com>
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

From: Fabien Parent <fparent@baylibre.com>

MT8365 requires an extra 2 clocks to be enabled to behave correctly.
Add support these 2 clocks, they are made optional since they seem to
be present only on MT8365.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

