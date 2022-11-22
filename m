Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AA763446D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 20:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiKVTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 14:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiKVTSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 14:18:09 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F1724F28;
        Tue, 22 Nov 2022 11:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669144687; x=1700680687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JzC+t1MWJwxB8Fmck04OqHk780e/xmaFSEEbGTIwRWo=;
  b=hRCmGYuAGEKqeIZOQ+r0VrJ2TBJzn8Uu7Qu7qejRvy4hShz4SCAXpDBf
   17eRIDePxq101OGsVGnIDGUBC/JCeeTVsnpJxqKVNEzI0I6Yo9c5pN7HH
   Us9ILDYqhr17HQ1Ti18gTmoKg3HLua/Oafj/ral8EHTig2rYrYZsRGBTk
   Eg3VwjDP1HYeE0fwRajgJojRisqphczsZL2mmLrk4cxr5ansMYtI2vKIl
   cHeFZ/IiUG8N9c0FXYNXsetdIixYjm7YasX2Q/2PJkZ8DTl1QA7CZwtL2
   djzkQEO8O472maQOY4YMhllyKNCfyW6zv3kgHTNHAIN85aWj67vGhCBcs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315716801"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="315716801"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 11:18:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="730515659"
X-IronPort-AV: E=Sophos;i="5.96,184,1665471600"; 
   d="scan'208";a="730515659"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Nov 2022 11:18:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7F37F128; Tue, 22 Nov 2022 21:18:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 1/2] HID: i2c-hid: acpi: Drop unneded NULL check of adev
Date:   Tue, 22 Nov 2022 21:18:20 +0200
Message-Id: <20221122191821.18076-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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
 drivers/hid/i2c-hid/i2c-hid-acpi.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i2c-hid-acpi.c
index b96ae15e0ad9..661a87dbd584 100644
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
 
 	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
 		device_set_wakeup_capable(dev, true);
-- 
2.35.1

