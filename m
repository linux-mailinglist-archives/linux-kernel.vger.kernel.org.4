Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D8607E88
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJUTAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJUTAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:00:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B27B24D8BC;
        Fri, 21 Oct 2022 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666378812; x=1697914812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KHP9T1zHMb4SNG4errxN0lomDv65adiOY/SYXWbHjM=;
  b=bmtdcDUi26px8GH6OPmATbLkvZsVyOE3JuGUfDtQPxHRNEXIqxaxTvfz
   INLPWFJWGQRJ1HQQgOvjLHf0LCEn+MKNYBBiqub4S//XIdg0YE/ISAe1W
   0rroUtXXJzXVX/S32VRuUsQVjsPRJUvJsYKH19YHl/7bitEKoWB3GpaVX
   otBprZ9zEDjSvwYJBPtojtk0PAHwChrECpuAcagWFBS/+TgC3VogOcwda
   TdaXLjezJTN457ZRGuZzGe8zAEgWEcZNsWZjex9YDL6ZfHLgW2iPW+zt8
   hWjw6/Ra67vCGVvTDRkWzQa76z94l5egLVFPTjO4MxMYPxJpqJLoNwdGw
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="333658297"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="333658297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773171048"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="773171048"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2022 12:00:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D6FBA291; Fri, 21 Oct 2022 22:00:22 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v5 2/4] spi: pxa2xx: Respect Intel SSP type given by a property
Date:   Fri, 21 Oct 2022 22:00:16 +0300
Message-Id: <20221021190018.63646-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
References: <20221021190018.63646-1-andriy.shevchenko@linux.intel.com>
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

Allow to set the Intel SSP type by reading the property.
Only apply this to the known MFD enumerated LPSS devices.

The check is done by the looking for the specifically
named IO memory resource provided by upper layer. This
won't be an issue in the future because we strictly
prioritize the order in which we are looking for the SSP
type in the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 93be7e8ef884..5527bcc5c729 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1462,9 +1462,12 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	const struct pci_device_id *pcidev_id = NULL;
 	enum pxa_ssp_type type = SSP_UNDEFINED;
 	const void *match;
+	bool is_lpss_priv;
 	int status;
 	u64 uid;
 
+	is_lpss_priv = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
+
 	if (pcidev)
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
 
@@ -1473,6 +1476,15 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 		type = (enum pxa_ssp_type)match;
 	else if (pcidev_id)
 		type = (enum pxa_ssp_type)pcidev_id->driver_data;
+	else if (is_lpss_priv) {
+		u32 value;
+
+		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
+		if (status)
+			return ERR_PTR(status);
+
+		type = (enum pxa_ssp_type)value;
+	}
 
 	/* Validate the SSP type correctness */
 	if (!(type > SSP_UNDEFINED && type < SSP_MAX))
-- 
2.35.1

