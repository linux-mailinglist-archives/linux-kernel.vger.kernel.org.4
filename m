Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6939A646170
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLGTEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLGTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7476F0EC;
        Wed,  7 Dec 2022 11:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439842; x=1701975842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vKGtpM5JSZarHWj35MDsk6li/lREkuRPGsDfjh4bQXA=;
  b=h2L/fBbPH63mgaslX9b7ICO+UMgzfjc+tC9DQLecLiJYtAYbEnn+2k7n
   AId9nT2E9QAfKz3E8KJw+ot600kgi0kY55rjQXbXnhOqEV0eIdEI1pXnR
   5/a5oVgBAWHeOn3EBjriE2OwIGcrHMuwYsPjioK8TJCXQg3TyQkobe3Mo
   N3H8uDuPf6FsTH12go4lIxxb+tazvMhSOx1FNfhT0PKEPzZeFwdDrwArl
   coFmLpH3fa/agjrf7ZUwFVYI9hDKuXuASkECfWOFj9Vm0AX9U50+JWPXt
   w6lqsI1mH6KLb50inOHOV150swFORtyXkCYsopWNBZzJqS/8r30Kce+Zw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690223"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690223"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060667"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060667"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5B94F4; Wed,  7 Dec 2022 21:04:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 01/11] iio: light: tsl2563: Do not hardcode interrupt trigger type
Date:   Wed,  7 Dec 2022 21:03:38 +0200
Message-Id: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ferry Toth <ftoth@exalondelft.nl>

Instead of hardcoding IRQ trigger type to IRQF_TRIGGER_RAISING,
let's respect the settings specified in the firmware description.
To be compatible with the older firmware descriptions, if trigger
type is not set up there, we'll set it to default (raising edge).

Fixes: 388be4883952 ("staging:iio: tsl2563 abi fixes and interrupt handling")
Fixes: bdab1001738f ("staging:iio:light:tsl2563 remove old style event registration.")
Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/tsl2563.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index d0e42b73203a..71302ae864d9 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -704,6 +704,7 @@ static int tsl2563_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
+	unsigned long irq_flags;
 	int err = 0;
 	u8 id = 0;
 
@@ -759,10 +760,15 @@ static int tsl2563_probe(struct i2c_client *client)
 		indio_dev->info = &tsl2563_info_no_irq;
 
 	if (client->irq) {
+		irq_flags = irq_get_trigger_type(client->irq);
+		if (irq_flags == IRQF_TRIGGER_NONE)
+			irq_flags = IRQF_TRIGGER_RISING;
+		irq_flags |= IRQF_ONESHOT;
+
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 					   NULL,
 					   &tsl2563_event_handler,
-					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					   irq_flags,
 					   "tsl2563_event",
 					   indio_dev);
 		if (err) {
-- 
2.35.1

