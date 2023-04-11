Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF196DE2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDKRoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjDKRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:44:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D351161B4;
        Tue, 11 Apr 2023 10:44:09 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mn5-20020a17090b188500b00246eddf34f6so1047655pjb.0;
        Tue, 11 Apr 2023 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qylkhsUJrqz1P65jb9ADOri9NgFbnTH2A9zHw9WW0qY=;
        b=BtS2zLxcnFTzj47ZGUs/iDCtCJ2ZYIZ/JK28crf7NtUAA8JfA5QeyfI46DSsF3ZBYi
         G9nr39KkcLsErpPJA3toBQIBArjyfKR0WQeumWa3p2bbwkK9fBVGowTA9p7ui6oDyQ9c
         mRoUSVAZzsXIcHB2Yg+kj8wcxpwJqy56wmVHzKY80UVhI4u1E+NOy7D/Endif1aZ11+9
         8LbXyVZKnTx9e0wZ6KdqQSTuZ0ZSAksLeqf6tvf++w6VlUGuffy8+RyV8phAimERr4YG
         IgductCA0DiYQuqIK/MaGXT8j5inrnplS6ts1wHW4rnucBV+QzMlxcERdoH4qjoVICRg
         z7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qylkhsUJrqz1P65jb9ADOri9NgFbnTH2A9zHw9WW0qY=;
        b=YSf8HDY9pD9mKPoSN0ldusTD9KiNOFkgJYfaSIWAoNb+0K8t0V5/S1BoOhXA8AI5bA
         5oMHH5PG+dyiLPynVUw4tGFzY0VmU9Jgdnnn8qhXS7UdDxy7aussq5RFXjgZi3Ry+rUv
         iHLwdu1HGquvZb7oLLtZE1Ztwi0Qd/KeWGRxT7+zPzom/0HxfkUMK4NCFPaHNdjM2Uy6
         A4IPpB+eZVtMdaywwdxuU7/ehVK/zMkGQSGIjU8RsBW+EitgE2k/3g21TPYGS/LM5TcA
         Nqt9k1QtIYnYdO7FwQg4z1o362y11JoL+ehOatNGTDF7XE9+/OVu7j1dTdZ6HKL4AsQb
         UNZw==
X-Gm-Message-State: AAQBX9eulBTLasiVdyBW7nOLkfYhEcOCuiTAwqzVAFYkToO6F90i9lJy
        4Hf4m5xrGg445x3IfgwfX6f12fGjpaF/z9IFT9o=
X-Google-Smtp-Source: AKy350ZnHRCB/+AcOpJfblNebGwkcDdp0cnZ3GIUu3Onyme4a64WUy3U8uhSjLJeQtNlxcDvn0WE4Q==
X-Received: by 2002:a17:903:404c:b0:19a:bbd0:c5cc with SMTP id n12-20020a170903404c00b0019abbd0c5ccmr2878356pla.60.1681235049166;
        Tue, 11 Apr 2023 10:44:09 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:44:08 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/13] clk: hisilicon: hi3516cv300: Use helper functions
Date:   Wed, 12 Apr 2023 01:43:11 +0800
Message-Id: <20230411174329.424763-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411174329.424763-1-mmyangfl@gmail.com>
References: <20230411174329.424763-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3516cv300.c | 172 +++---------------------
 1 file changed, 17 insertions(+), 155 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 5d4e61c7a429..992b9c16ce7e 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3516CV300 core CRG */
 #define HI3516CV300_INNER_CLK_OFFSET	64
@@ -126,67 +125,14 @@ static const struct hisi_gate_clock hi3516cv300_gate_clks[] = {
 	{ HI3516CV300_USB2_PHY_CLK, "clk_usb2_phy", NULL, 0, 0xb8, 7, 0, },
 };
 
-static struct hisi_clock_data *hi3516cv300_clk_register(
-		struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3516CV300_CRG_NR_CLKS);
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
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
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
-	of_clk_del_provider(pdev->dev.of_node);
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
@@ -200,119 +146,35 @@ static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
 		CLK_SET_RATE_PARENT, 0x0, 23, 1, 0, wdt_mux_table, },
 };
 
-static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
-		struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3516CV300_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_mux;
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
-	of_clk_del_provider(pdev->dev.of_node);
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
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
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
-- 
2.39.2

