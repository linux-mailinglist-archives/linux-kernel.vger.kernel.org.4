Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5D06DE2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDKRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDKRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:44:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA25276;
        Tue, 11 Apr 2023 10:44:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pm7-20020a17090b3c4700b00246f00dace2so838625pjb.2;
        Tue, 11 Apr 2023 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681235089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOql+bAuTzb4sNeAYIK71k2lMY+HYwNHUIwpssNISEY=;
        b=Bom/Wn8JatzU3tzR4sD0zSM3L9IG4vjiBVYejPZ90T4L4r8D8PPusN00RhiVChGnWi
         FlzRqtwGrmV+wNdYrHExM70gGyaljUiwxpoi66gBlCNo2JqmDuVpKnODXnjqUNjotWaD
         DTp38AU70bQHGVHXdX9FeCDWQ+NNpl4L6UNm5b4UeUrMZKLiY1DBwniYlt5mEFHfBSbQ
         0PKpXQZ5NRFJDOpxnmwezdUTmAmorMAVLSQkueiFCNuGnFIa0s/rpZ+O+x3hQRpt7cOW
         EPKNXPgTmlR9UiaJP/8bJ0AUlsR1v0pe4kF3Ar3ONF2dl1w3KVA7nfQc8MCsNWx5THmm
         dFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681235089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOql+bAuTzb4sNeAYIK71k2lMY+HYwNHUIwpssNISEY=;
        b=fxHkVm/o5JN7n98Xhx9tkSLYP0VOyIhV8LnEILDGWGIuoqiz+m74Vj4+cMeyfUT2jZ
         vxYgG4SUmAeSGM5BwOhSSOPfD5faU4UDhr9gW3KPzWQrUc0zWxCy/LZfBQiv8GYqrqma
         JI2zBd7vDCT/zPC1TU70U/FqDoDmRQa1UDaDj1QeSSAaDJuhZNC0L8OmeV6IjBGCUgDt
         hv7tI+aiGM7h0sn1MxX6oAp2+9HwFEsX7UPezZ+fJHpCyUJ2x3hBD+i3budYnmhvbIQu
         zRztcYlniViR6xBsvcuCFrf/B1P8snwCbZXycBTGIikGHCdaUpuLq/4ST1I5ANUGokjq
         Ob5A==
X-Gm-Message-State: AAQBX9cRF+/TeEleKkGHPWCcTHqU6Vl/0jx87QrPFcxGQM7RPy6hX1EW
        Dn5xuEVqTYqiPZ70MM9nJocuNnLlLeAIORI+
X-Google-Smtp-Source: AKy350ZeAQVRtDJ+jsMieE5cZRwH338iQ8wQx9QvGrbYA05HO0sHPyRdlqOduoV34OQ9n8GfKKSqgA==
X-Received: by 2002:a17:903:2111:b0:1a6:467c:fc0c with SMTP id o17-20020a170903211100b001a6467cfc0cmr5977813ple.3.1681235088809;
        Tue, 11 Apr 2023 10:44:48 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001a655738a42sm1900805pll.172.2023.04.11.10.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:44:48 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/13] clk: hisilicon: hi3519: Use helper functions
Date:   Wed, 12 Apr 2023 01:43:14 +0800
Message-Id: <20230411174329.424763-6-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/clk-hi3519.c | 128 ++++-------------------------
 1 file changed, 15 insertions(+), 113 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350cf0..eac66bde1361 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include "clk.h"
-#include "reset.h"
+#include "crg.h"
 
 #define HI3519_INNER_CLK_OFFSET	64
 #define HI3519_FIXED_24M	65
@@ -73,131 +73,33 @@ static const struct hisi_gate_clock hi3519_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xe4, 18, 0, },
 };
 
-static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3519_NR_CLKS);
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
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
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
-	of_clk_del_provider(pdev->dev.of_node);
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
-	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	hi3519_clk_unregister(pdev);
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
-- 
2.39.2

