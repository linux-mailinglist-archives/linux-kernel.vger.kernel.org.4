Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74D742426
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjF2KqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2KqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:46:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5BF1FD7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688035568; x=1719571568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bKELHWVc0gm7Wrq9rJb2qhEkSaXqfGvlib5oCM0+8EM=;
  b=NC4dWm3RfBfr0FsPmpM6hGaKa5KbmlU5hcLzLn+Qqo5JG/KQCW1taRdd
   5LRkHC5sxQi52u4BKVcXa5w1XmU3awQxgPwCSgYitaiBE2312UtUL4MoY
   c5p7Diuv8dV7V7SVd+++3XsXwXbXqNcQqMupSUQLONoWru4Iep9bS0icn
   yesTQs2BJao/rbsj3mTqMkXtSTO6BQ8raKVGFVzLMHOp+DNpw6yr9B1k4
   ccGlfVg30XjsnUcGet6LOaaN7qapWSDnwMBpzxwHgvA40LsuIQd/6fQ+Z
   WoS7f8nYzBGMX6ysOkIF7md+inKg3BnXy1Do+pIp0YdstXNbY4bb0LiSZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="362115074"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="362115074"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 03:46:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="963948381"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="963948381"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2023 03:46:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C55EC4DA; Thu, 29 Jun 2023 13:46:05 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 2/3] ASoC: rt5677: Use device_get_match_data()
Date:   Thu, 29 Jun 2023 13:46:02 +0300
Message-Id: <20230629104603.88612-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
References: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use device_get_match_data() to simplify the code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/soc/codecs/rt5677.c | 21 ++++-----------------
 sound/soc/codecs/rt5677.h |  4 ++--
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 4ef9c88cb20a..4d09eb2a0755 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -6,7 +6,6 @@
  * Author: Oder Chiou <oder_chiou@realtek.com>
  */
 
-#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -18,7 +17,6 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/firmware.h>
-#include <linux/of_device.h>
 #include <linux/property.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
@@ -5559,6 +5557,7 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 
 static int rt5677_i2c_probe(struct i2c_client *i2c)
 {
+	struct device *dev = &i2c->dev;
 	struct rt5677_priv *rt5677;
 	int ret;
 	unsigned int val;
@@ -5573,21 +5572,9 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
 	INIT_DELAYED_WORK(&rt5677->dsp_work, rt5677_dsp_work);
 	i2c_set_clientdata(i2c, rt5677);
 
-	if (i2c->dev.of_node) {
-		const struct of_device_id *match_id;
-
-		match_id = of_match_device(rt5677_of_match, &i2c->dev);
-		if (match_id)
-			rt5677->type = (enum rt5677_type)match_id->data;
-	} else if (ACPI_HANDLE(&i2c->dev)) {
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(rt5677_acpi_match, &i2c->dev);
-		if (acpi_id)
-			rt5677->type = (enum rt5677_type)acpi_id->driver_data;
-	} else {
+	rt5677->type = (enum rt5677_type)(uintptr_t)device_get_match_data(dev);
+	if (rt5677->type == 0)
 		return -EINVAL;
-	}
 
 	rt5677_read_device_properties(rt5677, &i2c->dev);
 
@@ -5702,7 +5689,7 @@ static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = RT5677_DRV_NAME,
 		.of_match_table = rt5677_of_match,
-		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
+		.acpi_match_table = rt5677_acpi_match,
 	},
 	.probe    = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 944ae02aafc2..5ccdf1ba613a 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1753,8 +1753,8 @@ enum {
 };
 
 enum rt5677_type {
-	RT5677,
-	RT5676,
+	RT5677 = 1,
+	RT5676 = 2,
 };
 
 /* ASRC clock source selection */
-- 
2.40.0.1.gaa8946217a0b

