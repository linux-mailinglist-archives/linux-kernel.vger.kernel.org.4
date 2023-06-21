Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00173889B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjFUPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjFUPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:16:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2302B5254;
        Wed, 21 Jun 2023 08:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687360312; x=1718896312;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=avPldn+bfrcBhDUfOYNR74bNnMBvVnz4MZjZ32hxuoE=;
  b=GFLP5JDI7/6kbhhGidyyOFWpiTV2k10kTnNZtqVcbVE/PtWR07jX406w
   tpuGjtJ64HwAzDs7Fc1McxzTsN7gIzuJZPl9vN+JKAcxeliBIS6hM7bBK
   h2siX21VObUav1gwF/I3OxY8/bVDnbPorGnXRVegzflqy001nQ1c34dZT
   FPkOTq8H4J2W4hNZTQvfCL2iEm6eoze2oLAMoc+triLEBbEFpctPUjclZ
   i2+0lcVKCXXyh+BycKBOksNGDZhGN80wrJ2Cvi5k7MxaArW7gfC0vaQrC
   eqi6lls0rKztIbaJvEpz3PVfyxoT9L9CBuHmxrJj01wCh0wPR8NwiwlkP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="344937863"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="344937863"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 08:11:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827489542"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="827489542"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 08:11:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E6291FD; Wed, 21 Jun 2023 18:11:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] platform/x86: wmi: Break possible infinite loop when parsing GUID
Date:   Wed, 21 Jun 2023 18:11:54 +0300
Message-Id: <20230621151155.78279-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The while-loop may break on one of the two conditions, either ID string
is empty or GUID matches. The second one, may never be reached if the
parsed string is not correct GUID. In such a case the loop will never
advance to check the next ID.

Break possible infinite loop by factoring out guid_parse_and_compare()
helper which may be moved to the generic header for everyone later on
and preventing from similar mistake in the future.

Interestingly that firstly it appeared when WMI was turned into a bus
driver, but later when duplicated GUIDs were checked, the while-loop
has been replaced by for-loop and hence no mistake made again.

Fixes: a48e23385fcf ("platform/x86: wmi: add context pointer field to struct wmi_device_id")
Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/wmi.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 5b95d7aa5c2f..098512a53170 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -136,6 +136,16 @@ static acpi_status find_guid(const char *guid_string, struct wmi_block **out)
 	return AE_NOT_FOUND;
 }
 
+static bool guid_parse_and_compare(const char *string, const guid_t *guid)
+{
+	guid_t guid_input;
+
+	if (guid_parse(string, &guid_input))
+		return false;
+
+	return guid_equal(&guid_input, guid);
+}
+
 static const void *find_guid_context(struct wmi_block *wblock,
 				     struct wmi_driver *wdriver)
 {
@@ -146,11 +156,7 @@ static const void *find_guid_context(struct wmi_block *wblock,
 		return NULL;
 
 	while (*id->guid_string) {
-		guid_t guid_input;
-
-		if (guid_parse(id->guid_string, &guid_input))
-			continue;
-		if (guid_equal(&wblock->gblock.guid, &guid_input))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return id->context;
 		id++;
 	}
@@ -895,11 +901,7 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 		return 0;
 
 	while (*id->guid_string) {
-		guid_t driver_guid;
-
-		if (WARN_ON(guid_parse(id->guid_string, &driver_guid)))
-			continue;
-		if (guid_equal(&driver_guid, &wblock->gblock.guid))
+		if (guid_parse_and_compare(id->guid_string, &wblock->gblock.guid))
 			return 1;
 
 		id++;
-- 
2.40.0.1.gaa8946217a0b

