Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE856607E84
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJUTAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:00:12 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378516CA7A;
        Fri, 21 Oct 2022 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666378807; x=1697914807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3LKz11YL5jDVuuxonOVP7DrQMsduuZXSBKCi22WKThQ=;
  b=BiOtG7cgyvDG+J40yA0KYSRc0AwxjxirYyg2kSLJSdAXeCYRiT4tzoTR
   5v64nKHE7ifaXhE2P5SUMJtZAX1I6PrBw6LwKgJIhM8/+Bye0Zyfo7w6b
   MjhQtoNVJk12MG0aNUR82aNgEFrNzxs+gY3425DlkdbVz7VQFK8uV8Pdd
   jtg2MniWt1N6RKGckpaaCd30kwfqwUTGgC/RMEPFwoD/Qm+qrgZbpiZTk
   dA0/y1G4qJoBGj4iLw+hIIoJk8jBWnezXF09CY+xkaEk3i+XMLtP3MU6W
   5x1MD++PSMxqV3ovdp1gdZTpN+jIwnk0LDw4SEjU5Mu3Dm9tYUsAd60Ny
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307071103"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="307071103"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="875798621"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="875798621"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2022 12:00:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C9413B7; Fri, 21 Oct 2022 22:00:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 1/4] spi: pxa2xx: Validate the correctness of the SSP type
Date:   Fri, 21 Oct 2022 22:00:15 +0300
Message-Id: <20221021190018.63646-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
References: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we blindly apply the SSP type value from any source of the
information. Increase robustness by validating the value before use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c   | 6 ++++--
 include/linux/pxa2xx_ssp.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c9f6a3fbe62f..93be7e8ef884 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1460,7 +1460,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
 	const struct pci_device_id *pcidev_id = NULL;
-	enum pxa_ssp_type type;
+	enum pxa_ssp_type type = SSP_UNDEFINED;
 	const void *match;
 	int status;
 	u64 uid;
@@ -1473,7 +1473,9 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		type = (enum pxa_ssp_type)match;
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
-	else
+
+	/* Validate the SSP type correctness */
+	if (!(type > SSP_UNDEFINED && type < SSP_MAX))
 		return ERR_PTR(-EINVAL);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
diff --git a/include/linux/pxa2xx_ssp.h b/include/linux/pxa2xx_ssp.h
index a3fec2de512f..cd1973e6ac4b 100644
--- a/include/linux/pxa2xx_ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -229,6 +229,7 @@ enum pxa_ssp_type {
 	LPSS_SPT_SSP,
 	LPSS_BXT_SSP,
 	LPSS_CNL_SSP,
+	SSP_MAX
 };
 
 struct ssp_device {
-- 
2.35.1

