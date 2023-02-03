Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C0688F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjBCGJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjBCGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:09:06 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9236B009
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:09:04 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id dt8so3411491oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 22:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhDFp02xAnIoajb23QEQdChW+frO427szyZqJSvH2Ow=;
        b=tl8uOyMje7TVhx8wjF4XNRLmw0XIhbo7ZVBa7x+ofZMLoMFDzFZIXuKO72fTi/EIDT
         EMyN3Mf5GZ1mv58YKGuwkSdoa8eCebr2g+uvLynpt0B60R5CvNzmSBCet7wrqWCyPP1C
         xpL5zjXDJ4k8LqXP9Etuad/GNPF/uffPRfHpl3Ujd2Gt5xWeVo5xse97lZoGzXVwsdY7
         Lr0eMck8t1WiI89AhzY+nrZbPATcEOY89DkxPOZcpJn9p2VymP+WKAdLQwBll8vsk5Xr
         ZPYpO6YCaw5HD6s8avz5tmRAV0iiq6o/9RytHbeIbGm+3Vw0+H9Z6r0yiX8dhc6NCE3B
         +Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhDFp02xAnIoajb23QEQdChW+frO427szyZqJSvH2Ow=;
        b=3H7V1+zdfREntwGKeqYWSoeU4snoLPswlYbjIQMRPH4b6brpwDvn9g2eOQTTOqI3Pm
         hAz5Da5aZ7OAZjbZGSpDCDMEHJtXdC/mcWqld5QWBfzMEnEmd2/4uqvdmkTMGgO/3+QO
         UWuhkASqOdQUajO6vlFxvriO3WqIdEh0PkET6oQRqXQesNa8vFJpXI8kzaU4EiIrGtDe
         Zjc/nFDeUW/deOYnbFYrZ6EE7kKn2usKm2VijCNAR6nAuiCPdSCND8oejG3PKkBRoubW
         VGtyKNNYhV0JFkFOCFPG2W86xMMmQqZHMGMVQ9Cw3NNVuLgYvoaIIZNGPAhPafZ3npWn
         tJOg==
X-Gm-Message-State: AO0yUKVBU9ga8TiVHfyvsebfD3Qev7rkYdtCrtRriBylYlPFZbQrqfGu
        +j67Yy6LEVYn4gFZ6HyI6YPEmA==
X-Google-Smtp-Source: AK7set8bFtm2GOhgc9JGHl5lZ6gfkXvATjtYJDqc9t57xJj5PYF9WlJCZv7dLF36uioZOXpSMEcvRQ==
X-Received: by 2002:aca:2802:0:b0:364:adbc:609b with SMTP id 2-20020aca2802000000b00364adbc609bmr3730087oix.19.1675404543814;
        Thu, 02 Feb 2023 22:09:03 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id c15-20020a9d75cf000000b0068bbaf7a1b0sm739663otl.34.2023.02.02.22.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 22:09:03 -0800 (PST)
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
Subject: [PATCH 2/6] clk: samsung: Remove np argument from samsung_clk_init()
Date:   Fri,  3 Feb 2023 00:09:20 -0600
Message-Id: <20230203060924.8257-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203060924.8257-1-semen.protsenko@linaro.org>
References: <20230203060924.8257-1-semen.protsenko@linaro.org>
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
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c        | 2 +-
 drivers/clk/samsung/clk-exynos4412-isp.c | 2 +-
 drivers/clk/samsung/clk-exynos5250.c     | 2 +-
 drivers/clk/samsung/clk-exynos5420.c     | 2 +-
 drivers/clk/samsung/clk-s3c2410.c        | 2 +-
 drivers/clk/samsung/clk-s3c2412.c        | 2 +-
 drivers/clk/samsung/clk-s3c2443.c        | 2 +-
 drivers/clk/samsung/clk-s3c64xx.c        | 2 +-
 drivers/clk/samsung/clk-s5pv210.c        | 2 +-
 drivers/clk/samsung/clk.c                | 6 +++---
 drivers/clk/samsung/clk.h                | 3 +--
 11 files changed, 13 insertions(+), 14 deletions(-)

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
diff --git a/drivers/clk/samsung/clk-s3c2410.c b/drivers/clk/samsung/clk-s3c2410.c
index d72c79fa9b63..8483d4a2be03 100644
--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -332,7 +332,7 @@ void __init s3c2410_common_clk_init(struct device_node *np, unsigned long xti_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(reg_base, NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	/* Register external clocks only in non-dt cases */
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index 367f3ecb68e8..8f12a40790d4 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -216,7 +216,7 @@ void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(reg_base, NR_CLKS);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index bfcad2a24dbe..6db8147f0aa2 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -353,7 +353,7 @@ void __init s3c2443_common_clk_init(struct device_node *np, unsigned long xti_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	ctx = samsung_clk_init(np, reg_base, NR_CLKS);
+	ctx = samsung_clk_init(reg_base, NR_CLKS);
 
 	/* Register external clocks only in non-dt cases */
 	if (!np)
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
2.39.0

