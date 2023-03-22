Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948116C50FD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjCVQmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCVQmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:42:33 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE6F6420E;
        Wed, 22 Mar 2023 09:42:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k15so10183181pgt.10;
        Wed, 22 Mar 2023 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS9JTRcWDJXKghFeO1Ewd82eQaR9XI3VWrHV848ZxsA=;
        b=qpPeCukKAIKAeM38tAdGle6ebUbVsPyPBWmC9worDTPYQ7FMmZGQd/k4ttPGb/4LxV
         odEEGRV0waHmUvzWy1VJDzI5bJhEIYDfoeQSnptoM8SCjJPez2d+Sd5jJ507ATbE+ZdU
         OZTu7r7+o3OPeB4xyufqlTQigwbLtXztIMxkXN3PPP/zcV7BF2Gxxktd3YJj1RZjVcUO
         3VVg0j7Yv1rrXnbswGBDpWcTEzbBbBPvdF3xEAppBSiACqEvzx6f45KvznysJCaMPqx1
         KL7IvXOwWjObcArb80474WLMdH0j5vbI1nJzn/mt7j+AuRYLEOrwdQWSErDyheCZgmsJ
         XJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS9JTRcWDJXKghFeO1Ewd82eQaR9XI3VWrHV848ZxsA=;
        b=3v3NeIuECjZQqOn3SRGkNJ9cL6Qql2+WAUGm6MRtmjL+taF1oJavehCrxoBacDzekU
         B7Vg5xvdmjgtSvAj7NwQEZWDx8REQuRM3/nzzLctrB4Y1lQuYz+y3WHWI+C2PoopGx+d
         dWUFDtfdNkn0SrePKf3bMfMJLqvE+qrqijWgNHD65j3TpJALgrPLTL/pyMpLEmgzsXOX
         Z88sT/PoJiicTYL6w/qois1IZi+IE2EN/e0MBxEUT+QPmbqRC3A16Ecqt4Q5ZGyx2QNo
         ynaDB937leOxh9ulk0PqVOHzYz0dWRVe3qelk+/B/KwoSx9OGj3Et8BvPagoVbKc4nr1
         TcHg==
X-Gm-Message-State: AO0yUKXaY/3xixdWC2fSggixNzovR/qsxn7PsDHoUKhq9IQ79h0WcS+c
        BJp6pc+AfbvJ3qDhpFzloGobK7ALHYT4Xl24sB4=
X-Google-Smtp-Source: AK7set/Vg29puQ3pzfGyhu7Gkh66+f+NIucib+rQ2gLppWmI6jWqF5OwF/dGul3nrnH5C/yrrHrHbQ==
X-Received: by 2002:a62:6409:0:b0:627:eaf5:48e8 with SMTP id y9-20020a626409000000b00627eaf548e8mr2926793pfb.32.1679503350078;
        Wed, 22 Mar 2023 09:42:30 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:42:29 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/9] clk: hisilicon: Extract common functions
Date:   Thu, 23 Mar 2023 00:41:50 +0800
Message-Id: <20230322164201.2454771-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322164201.2454771-1-mmyangfl@gmail.com>
References: <20230322164201.2454771-1-mmyangfl@gmail.com>
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

