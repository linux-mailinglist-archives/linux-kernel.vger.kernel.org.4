Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6292962D90A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiKQLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239736AbiKQLIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:15 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075531FB3;
        Thu, 17 Nov 2022 03:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668683291; x=1700219291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBHKobpk/VhTDX4eSeyn9vK1zVXcs+GCnxTGHrxO5To=;
  b=V94tzEgi/ezsUIHZq+vGkaOsch6tpfBJ1jCptoi3UB8L3E8+9Txt6bsq
   ewqlA6oQVE0nFesmm11HhuzGERhBYOkZRJe2Dd/T2garH3KQiIr8+0TPm
   pBEbsS9TWm1eDxFcCBOVRyAPKfahtfSormwU/saAT27XuZ4zj03wRtrcf
   57uKx2Rc12W5Pu0Ibr9pVdiRquBxv6mVDeCEq98yWfFaos65zkhB231x5
   cHlAHf5mMpUIMJwsC/sf2mzuvg0TY2qUTzEb6cYC5LZvkNZ+himJNIWWb
   IM/SiNZqfqJP2pOhuEiLUqUTUXLnbn2uAGuPQrm0z/mCc8YgEc0/c9KrX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="296186172"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296186172"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 03:08:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="639763892"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="639763892"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Nov 2022 03:07:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4725A41A; Thu, 17 Nov 2022 13:08:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 5/7] pwm: lpss: Rename pwm_lpss_probe() --> devm_pwm_lpss_probe()
Date:   Thu, 17 Nov 2022 13:08:04 +0200
Message-Id: <20221117110806.65470-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

