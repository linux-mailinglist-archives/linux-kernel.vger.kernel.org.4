Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703556DC61B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDJLJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDJLJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:09:51 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D86590;
        Mon, 10 Apr 2023 04:09:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id 20so6193403plk.10;
        Mon, 10 Apr 2023 04:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4LZi4v8BP7uhMO1g5FIUEMzxer6nFR6wrcwU4BODNA=;
        b=V/Mo8lp6DYQY4Vh7rXY3tciBhihRppXEisbu+VKKF1wQSRGQF9zFU1cxLZM0Q8NsL6
         JzNKBCc8V0j70NHd41yuHmsDbQZ60LE0/JU4JlJbVUBwAJjcy5ZZecDod63ZJY6x/Wyx
         uE1iLCdhFgRbMNCeMbIEvyrOtlhxzgyG03Q3b33k9tACuAaGyJaFa4RVPbh+XT4S8j8S
         KybgfCKmR9ykxMNzNUSN7Txl3bbWU8O/NnIYacb1UScRunv41s0vG2yrT2SIQ2BwWsP2
         1Gw9+FBdZQGFomX+w0JeKL7Foek3t3SeTW3DsvOiWhuhsQ92ePUrC7AjJl3tQC2u6zS3
         oNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4LZi4v8BP7uhMO1g5FIUEMzxer6nFR6wrcwU4BODNA=;
        b=SG5pF+yZdv3C+Ltypnx2jvDvrTIyQ/6gVY1YEZ46Jx9KjnQdv0tndgU3ZIohS+G3i4
         1Lskx68RBvnHC0r+rz9dTAWEztBc2l2G24jb2n7tFN3Pcth/AQKx/nfFUaHjJhM2yXkp
         6oCLPgI8sfx4zJ0ewBshKqtoYC6YIG47byq1GGxYhMeDp4un4KtWfxD+0prydyVLuigX
         t32lZD4+47WHPPhDip5PrkVGjE2WYXnIg5t+exQHfFxGRDLP3yU2YsQxdu1i5X2v5twX
         n4uzAPvodSo/WnGl97zgcizeFMCpr6aMqSVecw2Ihx47+f8XdKY7osjolWmG9qI+1XeH
         2rxw==
X-Gm-Message-State: AAQBX9dEEvYK8YdNFJqb+A9Z7J04TDyl6rlBEcl354jysBqIAB5Acbli
        d3GsYWgic59cbWrLLc6BiIxBgYjzUkqV/UGx/jY=
X-Google-Smtp-Source: AKy350YeEAajgRFgXDP+vGmIDat5Aqd4mNxnM+2puxtQZ2BLaCIkLwhoZ/G3rk5iU4Del4QWFtl1dQ==
X-Received: by 2002:a17:902:e74f:b0:1a6:3799:ec36 with SMTP id p15-20020a170902e74f00b001a63799ec36mr4148786plf.33.1681124970057;
        Mon, 10 Apr 2023 04:09:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:09:29 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] clk: hisilicon: hi3660: Convert into module
Date:   Mon, 10 Apr 2023 19:07:20 +0800
Message-Id: <20230410110733.192151-9-mmyangfl@gmail.com>
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

Use common helper functions and register clks with a single of_device_id
data.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3660.c | 192 ++++++++---------------------
 1 file changed, 53 insertions(+), 139 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 41f61726ab19..ce911b35bf68 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -5,9 +5,13 @@
  */
 
 #include <dt-bindings/clock/hi3660-clock.h>
+
 #include <linux/clk-provider.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+
 #include "clk.h"
 
 static const struct hisi_fixed_rate_clock hi3660_fixed_rate_clks[] = {
@@ -469,169 +473,79 @@ static const struct hisi_gate_clock hi3660_iomcu_gate_sep_clks[] = {
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
+	.gate_sep_clks = hi3660_iomcu_gate_sep_clks,
+	.gate_sep_clks_num = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
+};
 
-static void hi3660_clk_pctrl_init(struct device_node *np)
-{
-	struct hisi_clock_data *clk_data;
-	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
+static const struct hisi_clocks hi3660_clk_pmuctrl_clks = {
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
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("HiSilicon Hi3660 Clock Driver");
-- 
2.39.2

