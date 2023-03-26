Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89756C9297
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 07:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjCZF20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 01:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjCZF2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 01:28:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB1330F2;
        Sat, 25 Mar 2023 22:28:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso8940556pjb.0;
        Sat, 25 Mar 2023 22:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679808500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzqnlpaZQYiWvtgYVVVK+zVHzXORQeLQeNjwiqHCZDc=;
        b=fHhDQ3XPWZJSNlJoNx6L35AB4WPx7YjQgPEGEthRfxFOsS8HqTtbr79Yr7kDIFRcCH
         MneEmeUrdMkKuXAIXgVyIvaC9+OZWeZtL9d9Jmd2kQp4EabPLBore8QPoOo1bYHZ1Uk0
         QVH40YQ9paqT194m+XDPcYIUEbla3zzv3cl4HSnol18L+yz3S8VROkFjvUDAv8pu7bCQ
         XUjN3+7/hjjzbXv+GTClyl+9fAuBg9kcHxmrJVE6n0ZwRHO16pGQrLuVP0/jyzcTIaHK
         Au1/7GsO1/YSQ1kB9dLr0JLwHjih3GLMP+n6c01mv5GHSnm/GESPPex+qSc9Ao7Nfil/
         PCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679808500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzqnlpaZQYiWvtgYVVVK+zVHzXORQeLQeNjwiqHCZDc=;
        b=MkTy/fYHSzgINcMqa6THQQK3aA1re1Tz5VNtdJ1aKqEeg3eK0H2epgf438OkKtFJ91
         o48NHDHecwZdfHGHv7h2xgI19dmAJB+ykURwadP2bKDqznYXlC4Cv4URkmWsMORR3Fna
         XoVZYbNlzfSBGNkWXWpwPqrLGgAgXjkpZJP2hC5LgyyovEWtWAIgxwhC37z1lIYLAVXv
         8K3bC5UCtn7ETY87E0R3gZBR/0Ei7jdL/KdvWR4melsOfbE8IsYLxGzvZN4moDeat9WC
         v6n6k2h6ruU4dRkj8fjlWPagMPeYlLjFocFtf9PZ7dZRxv5yhWJRppKxmeVYGsseYG9V
         Me1A==
X-Gm-Message-State: AO0yUKXftHnA1fAdaUjg9Ai9USfGlYE6oRZ9PgyoGnF26Hu8zQAnbyaI
        py5mDFRcXuzEhV7poBZr3F2LRSfQmLts1BMO
X-Google-Smtp-Source: AK7set9iEFTTnJpueWiQ1nQlzpGTSB4Rq3ajQ7O/kbYczaQUPm+joQFkIh4Zalm3zvWqqBq68jBFmw==
X-Received: by 2002:a05:6a20:6695:b0:cc:6699:dd8a with SMTP id o21-20020a056a20669500b000cc6699dd8amr8122889pzh.45.1679808500304;
        Sat, 25 Mar 2023 22:28:20 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id b14-20020a63eb4e000000b004fb5f4bf585sm15966915pgk.78.2023.03.25.22.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:28:20 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] clk: hisilicon: Add helper functions for platform driver
Date:   Sun, 26 Mar 2023 13:27:47 +0800
Message-Id: <20230326052757.297551-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230326052757.297551-1-mmyangfl@gmail.com>
References: <20230326052757.297551-1-mmyangfl@gmail.com>
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

Helper functions extract common operations on platform drivers.

During migration to devm APIs, (virtual) fixed clocks were found hard on
devm APIs, since they often depended by crucial peripherals, thus require
early initialization before device probing, and cannot use devm APIs.

One solution to this problem is to add a "fixed-clock" node to device tree,
independent to clock device, and make those peripherals depend on that.
However, there is also some devices that do use fixed clocks provided by
drivers, for example clk-hi3660.c .

To simplify codes, we migrate clocks of other types to devm APIs, while
keep fixed clocks self-managed, alongside with struct hisi_clock_data, and
remove devm-managed hisi_clock_data.

`hisi_clk_alloc` will be removed in the following patch.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk.c   | 148 ++++++++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.h   |  56 +++++++++++--
 drivers/clk/hisilicon/crg.h   |   5 ++
 drivers/clk/hisilicon/reset.c |  65 ++++++++++++++-
 4 files changed, 266 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93599..96bbc09e7d45 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -88,6 +88,25 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
 
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
+{
+	if (data->clks) {
+		if (data->clks->fixed_rate_clks_num)
+			hisi_clk_unregister_fixed_rate(data->clks->fixed_rate_clks,
+						       data->clks->fixed_rate_clks_num,
+						       data);
+		if (data->clks->fixed_factor_clks_num)
+			hisi_clk_unregister_fixed_factor(data->clks->fixed_factor_clks,
+							 data->clks->fixed_factor_clks_num,
+							 data);
+	}
+
+	of_clk_del_provider(np);
+	kfree(data->clk_data.clks);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_free);
+
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
@@ -341,3 +360,132 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+		      struct hisi_clock_data *data)
+{
+	int ret;
+
+	if (clks->mux_clks_num) {
+		ret = hisi_clk_register_mux(clks->mux_clks,
+					    clks->mux_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->phase_clks_num) {
+		ret = hisi_clk_register_phase(dev, clks->phase_clks,
+					      clks->phase_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->divider_clks_num) {
+		ret = hisi_clk_register_divider(clks->divider_clks,
+						clks->divider_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_clks_num) {
+		ret = hisi_clk_register_gate(clks->gate_clks,
+					     clks->gate_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	if (clks->gate_sep_clks_num) {
+		hisi_clk_register_gate_sep(clks->gate_sep_clks,
+					   clks->gate_sep_clks_num, data);
+	}
+
+	if (clks->clk_register_customized && clks->customized_clks_num) {
+		ret = clks->clk_register_customized(dev, clks->customized_clks,
+						    clks->customized_clks_num, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_register);
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks)
+{
+	struct hisi_clock_data *data;
+	int ret;
+
+	data = hisi_clk_init(np, clks->nr);
+	if (!data)
+		return -ENOMEM;
+	data->clks = clks;
+
+	ret = hisi_clk_register_fixed_rate(clks->fixed_rate_clks,
+					   clks->fixed_rate_clks_num, data);
+	if (ret)
+		goto err;
+
+	ret = hisi_clk_register_fixed_factor(clks->fixed_factor_clks,
+					     clks->fixed_factor_clks_num, data);
+	if (ret)
+		goto err;
+
+	np->data = data;
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_early_init);
+
+int hisi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct hisi_clocks *clks;
+	struct hisi_clock_data *data;
+	int ret;
+
+	clks = of_device_get_match_data(dev);
+	if (!clks)
+		return -ENOENT;
+
+	if (!np->data) {
+		ret = hisi_clk_early_init(np, clks);
+		if (ret)
+			return ret;
+	}
+
+	data = np->data;
+	np->data = NULL;
+
+	if (clks->prologue) {
+		ret = clks->prologue(dev, data);
+		if (ret)
+			goto err;
+	}
+
+	ret = hisi_clk_register(dev, clks, data);
+	if (ret)
+		goto err;
+
+	platform_set_drvdata(pdev, data);
+	return 0;
+
+err:
+	hisi_clk_free(np, data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_probe);
+
+int hisi_clk_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_clock_data *data = platform_get_drvdata(pdev);
+
+	hisi_clk_free(np, data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_clk_remove);
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 7a9b42e1b027..def94498e14d 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -17,10 +17,12 @@
 #include <linux/spinlock.h>
 
 struct platform_device;
+struct hisi_clocks;
 
 struct hisi_clock_data {
 	struct clk_onecell_data	clk_data;
 	void __iomem		*base;
+	const struct hisi_clocks	*clks;
 };
 
 struct hisi_fixed_rate_clock {
@@ -103,6 +105,38 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
+struct hisi_clocks {
+	int nr;
+
+	int (*prologue)(struct device *dev, struct hisi_clock_data *data);
+
+	const struct hisi_fixed_rate_clock *fixed_rate_clks;
+	int fixed_rate_clks_num;
+
+	const struct hisi_fixed_factor_clock *fixed_factor_clks;
+	int fixed_factor_clks_num;
+
+	const struct hisi_mux_clock *mux_clks;
+	int mux_clks_num;
+
+	const struct hisi_phase_clock *phase_clks;
+	int phase_clks_num;
+
+	const struct hisi_divider_clock *divider_clks;
+	int divider_clks_num;
+
+	const struct hisi_gate_clock *gate_clks;
+	int gate_clks_num;
+
+	const struct hisi_gate_clock *gate_sep_clks;
+	int gate_sep_clks_num;
+
+	const void *customized_clks;
+	int customized_clks_num;
+	int (*clk_register_customized)(struct device *dev, const void *clks,
+				       int num, struct hisi_clock_data *data);
+};
+
 struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
@@ -113,6 +147,7 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 
 struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
@@ -134,7 +169,16 @@ void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
 void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
 				int, struct hisi_clock_data *);
 
-#define hisi_clk_unregister(type) \
+int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+		      struct hisi_clock_data *data);
+
+/* helper functions for platform driver */
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
+int hisi_clk_probe(struct platform_device *pdev);
+int hisi_clk_remove(struct platform_device *pdev);
+
+#define hisi_clk_unregister_fn(type) \
 static inline \
 void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
 				int nums, struct hisi_clock_data *data) \
@@ -148,10 +192,10 @@ void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
 	} \
 }
 
-hisi_clk_unregister(fixed_rate)
-hisi_clk_unregister(fixed_factor)
-hisi_clk_unregister(mux)
-hisi_clk_unregister(divider)
-hisi_clk_unregister(gate)
+hisi_clk_unregister_fn(fixed_rate)
+hisi_clk_unregister_fn(fixed_factor)
+hisi_clk_unregister_fn(mux)
+hisi_clk_unregister_fn(divider)
+hisi_clk_unregister_fn(gate)
 
 #endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index 803f6ba6d7a2..d9544f1f2625 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -22,4 +22,9 @@ struct hisi_crg_dev {
 	const struct hisi_crg_funcs *funcs;
 };
 
+/* helper functions for platform driver */
+
+int hisi_crg_probe(struct platform_device *pdev);
+int hisi_crg_remove(struct platform_device *pdev);
+
 #endif	/* __HISI_CRG_H */
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17db8b1..471b5670e4dc 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -5,12 +5,16 @@
  * Copyright (c) 2015-2016 HiSilicon Technologies Co., Ltd.
  */
 
+#include <linux/device.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/of_address.h>
-#include <linux/platform_device.h>
+#include <linux/of_device.h>
 #include <linux/reset-controller.h>
-#include <linux/slab.h>
 #include <linux/spinlock.h>
+
+#include "clk.h"
+#include "crg.h"
 #include "reset.h"
 
 #define	HISI_RESET_BIT_MASK	0x1f
@@ -116,3 +120,60 @@ void hisi_reset_exit(struct hisi_reset_controller *rstc)
 	reset_controller_unregister(&rstc->rcdev);
 }
 EXPORT_SYMBOL_GPL(hisi_reset_exit);
+
+int hisi_crg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct hisi_clocks *clks;
+	struct hisi_crg_dev *crg;
+	int ret;
+
+	clks = of_device_get_match_data(dev);
+	if (!clks)
+		return -ENOENT;
+
+	crg = devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	if (!np->data) {
+		ret = hisi_clk_early_init(np, clks);
+		if (ret)
+			return ret;
+	}
+
+	crg->clk_data = np->data;
+	np->data = NULL;
+
+	ret = hisi_clk_register(dev, clks, crg->clk_data);
+	if (ret)
+		goto err;
+
+	crg->rstc = hisi_reset_init(pdev);
+	if (!crg->rstc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, crg);
+	return 0;
+
+err:
+	hisi_clk_free(np, crg->clk_data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_probe);
+
+int hisi_crg_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	crg->funcs->unregister_clks(pdev);
+	hisi_clk_free(np, crg->clk_data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_remove);
-- 
2.39.2

