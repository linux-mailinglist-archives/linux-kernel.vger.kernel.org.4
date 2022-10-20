Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5AA6065B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJTQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJTQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:26:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970B2578BC;
        Thu, 20 Oct 2022 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283175; x=1697819175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hWe3aaoOgf+xq5Pq0douiTL3qv6/yUoCMHsfExvmaKw=;
  b=myQ3+dkYIZCdmvRW6RODJ2f1vnWb6DI/UYVyld9wdsyBrjxu7qpdWSZA
   fyYtGVK77PH3p32Ip347QrTvfvSTxj7yI7dbXEXGNeNA2iyRhxcbBXdgq
   eLU236aGry7B48RC5JuwxC2bh9XPN6R3w7B74fLwGM5xh6w+yKvdLPxDw
   Ep+2+YcWCp1yaqNiqkl5kUZQ8LveLqyfCQCbHEWovvp6/8Poz9WkRSMPA
   RxHcOplnDDLXvXCuTkukthBqlzrGRYkiFMcGzte7YLkaR9Ixx2wlw9vFH
   78nrqDIbwxmKr3cSrJyw24Bt7WKNyjZg75Qyk4duUslYZeyuodg83nvcG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="287164935"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="287164935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="581004361"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="581004361"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 20 Oct 2022 09:26:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B1D504FD; Thu, 20 Oct 2022 19:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 1/5] spi: pxa2xx: Respect Intel SSP type given by a property
Date:   Thu, 20 Oct 2022 19:26:27 +0300
Message-Id: <20221020162631.68914-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
References: <20221020162631.68914-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

