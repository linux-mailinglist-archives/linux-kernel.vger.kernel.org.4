Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E96C5108
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjCVQn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCVQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:43:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9977EF6;
        Wed, 22 Mar 2023 09:43:02 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id ja10so19820496plb.5;
        Wed, 22 Mar 2023 09:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mL//PtvWoHvljIYOZ4hItJdnWZY01+XfQ1PtShbmcpw=;
        b=CkaAuZ1alL76W0H0MaHZ/jQ5jEgc26R4QhRVRDuUfnF3Pq6OK3Y0y1rpvILiN0l/z6
         NQ1C8AJzGSW+NXsoe+ZmtSmgaS8dU1B5jdGNu1dkNQhxARe0ln/YstWE3SVY0HUgDLad
         dIhzvC/JlCL4nwaRRXVnblgNPdkrPkha9ntL5w7c+lg0nDDLZ3zanRtmeC196ga9JJCv
         ce7oDHk9ABAtW9mHlOYBmQuSdJhgV4WZWmzSiiErJn5D503f6UU9msHr9d6ULoaZfVf7
         y8XNVnex5ohwYinin7+KOGt6K8AbT+N9DDuuNX5sytciskpux/N8D9viJJWIk6U6VmIs
         fBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mL//PtvWoHvljIYOZ4hItJdnWZY01+XfQ1PtShbmcpw=;
        b=MLbXrVtkSa2RQZUiIc5S/HWcsTXIoQRh8ASPF2+P772Cu7irRHthvPCDasS0KDKaRd
         Zm1b/sXQbqTREkIR3qh3A6AGsKe+9VWAk5yINxc++62daqAgPZq98ebWudveyuKH2k2p
         PpxqtunutMVBfJwNDk+dfebFGsjavYCsM0FdeMazD2phpEXzoJnSpgmzdX+5dkcDLUBT
         CL60Sh7j8rJpM/+EZ6YgZZVhyFFFPUTfAdLYynnriv4oYfe+me6XiB8o0781jsDzq32/
         aZOv6uNZ+B2a5KWSCR7ZX8NcVyYEqocsSTo49KS4dpAnXK8Q8aNK1E137yYLY0xj1vAo
         Dcaw==
X-Gm-Message-State: AO0yUKUWEZn8FHNOuZphyP/X9rIW4kPG/BkP3vkYzZQqIBlDnZia8P5W
        6rFaIHlCPp5PCJPHuks/CL1d/l95JI6G3N4YA8U=
X-Google-Smtp-Source: AK7set8TQIRyHmbCJ4kyUKAoyNLrcUvjxglrLuSz7ZrGsGJap3+aDA31ALQIdnDhLhIWqHu0iAPVOg==
X-Received: by 2002:a05:6a20:8493:b0:da:3903:f5e7 with SMTP id u19-20020a056a20849300b000da3903f5e7mr283386pzd.0.1679503380808;
        Wed, 22 Mar 2023 09:43:00 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:43:00 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 5/9] clk: hisilicon: Use helper functions
Date:   Thu, 23 Mar 2023 00:41:53 +0800
Message-Id: <20230322164201.2454771-6-mmyangfl@gmail.com>
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

Remove redundant codes.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3519.c      | 132 ++----------
 drivers/clk/hisilicon/clk-hi3559a.c     | 221 ++++----------------
 drivers/clk/hisilicon/clk-hi3660.c      | 204 ++++++------------
 drivers/clk/hisilicon/clk-hi3670.c      | 267 ++++++++----------------
 drivers/clk/hisilicon/crg-hi3516cv300.c | 169 ++-------------
 drivers/clk/hisilicon/crg-hi3798.c      | 219 ++-----------------
 drivers/clk/hisilicon/crg.h             |   6 -
 drivers/clk/hisilicon/reset.c           |   1 -
 8 files changed, 250 insertions(+), 969 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index 556c89037..199d1b8c3 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -6,11 +6,13 @@
  */
 
 #include <dt-bindings/clock/hi3519-clock.h>
-#include <linux/clk-provider.h>
+
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/of_device.h>
+
 #include "clk.h"
-#include "reset.h"
+#include "crg.h"
 
 #define HI3519_INNER_CLK_OFFSET	64
 #define HI3519_FIXED_24M	65
@@ -73,129 +75,33 @@ static const struct hisi_gate_clock hi3519_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
 };
 
-static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
-				     ARRAY_SIZE(hi3519_fixed_rate_clks),
-				     clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
-				clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	return clk_data;
-
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3519_fixed_rate_clks,
-				ARRAY_SIZE(hi3519_fixed_rate_clks),
-				clk_data);
-
-unregister_mux:
-	hisi_clk_unregister_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				clk_data);
-unregister_gate:
-	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3519_clk_unregister(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_gate(hi3519_gate_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_mux(hi3519_mux_clks,
-				ARRAY_SIZE(hi3519_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3519_fixed_rate_clks,
-				ARRAY_SIZE(hi3519_fixed_rate_clks),
-				crg->clk_data);
-}
-
-static int hi3519_clk_probe(struct platform_device *pdev)
-{
-	struct hi3519_crg_data *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = hi3519_clk_register(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static int hi3519_clk_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	hi3519_clk_unregister(pdev);
-	hisi_clk_free(np, crg->clk_data);
-	return 0;
-}
-
+static const struct hisi_clocks hi3519_crg_clks = {
+	.nr = HI3519_NR_CLKS,
+	.fixed_rate_clks = hi3519_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3519_fixed_rate_clks),
+	.mux_clks = hi3519_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3519_mux_clks),
+	.gate_clks = hi3519_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3519_gate_clks),
+};
 
 static const struct of_device_id hi3519_clk_match_table[] = {
-	{ .compatible = "hisilicon,hi3519-crg" },
+	{ .compatible = "hisilicon,hi3519-crg",
+	  .data = &hi3519_crg_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3519_clk_match_table);
 
 static struct platform_driver hi3519_clk_driver = {
-	.probe          = hi3519_clk_probe,
-	.remove		= hi3519_clk_remove,
+	.probe = hisi_crg_probe,
+	.remove = hisi_crg_remove,
 	.driver         = {
 		.name   = "hi3519-clk",
 		.of_match_table = hi3519_clk_match_table,
 	},
 };
 
-static int __init hi3519_clk_init(void)
-{
-	return platform_driver_register(&hi3519_clk_driver);
-}
-core_initcall(hi3519_clk_init);
-
-static void __exit hi3519_clk_exit(void)
-{
-	platform_driver_unregister(&hi3519_clk_driver);
-}
-module_exit(hi3519_clk_exit);
+module_platform_driver(hi3519_clk_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3519 Clock Driver");
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index c3dd018f8..d641b2a75 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include <dt-bindings/clock/hi3559av100-clock.h>
 
@@ -452,9 +451,11 @@ static const struct clk_ops hisi_clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 };
 
-static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
-			   int nums, struct hisi_clock_data *data, struct device *dev)
+static int
+hisi_clk_register_pll(struct device *dev, const void *clocks,
+		      int nums, struct hisi_clock_data *data)
 {
+	const struct hi3559av100_pll_clock *clks = clocks;
 	void __iomem *base = data->base;
 	struct hi3559av100_clk_pll *p_clk = NULL;
 	struct clk *clk = NULL;
@@ -464,7 +465,7 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
 
 	if (!p_clk)
-		return;
+		return -ENOMEM;
 
 	for (i = 0; i < nums; i++) {
 		init.name = clks[i].name;
@@ -494,73 +495,27 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 			devm_kfree(dev, p_clk);
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(clk);
 		}
 
 		data->clk_data.clks[clks[i].id] = clk;
 		p_clk++;
 	}
-}
-
-static struct hisi_clock_data *hi3559av100_clk_register(
-	struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_init(np, HI3559AV100_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-					   ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	hisi_clk_register_pll(hi3559av100_pll_clks,
-			      ARRAY_SIZE(hi3559av100_pll_clks), clk_data, &pdev->dev);
-
-	ret = hisi_clk_register_mux(hi3559av100_mux_clks_crg,
-				    ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3559av100_gate_clks,
-				     ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	return ERR_PTR(ret);
-}
 
-static void hi3559av100_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), crg->clk_data);
+	return 0;
 }
 
-static const struct hisi_crg_funcs hi3559av100_crg_funcs = {
-	.register_clks = hi3559av100_clk_register,
-	.unregister_clks = hi3559av100_clk_unregister,
+static const struct hisi_clocks hi3559av100_clks = {
+	.nr = HI3559AV100_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3559av100_fixed_rate_clks_crg,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg),
+	.mux_clks = hi3559av100_mux_clks_crg,
+	.mux_clks_num = ARRAY_SIZE(hi3559av100_mux_clks_crg),
+	.gate_clks = hi3559av100_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3559av100_gate_clks),
+	.customized_clks = hi3559av100_pll_clks,
+	.customized_clks_num = ARRAY_SIZE(hi3559av100_pll_clks),
+	.clk_register_customized = hisi_clk_register_pll,
 };
 
 static struct hisi_fixed_rate_clock hi3559av100_shub_fixed_rate_clks[] = {
@@ -668,7 +623,7 @@ static struct hisi_gate_clock hi3559av100_shub_gate_clks[] = {
 	},
 };
 
-static int hi3559av100_shub_default_clk_set(void)
+static int hi3559av100_shub_default_clk_set(struct device *dev, struct hisi_clock_data *data)
 {
 	void __iomem *crg_base;
 	unsigned int val;
@@ -691,147 +646,41 @@ static int hi3559av100_shub_default_clk_set(void)
 	return 0;
 }
 
-static struct hisi_clock_data *hi3559av100_shub_clk_register(
-	struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data = NULL;
-	int ret;
-
-	hi3559av100_shub_default_clk_set();
-
-	clk_data = hisi_clk_init(np, HI3559AV100_SHUB_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-					   ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3559av100_shub_mux_clks,
-				    ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_divider(hi3559av100_shub_div_clks,
-					ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	ret = hisi_clk_register_gate(hi3559av100_shub_gate_clks,
-				     ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-	if (ret)
-		goto unregister_factor;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-unregister_factor:
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), crg->clk_data);
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3559av100_shub_crg_funcs = {
-	.register_clks = hi3559av100_shub_clk_register,
-	.unregister_clks = hi3559av100_shub_clk_unregister,
+static const struct hisi_clocks hi3559av100_shub_clks = {
+	.nr = HI3559AV100_SHUB_NR_CLKS,
+	.prologue = hi3559av100_shub_default_clk_set,
+	.fixed_rate_clks = hi3559av100_shub_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks),
+	.mux_clks = hi3559av100_shub_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3559av100_shub_mux_clks),
+	.divider_clks = hi3559av100_shub_div_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3559av100_shub_div_clks),
+	.gate_clks = hi3559av100_shub_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3559av100_shub_gate_clks),
 };
 
 static const struct of_device_id hi3559av100_crg_match_table[] = {
 	{
 		.compatible = "hisilicon,hi3559av100-clock",
-		.data = &hi3559av100_crg_funcs
+		.data = &hi3559av100_clks
 	},
 	{
 		.compatible = "hisilicon,hi3559av100-shub-clock",
-		.data = &hi3559av100_shub_crg_funcs
+		.data = &hi3559av100_shub_clks
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3559av100_crg_match_table);
 
-static int hi3559av100_crg_probe(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->funcs = of_device_get_match_data(&pdev->dev);
-	if (!crg->funcs)
-		return -ENOENT;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = crg->funcs->register_clks(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static int hi3559av100_crg_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-	hisi_clk_free(np, crg->clk_data);
-	return 0;
-}
-
 static struct platform_driver hi3559av100_crg_driver = {
-	.probe		= hi3559av100_crg_probe,
-	.remove		= hi3559av100_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove = hisi_crg_remove,
 	.driver		= {
 		.name	= "hi3559av100-clock",
 		.of_match_table = hi3559av100_crg_match_table,
 	},
 };
 
-static int __init hi3559av100_crg_init(void)
-{
-	return platform_driver_register(&hi3559av100_crg_driver);
-}
-core_initcall(hi3559av100_crg_init);
-
-static void __exit hi3559av100_crg_exit(void)
-{
-	platform_driver_unregister(&hi3559av100_crg_driver);
-}
-module_exit(hi3559av100_crg_exit);
-
+module_platform_driver(hi3559av100_crg_driver);
 
 MODULE_DESCRIPTION("HiSilicon Hi3559AV100 CRG Driver");
diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 41f61726a..9a9dab284 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -5,9 +5,11 @@
  */
 
 #include <dt-bindings/clock/hi3660-clock.h>
-#include <linux/clk-provider.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
@@ -469,169 +471,89 @@ static const struct hisi_gate_clock hi3660_iomcu_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x90, 0, 0, },
 };
 
-static struct hisi_clock_data *clk_crgctrl_data;
-
-static void hi3660_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_iomcu_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
-				   clk_data);
-}
-
-static void hi3660_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3660_pmu_gate_clks,
-			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_iomcu_clks = {
+	.nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+	.gate_sep_clks = hi3660_iomcu_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+};
 
-static void hi3660_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
+static const struct hisi_clocks hi3660_clk_pmuctrl_clks = {
+	.nr = ARRAY_SIZE(hi3660_pmu_gate_clks),
+	.gate_clks = hi3660_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pmu_gate_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
-}
+static const struct hisi_clocks hi3660_clk_pctrl_clks = {
+	.nr = ARRAY_SIZE(hi3660_pctrl_gate_clks),
+	.gate_clks = hi3660_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_pctrl_gate_clks),
+};
 
-static void hi3660_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_sctrl_divider_clks);
+static const struct hisi_clocks hi3660_clk_sctrl_clks = {
+	.nr = ARRAY_SIZE(hi3660_sctrl_mux_clks) +
+		ARRAY_SIZE(hi3660_sctrl_divider_clks) +
+		ARRAY_SIZE(hi3660_sctrl_gate_clks) +
+		ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
+	.mux_clks = hi3660_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_sctrl_mux_clks),
+	.divider_clks = hi3660_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_sctrl_divider_clks),
+	.gate_clks = hi3660_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_clks),
+	.gate_sep_clks = hi3660_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
+};
 
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3660_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_sctrl_gate_clks), clk_data);
-	hisi_clk_register_gate_sep(hi3660_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_mux(hi3660_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_sctrl_mux_clks), clk_data);
-	hisi_clk_register_divider(hi3660_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
-				  clk_data);
-}
+static const struct hisi_clocks hi3660_clk_crgctrl_clks = {
+	.nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
+		ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
+		ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
+		ARRAY_SIZE(hi3660_crgctrl_divider_clks) +
+		ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
+		ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
+	.fixed_rate_clks = hi3660_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3660_fixed_rate_clks),
+	.fixed_factor_clks = hi3660_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
+	.mux_clks = hi3660_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3660_crgctrl_mux_clks),
+	.divider_clks = hi3660_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3660_crgctrl_divider_clks),
+	.gate_clks = hi3660_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_clks),
+	.gate_sep_clks = hi3660_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
+};
 
 static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 {
-	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3660_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3660_crgctrl_divider_clks);
-	int i;
-
-	clk_crgctrl_data = hisi_clk_init(np, nr);
-	if (!clk_crgctrl_data)
-		return;
-
-	for (i = 0; i < nr; i++)
-		clk_crgctrl_data->clk_data.clks[i] = ERR_PTR(-EPROBE_DEFER);
-
-	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
-				     ARRAY_SIZE(hi3660_fixed_rate_clks),
-				     clk_crgctrl_data);
+	hisi_clk_early_init(np, &hi3660_clk_crgctrl_clks);
 }
 CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
 		      hi3660_clk_crgctrl_early_init);
 
-static void hi3660_clk_crgctrl_init(struct device_node *np)
-{
-	struct clk **clks;
-	int i;
-
-	if (!clk_crgctrl_data)
-		hi3660_clk_crgctrl_early_init(np);
-
-	/* clk_crgctrl_data initialization failed */
-	if (!clk_crgctrl_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
-				   clk_crgctrl_data);
-	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
-			       clk_crgctrl_data);
-	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
-			      clk_crgctrl_data);
-	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
-				       clk_crgctrl_data);
-	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
-				  clk_crgctrl_data);
-
-	clks = clk_crgctrl_data->clk_data.clks;
-	for (i = 0; i < clk_crgctrl_data->clk_data.clk_num; i++) {
-		if (IS_ERR(clks[i]) && PTR_ERR(clks[i]) != -EPROBE_DEFER)
-			pr_err("Failed to register crgctrl clock[%d] err=%ld\n",
-			       i, PTR_ERR(clks[i]));
-	}
-}
-
 static const struct of_device_id hi3660_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3660-crgctrl",
-	  .data = hi3660_clk_crgctrl_init },
+	  .data = &hi3660_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pctrl",
-	  .data = hi3660_clk_pctrl_init },
+	  .data = &hi3660_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3660-pmuctrl",
-	  .data = hi3660_clk_pmuctrl_init },
+	  .data = &hi3660_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3660-sctrl",
-	  .data = hi3660_clk_sctrl_init },
+	  .data = &hi3660_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3660-iomcu",
-	  .data = hi3660_clk_iomcu_init },
+	  .data = &hi3660_clk_iomcu_clks },
 	{ }
 };
-
-static int hi3660_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
+MODULE_DEVICE_TABLE(of, hi3660_clk_match_table);
 
 static struct platform_driver hi3660_clk_driver = {
-	.probe          = hi3660_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3660-clk",
 		.of_match_table = hi3660_clk_match_table,
 	},
 };
 
-static int __init hi3660_clk_init(void)
-{
-	return platform_driver_register(&hi3660_clk_driver);
-}
-core_initcall(hi3660_clk_init);
+module_platform_driver(hi3660_clk_driver);
diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index 4d05a7168..548b85ebd 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -8,9 +8,11 @@
  */
 
 #include <dt-bindings/clock/hi3670-clock.h>
-#include <linux/clk-provider.h>
+
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3670_fixed_rate_clks[] = {
@@ -822,195 +824,110 @@ static const struct hisi_gate_clock hi3670_media2_gate_sep_clks[] = {
 	  CLK_SET_RATE_PARENT, 0x00, 2, 0, },
 };
 
-static void hi3670_clk_crgctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_fixed_rate_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_gate_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_mux_clks) +
-		 ARRAY_SIZE(hi3670_crg_fixed_factor_clks) +
-		 ARRAY_SIZE(hi3670_crgctrl_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_fixed_rate(hi3670_fixed_rate_clks,
-				     ARRAY_SIZE(hi3670_fixed_rate_clks),
-				     clk_data);
-	hisi_clk_register_gate_sep(hi3670_crgctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_crgctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_crgctrl_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_crgctrl_mux_clks,
-			      ARRAY_SIZE(hi3670_crgctrl_mux_clks),
-			      clk_data);
-	hisi_clk_register_fixed_factor(hi3670_crg_fixed_factor_clks,
-				       ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
-				       clk_data);
-	hisi_clk_register_divider(hi3670_crgctrl_divider_clks,
-				  ARRAY_SIZE(hi3670_crgctrl_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_pctrl_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-	hisi_clk_register_gate(hi3670_pctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_pctrl_gate_clks), clk_data);
-}
-
-static void hi3670_clk_pmuctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_pmu_gate_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3670_pmu_gate_clks,
-			       ARRAY_SIZE(hi3670_pmu_gate_clks), clk_data);
-}
-
-static void hi3670_clk_sctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_gate_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_mux_clks) +
-		 ARRAY_SIZE(hi3670_sctrl_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_sctrl_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_sctrl_gate_clks,
-			       ARRAY_SIZE(hi3670_sctrl_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_sctrl_mux_clks,
-			      ARRAY_SIZE(hi3670_sctrl_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3670_sctrl_divider_clks,
-				  ARRAY_SIZE(hi3670_sctrl_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_iomcu_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks) +
-			ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate(hi3670_iomcu_gate_sep_clks,
-			       ARRAY_SIZE(hi3670_iomcu_gate_sep_clks), clk_data);
-
-	hisi_clk_register_fixed_factor(hi3670_iomcu_fixed_factor_clks,
-				       ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
-				       clk_data);
-}
-
-static void hi3670_clk_media1_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_media1_gate_sep_clks) +
-		 ARRAY_SIZE(hi3670_media1_gate_clks) +
-		 ARRAY_SIZE(hi3670_media1_mux_clks) +
-		 ARRAY_SIZE(hi3670_media1_divider_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_media1_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_media1_gate_sep_clks),
-				   clk_data);
-	hisi_clk_register_gate(hi3670_media1_gate_clks,
-			       ARRAY_SIZE(hi3670_media1_gate_clks),
-			       clk_data);
-	hisi_clk_register_mux(hi3670_media1_mux_clks,
-			      ARRAY_SIZE(hi3670_media1_mux_clks),
-			      clk_data);
-	hisi_clk_register_divider(hi3670_media1_divider_clks,
-				  ARRAY_SIZE(hi3670_media1_divider_clks),
-				  clk_data);
-}
-
-static void hi3670_clk_media2_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-
-	int nr = ARRAY_SIZE(hi3670_media2_gate_sep_clks);
-
-	clk_data = hisi_clk_init(np, nr);
-	if (!clk_data)
-		return;
-
-	hisi_clk_register_gate_sep(hi3670_media2_gate_sep_clks,
-				   ARRAY_SIZE(hi3670_media2_gate_sep_clks),
-				   clk_data);
-}
+static const struct hisi_clocks hi3670_clk_crgctrl_clks = {
+	.nr = ARRAY_SIZE(hi3670_fixed_rate_clks) +
+		ARRAY_SIZE(hi3670_crg_fixed_factor_clks) +
+		ARRAY_SIZE(hi3670_crgctrl_mux_clks) +
+		ARRAY_SIZE(hi3670_crgctrl_divider_clks) +
+		ARRAY_SIZE(hi3670_crgctrl_gate_clks) +
+		ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
+	.fixed_rate_clks = hi3670_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3670_fixed_rate_clks),
+	.fixed_factor_clks = hi3670_crg_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
+	.mux_clks = hi3670_crgctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_crgctrl_mux_clks),
+	.divider_clks = hi3670_crgctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_crgctrl_divider_clks),
+	.gate_clks = hi3670_crgctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_crgctrl_gate_clks),
+	.gate_sep_clks = hi3670_crgctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_pctrl_clks = {
+	.nr = ARRAY_SIZE(hi3670_pctrl_gate_clks),
+	.gate_clks = hi3670_pctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_pctrl_gate_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_pmuctrl_clks = {
+	.nr = ARRAY_SIZE(hi3670_pmu_gate_clks),
+	.gate_clks = hi3670_pmu_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_pmu_gate_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_sctrl_clks = {
+	.nr = ARRAY_SIZE(hi3670_sctrl_mux_clks) +
+		ARRAY_SIZE(hi3670_sctrl_divider_clks) +
+		ARRAY_SIZE(hi3670_sctrl_gate_clks) +
+		ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
+	.mux_clks = hi3670_sctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_sctrl_mux_clks),
+	.divider_clks = hi3670_sctrl_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_sctrl_divider_clks),
+	.gate_clks = hi3670_sctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_sctrl_gate_clks),
+	.gate_sep_clks = hi3670_sctrl_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_iomcu_clks = {
+	.nr = ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks) +
+		ARRAY_SIZE(hi3670_iomcu_gate_sep_clks),
+	.fixed_factor_clks = hi3670_iomcu_fixed_factor_clks,
+	.fixed_factor_clks_num = ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
+	.gate_clks = hi3670_iomcu_gate_sep_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_media1_clks = {
+	.nr = ARRAY_SIZE(hi3670_media1_mux_clks) +
+		ARRAY_SIZE(hi3670_media1_divider_clks) +
+		ARRAY_SIZE(hi3670_media1_gate_clks) +
+		ARRAY_SIZE(hi3670_media1_gate_sep_clks),
+	.mux_clks = hi3670_media1_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3670_media1_mux_clks),
+	.divider_clks = hi3670_media1_divider_clks,
+	.divider_clks_num = ARRAY_SIZE(hi3670_media1_divider_clks),
+	.gate_clks = hi3670_media1_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3670_media1_gate_clks),
+	.gate_sep_clks = hi3670_media1_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_media1_gate_sep_clks),
+};
+
+static const struct hisi_clocks hi3670_clk_media2_clks = {
+	.nr = ARRAY_SIZE(hi3670_media2_gate_sep_clks),
+	.gate_sep_clks = hi3670_media2_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3670_media2_gate_sep_clks),
+};
 
 static const struct of_device_id hi3670_clk_match_table[] = {
 	{ .compatible = "hisilicon,hi3670-crgctrl",
-	  .data = hi3670_clk_crgctrl_init },
+	  .data = &hi3670_clk_crgctrl_clks },
 	{ .compatible = "hisilicon,hi3670-pctrl",
-	  .data = hi3670_clk_pctrl_init },
+	  .data = &hi3670_clk_pctrl_clks },
 	{ .compatible = "hisilicon,hi3670-pmuctrl",
-	  .data = hi3670_clk_pmuctrl_init },
+	  .data = &hi3670_clk_pmuctrl_clks },
 	{ .compatible = "hisilicon,hi3670-sctrl",
-	  .data = hi3670_clk_sctrl_init },
+	  .data = &hi3670_clk_sctrl_clks },
 	{ .compatible = "hisilicon,hi3670-iomcu",
-	  .data = hi3670_clk_iomcu_init },
+	  .data = &hi3670_clk_iomcu_clks },
 	{ .compatible = "hisilicon,hi3670-media1-crg",
-	  .data = hi3670_clk_media1_init },
+	  .data = &hi3670_clk_media1_clks },
 	{ .compatible = "hisilicon,hi3670-media2-crg",
-	  .data = hi3670_clk_media2_init },
+	  .data = &hi3670_clk_media2_clks },
 	{ }
 };
-
-static int hi3670_clk_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = pdev->dev.of_node;
-	void (*init_func)(struct device_node *np);
-
-	init_func = of_device_get_match_data(dev);
-	if (!init_func)
-		return -ENODEV;
-
-	init_func(np);
-
-	return 0;
-}
+MODULE_DEVICE_TABLE(of, hi3670_clk_match_table);
 
 static struct platform_driver hi3670_clk_driver = {
-	.probe          = hi3670_clk_probe,
+	.probe = hisi_clk_probe,
+	.remove = hisi_clk_remove,
 	.driver         = {
 		.name   = "hi3670-clk",
 		.of_match_table = hi3670_clk_match_table,
 	},
 };
 
-static int __init hi3670_clk_init(void)
-{
-	return platform_driver_register(&hi3670_clk_driver);
-}
-core_initcall(hi3670_clk_init);
+module_platform_driver(hi3670_clk_driver);
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 6c756680d..0805852ec 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -6,13 +6,13 @@
  */
 
 #include <dt-bindings/clock/hi3516cv300-clock.h>
-#include <linux/clk-provider.h>
+
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
+
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3516CV300 core CRG */
 #define HI3516CV300_INNER_CLK_OFFSET	64
@@ -126,62 +126,14 @@ static const struct hisi_gate_clock hi3516cv300_gate_clks[] = {
 	{ HI3516CV300_USB2_PHY_CLK, "clk_usb2_phy", NULL, 0, 0xb8, 7, 0, },
 };
 
-static struct hisi_clock_data *hi3516cv300_clk_register(
-		struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_init(np, HI3516CV300_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_fixed_rate(hi3516cv300_fixed_rate_clks,
-			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3516cv300_mux_clks,
-			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3516cv300_gate_clks,
-			ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
-				ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
-			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3516cv300_fixed_rate_clks,
-			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3516cv300_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
-			ARRAY_SIZE(hi3516cv300_gate_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
-			ARRAY_SIZE(hi3516cv300_mux_clks), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3516cv300_fixed_rate_clks,
-			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3516cv300_crg_funcs = {
-	.register_clks = hi3516cv300_clk_register,
-	.unregister_clks = hi3516cv300_clk_unregister,
+static const struct hisi_clocks hi3516cv300_crg_clks = {
+	.nr = HI3516CV300_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3516cv300_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3516cv300_fixed_rate_clks),
+	.mux_clks = hi3516cv300_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3516cv300_mux_clks),
+	.gate_clks = hi3516cv300_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3516cv300_gate_clks),
 };
 
 /* hi3516CV300 sysctrl CRG */
@@ -195,116 +147,35 @@ static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
 		CLK_SET_RATE_PARENT, 0x0, 23, 1, 0, wdt_mux_table, },
 };
 
-static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
-		struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_init(np, HI3516CV300_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return clk_data;
-
-unregister_mux:
-	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3516cv300_sysctrl_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
-			crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3516cv300_sysctrl_funcs = {
-	.register_clks = hi3516cv300_sysctrl_clk_register,
-	.unregister_clks = hi3516cv300_sysctrl_clk_unregister,
+static const struct hisi_clocks hi3516cv300_sysctrl_clks = {
+	.nr = HI3516CV300_SYSCTRL_NR_CLKS,
+	.mux_clks = hi3516cv300_sysctrl_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
 };
 
 static const struct of_device_id hi3516cv300_crg_match_table[] = {
 	{
 		.compatible = "hisilicon,hi3516cv300-crg",
-		.data = &hi3516cv300_crg_funcs
+		.data = &hi3516cv300_crg_clks,
 	},
 	{
 		.compatible = "hisilicon,hi3516cv300-sysctrl",
-		.data = &hi3516cv300_sysctrl_funcs
+		.data = &hi3516cv300_sysctrl_clks,
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3516cv300_crg_match_table);
 
-static int hi3516cv300_crg_probe(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->funcs = of_device_get_match_data(&pdev->dev);
-	if (!crg->funcs)
-		return -ENOENT;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = crg->funcs->register_clks(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static int hi3516cv300_crg_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-	hisi_clk_free(np, crg->clk_data);
-	return 0;
-}
-
 static struct platform_driver hi3516cv300_crg_driver = {
-	.probe          = hi3516cv300_crg_probe,
-	.remove		= hi3516cv300_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove = hisi_crg_remove,
 	.driver         = {
 		.name   = "hi3516cv300-crg",
 		.of_match_table = hi3516cv300_crg_match_table,
 	},
 };
 
-static int __init hi3516cv300_crg_init(void)
-{
-	return platform_driver_register(&hi3516cv300_crg_driver);
-}
-core_initcall(hi3516cv300_crg_init);
-
-static void __exit hi3516cv300_crg_exit(void)
-{
-	platform_driver_unregister(&hi3516cv300_crg_driver);
-}
-module_exit(hi3516cv300_crg_exit);
+module_platform_driver(hi3516cv300_crg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3516CV300 CRG Driver");
diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index fad1a2fba..f329886c4 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -6,13 +6,13 @@
  */
 
 #include <dt-bindings/clock/histb-clock.h>
-#include <linux/clk-provider.h>
+
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
+
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3798 core CRG */
 #define HI3798_INNER_CLK_OFFSET		64
@@ -41,6 +41,8 @@
 
 #define HI3798_CRG_NR_CLKS			128
 
+#define HI3798_SYSCTRL_NR_CLKS 16
+
 static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
@@ -59,109 +61,6 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
 
-struct hi3798_clks {
-	const struct hisi_gate_clock *gate_clks;
-	int gate_clks_nums;
-	const struct hisi_mux_clock *mux_clks;
-	int mux_clks_nums;
-	const struct hisi_phase_clock *phase_clks;
-	int phase_clks_nums;
-};
-
-static struct hisi_clock_data *
-hi3798_clk_register(struct platform_device *pdev,
-		    const struct hi3798_clks *clks)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_init(np, HI3798_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	/* hisi_phase_clock is resource managed */
-	ret = hisi_clk_register_phase(&pdev->dev, clks->phase_clks,
-				      clks->phase_clks_nums, clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_fixed_rate(hi3798_fixed_rate_clks,
-					   ARRAY_SIZE(hi3798_fixed_rate_clks),
-					   clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(clks->mux_clks, clks->mux_clks_nums, clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
-	if (ret)
-		goto unregister_mux;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-				       ARRAY_SIZE(hi3798_fixed_rate_clks),
-				       clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798_clk_unregister(struct platform_device *pdev,
-				  const struct hi3798_clks *clks)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
-	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-				       ARRAY_SIZE(hi3798_fixed_rate_clks),
-				       crg->clk_data);
-}
-
-/* hi3798 sysctrl CRG */
-
-#define HI3798_SYSCTRL_NR_CLKS 16
-
-static struct hisi_clock_data *
-hi3798_sysctrl_clk_register(struct platform_device *pdev,
-			    const struct hi3798_clks *clks)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_init(np, HI3798_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798_sysctrl_clk_unregister(struct platform_device *pdev,
-					  const struct hi3798_clks *clks)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
-}
-
 /* hi3798CV200 */
 
 static const char *const hi3798cv200_mmc_mux_p[] = {
@@ -299,29 +198,16 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
-static const struct hi3798_clks hi3798cv200_crg_clks = {
-	.gate_clks = hi3798cv200_gate_clks,
-	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_gate_clks),
+static const struct hisi_clocks hi3798cv200_crg_clks = {
+	.nr = HI3798_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3798_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3798_fixed_rate_clks),
 	.mux_clks = hi3798cv200_mux_clks,
-	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.mux_clks_num = ARRAY_SIZE(hi3798cv200_mux_clks),
 	.phase_clks = hi3798cv200_phase_clks,
-	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
-};
-
-static struct hisi_clock_data *
-hi3798cv200_clk_register(struct platform_device *pdev)
-{
-	return hi3798_clk_register(pdev, &hi3798cv200_crg_clks);
-}
-
-static void hi3798cv200_clk_unregister(struct platform_device *pdev)
-{
-	hi3798_clk_unregister(pdev, &hi3798cv200_crg_clks);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
-	.register_clks = hi3798cv200_clk_register,
-	.unregister_clks = hi3798cv200_clk_unregister,
+	.phase_clks_num = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_gate_clks),
 };
 
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
@@ -333,94 +219,31 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
-static const struct hi3798_clks hi3798cv200_sysctrl_clks = {
+static const struct hisi_clocks hi3798cv200_sysctrl_clks = {
+	.nr = HI3798_SYSCTRL_NR_CLKS,
 	.gate_clks = hi3798cv200_sysctrl_gate_clks,
-	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-};
-
-static struct hisi_clock_data *
-hi3798cv200_sysctrl_clk_register(struct platform_device *pdev)
-{
-	return hi3798_sysctrl_clk_register(pdev, &hi3798cv200_sysctrl_clks);
-}
-
-static void hi3798cv200_sysctrl_clk_unregister(struct platform_device *pdev)
-{
-	hi3798_sysctrl_clk_unregister(pdev, &hi3798cv200_sysctrl_clks);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
-	.register_clks = hi3798cv200_sysctrl_clk_register,
-	.unregister_clks = hi3798cv200_sysctrl_clk_unregister,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
 };
 
 static const struct of_device_id hi3798_crg_match_table[] = {
 	{ .compatible = "hisilicon,hi3798cv200-crg",
-		.data = &hi3798cv200_crg_funcs },
+		.data = &hi3798cv200_crg_clks },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
-		.data = &hi3798cv200_sysctrl_funcs },
+		.data = &hi3798cv200_sysctrl_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3798_crg_match_table);
 
-static int hi3798_crg_probe(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg;
-
-	crg = devm_kmalloc(&pdev->dev, sizeof(*crg), GFP_KERNEL);
-	if (!crg)
-		return -ENOMEM;
-
-	crg->funcs = of_device_get_match_data(&pdev->dev);
-	if (!crg->funcs)
-		return -ENOENT;
-
-	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
-
-	crg->clk_data = crg->funcs->register_clks(pdev);
-	if (IS_ERR(crg->clk_data)) {
-		hisi_reset_exit(crg->rstc);
-		return PTR_ERR(crg->clk_data);
-	}
-
-	platform_set_drvdata(pdev, crg);
-	return 0;
-}
-
-static int hi3798_crg_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-	hisi_clk_free(np, crg->clk_data);
-	return 0;
-}
-
 static struct platform_driver hi3798_crg_driver = {
-	.probe = hi3798_crg_probe,
-	.remove = hi3798_crg_remove,
+	.probe = hisi_crg_probe,
+	.remove = hisi_crg_remove,
 	.driver = {
 		.name = "hi3798-crg",
 		.of_match_table = hi3798_crg_match_table,
 	},
 };
 
-static int __init hi3798_crg_init(void)
-{
-	return platform_driver_register(&hi3798_crg_driver);
-}
-core_initcall(hi3798_crg_init);
-
-static void __exit hi3798_crg_exit(void)
-{
-	platform_driver_unregister(&hi3798_crg_driver);
-}
-module_exit(hi3798_crg_exit);
+module_platform_driver(hi3798_crg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3798 CRG Driver");
diff --git a/drivers/clk/hisilicon/crg.h b/drivers/clk/hisilicon/crg.h
index d9544f1f2..49142759d 100644
--- a/drivers/clk/hisilicon/crg.h
+++ b/drivers/clk/hisilicon/crg.h
@@ -11,15 +11,9 @@
 struct hisi_clock_data;
 struct hisi_reset_controller;
 
-struct hisi_crg_funcs {
-	struct hisi_clock_data*	(*register_clks)(struct platform_device *pdev);
-	void (*unregister_clks)(struct platform_device *pdev);
-};
-
 struct hisi_crg_dev {
 	struct hisi_clock_data *clk_data;
 	struct hisi_reset_controller *rstc;
-	const struct hisi_crg_funcs *funcs;
 };
 
 /* helper functions for platform driver */
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 471b5670e..843e7b2c9 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -172,7 +172,6 @@ int hisi_crg_remove(struct platform_device *pdev)
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
 	hisi_clk_free(np, crg->clk_data);
 	return 0;
 }
-- 
2.39.2

