Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABB6DC612
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDJLIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjDJLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:08:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5D5247;
        Mon, 10 Apr 2023 04:08:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso4137028pjb.2;
        Mon, 10 Apr 2023 04:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681124918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWyQ5Pjpw8KX3nyQXwtTt+inCkDHJTaq2DC+SwS9XK8=;
        b=F41/cBOahuvvd/fGLSqfquMTyeimw4QF5oHc/80R6SmoXpfT+0pd91MKbBlbwsoNWc
         KkBaNhY7D4ealZ60ylLnrq2d9zb8QLcTC0AsJMnQsg0f314V/LXMYXFiq5x9r5XIeXvU
         s7c1Kz8XzQ1a3KFTQ+iWs2saJyxYVdPNcj2Qf//A8tDQaVhbqes77N13zrVFOFDm9XXm
         o6UnkMu22p6A3OK4MdZKyKoc7qlM9kVys8crZ2+P5KjcxDKiJZI+U3jE/njEaCzxFguc
         0u7BCEIifdkyBcgiaQ5dtjwinzDvjFJpK9cfL87l3S8XQv2C3oPjKDRw/z1Idnk0+Jlt
         BKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWyQ5Pjpw8KX3nyQXwtTt+inCkDHJTaq2DC+SwS9XK8=;
        b=zK62GL264/VUazV7reA+OZIYd6IaAoPB1+za0cwtOc1Kln3nvLC6xkGhlc+ZV6SPXp
         slclQOr+ulxuO03HNH9qUMf76/E4CAeQnO3oOs0aTc2ozL20X+Qs8WytqXIWBjkSFn+H
         YS2TMfmquqiGdPMfC1aEo0S7B0v5tUI7KgE/8hBgesZ0HZKWtM13FelMwxWbgHhXckTh
         G7gIZaXP1EGOySVfoE6I2tfn2VnRMuTjnnj60WScT8S9UNMpxvleUEcBupPhvue02BEE
         IrSIe41amTTCSJJ+jlhTT5P7Xvaa6sdcI3GVuFXhgAe+tt0za9Hqn1QnDYlBK4vClE2n
         nX+A==
X-Gm-Message-State: AAQBX9dJpwe85inzQOhkDV5duzmDpmNoM1lSXG+D51C46CLeJJiGE4BY
        n35aMM/aHecbuJ/Wvy+UpRfi7bBSVkXTMp/l+YA=
X-Google-Smtp-Source: AKy350ZjedE0pTqWlY1xmfGnUJwZco50DYXXIkNFana9PDeo6gcjnDFVsCWgTHfGFt8vu5X2FR3I7w==
X-Received: by 2002:a17:903:1c3:b0:19e:bc01:610e with SMTP id e3-20020a17090301c300b0019ebc01610emr14511838plh.33.1681124917790;
        Mon, 10 Apr 2023 04:08:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.201])
        by smtp.gmail.com with ESMTPSA id r5-20020a170902be0500b001a076568da9sm7464728pls.216.2023.04.10.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 04:08:37 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/14] clk: hisilicon: hi3798cv200: Use helper functions
Date:   Mon, 10 Apr 2023 19:07:16 +0800
Message-Id: <20230410110733.192151-5-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3798cv200.c | 201 +++---------------------
 1 file changed, 22 insertions(+), 179 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index 08a19ba776e6..cf0944774ae9 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 #include "clk.h"
 #include "crg.h"
-#include "reset.h"
 
 /* hi3798CV200 core CRG */
 #define HI3798CV200_INNER_CLK_OFFSET		64
@@ -41,6 +40,7 @@
 
 #define HI3798CV200_CRG_NR_CLKS			128
 
+#define HI3798CV200_SYSCTRL_NR_CLKS		16
 static const struct hisi_fixed_rate_clock hi3798cv200_fixed_rate_clks[] = {
 	{ HISTB_OSC_CLK, "clk_osc", NULL, 0, 24000000, },
 	{ HISTB_APB_CLK, "clk_apb", NULL, 0, 100000000, },
@@ -193,90 +193,18 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
-static struct hisi_clock_data *hi3798cv200_clk_register(
-				struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_CRG_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	/* hisi_phase_clock is resource managed */
-	ret = hisi_clk_register_phase(&pdev->dev,
-				hi3798cv200_phase_clks,
-				ARRAY_SIZE(hi3798cv200_phase_clks),
-				clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_fixed_rate(hi3798cv200_fixed_rate_clks,
-				     ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				     clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = hisi_clk_register_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				clk_data);
-	if (ret)
-		goto unregister_fixed_rate;
-
-	ret = hisi_clk_register_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
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
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798cv200_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_gate_clks,
-				ARRAY_SIZE(hi3798cv200_gate_clks),
-				crg->clk_data);
-	hisi_clk_unregister_mux(hi3798cv200_mux_clks,
-				ARRAY_SIZE(hi3798cv200_mux_clks),
-				crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3798cv200_fixed_rate_clks,
-				ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
-				crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
-	.register_clks = hi3798cv200_clk_register,
-	.unregister_clks = hi3798cv200_clk_unregister,
+static const struct hisi_clocks hi3798cv200_crg_clks = {
+	.nr = HI3798CV200_CRG_NR_CLKS,
+	.fixed_rate_clks = hi3798cv200_fixed_rate_clks,
+	.fixed_rate_clks_num = ARRAY_SIZE(hi3798cv200_fixed_rate_clks),
+	.mux_clks = hi3798cv200_mux_clks,
+	.mux_clks_num = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_num = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_gate_clks),
 };
 
-/* hi3798CV200 sysctrl CRG */
-
-#define HI3798CV200_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -286,116 +214,31 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
-static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
-					struct platform_device *pdev)
-{
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798CV200_SYSCTRL_NR_CLKS);
-	if (!clk_data)
-		return ERR_PTR(-ENOMEM);
-
-	ret = hisi_clk_register_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	if (ret)
-		return ERR_PTR(ret);
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
-	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
-}
-
-static void hi3798cv200_sysctrl_clk_unregister(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				crg->clk_data);
-}
-
-static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
-	.register_clks = hi3798cv200_sysctrl_clk_register,
-	.unregister_clks = hi3798cv200_sysctrl_clk_unregister,
+static const struct hisi_clocks hi3798cv200_sysctrl_clks = {
+	.nr = HI3798CV200_SYSCTRL_NR_CLKS,
+	.gate_clks = hi3798cv200_sysctrl_gate_clks,
+	.gate_clks_num = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
 };
 
 static const struct of_device_id hi3798cv200_crg_match_table[] = {
 	{ .compatible = "hisilicon,hi3798cv200-crg",
-		.data = &hi3798cv200_crg_funcs },
+		.data = &hi3798cv200_crg_clks },
 	{ .compatible = "hisilicon,hi3798cv200-sysctrl",
-		.data = &hi3798cv200_sysctrl_funcs },
+		.data = &hi3798cv200_sysctrl_clks },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, hi3798cv200_crg_match_table);
 
-static int hi3798cv200_crg_probe(struct platform_device *pdev)
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
-static int hi3798cv200_crg_remove(struct platform_device *pdev)
-{
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	hisi_reset_exit(crg->rstc);
-	crg->funcs->unregister_clks(pdev);
-	return 0;
-}
-
 static struct platform_driver hi3798cv200_crg_driver = {
-	.probe          = hi3798cv200_crg_probe,
-	.remove		= hi3798cv200_crg_remove,
-	.driver         = {
-		.name   = "hi3798cv200-crg",
+	.probe = hisi_crg_probe,
+	.remove = hisi_crg_remove,
+	.driver = {
+		.name = "hi3798cv200-crg",
 		.of_match_table = hi3798cv200_crg_match_table,
 	},
 };
 
-static int __init hi3798cv200_crg_init(void)
-{
-	return platform_driver_register(&hi3798cv200_crg_driver);
-}
-core_initcall(hi3798cv200_crg_init);
-
-static void __exit hi3798cv200_crg_exit(void)
-{
-	platform_driver_unregister(&hi3798cv200_crg_driver);
-}
-module_exit(hi3798cv200_crg_exit);
+module_platform_driver(hi3798cv200_crg_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("HiSilicon Hi3798CV200 CRG Driver");
-- 
2.39.2

