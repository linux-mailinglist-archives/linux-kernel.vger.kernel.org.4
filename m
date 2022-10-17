Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE95601469
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJQRMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQRMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:12:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1A696F7;
        Mon, 17 Oct 2022 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026749; x=1697562749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWe3aaoOgf+xq5Pq0douiTL3qv6/yUoCMHsfExvmaKw=;
  b=AKLR/u5jqtntQ8BCQJr/+MbgSZ236t3OxVV/ZJJDgoxCsa3ZiXHQLbOw
   T5shub33VMi1sSQnL2yuSJHPC/sMeXHWuH28sc8LSEmca0oMHbYm8vQCU
   Pt6tQmHySyVZZRyXDkJFPPkXz9cSRq+JuoaG0ExokCvQ4b/CbNApSuKKz
   05oXDZQ3VXa111EkUrYvFY4r+8DHr9ga1XPYtCvWGBfqY+8ij9Dl6KPLb
   b/hzuzeHj7U1GfZQPZCsX0F6yHvEHT/eDvoaUNsj/CbAGWSaEcY2SQMH9
   zbt9Im2Zb6CgS0g5iWU0ci4sAe5goV4FL/0sAdzHPN6ylVTvRXcirAIEx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305849453"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305849453"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957417116"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="957417116"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 10:12:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7641291; Mon, 17 Oct 2022 20:12:48 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/6] spi: pxa2xx: Respect Intel SSP type given by a property
Date:   Mon, 17 Oct 2022 20:12:39 +0300
Message-Id: <20221017171243.57078-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
References: <20221017171243.57078-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to set the Intel SSP type by reading the property.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c   | 6 ++++++
 include/linux/pxa2xx_ssp.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 03ed6d4a14cd..857732a54ca7 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1460,6 +1460,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
 	const struct pci_device_id *pcidev_id = NULL;
+	u32 value = SSP_UNDEFINED;
 	enum pxa_ssp_type type;
 	const void *match;
 	int status;
@@ -1468,9 +1469,14 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (pcidev)
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
 
+	/* Always try to read property */
+	device_property_read_u32(&pdev->dev, "intel,spi-pxa2xx-type", &value);
+
 	match = device_get_match_data(&pdev->dev);
 	if (match)
 		type = (enum pxa_ssp_type)match;
+	else if (value > SSP_UNDEFINED && value < SSP_MAX)
+		type = (enum pxa_ssp_type)value;
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
 	else
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

