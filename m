Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F011744118
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjF3RWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjF3RWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:22:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03654421F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688145718; x=1719681718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xfinsx2cbNjgygxyV5dAX8kY09FdNFlEzPlxBJeXw0c=;
  b=DqtypnIMIof3PuovmXvz1BV39KBnJilJF3fquNMTlGZLyisk8F0K6jFY
   Lwd1lNWMw4JWupzJ0m2bhXjWimmkOHVNQbVFc8Xf8x/O1ok/PmLQw64y+
   eyv2JHBv96+YgAgq+zZeTpSDW3ed0z20wiZQGfsqzQMEvIYhcOyaX2DXA
   hby126NWEaEtrs8Vrzt620FrZOcH0tFQnrGQk3mtg9adY/HXt/JCDBiUa
   c2zxE95wRF2tofJ463LcP8JHHXQXCCoD1mDcu+Nbpn/HTauaVNfbgSMqY
   CuMTW8kHtNSPIqaZNxZJfGROSGdjgrTXfSfwmKlYlFA6CHBfQAHHdU3Ad
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="361298319"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="361298319"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="747486144"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="747486144"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2023 10:21:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E97F5516; Fri, 30 Jun 2023 20:21:57 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 3/4] ASoC: rt5677: Use device_get_match_data()
Date:   Fri, 30 Jun 2023 20:21:54 +0300
Message-Id: <20230630172155.83754-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 17d5dd5d2974..b0c15e27c763 100644
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
@@ -5531,6 +5529,7 @@ static int rt5677_init_irq(struct i2c_client *i2c)
 
 static int rt5677_i2c_probe(struct i2c_client *i2c)
 {
+	struct device *dev = &i2c->dev;
 	struct rt5677_priv *rt5677;
 	int ret;
 	unsigned int val;
@@ -5545,21 +5544,9 @@ static int rt5677_i2c_probe(struct i2c_client *i2c)
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
 
@@ -5674,7 +5661,7 @@ static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
 		.name = RT5677_DRV_NAME,
 		.of_match_table = rt5677_of_match,
-		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
+		.acpi_match_table = rt5677_acpi_match,
 	},
 	.probe    = rt5677_i2c_probe,
 	.remove   = rt5677_i2c_remove,
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 5932b04cf85e..d67ebae067d9 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1691,8 +1691,8 @@ enum {
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

