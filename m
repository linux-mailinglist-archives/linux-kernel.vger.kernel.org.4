Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BC6A9A66
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCCPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCCPPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:15:48 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387BD1F4AB;
        Fri,  3 Mar 2023 07:15:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a7so1742117pfx.10;
        Fri, 03 Mar 2023 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giFfJwXNPJLMNED9GYpA4et3XffJ1cdsmrq2P3gr9F4=;
        b=KwqYBsWktWCPQfD45lhXLzcJcD3IQizu11gLk+QCTCCHOetHJopzX22oQL8CL3J5Z7
         n5jq+OEOuepE3M/Lo33QN2+cPKrL1vAARthBxSoYqrzL8AoCJWZ/4k3YqhVpWBYpE4Vf
         wofWl3P771ngFdiryBquX/af3RgvAeS+qlsA6T9BGxwG8MBwlVJ/usxT5pCI821R+SYH
         GmI+KTVTMe6GRJbxmC2uT3Rs0VtunPU+jgEJX+zI4WccYC/pWKLaZpUr2YLBG8/lMDrH
         jsSh5L/Jsq49rwW3fZ6Z/s444ayWEMsEkanPA2lPFXOC43mZ01LlHM0iAZxbtLQBfCFy
         VTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giFfJwXNPJLMNED9GYpA4et3XffJ1cdsmrq2P3gr9F4=;
        b=kTr/E3wz5DR+RijvwX68+45Ug3FjdU1X9U8xmikfztdD7qXFDxs7LedxvHGnl5cMtV
         IpzERUluqW05e5y1DrLjOFq9Wyv2uMrtHlXHeMU74nk9Cai48o88xYHbKc2qsVUVvHgr
         kOmOgFzb4v1NnPH/B1tJktCevGUrU/Oj28fu/ggICP0ZYtkHW2AnNmuKUDo6hjRAju5v
         kgxB46qT9IhqmGW3/e30StWFK8cyBdnjQZrFsOHosuYaglKkV2fS2ChwZbl0rnH4D7u8
         tdeuEc9jj99D4pHxZaGHkfahO+ZgIQieOR3VJAZXuPYk7IC1Wy3hNsH72fLTYC6Zw9kS
         dsKA==
X-Gm-Message-State: AO0yUKV6bazK9oRdpj0M5lGEGRCvSpLOCUH04VcnpZuUWpAbDV4w9wMA
        ZYKWe5d6sJULSzQ63TRzsVA=
X-Google-Smtp-Source: AK7set+/pDyTMpQl5g9S6TNhvVuTBZM8P8wmwB9xIwSvjPnB4aYzc0fr2aSs7TMZnNTOebjAu2x3Bw==
X-Received: by 2002:aa7:9464:0:b0:600:cc40:2587 with SMTP id t4-20020aa79464000000b00600cc402587mr2051066pfq.6.1677856545863;
        Fri, 03 Mar 2023 07:15:45 -0800 (PST)
Received: from y.ha.lan ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id p4-20020aa78604000000b005a8bdc18453sm1739721pfn.35.2023.03.03.07.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:15:45 -0800 (PST)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] clk: hisilicon: Extract common functions
Date:   Fri,  3 Mar 2023 23:14:10 +0800
Message-Id: <20230303151417.104321-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303151417.104321-1-mmyangfl@gmail.com>
References: <20230303151417.104321-1-mmyangfl@gmail.com>
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
index bdce43fbe..9c933172b 100644
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
 static const char *const mmc_mux_p[] = {
 		"100m", "50m", "25m", "200m", "150m" };
 static u32 mmc_mux_table[] = {0, 1, 2, 3, 6};
@@ -193,79 +311,24 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
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
@@ -273,10 +336,6 @@ static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
 	.unregister_clks = hi3798cv200_clk_unregister,
 };
 
-/* hi3798 sysctrl CRG */
-
-#define HI3798_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -286,45 +345,20 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
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
2.39.1

