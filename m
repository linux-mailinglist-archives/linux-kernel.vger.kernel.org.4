Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906D26E41C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjDQH4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDQH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:56:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E02130C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:56:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a7ac89b82dso11658411fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681718158; x=1684310158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6f6IBkBIt739+E7WXx4zldQTdeT9xMqDgSUi25Hzr98=;
        b=iJ+BuNWG3vRAUZE+T7vEdn54sf368+DJrKBVNkZ2JD+z18ddB1/dgIt5S8eAzQPi4C
         EpEKGm34ztxZ6UmFEZHxUdBMa/bVCa9w84JR3BpSCUh1wfrJJ80NZWkGKWNJkhlKFVTa
         YI6qveLXqUu9OhmJCPpnfEn0ItnzC+iJWoVI8R0XQpAgiYdS2LSenrHnvU3JvxW7p4mj
         2hJR2AeiA32X6hDX0b5Q3ALrFWjBerlapF54w+o03EcFo/wYDI5ehd1kDvbhLRdqegVb
         0TNf8PxiUVkOH+fJGMnHSIYZ3EM9mW210qqPJDQAQ+REw61Sb4r26uON2GbvE+39Hxcz
         IpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718158; x=1684310158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6f6IBkBIt739+E7WXx4zldQTdeT9xMqDgSUi25Hzr98=;
        b=FYK6hfFD17SYkvgcOLizCRA0NLw2E+9YAUD7UfUNKcEdY+eAxxogX/mRUAu9omi4kd
         qIjct7n0ykYEcRJSQIgJyHjXOzUfInNtbWl5sGKAgt7H3L4hnbKLkNRSlNjSO7Vif8k9
         axjdRPapn0uQds6mqm9njs92Kk9tBvhXKhjJpxD0X0nBi0V4mQ6Wl4AorY1lh9Eqlb/L
         j1uO1g0mYapKWsc/M5ONc6Wlde1Aqj8ttHNSrPAHhxqZm6CV7OhtrJ3xFnVqXztOatWD
         nEJHuDll1sG+8HjmoKVwDqO77tIlYnJr8FdLTTs/gGlcFgWv/Xpob54I3+XcM53T2cAZ
         72lA==
X-Gm-Message-State: AAQBX9eZHHDv0KbHYBpeCLa091sDzKbJ5FUEiJOjLSjWCh8WgHaE4chQ
        fxz14716amcP3YsWAG6KIw4m4A==
X-Google-Smtp-Source: AKy350ZReBtvGSADhwf4Gq88llq9bm0MreBu/SXYNYCghuMTThVr5UWog7ASHWBdyCAr0lib67tAHg==
X-Received: by 2002:ac2:4908:0:b0:4b5:7a91:70f5 with SMTP id n8-20020ac24908000000b004b57a9170f5mr1709749lfi.63.1681718158531;
        Mon, 17 Apr 2023 00:55:58 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id p2-20020a19f002000000b004eb274b3a43sm1952547lfc.134.2023.04.17.00.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:55:58 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 09:55:51 +0200
Subject: [PATCH 6/7] dmaengine: ste_dma40: Use managed resources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v1-6-b26324956e47@linaro.org>
References: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v1-0-b26324956e47@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the DMA40 driver to use a bunch of managed
resources and strip down the errorpath.

The result is pretty neat and makes the driver way more
readable.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 180 ++++++++++++++++--------------------------------
 1 file changed, 61 insertions(+), 119 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index fe98f12b8130..c5991009d3e4 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -554,8 +554,6 @@ struct d40_gen_dmac {
  * @virtbase: The virtual base address of the DMA's register.
  * @rev: silicon revision detected.
  * @clk: Pointer to the DMA clock structure.
- * @phy_start: Physical memory start of the DMA registers.
- * @phy_size: Size of the DMA register map.
  * @irq: The IRQ number.
  * @num_memcpy_chans: The number of channels used for memcpy (mem-to-mem
  * transfers).
@@ -599,8 +597,6 @@ struct d40_base {
 	void __iomem			 *virtbase;
 	u8				  rev:4;
 	struct clk			 *clk;
-	phys_addr_t			  phy_start;
-	resource_size_t			  phy_size;
 	int				  irq;
 	int				  num_memcpy_chans;
 	int				  num_phy_chans;
@@ -3128,65 +3124,58 @@ static int __init d40_phy_res_init(struct d40_base *base)
 	return num_phy_chans_avail;
 }
 
+/* Called from the registered devm action */
+static void d40_drop_kmem_cache_action(void *d)
+{
+	struct kmem_cache *desc_slab = d;
+
+	kmem_cache_destroy(desc_slab);
+}
+
 static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 {
 	struct stedma40_platform_data *plat_data = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	void __iomem *virtbase;
-	struct resource *res;
 	struct d40_base *base;
 	int num_log_chans;
 	int num_phy_chans;
 	int num_memcpy_chans;
-	int clk_ret = -EINVAL;
 	int i;
 	u32 pid;
 	u32 cid;
 	u8 rev;
+	int ret;
 
-	clk = clk_get(dev, NULL);
-	if (IS_ERR(clk)) {
-		d40_err(dev, "No matching clock found\n");
-		goto check_prepare_enabled;
-	}
-
-	clk_ret = clk_prepare_enable(clk);
-	if (clk_ret) {
-		d40_err(dev, "Failed to prepare/enable clock\n");
-		goto disable_unprepare;
-	}
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return NULL;
 
 	/* Get IO for DMAC base address */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "base");
-	if (!res)
-		goto disable_unprepare;
-
-	if (request_mem_region(res->start, resource_size(res),
-			       D40_NAME " I/O base") == NULL)
-		goto release_region;
-
-	virtbase = ioremap(res->start, resource_size(res));
-	if (!virtbase)
-		goto release_region;
+	virtbase = devm_platform_ioremap_resource_byname(pdev, "base");
+	if (IS_ERR(virtbase)) {
+		dev_err(dev, "No IO base defined\n");
+		return NULL;
+	}
 
 	/* This is just a regular AMBA PrimeCell ID actually */
 	for (pid = 0, i = 0; i < 4; i++)
-		pid |= (readl(virtbase + resource_size(res) - 0x20 + 4 * i)
+		pid |= (readl(virtbase + SZ_4K - 0x20 + 4 * i)
 			& 255) << (i * 8);
 	for (cid = 0, i = 0; i < 4; i++)
-		cid |= (readl(virtbase + resource_size(res) - 0x10 + 4 * i)
+		cid |= (readl(virtbase + SZ_4K - 0x10 + 4 * i)
 			& 255) << (i * 8);
 
 	if (cid != AMBA_CID) {
 		d40_err(dev, "Unknown hardware! No PrimeCell ID\n");
-		goto unmap_io;
+		return NULL;
 	}
 	if (AMBA_MANF_BITS(pid) != AMBA_VENDOR_ST) {
 		d40_err(dev, "Unknown designer! Got %x wanted %x\n",
 			AMBA_MANF_BITS(pid),
 			AMBA_VENDOR_ST);
-		goto unmap_io;
+		return NULL;
 	}
 	/*
 	 * HW revision:
@@ -3200,7 +3189,7 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	rev = AMBA_REV_BITS(pid);
 	if (rev < 2) {
 		d40_err(dev, "hardware revision: %d is not supported", rev);
-		goto unmap_io;
+		return NULL;
 	}
 
 	/* The number of physical channels on this HW */
@@ -3218,23 +3207,22 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 	num_log_chans = num_phy_chans * D40_MAX_LOG_CHAN_PER_PHY;
 
 	dev_info(dev,
-		 "hardware rev: %d @ %pa with %d physical and %d logical channels\n",
-		 rev, &res->start, num_phy_chans, num_log_chans);
+		 "hardware rev: %d with %d physical and %d logical channels\n",
+		 rev, num_phy_chans, num_log_chans);
 
-	base = kzalloc(ALIGN(sizeof(struct d40_base), 4) +
-		       (num_phy_chans + num_log_chans + num_memcpy_chans) *
-		       sizeof(struct d40_chan), GFP_KERNEL);
+	base = devm_kzalloc(dev,
+		ALIGN(sizeof(struct d40_base), 4) +
+		(num_phy_chans + num_log_chans + num_memcpy_chans) *
+		sizeof(struct d40_chan), GFP_KERNEL);
 
-	if (base == NULL)
-		goto unmap_io;
+	if (!base)
+		return NULL;
 
 	base->rev = rev;
 	base->clk = clk;
 	base->num_memcpy_chans = num_memcpy_chans;
 	base->num_phy_chans = num_phy_chans;
 	base->num_log_chans = num_log_chans;
-	base->phy_start = res->start;
-	base->phy_size = resource_size(res);
 	base->virtbase = virtbase;
 	base->plat_data = plat_data;
 	base->dev = dev;
@@ -3271,76 +3259,55 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		base->gen_dmac.init_reg_size = ARRAY_SIZE(dma_init_reg_v4a);
 	}
 
-	base->phy_res = kcalloc(num_phy_chans,
-				sizeof(*base->phy_res),
-				GFP_KERNEL);
+	base->phy_res = devm_kcalloc(dev, num_phy_chans,
+				     sizeof(*base->phy_res),
+				     GFP_KERNEL);
 	if (!base->phy_res)
-		goto free_base;
+		return NULL;
 
-	base->lookup_phy_chans = kcalloc(num_phy_chans,
-					 sizeof(*base->lookup_phy_chans),
-					 GFP_KERNEL);
+	base->lookup_phy_chans = devm_kcalloc(dev, num_phy_chans,
+					      sizeof(*base->lookup_phy_chans),
+					      GFP_KERNEL);
 	if (!base->lookup_phy_chans)
-		goto free_phy_res;
+		return NULL;
 
-	base->lookup_log_chans = kcalloc(num_log_chans,
-					 sizeof(*base->lookup_log_chans),
-					 GFP_KERNEL);
+	base->lookup_log_chans = devm_kcalloc(dev, num_log_chans,
+					      sizeof(*base->lookup_log_chans),
+					      GFP_KERNEL);
 	if (!base->lookup_log_chans)
-		goto free_phy_chans;
+		return NULL;
 
-	base->reg_val_backup_chan = kmalloc_array(base->num_phy_chans,
+	base->reg_val_backup_chan = devm_kmalloc_array(dev, base->num_phy_chans,
 						  sizeof(d40_backup_regs_chan),
 						  GFP_KERNEL);
 	if (!base->reg_val_backup_chan)
-		goto free_log_chans;
+		return NULL;
 
-	base->lcla_pool.alloc_map = kcalloc(num_phy_chans
+	base->lcla_pool.alloc_map = devm_kcalloc(dev, num_phy_chans
 					    * D40_LCLA_LINK_PER_EVENT_GRP,
 					    sizeof(*base->lcla_pool.alloc_map),
 					    GFP_KERNEL);
 	if (!base->lcla_pool.alloc_map)
-		goto free_backup_chan;
+		return NULL;
 
-	base->regs_interrupt = kmalloc_array(base->gen_dmac.il_size,
+	base->regs_interrupt = devm_kmalloc_array(dev, base->gen_dmac.il_size,
 					     sizeof(*base->regs_interrupt),
 					     GFP_KERNEL);
 	if (!base->regs_interrupt)
-		goto free_map;
+		return NULL;
 
 	base->desc_slab = kmem_cache_create(D40_NAME, sizeof(struct d40_desc),
 					    0, SLAB_HWCACHE_ALIGN,
 					    NULL);
-	if (base->desc_slab == NULL)
-		goto free_regs;
+	if (!base->desc_slab)
+		return NULL;
 
+	ret = devm_add_action_or_reset(dev, d40_drop_kmem_cache_action,
+				       base->desc_slab);
+	if (ret)
+		return NULL;
 
 	return base;
- free_regs:
-	kfree(base->regs_interrupt);
- free_map:
-	kfree(base->lcla_pool.alloc_map);
- free_backup_chan:
-	kfree(base->reg_val_backup_chan);
- free_log_chans:
-	kfree(base->lookup_log_chans);
- free_phy_chans:
-	kfree(base->lookup_phy_chans);
- free_phy_res:
-	kfree(base->phy_res);
- free_base:
-	kfree(base);
- unmap_io:
-	iounmap(virtbase);
- release_region:
-	release_mem_region(res->start, resource_size(res));
- check_prepare_enabled:
-	if (!clk_ret)
- disable_unprepare:
-		clk_disable_unprepare(clk);
-	if (!IS_ERR(clk))
-		clk_put(clk);
-	return NULL;
 }
 
 static void __init d40_hw_init(struct d40_base *base)
@@ -3585,11 +3552,11 @@ static int __init d40_probe(struct platform_device *pdev)
 	} else
 		writel(base->phy_lcpa, base->virtbase + D40_DREG_LCPA);
 
-	base->lcpa_base = ioremap(base->phy_lcpa, base->lcpa_size);
+	base->lcpa_base = devm_ioremap(dev, base->phy_lcpa, base->lcpa_size);
 	if (!base->lcpa_base) {
 		ret = -ENOMEM;
 		d40_err(dev, "Failed to ioremap LCPA region\n");
-		goto release_base;
+		goto report_failure;
 	}
 	/* If lcla has to be located in ESRAM we don't need to allocate */
 	if (base->plat_data->use_esram_lcla) {
@@ -3599,14 +3566,14 @@ static int __init d40_probe(struct platform_device *pdev)
 			ret = -ENOENT;
 			d40_err(dev,
 				"No \"lcla_esram\" memory resource\n");
-			goto destroy_cache;
+			goto report_failure;
 		}
-		base->lcla_pool.base = ioremap(res->start,
-						resource_size(res));
+		base->lcla_pool.base = devm_ioremap(dev, res->start,
+						    resource_size(res));
 		if (!base->lcla_pool.base) {
 			ret = -ENOMEM;
 			d40_err(dev, "Failed to ioremap LCLA region\n");
-			goto destroy_cache;
+			goto report_failure;
 		}
 		writel(res->start, base->virtbase + D40_DREG_LCLA);
 
@@ -3678,16 +3645,8 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	dev_info(base->dev, "initialized\n");
 	return 0;
- destroy_cache:
-	kmem_cache_destroy(base->desc_slab);
-	if (base->virtbase)
-		iounmap(base->virtbase);
-
-	if (base->lcla_pool.base && base->plat_data->use_esram_lcla) {
-		iounmap(base->lcla_pool.base);
-		base->lcla_pool.base = NULL;
-	}
 
+ destroy_cache:
 	if (base->lcla_pool.dma_addr)
 		dma_unmap_single(base->dev, base->lcla_pool.dma_addr,
 				 SZ_1K * base->num_phy_chans,
@@ -3699,28 +3658,11 @@ static int __init d40_probe(struct platform_device *pdev)
 
 	kfree(base->lcla_pool.base_unaligned);
 
-	if (base->lcpa_base)
-		iounmap(base->lcpa_base);
-
-release_base:
-	if (base->phy_start)
-		release_mem_region(base->phy_start,
-				   base->phy_size);
-	if (base->clk) {
-		clk_disable_unprepare(base->clk);
-		clk_put(base->clk);
-	}
-
 	if (base->lcpa_regulator) {
 		regulator_disable(base->lcpa_regulator);
 		regulator_put(base->lcpa_regulator);
 	}
 
-	kfree(base->lcla_pool.alloc_map);
-	kfree(base->lookup_log_chans);
-	kfree(base->lookup_phy_chans);
-	kfree(base->phy_res);
-	kfree(base);
  report_failure:
 	d40_err(dev, "probe failed\n");
 	return ret;

-- 
2.39.2

