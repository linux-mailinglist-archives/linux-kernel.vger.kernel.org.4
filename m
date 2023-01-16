Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71A66BE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjAPMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAPMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:46:35 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565713A9D;
        Mon, 16 Jan 2023 04:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673873194; x=1705409194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BwXZVfB+xF4aartu15hkES7lfjOUi/vmIT0fRE7IbyM=;
  b=TJZTGM3Wrv7m1D6vLl7IVK1nIjHSaOvX6Xifqm99PpiM16bdf6WC0kiT
   YSf9r/zSuXJI11xM0aoURxto1QUTcvllgQn267XoEVB+2wNM2iSkStEYa
   k8nd1pBjaNJmK5WiGoTEtZF6snJmfswCGclBLfhY199n6BK+oBMatRYqt
   MPoP3QNvFqFbaSXrbdSsfO9OWhD7S5Q3zr7vqVeNWBVX36N/uOyLtonYy
   /JXYW2BE2OVdz5ajR4+dPvtUIGkldizA2dlQ4fZ4VSDzVu15ZyNK17d1R
   rMXDr3NPeMgYUnf3NCpikgm/tWiYrmLVrUs5IGmQgaK4jvLDWmF0xkFIR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="312306377"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="312306377"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 04:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="987791362"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="987791362"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jan 2023 04:46:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BBCF914B; Mon, 16 Jan 2023 14:47:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 2/3] gpio: pcf857x: Make use of device properties
Date:   Mon, 16 Jan 2023 14:47:03 +0200
Message-Id: <20230116124704.30470-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
References: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
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

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Add mod_devicetable.h include.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pcf857x.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index dfa15444a24a..9d34776109db 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -11,9 +11,9 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -35,7 +35,6 @@ static const struct i2c_device_id pcf857x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pcf857x_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id pcf857x_of_table[] = {
 	{ .compatible = "nxp,pcf8574" },
 	{ .compatible = "nxp,pcf8574a" },
@@ -53,7 +52,6 @@ static const struct of_device_id pcf857x_of_table[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pcf857x_of_table);
-#endif
 
 /*
  * The pcf857x, pca857x, and pca967x chips only expose one read and one
@@ -275,12 +273,11 @@ static const struct irq_chip pcf857x_irq_chip = {
 static int pcf857x_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	struct device_node *np = client->dev.of_node;
 	struct pcf857x *gpio;
 	unsigned int n_latch = 0;
 	int status;
 
-	of_property_read_u32(np, "lines-initial-states", &n_latch);
+	device_property_read_u32(&client->dev, "lines-initial-states", &n_latch);
 
 	/* Allocate, initialize, and register this gpio_chip. */
 	gpio = devm_kzalloc(&client->dev, sizeof(*gpio), GFP_KERNEL);
@@ -420,7 +417,7 @@ static void pcf857x_shutdown(struct i2c_client *client)
 static struct i2c_driver pcf857x_driver = {
 	.driver = {
 		.name	= "pcf857x",
-		.of_match_table = of_match_ptr(pcf857x_of_table),
+		.of_match_table = pcf857x_of_table,
 	},
 	.probe_new = pcf857x_probe,
 	.shutdown = pcf857x_shutdown,
-- 
2.39.0

