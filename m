Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EBA601D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 01:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJQXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 19:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJQXe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 19:34:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9571AE65;
        Mon, 17 Oct 2022 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666049696; x=1697585696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q7gifIbAGnfqIQa317CCU6jq49uc6FOfKfZTEgyZZeU=;
  b=LsY2c+aKpkkKu59h5v+OvIbzTb4BPtdKeHYG0B2fWQ1HXJSDQHonIjj+
   fnFumz6entw4mi/pNTyLZwNJNc3bBQt050LXShLrfQcaGaYUKKIpwFHly
   zsT8XC4WTbx14XTKXtpD6Q4AM+nGIAO+v1C8TSxEGcGt6yUNrwnccKfIZ
   gLvvE33g1SfDzgxWG5v0VuBx90pNH294jBOFtOsnALvpn/olOMxM0KOQU
   IUV/hOXHl9D0B0+6QawAzWx96Eosy4uhEFrnXJbVprTyMc1dhplEl57GH
   jCG2iHgeeHaD9qD5iBeZyqZ11YYzYtN1XcY5dINtY3nRxwvQTaMOHsomo
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="289240539"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="289240539"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 16:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="753811623"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="753811623"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 17 Oct 2022 16:34:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B986717F; Tue, 18 Oct 2022 02:35:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Steev Klimaszewski <steev@kali.org>
Subject: [PATCH v1 1/1] usb: dwc3: Don't switch OTG -> peripheral if extcon is present
Date:   Tue, 18 Oct 2022 02:35:10 +0300
Message-Id: <20221017233510.53336-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Smirnov <andrew.smirnov@gmail.com>

If the extcon device exists, get the mode from the extcon device. If
the controller is DRD and the driver is unable to determine the mode,
only then default the dr_mode to USB_DR_MODE_PERIPHERAL.

Reported-by: Steev Klimaszewski <steev@kali.org>
Fixes: 7a84e7353e23 ("Revert "usb: dwc3: Don't switch OTG -> peripheral if extcon is present"")
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/dwc3/core.c | 49 +++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/drd.c  | 50 -----------------------------------------
 2 files changed, 48 insertions(+), 51 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index ea51624461b5..c0e7c76dc5c8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/reset.h>
@@ -85,7 +86,7 @@ static int dwc3_get_dr_mode(struct dwc3 *dwc)
 		 * mode. If the controller supports DRD but the dr_mode is not
 		 * specified or set to OTG, then set the mode to peripheral.
 		 */
-		if (mode == USB_DR_MODE_OTG &&
+		if (mode == USB_DR_MODE_OTG && !dwc->edev &&
 		    (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
 		     !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
 		    !DWC3_VER_IS_PRIOR(DWC3, 330A))
@@ -1690,6 +1691,46 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	}
 }
 
+static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	struct device_node *np_phy;
+	struct extcon_dev *edev = NULL;
+	const char *name;
+
+	if (device_property_read_bool(dev, "extcon"))
+		return extcon_get_edev_by_phandle(dev, 0);
+
+	/*
+	 * Device tree platforms should get extcon via phandle.
+	 * On ACPI platforms, we get the name from a device property.
+	 * This device property is for kernel internal use only and
+	 * is expected to be set by the glue code.
+	 */
+	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
+		return extcon_get_extcon_dev(name);
+
+	/*
+	 * Try to get an extcon device from the USB PHY controller's "port"
+	 * node. Check if it has the "port" node first, to avoid printing the
+	 * error message from underlying code, as it's a valid case: extcon
+	 * device (and "port" node) may be missing in case of "usb-role-switch"
+	 * or OTG mode.
+	 */
+	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
+	if (of_graph_is_present(np_phy)) {
+		struct device_node *np_conn;
+
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+		if (np_conn)
+			edev = extcon_find_edev_by_node(np_conn);
+		of_node_put(np_conn);
+	}
+	of_node_put(np_phy);
+
+	return edev;
+}
+
 static int dwc3_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -1840,6 +1881,12 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
+	dwc->edev = dwc3_get_extcon(dwc);
+	if (IS_ERR(dwc->edev)) {
+		ret = dev_err_probe(dwc->dev, PTR_ERR(dwc->edev), "failed to get extcon\n");
+		goto err3;
+	}
+
 	ret = dwc3_get_dr_mode(dwc);
 	if (ret)
 		goto err3;
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 8cad9e7d3368..039bf241769a 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/extcon.h>
-#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -439,51 +438,6 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
-{
-	struct device *dev = dwc->dev;
-	struct device_node *np_phy;
-	struct extcon_dev *edev = NULL;
-	const char *name;
-
-	if (device_property_read_bool(dev, "extcon"))
-		return extcon_get_edev_by_phandle(dev, 0);
-
-	/*
-	 * Device tree platforms should get extcon via phandle.
-	 * On ACPI platforms, we get the name from a device property.
-	 * This device property is for kernel internal use only and
-	 * is expected to be set by the glue code.
-	 */
-	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0) {
-		edev = extcon_get_extcon_dev(name);
-		if (!edev)
-			return ERR_PTR(-EPROBE_DEFER);
-
-		return edev;
-	}
-
-	/*
-	 * Try to get an extcon device from the USB PHY controller's "port"
-	 * node. Check if it has the "port" node first, to avoid printing the
-	 * error message from underlying code, as it's a valid case: extcon
-	 * device (and "port" node) may be missing in case of "usb-role-switch"
-	 * or OTG mode.
-	 */
-	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	if (of_graph_is_present(np_phy)) {
-		struct device_node *np_conn;
-
-		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-		if (np_conn)
-			edev = extcon_find_edev_by_node(np_conn);
-		of_node_put(np_conn);
-	}
-	of_node_put(np_phy);
-
-	return edev;
-}
-
 #if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
 #define ROLE_SWITCH 1
 static int dwc3_usb_role_switch_set(struct usb_role_switch *sw,
@@ -588,10 +542,6 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	    device_property_read_bool(dwc->dev, "usb-role-switch"))
 		return dwc3_setup_role_switch(dwc);
 
-	dwc->edev = dwc3_get_extcon(dwc);
-	if (IS_ERR(dwc->edev))
-		return PTR_ERR(dwc->edev);
-
 	if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
-- 
2.35.1

