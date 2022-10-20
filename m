Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70AF606917
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJTTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJTTot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:44:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA1B3FECC;
        Thu, 20 Oct 2022 12:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666295086; x=1697831086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zkf3kxbtj/cO1oGXalV1myW08PGzo34Wex6zNG0q3+g=;
  b=QABKFpUGMf+IDvrB8TtYZiPmRqAB8hO7R9K2G3umU8K4Uz4fltAjj54Z
   TICQTU+JQIMOrAC/RS350Fc3Kz5LK0C7gDvuLfawaZQAjz/TgEcvqkMMv
   or+/ReN02g6yySey6rykkSAWFxDDHGJOvNC3/NnnCMg0AtLFCGak6bucg
   ETcVKoN+bhbTA1FEdWuTceI/5eLfhSfeyCHy3HqmMvSbZgQNQZtkPfijy
   YiW9Ai+GFldBj0TvIrHIgGNipvAo4dICGgxxg/+Gv4ZzZvTqTUM3Rkt+5
   g4J0N2vteXM7otn2JdAxO+qChD7KOxnFKtipSif+EuQ7ivb4EL4G8p8nh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333392706"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333392706"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875210366"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="875210366"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2022 12:44:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0C7EF3F9; Thu, 20 Oct 2022 22:45:04 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 4/5] spi: pxa2xx: Consistently use dev variable in pxa2xx_spi_init_pdata()
Date:   Thu, 20 Oct 2022 22:44:59 +0300
Message-Id: <20221020194500.10225-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
References: <20221020194500.10225-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a temporary variable to keep a pointer to a struct device in
the pxa2xx_spi_init_pdata(). Use it consistently there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 0824965e894d..00c07e93d414 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1349,7 +1349,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 			return ERR_PTR(status);
 	}
 
-	match = device_get_match_data(&pdev->dev);
+	match = device_get_match_data(dev);
 	if (match)
 		type = (enum pxa_ssp_type)match;
 	else if (value > SSP_UNDEFINED && value < SSP_MAX)
@@ -1357,7 +1357,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	else
 		return ERR_PTR(-EINVAL);
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
 
@@ -1376,7 +1376,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		pdata->dma_filter = pxa2xx_spi_idma_filter;
 	}
 
-	ssp->clk = devm_clk_get(&pdev->dev, NULL);
+	ssp->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ssp->clk))
 		return ERR_CAST(ssp->clk);
 
@@ -1385,7 +1385,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		return ERR_PTR(ssp->irq);
 
 	ssp->type = type;
-	ssp->dev = &pdev->dev;
+	ssp->dev = dev;
 
 	status = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
 	if (status)
@@ -1393,7 +1393,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	else
 		ssp->port_id = uid;
 
-	pdata->is_slave = device_property_read_bool(&pdev->dev, "spi-slave");
+	pdata->is_slave = device_property_read_bool(dev, "spi-slave");
 	pdata->num_chipselect = 1;
 	pdata->enable_dma = true;
 	pdata->dma_burst_size = 1;
-- 
2.35.1

