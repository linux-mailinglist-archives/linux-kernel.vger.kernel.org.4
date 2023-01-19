Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2330674093
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjASSIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjASSIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:08:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252D6923B;
        Thu, 19 Jan 2023 10:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674151720; x=1705687720;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2HAQeZRGLc90JRhljo6mi9VHqdlbvFwzbqo8cX32v/0=;
  b=AHYOqvsKPjG3X/qVVmvmxzjnOJvIxqOHBoiRNiZzk4FWpdXUa/k04AVh
   dnRg1FKy73QgFQH618pzfVIfgRiHJH7Tyseu6jTVVAXfGQHDUFB0+RteF
   G0cBkuwHKlCfQOhD3QUbNAKzFi5XS15UisOLa3DSzGNb9h/x5+0zSv+YG
   /T4GJP9JAVtyU7UwQ5PIUFgfJg7/67JURujhR+T2GQwbdaKCQzPkynO8l
   viIV4pQ5Ly1eh8gu/YDmdWRnVmuSfbS9RjgMfrn8OwYkIe2LZcnYProMa
   6P3mNAO0bW0sqM5a6REQ98QG5bsoCm4wrgrM1i4wl7vAKZiodMd4vggrn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="324056716"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="324056716"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 10:08:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="802733896"
X-IronPort-AV: E=Sophos;i="5.97,229,1669104000"; 
   d="scan'208";a="802733896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jan 2023 10:08:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A144C36D; Thu, 19 Jan 2023 20:09:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shravan Sudhakar <s.shravan@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v2 1/1] platform/x86: int1092: Switch to use acpi_evaluate_dsm_typed()
Date:   Thu, 19 Jan 2023 20:09:04 +0200
Message-Id: <20230119180904.78446-1-andriy.shevchenko@linux.intel.com>
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

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: removed unused variable (LKP)
 drivers/platform/x86/intel/int1092/intel_sar.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index e03943e6380a..352fc4596494 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -131,16 +131,15 @@ static acpi_status sar_get_device_mode(struct platform_device *device)
 	acpi_status status = AE_OK;
 	union acpi_object *out;
 	u32 rev = 0;
-	int value;
 
-	out = acpi_evaluate_dsm(context->handle, &context->guid, rev,
-				COMMAND_ID_DEV_MODE, NULL);
-	if (get_int_value(out, &value)) {
+	out = acpi_evaluate_dsm_typed(context->handle, &context->guid, rev,
+				      COMMAND_ID_DEV_MODE, NULL, ACPI_TYPE_INTEGER);
+	if (!out) {
 		dev_err(&device->dev, "DSM cmd:%d Failed to retrieve value\n", COMMAND_ID_DEV_MODE);
 		status = AE_ERROR;
 		goto dev_mode_error;
 	}
-	context->sar_data.device_mode = value;
+	context->sar_data.device_mode = out->integer.value;
 	update_sar_data(context);
 	sysfs_notify(&device->dev.kobj, NULL, SYSFS_DATANAME);
 
@@ -221,11 +220,11 @@ static void sar_get_data(int reg, struct wwan_sar_context *context)
 
 	req.type = ACPI_TYPE_INTEGER;
 	req.integer.value = reg;
-	out = acpi_evaluate_dsm(context->handle, &context->guid, rev,
-				COMMAND_ID_CONFIG_TABLE, &req);
+	out = acpi_evaluate_dsm_typed(context->handle, &context->guid, rev,
+				      COMMAND_ID_CONFIG_TABLE, &req, ACPI_TYPE_PACKAGE);
 	if (!out)
 		return;
-	if (out->type == ACPI_TYPE_PACKAGE && out->package.count >= 3 &&
+	if (out->package.count >= 3 &&
 	    out->package.elements[0].type == ACPI_TYPE_INTEGER &&
 	    out->package.elements[1].type == ACPI_TYPE_INTEGER &&
 	    out->package.elements[2].type == ACPI_TYPE_PACKAGE &&
-- 
2.39.0

