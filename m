Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992CA606914
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJTTov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJTToq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:44:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED331EEF;
        Thu, 20 Oct 2022 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666295084; x=1697831084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jRtLRvDs43iHgGkeKwqBjox9tFRe2xXnZgo9MxkWuFY=;
  b=Ahomm5ctWySbz6QrAxPe/StG/DghkJyq3wi40dyp991KVVZ/uNjLBfO/
   tlDKBNo7s7bscIz/LQhBEWXfiRrCFKXnKODEFWVKafkYbRpc6tcSJ3+kW
   FodSnIgpP+dIuvm2++IgfaddPY/44X8s0VYEQ1lvXqFz8wujEk83IeV4R
   ZmkAblSs35Pmdta8vyna+Z3V1a5aq+ng76F49v+PC2oLfQjGJg7gUdzZZ
   XqvIuwa3CLBhu6XW+vK5KcBYhtBZXJ3Rw69UoLM2S4KUA7HL6FaXFT8xE
   lviUb4Sj73D5X451sAEw7sgRyjmBzEy3nrHHtKZlYBt/U8nESP19+BX0h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333392704"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333392704"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 12:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="875210362"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="875210362"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 20 Oct 2022 12:44:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E5740D0; Thu, 20 Oct 2022 22:45:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 1/5] spi: pxa2xx: Respect Intel SSP type given by a property
Date:   Thu, 20 Oct 2022 22:44:56 +0300
Message-Id: <20221020194500.10225-2-andriy.shevchenko@linux.intel.com>
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

Allow to set the Intel SSP type by reading the property.
Only apply this to the known MFD enumerated devices.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c   | 12 ++++++++++++
 include/linux/pxa2xx_ssp.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 03ed6d4a14cd..f3ba1b0588fb 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1460,17 +1460,29 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	struct resource *res;
 	struct pci_dev *pcidev = dev_is_pci(parent) ? to_pci_dev(parent) : NULL;
 	const struct pci_device_id *pcidev_id = NULL;
+	u32 value = SSP_UNDEFINED;
 	enum pxa_ssp_type type;
+	bool mfd_enumerated;
 	const void *match;
 	int status;
 	u64 uid;
 
+	/* For MFD enumerated devices always ask for a property */
+	mfd_enumerated = platform_get_resource_byname(pdev, IORESOURCE_MEM, "lpss_priv");
+	if (mfd_enumerated) {
+		status = device_property_read_u32(dev, "intel,spi-pxa2xx-type", &value);
+		if (status)
+			return ERR_PTR(status);
+	}
+
 	if (pcidev)
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match, pcidev);
 
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

