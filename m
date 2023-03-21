Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBB6C3B25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCUUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCUUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:01:46 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A6F4A1E6;
        Tue, 21 Mar 2023 13:01:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u5so17228476plq.7;
        Tue, 21 Mar 2023 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679428878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBzIl+Etn0BmttNtqrehjuODCX4s5rpsIbPpkMECh08=;
        b=jiCKFCNUldOX+U75Zm9r5sIgNhQorch/jg6Eg6JScW8J0Ea/jmXacnc/x5PJw+RdBi
         tJiPN9/u2iGchVjK/Leky2QI1nIuIrHtF2yivW0/OGYnQOjfyFXmfIzpu1bQFD/wmnED
         Fw46+GXaeX/MMd1IyzjxCBLzMkXenn/O9QuWWtnMGntTVB8/agBwyv7GEbW+95A5XcuX
         3hd7metgPoqAPyUimQ5aDFpi7Ntll9RdcmI/cw6O+6QTWmwULtbVo/eyMthcDxOsxAj+
         g2n+PVci/P2lYJpje9ESduE6WNLeWTbPjNAMYlfTbq3neAcdeVIwKZKRIx11R5StsrMT
         zoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679428878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBzIl+Etn0BmttNtqrehjuODCX4s5rpsIbPpkMECh08=;
        b=G/8tBtFYp7afhRM1QFWN6HuzS8xANnNkTnIxc676a8XxCnUeHGMQ3tAi57g3WM/vWY
         gmRzojXRRFwZKey+IlnNNT7uqvrzZHK8l2hcjuz6WVgi8rM1CqyZ8Im7oHD7JEwH1Yes
         2zYmK1jHuqCIzfv3mA40ce8gGJ3+s2OFFlHHec08MCXvagTPA3UY/+Aljizvzj0vbcDu
         MPPjaWSnzB+5sge3KKkYDHRKCjW00y32Ymx1im2s6i15PFL8ltRsSacyeqXwq0pE/64w
         F8sC8vDz6uIB8IZ3ZWGR05turA/zYN4VCz8/qqzW8p+zvWdnwZtTS7C+6sTlKNiqyQWN
         uIBQ==
X-Gm-Message-State: AO0yUKUBFAvPF/6pOgD71WmfyA9ijVxWxypN8bvF1GidQR7exNs1FC5a
        GpMsmTuYVuXG/ZleTiisB2Pycyx/SbWxPKr2sMM=
X-Google-Smtp-Source: AK7set/K5fnqLWa2+KPMXA55I1BK48d2eIS+GpiTHf3/UpDMa3+e6ieRq3vghJBRG5m96DHDHIjU9A==
X-Received: by 2002:a17:90b:4f47:b0:234:5eb:2177 with SMTP id pj7-20020a17090b4f4700b0023405eb2177mr1066790pjb.9.1679428877909;
        Tue, 21 Mar 2023 13:01:17 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.245.199])
        by smtp.gmail.com with ESMTPSA id mt19-20020a17090b231300b0023b5528b8d4sm930557pjb.19.2023.03.21.13.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:01:17 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] clk: hisilicon: Migrate devm APIs
Date:   Wed, 22 Mar 2023 04:00:24 +0800
Message-Id: <20230321200031.1812026-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321200031.1812026-1-mmyangfl@gmail.com>
References: <20230321200031.1812026-1-mmyangfl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrates devm APIs for HiSilicon clock drivers.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3519.c        |  45 +---
 drivers/clk/hisilicon/clk-hi3559a.c       | 111 ++++------
 drivers/clk/hisilicon/clk-hi3620.c        |  12 +-
 drivers/clk/hisilicon/clk-hi3660.c        |  46 ++--
 drivers/clk/hisilicon/clk-hi3670.c        |  52 +++--
 drivers/clk/hisilicon/clk-hi6220.c        |  34 +--
 drivers/clk/hisilicon/clk-hip04.c         |   4 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    |  15 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |  33 +--
 drivers/clk/hisilicon/clk.c               | 245 ++++++++++------------
 drivers/clk/hisilicon/clk.h               |  89 ++++----
 drivers/clk/hisilicon/clkdivider-hi6220.c |  23 +-
 drivers/clk/hisilicon/clkgate-separated.c |  16 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c   |  60 ++----
 drivers/clk/hisilicon/crg-hi3798.c        |  56 ++---
 15 files changed, 364 insertions(+), 477 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350..5900140c7 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -75,6 +75,7 @@ static const struct hisi_gate_clock hi3519_gate_clks[] = {
 
 static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
@@ -82,62 +83,34 @@ static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
-	ret = hisi_clk_register_fixed_rate(hi3519_fixed_rate_clks,
+	ret = hisi_clk_register_fixed_rate(dev, hi3519_fixed_rate_clks,
 				     ARRAY_SIZE(hi3519_fixed_rate_clks),
 				     clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_mux(hi3519_mux_clks,
+	ret = hisi_clk_register_mux(dev, hi3519_mux_clks,
 				ARRAY_SIZE(hi3519_mux_clks),
 				clk_data);
 	if (ret)
-		goto unregister_fixed_rate;
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_gate(hi3519_gate_clks,
+	ret = hisi_clk_register_gate(dev, hi3519_gate_clks,
 				ARRAY_SIZE(hi3519_gate_clks),
 				clk_data);
 	if (ret)
-		goto unregister_mux;
+		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		return ERR_PTR(ret);
 
 	return clk_data;
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
 }
 
 static void hi3519_clk_unregister(struct platform_device *pdev)
 {
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
 }
 
 static int hi3519_clk_probe(struct platform_device *pdev)
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 8036bd8cb..7dbfd949a 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -452,19 +452,20 @@ static const struct clk_ops hisi_clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 };
 
-static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
-			   int nums, struct hisi_clock_data *data, struct device *dev)
+static int hisi_clk_register_pll(struct device *dev,
+				 const struct hi3559av100_pll_clock *clks,
+				 int nums, struct hisi_clock_data *data)
 {
 	void __iomem *base = data->base;
 	struct hi3559av100_clk_pll *p_clk = NULL;
-	struct clk *clk = NULL;
 	struct clk_init_data init;
 	int i;
+	int ret;
 
 	p_clk = devm_kzalloc(dev, sizeof(*p_clk) * nums, GFP_KERNEL);
 
 	if (!p_clk)
-		return;
+		return 0;
 
 	for (i = 0; i < nums; i++) {
 		init.name = clks[i].name;
@@ -489,22 +490,24 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 		p_clk->refdiv_width = clks[i].refdiv_width;
 		p_clk->hw.init = &init;
 
-		clk = clk_register(NULL, &p_clk->hw);
-		if (IS_ERR(clk)) {
-			devm_kfree(dev, p_clk);
+		ret = devm_clk_hw_register(dev, &p_clk->hw);
+		if (ret) {
 			dev_err(dev, "%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return ret;
 		}
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = &p_clk->hw;
 		p_clk++;
 	}
+
+	return 0;
 }
 
 static struct hisi_clock_data *hi3559av100_clk_register(
 	struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
@@ -512,55 +515,36 @@ static struct hisi_clock_data *hi3559av100_clk_register(
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
-	ret = hisi_clk_register_fixed_rate(hi3559av100_fixed_rate_clks_crg,
+	ret = hisi_clk_register_fixed_rate(dev, hi3559av100_fixed_rate_clks_crg,
 					   ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	hisi_clk_register_pll(hi3559av100_pll_clks,
-			      ARRAY_SIZE(hi3559av100_pll_clks), clk_data, &pdev->dev);
+	ret = hisi_clk_register_pll(dev, hi3559av100_pll_clks,
+				    ARRAY_SIZE(hi3559av100_pll_clks), clk_data);
+	if (ret)
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_mux(hi3559av100_mux_clks_crg,
+	ret = hisi_clk_register_mux(dev, hi3559av100_mux_clks_crg,
 				    ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
 	if (ret)
-		goto unregister_fixed_rate;
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_gate(hi3559av100_gate_clks,
+	ret = hisi_clk_register_gate(dev, hi3559av100_gate_clks,
 				     ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
 	if (ret)
-		goto unregister_mux;
+		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		return ERR_PTR(ret);
 
 	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), clk_data);
-	return ERR_PTR(ret);
 }
 
 static void hi3559av100_clk_unregister(struct platform_device *pdev)
 {
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3559av100_gate_clks,
-				 ARRAY_SIZE(hi3559av100_gate_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
-				ARRAY_SIZE(hi3559av100_mux_clks_crg), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_fixed_rate_clks_crg,
-				       ARRAY_SIZE(hi3559av100_fixed_rate_clks_crg), crg->clk_data);
 }
 
 static const struct hisi_crg_funcs hi3559av100_crg_funcs = {
@@ -699,6 +683,7 @@ static int hi3559av100_shub_default_clk_set(void)
 static struct hisi_clock_data *hi3559av100_shub_clk_register(
 	struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data = NULL;
 	int ret;
 
@@ -708,62 +693,36 @@ static struct hisi_clock_data *hi3559av100_shub_clk_register(
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
-	ret = hisi_clk_register_fixed_rate(hi3559av100_shub_fixed_rate_clks,
+	ret = hisi_clk_register_fixed_rate(dev, hi3559av100_shub_fixed_rate_clks,
 					   ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_mux(hi3559av100_shub_mux_clks,
+	ret = hisi_clk_register_mux(dev, hi3559av100_shub_mux_clks,
 				    ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
 	if (ret)
-		goto unregister_fixed_rate;
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_divider(hi3559av100_shub_div_clks,
+	ret = hisi_clk_register_divider(dev, hi3559av100_shub_div_clks,
 					ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
 	if (ret)
-		goto unregister_mux;
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_gate(hi3559av100_shub_gate_clks,
+	ret = hisi_clk_register_gate(dev, hi3559av100_shub_gate_clks,
 				     ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
 	if (ret)
-		goto unregister_factor;
+		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		return ERR_PTR(ret);
 
 	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), clk_data);
-unregister_factor:
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), clk_data);
-	return ERR_PTR(ret);
 }
 
 static void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
 {
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
-				 ARRAY_SIZE(hi3559av100_shub_gate_clks), crg->clk_data);
-	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
-				    ARRAY_SIZE(hi3559av100_shub_div_clks), crg->clk_data);
-	hisi_clk_unregister_mux(hi3559av100_shub_mux_clks,
-				ARRAY_SIZE(hi3559av100_shub_mux_clks), crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3559av100_shub_fixed_rate_clks,
-				       ARRAY_SIZE(hi3559av100_shub_fixed_rate_clks), crg->clk_data);
 }
 
 static const struct hisi_crg_funcs hi3559av100_shub_crg_funcs = {
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index a3d04c7c3..d6307a8cd 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -194,23 +194,25 @@ static struct hisi_gate_clock hi3620_separated_gate_clks[] __initdata = {
 
 static void __init hi3620_clk_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	clk_data = hisi_clk_init(np, HI3620_NR_CLKS);
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_fixed_rate(hi3620_fixed_rate_clks,
+	hisi_clk_register_fixed_rate(dev, hi3620_fixed_rate_clks,
 				     ARRAY_SIZE(hi3620_fixed_rate_clks),
 				     clk_data);
-	hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
+	hisi_clk_register_fixed_factor(dev, hi3620_fixed_factor_clks,
 				       ARRAY_SIZE(hi3620_fixed_factor_clks),
 				       clk_data);
-	hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
+	hisi_clk_register_mux(dev, hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
 			      clk_data);
-	hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
+	hisi_clk_register_divider(dev, hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
 				  clk_data);
-	hisi_clk_register_gate_sep(hi3620_separated_gate_clks,
+	hisi_clk_register_gate_sep(dev, hi3620_separated_gate_clks,
 				   ARRAY_SIZE(hi3620_separated_gate_clks),
 				   clk_data);
 }
diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
index 41f61726a..d605c2a08 100644
--- a/drivers/clk/hisilicon/clk-hi3660.c
+++ b/drivers/clk/hisilicon/clk-hi3660.c
@@ -473,6 +473,8 @@ static struct hisi_clock_data *clk_crgctrl_data;
 
 static void hi3660_clk_iomcu_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3660_iomcu_gate_sep_clks);
 
@@ -480,13 +482,15 @@ static void hi3660_clk_iomcu_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi3660_iomcu_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3660_iomcu_gate_sep_clks,
 				   ARRAY_SIZE(hi3660_iomcu_gate_sep_clks),
 				   clk_data);
 }
 
 static void hi3660_clk_pmuctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3660_pmu_gate_clks);
 
@@ -494,24 +498,28 @@ static void hi3660_clk_pmuctrl_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate(hi3660_pmu_gate_clks,
+	hisi_clk_register_gate(dev, hi3660_pmu_gate_clks,
 			       ARRAY_SIZE(hi3660_pmu_gate_clks), clk_data);
 }
 
 static void hi3660_clk_pctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3660_pctrl_gate_clks);
 
 	clk_data = hisi_clk_init(np, nr);
 	if (!clk_data)
 		return;
-	hisi_clk_register_gate(hi3660_pctrl_gate_clks,
+	hisi_clk_register_gate(dev, hi3660_pctrl_gate_clks,
 			       ARRAY_SIZE(hi3660_pctrl_gate_clks), clk_data);
 }
 
 static void hi3660_clk_sctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3660_sctrl_gate_clks) +
 		 ARRAY_SIZE(hi3660_sctrl_gate_sep_clks) +
@@ -521,20 +529,22 @@ static void hi3660_clk_sctrl_init(struct device_node *np)
 	clk_data = hisi_clk_init(np, nr);
 	if (!clk_data)
 		return;
-	hisi_clk_register_gate(hi3660_sctrl_gate_clks,
+	hisi_clk_register_gate(dev, hi3660_sctrl_gate_clks,
 			       ARRAY_SIZE(hi3660_sctrl_gate_clks), clk_data);
-	hisi_clk_register_gate_sep(hi3660_sctrl_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3660_sctrl_gate_sep_clks,
 				   ARRAY_SIZE(hi3660_sctrl_gate_sep_clks),
 				   clk_data);
-	hisi_clk_register_mux(hi3660_sctrl_mux_clks,
+	hisi_clk_register_mux(dev, hi3660_sctrl_mux_clks,
 			      ARRAY_SIZE(hi3660_sctrl_mux_clks), clk_data);
-	hisi_clk_register_divider(hi3660_sctrl_divider_clks,
+	hisi_clk_register_divider(dev, hi3660_sctrl_divider_clks,
 				  ARRAY_SIZE(hi3660_sctrl_divider_clks),
 				  clk_data);
 }
 
 static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	int nr = ARRAY_SIZE(hi3660_fixed_rate_clks) +
 		 ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks) +
 		 ARRAY_SIZE(hi3660_crgctrl_gate_clks) +
@@ -548,9 +558,9 @@ static void hi3660_clk_crgctrl_early_init(struct device_node *np)
 		return;
 
 	for (i = 0; i < nr; i++)
-		clk_crgctrl_data->clk_data.clks[i] = ERR_PTR(-EPROBE_DEFER);
+		clk_crgctrl_data->clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
 
-	hisi_clk_register_fixed_rate(hi3660_fixed_rate_clks,
+	hisi_clk_register_fixed_rate(dev, hi3660_fixed_rate_clks,
 				     ARRAY_SIZE(hi3660_fixed_rate_clks),
 				     clk_crgctrl_data);
 }
@@ -559,7 +569,9 @@ CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
 
 static void hi3660_clk_crgctrl_init(struct device_node *np)
 {
-	struct clk **clks;
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
+	struct clk_hw **clks;
 	int i;
 
 	if (!clk_crgctrl_data)
@@ -569,24 +581,24 @@ static void hi3660_clk_crgctrl_init(struct device_node *np)
 	if (!clk_crgctrl_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi3660_crgctrl_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3660_crgctrl_gate_sep_clks,
 				   ARRAY_SIZE(hi3660_crgctrl_gate_sep_clks),
 				   clk_crgctrl_data);
-	hisi_clk_register_gate(hi3660_crgctrl_gate_clks,
+	hisi_clk_register_gate(dev, hi3660_crgctrl_gate_clks,
 			       ARRAY_SIZE(hi3660_crgctrl_gate_clks),
 			       clk_crgctrl_data);
-	hisi_clk_register_mux(hi3660_crgctrl_mux_clks,
+	hisi_clk_register_mux(dev, hi3660_crgctrl_mux_clks,
 			      ARRAY_SIZE(hi3660_crgctrl_mux_clks),
 			      clk_crgctrl_data);
-	hisi_clk_register_fixed_factor(hi3660_crg_fixed_factor_clks,
+	hisi_clk_register_fixed_factor(dev, hi3660_crg_fixed_factor_clks,
 				       ARRAY_SIZE(hi3660_crg_fixed_factor_clks),
 				       clk_crgctrl_data);
-	hisi_clk_register_divider(hi3660_crgctrl_divider_clks,
+	hisi_clk_register_divider(dev, hi3660_crgctrl_divider_clks,
 				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
 				  clk_crgctrl_data);
 
-	clks = clk_crgctrl_data->clk_data.clks;
-	for (i = 0; i < clk_crgctrl_data->clk_data.clk_num; i++) {
+	clks = clk_crgctrl_data->clk_data->hws;
+	for (i = 0; i < clk_crgctrl_data->clk_data->num; i++) {
 		if (IS_ERR(clks[i]) && PTR_ERR(clks[i]) != -EPROBE_DEFER)
 			pr_err("Failed to register crgctrl clock[%d] err=%ld\n",
 			       i, PTR_ERR(clks[i]));
diff --git a/drivers/clk/hisilicon/clk-hi3670.c b/drivers/clk/hisilicon/clk-hi3670.c
index 4d05a7168..1e6da7cc2 100644
--- a/drivers/clk/hisilicon/clk-hi3670.c
+++ b/drivers/clk/hisilicon/clk-hi3670.c
@@ -824,6 +824,8 @@ static const struct hisi_gate_clock hi3670_media2_gate_sep_clks[] = {
 
 static void hi3670_clk_crgctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	int nr = ARRAY_SIZE(hi3670_fixed_rate_clks) +
@@ -837,40 +839,44 @@ static void hi3670_clk_crgctrl_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_fixed_rate(hi3670_fixed_rate_clks,
+	hisi_clk_register_fixed_rate(dev, hi3670_fixed_rate_clks,
 				     ARRAY_SIZE(hi3670_fixed_rate_clks),
 				     clk_data);
-	hisi_clk_register_gate_sep(hi3670_crgctrl_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3670_crgctrl_gate_sep_clks,
 				   ARRAY_SIZE(hi3670_crgctrl_gate_sep_clks),
 				   clk_data);
-	hisi_clk_register_gate(hi3670_crgctrl_gate_clks,
+	hisi_clk_register_gate(dev, hi3670_crgctrl_gate_clks,
 			       ARRAY_SIZE(hi3670_crgctrl_gate_clks),
 			       clk_data);
-	hisi_clk_register_mux(hi3670_crgctrl_mux_clks,
+	hisi_clk_register_mux(dev, hi3670_crgctrl_mux_clks,
 			      ARRAY_SIZE(hi3670_crgctrl_mux_clks),
 			      clk_data);
-	hisi_clk_register_fixed_factor(hi3670_crg_fixed_factor_clks,
+	hisi_clk_register_fixed_factor(dev, hi3670_crg_fixed_factor_clks,
 				       ARRAY_SIZE(hi3670_crg_fixed_factor_clks),
 				       clk_data);
-	hisi_clk_register_divider(hi3670_crgctrl_divider_clks,
+	hisi_clk_register_divider(dev, hi3670_crgctrl_divider_clks,
 				  ARRAY_SIZE(hi3670_crgctrl_divider_clks),
 				  clk_data);
 }
 
 static void hi3670_clk_pctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3670_pctrl_gate_clks);
 
 	clk_data = hisi_clk_init(np, nr);
 	if (!clk_data)
 		return;
-	hisi_clk_register_gate(hi3670_pctrl_gate_clks,
+	hisi_clk_register_gate(dev, hi3670_pctrl_gate_clks,
 			       ARRAY_SIZE(hi3670_pctrl_gate_clks), clk_data);
 }
 
 static void hi3670_clk_pmuctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3670_pmu_gate_clks);
 
@@ -878,12 +884,14 @@ static void hi3670_clk_pmuctrl_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate(hi3670_pmu_gate_clks,
+	hisi_clk_register_gate(dev, hi3670_pmu_gate_clks,
 			       ARRAY_SIZE(hi3670_pmu_gate_clks), clk_data);
 }
 
 static void hi3670_clk_sctrl_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3670_sctrl_gate_sep_clks) +
 		 ARRAY_SIZE(hi3670_sctrl_gate_clks) +
@@ -894,22 +902,24 @@ static void hi3670_clk_sctrl_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi3670_sctrl_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3670_sctrl_gate_sep_clks,
 				   ARRAY_SIZE(hi3670_sctrl_gate_sep_clks),
 				   clk_data);
-	hisi_clk_register_gate(hi3670_sctrl_gate_clks,
+	hisi_clk_register_gate(dev, hi3670_sctrl_gate_clks,
 			       ARRAY_SIZE(hi3670_sctrl_gate_clks),
 			       clk_data);
-	hisi_clk_register_mux(hi3670_sctrl_mux_clks,
+	hisi_clk_register_mux(dev, hi3670_sctrl_mux_clks,
 			      ARRAY_SIZE(hi3670_sctrl_mux_clks),
 			      clk_data);
-	hisi_clk_register_divider(hi3670_sctrl_divider_clks,
+	hisi_clk_register_divider(dev, hi3670_sctrl_divider_clks,
 				  ARRAY_SIZE(hi3670_sctrl_divider_clks),
 				  clk_data);
 }
 
 static void hi3670_clk_iomcu_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi3670_iomcu_gate_sep_clks) +
 			ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks);
@@ -918,16 +928,18 @@ static void hi3670_clk_iomcu_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate(hi3670_iomcu_gate_sep_clks,
+	hisi_clk_register_gate(dev, hi3670_iomcu_gate_sep_clks,
 			       ARRAY_SIZE(hi3670_iomcu_gate_sep_clks), clk_data);
 
-	hisi_clk_register_fixed_factor(hi3670_iomcu_fixed_factor_clks,
+	hisi_clk_register_fixed_factor(dev, hi3670_iomcu_fixed_factor_clks,
 				       ARRAY_SIZE(hi3670_iomcu_fixed_factor_clks),
 				       clk_data);
 }
 
 static void hi3670_clk_media1_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	int nr = ARRAY_SIZE(hi3670_media1_gate_sep_clks) +
@@ -939,22 +951,24 @@ static void hi3670_clk_media1_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi3670_media1_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3670_media1_gate_sep_clks,
 				   ARRAY_SIZE(hi3670_media1_gate_sep_clks),
 				   clk_data);
-	hisi_clk_register_gate(hi3670_media1_gate_clks,
+	hisi_clk_register_gate(dev, hi3670_media1_gate_clks,
 			       ARRAY_SIZE(hi3670_media1_gate_clks),
 			       clk_data);
-	hisi_clk_register_mux(hi3670_media1_mux_clks,
+	hisi_clk_register_mux(dev, hi3670_media1_mux_clks,
 			      ARRAY_SIZE(hi3670_media1_mux_clks),
 			      clk_data);
-	hisi_clk_register_divider(hi3670_media1_divider_clks,
+	hisi_clk_register_divider(dev, hi3670_media1_divider_clks,
 				  ARRAY_SIZE(hi3670_media1_divider_clks),
 				  clk_data);
 }
 
 static void hi3670_clk_media2_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	int nr = ARRAY_SIZE(hi3670_media2_gate_sep_clks);
@@ -963,7 +977,7 @@ static void hi3670_clk_media2_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi3670_media2_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi3670_media2_gate_sep_clks,
 				   ARRAY_SIZE(hi3670_media2_gate_sep_clks),
 				   clk_data);
 }
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index e7cdf72d4..892f3d61f 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -71,19 +71,21 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
 
 static void __init hi6220_clk_ao_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data_ao;
 
 	clk_data_ao = hisi_clk_init(np, HI6220_AO_NR_CLKS);
 	if (!clk_data_ao)
 		return;
 
-	hisi_clk_register_fixed_rate(hi6220_fixed_rate_clks,
+	hisi_clk_register_fixed_rate(dev, hi6220_fixed_rate_clks,
 				ARRAY_SIZE(hi6220_fixed_rate_clks), clk_data_ao);
 
-	hisi_clk_register_fixed_factor(hi6220_fixed_factor_clks,
+	hisi_clk_register_fixed_factor(dev, hi6220_fixed_factor_clks,
 				ARRAY_SIZE(hi6220_fixed_factor_clks), clk_data_ao);
 
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
+	hisi_clk_register_gate_sep(dev, hi6220_separated_gate_clks_ao,
 				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
 }
 /* Allow reset driver to probe as well */
@@ -179,19 +181,21 @@ static struct hi6220_divider_clock hi6220_div_clks_sys[] __initdata = {
 
 static void __init hi6220_clk_sys_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	clk_data = hisi_clk_init(np, HI6220_SYS_NR_CLKS);
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_sys,
+	hisi_clk_register_gate_sep(dev, hi6220_separated_gate_clks_sys,
 			ARRAY_SIZE(hi6220_separated_gate_clks_sys), clk_data);
 
-	hisi_clk_register_mux(hi6220_mux_clks_sys,
+	hisi_clk_register_mux(dev, hi6220_mux_clks_sys,
 			ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
 
-	hi6220_clk_register_divider(hi6220_div_clks_sys,
+	hi6220_clk_register_divider(dev, hi6220_div_clks_sys,
 			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
 }
 CLK_OF_DECLARE_DRIVER(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
@@ -236,19 +240,21 @@ static struct hi6220_divider_clock hi6220_div_clks_media[] __initdata = {
 
 static void __init hi6220_clk_media_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	clk_data = hisi_clk_init(np, HI6220_MEDIA_NR_CLKS);
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_media,
+	hisi_clk_register_gate_sep(dev, hi6220_separated_gate_clks_media,
 				ARRAY_SIZE(hi6220_separated_gate_clks_media), clk_data);
 
-	hisi_clk_register_mux(hi6220_mux_clks_media,
+	hisi_clk_register_mux(dev, hi6220_mux_clks_media,
 				ARRAY_SIZE(hi6220_mux_clks_media), clk_data);
 
-	hi6220_clk_register_divider(hi6220_div_clks_media,
+	hi6220_clk_register_divider(dev, hi6220_div_clks_media,
 				ARRAY_SIZE(hi6220_div_clks_media), clk_data);
 }
 CLK_OF_DECLARE_DRIVER(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
@@ -270,16 +276,18 @@ static struct hi6220_divider_clock hi6220_div_clks_power[] __initdata = {
 
 static void __init hi6220_clk_power_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	clk_data = hisi_clk_init(np, HI6220_POWER_NR_CLKS);
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate(hi6220_gate_clks_power,
+	hisi_clk_register_gate(dev, hi6220_gate_clks_power,
 				ARRAY_SIZE(hi6220_gate_clks_power), clk_data);
 
-	hi6220_clk_register_divider(hi6220_div_clks_power,
+	hi6220_clk_register_divider(dev, hi6220_div_clks_power,
 				ARRAY_SIZE(hi6220_div_clks_power), clk_data);
 }
 CLK_OF_DECLARE(hi6220_clk_power, "hisilicon,hi6220-pmctrl", hi6220_clk_power_init);
@@ -292,6 +300,8 @@ static const struct hisi_gate_clock hi6220_acpu_sc_gate_sep_clks[] = {
 
 static void __init hi6220_clk_acpu_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int nr = ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks);
 
@@ -299,7 +309,7 @@ static void __init hi6220_clk_acpu_init(struct device_node *np)
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_gate_sep(hi6220_acpu_sc_gate_sep_clks,
+	hisi_clk_register_gate_sep(dev, hi6220_acpu_sc_gate_sep_clks,
 				   ARRAY_SIZE(hi6220_acpu_sc_gate_sep_clks),
 				   clk_data);
 }
diff --git a/drivers/clk/hisilicon/clk-hip04.c b/drivers/clk/hisilicon/clk-hip04.c
index 785b9faf3..babb45bce 100644
--- a/drivers/clk/hisilicon/clk-hip04.c
+++ b/drivers/clk/hisilicon/clk-hip04.c
@@ -29,13 +29,15 @@ static struct hisi_fixed_rate_clock hip04_fixed_rate_clks[] __initdata = {
 
 static void __init hip04_clk_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	clk_data = hisi_clk_init(np, HIP04_NR_CLKS);
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_fixed_rate(hip04_fixed_rate_clks,
+	hisi_clk_register_fixed_rate(dev, hip04_fixed_rate_clks,
 				     ARRAY_SIZE(hip04_fixed_rate_clks),
 				     clk_data);
 }
diff --git a/drivers/clk/hisilicon/clk-hisi-phase.c b/drivers/clk/hisilicon/clk-hisi-phase.c
index ba6afad66..cea5c773c 100644
--- a/drivers/clk/hisilicon/clk-hisi-phase.c
+++ b/drivers/clk/hisilicon/clk-hisi-phase.c
@@ -5,11 +5,11 @@
  * Simple HiSilicon phase clock implementation.
  */
 
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 
 #include "clk.h"
 
@@ -90,14 +90,15 @@ static const struct clk_ops clk_phase_ops = {
 	.set_phase = hisi_clk_set_phase,
 };
 
-struct clk *clk_register_hisi_phase(struct device *dev,
+struct clk_hw *devm_clk_hw_register_hisi_phase(struct device *dev,
 		const struct hisi_phase_clock *clks,
 		void __iomem *base, spinlock_t *lock)
 {
 	struct clk_hisi_phase *phase;
 	struct clk_init_data init;
+	int ret;
 
-	phase = devm_kzalloc(dev, sizeof(struct clk_hisi_phase), GFP_KERNEL);
+	phase = devm_kzalloc(dev, sizeof(*phase), GFP_KERNEL);
 	if (!phase)
 		return ERR_PTR(-ENOMEM);
 
@@ -116,6 +117,10 @@ struct clk *clk_register_hisi_phase(struct device *dev,
 	phase->phase_num = clks->phase_num;
 	phase->hw.init = &init;
 
-	return devm_clk_register(dev, &phase->hw);
+	ret = devm_clk_hw_register(dev, &phase->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &phase->hw;
 }
-EXPORT_SYMBOL_GPL(clk_register_hisi_phase);
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_hisi_phase);
diff --git a/drivers/clk/hisilicon/clk-hix5hd2.c b/drivers/clk/hisilicon/clk-hix5hd2.c
index 64bdd3f05..368ef02a1 100644
--- a/drivers/clk/hisilicon/clk-hix5hd2.c
+++ b/drivers/clk/hisilicon/clk-hix5hd2.c
@@ -249,21 +249,23 @@ static const struct clk_ops clk_complex_ops = {
 	.disable = clk_complex_disable,
 };
 
-static void __init
-hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
+static int __init
+hix5hd2_clk_register_complex(struct device *dev,
+			     struct hix5hd2_complex_clock *clks, int nums,
 			     struct hisi_clock_data *data)
 {
 	void __iomem *base = data->base;
 	int i;
+	int ret;
 
 	for (i = 0; i < nums; i++) {
 		struct hix5hd2_clk_complex *p_clk;
-		struct clk *clk;
+		struct clk_hw *clk;
 		struct clk_init_data init;
 
-		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
+		p_clk = devm_kzalloc(dev, sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
-			return;
+			return 0;
 
 		init.name = clks[i].name;
 		if (clks[i].type == TYPE_ETHER)
@@ -284,34 +286,37 @@ hix5hd2_clk_register_complex(struct hix5hd2_complex_clock *clks, int nums,
 		p_clk->phy_rst_mask = clks[i].phy_rst_mask;
 		p_clk->hw.init = &init;
 
-		clk = clk_register(NULL, &p_clk->hw);
-		if (IS_ERR(clk)) {
-			kfree(p_clk);
+		ret = devm_clk_hw_register(dev, &p_clk->hw);
+		if (ret) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return ret;
 		}
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = &p_clk->hw;
 	}
+
+	return 0;
 }
 
 static void __init hix5hd2_clk_init(struct device_node *np)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 
 	clk_data = hisi_clk_init(np, HIX5HD2_NR_CLKS);
 	if (!clk_data)
 		return;
 
-	hisi_clk_register_fixed_rate(hix5hd2_fixed_rate_clks,
+	hisi_clk_register_fixed_rate(dev, hix5hd2_fixed_rate_clks,
 				     ARRAY_SIZE(hix5hd2_fixed_rate_clks),
 				     clk_data);
-	hisi_clk_register_mux(hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
+	hisi_clk_register_mux(dev, hix5hd2_mux_clks, ARRAY_SIZE(hix5hd2_mux_clks),
 					clk_data);
-	hisi_clk_register_gate(hix5hd2_gate_clks,
+	hisi_clk_register_gate(dev, hix5hd2_gate_clks,
 			ARRAY_SIZE(hix5hd2_gate_clks), clk_data);
-	hix5hd2_clk_register_complex(hix5hd2_complex_clks,
+	hix5hd2_clk_register_complex(dev, hix5hd2_complex_clks,
 				     ARRAY_SIZE(hix5hd2_complex_clks),
 				     clk_data);
 }
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93..33a312935 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -13,6 +13,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -23,14 +24,13 @@
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
 
-struct hisi_clock_data *hisi_clk_alloc(struct platform_device *pdev,
-						int nr_clks)
+struct hisi_clock_data *hisi_clk_alloc(struct platform_device *pdev, int nr_clks)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	struct resource *res;
-	struct clk **clk_table;
 
-	clk_data = devm_kmalloc(&pdev->dev, sizeof(*clk_data), GFP_KERNEL);
+	clk_data = devm_kmalloc(dev, sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
 		return NULL;
 
@@ -42,146 +42,125 @@ struct hisi_clock_data *hisi_clk_alloc(struct platform_device *pdev,
 	if (!clk_data->base)
 		return NULL;
 
-	clk_table = devm_kmalloc_array(&pdev->dev, nr_clks,
-				       sizeof(*clk_table),
-				       GFP_KERNEL);
-	if (!clk_table)
+	clk_data->clk_data = devm_kzalloc(dev,
+			sizeof(*clk_data->clk_data) + nr_clks * sizeof(clk_data->clk_data->hws[0]),
+			GFP_KERNEL);
+	if (!clk_data->clk_data)
 		return NULL;
 
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
+	clk_data->clk_data->num = nr_clks;
 
 	return clk_data;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_alloc);
 
-struct hisi_clock_data *hisi_clk_init(struct device_node *np,
-					     int nr_clks)
+struct hisi_clock_data *hisi_clk_init(struct device_node *np, int nr_clks)
 {
+	struct platform_device *pdev = of_find_device_by_node(np);
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
-	struct clk **clk_table;
 	void __iomem *base;
 
 	base = of_iomap(np, 0);
 	if (!base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		goto err;
+		return NULL;
 	}
 
-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	clk_data = devm_kmalloc(dev, sizeof(*clk_data), GFP_KERNEL);
 	if (!clk_data)
-		goto err;
+		return NULL;
 
 	clk_data->base = base;
-	clk_table = kcalloc(nr_clks, sizeof(*clk_table), GFP_KERNEL);
-	if (!clk_table)
-		goto err_data;
+	clk_data->clk_data = devm_kzalloc(dev,
+			sizeof(*clk_data->clk_data) + nr_clks * sizeof(clk_data->clk_data->hws[0]),
+			GFP_KERNEL);
+	if (!clk_data->clk_data)
+		return NULL;
 
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
+	clk_data->clk_data->num = nr_clks;
+	devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data->clk_data);
 	return clk_data;
-err_data:
-	kfree(clk_data);
-err:
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
 
-int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
-					 int nums, struct hisi_clock_data *data)
+int hisi_clk_register_fixed_rate(struct device *dev,
+				 const struct hisi_fixed_rate_clock *clks,
+				 int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = clk_register_fixed_rate(NULL, clks[i].name,
-					      clks[i].parent_name,
-					      clks[i].flags,
-					      clks[i].fixed_rate);
+		clk = devm_clk_hw_register_fixed_rate(dev, clks[i].name,
+						      clks[i].parent_name,
+						      clks[i].flags,
+						      clks[i].fixed_rate);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			goto err;
+			return PTR_ERR(clk);
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
-
-err:
-	while (i--)
-		clk_unregister_fixed_rate(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_rate);
 
-int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *clks,
-					   int nums,
-					   struct hisi_clock_data *data)
+int hisi_clk_register_fixed_factor(struct device *dev,
+				   const struct hisi_fixed_factor_clock *clks,
+				   int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = clk_register_fixed_factor(NULL, clks[i].name,
-						clks[i].parent_name,
-						clks[i].flags, clks[i].mult,
-						clks[i].div);
+		clk = devm_clk_hw_register_fixed_factor(dev, clks[i].name,
+							clks[i].parent_name,
+							clks[i].flags, clks[i].mult,
+							clks[i].div);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			goto err;
+			return PTR_ERR(clk);
 		}
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
-
-err:
-	while (i--)
-		clk_unregister_fixed_factor(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_fixed_factor);
 
-int hisi_clk_register_mux(const struct hisi_mux_clock *clks,
-				  int nums, struct hisi_clock_data *data)
+int hisi_clk_register_mux(struct device *dev,
+			  const struct hisi_mux_clock *clks,
+			  int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		u32 mask = BIT(clks[i].width) - 1;
-
-		clk = clk_register_mux_table(NULL, clks[i].name,
-					clks[i].parent_names,
-					clks[i].num_parents, clks[i].flags,
-					base + clks[i].offset, clks[i].shift,
-					mask, clks[i].mux_flags,
-					clks[i].table, &hisi_clk_lock);
+		clk = __devm_clk_hw_register_mux(dev, NULL, clks[i].name,
+						 clks[i].num_parents,
+						 clks[i].parent_names, NULL, NULL,
+						 clks[i].flags,
+						 base + clks[i].offset, clks[i].shift,
+						 BIT(clks[i].width) - 1, clks[i].mux_flags,
+						 clks[i].table, &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			goto err;
+			return PTR_ERR(clk);
 		}
 
 		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
+			clk_hw_register_clkdev(clk, clks[i].alias, NULL);
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
-
-err:
-	while (i--)
-		clk_unregister_mux(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_mux);
 
@@ -190,72 +169,68 @@ int hisi_clk_register_phase(struct device *dev,
 			    int nums, struct hisi_clock_data *data)
 {
 	void __iomem *base = data->base;
-	struct clk *clk;
+	struct clk_hw *clk;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = clk_register_hisi_phase(dev, &clks[i], base,
-					      &hisi_clk_lock);
+		clk = devm_clk_hw_register_hisi_phase(dev, &clks[i], base,
+						      &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 			       clks[i].name);
 			return PTR_ERR(clk);
 		}
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_phase);
 
-int hisi_clk_register_divider(const struct hisi_divider_clock *clks,
-				      int nums, struct hisi_clock_data *data)
+int hisi_clk_register_divider(struct device *dev,
+			      const struct hisi_divider_clock *clks,
+			      int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = clk_register_divider_table(NULL, clks[i].name,
-						 clks[i].parent_name,
-						 clks[i].flags,
-						 base + clks[i].offset,
-						 clks[i].shift, clks[i].width,
-						 clks[i].div_flags,
-						 clks[i].table,
-						 &hisi_clk_lock);
+		clk = devm_clk_hw_register_divider_table(dev, clks[i].name,
+							 clks[i].parent_name,
+							 clks[i].flags,
+							 base + clks[i].offset,
+							 clks[i].shift, clks[i].width,
+							 clks[i].div_flags,
+							 clks[i].table,
+							 &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			goto err;
+			return PTR_ERR(clk);
 		}
 
 		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
+			clk_hw_register_clkdev(clk, clks[i].alias, NULL);
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
-
-err:
-	while (i--)
-		clk_unregister_divider(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_divider);
 
-int hisi_clk_register_gate(const struct hisi_gate_clock *clks,
-				       int nums, struct hisi_clock_data *data)
+int hisi_clk_register_gate(struct device *dev,
+			   const struct hisi_gate_clock *clks,
+			   int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = clk_register_gate(NULL, clks[i].name,
+		clk = devm_clk_hw_register_gate(dev, clks[i].name,
 						clks[i].parent_name,
 						clks[i].flags,
 						base + clks[i].offset,
@@ -265,34 +240,29 @@ int hisi_clk_register_gate(const struct hisi_gate_clock *clks,
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			goto err;
+			return PTR_ERR(clk);
 		}
 
 		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
+			clk_hw_register_clkdev(clk, clks[i].alias, NULL);
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
 
 	return 0;
-
-err:
-	while (i--)
-		clk_unregister_gate(data->clk_data.clks[clks[i].id]);
-
-	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_gate);
 
-void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
-				       int nums, struct hisi_clock_data *data)
+int hisi_clk_register_gate_sep(struct device *dev,
+				const struct hisi_gate_clock *clks,
+				int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = hisi_register_clkgate_sep(NULL, clks[i].name,
+		clk = hisi_register_clkgate_sep(dev, clks[i].name,
 						clks[i].parent_name,
 						clks[i].flags,
 						base + clks[i].offset,
@@ -302,42 +272,47 @@ void hisi_clk_register_gate_sep(const struct hisi_gate_clock *clks,
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(clk);
 		}
 
 		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
+			clk_hw_register_clkdev(clk, clks[i].alias, NULL);
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_clk_register_gate_sep);
 
-void __init hi6220_clk_register_divider(const struct hi6220_divider_clock *clks,
-					int nums, struct hisi_clock_data *data)
+int hi6220_clk_register_divider(struct device *dev,
+				const struct hi6220_divider_clock *clks,
+				int nums, struct hisi_clock_data *data)
 {
-	struct clk *clk;
+	struct clk_hw *clk;
 	void __iomem *base = data->base;
 	int i;
 
 	for (i = 0; i < nums; i++) {
-		clk = hi6220_register_clkdiv(NULL, clks[i].name,
-						clks[i].parent_name,
-						clks[i].flags,
-						base + clks[i].offset,
-						clks[i].shift,
-						clks[i].width,
-						clks[i].mask_bit,
-						&hisi_clk_lock);
+		clk = hi6220_register_clkdiv(dev, clks[i].name,
+					     clks[i].parent_name,
+					     clks[i].flags,
+					     base + clks[i].offset,
+					     clks[i].shift,
+					     clks[i].width,
+					     clks[i].mask_bit,
+					     &hisi_clk_lock);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n",
 			       __func__, clks[i].name);
-			continue;
+			return PTR_ERR(clk);
 		}
 
 		if (clks[i].alias)
-			clk_register_clkdev(clk, clks[i].alias, NULL);
+			clk_hw_register_clkdev(clk, clks[i].alias, NULL);
 
-		data->clk_data.clks[clks[i].id] = clk;
+		data->clk_data->hws[clks[i].id] = clk;
 	}
+
+	return 0;
 }
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 7a9b42e1b..9df5e9bed 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -19,8 +19,8 @@
 struct platform_device;
 
 struct hisi_clock_data {
-	struct clk_onecell_data	clk_data;
-	void __iomem		*base;
+	struct clk_hw_onecell_data	*clk_data;
+	void __iomem			*base;
 };
 
 struct hisi_fixed_rate_clock {
@@ -103,55 +103,44 @@ struct hisi_gate_clock {
 	const char		*alias;
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *, const char *,
-				const char *, unsigned long,
-				void __iomem *, u8,
-				u8, spinlock_t *);
-struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
-	const char *parent_name, unsigned long flags, void __iomem *reg,
-	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
-
-struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
-struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
-int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_mux(const struct hisi_mux_clock *, int,
-				struct hisi_clock_data *);
-struct clk *clk_register_hisi_phase(struct device *dev,
-				const struct hisi_phase_clock *clks,
-				void __iomem *base, spinlock_t *lock);
+struct clk_hw *hisi_register_clkgate_sep(struct device *dev, const char *name,
+					 const char *parent_name,
+					 unsigned long flags,
+					 void __iomem *reg, u8 bit_idx,
+					 u8 clk_gate_flags, spinlock_t *lock);
+struct clk_hw *hi6220_register_clkdiv(struct device *dev, const char *name,
+				      const char *parent_name, unsigned long flags,
+				      void __iomem *reg, u8 shift,
+				      u8 width, u32 mask_bit, spinlock_t *lock);
+
+struct hisi_clock_data *hisi_clk_alloc(struct platform_device *pdev, int nr_clks);
+struct hisi_clock_data *hisi_clk_init(struct device_node *np, int nr_clks);
+int hisi_clk_register_fixed_rate(struct device *dev,
+				 const struct hisi_fixed_rate_clock *clks,
+				 int nums, struct hisi_clock_data *data);
+int hisi_clk_register_fixed_factor(struct device *dev,
+				   const struct hisi_fixed_factor_clock *clks,
+				   int nums, struct hisi_clock_data *data);
+int hisi_clk_register_mux(struct device *dev,
+			  const struct hisi_mux_clock *clks, int nums,
+			  struct hisi_clock_data *data);
+struct clk_hw *devm_clk_hw_register_hisi_phase(struct device *dev,
+					       const struct hisi_phase_clock *clks,
+					       void __iomem *base, spinlock_t *lock);
 int hisi_clk_register_phase(struct device *dev,
-				const struct hisi_phase_clock *clks,
+			    const struct hisi_phase_clock *clks,
+			    int nums, struct hisi_clock_data *data);
+int hisi_clk_register_divider(struct device *dev,
+			      const struct hisi_divider_clock *clks,
+			      int nums, struct hisi_clock_data *data);
+int hisi_clk_register_gate(struct device *dev,
+			   const struct hisi_gate_clock *clks,
+			   int nums, struct hisi_clock_data *data);
+int hisi_clk_register_gate_sep(struct device *dev,
+			       const struct hisi_gate_clock *clks,
+			       int nums, struct hisi_clock_data *data);
+int hi6220_clk_register_divider(struct device *dev,
+				const struct hi6220_divider_clock *clks,
 				int nums, struct hisi_clock_data *data);
-int hisi_clk_register_divider(const struct hisi_divider_clock *,
-				int, struct hisi_clock_data *);
-int hisi_clk_register_gate(const struct hisi_gate_clock *,
-				int, struct hisi_clock_data *);
-void hisi_clk_register_gate_sep(const struct hisi_gate_clock *,
-				int, struct hisi_clock_data *);
-void hi6220_clk_register_divider(const struct hi6220_divider_clock *,
-				int, struct hisi_clock_data *);
-
-#define hisi_clk_unregister(type) \
-static inline \
-void hisi_clk_unregister_##type(const struct hisi_##type##_clock *clks, \
-				int nums, struct hisi_clock_data *data) \
-{ \
-	struct clk **clocks = data->clk_data.clks; \
-	int i; \
-	for (i = 0; i < nums; i++) { \
-		int id = clks[i].id; \
-		if (clocks[id])  \
-			clk_unregister_##type(clocks[id]); \
-	} \
-}
-
-hisi_clk_unregister(fixed_rate)
-hisi_clk_unregister(fixed_factor)
-hisi_clk_unregister(mux)
-hisi_clk_unregister(divider)
-hisi_clk_unregister(gate)
 
 #endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
index 5348bafe6..a8f1b3e51 100644
--- a/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -7,9 +7,9 @@
  * Author: Bintian Wang <bintian.wang@huawei.com>
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
-#include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/spinlock.h>
@@ -97,19 +97,20 @@ static const struct clk_ops hi6220_clkdiv_ops = {
 	.set_rate = hi6220_clkdiv_set_rate,
 };
 
-struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
+struct clk_hw *hi6220_register_clkdiv(struct device *dev, const char *name,
 	const char *parent_name, unsigned long flags, void __iomem *reg,
 	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock)
 {
 	struct hi6220_clk_divider *div;
-	struct clk *clk;
+	struct clk_hw *clk;
 	struct clk_init_data init;
 	struct clk_div_table *table;
 	u32 max_div, min_div;
 	int i;
+	int ret;
 
 	/* allocate the divider */
-	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
 		return ERR_PTR(-ENOMEM);
 
@@ -117,11 +118,9 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 	max_div = div_mask(width) + 1;
 	min_div = 1;
 
-	table = kcalloc(max_div + 1, sizeof(*table), GFP_KERNEL);
-	if (!table) {
-		kfree(div);
+	table = devm_kcalloc(dev, max_div + 1, sizeof(*table), GFP_KERNEL);
+	if (!table)
 		return ERR_PTR(-ENOMEM);
-	}
 
 	for (i = 0; i < max_div; i++) {
 		table[i].div = min_div + i;
@@ -144,11 +143,9 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 	div->table = table;
 
 	/* register the clock */
-	clk = clk_register(dev, &div->hw);
-	if (IS_ERR(clk)) {
-		kfree(table);
-		kfree(div);
-	}
+	ret = devm_clk_hw_register(dev, &div->hw);
+	if (ret)
+		return ERR_PTR(ret);
 
 	return clk;
 }
diff --git a/drivers/clk/hisilicon/clkgate-separated.c b/drivers/clk/hisilicon/clkgate-separated.c
index 90d858522..04bc73925 100644
--- a/drivers/clk/hisilicon/clkgate-separated.c
+++ b/drivers/clk/hisilicon/clkgate-separated.c
@@ -9,10 +9,10 @@
  *	   Xin Li <li.xin@linaro.org>
  */
 
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
-#include <linux/slab.h>
 
 #include "clk.h"
 
@@ -80,17 +80,18 @@ static const struct clk_ops clkgate_separated_ops = {
 	.is_enabled	= clkgate_separated_is_enabled,
 };
 
-struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
+struct clk_hw *hisi_register_clkgate_sep(struct device *dev, const char *name,
 				      const char *parent_name,
 				      unsigned long flags,
 				      void __iomem *reg, u8 bit_idx,
 				      u8 clk_gate_flags, spinlock_t *lock)
 {
 	struct clkgate_separated *sclk;
-	struct clk *clk;
+	struct clk_hw *clk;
 	struct clk_init_data init;
+	int ret;
 
-	sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
+	sclk = devm_kzalloc(dev,  sizeof(*sclk), GFP_KERNEL);
 	if (!sclk)
 		return ERR_PTR(-ENOMEM);
 
@@ -106,8 +107,9 @@ struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
 	sclk->hw.init = &init;
 	sclk->lock = lock;
 
-	clk = clk_register(dev, &sclk->hw);
-	if (IS_ERR(clk))
-		kfree(sclk);
+	ret = devm_clk_hw_register(dev, &sclk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return clk;
 }
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 5d4e61c7a..5f56fb3e5 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -129,6 +129,7 @@ static const struct hisi_gate_clock hi3516cv300_gate_clks[] = {
 static struct hisi_clock_data *hi3516cv300_clk_register(
 		struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
@@ -136,52 +137,31 @@ static struct hisi_clock_data *hi3516cv300_clk_register(
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
-	ret = hisi_clk_register_fixed_rate(hi3516cv300_fixed_rate_clks,
+	ret = hisi_clk_register_fixed_rate(dev, hi3516cv300_fixed_rate_clks,
 			ARRAY_SIZE(hi3516cv300_fixed_rate_clks), clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_mux(hi3516cv300_mux_clks,
+	ret = hisi_clk_register_mux(dev, hi3516cv300_mux_clks,
 			ARRAY_SIZE(hi3516cv300_mux_clks), clk_data);
 	if (ret)
-		goto unregister_fixed_rate;
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_gate(hi3516cv300_gate_clks,
+	ret = hisi_clk_register_gate(dev, hi3516cv300_gate_clks,
 			ARRAY_SIZE(hi3516cv300_gate_clks), clk_data);
 	if (ret)
-		goto unregister_mux;
+		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		return ERR_PTR(ret);
 
 	return clk_data;
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
 }
 
 static void hi3516cv300_clk_unregister(struct platform_device *pdev)
 {
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
 }
 
 static const struct hisi_crg_funcs hi3516cv300_crg_funcs = {
@@ -203,6 +183,7 @@ static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
 static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
 		struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
@@ -210,34 +191,21 @@ static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
-	ret = hisi_clk_register_mux(hi3516cv300_sysctrl_mux_clks,
+	ret = hisi_clk_register_mux(dev, hi3516cv300_sysctrl_mux_clks,
 			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  &clk_data->clk_data);
 	if (ret)
-		goto unregister_mux;
+		return ERR_PTR(ret);
 
 	return clk_data;
-
-unregister_mux:
-	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks), clk_data);
-	return ERR_PTR(ret);
 }
 
 static void hi3516cv300_sysctrl_clk_unregister(struct platform_device *pdev)
 {
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
-			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
-			crg->clk_data);
 }
 
 static const struct hisi_crg_funcs hi3516cv300_sysctrl_funcs = {
diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 778637131..d05151d0e 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -72,6 +72,7 @@ static struct hisi_clock_data *
 hi3798_clk_register(struct platform_device *pdev,
 		    const struct hi3798_clks *clks)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
@@ -80,55 +81,36 @@ hi3798_clk_register(struct platform_device *pdev,
 		return ERR_PTR(-ENOMEM);
 
 	/* hisi_phase_clock is resource managed */
-	ret = hisi_clk_register_phase(&pdev->dev, clks->phase_clks,
+	ret = hisi_clk_register_phase(dev, clks->phase_clks,
 				      clks->phase_clks_nums, clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_fixed_rate(hi3798_fixed_rate_clks,
+	ret = hisi_clk_register_fixed_rate(dev, hi3798_fixed_rate_clks,
 					   ARRAY_SIZE(hi3798_fixed_rate_clks),
 					   clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_mux(clks->mux_clks, clks->mux_clks_nums, clk_data);
+	ret = hisi_clk_register_mux(dev, clks->mux_clks, clks->mux_clks_nums, clk_data);
 	if (ret)
-		goto unregister_fixed_rate;
+		return ERR_PTR(ret);
 
-	ret = hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
+	ret = hisi_clk_register_gate(dev, clks->gate_clks, clks->gate_clks_nums, clk_data);
 	if (ret)
-		goto unregister_mux;
+		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		return ERR_PTR(ret);
 
 	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
-unregister_mux:
-	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, clk_data);
-unregister_fixed_rate:
-	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-				       ARRAY_SIZE(hi3798_fixed_rate_clks),
-				       clk_data);
-	return ERR_PTR(ret);
 }
 
 static void hi3798_clk_unregister(struct platform_device *pdev,
 				  const struct hi3798_clks *clks)
 {
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
-	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, crg->clk_data);
-	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
-				       ARRAY_SIZE(hi3798_fixed_rate_clks),
-				       crg->clk_data);
 }
 
 /* hi3798 sysctrl CRG */
@@ -139,6 +121,7 @@ static struct hisi_clock_data *
 hi3798_sysctrl_clk_register(struct platform_device *pdev,
 			    const struct hi3798_clks *clks)
 {
+	struct device *dev = &pdev->dev;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
@@ -146,30 +129,21 @@ hi3798_sysctrl_clk_register(struct platform_device *pdev,
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
-	ret = hisi_clk_register_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
+	ret = hisi_clk_register_gate(dev, clks->gate_clks, clks->gate_clks_nums, clk_data);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					  clk_data->clk_data);
 	if (ret)
-		goto unregister_gate;
+		return ERR_PTR(ret);
 
 	return clk_data;
-
-unregister_gate:
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, clk_data);
-	return ERR_PTR(ret);
 }
 
 static void hi3798_sysctrl_clk_unregister(struct platform_device *pdev,
 					  const struct hi3798_clks *clks)
 {
-	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(pdev->dev.of_node);
-
-	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
 }
 
 /* hi3798CV200 */
-- 
2.39.2

