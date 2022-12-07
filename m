Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8952646166
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLGTEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiLGTD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:03:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CD6DCDF;
        Wed,  7 Dec 2022 11:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670439835; x=1701975835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Y3OtGkyYYjSIDhDns3MoKSTMDiEstJmDjab6GVes+w=;
  b=IgGqwIkS+0KkDx7A7DfsVZWViJCCInv32rhw4snhsV9fRPDXsdRN1nYv
   VtUEFO93wvsisIbHu03G6ud5md5U2VMFmmoijc9yfuCpXuPxCZIeOUxaV
   WwHyiAuWH9kQM2aygeuMWR1mNSjnlhLjtUFGlxk3vRKdilClQci1ODTQ+
   XsEyS4Vp8A/TmzL0tSXzhpAcrac/jdUtU8zcKAoMfEsT8wdJT+JRAO4Lv
   E75gUvCSmIDJhPJkGiHlmt5DBRtEAYDMRYy/8QCk527l+G3wW8zJJoN3/
   fJxKnDzwvVAYpn2B4qDUzfgeyAIF+y4PX0Ny1J/4ThBdz4OLglviLwk7U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="297333247"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="297333247"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 11:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="624411152"
X-IronPort-AV: E=Sophos;i="5.96,225,1665471600"; 
   d="scan'208";a="624411152"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2022 11:03:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 183603BC; Wed,  7 Dec 2022 21:04:09 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v1 06/11] iio: light: tsl2563: Simplify with dev_err_probe
Date:   Wed,  7 Dec 2022 21:03:43 +0200
Message-Id: <20221207190348.9347-6-andriy.shevchenko@linux.intel.com>
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

Code can be a bit simpler with dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Ferry Toth <ftoth@exalondelft.nl>
---
 drivers/iio/light/tsl2563.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index bdd40a5df53d..cce044556293 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -695,12 +695,13 @@ static const struct iio_info tsl2563_info = {
 
 static int tsl2563_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct tsl2563_chip *chip;
 	struct tsl2563_platform_data *pdata = client->dev.platform_data;
 	unsigned long irq_flags;
-	int err = 0;
 	u8 id = 0;
+	int err;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
@@ -712,16 +713,12 @@ static int tsl2563_probe(struct i2c_client *client)
 	chip->client = client;
 
 	err = tsl2563_detect(chip);
-	if (err) {
-		dev_err(&client->dev, "detect error %d\n", -err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "detect error\n");
 
 	err = tsl2563_read_id(chip, &id);
-	if (err) {
-		dev_err(&client->dev, "read id error %d\n", -err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "read id error\n");
 
 	mutex_init(&chip->lock);
 
@@ -765,17 +762,13 @@ static int tsl2563_probe(struct i2c_client *client)
 					   irq_flags,
 					   "tsl2563_event",
 					   indio_dev);
-		if (err) {
-			dev_err(&client->dev, "irq request error %d\n", -err);
-			return err;
-		}
+		if (err)
+			return dev_err_probe(dev, err, "irq request error\n");
 	}
 
 	err = tsl2563_configure(chip);
-	if (err) {
-		dev_err(&client->dev, "configure error %d\n", -err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "configure error\n");
 
 	INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_poweroff_work);
 
@@ -784,7 +777,7 @@ static int tsl2563_probe(struct i2c_client *client)
 
 	err = iio_device_register(indio_dev);
 	if (err) {
-		dev_err(&client->dev, "iio registration error %d\n", -err);
+		dev_err_probe(dev, err, "iio registration error\n");
 		goto fail;
 	}
 
-- 
2.35.1

