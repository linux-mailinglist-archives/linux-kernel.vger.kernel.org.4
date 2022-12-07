Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C4646176
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiLGTEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiLGTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:04:04 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FFF7061A;
        Wed,  7 Dec 2022 11:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439843; x=1701975843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Al6ot08K5G63PiVcb4PsFpdTXyvKTgMvRkFiF1LSefc=;
  b=kliUXD4/BIWjTTrw216pfAU+xzqnlzlIGo3Bl++qWwrOB7lwJVcPInTE
   rso+kDZ+OWCosyaDkZwlK3DgDEOWW9bRinhaI4Nx4HIDZZ7GIZ2XgQv+g
   Sp3v5VrGmMiiKix2D+kpKa+eqwoGMnB2pMhHaldwOdGHtVDeXtAFaMdPO
   zZgZaB7dMOq92gF+cu87HCGL1Rfb/VBV0gfRC31YdOz6qWevWpsQ3DLD1
   cYzUzYgCrWHxeX7L9XlU52IN4rHcIjRtJtBIbeLbm8e6ecv+q1cKwsZdx
   Xf3xQDkcxl1tV+mMAfkKkWxsXJ5o9VIU5LbufboS2K+ipdHPYFbjZEako
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="315690239"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="315690239"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="821060672"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="821060672"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2022 11:03:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3903B4A1; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 08/11] iio: light: tsl2563: Utilise temporary variable for struct device
Date:   Wed,  7 Dec 2022 21:03:45 +0200
Message-Id: <20221207190348.9347-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
References: <20221207190348.9347-1-andriy.shevchenko@linux.intel.com>
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

We have a temporary variable to keep pointer to struct device.
Utilise it inside the ->probe() implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index ed193a3da91e..c5814545fd19 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -701,7 +701,7 @@ static int tsl2563_probe(struct i2c_client *client)
 	u8 id = 0;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -731,7 +731,7 @@ static int tsl2563_probe(struct i2c_client *client)
 	chip->cover_comp_gain = 1;
 	device_property_read_u32(dev, "amstaos,cover-comp-gain", &chip->cover_comp_gain);
 
-	dev_info(&client->dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
+	dev_info(dev, "model %d, rev. %d\n", id >> 4, id & 0x0f);
 	indio_dev->name = client->name;
 	indio_dev->channels = tsl2563_channels;
 	indio_dev->num_channels = ARRAY_SIZE(tsl2563_channels);
@@ -748,7 +748,7 @@ static int tsl2563_probe(struct i2c_client *client)
 			irq_flags = IRQF_TRIGGER_RISING;
 		irq_flags |= IRQF_ONESHOT;
 
-		err = devm_request_threaded_irq(&client->dev, client->irq,
+		err = devm_request_threaded_irq(dev, client->irq,
 					   NULL,
 					   &tsl2563_event_handler,
 					   irq_flags,
-- 
2.35.1

