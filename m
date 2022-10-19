Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFCF604AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiJSPM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiJSPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:11:32 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E677D1C2;
        Wed, 19 Oct 2022 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666191887; x=1697727887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hGgSA2GsBhzJwzVfaWPKJQVLq/322V9p+NlpEwW/lY=;
  b=nTHH/5bZEj8QgClyUBItabkN55sTS+n3da2h2SmyDBNCTQYDeRjMrpoG
   QDyyLxrVAm171JGP0PEmcW8pqN8mfnyfnBll6WyiD4SkqNNDM7j6rvTwR
   WFVVKQs5huf1vKnrwtnHjsrDSWPajEekgEA+Ajy6BtmDZlXg2d9sdelVd
   o/UsEqu7K9NxPN6l51gs6elUFPB9AwkEH8yn0iKJCRUCUrjX+rdg7etHB
   otIUYOkRQn5NsTAFV5BV7nqiMADTtx3jyWRIOBPh4xXGPLWeIyyBYICNi
   A4xpWW+UOGRveYJJ+UIBZnp0W2lETDY9LCLheNFrewQCsvEqiaWmdKQax
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="305170527"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305170527"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:04:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607135198"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607135198"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 08:04:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA5D215C; Wed, 19 Oct 2022 18:04:33 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/5] spi: pxa2xx: Remove no more needed driver data
Date:   Wed, 19 Oct 2022 18:04:28 +0300
Message-Id: <20221019150430.27142-4-andriy.shevchenko@linux.intel.com>
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

