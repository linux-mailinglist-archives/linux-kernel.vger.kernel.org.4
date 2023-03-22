Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14E6C510C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCVQnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCVQnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:43:35 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565242E0F9;
        Wed, 22 Mar 2023 09:43:23 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c18so19804622ple.11;
        Wed, 22 Mar 2023 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVyUZikSaJsNxn1wjR+Qtg9neKLZcplSxWneVSZ9wvE=;
        b=N4QGr2I7ZjryaUhKt7UQKYoBFiRWMtfvY7Kicm8a+JrNtwTRuvfk6ng7M/A0AhoTJE
         /x9sDRl0yYEkbgVdhMD0+iwJRjplHzcMLaYEjjsjhwTgLoQphiv4F4d4PqKstpsznwX9
         8SiV4RUy/vLAulZPoQkKIeMPm7m4d2tWemQanjpSEfy6KbX334bEF3Hc0n3QQ40yzeRW
         Y17kGH8rFhFu/vZ2xhFr1Fq0a77acJLGScjS1IrheHd5rl1JbzgOK5MbAeeB+Tnjy2S7
         dL1ZetSTuovz3zJyjUnLk6QgtfWSTaXaLEtVkfQ1g4JnWlcZffPPrJytNSKijHLJbqqD
         ntOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVyUZikSaJsNxn1wjR+Qtg9neKLZcplSxWneVSZ9wvE=;
        b=QavPytaXhMb1+guPv+LzVWWgeL/rGuLDc0lR4xnui5CfGmuWMwCyft3hmKzyA0KPsj
         9vutBxwhnsQ5lJSXXmLCvTCl4ui5OiSSqDyWWrTVGoRj9JcrLQweKx2YrjBhJRC3Axfn
         7TJAMWB9HpfIpSQLTiqxccDdOzyE3IH5oyYZ9kdBBOkPy6s+KkVcWK523hZQJHIfaBvX
         3lOYisXCPo1YplQycd+ItRlnkZoXYUt3pU6ieA87W87RrrEnEm2n1RdacUKeI6hAxcsf
         xyOLors5mbxylmyeyjqQHhwKXWzH1a6fWDnv4aTqxblr57U0jQamqAsfwqAd0CmHsrO/
         cc7Q==
X-Gm-Message-State: AO0yUKXyZdhaHFk8cIMGbah4423zEmJGTXRTm46pYExGb7vXtIUjysRZ
        OEqP/hismFL92J7avyfSZ4uftSFv2ZBnupvTgKU=
X-Google-Smtp-Source: AK7set9nBUOG+TF6bBUQ5eAIPk9IeXUHJpFwZLbvywI9fnLPpKGZ1ZrX30E7O5OxybXHh1bCgciHYw==
X-Received: by 2002:a05:6a20:e13:b0:da:e752:d47c with SMTP id ej19-20020a056a200e1300b000dae752d47cmr254186pzb.12.1679503402267;
        Wed, 22 Mar 2023 09:43:22 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:43:21 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] clk: hisilicon: Migrate devm APIs
Date:   Thu, 23 Mar 2023 00:41:55 +0800
Message-Id: <20230322164201.2454771-8-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322164201.2454771-1-mmyangfl@gmail.com>
References: <20230322164201.2454771-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrates devm APIs for HiSilicon clock drivers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3559a.c       |  29 +-
 drivers/clk/hisilicon/clk-hi3620.c        |  28 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c   |   9 +-
 drivers/clk/hisilicon/clk-hi6220.c        |  13 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  13 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  12 +-
 drivers/clk/hisilicon/clk.c               | 330 +++++++---------------
 drivers/clk/hisilicon/clk.h               |  80 +++---
 drivers/clk/hisilicon/clkdivider-hi6220.c |  24 +-
 drivers/clk/hisilicon/clkgate-separated.c |  26 +-
 10 files changed, 230 insertions(+), 334 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index d641b2a75..926a7c211 100644
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
-	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
-
-	if (!p_clk)
-		return -ENOMEM;
+	int ret;
 
 	for (i = 0; i < nums; i++) {
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
index 0a973c677..97f6d1d63 100644
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
 
@@ -431,27 +429,31 @@ clk_register_hisi_mmc(struct device *dev, const struct hisi_mmc_clock *mmc_clk,
 	mclk->sam_off = mmc_clk->sam_off;
 	mclk->sam_bits = mmc_clk->sam_bits;
 
-	clk = clk_register(NULL, &mclk->hw);
-	if (WARN_ON(IS_ERR(clk)))
-		kfree(mclk);
-	return clk;
+	ret = devm_clk_hw_register(dev, &mclk->hw);
+	if (ret) {
+		dev_err(dev, "%s: failed to register clock %s\n",
+			__func__, clks[i].name);
+		return ret;
+	}
+
+	return &mclk->hw;
 }
 
 static int hisi_register_clk_mmc(struct device *dev, const void *clocks,
 				 int nums, struct hisi_clock_data *data)
 {
 	const struct hisi_mmc_clock *clks = clocks;
-	struct clk *clk;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
+		struct clk_hw *clk = clk_register_hisi_mmc(dev, &clks[i], data->base);
+
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
index 4fdee4424..dd996a439 100644
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
index 7bd5008a0..8b166f4e2 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -16,6 +16,13 @@
 
 #include "clk.h"
 
+static int
+hi6220_clk_register_divider_stub(struct device *dev, const void *clks,
+				 int num, struct hisi_clock_data *data)
+{
+	return hi6220_clk_register_divider(dev, clks, num, data);
+}
+
 /* clocks in AO (always on) controller */
 static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] = {
 	{ HI6220_REF32K,	"ref32k",	NULL, 0, 32764,     },
@@ -176,7 +183,7 @@ static const struct hisi_clocks hi6220_sys_clks = {
 	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_sys),
 	.customized_clks = hi6220_div_clks_sys,
 	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_sys),
-	.clk_register_customized = hi6220_clk_register_divider,
+	.clk_register_customized = hi6220_clk_register_divider_stub,
 };
 
 /* clocks in media controller */
@@ -224,7 +231,7 @@ static const struct hisi_clocks hi6220_media_clks = {
 	.gate_sep_clks_num = ARRAY_SIZE(hi6220_separated_gate_clks_media),
 	.customized_clks = hi6220_div_clks_media,
 	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_media),
-	.clk_register_customized = hi6220_clk_register_divider,
+	.clk_register_customized = hi6220_clk_register_divider_stub,
 };
 
 /* clocks in pmctrl */
@@ -247,7 +254,7 @@ static const struct hisi_clocks hi6220_power_clks = {
 	.gate_clks_num = ARRAY_SIZE(hi6220_gate_clks_power),
 	.customized_clks = hi6220_div_clks_power,
 	.customized_clks_num = ARRAY_SIZE(hi6220_div_clks_power),
-	.clk_register_customized = hi6220_clk_register_divider,
+	.clk_register_customized = hi6220_clk_register_divider_stub,
 };
 
 /* clocks in acpu */
diff --git a/drivers/clk/hisilicon/clk-hisi-phase.c b/drivers/clk/hisilicon/clk-hisi-phase.c
index ba6afad66..15a23dd6e 100644
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
index 4243f592a..e72c8f64a 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -6,7 +6,7 @@
 
 #include <dt-bindings/clock/hix5hd2-clock.h>
 
-#include <linux/slab.h>
+#include <linux/device.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -260,13 +260,14 @@ hix5hd2_clk_register_complex(struct device *dev, const void *clocks, int nums,
 	struct hix5hd2_complex_clock *clks = clocks;
 	void __iomem *base = data->base;
 	int i;
+	int ret;
 
 	for (i = 0; i < nums; i++) {
 		struct hix5hd2_clk_complex *p_clk;
 		struct clk *clk;
 		struct clk_init_data init;
 
-		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
+		p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
 			return -ENOMEM;
 
@@ -289,12 +290,11 @@ hix5hd2_clk_register_complex(struct device *dev, const void *clocks, int nums,
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
 
 		data->clk_data.clks[clks[i].id] = clk;
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 439fd154b..56bab595f 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -13,6 +13,8 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -23,35 +25,44 @@
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
 
-struct hisi_clock_data *hisi_clk_init(struct device_node *np,
-					     int nr_clks)
+struct hisi_clock_data *hisi_clk_init(struct device_node *np, int nr)
 {
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
@@ -66,270 +77,145 @@ void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
 	}
 
 	of_clk_del_provider(np);
-	kfree(data->clk_data.clks);
+	kfree(data->clk_data);
 	kfree(data);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_free);
 
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
-					 int nums, struct hisi_clock_data *data)
+				 int num, struct hisi_clock_data *data)
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
+				   int num, struct hisi_clock_data *data)
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
+		clk = clk_hw_register_fixed_factor(NULL, p_clk->name, p_clk->parent_name,
+			p_clk->flags, p_clk->mult, p_clk->div);
 
-	return PTR_ERR(clk);
-}
-EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_factor);
-
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
+#define hisi_clk_register_fn(fn, type, stmt) \
+int fn(struct device *dev, const struct type *clks, \
+	int num, struct hisi_clock_data *data) \
+{ \
+	void __iomem *base = data->base; \
+	int i; \
+\
+	for (i = 0; i < num; i++) { \
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
+			    int num, struct hisi_clock_data *data)
 {
 	void __iomem *base = data->base;
-	struct clk *clk;
 	int i;
 
-	for (i = 0; i < nums; i++) {
-		clk = clk_register_hisi_phase(dev, &clks[i], base,
-					      &hisi_clk_lock);
+	for (i = 0; i < num; i++) {
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
-int hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
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
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hisi_clk_register_gate_sep);
-
-int hi6220_clk_register_divider(struct device *dev,
-				const struct hi6220_divider_clock *clks,
-				int nums, struct hisi_clock_data *data)
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
-			return PTR_ERR(clk);
-		}
-
-		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
-
-		data->clk_data.clks[clks[i].id] = clk;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hi6220_clk_register_divider);
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
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index daa85acda..1ab1401ee 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -30,8 +30,8 @@ struct hisi_clocks;
  * Other clocks are devm-managed.
  */
 struct hisi_clock_data {
-	struct clk_onecell_data	clk_data;
-	void __iomem		*base;
+	struct clk_hw_onecell_data	*clk_data;
+	void __iomem			*base;
 	const struct hisi_clocks	*clks;
 };
 
@@ -147,39 +147,46 @@ struct hisi_clocks {
 				       int num, struct hisi_clock_data *data);
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *, const char *,
-				const char *, unsigned long,
-				void __iomem *, u8,
-				u8, spinlock_t *);
-struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
-	const char *parent_name, unsigned long flags, void __iomem *reg,
-	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
-
-struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+struct clk_hw *
+devm_clk_hw_register_hisi_phase(struct device *dev, const struct hisi_phase_clock *clks,
+				void __iomem *base, spinlock_t *lock);
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
 void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
 
-int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
-				int, struct hisi_clock_data *);
+int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
+				 int num, struct hisi_clock_data *data);
+int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *clks,
+				   int num, struct hisi_clock_data *data);
 
-int hisi_clk_register_mux(const struct hisi_mux_clock *, int,
-				struct hisi_clock_data *);
-struct clk *clk_register_hisi_phase(struct device *dev,
-				const struct hisi_phase_clock *clks,
-				void __iomem *base, spinlock_t *lock);
+int hisi_clk_register_mux(struct device *dev,
+			  const struct hisi_mux_clock *clks, int num,
+			  struct hisi_clock_data *data);
 int hisi_clk_register_phase(struct device *dev,
-				const struct hisi_phase_clock *clks,
-				int nums, struct hisi_clock_data *data);
-int hisi_clk_register_divider(const struct hisi_divider_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_gate(const struct hisi_gate_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
-			       int nums, struct hisi_clock_data *data);
+			    const struct hisi_phase_clock *clks,
+			    int num, struct hisi_clock_data *data);
+int hisi_clk_register_divider(struct device *dev,
+			      const struct hisi_divider_clock *clks,
+			      int num, struct hisi_clock_data *data);
+int hisi_clk_register_gate(struct device *dev,
+			   const struct hisi_gate_clock *clks,
+			   int num, struct hisi_clock_data *data);
+int hisi_clk_register_gate_sep(struct device *dev,
+			       const struct hisi_gate_clock *clks,
+			       int num, struct hisi_clock_data *data);
 int hi6220_clk_register_divider(struct device *dev,
 				const struct hi6220_divider_clock *clks,
-				int nums, struct hisi_clock_data *data);
+				int num, struct hisi_clock_data *data);
 
 int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
 		      struct hisi_clock_data *data);
@@ -192,22 +199,17 @@ int hisi_clk_remove(struct platform_device *pdev);
 
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
index 5348bafe6..3c03b3e5b 100644
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
index 90d858522..dc64a8a0a 100644
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

