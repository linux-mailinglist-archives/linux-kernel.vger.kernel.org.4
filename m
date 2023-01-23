Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4666782A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjAWROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjAWROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:14:15 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18FFE227BA;
        Mon, 23 Jan 2023 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674494054; x=1706030054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0U79zkIHIxmyTykAVQHhm+4844Ljl83bqkEvLyMecqU=;
  b=fYMdyCKRwJlhtKoKpc2crZWXpZRb94yxXdWPMTYIqaHCFTOeU7sg7MHr
   xtnNXiS3z07dXq6/0M3pyM+LIX25DT35+R0p7c6fa5I8yOvjAC2sMO8h/
   trkOayi2NrSbARMv3CMxZKR8AU+ReW56u1IpfqJU4LAyXW0I7H6uGsmwD
   PFBgv4O6VzwIeKuI/wl488Ty5wz7pC8O0mhyH1tVjOIrbKBlcLgSCYVWE
   juE5+UKtMi1nfqdjzmrbIo5Cm8SyiaW5iSjNU1EeV+1GOuFjxrggyfa4O
   vvFJ8/zEFHaPsS3l1S+x6oPyMmJcLEPTyyh7lIeQg+3ayFBRsjb/xHZeR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="324773379"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="324773379"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694006139"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694006139"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 23 Jan 2023 09:09:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D30A1165; Mon, 23 Jan 2023 19:10:15 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 3/3] ACPI: video: Switch to use acpi_get_first_match_physical_node()
Date:   Mon, 23 Jan 2023 19:10:06 +0200
Message-Id: <20230123171006.58274-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
References: <20230123171006.58274-1-andriy.shevchenko@linux.intel.com>
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

Refactor the code to use acpi_get_first_match_physical_node(),
which is currently open coded.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/video_detect.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 0ccde0d4c527..b23773347e67 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -112,16 +112,10 @@ static bool nvidia_wmi_ec_supported(void)
 
 static bool apple_gmux_backlight_present(void)
 {
-	struct acpi_device *adev;
 	struct device *dev;
 	bool ret;
 
-	adev = acpi_dev_get_first_match_dev(GMUX_ACPI_HID, NULL, -1);
-	if (!adev)
-		return false;
-
-	dev = get_device(acpi_get_first_physical_node(adev));
-	acpi_dev_put(adev);
+	dev = acpi_get_first_match_physical_node(GMUX_ACPI_HID, NULL, -1);
 	if (!dev)
 		return false;
 
-- 
2.39.0

