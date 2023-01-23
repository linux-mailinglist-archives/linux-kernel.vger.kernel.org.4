Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947CD6782B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjAWRP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjAWRPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:15:22 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC152CC55;
        Mon, 23 Jan 2023 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674494114; x=1706030114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/DBnlX2nHw8xdE1A7dfpSiRzHDfuI95hSDjM/i9Kzow=;
  b=YisKAmcEsusnIBZwQXx2fFjo+zxnt0nELBJj2KSgMBjiw9BdJKJN2FqT
   KGorQyMznTqkRI48vdkq3vBNUdn8hcvDur+eOoenkm8c5ZAKc9uLH1aQ9
   7tcCmShxvqignrXj096zYOUw2B202QzOWmhBPSjH4ExHHTKSJaybK874l
   lSzR5rXEO0QPVAVAgneA/zmi0RUfikR1QeyPNWl53g8zrnKIv7/gNNDDh
   X2dtKTbGkR01EkdFL1qhzgVaGSmP0ICcLp8RWnIrerUPdpJ/fcElsDiZk
   Jiq6dGRP/4t03p6KDCFzeuMd6xAnEWV2Z49NCnk3Ex2KdkLKznR5thYI4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="328182987"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="328182987"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:09:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="639261262"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="639261262"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 23 Jan 2023 09:09:38 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A777119; Mon, 23 Jan 2023 19:10:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 1/3] ACPI: video: Fix refcounting in apple_gmux_backlight_present()
Date:   Mon, 23 Jan 2023 19:10:04 +0200
Message-Id: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
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

acpi_dev_get_first_match_dev() gets ACPI device with the bumped
refcount. The caller must drop it when it's done.

Fix ACPI device refcounting in apple_gmux_backlight_present().

Fixes: 3cf3b7f012f3 ("ACPI: video: Fix Apple GMUX backlight detection")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/video_detect.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 65cec7bb6d96..0ccde0d4c527 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -114,12 +114,14 @@ static bool apple_gmux_backlight_present(void)
 {
 	struct acpi_device *adev;
 	struct device *dev;
+	bool ret;
 
 	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
 	if (!adev)
 		return false;
 
-	dev = acpi_get_first_physical_node(adev);
+	dev = get_device(acpi_get_first_physical_node(adev));
+	acpi_dev_put(adev);
 	if (!dev)
 		return false;
 
@@ -127,7 +129,9 @@ static bool apple_gmux_backlight_present(void)
 	 * drivers/platform/x86/apple-gmux.c only supports old style
 	 * Apple GMUX with an IO-resource.
 	 */
-	return pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
+	ret = pnp_get_resource(to_pnp_dev(dev), IORESOURCE_IO, 0) != NULL;
+	put_device(dev);
+	return ret;
 }
 
 /* Force to use vendor driver when the ACPI device is known to be
-- 
2.39.0

