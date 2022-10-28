Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24A611AB5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJ1TNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJ1TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:12:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2630623923E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a67so9192535edf.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deMSZFUhvNmRdIfYG/C3RyBQaijBl5jkuXDMUwHOSfU=;
        b=ITbfN5eFzSlarpfm6uqKJEMWgyggUQN+lNoa9zCXhXHPcYfNQJ2H4hx+xTBeYE/llo
         EdEPh1b27nTt6KvLrJ/pXVkD/pE6Yz54gTQr4bhyvozC0Npne1qN92uZnXET0cx4JVOV
         OIf32eGS4HV6oBvFTlBRqHsc1vSKR4Yndk7FovaFMDVlH9jKv407c77vFEGoKLKx3Lpx
         00aMv/M7su9Eomf1x27yzLxJ55SMvdXcI4yW8UlWN/xobQg71hnNUCLuWRFSUVrw6eCy
         XpaKyIlbOpZ7lYMhXVK8NXHed8YPZKN5BmVRib+GQqe8JN35zRS6UFEVsrCGmh/Hne4d
         RvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deMSZFUhvNmRdIfYG/C3RyBQaijBl5jkuXDMUwHOSfU=;
        b=JuminPC/brhJoqvi24KqGiU4Ii6GFOYdJQ1DO3AYqiLv7QFNeCjeu5TFo403zuypaw
         VsnHRVIT0V1nIFy4g7qpSvfBL0LPI5WgbMWbx5DnIe5EKURzpSKitSZnIb6r6v1DdIn0
         3LmOmZUTYbzaq3sOWAf4VVwFHEGGEcxnAKxzEc28F9DJ7xKL8AFVu2wKSVKCsaOIZ8tB
         MlQZDhT5YTqQ9sVoUnXjHXHsmGgeqjcs02eghWTC/m0pOx87snK8Ixc/IB6lM8WUNpr/
         fBB8ICN1AnJ9mHiLlIje9h6zavTNzoM/5DWW8/x+ANUvh9JJeIZpQyojXtuhaFAkk8pX
         carg==
X-Gm-Message-State: ACrzQf0Xo9PKfuyXotl5JM/APN6FezJHM0N+jqBRdz9ouUWCuQQQVHk6
        1bjP9m7VyQx+TlkNvvlkOgBXXw==
X-Google-Smtp-Source: AMsMyM6avMFshulH77RloU/mF32waXGsMPKerdgE9UbPWuVeBJIddF1PsG+b3odsc165qF4xXhcX6A==
X-Received: by 2002:a05:6402:430a:b0:462:2e05:30b5 with SMTP id m10-20020a056402430a00b004622e0530b5mr920629edc.246.1666984373603;
        Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id kz2-20020a17090777c200b0079dbf06d558sm2487737ejc.184.2022.10.28.12.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
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
Subject: [PATCH 4/4] iommu/exynos: Rearrange the platform driver code
Date:   Fri, 28 Oct 2022 21:12:43 +0200
Message-Id: <20221028191243.31721-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the platform_driver code to the bottom of the driver, as it's a
canonical form for that. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 359 +++++++++++++++++------------------
 1 file changed, 179 insertions(+), 180 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 57492db877e2..af1c8ddcf5e4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -641,186 +641,6 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
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
@@ -1427,6 +1247,184 @@ static const struct iommu_ops exynos_iommu_ops = {
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
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
+				dev_name(dev), data);
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
@@ -1460,6 +1458,7 @@ static int __init exynos_iommu_init(void)
 	}
 
 	return 0;
+
 err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
-- 
2.35.1

