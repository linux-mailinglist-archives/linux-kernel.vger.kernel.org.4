Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C26DC60F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDJLIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDJLIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:08:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650FF5252;
        Mon, 10 Apr 2023 04:08:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id v9so9169168pjk.0;
        Mon, 10 Apr 2023 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qylkhsUJrqz1P65jb9ADOri9NgFbnTH2A9zHw9WW0qY=;
        b=IEu/n8H7hxAYx7i2FmQBmYLYSnagatlbmV9kCWZ5ubRDIdgyU1qKL/S4HO9Ypv1eU1
         HhRFWlfYbCWG0xSx929G3gAPNArRJaCdcYykzmgKlOi64G0CiiVl+8TcX07/zG65J6Lp
         SA42xwaxEorNnx4BSdi/zyMGY2+iVsb1j+EGugSyBjUF9RNnaqfuawSCytnWnrSNTa0v
         k7dFCCt7/SuGjVoXuJ06NDo/vUfUvHm0T3QamsAl3IeN4Q1STcVLm/3JavQSmEybwsBY
         w4pfqJkECYBP1rRBl8MYsFlMNvmgTUx8zl7dXAF7a97jCQ7iwhI4PgvtvbVCT11/cvuj
         htCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qylkhsUJrqz1P65jb9ADOri9NgFbnTH2A9zHw9WW0qY=;
        b=SNn6yg2qT7KpzdBbRn+7b6zM0mOs+qhNyg2nzl5eSRghbrfHw/4yG7SMGHgzRoILPe
         oPu8G6kv/Y5sZjPPfISkJ/bEwxqWbQm+voIqcD2zWTTiCZIKi3NKO76ZgIz+IdXTr/Vn
         yfauFf8+CQy7ALSuqCbiAkMwR2eYC6ItcXxiIQiUUUW8HZpUrwR1CvYxIjhN8prdq2cw
         J7NdKLK4UFBK4n0oD/I7ru1QJ+wfBGKkeP6AUZZkmIzQkVtWp/5KBOqC7bdgiGFez87F
         fKvDvVf5tsYXm1TSvBUEO3Ta81BjX9TKhDLq60s1r5TjLAo20gc8gEJNNQ7TXyJBds9G
         0ucw==
X-Gm-Message-State: AAQBX9dxLh5n9nDspQ0Blpp7RCAFfRiA1K8BH1BFbYq8Erg9iDGpKV8R
        kH9JoiFqCtnbjVBgWqXyvL1Jwy5MAlmITT0pxlk=
X-Google-Smtp-Source: AKy350ZiFMuTkYs2o3Q44/+BhF4/ewM63JryP3peL+dqUV1hgEIqKx8NOIShSkW+//gQlZLTH+X7Pg==
X-Received: by 2002:a17:90a:5e4d:b0:246:9439:3cb1 with SMTP id u13-20020a17090a5e4d00b0024694393cb1mr5545228pji.21.1681124904699;
        Mon, 10 Apr 2023 04:08:24 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:08:24 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/14] clk: hisilicon: hi3516cv300: Use helper functions
Date:   Mon, 10 Apr 2023 19:07:15 +0800
Message-Id: <20230410110733.192151-4-mmyangfl@gmail.com>
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

