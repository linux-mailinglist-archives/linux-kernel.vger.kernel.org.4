Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC36C3B23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCUUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCUUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:01:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB3474F7;
        Tue, 21 Mar 2023 13:01:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so21501395pjt.2;
        Tue, 21 Mar 2023 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS9JTRcWDJXKghFeO1Ewd82eQaR9XI3VWrHV848ZxsA=;
        b=ZOUedwkmiGVjKP1NG99vStn4H7ciw9boBTbZ35gR7/999o5FHdAdaP+Ccmq4kZRAKB
         oCReXIODCAC8W8Xhpr+WQN4joBwhOLVAiUQV5Ai1pgrMaEL6cWSYF4/mlb6RQgPY/Hzn
         3XFACa6z632k+S/oqcYhgm2qUbZ6ayQwg1vepYcdw/oyeecA/b2S/HbLc+znEMMTGNo0
         Tjyd0II9nR7yyt4gyHk6TWECR5ackzvqeVXViBJd7fUi/R/DHtDd3yDPvhJVN5I/prjz
         GTajb9Q1//EmlCsjySBEA1W/2JMxF+gg5aXnWbeeik5OnE1dNXOmTeJQQFCIS1OQDrVa
         W2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS9JTRcWDJXKghFeO1Ewd82eQaR9XI3VWrHV848ZxsA=;
        b=UhsONQKwK4qNxdg7C7fNamLgW5zUvwXgFhBIgRGtWTIuiwX+F+ra2Go7+IkkXmHNeX
         k1npCP5fgUue5/pgbbfseSoloxao1Gnqt3O1XhffNk03mFU0NoJkvs9+NDmxWkix0wMM
         XArFVeO2qAuIV+rDvo9zm3CKL/tHn5Ei9yGvc8o2S+i6sDrgmcCMF9CDA2I0kdY1+e0g
         c3j3Nwgk3KTqgl4TtlmhFMJgGmrGjKLo6Gk8HGBnW8hZgRPXfLk3K8MYjehtwvQDqeHr
         eDrKFJsVeDEVF0rLflcfDH1BccP7TKdJK7HwrYkD/ufBzr3u+bsK0thWmV2ZwCD81Do6
         0sSg==
X-Gm-Message-State: AO0yUKU68xRd6vIj6wZhBCUWntQys7pAWCKjmf3RyEGjaqilVCukASv+
        tCb9XNOujTa56h7x+KSsLHI=
X-Google-Smtp-Source: AK7set8LlvUIQzNntJWrl5dYPZyd9MDeIgi9PIB1GT39GAN7+Fr3Gwm06dDKVsPEPJHfzlyD+BEsVQ==
X-Received: by 2002:a17:90b:1650:b0:23f:5a17:ac74 with SMTP id il16-20020a17090b165000b0023f5a17ac74mr1175308pjb.0.1679428866519;
        Tue, 21 Mar 2023 13:01:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0023b5528b8d4sm930557pjb.19.2023.03.21.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:01:06 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] clk: hisilicon: Extract common functions
Date:   Wed, 22 Mar 2023 04:00:23 +0800
Message-Id: <20230321200031.1812026-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321200031.1812026-1-mmyangfl@gmail.com>
References: <20230321200031.1812026-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be reused with other Hi3798 series SoCs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/crg-hi3798.c | 243 ++++++++++++++++-------------
 1 file changed, 137 insertions(+), 106 deletions(-)

diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 7e9507de2..778637131 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -59,6 +59,121 @@ static const struct hisi_fixed_rate_clock hi3798_fixed_rate_clks[] = {
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
+static struct hisi_clock_data *
+hi3798_clk_register(struct platform_device *pdev,
+		    const struct hi3798_clks *clks)
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
+static void hi3798_clk_unregister(struct platform_device *pdev,
+				  const struct hi3798_clks *clks)
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
+static struct hisi_clock_data *
+hi3798_sysctrl_clk_register(struct platform_device *pdev,
+			    const struct hi3798_clks *clks)
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
+static void hi3798_sysctrl_clk_unregister(struct platform_device *pdev,
+					  const struct hi3798_clks *clks)
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
@@ -194,79 +309,24 @@ static const struct hisi_gate_clock hi3798cv200_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0xb0, 18, 0 },
 };
 
-static struct hisi_clock_data *hi3798cv200_clk_register(
-				struct platform_device *pdev)
-{
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
+static const struct hi3798_clks hi3798cv200_crg_clks = {
+	.gate_clks = hi3798cv200_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_gate_clks),
+	.mux_clks = hi3798cv200_mux_clks,
+	.mux_clks_nums = ARRAY_SIZE(hi3798cv200_mux_clks),
+	.phase_clks = hi3798cv200_phase_clks,
+	.phase_clks_nums = ARRAY_SIZE(hi3798cv200_phase_clks),
+};
 
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
+static struct hisi_clock_data *
+hi3798cv200_clk_register(struct platform_device *pdev)
+{
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
@@ -274,10 +334,6 @@ static const struct hisi_crg_funcs hi3798cv200_crg_funcs = {
 	.unregister_clks = hi3798cv200_clk_unregister,
 };
 
-/* hi3798 sysctrl CRG */
-
-#define HI3798_SYSCTRL_NR_CLKS 16
-
 static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 	{ HISTB_IR_CLK, "clk_ir", "24m",
 		CLK_SET_RATE_PARENT, 0x48, 4, 0, },
@@ -287,45 +343,20 @@ static const struct hisi_gate_clock hi3798cv200_sysctrl_gate_clks[] = {
 		CLK_SET_RATE_PARENT, 0x48, 10, 0, },
 };
 
-static struct hisi_clock_data *hi3798cv200_sysctrl_clk_register(
-					struct platform_device *pdev)
-{
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
+static const struct hi3798_clks hi3798cv200_sysctrl_clks = {
+	.gate_clks = hi3798cv200_sysctrl_gate_clks,
+	.gate_clks_nums = ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
+};
 
-unregister_gate:
-	hisi_clk_unregister_gate(hi3798cv200_sysctrl_gate_clks,
-				ARRAY_SIZE(hi3798cv200_sysctrl_gate_clks),
-				clk_data);
-	return ERR_PTR(ret);
+static struct hisi_clock_data *
+hi3798cv200_sysctrl_clk_register(struct platform_device *pdev)
+{
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

