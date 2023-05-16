Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A287704E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbjEPM4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbjEPM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:56:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DED74C3C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:55:46 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac7de2b72fso153276831fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241741; x=1686833741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVQkPRqRwG5xBfBm9IYhXXbdgn9DcrnRu4p8iX6QF0c=;
        b=IyMHltUlP9uKObnRhXsIyR5xuvuy5bjKsO1TBpsgEY0lojsUh6azozyNnSwoqRDWgZ
         Gn8vJavea3cp8JfBWPWuaTPwvTQy/F2fa3VEUu6XXxJpOhZj6RBsqNtJynV9+Mf4pDY0
         OBsSQ6/2CyfHkwAlJFgBaGhlWOLk1dmsACou6FFkIX90DCvG6gjXXjg888ssICey6CZX
         Gw3UjaqfFgr/g/oJxHYAGhekljVkZUgwHhB5b122Lp7GbHvgRnmtUb5eptJzX4S+g8Dz
         KB42QhcGnkjbEYhaFvz8YXR20ggRESG8cnBpztR//BQCIaoAlLvdgHjlzGql61lrW+uR
         3LAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241741; x=1686833741;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVQkPRqRwG5xBfBm9IYhXXbdgn9DcrnRu4p8iX6QF0c=;
        b=j+EcgXXIL7u8lhxz7MTplh7FDDkq9u9qLZMQIyES+omWUaoNgQjwmcXT9wF+NkplF5
         QiVfCRp268NIQ9zr3dWQSfC9bD8UVsBWXf7TXNXG5Tbmtlx4AJUeVTuxsRoCwJ+tEDBo
         nYRLaRa/9l8P5p7npxcHZFcaqIG8nqa/Tp5c9K/LZd8Xe4zxOJjY166jh18c53Zr05Ky
         kwz6/6+WdTFYkVq3edxzRRjbRotvxcvS+muEYaaE7yrOTFoqNbrU8nkgi+rw+ChwD3KN
         hPvLNLTmfWhflLoDianL5vzbTpgB2yJ3dHFCOKFcUzSnOuD+lnwq5lSHiqeRptpYQjv1
         07Ew==
X-Gm-Message-State: AC+VfDwjRN6h0t8OtexooSuXCujmrYTOlV1Si0pSEhwm73V2jNGxH4Tl
        xo1GhjWpNIv6NArUm6BgehnCEg==
X-Google-Smtp-Source: ACHHUZ7RhEWIXLYECAhT2ZQwH8jf4ikc6qKU6EfvQP9IF9TiXwnukvQW7I4p7F6775X3q8QBbqKciQ==
X-Received: by 2002:a2e:80c6:0:b0:2a6:2444:9892 with SMTP id r6-20020a2e80c6000000b002a624449892mr8100808ljg.25.1684241741373;
        Tue, 16 May 2023 05:55:41 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:40 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:55:32 +0200
Subject: [PATCH v3 2/7] dmaengine: ste_dma40: Get LCPA SRAM from SRAM node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v3-2-60bfa6785968@linaro.org>
References: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing the reserved SRAM as a "reg" field
look for a phandle to the LCPA SRAM memory so we can
use the proper SRAM device tree bindings for the SRAM.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/Kconfig     |  1 +
 drivers/dma/ste_dma40.c | 47 ++++++++++++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f5f422f9b850..644c188d6a11 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -553,6 +553,7 @@ config STE_DMA40
 	bool "ST-Ericsson DMA40 support"
 	depends on ARCH_U8500
 	select DMA_ENGINE
+	select SRAM
 	help
 	  Support for ST-Ericsson DMA40 controller
 
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index f093e08c23b1..7890ccae61f9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -19,6 +19,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_dma.h>
 #include <linux/amba/bus.h>
 #include <linux/regulator/consumer.h>
@@ -3506,9 +3507,11 @@ static int __init d40_probe(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np_lcpa;
 	int ret = -ENOENT;
 	struct d40_base *base;
 	struct resource *res;
+	struct resource res_lcpa;
 	int num_reserved_chans;
 	u32 val;
 
@@ -3535,37 +3538,37 @@ static int __init d40_probe(struct platform_device *pdev)
 	spin_lock_init(&base->interrupt_lock);
 	spin_lock_init(&base->execmd_lock);
 
-	/* Get IO for logical channel parameter address */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lcpa");
-	if (!res) {
-		ret = -ENOENT;
-		d40_err(&pdev->dev, "No \"lcpa\" memory resource\n");
-		goto destroy_cache;
+	/* Get IO for logical channel parameter address (LCPA) */
+	np_lcpa = of_parse_phandle(np, "sram", 0);
+	if (!np_lcpa) {
+		dev_err(&pdev->dev, "no LCPA SRAM node\n");
+		goto report_failure;
 	}
-	base->lcpa_size = resource_size(res);
-	base->phy_lcpa = res->start;
-
-	if (request_mem_region(res->start, resource_size(res),
-			       D40_NAME " I/O lcpa") == NULL) {
-		ret = -EBUSY;
-		d40_err(&pdev->dev, "Failed to request LCPA region %pR\n", res);
-		goto destroy_cache;
+	/* This is no device so read the address directly from the node */
+	ret = of_address_to_resource(np_lcpa, 0, &res_lcpa);
+	if (ret) {
+		dev_err(&pdev->dev, "no LCPA SRAM resource\n");
+		goto report_failure;
 	}
+	base->lcpa_size = resource_size(&res_lcpa);
+	base->phy_lcpa = res_lcpa.start;
+	dev_info(&pdev->dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
+		 (u32)base->phy_lcpa, base->lcpa_size);
 
 	/* We make use of ESRAM memory for this. */
 	val = readl(base->virtbase + D40_DREG_LCPA);
-	if (res->start != val && val != 0) {
+	if (base->phy_lcpa != val && val != 0) {
 		dev_warn(&pdev->dev,
-			 "[%s] Mismatch LCPA dma 0x%x, def %pa\n",
-			 __func__, val, &res->start);
+			 "[%s] Mismatch LCPA dma 0x%x, def %08x\n",
+			 __func__, val, (u32)base->phy_lcpa);
 	} else
-		writel(res->start, base->virtbase + D40_DREG_LCPA);
+		writel(base->phy_lcpa, base->virtbase + D40_DREG_LCPA);
 
-	base->lcpa_base = ioremap(res->start, resource_size(res));
+	base->lcpa_base = ioremap(base->phy_lcpa, base->lcpa_size);
 	if (!base->lcpa_base) {
 		ret = -ENOMEM;
 		d40_err(&pdev->dev, "Failed to ioremap LCPA region\n");
-		goto destroy_cache;
+		goto release_base;
 	}
 	/* If lcla has to be located in ESRAM we don't need to allocate */
 	if (base->plat_data->use_esram_lcla) {
@@ -3678,9 +3681,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	if (base->lcpa_base)
 		iounmap(base->lcpa_base);
 
-	if (base->phy_lcpa)
-		release_mem_region(base->phy_lcpa,
-				   base->lcpa_size);
+release_base:
 	if (base->phy_start)
 		release_mem_region(base->phy_start,
 				   base->phy_size);

-- 
2.40.1

