Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F316AD34F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 01:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCGAYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 19:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCGAYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 19:24:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18D03CE0B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 16:24:27 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t22so8438676oiw.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 16:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678148667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN9uwopFM2K6LXwaRiOglfUpZg/iDdiIp/u5JUJ9i7g=;
        b=LEAKGq5cE287q5SzAVaLkqWNwx/qST655/KyshXdlO6ch8wu0fkwrY3h3u/92orGqX
         dI9vx85BIB+WbngQzwdHvu8cof2eXi7JM9LoIh3RjJDGIXUlI2y2nMLk3QihZFvaEy4F
         rNhRMJ6fXUwkT7xcQurEzAvgnN7PEBj/VvHWYXX/sG5d+MUAo/KaQhW9PaX18W94tq1O
         rLvlDtZkV9nNGPPtHv0JzQReoLtBVFItxHIvj9rwk0MRAJHNsq/oaA+rZUkjwhF0Cjlj
         kXov9DITAkuKhQ/e0ZgYMfQku2DxJpyWVxH9ScvXnuTxsK7x+JFgPhgHHg5e2uOTGImT
         1/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678148667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN9uwopFM2K6LXwaRiOglfUpZg/iDdiIp/u5JUJ9i7g=;
        b=tGsNz2DHnWf46IjXrbqKakV4bmggc2erJ4J24oyS4J5b5cJFO/zy9GN1opfW18z+lP
         P5VmHNcCuhf0ABWwpMX1wyUynf0zj+jdgWO5IqM6G/A9UPEJSR+oplLLk8qwKOjCok7/
         me39kxoTZ41gB9E5Ea54H5YQ/VMCRcp4WHZEvvpDjQMWMIWP6Mi4DnumW78plkcde1pl
         +AvxT918SdmwoZkCY1QMwbXEn0qT3eFH1/xCqNlQ7ymknR86YgqX6EBqXhcjcnj6Aidk
         aZfNrmdQbdKDyXFpyJjdNUPMagTHeK1P91uNnh3rHEYwFbplqOj+XB4i9j3p6Ykc9nC2
         6JcQ==
X-Gm-Message-State: AO0yUKXtl8fw8Ns7AbjaJaElhpxV1UuE9qC219h/HnfyhoKzvjbYR9Aq
        28MVlPVlBvOaNpRCYY6bP3RK4A==
X-Google-Smtp-Source: AK7set9B//0TMKTIFBweTSDsJcocQ4YJ+R6b+Df775oLOh54202NCxFKshmQR/C0o5sxc6pzoWl2Pg==
X-Received: by 2002:a05:6808:601:b0:37f:879d:f548 with SMTP id y1-20020a056808060100b0037f879df548mr5661941oih.14.1678148667244;
        Mon, 06 Mar 2023 16:24:27 -0800 (PST)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id q65-20020acaf244000000b00383e0bec93bsm4527250oih.49.2023.03.06.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:24:26 -0800 (PST)
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
Subject: [PATCH v4 3/3] clk: samsung: exynos5433: Extract PM support to common ARM64 layer
Date:   Mon,  6 Mar 2023 18:24:23 -0600
Message-Id: <20230307002423.24454-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307002423.24454-1-semen.protsenko@linaro.org>
References: <20230307002423.24454-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5433 clock driver implements PM support internally, which might be
also useful for other Exynos clock drivers. Extract all PM related code
from clk-exynos5433 to common ARM64 functions.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v4:
  - Rebased on top of krzk/linux.git/for-next tree
  - Reworked exynos_arm64_enable_bus_clk() user code to only print an
    error message if that function fails

Changes in v3:
  - Rebased on top of latest soc/for-next tree
  - Added Marek's Acked-by tag
  - Added Marek's authorship in the header comment

Changes in v2:
  - Rebased on top of latest soc/for-next tree
  - Included linux/slab.h for kfree (found by kernel test robot)

 drivers/clk/samsung/clk-exynos-arm64.c | 176 ++++++++++++++++++++++++-
 drivers/clk/samsung/clk-exynos-arm64.h |   3 +
 drivers/clk/samsung/clk-exynos5433.c   | 157 +---------------------
 3 files changed, 180 insertions(+), 156 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsung/clk-exynos-arm64.c
index 60fd820c14aa..7d8937caf22a 100644
--- a/drivers/clk/samsung/clk-exynos-arm64.c
+++ b/drivers/clk/samsung/clk-exynos-arm64.c
@@ -10,6 +10,9 @@
  */
 #include <linux/clk.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
 
 #include "clk-exynos-arm64.h"
 
@@ -21,6 +24,19 @@
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
@@ -76,10 +92,16 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
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
@@ -87,6 +109,46 @@ static int __init exynos_arm64_enable_bus_clk(struct device *dev,
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
@@ -117,3 +179,113 @@ void __init exynos_arm64_register_cmu(struct device *dev,
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
+	/*
+	 * Try to boot even if the parent clock enablement fails, as it might be
+	 * already enabled by bootloader.
+	 */
+	ret = exynos_arm64_enable_bus_clk(dev, NULL, cmu);
+	if (ret)
+		dev_err(dev, "%s: could not enable bus clock %s; err = %d\n",
+		       __func__, cmu->clk_name, ret);
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
2.39.2

