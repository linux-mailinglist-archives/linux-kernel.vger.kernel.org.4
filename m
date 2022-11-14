Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307562863A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiKNQ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237618AbiKNQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:55:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18B5220E4;
        Mon, 14 Nov 2022 08:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668444929; x=1699980929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IkuaKQE6muJiKEUj5oH1o7j+tKeDX81ryQ4zKUFKwN0=;
  b=NGzwMexsYeSatPJrSGNRvPG3Aj+WZhOKl4k+J8GK7EBIo9hiGDa5xHbp
   rheDwZFV4vTFeSsANpEeJ0vtY7cCZUX9kQSkIZH1Uw+PmdNSExeLlVAoB
   IggKqdKubAjLluBlj9LO8ek6ae9zWpgvtXh1asoWdLJqy3jotJj4sPSaK
   JuSOEi2mSes4TzQvyKyX1N9Kt+17oznPaVKdIN/XL3okQ+LNHbnTh0sI1
   PJZYnPSwJt7ooHxBnjOufK9U547wqaqSaNc8sh8Tr8dHmX6Wmi5lYg14r
   FW3YaVdtq8IhOXLH8TDe3YQMGOIubft7+z8gFa0xW0lWpB8bznh7ZnWOS
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295382843"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295382843"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="727593561"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="727593561"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Nov 2022 08:55:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 223DF346; Mon, 14 Nov 2022 18:55:47 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v4 5/7] pwm: lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
Date:   Mon, 14 Nov 2022 18:55:43 +0200
Message-Id: <20221114165545.56088-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
References: <20221114165545.56088-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pwm_lpss_probe() uses managed resources. Show this to
the users explicitly by adding devm prefix to its name.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-lpss-pci.c                 | 2 +-
 drivers/pwm/pwm-lpss-platform.c            | 2 +-
 drivers/pwm/pwm-lpss.c                     | 6 +++---
 include/linux/platform_data/x86/pwm-lpss.h | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index 98413d364338..b4134bee2863 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -30,7 +30,7 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 		return err;
 
 	info = (struct pwm_lpss_boardinfo *)id->driver_data;
-	lpwm = pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
+	lpwm = devm_pwm_lpss_probe(&pdev->dev, pcim_iomap_table(pdev)[0], info);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index c48c6f2b2cd8..f350607e28bd 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -31,7 +31,7 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	lpwm = pwm_lpss_probe(&pdev->dev, base, info);
+	lpwm = devm_pwm_lpss_probe(&pdev->dev, base, info);
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index b8739cd2c235..bb740346b699 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -244,8 +244,8 @@ static const struct pwm_ops pwm_lpss_ops = {
 	.owner = THIS_MODULE,
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
-				     const struct pwm_lpss_boardinfo *info)
+struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
+					  const struct pwm_lpss_boardinfo *info)
 {
 	struct pwm_lpss_chip *lpwm;
 	unsigned long c;
@@ -284,7 +284,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
 
 	return lpwm;
 }
-EXPORT_SYMBOL_GPL(pwm_lpss_probe);
+EXPORT_SYMBOL_GPL(devm_pwm_lpss_probe);
 
 MODULE_DESCRIPTION("PWM driver for Intel LPSS");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
diff --git a/include/linux/platform_data/x86/pwm-lpss.h b/include/linux/platform_data/x86/pwm-lpss.h
index 296bd837ddbb..c852fe24fe2a 100644
--- a/include/linux/platform_data/x86/pwm-lpss.h
+++ b/include/linux/platform_data/x86/pwm-lpss.h
@@ -27,7 +27,7 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
 
-struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, void __iomem *base,
-				     const struct pwm_lpss_boardinfo *info);
+struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
+					  const struct pwm_lpss_boardinfo *info);
 
 #endif	/* __PLATFORM_DATA_X86_PWM_LPSS_H */
-- 
2.35.1

