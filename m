Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6973E6CD3BB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjC2Hw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjC2Hv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:51:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F1E35B5;
        Wed, 29 Mar 2023 00:51:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so17734519pjb.4;
        Wed, 29 Mar 2023 00:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680076311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKHiROYEntsmowdq7zzh65GeTvG6kTuPX2OWHAUJB1Y=;
        b=E9sVJSaiYe/BNbXnMIpvDFgAjBl2WtwbfMXXsHWz2Vl7egBlWUZA9kkCicyx/6ohdu
         hkoceOxLn4HbtMROp5NWwkubbayKNSkC1/MmKYUmMpZhayyAl1g6wghII/lgAL9D73VD
         6ntHdQ6Ibn04jgVYDt27jpATgpjwwIAYH8MOoLu+fH7xA0AY+rSIvHanXTNuHLsXpGzI
         NPRfBnSM4EAD2gYIIKH9/WBtwnNNkv9GNxkATjpwcZBNoTskE2UNXBR0swoV7kyAIHdy
         r8g1mNEnJNXZwkpY9N1cQgQme0qD5C2kFM7XnXf30i/RPlNYjDeeVw86BH0JEnOdE0EG
         9t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKHiROYEntsmowdq7zzh65GeTvG6kTuPX2OWHAUJB1Y=;
        b=xrcLchcBptDU3R6vb3fEk3iYAv0PAj2zYBBqXstO83INWyOpWXvsXkWvsXEZOWyM7V
         oa0oG185+0FU0fwRs3wO6t+s/YvyJj8CiQy30RFN/cUwOcqxaU084+p1w5FxvCezJLuz
         I6w7gWhmQ1jJud2HMmN63QjaWFPvekBsu6M2AgpQBHJsWK7IBwMdn/3+5zR/oDAJuyok
         Hlu31MaQoWM4E3TpGl8Jr3yebXMdUPUPt0CAF/AxlnITJSFZkKUwcQNvUkBceHmeK+eY
         6MmmThnrYWwss8jrRAG9JYbax2Xb43s9xCAhS6albs9FJDgkmqO3JrI8AfrCKIjUMBeZ
         6DQQ==
X-Gm-Message-State: AAQBX9eBG5aFmtjhkvJrNDee1+JA0KcdSDHL7iQGXPXaHWfsVz4bDefe
        VX91uGmiI8yJFaaVP23F42tUla8wcleHswbG
X-Google-Smtp-Source: AKy350aFwZwP6cAt/7NagV4VbY23m7cb5aEyRATuiGkqJ3dOIuKNVLE+KFWy2ZR0saxBMtxvl2JD7Q==
X-Received: by 2002:a17:903:1208:b0:1a2:55c9:1808 with SMTP id l8-20020a170903120800b001a255c91808mr10155613plh.17.1680076311272;
        Wed, 29 Mar 2023 00:51:51 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.204])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709029a8400b0019a773419a6sm22357976plp.170.2023.03.29.00.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:51:50 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] clk: hisilicon: Add helper functions for platform driver
Date:   Wed, 29 Mar 2023 15:50:50 +0800
Message-Id: <20230329075104.165176-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329075104.165176-1-mmyangfl@gmail.com>
References: <20230329075104.165176-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/reset.c |  47 ++++++++++-
 4 files changed, 248 insertions(+), 8 deletions(-)

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
index 93cee17db8b1..3464e3b4d708 100644
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
@@ -116,3 +120,42 @@ void hisi_reset_exit(struct hisi_reset_controller *rstc)
 	reset_controller_unregister(&rstc->rcdev);
 }
 EXPORT_SYMBOL_GPL(hisi_reset_exit);
+
+int hisi_crg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct hisi_crg_dev *crg;
+	int ret;
+
+	crg = devm_kmalloc(dev, sizeof(*crg), GFP_KERNEL);
+	if (!crg)
+		return -ENOMEM;
+
+	ret = hisi_clk_probe(pdev);
+	if (ret)
+		return ret;
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
+	hisi_clk_remove(pdev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_probe);
+
+int hisi_crg_remove(struct platform_device *pdev)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	hisi_reset_exit(crg->rstc);
+	hisi_clk_remove(pdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_crg_remove);
-- 
2.39.2

