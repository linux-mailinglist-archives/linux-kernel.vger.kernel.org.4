Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5EC6A01EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjBWEXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjBWEWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:22:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0391649895
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:21:28 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id a14-20020a056830100e00b00690ed91749aso2091995otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rOeT+TlXHq+kYJRcc5stz7RolNpClrKSBYxv7SYDZo=;
        b=yhCAsDnjDQXPkSq2JXGYxr7DKODT6rJDVT7ABVTz0LPZCGng/9MX6BjredcfQt86+r
         H0e3oKJlyTqJ8MrCHvdLKdt5cQM+ypPuS7PTlEmHRkv1bzO9NeD9/gfJWLbsd8uwVku8
         jBbwhFjSJKYkmjjAldFM/FL26FJ64Nven8w7H2pS1N0rxYXApxgTwMLNOqfK7aLorV92
         v7OMXYVOziguas23Ag+hc9wMz9oBefPlB4NdDV0+5aCEeewAr9GjIPPyskus6RDaeZ97
         b92jROQUjLr9tCGUPuIXN+wienWQ7dZV5Dt3PLRc3rZr2q8fv0UV6Jes8npHCy6r7jyd
         IXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rOeT+TlXHq+kYJRcc5stz7RolNpClrKSBYxv7SYDZo=;
        b=tmWSm7ZLBBvrVdyDhkDS8hyOoC4a9FLKs0y+D+09f0l/irlwS2DM00tuKIlbzglmoL
         McZSN9RT8k2zjNWv4LFuwuwo95wnxGtV48kFOzcinVrbwcIOalra/xZxe1FJ8sAliBKf
         yGAIYRtD23tSlkaEeNizcjPOM0Oc15ZPaJ/66s7ACCKKRAc//AYfQXmrCOPVBWMLLARR
         qHH64AJsXCLwWH2e5yVd9wvIVGDMPN/CfgOLzBBmdTaGb96gAV5H1MtPWG4eoXYj1Wcb
         29nwtpYQi+wSa86sk5sUuLXGOFgKQpehO1O/Rr3Y5Xw2Tp91AHrQNd5MQwEEde25uZZN
         OTLA==
X-Gm-Message-State: AO0yUKU8WZLFuvIss0MnTGb98Qz15WExGufSBiU50m01nEujQO2Di2dz
        GeEnAslK28thd0nsbzJEA5fpBg==
X-Google-Smtp-Source: AK7set+lh60j/dD/b3OYUa4K/o8jntVzHLjpfTyTwS2d2UmMik103hQoAN8BIUNLOjLX6bvbM40Jlw==
X-Received: by 2002:a05:6830:550:b0:68b:c938:878a with SMTP id l16-20020a056830055000b0068bc938878amr1440059otb.16.1677126082172;
        Wed, 22 Feb 2023 20:21:22 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id y7-20020a9d5187000000b0068bb7bd2668sm2225332otg.73.2023.02.22.20.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:21:21 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Virag <virag.david003@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] clk: samsung: clk-pll: Implement pll0818x PLL type
Date:   Wed, 22 Feb 2023 22:21:30 -0600
Message-Id: <20230223042133.26551-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223042133.26551-1-semen.protsenko@linaro.org>
References: <20230223042133.26551-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pll0818x PLL is used in Exynos850 SoC for CMU_G3D PLL. Operation-wise,
pll0818x is the same as pll0822x. The only difference is:
  - pl0822x is integer PLL with Middle FVCO (950 to 2400 MHz)
  - pl0818x is integer PLL with Low FVCO (600 to 1200 MHz)

Add pll0818x type as an alias to pll0822x.

Reviewed-by: Chanho Park <chanho61.park@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Rebased on top of most recent soc/for-next tree
  - Added Chanho Park Reviewed-by tag

 drivers/clk/samsung/clk-pll.c | 1 +
 drivers/clk/samsung/clk-pll.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 5ceac4c25c1c..74934c6182ce 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1314,6 +1314,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 			init.ops = &samsung_pll35xx_clk_ops;
 		break;
 	case pll_1417x:
+	case pll_0818x:
 	case pll_0822x:
 		pll->enable_offs = PLL0822X_ENABLE_SHIFT;
 		pll->lock_offs = PLL0822X_LOCK_STAT_SHIFT;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 5d5a58d40e7e..0725d485c6ee 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -34,6 +34,7 @@ enum samsung_pll_type {
 	pll_1451x,
 	pll_1452x,
 	pll_1460x,
+	pll_0818x,
 	pll_0822x,
 	pll_0831x,
 	pll_142xx,
-- 
2.39.1

