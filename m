Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E9611AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJ1TNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ1TM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:12:56 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645A2339A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z18so4225732edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce4G8W5n1Lw9GJ2OPzfRvhL8Ar7JfIK4yfZO67gLs8o=;
        b=USP77o4Kj2PXkea5iju4USuaykmQfPyYjmvznDQakbS8TtPG6SAAgBqdEnSwNoevF2
         9/MX/qCCFNYzLoU8S55oAFU4v3FXisMLnhwxhZE34gQSNi7Nh5ffwJNiNHW+ZGnIwjdt
         5aVCxJdIEFHlacrIJJ0tIfaoOAbetXlbZmi9sRAWGTjVXLt7Az796qbPtToLaUDVkK0O
         uRUMhOePJ0xuK4nt1CshdgJXZHiYpRUWgiAI1FtQw+k/U4IGZD92SPs+gtu30naDO3hJ
         vk/pVENy7WDuEPyvq5+PPbKqwzI+wI0tCiZ76IYjhi46RsCLGdKsqCyoOTDVEdSPN7Sa
         HeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce4G8W5n1Lw9GJ2OPzfRvhL8Ar7JfIK4yfZO67gLs8o=;
        b=nEcKT7hu2cR+7Dg6kxeOvMMhhI08Zu0WejndkfUnLmVQOuGl3rdkMN24PZvuP05D73
         cyzzavuW7rhHoIPcSOF2PvGBEmXmQrS13ouVcUDJ71OAAg3DBui9ILRhEQUUdvGgQ9Vp
         HuoAVOjta1R9lQl04GiuRnJ/sV0KSLabG0VH9/fZFnKHu79dLAS7FdIWAPzHcGGW6sEq
         RhBJvhdC0z/MJn5IJI9ZbeJqYSqwDc77klRHzzq+gQumA/NDOlasKXmk2IyPrC/ej1t0
         VBq6qi9TEJSAbUAkQy4duGghycXC0XEvzpOLNe3M1Qx0XKVMlLyicM5Z9pZj1JHd9kdj
         RQCA==
X-Gm-Message-State: ACrzQf3rjnUAFDGbvd7Xuc+SAYxNY+e7hHQ/8ho7CJRMdc8dNo9qqbNi
        hZ0lsUYhjQqb1mIig2gu0zMwyg==
X-Google-Smtp-Source: AMsMyM6fQx72vUp95PoUjSyByIOuAe4YYAUh6ucP84vWfDBeUQfZYGHasjqdWI7uR1/gJ5ciL2E5Cw==
X-Received: by 2002:a05:6402:448c:b0:457:52eb:b57e with SMTP id er12-20020a056402448c00b0045752ebb57emr948141edb.178.1666984371738;
        Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id fx1-20020a170906b74100b007a7f9b6318asm2569764ejb.50.2022.10.28.12.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:51 -0700 (PDT)
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
Subject: [PATCH 3/4] iommu/exynos: Modularize the driver
Date:   Fri, 28 Oct 2022 21:12:42 +0200
Message-Id: <20221028191243.31721-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
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

Rework the driver so it can be built as a loadable module. That can be
useful as not all ARM64 platforms need it. And that's ok for it to be a
module because it's not a critical driver (platform can work when it's
disabled).

Also add the shutdown driver method, while at it. That was inspired by
other IOMMU drivers, and can be useful e.g. for performing a kexec. See
commit 1a4e90f25b2c ("iommu/rockchip: Perform a reset on shutdown") for
example.

Remove method and module exit function are not implemented, as the
removal of IOMMUs cannot be done reliably. As Robin Murphy mentioned in
[1]:

    ...it's better not to even pretend that removing an IOMMU's driver
    while other drivers are using it (usually via DMA ops without even
    realising) is going to have anything other than catastrophic
    results.

[1] https://lore.kernel.org/lkml/20220702213724.3949-2-semen.protsenko@linaro.org/T/#md7e1e3f5b2c9e7fa5bc28fe33e818b6aa4a7237c

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/Kconfig        |  2 +-
 drivers/iommu/exynos-iommu.c | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc5f7a156ff5..6f7055606679 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -259,7 +259,7 @@ config TEGRA_IOMMU_SMMU
 	  SoCs (Tegra30 up to Tegra210).
 
 config EXYNOS_IOMMU
-	bool "Exynos IOMMU Support"
+	tristate "Exynos IOMMU Support"
 	depends on ARCH_EXYNOS || COMPILE_TEST
 	depends on !CPU_BIG_ENDIAN # revisit driver if we can enable big-endian ptes
 	select IOMMU_API
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0d150b383d04..57492db877e2 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/kmemleak.h>
 #include <linux/list.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -752,6 +753,16 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	return ret;
 }
 
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
 static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
 {
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
@@ -799,8 +810,9 @@ static const struct of_device_id sysmmu_of_match[] = {
 	{ },
 };
 
-static struct platform_driver exynos_sysmmu_driver __refdata = {
+static struct platform_driver exynos_sysmmu_driver = {
 	.probe	= exynos_sysmmu_probe,
+	.shutdown = exynos_sysmmu_shutdown,
 	.driver	= {
 		.name		= "exynos-sysmmu",
 		.of_match_table	= sysmmu_of_match,
@@ -1404,6 +1416,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
+	.owner = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.detach_dev	= exynos_iommu_detach_device,
@@ -1454,3 +1467,6 @@ static int __init exynos_iommu_init(void)
 	return ret;
 }
 core_initcall(exynos_iommu_init);
+
+MODULE_DESCRIPTION("IOMMU driver for Exynos SoCs");
+MODULE_LICENSE("GPL");
-- 
2.35.1

