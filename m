Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409896DC628
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjDJLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjDJLLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:11:32 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3559D2;
        Mon, 10 Apr 2023 04:11:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso7051481pjs.0;
        Mon, 10 Apr 2023 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681125064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4YkqjVQYX/c3jxukKHUZf0PehPmtJM6Cs6Goz5bGvE=;
        b=n6FBKVDDKlujVfojCTrck2K5ATQmGn7Cl9UMp34+nUuirI2fTOXjFOc1moQa/pnMYQ
         9v/AVRzNgxPn/ZC0PQypf0SKKrAGPXGn9LpKzKMVLOQbjwHh+pgwK+O91Ys3pE9k9Ur2
         lwOleCx/T30GDRyClvAHHLwAVBnzCjyQHYcf0VhzvRvT4TBv+4FREsnvrGPwTCDONzoJ
         pi+QDre/amlNL4i2X4R/AzurXBGd+8bwX6r54YTVqB/8pXySKF8ZVIHx33pm8VuMzh+1
         +AcqDRrE7eTo9tYZWxk9ub+EFexRm3MXqvswjrX3GHeeKseUQAcAOCo01Y820oFLYy8e
         xtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681125064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4YkqjVQYX/c3jxukKHUZf0PehPmtJM6Cs6Goz5bGvE=;
        b=c0+0hkCrXXlwcYbrzjhp2I8VpYusx+XIsF3wNb4FoqU6Zd6mdm4IR57CTh0kGaytrT
         jRJVcu5P/qii1D0q1WHG+HP6l8MNVL7KDybTp+kVdZK2iRiZFY7B2L8ThZPpSs7Se15+
         2tq6RmPgbwgoSrR5d7PwH7b77SWqxxV2J3YtLUS+zFhGec+gftrCyH+jyZ4VP7Q10sSH
         zZadq8hXzBo0THNHJxmhjBTr41Rt+r0Lq4IQ9ce2zXfMh2V6pBKNel78RYzcCUtr1cSl
         RfTxd5jsYEJakVJCShcskI7hF2HFX2qj0jvvPdE2d1vHipr1T4DjrSkMb6MMh1Usq3cB
         CXAw==
X-Gm-Message-State: AAQBX9evO/FTuJfyPoyJSbpQXNS7hy2CE+/VbMqTUkTT71ljJ8by4/BU
        3Va4p4T5bHoqYNEE/eIjY7Pg2qdMc9Ni515+FrQ=
X-Google-Smtp-Source: AKy350Y/CIPn/pfNVDh9tCX4NZHrxqws/dmz4DRwmX7fi0Ra5ZvmQ9yOSLk9rMn852BiJkrXq335FA==
X-Received: by 2002:a17:902:ea0a:b0:1a6:492c:df22 with SMTP id s10-20020a170902ea0a00b001a6492cdf22mr1197609plg.17.1681125063481;
        Mon, 10 Apr 2023 04:11:03 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:11:03 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Nick Alcock <nick.alcock@oracle.com>
Subject: [PATCH v3 14/14] clk: hisilicon: Migrate devm APIs
Date:   Mon, 10 Apr 2023 19:07:26 +0800
Message-Id: <20230410110733.192151-15-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410110733.192151-1-mmyangfl@gmail.com>
References: <20230410110733.192151-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrates devm APIs for HiSilicon clock drivers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3559a.c       |  29 +-
 drivers/clk/hisilicon/clk-hi3620.c        |  29 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        |   4 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  15 +-
 drivers/clk/hisilicon/clk.c               | 416 +++++++---------------
 drivers/clk/hisilicon/clk.h               |  96 ++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 10 files changed, 258 insertions(+), 403 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 9844e86ec146..3af5413c16ee 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -457,17 +457,16 @@ hisi_clk_register_pll(struct device *dev, const void *clocks,
 {
 	const struct hi3559av100_pll_clock *clks = clocks;
 	void __iomem *base = data->base;
-	struct hi3559av100_clk_pll *p_clk = NULL;
-	struct clk *clk = NULL;
+	struct hi3559av100_clk_pll *p_clk;
 	struct clk_init_data init;
 	int i;
-
-	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * num, GFP_KERNEL);
-
-	if (!p_clk)
-		return -ENOMEM;
+	int ret;
 
 	for (i = 0; i < num; i++) {
+		p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
+		if (!p_clk)
+			return -ENOMEM;
+
 		init.name = clks[i].name;
 		init.flags = 0;
 		init.parent_names =
@@ -490,16 +489,14 @@ hisi_clk_register_pll(struct device *dev, const void *clocks,
 		p_clk->refdiv_width = clks[i].refdiv_width;
 		p_clk->hw.init = &init;
 
-		clk = clk_register(NULL, &p_clk->hw);
-		if (IS_ERR(clk)) {
-			devm_kfree(dev, p_clk);
+		ret = devm_clk_hw_register(dev, &p_clk->hw);
+		if (ret) {
 			dev_err(dev, "%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			return PTR_ERR(clk);
+				__func__, clks[i].name);
+			return ret;
 		}
 
-		data->clk_data.clks[clks[i].id] = clk;
-		p_clk++;
+		data->clk_data->hws[clks[i].id] = &p_clk->hw;
 	}
 
 	return 0;
@@ -628,7 +625,7 @@ static int hi3559av100_shub_default_clk_set(struct device *dev, struct hisi_cloc
 	void __iomem *crg_base;
 	unsigned int val;
 
-	crg_base = ioremap(CRG_BASE_ADDR, SZ_4K);
+	crg_base = devm_ioremap(dev, CRG_BASE_ADDR, SZ_4K);
 
 	/* SSP: 192M/2 */
 	val = readl_relaxed(crg_base + 0x20);
@@ -640,7 +637,7 @@ static int hi3559av100_shub_default_clk_set(struct device *dev, struct hisi_cloc
 	val |= (0x1 << 28);
 	writel_relaxed(val, crg_base + 0x1C);
 
-	iounmap(crg_base);
+	devm_iounmap(dev, crg_base);
 	crg_base = NULL;
 
 	return 0;
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 464b7887415c..e775457f7678 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -11,12 +11,10 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hi3620-clock.h>
 
@@ -399,15 +397,15 @@ static const struct clk_ops clk_mmc_ops = {
 	.recalc_rate = mmc_clk_recalc_rate,
 };
 
-static struct clk *
+static struct clk_hw *
 clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
 		      void __iomem *base)
 {
 	struct clk_mmc *mclk;
-	struct clk *clk;
 	struct clk_init_data init;
+	int ret;
 
-	mclk = kzalloc(sizeof(*mclk), GFP_KERNEL);
+	mclk = devm_kzalloc(dev, sizeof(*mclk), GFP_KERNEL);
 	if (!mclk)
 		return ERR_PTR(-ENOMEM);
 
@@ -431,26 +429,31 @@ clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
 	mclk->sam_off = mmc_clk->sam_off;
 	mclk->sam_bits = mmc_clk->sam_bits;
 
-	clk = clk_register(NULL, &mclk->hw);
-	if (WARN_ON(IS_ERR(clk)))
-		kfree(mclk);
-	return clk;
+	ret = devm_clk_hw_register(dev, &mclk->hw);
+	if (ret) {
+		dev_err(dev, "%s: failed to register clock %s\n",
+			__func__, init.name);
+		return ERR_PTR(ret);
+	}
+
+	return &mclk->hw;
 }
 
 static int hisi_register_clk_mmc(struct device *dev, const void *clocks,
 				 size_t num, struct hisi_clock_data *data)
 {
 	const struct hisi_mmc_clock *clks = clocks;
+	int i;
 
-	for (int i = 0; i < num; i++) {
-		struct clk *clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
+	for (i = 0; i < num; i++) {
+		struct clk_hw *clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
 
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
 			return PTR_ERR(clk);
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
diff --git a/drivers/clk/hisilicon/clk-hi6220-stub.c b/drivers/clk/hisilicon/clk-hi6220-stub.c
index 4fdee4424d82..dd996a43958e 100644
--- a/drivers/clk/hisilicon/clk-hi6220-stub.c
+++ b/drivers/clk/hisilicon/clk-hi6220-stub.c
@@ -195,7 +195,6 @@ static int hi6220_stub_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct clk_init_data init;
 	struct hi6220_stub_clk *stub_clk;
-	struct clk *clk;
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
@@ -233,11 +232,11 @@ static int hi6220_stub_clk_probe(struct platform_device *pdev)
 	init.num_parents = 0;
 	init.flags = 0;
 
-	clk = devm_clk_register(dev, &stub_clk->hw);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	ret = devm_clk_hw_register(dev, &stub_clk->hw);
+	if (ret)
+		return ret;
 
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, clk);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &stub_clk->hw);
 	if (ret) {
 		dev_err(dev, "failed to register OF clock provider\n");
 		return ret;
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index edf83e996bd5..8e63bc140fa4 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -20,9 +20,7 @@ static int
 hi6220_clk_register_divider_stub(struct device *dev, const void *clks,
 				 size_t num, struct hisi_clock_data *data)
 {
-	/* INCOMPLETE PATCH */
-	hi6220_clk_register_divider(clks, num, data);
-	return 0;
+	return hi6220_clk_register_divider(dev, clks, num, data);
 }
 
 /* clocks in AO (always on) controller */
diff --git a/drivers/clk/hisilicon/clk-hisi-phase.c b/drivers/clk/hisilicon/clk-hisi-phase.c
index ba6afad66a2b..15a23dd6edb1 100644
--- a/drivers/clk/hisilicon/clk-hisi-phase.c
+++ b/drivers/clk/hisilicon/clk-hisi-phase.c
@@ -5,11 +5,11 @@
  * Simple HiSilicon phase clock implementation.
  */
 
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include "clk.h"
 
@@ -90,12 +90,13 @@ static const struct clk_ops clk_phase_ops = {
 	.set_phase = hisi_clk_set_phase,
 };
 
-struct clk *clk_register_hisi_phase(struct device *dev,
+struct clk_hw *devm_clk_hw_register_hisi_phase(struct device *dev,
 		const struct hisi_phase_clock *clks,
 		void __iomem *base, spinlock_t *lock)
 {
 	struct clk_hisi_phase *phase;
 	struct clk_init_data init;
+	int ret;
 
 	phase = devm_kzalloc(dev, sizeof(struct clk_hisi_phase), GFP_KERNEL);
 	if (!phase)
@@ -116,6 +117,10 @@ struct clk *clk_register_hisi_phase(struct device *dev,
 	phase->phase_num = clks->phase_num;
 	phase->hw.init = &init;
 
-	return devm_clk_register(dev, &phase->hw);
+	ret = devm_clk_hw_register(dev, &phase->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &phase->hw;
 }
-EXPORT_SYMBOL_GPL(clk_register_hisi_phase);
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_hisi_phase);
diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index fb0f5d2745b2..e2630f03b966 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -6,7 +6,7 @@
 
 #include <dt-bindings/clock/hix5hd2-clock.h>
 
-#include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -260,13 +260,13 @@ hix5hd2_clk_register_complex(struct device *dev, const void *clocks, size_t num,
 	const struct hix5hd2_complex_clock *clks = clocks;
 	void __iomem *base = data->base;
 	int i;
+	int ret;
 
 	for (i = 0; i < num; i++) {
 		struct hix5hd2_clk_complex *p_clk;
-		struct clk *clk;
 		struct clk_init_data init;
 
-		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
+		p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
 			return -ENOMEM;
 
@@ -289,15 +289,14 @@ hix5hd2_clk_register_complex(struct device *dev, const void *clocks, size_t num,
 		p_clk->phy_rst_mask = clks[i].phy_rst_mask;
 		p_clk->hw.init = &init;
 
-		clk = clk_register(NULL, &p_clk->hw);
-		if (IS_ERR(clk)) {
-			kfree(p_clk);
+		ret = devm_clk_hw_register(dev, &p_clk->hw);
+		if (ret) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			return PTR_ERR(p_clk);
+			return ret;
 		}
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = &p_clk->hw;
 	}
 
 	return 0;
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index cb4444bba2c0..8ac55e809013 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2012-2013 Hisilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
+ * Copyright (c) 2023 David Yang
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
  *	   Xin Li <li.xin@linaro.org>
@@ -13,6 +14,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -23,67 +26,44 @@
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
 
-struct hisi_clock_data *hisi_clk_alloc(struct platform_device *pdev,
-						int nr_clks)
+struct hisi_clock_data *hisi_clk_init(struct device_node *np, int nr)
 {
-	struct hisi_clock_data *clk_data;
-	struct resource *res;
-	struct clk **clk_table;
-
-	clk_data = devm_kmalloc(&pdev->dev, sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		return NULL;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return NULL;
-	clk_data->base = devm_ioremap(&pdev->dev,
-				res->start, resource_size(res));
-	if (!clk_data->base)
-		return NULL;
-
-	clk_table = devm_kmalloc_array(&pdev->dev, nr_clks,
-				       sizeof(*clk_table),
-				       GFP_KERNEL);
-	if (!clk_table)
-		return NULL;
-
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
-
-	return clk_data;
-}
-EXPORT_SYMBOL_GPL(hisi_clk_alloc);
-
-struct hisi_clock_data *hisi_clk_init(struct device_node *np,
-					     int nr_clks)
-{
-	struct hisi_clock_data *clk_data;
-	struct clk **clk_table;
 	void __iomem *base;
+	struct hisi_clock_data *data;
+	int ret;
+	int i;
 
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		goto err;
+		return NULL;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		goto err;
+	data = kmalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return NULL;
 
-	clk_data->base = base;
-	clk_table = kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
-	if (!clk_table)
+	data->clk_data = kzalloc(sizeof(*data->clk_data) + nr * sizeof(data->clk_data->hws[0]),
+			GFP_KERNEL);
+	if (!data->clk_data)
 		goto err_data;
 
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
-	return clk_data;
+	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, data->clk_data);
+	if (ret)
+		goto err_clk;
+
+	data->base = base;
+	data->clks = NULL;
+	data->clk_data->num = nr;
+	for (i = 0; i < nr; i++)
+		data->clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	return data;
+
+err_clk:
+	kfree(data->clk_data);
 err_data:
-	kfree(clk_data);
-err:
+	kfree(data);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
@@ -92,312 +72,174 @@ void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
 {
 	if (data->clks) {
 		if (data->clks->fixed_rate_clks_num)
-			hisi_clk_unregister_fixed_rate(data->clks->fixed_rate_clks,
-						       data->clks->fixed_rate_clks_num,
-						       data);
+			hisi_clk_unregister_fixed_rate(data);
 		if (data->clks->fixed_factor_clks_num)
-			hisi_clk_unregister_fixed_factor(data->clks->fixed_factor_clks,
-							 data->clks->fixed_factor_clks_num,
-							 data);
+			hisi_clk_unregister_fixed_factor(data);
 	}
 
 	of_clk_del_provider(np);
-	kfree(data->clk_data.clks);
+	kfree(data->clk_data);
 	kfree(data);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_free);
 
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
-					 int nums, struct hisi_clock_data *data)
+				 size_t num, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	int i;
 
-	for (i = 0; i < nums; i++) {
-		clk = clk_register_fixed_rate(NULL, clks[i].name,
-					      clks[i].parent_name,
-					      clks[i].flags,
-					      clks[i].fixed_rate);
+	for (i = 0; i < num; i++) {
+		const struct hisi_fixed_rate_clock *p_clk = &clks[i];
+
+		clk = clk_hw_register_fixed_rate(NULL, p_clk->name, p_clk->parent_name,
+			p_clk->flags, p_clk->fixed_rate);
+
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
+			       __func__, p_clk->name);
 			goto err;
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+
+		data->clk_data->hws[p_clk->id] = clk;
 	}
 
 	return 0;
 
 err:
 	while (i--)
-		clk_unregister_fixed_rate(data->clk_data.clks[clks[i].id]);
-
+		clk_hw_unregister_fixed_rate(data->clk_data->hws[clks[i].id]);
 	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_rate);
 
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *clks,
-					   int nums,
-					   struct hisi_clock_data *data)
+				   size_t num, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	int i;
 
-	for (i = 0; i < nums; i++) {
-		clk = clk_register_fixed_factor(NULL, clks[i].name,
-						clks[i].parent_name,
-						clks[i].flags, clks[i].mult,
-						clks[i].div);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			goto err;
-		}
-		data->clk_data.clks[clks[i].id] = clk;
-	}
-
-	return 0;
+	for (i = 0; i < num; i++) {
+		const struct hisi_fixed_factor_clock *p_clk = &clks[i];
 
-err:
-	while (i--)
-		clk_unregister_fixed_factor(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
-}
-EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_factor);
+		clk = clk_hw_register_fixed_factor(NULL, p_clk->name, p_clk->parent_name,
+			p_clk->flags, p_clk->mult, p_clk->div);
 
-int hisi_clk_register_mux(const struct hisi_mux_clock *clks,
-				  int nums, struct hisi_clock_data *data)
-{
-	struct clk *clk;
-	void __iomem *base = data->base;
-	int i;
-
-	for (i = 0; i < nums; i++) {
-		u32 mask = BIT(clks[i].width) - 1;
-
-		clk = clk_register_mux_table(NULL, clks[i].name,
-					clks[i].parent_names,
-					clks[i].num_parents, clks[i].flags,
-					base + clks[i].offset, clks[i].shift,
-					mask, clks[i].mux_flags,
-					clks[i].table, &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
+			       __func__, p_clk->name);
 			goto err;
 		}
 
-		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
-
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[p_clk->id] = clk;
 	}
 
 	return 0;
 
 err:
 	while (i--)
-		clk_unregister_mux(data->clk_data.clks[clks[i].id]);
-
+		clk_hw_unregister_fixed_rate(data->clk_data->hws[clks[i].id]);
 	return PTR_ERR(clk);
 }
-EXPORT_SYMBOL_GPL(hisi_clk_register_mux);
+EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_factor);
+
+/*
+ * We ARE function creater. Commit message from checkpatch:
+ *   Avoid warning on macros that use argument concatenation as
+ *   those macros commonly create another function
+ */
+#define hisi_clk_register_fn(fn, type, stmt) \
+int fn(struct device *dev, const struct type *clks, \
+	size_t num, struct hisi_clock_data *data) \
+{ \
+	void __iomem *base = data->base; \
+\
+	for (int i = 0; i < num; i++) { \
+		const struct type *p_clk = &clks[i]; \
+		struct clk_hw *clk = stmt; \
+\
+		if (IS_ERR(clk)) { \
+			pr_err("%s: failed to register clock %s\n", \
+			       __func__, p_clk->name); \
+			return PTR_ERR(clk); \
+		} \
+\
+		if (p_clk->alias) \
+			clk_hw_register_clkdev(clk, p_clk->alias, NULL); \
+\
+		data->clk_data->hws[p_clk->id] = clk; \
+	} \
+\
+	return 0; \
+} \
+EXPORT_SYMBOL_GPL(fn);
+
+hisi_clk_register_fn(hisi_clk_register_mux, hisi_mux_clock,
+	__devm_clk_hw_register_mux(dev, NULL, p_clk->name,
+		p_clk->num_parents, p_clk->parent_names, NULL, NULL,
+		p_clk->flags, base + p_clk->offset, p_clk->shift, BIT(p_clk->width) - 1,
+		p_clk->mux_flags, p_clk->table, &hisi_clk_lock))
 
 int hisi_clk_register_phase(struct device *dev,
 			    const struct hisi_phase_clock *clks,
-			    int nums, struct hisi_clock_data *data)
+			    size_t num, struct hisi_clock_data *data)
 {
 	void __iomem *base = data->base;
-	struct clk *clk;
-	int i;
 
-	for (i = 0; i < nums; i++) {
-		clk = clk_register_hisi_phase(dev, &clks[i], base,
-					      &hisi_clk_lock);
+	for (int i = 0; i < num; i++) {
+		const struct hisi_phase_clock *p_clk = &clks[i];
+		struct clk_hw *clk = devm_clk_hw_register_hisi_phase(dev,
+			p_clk, base, &hisi_clk_lock);
+
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
-			       clks[i].name);
+			       p_clk->name);
 			return PTR_ERR(clk);
 		}
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[p_clk->id] = clk;
 	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_phase);
 
-int hisi_clk_register_divider(const struct hisi_divider_clock *clks,
-				      int nums, struct hisi_clock_data *data)
-{
-	struct clk *clk;
-	void __iomem *base = data->base;
-	int i;
-
-	for (i = 0; i < nums; i++) {
-		clk = clk_register_divider_table(NULL, clks[i].name,
-						 clks[i].parent_name,
-						 clks[i].flags,
-						 base + clks[i].offset,
-						 clks[i].shift, clks[i].width,
-						 clks[i].div_flags,
-						 clks[i].table,
-						 &hisi_clk_lock);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			goto err;
-		}
-
-		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
-
-		data->clk_data.clks[clks[i].id] = clk;
-	}
-
-	return 0;
-
-err:
-	while (i--)
-		clk_unregister_divider(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
-}
-EXPORT_SYMBOL_GPL(hisi_clk_register_divider);
-
-int hisi_clk_register_gate(const struct hisi_gate_clock *clks,
-				       int nums, struct hisi_clock_data *data)
-{
-	struct clk *clk;
-	void __iomem *base = data->base;
-	int i;
-
-	for (i = 0; i < nums; i++) {
-		clk = clk_register_gate(NULL, clks[i].name,
-						clks[i].parent_name,
-						clks[i].flags,
-						base + clks[i].offset,
-						clks[i].bit_idx,
-						clks[i].gate_flags,
-						&hisi_clk_lock);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			goto err;
-		}
-
-		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
-
-		data->clk_data.clks[clks[i].id] = clk;
-	}
-
-	return 0;
-
-err:
-	while (i--)
-		clk_unregister_gate(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
-}
-EXPORT_SYMBOL_GPL(hisi_clk_register_gate);
-
-void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
-				       int nums, struct hisi_clock_data *data)
-{
-	struct clk *clk;
-	void __iomem *base = data->base;
-	int i;
-
-	for (i = 0; i < nums; i++) {
-		clk = hisi_register_clkgate_sep(NULL, clks[i].name,
-						clks[i].parent_name,
-						clks[i].flags,
-						base + clks[i].offset,
-						clks[i].bit_idx,
-						clks[i].gate_flags,
-						&hisi_clk_lock);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			continue;
-		}
-
-		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
-
-		data->clk_data.clks[clks[i].id] = clk;
-	}
-}
-EXPORT_SYMBOL_GPL(hisi_clk_register_gate_sep);
-
-void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
-					int nums, struct hisi_clock_data *data)
-{
-	struct clk *clk;
-	void __iomem *base = data->base;
-	int i;
-
-	for (i = 0; i < nums; i++) {
-		clk = hi6220_register_clkdiv(NULL, clks[i].name,
-						clks[i].parent_name,
-						clks[i].flags,
-						base + clks[i].offset,
-						clks[i].shift,
-						clks[i].width,
-						clks[i].mask_bit,
-						&hisi_clk_lock);
-		if (IS_ERR(clk)) {
-			pr_err("%s: failed to register clock %s\n",
-			       __func__, clks[i].name);
-			continue;
-		}
-
-		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
-
-		data->clk_data.clks[clks[i].id] = clk;
-	}
-}
+hisi_clk_register_fn(hisi_clk_register_divider, hisi_divider_clock,
+	devm_clk_hw_register_divider_table(dev, p_clk->name, p_clk->parent_name,
+		p_clk->flags, base + p_clk->offset, p_clk->shift, p_clk->width,
+		p_clk->div_flags, p_clk->table, &hisi_clk_lock))
+hisi_clk_register_fn(hisi_clk_register_gate, hisi_gate_clock,
+	devm_clk_hw_register_gate(dev, p_clk->name, p_clk->parent_name,
+		p_clk->flags, base + p_clk->offset, p_clk->bit_idx,
+		p_clk->gate_flags, &hisi_clk_lock))
+hisi_clk_register_fn(hisi_clk_register_gate_sep, hisi_gate_clock,
+	devm_clk_hw_register_hisi_gate_sep(dev, p_clk->name, p_clk->parent_name,
+		p_clk->flags, base + p_clk->offset, p_clk->bit_idx,
+		p_clk->gate_flags, &hisi_clk_lock))
+hisi_clk_register_fn(hi6220_clk_register_divider, hi6220_divider_clock,
+	devm_clk_hw_register_hi6220_divider(dev, p_clk->name, p_clk->parent_name,
+		p_clk->flags, base + p_clk->offset, p_clk->shift, p_clk->width,
+		p_clk->mask_bit, &hisi_clk_lock))
 
 int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
 		      struct hisi_clock_data *data)
 {
 	int ret;
 
-	if (clks->mux_clks_num) {
-		ret = hisi_clk_register_mux(clks->mux_clks,
-					    clks->mux_clks_num, data);
-		if (ret)
-			return ret;
-	}
-
-	if (clks->phase_clks_num) {
-		ret = hisi_clk_register_phase(dev, clks->phase_clks,
-					      clks->phase_clks_num, data);
-		if (ret)
-			return ret;
-	}
-
-	if (clks->divider_clks_num) {
-		ret = hisi_clk_register_divider(clks->divider_clks,
-						clks->divider_clks_num, data);
-		if (ret)
-			return ret;
-	}
-
-	if (clks->gate_clks_num) {
-		ret = hisi_clk_register_gate(clks->gate_clks,
-					     clks->gate_clks_num, data);
-		if (ret)
-			return ret;
-	}
-
-	if (clks->gate_sep_clks_num) {
-		hisi_clk_register_gate_sep(clks->gate_sep_clks,
-					   clks->gate_sep_clks_num, data);
-	}
+#define do_hisi_clk_register(type) do { \
+	if (clks->type##_clks_num) { \
+		ret = hisi_clk_register_##type(dev, clks->type##_clks, \
+					       clks->type##_clks_num, data); \
+		if (ret) \
+			return ret; \
+	} \
+} while (0)
+
+	do_hisi_clk_register(mux);
+	do_hisi_clk_register(phase);
+	do_hisi_clk_register(divider);
+	do_hisi_clk_register(gate);
+	do_hisi_clk_register(gate_sep);
 
 	if (clks->clk_register_customized && clks->customized_clks_num) {
 		ret = clks->clk_register_customized(dev, clks->customized_clks,
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index cc580915d058..903197397fcf 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2012-2013 Hisilicon Limited.
  * Copyright (c) 2012-2013 Linaro Limited.
+ * Copyright (c) 2023 David Yang
  *
  * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
  *	   Xin Li <li.xin@linaro.org>
@@ -19,9 +20,19 @@
 struct platform_device;
 struct hisi_clocks;
 
+/*
+ * (Virtual) fixed clocks, often depended by crucial peripherals, require
+ * early initialization before device probing, thus cannot use devm APIs.
+ * Otherwise, kernel will defer those peripherals, causing boot failure.
+ *
+ * fixed_rate and fixed_factor clocks are driver-managed. They are freed by
+ * `hisi_clk_free` altogether.
+ *
+ * Other clocks are devm-managed.
+ */
 struct hisi_clock_data {
-	struct clk_onecell_data	clk_data;
-	void __iomem		*base;
+	struct clk_hw_onecell_data	*clk_data;
+	void __iomem			*base;
 	const struct hisi_clocks	*clks;
 };
 
@@ -138,37 +149,45 @@ struct hisi_clocks {
 				       size_t num, struct hisi_clock_data *data);
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *, const char *,
-				const char *, unsigned long,
-				void __iomem *, u8,
-				u8, spinlock_t *);
-struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
-	const char *parent_name, unsigned long flags, void __iomem *reg,
-	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
-
-struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
-struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
-void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
-int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_mux(const struct hisi_mux_clock *, int,
-				struct hisi_clock_data *);
-struct clk *clk_register_hisi_phase(struct device *dev,
-				const struct hisi_phase_clock *clks,
+struct clk_hw *
+devm_clk_hw_register_hisi_phase(struct device *dev, const struct hisi_phase_clock *clks,
 				void __iomem *base, spinlock_t *lock);
+struct clk_hw *
+devm_clk_hw_register_hisi_gate_sep(struct device *dev, const char *name,
+				   const char *parent_name, unsigned long flags,
+				   void __iomem *reg, u8 bit_idx,
+				   u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *
+devm_clk_hw_register_hi6220_divider(struct device *dev, const char *name,
+				    const char *parent_name, unsigned long flags,
+				    void __iomem *reg, u8 shift,
+				    u8 width, u32 mask_bit, spinlock_t *lock);
+
+struct hisi_clock_data *hisi_clk_init(struct device_node *np, int nr);
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
+
+int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
+				 size_t num, struct hisi_clock_data *data);
+int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *clks,
+				   size_t num, struct hisi_clock_data *data);
+
+int hisi_clk_register_mux(struct device *dev, const struct hisi_mux_clock *clks,
+			  size_t num, struct hisi_clock_data *data);
 int hisi_clk_register_phase(struct device *dev,
-				const struct hisi_phase_clock *clks,
-				int nums, struct hisi_clock_data *data);
-int hisi_clk_register_divider(const struct hisi_divider_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_gate(const struct hisi_gate_clock *,
-				int, struct hisi_clock_data *);
-void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
-				int, struct hisi_clock_data *);
-void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
-				int, struct hisi_clock_data *);
+			    const struct hisi_phase_clock *clks,
+			    size_t num, struct hisi_clock_data *data);
+int hisi_clk_register_divider(struct device *dev,
+			      const struct hisi_divider_clock *clks,
+			      size_t num, struct hisi_clock_data *data);
+int hisi_clk_register_gate(struct device *dev,
+			   const struct hisi_gate_clock *clks,
+			   size_t num, struct hisi_clock_data *data);
+int hisi_clk_register_gate_sep(struct device *dev,
+			       const struct hisi_gate_clock *clks,
+			       size_t num, struct hisi_clock_data *data);
+int hi6220_clk_register_divider(struct device *dev,
+				const struct hi6220_divider_clock *clks,
+				size_t num, struct hisi_clock_data *data);
 
 int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
 		      struct hisi_clock_data *data);
@@ -181,22 +200,17 @@ int hisi_clk_remove(struct platform_device *pdev);
 
 #define hisi_clk_unregister_fn(type) \
 static inline \
-void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
-				int nums, struct hisi_clock_data *data) \
+void hisi_clk_unregister_##type(struct hisi_clock_data *data) \
 { \
-	struct clk **clocks = data->clk_data.clks; \
 	int i; \
-	for (i = 0; i < nums; i++) { \
-		int id = clks[i].id; \
-		if (clocks[id])  \
-			clk_unregister_##type(clocks[id]); \
+	for (i = 0; i < data->clks->type##_clks_num; i++) { \
+		struct clk_hw *clk = data->clk_data->hws[data->clks->type##_clks[i].id]; \
+		if (clk && !IS_ERR(clk)) \
+			clk_hw_unregister_##type(clk); \
 	} \
 }
 
 hisi_clk_unregister_fn(fixed_rate)
 hisi_clk_unregister_fn(fixed_factor)
-hisi_clk_unregister_fn(mux)
-hisi_clk_unregister_fn(divider)
-hisi_clk_unregister_fn(gate)
 
 #endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
index 5348bafe694f..3c03b3e5b841 100644
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -9,7 +9,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/spinlock.h>
@@ -97,19 +97,19 @@ static const struct clk_ops hi6220_clkdiv_ops = {
 	.set_rate = hi6220_clkdiv_set_rate,
 };
 
-struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
+struct clk_hw *devm_clk_hw_register_hi6220_divider(struct device *dev, const char *name,
 	const char *parent_name, unsigned long flags, void __iomem *reg,
 	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock)
 {
 	struct hi6220_clk_divider *div;
-	struct clk *clk;
 	struct clk_init_data init;
 	struct clk_div_table *table;
 	u32 max_div, min_div;
 	int i;
+	int ret;
 
 	/* allocate the divider */
-	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
 		return ERR_PTR(-ENOMEM);
 
@@ -117,11 +117,9 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 	max_div = div_mask(width) + 1;
 	min_div = 1;
 
-	table = kcalloc(max_div + 1, sizeof(*table), GFP_KERNEL);
-	if (!table) {
-		kfree(div);
+	table = devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERNEL);
+	if (!table)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	for (i = 0; i < max_div; i++) {
 		table[i].div = min_div + i;
@@ -144,11 +142,9 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 	div->table = table;
 
 	/* register the clock */
-	clk = clk_register(dev, &div->hw);
-	if (IS_ERR(clk)) {
-		kfree(table);
-		kfree(div);
-	}
+	ret = devm_clk_hw_register(dev, &div->hw);
+	if (ret)
+		return ERR_PTR(ret);
 
-	return clk;
+	return &div->hw;
 }
diff --git a/drivers/clk/hisilicon/clkgate-separated.c b/drivers/clk/hisilicon/clkgate-separated.c
index 90d858522967..dc64a8a0ab58 100644
--- a/drivers/clk/hisilicon/clkgate-separated.c
+++ b/drivers/clk/hisilicon/clkgate-separated.c
@@ -11,8 +11,8 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/io.h>
-#include <linux/slab.h>
 
 #include "clk.h"
 
@@ -80,17 +80,18 @@ static const struct clk_ops clkgate_separated_ops = {
 	.is_enabled	= clkgate_separated_is_enabled,
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
-				      const char *parent_name,
-				      unsigned long flags,
-				      void __iomem *reg, u8 bit_idx,
-				      u8 clk_gate_flags, spinlock_t *lock)
+struct clk_hw *
+devm_clk_hw_register_hisi_gate_sep(struct device *dev, const char *name,
+				   const char *parent_name,
+				   unsigned long flags,
+				   void __iomem *reg, u8 bit_idx,
+				   u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clkgate_separated *sclk;
-	struct clk *clk;
 	struct clk_init_data init;
+	int ret;
 
-	sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
+	sclk = devm_kzalloc(dev, sizeof(*sclk), GFP_KERNEL);
 	if (!sclk)
 		return ERR_PTR(-ENOMEM);
 
@@ -106,8 +107,9 @@ struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
 	sclk->hw.init = &init;
 	sclk->lock = lock;
 
-	clk = clk_register(dev, &sclk->hw);
-	if (IS_ERR(clk))
-		kfree(sclk);
-	return clk;
+	ret = devm_clk_hw_register(dev, &sclk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &sclk->hw;
 }
-- 
2.39.2

