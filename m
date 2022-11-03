Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB0D6188FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiKCTwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiKCTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:52:06 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226620364
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:52:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y14so8137735ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AClRHYQmmiljK9Z1RfiVXUSaeI4B4a5JMw83y2hLjc=;
        b=I+yQTuz7Ehdp6gLmvTSiRfW8d7safqQgm6xFo5ffNjn2ymI6ele5uztQfdKB4w4of1
         yrdAXb+n5lMSvHrXuRCJOJd+gH8sXRbJpxlOgvSiFHqDtwIDsxml9RVmYOg+GFT8gTrS
         YTmIBlFiJlnYK8RaSHjXa6bKk3jKG0F1eTZEaQDfUMHldgm3Tt2pxx8HelUqTLOmRBbA
         uqONeXXZErQ2pmSgLWy+3iRhMLG+GvxowruU7JdfgPlA7i5d3zK1FlR146IqWScRjSN8
         Si36SZHhp0LSKvd4jiiwjucmqr3vgbhiGYOGK+03e6QnliPU18z+4wy1nkIopXZtEI/O
         05eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9AClRHYQmmiljK9Z1RfiVXUSaeI4B4a5JMw83y2hLjc=;
        b=Sw4Cf0cu1tDugGB8S8k7uDANATgg0yKtD3Ek7C/mkqdBbisYbdqlv4TmfYcTI+x4mQ
         l2KAUx3KSwDMafT+3X2xwJ7+8js50ZWowRPlw+VZ/Z8pPN7z+VQlXTsO802XrLWJ0Ffn
         2yEtE7jZZ1jMdicUy0G0X4+4rfni008I88TVUA72htYC5eXpDfHRtnbTt5C5VpWhKVSb
         EGsLayoBr02/daUCehWRhefDqTlVDi7XVXuULG9Xx3xj++rEs0eAgoopJqAncQiikpPN
         RxrmcCw6mm6b0ICQnWBMW/zVfMp+Q4OFGhb8nBO7IflHERssvX7LKCDzmPDEUFZ9AMCp
         DJpA==
X-Gm-Message-State: ACrzQf34sJ+qmrIeQzEkOEWmNkEbYPj1uvl4j+/QSAydfAkzC8hflCbL
        S4YiTuEN33QZM9s4/E6wISKAEg==
X-Google-Smtp-Source: AMsMyM6J5RCvHZ4nfAKpAsy44oTqJ0eAdadZ1UgP4V2W93kLu/WbhZUuA/LB4sy2MA3T1iCYEwidFA==
X-Received: by 2002:a17:907:3f26:b0:78d:9c30:4529 with SMTP id hq38-20020a1709073f2600b0078d9c304529mr30510256ejc.195.1667505124242;
        Thu, 03 Nov 2022 12:52:04 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id br26-20020a170906d15a00b0072af4af2f46sm872441ejb.74.2022.11.03.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:52:03 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 5/6] iommu/exynos: Rearrange the platform driver code
Date:   Thu,  3 Nov 2022 20:51:53 +0100
Message-Id: <20221103195154.21495-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221103195154.21495-1-semen.protsenko@linaro.org>
References: <20221103195154.21495-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the platform_driver code to the bottom of the driver, as it's a
canonical form for that. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Fixed checkpatch style suggestion with "--strict" flag

 drivers/iommu/exynos-iommu.c | 361 +++++++++++++++++------------------
 1 file changed, 180 insertions(+), 181 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index cd3f74e638f0..c995cf8294cf 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -641,187 +641,6 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static const struct iommu_ops exynos_iommu_ops;
-
-static int exynos_sysmmu_probe(struct platform_device *pdev)
-{
-	int irq, ret;
-	struct device *dev = &pdev->dev;
-	struct sysmmu_drvdata *data;
-	struct resource *res;
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->sfrbase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->sfrbase))
-		return PTR_ERR(data->sfrbase);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq;
-
-	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
-				dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
-		return ret;
-	}
-
-	data->clk = devm_clk_get(dev, "sysmmu");
-	if (PTR_ERR(data->clk) == -ENOENT)
-		data->clk = NULL;
-	else if (IS_ERR(data->clk))
-		return PTR_ERR(data->clk);
-
-	data->aclk = devm_clk_get(dev, "aclk");
-	if (PTR_ERR(data->aclk) == -ENOENT)
-		data->aclk = NULL;
-	else if (IS_ERR(data->aclk))
-		return PTR_ERR(data->aclk);
-
-	data->pclk = devm_clk_get(dev, "pclk");
-	if (PTR_ERR(data->pclk) == -ENOENT)
-		data->pclk = NULL;
-	else if (IS_ERR(data->pclk))
-		return PTR_ERR(data->pclk);
-
-	if (!data->clk && (!data->aclk || !data->pclk)) {
-		dev_err(dev, "Failed to get device clock(s)!\n");
-		return -ENOENT;
-	}
-
-	data->clk_master = devm_clk_get(dev, "master");
-	if (PTR_ERR(data->clk_master) == -ENOENT)
-		data->clk_master = NULL;
-	else if (IS_ERR(data->clk_master))
-		return PTR_ERR(data->clk_master);
-
-	data->sysmmu = dev;
-	spin_lock_init(&data->lock);
-
-	__sysmmu_get_version(data);
-
-	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
-				     dev_name(data->sysmmu));
-	if (ret)
-		return ret;
-
-	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
-	if (ret)
-		goto err_iommu_register;
-
-	platform_set_drvdata(pdev, data);
-
-	if (PG_ENT_SHIFT < 0) {
-		if (MMU_MAJ_VER(data->version) < 5) {
-			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
-			LV1_PROT = SYSMMU_LV1_PROT;
-			LV2_PROT = SYSMMU_LV2_PROT;
-		} else {
-			PG_ENT_SHIFT = SYSMMU_V5_PG_ENT_SHIFT;
-			LV1_PROT = SYSMMU_V5_LV1_PROT;
-			LV2_PROT = SYSMMU_V5_LV2_PROT;
-		}
-	}
-
-	if (MMU_MAJ_VER(data->version) >= 5) {
-		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
-		if (ret) {
-			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
-			goto err_dma_set_mask;
-		}
-	}
-
-	/*
-	 * use the first registered sysmmu device for performing
-	 * dma mapping operations on iommu page tables (cpu cache flush)
-	 */
-	if (!dma_dev)
-		dma_dev = &pdev->dev;
-
-	pm_runtime_enable(dev);
-
-	return 0;
-
-err_dma_set_mask:
-	iommu_device_unregister(&data->iommu);
-err_iommu_register:
-	iommu_device_sysfs_remove(&data->iommu);
-	return ret;
-}
-
-static void exynos_sysmmu_shutdown(struct platform_device *pdev)
-{
-	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
-	int irq = platform_get_irq(pdev, 0);
-
-	devm_free_irq(dev, irq, data);
-	pm_runtime_force_suspend(dev);
-}
-
-static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
-{
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
-	struct device *master = data->master;
-
-	if (master) {
-		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
-
-		mutex_lock(&owner->rpm_lock);
-		if (data->domain) {
-			dev_dbg(data->sysmmu, "saving state\n");
-			__sysmmu_disable(data);
-		}
-		mutex_unlock(&owner->rpm_lock);
-	}
-	return 0;
-}
-
-static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
-{
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
-	struct device *master = data->master;
-
-	if (master) {
-		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
-
-		mutex_lock(&owner->rpm_lock);
-		if (data->domain) {
-			dev_dbg(data->sysmmu, "restoring state\n");
-			__sysmmu_enable(data);
-		}
-		mutex_unlock(&owner->rpm_lock);
-	}
-	return 0;
-}
-
-static const struct dev_pm_ops sysmmu_pm_ops = {
-	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-};
-
-static const struct of_device_id sysmmu_of_match[] = {
-	{ .compatible	= "samsung,exynos-sysmmu", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, sysmmu_of_match);
-
-static struct platform_driver exynos_sysmmu_driver = {
-	.probe	= exynos_sysmmu_probe,
-	.shutdown = exynos_sysmmu_shutdown,
-	.driver	= {
-		.name		= "exynos-sysmmu",
-		.of_match_table	= sysmmu_of_match,
-		.pm		= &sysmmu_pm_ops,
-		.suppress_bind_attrs = true,
-	}
-};
-
 static inline void exynos_iommu_set_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 {
 	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
@@ -1428,6 +1247,185 @@ static const struct iommu_ops exynos_iommu_ops = {
 	}
 };
 
+static int exynos_sysmmu_probe(struct platform_device *pdev)
+{
+	int irq, ret;
+	struct device *dev = &pdev->dev;
+	struct sysmmu_drvdata *data;
+	struct resource *res;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->sfrbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->sfrbase))
+		return PTR_ERR(data->sfrbase);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0, dev_name(dev),
+			       data);
+	if (ret) {
+		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
+		return ret;
+	}
+
+	data->clk = devm_clk_get(dev, "sysmmu");
+	if (PTR_ERR(data->clk) == -ENOENT)
+		data->clk = NULL;
+	else if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	data->aclk = devm_clk_get(dev, "aclk");
+	if (PTR_ERR(data->aclk) == -ENOENT)
+		data->aclk = NULL;
+	else if (IS_ERR(data->aclk))
+		return PTR_ERR(data->aclk);
+
+	data->pclk = devm_clk_get(dev, "pclk");
+	if (PTR_ERR(data->pclk) == -ENOENT)
+		data->pclk = NULL;
+	else if (IS_ERR(data->pclk))
+		return PTR_ERR(data->pclk);
+
+	if (!data->clk && (!data->aclk || !data->pclk)) {
+		dev_err(dev, "Failed to get device clock(s)!\n");
+		return -ENOENT;
+	}
+
+	data->clk_master = devm_clk_get(dev, "master");
+	if (PTR_ERR(data->clk_master) == -ENOENT)
+		data->clk_master = NULL;
+	else if (IS_ERR(data->clk_master))
+		return PTR_ERR(data->clk_master);
+
+	data->sysmmu = dev;
+	spin_lock_init(&data->lock);
+
+	__sysmmu_get_version(data);
+
+	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
+				     dev_name(data->sysmmu));
+	if (ret)
+		return ret;
+
+	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
+	if (ret)
+		goto err_iommu_register;
+
+	platform_set_drvdata(pdev, data);
+
+	if (PG_ENT_SHIFT < 0) {
+		if (MMU_MAJ_VER(data->version) < 5) {
+			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
+			LV1_PROT = SYSMMU_LV1_PROT;
+			LV2_PROT = SYSMMU_LV2_PROT;
+		} else {
+			PG_ENT_SHIFT = SYSMMU_V5_PG_ENT_SHIFT;
+			LV1_PROT = SYSMMU_V5_LV1_PROT;
+			LV2_PROT = SYSMMU_V5_LV2_PROT;
+		}
+	}
+
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			goto err_dma_set_mask;
+		}
+	}
+
+	/*
+	 * use the first registered sysmmu device for performing
+	 * dma mapping operations on iommu page tables (cpu cache flush)
+	 */
+	if (!dma_dev)
+		dma_dev = &pdev->dev;
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+err_dma_set_mask:
+	iommu_device_unregister(&data->iommu);
+err_iommu_register:
+	iommu_device_sysfs_remove(&data->iommu);
+	return ret;
+}
+
+static void exynos_sysmmu_shutdown(struct platform_device *pdev)
+{
+	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int irq = platform_get_irq(pdev, 0);
+
+	devm_free_irq(dev, irq, data);
+	pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct device *master = data->master;
+
+	if (master) {
+		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
+
+		mutex_lock(&owner->rpm_lock);
+		if (data->domain) {
+			dev_dbg(data->sysmmu, "saving state\n");
+			__sysmmu_disable(data);
+		}
+		mutex_unlock(&owner->rpm_lock);
+	}
+	return 0;
+}
+
+static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct device *master = data->master;
+
+	if (master) {
+		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
+
+		mutex_lock(&owner->rpm_lock);
+		if (data->domain) {
+			dev_dbg(data->sysmmu, "restoring state\n");
+			__sysmmu_enable(data);
+		}
+		mutex_unlock(&owner->rpm_lock);
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops sysmmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static const struct of_device_id sysmmu_of_match[] = {
+	{ .compatible	= "samsung,exynos-sysmmu", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sysmmu_of_match);
+
+static struct platform_driver exynos_sysmmu_driver = {
+	.probe	= exynos_sysmmu_probe,
+	.shutdown = exynos_sysmmu_shutdown,
+	.driver	= {
+		.name		= "exynos-sysmmu",
+		.of_match_table	= sysmmu_of_match,
+		.pm		= &sysmmu_pm_ops,
+		.suppress_bind_attrs = true,
+	}
+};
+
 static int __init exynos_iommu_init(void)
 {
 	struct device_node *np;
@@ -1461,6 +1459,7 @@ static int __init exynos_iommu_init(void)
 	}
 
 	return 0;
+
 err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
-- 
2.35.1

