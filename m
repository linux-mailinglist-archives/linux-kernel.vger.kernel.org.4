Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FA6AD5AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCGDZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCGDZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:25:19 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302E94A1F7;
        Mon,  6 Mar 2023 19:25:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h8so12704059plf.10;
        Mon, 06 Mar 2023 19:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678159510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRrcvVHttd2dYu+fn2CA/uo+2h7eomhmsrfs6CY1hTQ=;
        b=orGXK/6QfNsbcBNUnOxTTsRiFsJefVsA3Lm1SPSGgPN7BSW3Bg0xzvqxo8a5ocBe06
         xU9/wRn2Vo1N8Er1I9IgQThFEXPwr+8TYvdaluM/auOMxa+W+bTqR8Xc2OepFU9KwZzP
         GDhwLocW2QxFX0FFnr3rYib7l0yRnwmMuj2BNBVTj9FrS0ix5E6BI9vJZNOYj8SxaxvJ
         k2zLO/Tw42LjbQeShlnic3NTRuYHLRfCgDdsG2CszdW8ebGNypHWMoHzZk0FaQ4sZilD
         Ksjpr5SG0BEwflkFYb1jw5vFwlAK3wjafUe1cf6XmQBBsfm5CXRt9mgiDi2Irbbn73Gl
         rxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678159510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRrcvVHttd2dYu+fn2CA/uo+2h7eomhmsrfs6CY1hTQ=;
        b=H9gXPbjxmO2lmEePPgNXubzRvcVcS1XNNogaN1RR5lNFrIw6gqyEVeOFxzJDOGj92r
         ZfwZ07ic/LSg+iFt10oI/MH/lNsoPdnWLemFadgLVuldkm0zWYdIoxKEy5OitqgbWOA9
         IYXNtUMnxljDbxIjQe2OtG9nhfJFllnsgKqe5n21t7jN/YzFhSYTs/FMoPY4IY0Y2cyH
         wA1FU7feas2FOesp28ejkzhPyfEhfW30s2Mbbr7e45W9uGY+QY3eWqvGWWJh3k8aWJdU
         ZJF9SsSN0x1kJTIit2CUzHMQ5YNYgYkTik7xNseXM2qY9T8NuVsdSHvGt88xVAWti63o
         MaYw==
X-Gm-Message-State: AO0yUKXUpfwCYvr8tKF+5q9Ndr78GM26IpcacT7uwBEZqXv0ImQSorLT
        C6loTBBYgDjZGxXZ1ip8PGU=
X-Google-Smtp-Source: AK7set9hM8e1zUxZj/7izluLy54NdD+uBMVzyy3Aj7C4dnLCKzYw+giYlUJeSgTAVKsoLdZgRYWM8Q==
X-Received: by 2002:a17:902:f7c7:b0:19e:bad6:273f with SMTP id h7-20020a170902f7c700b0019ebad6273fmr6467459plw.27.1678159510211;
        Mon, 06 Mar 2023 19:25:10 -0800 (PST)
Received: from y.ha.lan ([2a09:bac5:21b4:1246::1d2:a])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b0019a997bca5csm7380022plh.121.2023.03.06.19.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 19:25:09 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] clk: hisilicon: Extract common functions
Date:   Tue,  7 Mar 2023 11:22:36 +0800
Message-Id: <20230307032243.14988-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307032243.14988-1-mmyangfl@gmail.com>
References: <20230307032243.14988-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be reused with other Hi3798 series SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c | 238 ++++++++++++++++-------------
 1 file changed, 136 insertions(+), 102 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 7e9507de2..2477c1208 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -59,6 +59,124 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
 
+struct hi3798_crg_clks {
+	const struct hisi_phase_clock *phase_clks;
+	int phase_clks_nums;
+	const struct hisi_mux_clock *mux_clks;
+	int mux_clks_nums;
+	const struct hisi_gate_clock *gate_clks;
+	int gate_clks_nums;
+};
+
+static struct hisi_clock_data *hi3798_clk_register(
+		struct platform_device *pdev, const struct hi3798_crg_clks *clks)
+{
+	struct hisi_clock_data *clk_data;
+	int ret;
+
+	clk_data = hisi_clk_alloc(pdev, HI3798_CRG_NR_CLKS);
+	if (!clk_data)
+		return ERR_PTR(-ENOMEM);
+
+	/* hisi_phase_clock is resource managed */
+	ret = hisi_clk_register_phase(&pdev->dev, clks->phase_clks,
+				      clks->phase_clks_nums, clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = hisi_clk_register_fixed_rate(hi3798_fixed_rate_clks,
+					   ARRAY_SIZE(hi3798_fixed_rate_clks),
+					   clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = hisi_clk_register_mux(clks->mux_clks, clks->mux_clks_nums, clk_data);
+	if (ret)
+		goto unregister_fixed_rate;
+
+	ret = hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
+	if (ret)
+		goto unregister_mux;
+
+	ret = of_clk_add_provider(pdev->dev.of_node,
+			of_clk_src_onecell_get, &clk_data->clk_data);
+	if (ret)
+		goto unregister_gate;
+
+	return clk_data;
+
+unregister_gate:
+	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
+unregister_mux:
+	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, clk_data);
+unregister_fixed_rate:
+	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
+				       ARRAY_SIZE(hi3798_fixed_rate_clks),
+				       clk_data);
+	return ERR_PTR(ret);
+}
+
+static void hi3798_clk_unregister(
+		struct platform_device *pdev, const struct hi3798_crg_clks *clks)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
+	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, crg->clk_data);
+	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
+				       ARRAY_SIZE(hi3798_fixed_rate_clks),
+				       crg->clk_data);
+}
+
+/* hi3798 sysctrl CRG */
+
+#define HI3798_SYSCTRL_NR_CLKS 16
+
+struct hi3798_sysctrl_clks {
+	const struct hisi_gate_clock *gate_clks;
+	int gate_clks_nums;
+};
+
+static struct hisi_clock_data *hi3798_sysctrl_clk_register(
+		struct platform_device *pdev, const struct hi3798_sysctrl_clks *clks)
+{
+	struct hisi_clock_data *clk_data;
+	int ret;
+
+	clk_data = hisi_clk_alloc(pdev, HI3798_SYSCTRL_NR_CLKS);
+	if (!clk_data)
+		return ERR_PTR(-ENOMEM);
+
+	ret = hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = of_clk_add_provider(pdev->dev.of_node,
+			of_clk_src_onecell_get, &clk_data->clk_data);
+	if (ret)
+		goto unregister_gate;
+
+	return clk_data;
+
+unregister_gate:
+	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
+	return ERR_PTR(ret);
+}
+
+static void hi3798_sysctrl_clk_unregister(
+		struct platform_device *pdev, const struct hi3798_sysctrl_clks *clks)
+{
+	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+
+	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
+}
+
+/* hi3798CV200 */
+
 static const char *const hi3798cv200_mmc_mux_p[] = {
 		"100m", "50m", "25m", "200m", "150m" };
 static u32 hi3798cv200_mmc_mux_table[] = {0, 1, 2, 3, 6};
@@ -194,79 +312,24 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
+static const struct hi3798_crg_clks hi3798cv200_crg_clks_data = {
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
+	.mux_clks = hi3798cv200_mux_clks,
+	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_gate_clks),
+};
+
 static struct hisi_clock_data *hi3798cv200_clk_register(
 				struct platform_device *pdev)
 {
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798_CRG_NR_CLKS);
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
-	ret = hisi_clk_register_fixed_rate(hi3798_fixed_rate_clks,
-				     ARRAY_SIZE(hi3798_fixed_rate_clks),
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
-	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-				ARRAY_SIZE(hi3798_fixed_rate_clks),
-				clk_data);
-	return ERR_PTR(ret);
+	return hi3798_clk_register(pdev, &hi3798cv200_crg_clks_data);
 }
 
 static void hi3798cv200_clk_unregister(struct platform_device *pdev)
 {
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
-	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-				ARRAY_SIZE(hi3798_fixed_rate_clks),
-				crg->clk_data);
+	hi3798_clk_unregister(pdev, &hi3798cv200_crg_clks_data);
 }
 
 static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
@@ -274,10 +337,6 @@ static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
 	.unregister_clks = hi3798cv200_clk_unregister,
 };
 
-/* hi3798 sysctrl CRG */
-
-#define HI3798_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -287,45 +346,20 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
+static const struct hi3798_sysctrl_clks hi3798cv200_sysctrl_clks_data = {
+	.gate_clks = hi3798cv200_sysctrl_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
+};
+
 static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
 					struct platform_device *pdev)
 {
-	struct hisi_clock_data *clk_data;
-	int ret;
-
-	clk_data = hisi_clk_alloc(pdev, HI3798_SYSCTRL_NR_CLKS);
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
+	return hi3798_sysctrl_clk_register(pdev, &hi3798cv200_sysctrl_clks_data);
 }
 
 static void hi3798cv200_sysctrl_clk_unregister(struct platform_device *pdev)
 {
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				crg->clk_data);
+	hi3798_sysctrl_clk_unregister(pdev, &hi3798cv200_sysctrl_clks_data);
 }
 
 static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
-- 
2.39.2

