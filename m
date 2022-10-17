Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC92960146A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJQRMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJQRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:12:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD76696F7;
        Mon, 17 Oct 2022 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666026751; x=1697562751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hGgSA2GsBhzJwzVfaWPKJQVLq/322V9p+NlpEwW/lY=;
  b=gm8J49xcqyw0dE1jjakGsV4vCaUvxyjGKz8jlhi4KsQDmm0Q2/Ct2Gu/
   wr+iXG10jMKoJXaK2qFmFHzKa2hcjBYGSfqM/meVMUGQGOLdnAyIhbtTj
   GzC4Civ3mfGkN3bJBr/JLb5U8k0qX6aVa1ZOY92KJoBvzOsKcAqzs+PK8
   TGZVkkMCg6qPT7vKkooWkNvG+ATocDvZv/IEpIRbWxtMYXWUkFO47YzYS
   JgzgsaRueyTVQJ2lLreQb3lNYvsO9KcGiPCINCQ97ZbG7Gjoapt7KxRl5
   w76lQNY2u/Y2et4PJF95XlT6fxgT35JjYVXATllXM6CTJvSC/7ok2SpMa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="305849458"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="305849458"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="957417121"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="957417121"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 17 Oct 2022 10:12:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5F493625; Mon, 17 Oct 2022 20:12:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/6] spi: pxa2xx: Remove no more needed driver data
Date:   Mon, 17 Oct 2022 20:12:41 +0300
Message-Id: <20221017171243.57078-4-andriy.shevchenko@linux.intel.com>
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

