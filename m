Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26F16C5104
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjCVQnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjCVQnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:43:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E186421A;
        Wed, 22 Mar 2023 09:42:51 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so9193642pjb.4;
        Wed, 22 Mar 2023 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFwtRuKKvS08EgPlfHprYiQ7DefepSwO2og+GHcp1kY=;
        b=Qp1AidbByuDDhxfgwth82wGocS1piUfn9aK7wlw10ZtnYafxvy+fOz1tlfF8hPgB3j
         ZwutZKbCDgXw30XYsJq793Dz7pdrISLNj0e7pV6Tal93IMbR7PKpWYkWuc1B9tPgZTRo
         85n9kSiA+dkCqQKG0N0q5s2nJumLnsMhnjE8d2/tL9QsWP91ELvqiRiMGLbLRFtZLnLm
         SvO78dXJn/44RZ7H8JeiOtLNVpwPKZAd7OEUMlHtcsg3AbaDm9ruWC+9d5fCa+3Jb5LA
         SPnpOxw6CSPhEo589jkBDfXDC4FnGelc5rMz+mXcHPJ/oW+Mr++LpdNlVbjFsJ/eGDLs
         egZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFwtRuKKvS08EgPlfHprYiQ7DefepSwO2og+GHcp1kY=;
        b=YyhF+fZpSFB2NqTqZxtvMUuMuLO8Pl6ftwWncqWvGUxtgI8RM2QadWdM34FYAFUeU2
         WDY/ws0MHZHLditSa6mEiapeWy7oZs2zsRgqqbHJfmsPJH09Ua0aI9L66Em8h0r+brOb
         eYP2tiDOsyI69mTsGJmjHwz0FHdSUyN1SuUHKiPGPMsjc/0HQhKhqsAk2U7PlZFTxPVL
         y7SKScUvYtLwwjrtk/rSvHIEwRwuVAL4CPQ0TRTu1PMz0Jjl5gM/lhTM6/cRso/M/1Wz
         ZXnjaeO9ybFqRJRhsm6/wT91O9eQ8vYl4YLycWN1su2iXEjNbkYYpajcVWM5P0W/CGFQ
         12mQ==
X-Gm-Message-State: AO0yUKUOQ5JOxlaf9471ZlJh24uYHo5wFS/ynEwRE1eFRsFRtlPNR9+9
        0V3sZ6OwKgVpiyZOmt52eeX6v84IpcaPfltQ+Kk=
X-Google-Smtp-Source: AK7set+ojjwxhelE4d4L78Viq1ZZsNb8i86Wz4U0YMtzoRJRY9PBS11tAwTct6sosGlgorspkhBUlA==
X-Received: by 2002:a05:6a20:b712:b0:da:267a:d740 with SMTP id fg18-20020a056a20b71200b000da267ad740mr211929pzb.14.1679503370735;
        Wed, 22 Mar 2023 09:42:50 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:42:50 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 4/9] clk: hisilicon: Add helper functions for platform driver
Date:   Thu, 23 Mar 2023 00:41:52 +0800
Message-Id: <20230322164201.2454771-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322164201.2454771-1-mmyangfl@gmail.com>
References: <20230322164201.2454771-1-mmyangfl@gmail.com>
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

This patch is part of devm APIs migration.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi6220.c |   6 +-
 drivers/clk/hisilicon/clk.c        | 132 ++++++++++++++++++++++++++++-
 drivers/clk/hisilicon/clk.h        |  75 +++++++++++++---
 drivers/clk/hisilicon/crg.h        |   5 ++
 drivers/clk/hisilicon/reset.c      |  65 +++++++++++++-
 5 files changed, 264 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index e7cdf72d4..d9de83a19 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -191,7 +191,7 @@ static void __init hi6220_clk_sys_init(struct device_node *np)
 	hisi_clk_register_mux(hi6220_mux_clks_sys,
 			ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
 
-	hi6220_clk_register_divider(hi6220_div_clks_sys,
+	hi6220_clk_register_divider(NULL, hi6220_div_clks_sys,
 			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
 }
 CLK_OF_DECLARE_DRIVER(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
@@ -248,7 +248,7 @@ static void __init hi6220_clk_media_init(struct device_node *np)
 	hisi_clk_register_mux(hi6220_mux_clks_media,
 				ARRAY_SIZE(hi6220_mux_clks_media), clk_data);
 
-	hi6220_clk_register_divider(hi6220_div_clks_media,
+	hi6220_clk_register_divider(NULL, hi6220_div_clks_media,
 				ARRAY_SIZE(hi6220_div_clks_media), clk_data);
 }
 CLK_OF_DECLARE_DRIVER(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
@@ -279,7 +279,7 @@ static void __init hi6220_clk_power_init(struct device_node *np)
 	hisi_clk_register_gate(hi6220_gate_clks_power,
 				ARRAY_SIZE(hi6220_gate_clks_power), clk_data);
 
-	hi6220_clk_register_divider(hi6220_div_clks_power,
+	hi6220_clk_register_divider(NULL, hi6220_div_clks_power,
 				ARRAY_SIZE(hi6220_div_clks_power), clk_data);
 }
 CLK_OF_DECLARE(hi6220_clk_power, "hisilicon,hi6220-pmctrl", hi6220_clk_power_init);
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index a949be5fa..439fd154b 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -58,6 +58,13 @@ EXPORT_SYMBOL_GPL(hisi_clk_init);
 
 void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
 {
+	if (data->clks) {
+		if (data->clks->fixed_rate_clks_num)
+			hisi_clk_unregister_fixed_rate(data);
+		if (data->clks->fixed_factor_clks_num)
+			hisi_clk_unregister_fixed_factor(data);
+	}
+
 	of_clk_del_provider(np);
 	kfree(data->clk_data.clks);
 	kfree(data);
@@ -260,7 +267,7 @@ int hisi_clk_register_gate(const struct hisi_gate_clock *clks,
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_gate);
 
-void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
+int hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
 				       int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
@@ -286,11 +293,14 @@ void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
 
 		data->clk_data.clks[clks[i].id] = clk;
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_gate_sep);
 
-void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
-					int nums, struct hisi_clock_data *data)
+int hi6220_clk_register_divider(struct device *dev,
+				const struct hi6220_divider_clock *clks,
+				int nums, struct hisi_clock_data *data)
 {
 	struct clk *clk;
 	void __iomem *base = data->base;
@@ -308,7 +318,7 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(clk);
 		}
 
 		if (clks[i].alias)
@@ -316,4 +326,118 @@ void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
 
 		data->clk_data.clks[clks[i].id] = clk;
 	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hi6220_clk_register_divider);
+
+int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+		      struct hisi_clock_data *data)
+{
+	int ret;
+
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
 }
+EXPORT_SYMBOL_GPL(hisi_clk_remove);
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 30b6d4405..daa85acda 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -17,10 +17,22 @@
 #include <linux/spinlock.h>
 
 struct platform_device;
+struct hisi_clocks;
 
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
 	struct clk_onecell_data	clk_data;
 	void __iomem		*base;
+	const struct hisi_clocks	*clks;
 };
 
 struct hisi_fixed_rate_clock {
@@ -103,6 +115,38 @@ struct hisi_gate_clock {
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
@@ -118,6 +162,7 @@ int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
 				int, struct hisi_clock_data *);
+
 int hisi_clk_register_mux(const struct hisi_mux_clock *, int,
 				struct hisi_clock_data *);
 struct clk *clk_register_hisi_phase(struct device *dev,
@@ -130,12 +175,22 @@ int hisi_clk_register_divider(const struct hisi_divider_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_gate(const struct hisi_gate_clock *,
 				int, struct hisi_clock_data *);
-void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
-				int, struct hisi_clock_data *);
-void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
-				int, struct hisi_clock_data *);
+int hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
+			       int nums, struct hisi_clock_data *data);
+int hi6220_clk_register_divider(struct device *dev,
+				const struct hi6220_divider_clock *clks,
+				int nums, struct hisi_clock_data *data);
+
+int hisi_clk_register(struct device *dev, const struct hisi_clocks *clks,
+		      struct hisi_clock_data *data);
+
+/* helper functions for platform driver */
+
+int hisi_clk_early_init(struct device_node *np, const struct hisi_clocks *clks);
+int hisi_clk_probe(struct platform_device *pdev);
+int hisi_clk_remove(struct platform_device *pdev);
 
-#define hisi_clk_unregister(type) \
+#define hisi_clk_unregister_fn(type) \
 static inline \
 void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
 				int nums, struct hisi_clock_data *data) \
@@ -149,10 +204,10 @@ void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
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
index 803f6ba6d..d9544f1f2 100644
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
index 93cee17db..471b5670e 100644
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

