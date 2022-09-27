Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052475EC6DC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiI0OuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiI0Ot1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:49:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362DE476FB;
        Tue, 27 Sep 2022 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664290034; x=1695826034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yt0ucc2qTU8zV/g3jU5LvIWnCzcHat0C6WDxmrAtdlg=;
  b=fupIj2gIeCgaJaB+y3DY2X47C+RAc7KHeJxCgGiAj6gcxKQLi3ZzYlXv
   TOKy0TeMaeUGiZ7P2OhZVRaQr7cFMnyu5NSOXYl6vxSONObaUoID5kLRH
   LH3Uja0U8d9pRVZU0xNit9/7Dir/BzIKCoWZ36SMor9/zudsQzv3ng2z5
   /MOIacOQkkT2yWI+zUzC6lybEvpSJ2YMwK1r5eEJTD/HjwCC/FZg/VhY0
   s30x7BYY/azCIsTCJyy3dptPt/R4Qi2xOYg8Wi09+ddXbu37XYQQZeB2K
   0kf1O+9hmw5woHNcFEO/Wx1schBrTb5AH2/l47EMaow8Y9kj3BFYvIEjf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="298930817"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="298930817"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 07:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="796788475"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="796788475"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2022 07:47:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9EF51F7; Tue, 27 Sep 2022 17:47:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v3 3/8] pwm: lpss: Move resource mapping to the glue drivers
Date:   Tue, 27 Sep 2022 17:47:18 +0300
Message-Id: <20220927144723.9655-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move resource mapping to the glue drivers which helps
to transform pwm_lpss_probe() to pure library function
that may be used by others without need of specific
resource management.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-pci.c      | 6 +++++-
 drivers/pwm/pwm-lpss-platform.c | 9 ++++++---
 drivers/pwm/pwm-lpss.c          | 7 ++-----
 drivers/pwm/pwm-lpss.h          | 2 +-
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 9f2c666b95ec..f3367e844e61 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -25,8 +25,12 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 	if (err < 0)
 		return err;
 
+	err = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (err)
+		return err;
+
 	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = pwm_lpss_probe(&pdev->dev, &pdev->resource[0], info);
+	lpwm = pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 65154c0abab1..7bbbb7a9b578 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -21,16 +21,19 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	const struct pwm_lpss_boardinfo *info;
 	const struct acpi_device_id *id;
 	struct pwm_lpss_chip *lpwm;
-	struct resource *r;
+	void __iomem *base;
 
 	id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
 	if (!id)
 		return -ENODEV;
 
 	info = (const struct pwm_lpss_boardinfo *)id->driver_data;
-	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	lpwm = pwm_lpss_probe(&pdev->dev, r, info);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	lpwm = pwm_lpss_probe(&pdev->dev, base, info);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 74a296cb1af0..a20915459809 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -243,7 +243,7 @@ static const struct pwm_ops pwm_lpss_ops = {
 	.owner = THIS_MODULE,
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
@@ -258,10 +258,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 	if (!lpwm)
 		return ERR_PTR(-ENOMEM);
 
-	lpwm->regs = devm_ioremap_resource(dev, r);
-	if (IS_ERR(lpwm->regs))
-		return ERR_CAST(lpwm->regs);
-
+	lpwm->regs = base;
 	lpwm->info = info;
 
 	c = lpwm->info->clk_rate;
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 9ea5b145a353..c344921b2cab 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -38,7 +38,7 @@ extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
 extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
+struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 				     const struct pwm_lpss_boardinfo *info);
 
 #endif	/* __PWM_LPSS_H */
-- 
2.35.1

