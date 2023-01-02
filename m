Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF7565B5F5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjABRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjABReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:34:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131A3BCA;
        Mon,  2 Jan 2023 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672680864; x=1704216864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCU7ycnxB3zii0W95wguPLD/q5qBT1vuhKpdekHvQos=;
  b=VpCQDURFf78y1snCyVGS5MtsdFHqkBZqj2RykeK89ksYwBbU+siqYXno
   LI++/NZ33eWgYyOx8y5F+RsIO28HnqSJg4NMJMs73LxC2iasYK1ufWaBk
   Ksd6NZQw54VC8FEyt27k9r4SFWKeBOjDvxowWy73xaY4ObpaeUogATPb0
   Fr6DbcC3Tr+MgkPP3rU7tZH+mUG4NHi6nSG+kWt+XtbiFioDEw5xEalMX
   BqBGUY12OTlsz01alBHPwRnqAlLoY87VwFiEtMShfEPljFzo95HN2BlkB
   VsB/RJCPN9Zsi79ilGc9D7EB5qHBPoXOZiRZaw1zkDWIIMN1H+BGpvdgv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="322752810"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="322752810"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 09:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="686951024"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="686951024"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Jan 2023 09:34:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BB051162; Mon,  2 Jan 2023 19:34:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 2/3] iio: adc: ti-adc128s052: Drop anti-pattern of ACPI_PTR() use
Date:   Mon,  2 Jan 2023 19:34:49 +0200
Message-Id: <20230102173450.29882-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
References: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 4a15b6bea310..0f737e9df0fa 100644
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

