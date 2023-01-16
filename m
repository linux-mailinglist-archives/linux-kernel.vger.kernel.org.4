Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0924566C43D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjAPPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjAPPpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:45:52 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1051CAF6;
        Mon, 16 Jan 2023 07:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673883951; x=1705419951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+T4A+gAKP73DaKAeDy8LTC+///XJBTvfy40Dwpk4qRI=;
  b=HZa1gzkxcjMu7zfTPiG6ADYrMyLmckZVJCrEO1ynstBMy/A8ir36Gy7J
   5rdq4NonJABFzquM5/v+PIUpU7d5EQ9Wv/GBeYObzbsHSN47GQs15JjIB
   Ku5qCzXSPk8cN0nieI7DIdzAzlhRimSRxNXqqUdEByrQHxl04bwXPvfe9
   6yR9+k3lOYB6AemqawnY+1FRd+d+23fwnBJbBqOG2m0Co5IyMKc1q1HiV
   6s4PguReFyQQhyP5BSRIl/rWtf2D6idtQvbT+eLgCJvbicsQTzovu7LjV
   7KbxYeG/YSoPDUh8XamJ6J201IFdOYbnHzj34xgoHodAbD+ZHCBwO0qGJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410737025"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="410737025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 07:45:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="689517173"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="689517173"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 16 Jan 2023 07:45:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5BFE7E1; Mon, 16 Jan 2023 17:46:23 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] HID: i2c-hid: acpi: Drop unneded NULL check of adev
Date:   Mon, 16 Jan 2023 17:46:20 +0200
Message-Id: <20230116154621.16135-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is enumerated on ACPI platforms, so adev is valid.
Since there is no valid I²C ID table provided, there is no
possibility to bind a device to this driver via user space.
Hence, drop unneeded NULL check of adev.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index 375c77c3db74..5e28da45e762 100644
--- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
+++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
@@ -48,8 +48,9 @@ static guid_t i2c_hid_guid =
 	GUID_INIT(0x3CDFF6F7, 0x4267, 0x4555,
 		  0xAD, 0x05, 0xB3, 0x0A, 0x3D, 0x89, 0x38, 0xDE);
 
-static int i2c_hid_acpi_get_descriptor(struct acpi_device *adev)
+static int i2c_hid_acpi_get_descriptor(struct i2c_hid_acpi *ihid_acpi)
 {
+	struct acpi_device *adev = ihid_acpi->adev;
 	acpi_handle handle = acpi_device_handle(adev);
 	union acpi_object *obj;
 	u16 hid_descriptor_address;
@@ -81,29 +82,22 @@ static int i2c_hid_acpi_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct i2c_hid_acpi *ihid_acpi;
-	struct acpi_device *adev;
 	u16 hid_descriptor_address;
 	int ret;
 
-	adev = ACPI_COMPANION(dev);
-	if (!adev) {
-		dev_err(&client->dev, "Error could not get ACPI device\n");
-		return -ENODEV;
-	}
-
 	ihid_acpi = devm_kzalloc(&client->dev, sizeof(*ihid_acpi), GFP_KERNEL);
 	if (!ihid_acpi)
 		return -ENOMEM;
 
-	ihid_acpi->adev = adev;
+	ihid_acpi->adev = ACPI_COMPANION(dev);
 	ihid_acpi->ops.shutdown_tail = i2c_hid_acpi_shutdown_tail;
 
-	ret = i2c_hid_acpi_get_descriptor(adev);
+	ret = i2c_hid_acpi_get_descriptor(ihid_acpi);
 	if (ret < 0)
 		return ret;
 	hid_descriptor_address = ret;
 
-	acpi_device_fix_up_power(adev);
+	acpi_device_fix_up_power(ihid_acpi->adev);
 
 	return i2c_hid_core_probe(client, &ihid_acpi->ops,
 				  hid_descriptor_address, 0);
-- 
2.39.0

