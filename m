Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDB86065C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJTQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJTQ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:26:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E815202D;
        Thu, 20 Oct 2022 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666283192; x=1697819192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hGgSA2GsBhzJwzVfaWPKJQVLq/322V9p+NlpEwW/lY=;
  b=kIpP5KGpx9sWY2mr4WxRIMX5CBtuDvQG21OeD3GkJ1XwjdqFV7b2IAkX
   SBvw7W0tctEVX4CAadYSVbragGGmzM55BXprHmQIgqudBGspuMpwdYGbF
   ywdpk977/598MFSrOhut6FdYq9w+LI3lbe6LNSbOTEPo+oW5+QvBY618k
   3NZZE+mbvu/WCVoz/W90TTo884ORQFhCXMv6jrAy6f7A2QUj+2nrrzmD1
   coldjoXR3uYn9+JJ32dZpQWADts6leeweIKl+ilXg69uoB2FhBLclTnB2
   O3IegbzVB3xnWjYxWmrP03HNK+ogjC/Z2lJv5k1YUPdnqY/RV3VqXNHZ7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="393065808"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="393065808"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 09:26:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="663149971"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="663149971"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2022 09:26:11 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BD58E107; Thu, 20 Oct 2022 19:26:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/5] spi: pxa2xx: Remove no more needed driver data
Date:   Thu, 20 Oct 2022 19:26:29 +0300
Message-Id: <20221020162631.68914-4-andriy.shevchenko@linux.intel.com>
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

Since the ACPI enumerated devices provide a property with SSP type,
there is no more necessity to bear the copy of them in the ID table.
Drop the driver data in ACPI ID table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-pxa2xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 1d36d055a9d6..31927493eeb0 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1323,12 +1323,12 @@ static void cleanup(struct spi_device *spi)
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id pxa2xx_spi_acpi_match[] = {
-	{ "INT33C0", LPSS_LPT_SSP },
-	{ "INT33C1", LPSS_LPT_SSP },
-	{ "INT3430", LPSS_LPT_SSP },
-	{ "INT3431", LPSS_LPT_SSP },
-	{ "80860F0E", LPSS_BYT_SSP },
-	{ "8086228E", LPSS_BSW_SSP },
+	{ "INT33C0" },
+	{ "INT33C1" },
+	{ "INT3430" },
+	{ "INT3431" },
+	{ "80860F0E" },
+	{ "8086228E" },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, pxa2xx_spi_acpi_match);
-- 
2.35.1

