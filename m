Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97026EA011
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjDTXhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjDTXhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:37:01 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC51FDE;
        Thu, 20 Apr 2023 16:36:59 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Q2Yw616sqz9sRf;
        Fri, 21 Apr 2023 01:36:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
        s=MBO0001; t=1682033814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=csCjhgR/SJOt5QRcWIgsZZAjRac984Esza3qjXOQaaY=;
        b=h6Jcv5eYzbYH4wRpMRe+JH45ui7W/AQtCpzQIhVFY35wLnSKB6FpZ4v/itpyXbpxNKBooW
        t9syyE4Im0/W1CDE8u1XKjjgXkQ7LEonNWJar0vjvVpvx/b7SBA5VVqGcb0hCeuvl+jFA4
        huOAMoipUC3M/eAbeNQed7zIFAp/JhKxaIlGgOnCY3pul41gO6pDs4e7eNvxdBD1AxGhg7
        hxEhcpMm2bW6clLmRGCLT3clVf/ukKr6fOcb7uFiO6D3/++lSh+f16tw/YjLZ9X+ZCZ62W
        L8sf1SQvwERkzrbkTjIo2uRq5vgsBvC17rK2Tu6a+6b58n8f4Bw9XIUJU1P8Lg==
From:   Marius Hoch <mail@mariushoch.de>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Marius Hoch <mail@mariushoch.de>
Subject: [PATCH v2] iio: light: al3320a: Handle ACPI device CALS0001
Date:   Fri, 21 Apr 2023 01:26:31 +0200
Message-Id: <20230420232631.68864-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sensor can be found as CALS0001 on the Lenovo Yoga
Tablet 2 series.

Tested on a Lenovo Yoga Tablet 2 1051-F.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
v2: Explicitly include <linux/mod_devicetable.h> (don't rely on
linux/i2c.h including it)
---
 drivers/iio/light/al3320a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 9ff28bbf34bb..36214d790f71 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -247,11 +248,18 @@ static const struct of_device_id al3320a_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, al3320a_of_match);
 
+static const struct acpi_device_id al3320a_acpi_match[] = {
+	{"CALS0001"},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, al3320a_acpi_match);
+
 static struct i2c_driver al3320a_driver = {
 	.driver = {
 		.name = AL3320A_DRV_NAME,
 		.of_match_table = al3320a_of_match,
 		.pm = pm_sleep_ptr(&al3320a_pm_ops),
+		.acpi_match_table = al3320a_acpi_match,
 	},
 	.probe_new	= al3320a_probe,
 	.id_table	= al3320a_id,

base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f
-- 
2.39.2

