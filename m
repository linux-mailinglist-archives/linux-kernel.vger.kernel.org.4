Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3196B4D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCJQpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjCJQoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:44:30 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB38763FA;
        Fri, 10 Mar 2023 08:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466524; x=1710002524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RuQJbwPk2IdSAncLuUQNGHBqnHMz8cKVApAA9xFGFog=;
  b=GOv7nqRjE8NIID4/AILuVfEbFirfRws7mW8gkGDZTRedpxjNXpJNJ1gl
   yuaZKihsX3sVtc2DhLqVmvEmWK5e63tur4LU0BDW4sgtPLpcFUsYE6z+g
   Y2N3u+rIc/Ptz6V0r57P+wFH54InqWPVMK9X88MP2FkeEMz6jmPuSA3tZ
   qlfRcVM36FwT4LhdvnPYJ+IS1OnhuljnU7+y90Xbxcp3vVHTQ88QKtCCj
   DCnVFfr+uQrBMBJf4GSYiWtfY31ea1VoT4vRnaL6CJlOnhXLXjMUELJ47
   YGoQgmYkdIiZ0F7Kc48ww8CNu+PgX6FNsZ9zGicuk8ruG8VhLd/dZ4L4O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="335466771"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="335466771"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:40:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="710331265"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="710331265"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2023 08:40:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 47424143; Fri, 10 Mar 2023 18:41:30 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [resend, PATCH v1 1/1] usb: acpi: Switch to use acpi_evaluate_dsm_typed()
Date:   Fri, 10 Mar 2023 18:41:29 +0200
Message-Id: <20230310164129.21937-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi_evaluate_dsm_typed() provides a way to check the type of the
object evaluated by _DSM call. Use it instead of open coded variant.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
resend, v1: resent after v6.3-rc1 (Greg)
 drivers/usb/core/usb-acpi.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index 533baa85083c..a34b22537d7c 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -81,15 +81,11 @@ int usb_acpi_port_lpm_incapable(struct usb_device *hdev, int index)
 		return -ENODEV;
 	}
 
-	obj = acpi_evaluate_dsm(port_handle, &guid, 0,
-				USB_DSM_DISABLE_U1_U2_FOR_PORT, NULL);
-
-	if (!obj)
-		return -ENODEV;
-
-	if (obj->type != ACPI_TYPE_INTEGER) {
+	obj = acpi_evaluate_dsm_typed(port_handle, &guid, 0,
+				      USB_DSM_DISABLE_U1_U2_FOR_PORT, NULL,
+				      ACPI_TYPE_INTEGER);
+	if (!obj) {
 		dev_dbg(&hdev->dev, "evaluate port-%d _DSM failed\n", port1);
-		ACPI_FREE(obj);
 		return -EINVAL;
 	}
 
-- 
2.39.1

