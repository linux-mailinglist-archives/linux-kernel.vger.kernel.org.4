Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006996A01D5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 05:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjBWET6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 23:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjBWETe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 23:19:34 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4ED1F932
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:19:30 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id a23-20020a4ad5d7000000b005250867d3d9so594155oot.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 20:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4kLdNBDLHRncbUrO25+rnplxMkXOdoihdQ6ujkI2/Q=;
        b=EHqp7TR69VBewrbXlwhhy0jCr3Lh752CiYhXiqFjhQOsnXwp6uk17w6AShTqPZC1Ha
         jd10QuZUxNViNtxOhKhEFbVyS+z9PScqHH25pcK9BUAc1qMKUJdPj2CI0rTrDN+z816U
         oDq1s9yRwqO63ql6ry6OEBJ4rLwQ74rPANYzFlIVbXx0t8bz0neMf3wJj6B1CdpbdfH/
         CNj98HSogheOD0Ar4fakxIw3qkEYnkejJJj//THIGqklnxbNXfQ2zs33x5tjo1pZT/e3
         GyKIrb0z8YRctdq6E2J+DcKqDgp6zVizp7c23PYB+hNoPp46+j9ZM7ys/+YGJEM4wxCC
         0OtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4kLdNBDLHRncbUrO25+rnplxMkXOdoihdQ6ujkI2/Q=;
        b=NCCU9BqFc+zG2ztoSBy9eHXbSJWb+u3y55c2/mTqI1rYxfR9dIuzLqKU9iKrFKwHDS
         2ZRa3Rdq51ADoc8Rg38FvlaM/oEshIfleD3QXFz3lq9n0HxzOrkQkyShKseiTqrcj6nL
         uU+JYbb5E0LwvLhZ7mHIbMgjhKXTcMCNIUrg/HsUx8HWH1aBCrUIyO/iAeHkww/mgipn
         M9JB4kkHcUhTv2dbCATkbgWSfuNFibQ1isMzwDd4Zxxp4ePg9pqnLG34ai/Lx7lAz5cs
         IEkRbO+YfrMo/kFBdLDS8yqZBUnBQNEjUTcy6zZyDBl1lLfMUztMjZaZ8nXlG5Oydetz
         vopA==
X-Gm-Message-State: AO0yUKXNyIc4vFc1nnXnZ3WBIL4YmOoWrXt2CPvzjpssFTrP67iVMSGd
        5KV26t5NJ9uEt+aI3dS0PRQ3JA==
X-Google-Smtp-Source: AK7set+CbfttmHkz8Iym7B1fFvolJqM1FBYUdDBA6mLqfEUaqJXVXeeYUgxiopIUwMOo99FIh8O7tg==
X-Received: by 2002:a4a:d638:0:b0:51a:6ea9:5053 with SMTP id n24-20020a4ad638000000b0051a6ea95053mr4688535oon.9.1677125969142;
        Wed, 22 Feb 2023 20:19:29 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id m16-20020a056820035000b00517fc5fdf5bsm2271571ooe.17.2023.02.22.20.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 20:19:28 -0800 (PST)
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
Subject: [PATCH v3 6/6] clk: samsung: exynos5433: Extract PM support to common ARM64 layer
Date:   Wed, 22 Feb 2023 22:19:38 -0600
Message-Id: <20230223041938.22732-7-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223041938.22732-1-semen.protsenko@linaro.org>
References: <20230223041938.22732-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Exynos5433 clock driver implements PM support internally, which might be
also useful for other Exynos clock drivers. Extract all PM related code
from clk-exynos5433 to common ARM64 functions.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v3:
  - Rebased on top of latest soc/for-next tree
  - Added Marek's Acked-by tag
  - Added Marek's authorship in the header comment

Changes in v2:
  - Rebased on top of latest soc/for-next tree
  - Included linux/slab.h for kfree (found by kernel test robot)

 drivers/clk/samsung/clk-exynos-arm64.c | 173 ++++++++++++++++++++++++-
 drivers/clk/samsung/clk-exynos-arm64.h |   3 +
 drivers/clk/samsung/clk-exynos5433.c   | 157 +---------------------
 3 files changed, 177 insertions(+), 156 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
index 2aa3f0a5644e..2092e1c11278 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.c
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
+ * Copyright (C) 2017 Samsung Electronics Co., Ltd.
  * Copyright (C) 2021 Linaro Ltd.
  * Copyright (C) 2021 Dávid Virág <virag.david003@gmail.com>
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
  * Author: Sam Protsenko <semen.protsenko@linaro.org>
  * Author: Dávid Virág <virag.david003@gmail.com>
  *
@@ -10,6 +12,9 @@
  */
 #include <linux/clk.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include "clk-exynos-arm64.h"
 
@@ -21,6 +26,19 @@
 #define GATE_OFF_START		0x2000
 #define GATE_OFF_END		0x2fff
 
+struct exynos_arm64_cmu_data {
+	struct samsung_clk_reg_dump *clk_save;
+	unsigned int nr_clk_save;
+	const struct samsung_clk_reg_dump *clk_suspend;
+	unsigned int nr_clk_suspend;
+
+	struct clk *clk;
+	struct clk **pclks;
+	int nr_pclks;
+
+	struct samsung_clk_provider *ctx;
+};
+
 /**
  * exynos_arm64_init_clocks - Set clocks initial configuration
  * @np:			CMU device tree node with "reg" property (CMU addr)
@@ -76,10 +94,16 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
 	if (!cmu->clk_name)
 		return 0;
 
-	if (dev)
+	if (dev) {
+		struct exynos_arm64_cmu_data *data;
+
 		parent_clk = clk_get(dev, cmu->clk_name);
-	else
+		data = dev_get_drvdata(dev);
+		if (data)
+			data->clk = parent_clk;
+	} else {
 		parent_clk = of_clk_get_by_name(np, cmu->clk_name);
+	}
 
 	if (IS_ERR(parent_clk))
 		return PTR_ERR(parent_clk);
@@ -87,6 +111,46 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
 	return clk_prepare_enable(parent_clk);
 }
 
+static int __init exynos_arm64_cmu_prepare_pm(struct device *dev,
+		const struct samsung_cmu_info *cmu)
+{
+	struct exynos_arm64_cmu_data *data = dev_get_drvdata(dev);
+	int i;
+
+	data->clk_save = samsung_clk_alloc_reg_dump(cmu->clk_regs,
+						    cmu->nr_clk_regs);
+	if (!data->clk_save)
+		return -ENOMEM;
+
+	data->nr_clk_save = cmu->nr_clk_regs;
+	data->clk_suspend = cmu->suspend_regs;
+	data->nr_clk_suspend = cmu->nr_suspend_regs;
+	data->nr_pclks = of_clk_get_parent_count(dev->of_node);
+	if (!data->nr_pclks)
+		return 0;
+
+	data->pclks = devm_kcalloc(dev, sizeof(struct clk *), data->nr_pclks,
+				   GFP_KERNEL);
+	if (!data->pclks) {
+		kfree(data->clk_save);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < data->nr_pclks; i++) {
+		struct clk *clk = of_clk_get(dev->of_node, i);
+
+		if (IS_ERR(clk)) {
+			kfree(data->clk_save);
+			while (--i >= 0)
+				clk_put(data->pclks[i]);
+			return PTR_ERR(clk);
+		}
+		data->pclks[i] = clk;
+	}
+
+	return 0;
+}
+
 /**
  * exynos_arm64_register_cmu - Register specified Exynos CMU domain
  * @dev:	Device object; may be NULL if this function is not being
@@ -111,3 +175,108 @@ void __init exynos_arm64_register_cmu(struct device *dev,
 	exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
 	samsung_cmu_register_one(np, cmu);
 }
+
+/**
+ * exynos_arm64_register_cmu_pm - Register Exynos CMU domain with PM support
+ *
+ * @pdev:	Platform device object
+ * @set_manual:	If true, set gate clocks to manual mode
+ *
+ * It's a version of exynos_arm64_register_cmu() with PM support. Should be
+ * called from probe function of platform driver.
+ *
+ * Return: 0 on success, or negative error code on error.
+ */
+int __init exynos_arm64_register_cmu_pm(struct platform_device *pdev,
+					bool set_manual)
+{
+	const struct samsung_cmu_info *cmu;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct exynos_arm64_cmu_data *data;
+	void __iomem *reg_base;
+	int ret;
+
+	cmu = of_device_get_match_data(dev);
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+
+	ret = exynos_arm64_cmu_prepare_pm(dev, cmu);
+	if (ret)
+		return ret;
+
+	ret = exynos_arm64_enable_bus_clk(dev, NULL, cmu);
+	if (ret)
+		return ret;
+
+	if (set_manual)
+		exynos_arm64_init_clocks(np, cmu->clk_regs, cmu->nr_clk_regs);
+
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
+
+	data->ctx = samsung_clk_init(dev, reg_base, cmu->nr_clk_ids);
+
+	/*
+	 * Enable runtime PM here to allow the clock core using runtime PM
+	 * for the registered clocks. Additionally, we increase the runtime
+	 * PM usage count before registering the clocks, to prevent the
+	 * clock core from runtime suspending the device.
+	 */
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	samsung_cmu_register_clocks(data->ctx, cmu);
+	samsung_clk_of_add_provider(dev->of_node, data->ctx);
+	pm_runtime_put_sync(dev);
+
+	return 0;
+}
+
+int exynos_arm64_cmu_suspend(struct device *dev)
+{
+	struct exynos_arm64_cmu_data *data = dev_get_drvdata(dev);
+	int i;
+
+	samsung_clk_save(data->ctx->reg_base, data->clk_save,
+			 data->nr_clk_save);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_prepare_enable(data->pclks[i]);
+
+	/* For suspend some registers have to be set to certain values */
+	samsung_clk_restore(data->ctx->reg_base, data->clk_suspend,
+			    data->nr_clk_suspend);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_disable_unprepare(data->pclks[i]);
+
+	clk_disable_unprepare(data->clk);
+
+	return 0;
+}
+
+int exynos_arm64_cmu_resume(struct device *dev)
+{
+	struct exynos_arm64_cmu_data *data = dev_get_drvdata(dev);
+	int i;
+
+	clk_prepare_enable(data->clk);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_prepare_enable(data->pclks[i]);
+
+	samsung_clk_restore(data->ctx->reg_base, data->clk_save,
+			    data->nr_clk_save);
+
+	for (i = 0; i < data->nr_pclks; i++)
+		clk_disable_unprepare(data->pclks[i]);
+
+	return 0;
+}
diff --git a/drivers/clk/samsung/clk-exynos-arm64.h b/drivers/clk/samsung/clk-exynos-arm64.h
index 0dd174693935..969979e714bc 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.h
+++ b/drivers/clk/samsung/clk-exynos-arm64.h
@@ -16,5 +16,8 @@
 
 void exynos_arm64_register_cmu(struct device *dev,
 		struct device_node *np, const struct samsung_cmu_info *cmu);
+int exynos_arm64_register_cmu_pm(struct platform_device *pdev, bool set_manual);
+int exynos_arm64_cmu_suspend(struct device *dev);
+int exynos_arm64_cmu_resume(struct device *dev);
 
 #endif /* __CLK_EXYNOS_ARM64_H */
diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index eb72bf2aaee8..ed43233649ae 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -10,7 +10,6 @@
 #include <linux/clk-provider.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -19,6 +18,7 @@
 
 #include "clk.h"
 #include "clk-cpu.h"
+#include "clk-exynos-arm64.h"
 #include "clk-pll.h"
 
 /*
@@ -5478,160 +5478,9 @@ static const struct samsung_cmu_info imem_cmu_info __initconst = {
 	.clk_name		= "aclk_imem_200",
 };
 
-struct exynos5433_cmu_data {
-	struct samsung_clk_reg_dump *clk_save;
-	unsigned int nr_clk_save;
-	const struct samsung_clk_reg_dump *clk_suspend;
-	unsigned int nr_clk_suspend;
-
-	struct clk *clk;
-	struct clk **pclks;
-	int nr_pclks;
-
-	/* must be the last entry */
-	struct samsung_clk_provider ctx;
-};
-
-static int __maybe_unused exynos5433_cmu_suspend(struct device *dev)
-{
-	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
-	int i;
-
-	samsung_clk_save(data->ctx.reg_base, data->clk_save,
-			 data->nr_clk_save);
-
-	for (i = 0; i < data->nr_pclks; i++)
-		clk_prepare_enable(data->pclks[i]);
-
-	/* for suspend some registers have to be set to certain values */
-	samsung_clk_restore(data->ctx.reg_base, data->clk_suspend,
-			    data->nr_clk_suspend);
-
-	for (i = 0; i < data->nr_pclks; i++)
-		clk_disable_unprepare(data->pclks[i]);
-
-	clk_disable_unprepare(data->clk);
-
-	return 0;
-}
-
-static int __maybe_unused exynos5433_cmu_resume(struct device *dev)
-{
-	struct exynos5433_cmu_data *data = dev_get_drvdata(dev);
-	int i;
-
-	clk_prepare_enable(data->clk);
-
-	for (i = 0; i < data->nr_pclks; i++)
-		clk_prepare_enable(data->pclks[i]);
-
-	samsung_clk_restore(data->ctx.reg_base, data->clk_save,
-			    data->nr_clk_save);
-
-	for (i = 0; i < data->nr_pclks; i++)
-		clk_disable_unprepare(data->pclks[i]);
-
-	return 0;
-}
-
 static int __init exynos5433_cmu_probe(struct platform_device *pdev)
 {
-	const struct samsung_cmu_info *info;
-	struct exynos5433_cmu_data *data;
-	struct samsung_clk_provider *ctx;
-	struct device *dev = &pdev->dev;
-	void __iomem *reg_base;
-	int i;
-
-	info = of_device_get_match_data(dev);
-
-	data = devm_kzalloc(dev,
-			    struct_size(data, ctx.clk_data.hws, info->nr_clk_ids),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-	ctx = &data->ctx;
-
-	reg_base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(reg_base))
-		return PTR_ERR(reg_base);
-
-	for (i = 0; i < info->nr_clk_ids; ++i)
-		ctx->clk_data.hws[i] = ERR_PTR(-ENOENT);
-
-	ctx->clk_data.num = info->nr_clk_ids;
-	ctx->reg_base = reg_base;
-	ctx->dev = dev;
-	spin_lock_init(&ctx->lock);
-
-	data->clk_save = samsung_clk_alloc_reg_dump(info->clk_regs,
-						    info->nr_clk_regs);
-	if (!data->clk_save)
-		return -ENOMEM;
-	data->nr_clk_save = info->nr_clk_regs;
-	data->clk_suspend = info->suspend_regs;
-	data->nr_clk_suspend = info->nr_suspend_regs;
-	data->nr_pclks = of_clk_get_parent_count(dev->of_node);
-
-	if (data->nr_pclks > 0) {
-		data->pclks = devm_kcalloc(dev, sizeof(struct clk *),
-					   data->nr_pclks, GFP_KERNEL);
-		if (!data->pclks) {
-			kfree(data->clk_save);
-			return -ENOMEM;
-		}
-		for (i = 0; i < data->nr_pclks; i++) {
-			struct clk *clk = of_clk_get(dev->of_node, i);
-
-			if (IS_ERR(clk)) {
-				kfree(data->clk_save);
-				while (--i >= 0)
-					clk_put(data->pclks[i]);
-				return PTR_ERR(clk);
-			}
-			data->pclks[i] = clk;
-		}
-	}
-
-	if (info->clk_name)
-		data->clk = clk_get(dev, info->clk_name);
-	clk_prepare_enable(data->clk);
-
-	platform_set_drvdata(pdev, data);
-
-	/*
-	 * Enable runtime PM here to allow the clock core using runtime PM
-	 * for the registered clocks. Additionally, we increase the runtime
-	 * PM usage count before registering the clocks, to prevent the
-	 * clock core from runtime suspending the device.
-	 */
-	pm_runtime_get_noresume(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	if (info->pll_clks)
-		samsung_clk_register_pll(ctx, info->pll_clks,
-					 info->nr_pll_clks);
-	if (info->mux_clks)
-		samsung_clk_register_mux(ctx, info->mux_clks,
-					 info->nr_mux_clks);
-	if (info->div_clks)
-		samsung_clk_register_div(ctx, info->div_clks,
-					 info->nr_div_clks);
-	if (info->gate_clks)
-		samsung_clk_register_gate(ctx, info->gate_clks,
-					  info->nr_gate_clks);
-	if (info->fixed_clks)
-		samsung_clk_register_fixed_rate(ctx, info->fixed_clks,
-						info->nr_fixed_clks);
-	if (info->fixed_factor_clks)
-		samsung_clk_register_fixed_factor(ctx, info->fixed_factor_clks,
-						  info->nr_fixed_factor_clks);
-
-	samsung_clk_of_add_provider(dev->of_node, ctx);
-	pm_runtime_put_sync(dev);
-
-	return 0;
+	return exynos_arm64_register_cmu_pm(pdev, false);
 }
 
 static const struct of_device_id exynos5433_cmu_of_match[] = {
@@ -5679,7 +5528,7 @@ static const struct of_device_id exynos5433_cmu_of_match[] = {
 };
 
 static const struct dev_pm_ops exynos5433_cmu_pm_ops = {
-	SET_RUNTIME_PM_OPS(exynos5433_cmu_suspend, exynos5433_cmu_resume,
+	SET_RUNTIME_PM_OPS(exynos_arm64_cmu_suspend, exynos_arm64_cmu_resume,
 			   NULL)
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				     pm_runtime_force_resume)
-- 
2.39.1

