Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C536604AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbiJSPMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiJSPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:11:28 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59BFBE502;
        Wed, 19 Oct 2022 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666191875; x=1697727875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWe3aaoOgf+xq5Pq0douiTL3qv6/yUoCMHsfExvmaKw=;
  b=QKZW2Ob/gLgvdrrzndHUmNcbqnGhalNyWb2jbMg02XFcfNP555gSMUeW
   dQZw/3XhrlCAmqunf52C1bvZiB2c/MvkECC3ihrAcoXNSEreNYeA7Kc/d
   f3bunUKefznjdldmEZbgVlPMH6oiMgVIOzywaepTvrsvczS7Hz1iCWgrZ
   mu7m72qN4I678mC4qwD1PObQxUat4Y1kQpIj3t4W8Ma5ZgfsiC5PUzRsY
   zbFcH2dkil4ojipZQYo6SWsw1pBzetQN0twpubR5heL/8UxexPPIyDlFe
   KjKt3itWXMaUglg0R0m1JvMn5SRl9SO2eWlnpSGB4HNKvKkYSck+V+a25
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305170523"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305170523"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607135193"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607135193"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 08:04:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B3FED0; Wed, 19 Oct 2022 18:04:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/5] spi: pxa2xx: Respect Intel SSP type given by a property
Date:   Wed, 19 Oct 2022 18:04:26 +0300
Message-Id: <20221019150430.27142-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019150430.27142-1-andriy.shevchenko@linux.intel.com>
References: <20221019150430.27142-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

