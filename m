Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1867168E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjARIwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjARIwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:52:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354B5D917;
        Wed, 18 Jan 2023 00:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674029051; x=1705565051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JbyoyULxuDQD7DcV3gzSYDDU8vRCK87BqFyBt9ZRusA=;
  b=fciArdk0vwXamoxyjYmG9jN+aLCPdUSk4YSVq02Oeuiu+J/+xDqCtUdh
   FiGYPpH1tpzi9Wix1So1UsH+4BRxgtV3CinH0OnHfHno2iMCip+WilKFi
   nRK0gKsbGShrj7elv/W8uiJgEwAr6QEBUximgcffuLz/AX7X1RAqqf6M+
   eHA+N1+tOHUwmvm9R8BiN0V6RLaDUiPcvpaTP3dSHR+j/2R/YQz98FjkH
   dFWhZexnoZm8DpQYGE/CgYh9ge21tN1RJY2ipjl/ue8rBI2qtUN4PIypG
   FaTGIYqzPKMc29WrbrPW280HjGmJfr4TZttkVcT8cyKV26mC/Nstk/0AI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="411164489"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="411164489"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 00:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="637176612"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="637176612"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 18 Jan 2023 00:03:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D64CD256; Wed, 18 Jan 2023 10:04:21 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] usb: acpi: Switch to use acpi_evaluate_dsm_typed()
Date:   Wed, 18 Jan 2023 10:04:19 +0200
Message-Id: <20230118080419.20880-1-andriy.shevchenko@linux.intel.com>
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
2.39.0

