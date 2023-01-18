Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB78667198E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjARKqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjARKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:45:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC707855F;
        Wed, 18 Jan 2023 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674035481; x=1705571481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SAZuv1LTCdDrm63pGTGTDfWeIdGXMUVP06EZzEnNzss=;
  b=UD1ma9nXvvH23mxZg/gY85K6l/+c1VhlUqrjSUpmUd8yhA+kmxq5vK+n
   P65FiKMVNVdIU8NJRfUz+MEMl+/Cs/PD9AKxpgK8p+hpE3+VWp1SJVDJv
   jb+LA5GvWivTFeFxav9+x7r5PM+YCXdhNQwi9XFGWGm+BxB/xB5G8XHWp
   D92S9zkXSCK1Z/bT0k1F0sa0bvZf1eiFrp6KOU+KOp94aaySk09LmeKEe
   rifqAlpe1pbbkmHPPpGHJDwOVqY6XpLc8y9ElDvkccv8tYuKIwM1wVbLd
   EgirCz2O+qbIfJ3rY3kXPZ3Yl4pFseNhy6oLsfT+VAFmKee6LXo9igUQf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="352190678"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="352190678"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 01:51:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="988475082"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="988475082"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jan 2023 01:51:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B0187368; Wed, 18 Jan 2023 11:51:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shravan Sudhakar <s.shravan@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v1 1/1] platform/x86: int1092: Switch to use acpi_evaluate_dsm_typed()
Date:   Wed, 18 Jan 2023 11:51:52 +0200
Message-Id: <20230118095152.41427-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index e03943e6380a..20499cafabcb 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -133,14 +133,14 @@ static acpi_status sar_get_device_mode(struct platform_device *device)
 	u32 rev = 0;
 	int value;
 
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
 
@@ -221,11 +221,11 @@ static void sar_get_data(int reg, struct wwan_sar_context *context)
 
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

