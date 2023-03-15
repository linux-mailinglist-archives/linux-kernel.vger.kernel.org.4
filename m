Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B242C6BBEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjCOVTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjCOVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:19:13 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67645B409;
        Wed, 15 Mar 2023 14:18:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l14so1634470pfc.11;
        Wed, 15 Mar 2023 14:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678915108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkthGZ8hQmB63+z0P86zjPOZhKQbhtrGN77pfJie3Dc=;
        b=Uqw1OdDon8R7nt8R3YbuCX9D6lQLDYLF8E5VdtfTZBqeuN9deIdBkWIB8XD3w3hpIK
         B5SGU7puKaNrb9hwaTjmhTrCrqOFTlpN9GaGmKgZgu/DmFHfCfLXBaYc1wXgcDEHCdss
         dDxePc/1jjS3dHeaVmTW4+swoo0Vx8AaDgeLcfvr69L9HkWVTUtQJnSTopalRPLRKQPo
         tZzBMYQjG3ZmgV/BuYjeTTW432jQ+VG5ITCtK5o5M/T0Enje+xxPSHYT8kUScVVeNJiu
         fZFaHkXpoixaf+7liPoposwgt4kEHq+QGyl+C5N3ulexA1Bh3KzgaajVpH7yLlX5uqhS
         lc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkthGZ8hQmB63+z0P86zjPOZhKQbhtrGN77pfJie3Dc=;
        b=raWcM44J4q9IwCMOZSvJ86THSJSF4Yz1V0di3L3dv/BTuBs/u51PEWNjoH+yZ2Pn27
         WWvfjiV48pWNRiCh9KCd+OzieY6u8yx8beca0DO0gk94yu4zuJ9lilGkB7yw0z3Z1Wia
         dExCHvKPPvf1R+CQJUcGu2DG2J2u+WnxDYn7uc3askwWUyJQkjlXbNETp3Ls/wxHEXuz
         qoZpr69vcGA4Kv3xbMF3gPpuAy8mCGDleSKlo4nwScerwc5WHpZd/KcUZvUrKC+gw7EQ
         TTkgfq8Z2wB/1Ui2MqVgFzBOJWy6vDtSoaTraPeHkiKyk6KiCRG/dfk6KiVWPP3/QWnB
         NCoQ==
X-Gm-Message-State: AO0yUKUA7EZn9nKiaWJzsSjAbunNbQ8NGwuOraElAc6iujII8a+nyrHp
        YUCvZoAdNbc8Ag9OrLGF6pM=
X-Google-Smtp-Source: AK7set/TrV+6hliN6CQDVj/ljn2+ruF5vFyzZbvcSX7rU1S0ibmyYNFvErhIVnx3e5nGWmEe8yBPnQ==
X-Received: by 2002:a62:8457:0:b0:625:eacf:caf9 with SMTP id k84-20020a628457000000b00625eacfcaf9mr36542pfd.7.1678915107897;
        Wed, 15 Mar 2023 14:18:27 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b005897f5436c0sm3981695pfo.118.2023.03.15.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:18:27 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] clk: hisilicon: Extract common functions
Date:   Thu, 16 Mar 2023 05:16:21 +0800
Message-Id: <20230315211628.963205-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315211628.963205-1-mmyangfl@gmail.com>
References: <20230315211628.963205-1-mmyangfl@gmail.com>
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
 drivers/clk/hisilicon/crg-hi3798.c | 233 ++++++++++++++++-------------
 1 file changed, 131 insertions(+), 102 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 7e9507de2..2f8f14e73 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -59,6 +59,119 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
 	{ HI3798_FIXED_250M, "250m", NULL, 0, 250000000, },
 };
 
+struct hi3798_clks {
+	const struct hisi_gate_clock *gate_clks;
+	int gate_clks_nums;
+	const struct hisi_mux_clock *mux_clks;
+	int mux_clks_nums;
+	const struct hisi_phase_clock *phase_clks;
+	int phase_clks_nums;
+};
+
+static struct hisi_clock_data *hi3798_clk_register(
+		struct platform_device *pdev, const struct hi3798_clks *clks)
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
+		struct platform_device *pdev, const struct hi3798_clks *clks)
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
+static struct hisi_clock_data *hi3798_sysctrl_clk_register(
+		struct platform_device *pdev, const struct hi3798_clks *clks)
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
+		struct platform_device *pdev, const struct hi3798_clks *clks)
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
@@ -194,79 +307,24 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
+static const struct hi3798_clks hi3798cv200_crg_clks = {
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_gate_clks),
+	.mux_clks = hi3798cv200_mux_clks,
+	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
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
+	return hi3798_clk_register(pdev, &hi3798cv200_crg_clks);
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
+	hi3798_clk_unregister(pdev, &hi3798cv200_crg_clks);
 }
 
 static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
@@ -274,10 +332,6 @@ static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
 	.unregister_clks = hi3798cv200_clk_unregister,
 };
 
-/* hi3798 sysctrl CRG */
-
-#define HI3798_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -287,45 +341,20 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
+static const struct hi3798_clks hi3798cv200_sysctrl_clks = {
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
+	return hi3798_sysctrl_clk_register(pdev, &hi3798cv200_sysctrl_clks);
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
+	hi3798_sysctrl_clk_unregister(pdev, &hi3798cv200_sysctrl_clks);
 }
 
 static const struct hisi_crg_funcs hi3798cv200_sysctrl_funcs = {
-- 
2.39.2

