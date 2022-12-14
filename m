Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9C64C864
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiLNLt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiLNLtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:49:22 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9D63AF;
        Wed, 14 Dec 2022 03:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671018561; x=1702554561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r188qz47hPmbr6r5XbBcOdNISw/RCExFeHfQbTTAWVA=;
  b=bmpIVk2hvGOz9ftiG/2sp3uVh3GtvtHNR1aQv7JB1Dtub5ukUtvuDkKo
   X8/oHGH14orY9Y8cdCvLn1MfpPdgXBsmFJJ4vsNbeuqqr+WFA7CMaaxkg
   urHHtPyWDEPf7u3pgnl2drSXrUW/mVLyfbKSJPE5A+nbPAKIVnHrF+J7b
   apTquz1juGExfOMIIO5LnF0aOqg58wwacFqmUATnMOKuvNudjOR5ViKtO
   JisVr9CwJutOHXUA/JYwo4q+1QkZg73ISTBco+Uv1zAvk/jOExJ34J4VW
   XPdQaYTm61Uxy0MkyMHGDhpJQn54/tg5u+3jLZe1pEGKJbAG/c7ajRg8R
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="316017144"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="316017144"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 03:49:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="977805631"
X-IronPort-AV: E=Sophos;i="5.96,244,1665471600"; 
   d="scan'208";a="977805631"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2022 03:49:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5189BF4; Wed, 14 Dec 2022 13:49:48 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 2/2] iio: adc: ti-adc128s052: Drop anti-pattern of ACPI_PTR() use
Date:   Wed, 14 Dec 2022 13:49:44 +0200
Message-Id: <20221214114944.83790-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
References: <20221214114944.83790-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_PTR() is more harmful than helpful. For example, in this case
if CONFIG_ACPI=n, the ID table left unused and code is obfuscated
by ifdeffery.

Drop anti-pattern of ACPI_PTR() use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-adc128s052.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 9dfc625100b6..fc09ee6bb174 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -9,7 +9,6 @@
  * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
  */
 
-#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
@@ -201,19 +200,17 @@ static const struct spi_device_id adc128_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id adc128_acpi_match[] = {
 	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
-#endif
 
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
 		.of_match_table = adc128_of_match,
-		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
+		.acpi_match_table = adc128_acpi_match,
 	},
 	.probe = adc128_probe,
 	.id_table = adc128_id,
-- 
2.35.1

