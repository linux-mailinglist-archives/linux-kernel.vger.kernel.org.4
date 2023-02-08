Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D500C68FB51
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjBHXnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjBHXnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:43:03 -0500
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899A1C33B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:42:58 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-16a7f5b6882so526943fac.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f84JLknt9zf5KuZUy7eIlAu0yqleQaULaUEZ/2t+qgQ=;
        b=nFquQicdjsP2/hcUoahY97bT38Cuh30k6UJGdvvUS/74eV3tym2B77h2lXBsUtRF7e
         3nbQbRRRch42ekqlx70g+Ll7faiUsHwjG875N7Q5ewXqpZ/QhjqNhv2nl9YSrqoLKjDf
         hL5I4gOnxQ5u5bWSein8BwDI91Frc3u8bYYZrI5iMmirtpiIzqZ+4myVbHoPybctsXqu
         M4Jw49PpkNPBv4vDkScrlbZWE7/KTZRCPRmUkiZEOVdnRYEy8tY8s5PjndKnmPA+DJCO
         xNsI346QtSHlzONN3713BC52KNJGbp3To7eukyLldT+6/WGRMKoGpZ5LMCdWlCSqFvEu
         yG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f84JLknt9zf5KuZUy7eIlAu0yqleQaULaUEZ/2t+qgQ=;
        b=tHx10qi4/pP6vLwmPGgXtdT/dGkoLGdO7kC1DPzYO+jiA6bJmnVN3MeQAmW596eKYx
         lERcZmEexKmVhChsukXsF/wUHrK81CyfWzoDtIO9sCpOlky1NgNWyL8apEsq/OwOrYFm
         9oyiNUVcz+T49k1eHrppR/a+tVvcDVLmJCSnaVzUlMpIt4k2YnmRYLkcPJixSbE9bcMc
         xvAHenLNiW5nXaICY8UIQvb0wqtUESKX46fQ5KB1RjEjP7U4Ex+PfOiHgfzxTez3Uta1
         5h5stoMF9Ocm3GKNMMJreHEh66pmAgaYNt3vLiYSbCZx0LO5DYtTQS9knwaMuPeiCBCt
         5VKg==
X-Gm-Message-State: AO0yUKV75TTa2utHYfXMOFPxcUvCHfrYj58u+L8uWt2FGKimK5sS+HcJ
        JjC8rbVmtRCqTn8KEDm9TcbTYQ==
X-Google-Smtp-Source: AK7set8cwEKPwwAFCJQMGs0vbOXTdc83hpCY1w+EW9UmibhrgmEvRq53Os0+5Z+UP4JW+qtCaQFUag==
X-Received: by 2002:a05:6870:c225:b0:15e:db7e:b4dc with SMTP id z37-20020a056870c22500b0015edb7eb4dcmr4943112oae.35.1675899778222;
        Wed, 08 Feb 2023 15:42:58 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id n38-20020a056870822600b00155ffbdbaffsm7446008oae.18.2023.02.08.15.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:42:57 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanho Park <chanho61.park@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] clk: samsung: Remove np argument from samsung_clk_init()
Date:   Wed,  8 Feb 2023 17:43:09 -0600
Message-Id: <20230208234313.23863-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208234313.23863-1-semen.protsenko@linaro.org>
References: <20230208234313.23863-1-semen.protsenko@linaro.org>
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

The code using `np' argument was removed from samsung_clk_init(). Remove
that leftover parameter as well.

No functional change.

Fixes: d5e136a21b20 ("clk: samsung: Register clk provider only after registering its all clocks")
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Rebased on top of latest soc/for-next tree

 drivers/clk/samsung/clk-exynos4.c        | 2 +-
 drivers/clk/samsung/clk-exynos4412-isp.c | 2 +-
 drivers/clk/samsung/clk-exynos5250.c     | 2 +-
 drivers/clk/samsung/clk-exynos5420.c     | 2 +-
 drivers/clk/samsung/clk-s3c64xx.c        | 2 +-
 drivers/clk/samsung/clk-s5pv210.c        | 2 +-
 drivers/clk/samsung/clk.c                | 6 +++---
 drivers/clk/samsung/clk.h                | 3 +--
 8 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 244f74f31746..7a9994144d72 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1251,7 +1251,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
 
-	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(reg_base, CLK_NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
index 471a6fb82670..0b6390e04533 100644
--- a/drivers/clk/samsung/clk-exynos4412-isp.c
+++ b/drivers/clk/samsung/clk-exynos4412-isp.c
@@ -121,7 +121,7 @@ static int __init exynos4x12_isp_clk_probe(struct platform_device *pdev)
 	if (!exynos4x12_save_isp)
 		return -ENOMEM;
 
-	ctx = samsung_clk_init(np, reg_base, CLK_NR_ISP_CLKS);
+	ctx = samsung_clk_init(reg_base, CLK_NR_ISP_CLKS);
 	ctx->dev = dev;
 
 	platform_set_drvdata(pdev, ctx);
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 69862ab6dc52..f1cb69aea10e 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -797,7 +797,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(reg_base, CLK_NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index df9e93d6adf2..46cac4980be2 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1587,7 +1587,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 
 	exynos5x_soc = soc;
 
-	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(reg_base, CLK_NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index d582bac68bb7..47e9d19486dc 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -405,7 +405,7 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(reg_base, NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	/* Register external clocks. */
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
index b91d20994bf5..b0ab6bc9d21d 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -743,7 +743,7 @@ static void __init __s5pv210_clk_init(struct device_node *np,
 	struct samsung_clk_provider *ctx;
 	struct clk_hw **hws;
 
-	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(reg_base, NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_register_mux(ctx, early_mux_clks,
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index e132d63933c3..2436223aac1a 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -54,8 +54,8 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
 }
 
 /* setup the essentials required to support clock lookup using ccf */
-struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
-			void __iomem *base, unsigned long nr_clks)
+struct samsung_clk_provider * __init samsung_clk_init(void __iomem *base,
+			unsigned long nr_clks)
 {
 	struct samsung_clk_provider *ctx;
 	int i;
@@ -341,7 +341,7 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
 		return NULL;
 	}
 
-	ctx = samsung_clk_init(np, reg_base, cmu->nr_clk_ids);
+	ctx = samsung_clk_init(reg_base, cmu->nr_clk_ids);
 
 	if (cmu->pll_clks)
 		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 1b7315063edd..98753b0e5055 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -337,8 +337,7 @@ struct samsung_cmu_info {
 	const char *clk_name;
 };
 
-struct samsung_clk_provider * samsung_clk_init(
-			struct device_node *np, void __iomem *base,
+struct samsung_clk_provider *samsung_clk_init(void __iomem *base,
 			unsigned long nr_clks);
 void samsung_clk_of_add_provider(struct device_node *np,
 			struct samsung_clk_provider *ctx);
-- 
2.39.1

