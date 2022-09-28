Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256025EDB59
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiI1LIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbiI1LH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:57 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77912F594;
        Wed, 28 Sep 2022 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664363133; x=1695899133;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SLyV2jVHkIQf5fwKu3f5DjAStMdYliqR3ajlaFDEgDc=;
  b=dyO3Z0KdeXbUqjiXU4/SiZS4jc9tkc9N3s2ga8F77me+JR/Eg6n0GgZ1
   VusrgH0xcLT2k2aVIwTKWSglGz9+TqGIzbAuhXQsKXxwf07XD03g4eOFP
   /rynP45sDH++j56VLj2C5EN0wWtp3PpayBmcpOEiajXOfzfuIZQHHJEXQ
   5qveXABu8W3x/1n2NEKOBDPci1Mdkpd3IDtqybfY6JOZKVNcCyrFdq2R7
   t5pr8Jkqu5bOd4U23BACEQLLEIAezxnBhUfzmJoyDVHBT0z8FR333wjM9
   EjCgRQkpEM25lup1FkZkFGvXg2Bc6z341GQRICFag8xDjy/P5uXo00HX2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288729724"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="288729724"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="950662517"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="950662517"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2022 04:05:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2C1CC235; Wed, 28 Sep 2022 14:05:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/1] Input: icn8505 - Utilize acpi_get_subsystem_id()
Date:   Wed, 28 Sep 2022 14:05:48 +0300
Message-Id: <20220928110548.43955-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded variant of recently introduced acpi_get_subsystem_id().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: used PTR_ERR_OR_ZERO() amd twek the code accordingly (Dmitry)
 drivers/input/touchscreen/chipone_icn8505.c | 30 +++++++--------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
index f9ca5502ac8c..c421f4be2700 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -364,32 +364,20 @@ static irqreturn_t icn8505_irq(int irq, void *dev_id)
 
 static int icn8505_probe_acpi(struct icn8505_data *icn8505, struct device *dev)
 {
-	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	const char *subsys = "unknown";
-	struct acpi_device *adev;
-	union acpi_object *obj;
-	acpi_status status;
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return -ENODEV;
+	const char *subsys;
+	int error;
 
-	status = acpi_evaluate_object(adev->handle, "_SUB", NULL, &buffer);
-	if (ACPI_SUCCESS(status)) {
-		obj = buffer.pointer;
-		if (obj->type == ACPI_TYPE_STRING)
-			subsys = obj->string.pointer;
-		else
-			dev_warn(dev, "Warning ACPI _SUB did not return a string\n");
-	} else {
-		dev_warn(dev, "Warning ACPI _SUB failed: %#x\n", status);
-		buffer.pointer = NULL;
-	}
+	subsys = acpi_get_subsystem_id(ACPI_HANDLE(dev));
+	error = PTR_ERR_OR_ZERO(subsys);
+	if (error == -ENODATA)
+		subsys = "unknown";
+	else if (error)
+		return error;
 
 	snprintf(icn8505->firmware_name, sizeof(icn8505->firmware_name),
 		 "chipone/icn8505-%s.fw", subsys);
 
-	kfree(buffer.pointer);
+	kfree_const(subsys);
 	return 0;
 }
 
-- 
2.35.1

