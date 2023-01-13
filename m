Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5677669A18
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjAMO37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjAMO2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:28:54 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209E878E96;
        Fri, 13 Jan 2023 06:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673619539; x=1705155539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8CM+ANswML+huvLCOjDIrB7RxnHX0wqAonnUb68AXO4=;
  b=jf2n6LyhcgXoabQ2PYC6uTZbRgtei3cndwnvFiH4Cdxv0mXkdbpW69do
   U6lRkfgN8FrzqmVOtsjwJ0trWOnYoaxQ6gW5vWisVr3ZWK4aOf8nb6zJG
   XNQeTGP3DYIhAEF0P8DmGM3FXs5na8hthnydqxdKFiisauBdL1Qs8zuB+
   KxlYk4s3R4bpNuHsUvnzyvOSoLf1spQgw4BLrR6t1SkdRBz/yuVBcRk3u
   njnmjKio+OU4d44yYHZk2aEpIyF9bMV2OEOOTnNVlggpjLOEzqQWTSRUj
   kfUFIVYWQDTo04Xb9a9nyFmGLxm8sFqvmcv3IlTfRalxIR2w3VvrnAJtJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="324058540"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="324058540"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 06:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="832079536"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="832079536"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2023 06:18:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2760F130; Fri, 13 Jan 2023 16:19:18 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v1 1/1] iio: chemical: scd30_core: Switch to use dev_err_probe()
Date:   Fri, 13 Jan 2023 16:19:17 +0200
Message-Id: <20230113141917.23725-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Switch to use dev_err_probe() to simplify the error paths and
unify message template.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/chemical/scd30_core.c | 40 +++++++++++--------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index e0bb1dd5e790..7be5a45cf71a 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -642,10 +642,8 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 
 	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
 				      iio_device_id(indio_dev));
-	if (!trig) {
-		dev_err(dev, "failed to allocate trigger\n");
-		return -ENOMEM;
-	}
+	if (!trig)
+		return dev_err_probe(dev, -ENOMEM, "failed to allocate trigger\n");
 
 	trig->ops = &scd30_trigger_ops;
 	iio_trigger_set_drvdata(trig, indio_dev);
@@ -667,9 +665,9 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
 					IRQF_NO_AUTOEN,
 					indio_dev->name, indio_dev);
 	if (ret)
-		dev_err(dev, "failed to request irq\n");
+		return dev_err_probe(dev, ret, "failed to request irq\n");
 
-	return ret;
+	return 0;
 }
 
 int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
@@ -717,17 +715,13 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 		return ret;
 
 	ret = scd30_reset(state);
-	if (ret) {
-		dev_err(dev, "failed to reset device: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to reset device\n");
 
 	if (state->irq > 0) {
 		ret = scd30_setup_trigger(indio_dev);
-		if (ret) {
-			dev_err(dev, "failed to setup trigger: %d\n", ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to setup trigger\n");
 	}
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd30_trigger_handler, NULL);
@@ -735,23 +729,17 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 		return ret;
 
 	ret = scd30_command_read(state, CMD_FW_VERSION, &val);
-	if (ret) {
-		dev_err(dev, "failed to read firmware version: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read firmware version\n");
 	dev_info(dev, "firmware version: %d.%d\n", val >> 8, (char)val);
 
 	ret = scd30_command_write(state, CMD_MEAS_INTERVAL, state->meas_interval);
-	if (ret) {
-		dev_err(dev, "failed to set measurement interval: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set measurement interval\n");
 
 	ret = scd30_command_write(state, CMD_START_MEAS, state->pressure_comp);
-	if (ret) {
-		dev_err(dev, "failed to start measurement: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to start measurement\n");
 
 	ret = devm_add_action_or_reset(dev, scd30_stop_meas, state);
 	if (ret)
-- 
2.39.0

