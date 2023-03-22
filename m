Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98DC46C5101
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCVQm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCVQmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:42:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8758B6424F;
        Wed, 22 Mar 2023 09:42:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k2so19812090pll.8;
        Wed, 22 Mar 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679503360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3QY51BU06amNE5DXLTj+e6DpKsWv8MVhoGwTNbrWEU=;
        b=h/Wr/kK/YH1YCGwk0L/Mbp0mVuv3hhGI+H1CszjdCt+BzfyoC8Zp5dbJo6fuD9drwL
         DsdiGZObjlc1ij4Gd15BmdkdgIQhNZMF0XXPwKOJim1Zm6UZXxOqrHZuibn3dcZeBI0n
         PTFqzMguyN9TC78ngQiU5Q886XaC73pkUO7U/jbJo4CeRU48+Tr5oelL0CSqwEcPTviL
         59Vniq9GHYiM//ejhbPHUDZo0oFJoOMC3yUzj4fZti3MfPIPKEytseEUaSDdM18UHRee
         lpwSf38QdV5Z2nmKuxjf3qjt262iCuhUirW+1cmQww7XPbJ92hsxYvyaUOoRWVJZyj7g
         7Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3QY51BU06amNE5DXLTj+e6DpKsWv8MVhoGwTNbrWEU=;
        b=0qHgNwVZBzPN58olOnfaV1HS4fg0TvqZC93f6ShrN9/zslUZ+dn6/JyQ9E7y0nRVLx
         ScT76/s3NNhOpHKJ38uo7DgiL2pb3UnSnms75y3wmnHe3/Ugs4sSGxnxZODpUIkCONHZ
         l9DaaWK7KyKT//3CEvCS67vcj3yFZHgJQGrNr5NqsRgy+VzV6n4LdEX39HAHUkP0wsf+
         E8jn1SGsnV/J4pOQMmMNqDT+zy3weMYalsY1kt9nEUTJ/s8D9rk7y6Kf2sfhwrEJ0CJQ
         UFW92OgdTQEGyP97SBkA+gKLpHh9uEaBWZ2NJAozU3ViE+dkKGWHCHfEZ6quTtv3eG0T
         fDVw==
X-Gm-Message-State: AO0yUKUXdi9RB9x+3bVXQK72k+mBfANE+NT2LnOGxkz/qtrZ4vMGhBTn
        F6BLFXTNqm7V2kVRxM+iHcbWO34TkS5gf1eNunU=
X-Google-Smtp-Source: AK7set/FPO3B2DNEXzigEIlb2XVreNnIKLTMsjL+5h1Jm2LPlk6cECiTRvvNh9Ea5sO3sS57+ASKnQ==
X-Received: by 2002:a05:6a20:98a7:b0:d7:47e8:59bd with SMTP id jk39-20020a056a2098a700b000d747e859bdmr112041pzb.60.1679503360551;
        Wed, 22 Mar 2023 09:42:40 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm10300830pfh.193.2023.03.22.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:42:40 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/9] clk: hisilicon: Remove hisi_clk_alloc
Date:   Thu, 23 Mar 2023 00:41:51 +0800
Message-Id: <20230322164201.2454771-4-mmyangfl@gmail.com>
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

During migration to devm APIs, (virtual) fixed-rate clocks were found hard
on devm APIs, since they often depended by crucial peripherals, thus
require early initialization before device probing, and cannot use devm
APIs.

One solution to this problem is to add a "fixed-clock" node to device tree,
independent to clock device, and make those peripherals depend on that.
However, there is also some devices that do use fixed-rate clocks provided
by drivers, for example clk-hi3660.c .

To simplify codes, we migrate clocks of other types to devm APIs, while
keep fixed-rate clocks self-managed, alongside with struct hisi_clock_data,
and remove devm-managed hisi_clock_data.

Patches for devm APIs migration are to follow.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/clk/hisilicon/clk-hi3519.c      | 14 ++++-----
 drivers/clk/hisilicon/clk-hi3559a.c     | 25 ++++++----------
 drivers/clk/hisilicon/clk.c             | 40 +++++--------------------
 drivers/clk/hisilicon/clk.h             |  3 +-
 drivers/clk/hisilicon/crg-hi3516cv300.c | 26 ++++++----------
 drivers/clk/hisilicon/crg-hi3798.c      | 25 ++++++----------
 6 files changed, 43 insertions(+), 90 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f350..556c89037 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -75,10 +75,12 @@ static const struct hisi_gate_clock hi3519_gate_clks[] = {
 
 static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3519_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3519_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -100,11 +102,6 @@ static struct hisi_clock_data *hi3519_clk_register(struct platform_device *pdev)
 	if (ret)
 		goto unregister_mux;
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
 	return clk_data;
 
 unregister_fixed_rate:
@@ -127,8 +124,6 @@ static void hi3519_clk_unregister(struct platform_device *pdev)
 {
 	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_gate(hi3519_gate_clks,
 				ARRAY_SIZE(hi3519_mux_clks),
 				crg->clk_data);
@@ -164,10 +159,13 @@ static int hi3519_clk_probe(struct platform_device *pdev)
 
 static int hi3519_clk_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hi3519_crg_data *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	hi3519_clk_unregister(pdev);
+	hisi_clk_free(np, crg->clk_data);
 	return 0;
 }
 
diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/clk-hi3559a.c
index 8036bd8cb..c3dd018f8 100644
--- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -505,10 +505,12 @@ static void hisi_clk_register_pll(struct hi3559av100_pll_clock *clks,
 static struct hisi_clock_data *hi3559av100_clk_register(
 	struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3559AV100_CRG_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3559AV100_CRG_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -530,11 +532,6 @@ static struct hisi_clock_data *hi3559av100_clk_register(
 	if (ret)
 		goto unregister_mux;
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
 	return clk_data;
 
 unregister_gate:
@@ -553,8 +550,6 @@ static void hi3559av100_clk_unregister(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_gate(hi3559av100_gate_clks,
 				 ARRAY_SIZE(hi3559av100_gate_clks), crg->clk_data);
 	hisi_clk_unregister_mux(hi3559av100_mux_clks_crg,
@@ -699,12 +694,14 @@ static int hi3559av100_shub_default_clk_set(void)
 static struct hisi_clock_data *hi3559av100_shub_clk_register(
 	struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data = NULL;
 	int ret;
 
 	hi3559av100_shub_default_clk_set();
 
-	clk_data = hisi_clk_alloc(pdev, HI3559AV100_SHUB_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3559AV100_SHUB_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -728,11 +725,6 @@ static struct hisi_clock_data *hi3559av100_shub_clk_register(
 	if (ret)
 		goto unregister_factor;
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-				  of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
 	return clk_data;
 
 unregister_gate:
@@ -754,8 +746,6 @@ static void hi3559av100_shub_clk_unregister(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_gate(hi3559av100_shub_gate_clks,
 				 ARRAY_SIZE(hi3559av100_shub_gate_clks), crg->clk_data);
 	hisi_clk_unregister_divider(hi3559av100_shub_div_clks,
@@ -812,10 +802,13 @@ static int hi3559av100_crg_probe(struct platform_device *pdev)
 
 static int hi3559av100_crg_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	crg->funcs->unregister_clks(pdev);
+	hisi_clk_free(np, crg->clk_data);
 	return 0;
 }
 
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index 54d9fdc93..a949be5fa 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -23,38 +23,6 @@
 
 static DEFINE_SPINLOCK(hisi_clk_lock);
 
-struct hisi_clock_data *hisi_clk_alloc(struct platform_device *pdev,
-						int nr_clks)
-{
-	struct hisi_clock_data *clk_data;
-	struct resource *res;
-	struct clk **clk_table;
-
-	clk_data = devm_kmalloc(&pdev->dev, sizeof(*clk_data), GFP_KERNEL);
-	if (!clk_data)
-		return NULL;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return NULL;
-	clk_data->base = devm_ioremap(&pdev->dev,
-				res->start, resource_size(res));
-	if (!clk_data->base)
-		return NULL;
-
-	clk_table = devm_kmalloc_array(&pdev->dev, nr_clks,
-				       sizeof(*clk_table),
-				       GFP_KERNEL);
-	if (!clk_table)
-		return NULL;
-
-	clk_data->clk_data.clks = clk_table;
-	clk_data->clk_data.clk_num = nr_clks;
-
-	return clk_data;
-}
-EXPORT_SYMBOL_GPL(hisi_clk_alloc);
-
 struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 					     int nr_clks)
 {
@@ -88,6 +56,14 @@ struct hisi_clock_data *hisi_clk_init(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(hisi_clk_init);
 
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data)
+{
+	of_clk_del_provider(np);
+	kfree(data->clk_data.clks);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(hisi_clk_free);
+
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *clks,
 					 int nums, struct hisi_clock_data *data)
 {
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 7a9b42e1b..30b6d4405 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -111,8 +111,9 @@ struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
 	const char *parent_name, unsigned long flags, void __iomem *reg,
 	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
 
-struct hisi_clock_data *hisi_clk_alloc(struct platform_device *, int);
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
+void hisi_clk_free(struct device_node *np, struct hisi_clock_data *data);
+
 int hisi_clk_register_fixed_rate(const struct hisi_fixed_rate_clock *,
 				int, struct hisi_clock_data *);
 int hisi_clk_register_fixed_factor(const struct hisi_fixed_factor_clock *,
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 5d4e61c7a..6c756680d 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -129,10 +129,12 @@ static const struct hisi_gate_clock hi3516cv300_gate_clks[] = {
 static struct hisi_clock_data *hi3516cv300_clk_register(
 		struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3516CV300_CRG_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3516CV300_CRG_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -151,11 +153,6 @@ static struct hisi_clock_data *hi3516cv300_clk_register(
 	if (ret)
 		goto unregister_mux;
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
 	return clk_data;
 
 unregister_gate:
@@ -174,8 +171,6 @@ static void hi3516cv300_clk_unregister(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_gate(hi3516cv300_gate_clks,
 			ARRAY_SIZE(hi3516cv300_gate_clks), crg->clk_data);
 	hisi_clk_unregister_mux(hi3516cv300_mux_clks,
@@ -203,10 +198,12 @@ static const struct hisi_mux_clock hi3516cv300_sysctrl_mux_clks[] = {
 static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
 		struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3516CV300_SYSCTRL_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3516CV300_SYSCTRL_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -215,12 +212,6 @@ static struct hisi_clock_data *hi3516cv300_sysctrl_clk_register(
 	if (ret)
 		return ERR_PTR(ret);
 
-
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_mux;
-
 	return clk_data;
 
 unregister_mux:
@@ -233,8 +224,6 @@ static void hi3516cv300_sysctrl_clk_unregister(struct platform_device *pdev)
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_mux(hi3516cv300_sysctrl_mux_clks,
 			ARRAY_SIZE(hi3516cv300_sysctrl_mux_clks),
 			crg->clk_data);
@@ -286,10 +275,13 @@ static int hi3516cv300_crg_probe(struct platform_device *pdev)
 
 static int hi3516cv300_crg_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	crg->funcs->unregister_clks(pdev);
+	hisi_clk_free(np, crg->clk_data);
 	return 0;
 }
 
diff --git a/drivers/clk/hisilicon/crg-hi3798.c b/drivers/clk/hisilicon/crg-hi3798.c
index 778637131..fad1a2fba 100644
--- a/drivers/clk/hisilicon/crg-hi3798.c
+++ b/drivers/clk/hisilicon/crg-hi3798.c
@@ -72,10 +72,12 @@ static struct hisi_clock_data *
 hi3798_clk_register(struct platform_device *pdev,
 		    const struct hi3798_clks *clks)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3798_CRG_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3798_CRG_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -99,11 +101,6 @@ hi3798_clk_register(struct platform_device *pdev,
 	if (ret)
 		goto unregister_mux;
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
 	return clk_data;
 
 unregister_gate:
@@ -122,8 +119,6 @@ static void hi3798_clk_unregister(struct platform_device *pdev,
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
 	hisi_clk_unregister_mux(clks->mux_clks, clks->mux_clks_nums, crg->clk_data);
 	hisi_clk_unregister_fixed_rate(hi3798_fixed_rate_clks,
@@ -139,10 +134,12 @@ static struct hisi_clock_data *
 hi3798_sysctrl_clk_register(struct platform_device *pdev,
 			    const struct hi3798_clks *clks)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_clock_data *clk_data;
 	int ret;
 
-	clk_data = hisi_clk_alloc(pdev, HI3798_SYSCTRL_NR_CLKS);
+	clk_data = hisi_clk_init(np, HI3798_SYSCTRL_NR_CLKS);
 	if (!clk_data)
 		return ERR_PTR(-ENOMEM);
 
@@ -150,11 +147,6 @@ hi3798_sysctrl_clk_register(struct platform_device *pdev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	ret = of_clk_add_provider(pdev->dev.of_node,
-			of_clk_src_onecell_get, &clk_data->clk_data);
-	if (ret)
-		goto unregister_gate;
-
 	return clk_data;
 
 unregister_gate:
@@ -167,8 +159,6 @@ static void hi3798_sysctrl_clk_unregister(struct platform_device *pdev,
 {
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
-	of_clk_del_provider(pdev->dev.of_node);
-
 	hisi_clk_unregister_gate(clks->gate_clks, clks->gate_clks_nums, crg->clk_data);
 }
 
@@ -401,10 +391,13 @@ static int hi3798_crg_probe(struct platform_device *pdev)
 
 static int hi3798_crg_remove(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct hisi_crg_dev *crg = platform_get_drvdata(pdev);
 
 	hisi_reset_exit(crg->rstc);
 	crg->funcs->unregister_clks(pdev);
+	hisi_clk_free(np, crg->clk_data);
 	return 0;
 }
 
-- 
2.39.2

