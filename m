Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49F26A01D1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjBWETq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjBWET2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:19:28 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E9726863
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:19:26 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso2153677ota.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4VXf8i192LJe92+0fvL0GaVl0CQVy232y5xhHWFLbM=;
        b=afxwRdEqpaEu6wV8MqdT/9JrQl+SX+uwDUUYkFnbhzJyFnaHjZrQfSZpKlKsLB4RJP
         qxRLFw1m/KD0GnY8HaB3TsHrPWRcb1OnWcNyq8mlCb2MS/BkDcOqvQv90ege+sazcyEE
         WcyfLe/OxgJNqiSgqrQERdhLnPEVngWuMsjYr0XrBszvsiIpX+Jn3r/k6jPaXAmHyf/V
         ZHc+j/7NNZ59CUtqhlByiu4Iru1/2Nd+99K95TNGb0nF47IGUc3gLhZLwhwnSj03aMiU
         i/8U9wKEB5XV3j6NaYcsxZi1RTgIF5BTgm7rjRFGxPMJA66eOSTo+uaq07WuyXWUaTA/
         2F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4VXf8i192LJe92+0fvL0GaVl0CQVy232y5xhHWFLbM=;
        b=7Kv7n2qWz/kVKUYNuZIuS3A8HwDUr0rwO5y9HNutRFovHlElo99/shy9XaZm69SmVJ
         qHoX5kXdYrMrZnRV6AoQ4jerSRStjGPB7Vk6rLvTU1L2osK3+GMkvfFB2eeVr14HvPby
         fP7LPHkLFiXa4VnG9Dct2nJCV152OVVOuwufQJPalDvipZSDQ7puL8i3WikRSTIunMZa
         fHhtoNk3eaDiFCBL1wqFnD/uN972A8OoN/w/subjyNTHPrEUTT3wkqUt5kyR/mgdg7E+
         Yp/am9S/7IaFIYL3mqFIpskDUhKXdwMjsqqFm8H5TVBHTTq3lteFUAPGVtbIVCDDHJeU
         WewA==
X-Gm-Message-State: AO0yUKUdm7wGR+nik/5+oEenqCQgpbafU1Ct1hpokpdr3V5lnA+ng31g
        4mSVMqzA9dEjiojQmQIGQikZ2w==
X-Google-Smtp-Source: AK7set/4+pne6J2oHyvGKljHs5BgtzwB3cbfxhM1TpmLnwuuPql1Qlq6lWNdZWcEen4L/R/iE5mmhA==
X-Received: by 2002:a05:6830:232c:b0:690:c6fa:6e7b with SMTP id q12-20020a056830232c00b00690c6fa6e7bmr5021208otg.19.1677125966144;
        Wed, 22 Feb 2023 20:19:26 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id q7-20020a9d57c7000000b00690f7c779ebsm2918468oti.7.2023.02.22.20.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:19:25 -0800 (PST)
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
Subject: [PATCH v3 3/6] clk: samsung: Set dev in samsung_clk_init()
Date:   Wed, 22 Feb 2023 22:19:35 -0600
Message-Id: <20230223041938.22732-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223041938.22732-1-semen.protsenko@linaro.org>
References: <20230223041938.22732-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers set dev to context in order to implement PM. Make that part
of samsung_clk_init() instead of assigning `ctx->dev = dev' separately.

No functional change.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Rebased on top of latest soc/for-next tree
  - Added Marek's Acked-by tag

Changes in v2:
  - Rebased on top of latest soc/for-next tree

 drivers/clk/samsung/clk-exynos4.c        |  2 +-
 drivers/clk/samsung/clk-exynos4412-isp.c |  3 +--
 drivers/clk/samsung/clk-exynos5250.c     |  2 +-
 drivers/clk/samsung/clk-exynos5420.c     |  2 +-
 drivers/clk/samsung/clk-s3c64xx.c        |  2 +-
 drivers/clk/samsung/clk-s5pv210.c        |  2 +-
 drivers/clk/samsung/clk.c                | 19 +++++++++++++++----
 drivers/clk/samsung/clk.h                |  5 +++--
 8 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7a9994144d72..d7dbb3858347 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1251,7 +1251,7 @@ static void __init exynos4_clk_init(struct device_node *np,
 	if (!reg_base)
 		panic("%s: failed to map registers\n", __func__);
 
-	ctx = samsung_clk_init(reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos4_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-exynos4412-isp.c b/drivers/clk/samsung/clk-exynos4412-isp.c
index 0b6390e04533..1470c15e95da 100644
--- a/drivers/clk/samsung/clk-exynos4412-isp.c
+++ b/drivers/clk/samsung/clk-exynos4412-isp.c
@@ -121,8 +121,7 @@ static int __init exynos4x12_isp_clk_probe(struct platform_device *pdev)
 	if (!exynos4x12_save_isp)
 		return -ENOMEM;
 
-	ctx = samsung_clk_init(reg_base, CLK_NR_ISP_CLKS);
-	ctx->dev = dev;
+	ctx = samsung_clk_init(dev, reg_base, CLK_NR_ISP_CLKS);
 
 	platform_set_drvdata(pdev, ctx);
 
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index f1cb69aea10e..92fb09922f28 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -797,7 +797,7 @@ static void __init exynos5250_clk_init(struct device_node *np)
 		panic("%s: unable to determine soc\n", __func__);
 	}
 
-	ctx = samsung_clk_init(reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5250_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 46cac4980be2..1e0cbf762408 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -1587,7 +1587,7 @@ static void __init exynos5x_clk_init(struct device_node *np,
 
 	exynos5x_soc = soc;
 
-	ctx = samsung_clk_init(reg_base, CLK_NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, CLK_NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_of_register_fixed_ext(ctx, exynos5x_fixed_rate_ext_clks,
diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
index 47e9d19486dc..d27a1f73f077 100644
--- a/drivers/clk/samsung/clk-s3c64xx.c
+++ b/drivers/clk/samsung/clk-s3c64xx.c
@@ -405,7 +405,7 @@ void __init s3c64xx_clk_init(struct device_node *np, unsigned long xtal_f,
 			panic("%s: failed to map registers\n", __func__);
 	}
 
-	ctx = samsung_clk_init(reg_base, NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	/* Register external clocks. */
diff --git a/drivers/clk/samsung/clk-s5pv210.c b/drivers/clk/samsung/clk-s5pv210.c
index b0ab6bc9d21d..cd85342e4ddb 100644
--- a/drivers/clk/samsung/clk-s5pv210.c
+++ b/drivers/clk/samsung/clk-s5pv210.c
@@ -743,7 +743,7 @@ static void __init __s5pv210_clk_init(struct device_node *np,
 	struct samsung_clk_provider *ctx;
 	struct clk_hw **hws;
 
-	ctx = samsung_clk_init(reg_base, NR_CLKS);
+	ctx = samsung_clk_init(NULL, reg_base, NR_CLKS);
 	hws = ctx->clk_data.hws;
 
 	samsung_clk_register_mux(ctx, early_mux_clks,
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 2436223aac1a..912dfbe5ac20 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -53,9 +53,19 @@ struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
 	return rd;
 }
 
-/* setup the essentials required to support clock lookup using ccf */
-struct samsung_clk_provider * __init samsung_clk_init(void __iomem *base,
-			unsigned long nr_clks)
+/**
+ * samsung_clk_init() - Create and initialize a clock provider object
+ * @dev:	CMU device to enable runtime PM, or NULL if RPM is not needed
+ * @base:	Start address (mapped) of CMU registers
+ * @nr_clks:	Total clock count to allocate in clock provider object
+ *
+ * Setup the essentials required to support clock lookup using Common Clock
+ * Framework.
+ *
+ * Return: Allocated and initialized clock provider object.
+ */
+struct samsung_clk_provider * __init samsung_clk_init(struct device *dev,
+			void __iomem *base, unsigned long nr_clks)
 {
 	struct samsung_clk_provider *ctx;
 	int i;
@@ -67,6 +77,7 @@ struct samsung_clk_provider * __init samsung_clk_init(void __iomem *base,
 	for (i = 0; i < nr_clks; ++i)
 		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
 
+	ctx->dev = dev;
 	ctx->reg_base = base;
 	ctx->clk_data.num = nr_clks;
 	spin_lock_init(&ctx->lock);
@@ -341,7 +352,7 @@ struct samsung_clk_provider * __init samsung_cmu_register_one(
 		return NULL;
 	}
 
-	ctx = samsung_clk_init(reg_base, cmu->nr_clk_ids);
+	ctx = samsung_clk_init(NULL, reg_base, cmu->nr_clk_ids);
 
 	if (cmu->pll_clks)
 		samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_clks);
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index 98753b0e5055..3fd6c0868921 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -16,6 +16,7 @@
 /**
  * struct samsung_clk_provider: information about clock provider
  * @reg_base: virtual address for the register base.
+ * @dev: clock provider device needed for runtime PM.
  * @lock: maintains exclusion between callbacks for a given clock-provider.
  * @clk_data: holds clock related data like clk_hw* and number of clocks.
  */
@@ -337,8 +338,8 @@ struct samsung_cmu_info {
 	const char *clk_name;
 };
 
-struct samsung_clk_provider *samsung_clk_init(void __iomem *base,
-			unsigned long nr_clks);
+struct samsung_clk_provider *samsung_clk_init(struct device *dev,
+			void __iomem *base, unsigned long nr_clks);
 void samsung_clk_of_add_provider(struct device_node *np,
 			struct samsung_clk_provider *ctx);
 void samsung_clk_of_register_fixed_ext(
-- 
2.39.1

