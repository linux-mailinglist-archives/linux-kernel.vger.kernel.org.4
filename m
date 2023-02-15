Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2596978E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjBOJZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBOJZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:25:20 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552737561;
        Wed, 15 Feb 2023 01:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676453083; x=1707989083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9R9iKXEYRdJH2srCozT/f+4nFR+6Npl84e55McaFgGA=;
  b=FlpT3FSwEuY2L7FWBZPCIRuA792D5FqccmYJL5p7ZrSZdur1U/J9efl1
   rH9mQO/BaenZiL8RrE7Pr5qkiI4C2HZrYR96PGcY6rgeWZrKgNnuRGtaE
   YeLLaSvy4UnC8pQCeunMC5JSXbht54pgSzf/3sMV1Hgc9wyHFULF/SUiV
   7ZH0uPNLpcgFjSOAaq2xf+zeEksVUjDsoZdeErLtOEmAmsCPkNFGrmGZ1
   ZyvCJKgkORX69WQutjxjePOsIqJMxc9Q574wWKreX9Fo6ByX8GYlJooOj
   FETbFTun40K3YRVQSDCKWj6OKu8qne9ab5OmmhO5zaiquSMt7Hwa1X3o4
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29094642"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 15 Feb 2023 10:24:28 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 15 Feb 2023 10:24:28 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 15 Feb 2023 10:24:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1676453068; x=1707989068;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9R9iKXEYRdJH2srCozT/f+4nFR+6Npl84e55McaFgGA=;
  b=pMkXESgxqsBcK9UvItdNhaI6zBIbZpFFpYv9U/fOnajAzx7DDqtCSwpP
   6ImZvKgl6nQpTDWGQx8dHOvCggR4gWKxCpk+3jngyf6RYLdninhXA1nMm
   82E84CzwGOxS7cnsPECBmX+s+B5D1BhzLRc78M6syQZJ+oLHibJeIHNl5
   N2pu0d+yfT21t9r5Hw6g3/ewHldWEoHkKXAftuq3xv3FB3zGr8MlzEi6C
   qJHPOY96ut5fFj2lZYgQIR64pporzwxOa+Q0SCqLi1zrBw9A47r+qozCx
   a0t3SqYfWKHpLtvpY/JoZ3AVr3H68cZaAUEDwQberX45v0MjlQ1zHrDHC
   w==;
X-IronPort-AV: E=Sophos;i="5.97,299,1669071600"; 
   d="scan'208";a="29094641"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2023 10:24:28 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 52C2E280056;
        Wed, 15 Feb 2023 10:24:28 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] gpiolib: allow device numbering using OF alias
Date:   Wed, 15 Feb 2023 10:24:21 +0100
Message-Id: <20230215092421.143199-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

This is useful e.g. for the following cases

- GPIO IP name order is not aligned with SOC addresses
  (i.MX93 from NXP)
- reproducible naming for GPIO expander chips

The implementation is a mix of the one found for MMC and RTC.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
imx93 specifies alias for 4 on-chip GPIO controllers. But they are
ignored:
$ ls -o -g /sys/bus/gpio/devices/
total 0
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip0 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0071/gpiochip0
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip1 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0072/gpiochip1
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip2 -> ../../../devices/platform/soc@0/43810080.gpio/gpiochip2
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip3 -> ../../../devices/platform/soc@0/43820080.gpio/gpiochip3
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip4 -> ../../../devices/platform/soc@0/43830080.gpio/gpiochip4
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip5 -> ../../../devices/platform/soc@0/47400080.gpio/gpiochip5
lrwxrwxrwx 1 0 Feb 15 10:03 gpiochip6 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0070/gpiochip6

With this patch this becomes:
$ ls -o -g /sys/bus/gpio/devices/
total 0
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip0 -> ../../../devices/platform/soc@0/47400080.gpio/gpiochip0
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip1 -> ../../../devices/platform/soc@0/43810080.gpio/gpiochip1
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip2 -> ../../../devices/platform/soc@0/43820080.gpio/gpiochip2
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip3 -> ../../../devices/platform/soc@0/43830080.gpio/gpiochip3
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip4 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0071/gpiochip4
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip5 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0072/gpiochip5
lrwxrwxrwx 1 0 Feb 15 10:18 gpiochip6 -> ../../../devices/platform/soc@0/42000000.bus/42530000.i2c/i2c-2/2-0070/gpiochip6

 drivers/gpio/gpiolib.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 19bd23044b01..4d606ad522ac 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -663,10 +663,25 @@ static void gpiochip_setup_devs(void)
 	}
 }
 
+/**
+ * gpio_first_nonreserved_index() - get the first index that is not reserved
+ */
+static int gpio_first_nonreserved_index(void)
+{
+	int max;
+
+	max = of_alias_get_highest_id("gpio");
+	if (max < 0)
+		return 0;
+
+	return max + 1;
+}
+
 int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 			       struct lock_class_key *lock_key,
 			       struct lock_class_key *request_key)
 {
+	int index, alias_id, min_idx;
 	struct fwnode_handle *fwnode = NULL;
 	struct gpio_device *gdev;
 	unsigned long flags;
@@ -696,12 +711,22 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 	device_set_node(&gdev->dev, gc->fwnode);
 
-	gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
-	if (gdev->id < 0) {
-		ret = gdev->id;
-		goto err_free_gdev;
+	alias_id = of_alias_get_id(to_of_node(gc->fwnode), "gpio");
+	if (alias_id >= 0) {
+		index = ida_simple_get(&gpio_ida, alias_id, alias_id + 1,
+				       GFP_KERNEL);
+	} else {
+		min_idx = gpio_first_nonreserved_index();
+		index = ida_simple_get(&gpio_ida, min_idx, 0,
+				       GFP_KERNEL);
+		if (index < 0) {
+			ret = gdev->id;
+			goto err_free_gdev;
+		}
 	}
 
+	gdev->id = index;
+
 	ret = dev_set_name(&gdev->dev, GPIOCHIP_NAME "%d", gdev->id);
 	if (ret)
 		goto err_free_ida;
-- 
2.34.1

