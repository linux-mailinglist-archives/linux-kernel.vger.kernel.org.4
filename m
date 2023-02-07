Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4770268B67A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBFHeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBFHeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:34:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B94EDF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 23:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675668837; x=1707204837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X2WBQ9RJBzamhY9mmwq8nKykzM0EbKzq7klufUYGkLY=;
  b=LYbb8rppbhihxKmLiRibhXcPaKkXxx9yX+VDGNZuPOUIfv3gEhEiAnc3
   0Dvcg7vuFjLWEQqX0mkfkkYdXgXgR5MIPOeu3yvT6zMG9q8U+1UhkO/KO
   AFzrI4f1/AegCEpw0wd4NCsSie3eK547m3xzmlkAzgeZ3Vj5hvQfsArwz
   pkBVEfOeBaZhyv1uhxhBeeGsEqDTf2AvmkjnReoRpvLCxLasdSGcapmE/
   xX7tRm5Vr0L84Bz1O9580SOykUoLpJ8RAszPFQfrVMoQDLEZNwnY7FJBJ
   XHJvrDSO2n8nQISa8BtlF6HzbRP6JyA7ntSZcDiPV7g3P6JDUkSIkXxHK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="309481425"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="309481425"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 23:33:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="698757186"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="698757186"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2023 23:33:54 -0800
From:   Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
To:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [PATCH] platform/chrome: Avoid fetching the type-C parameters again
Date:   Tue,  7 Feb 2023 13:06:10 +0530
Message-Id: <20230207073610.3290391-1-rajat.khandelwal@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct 'cros_typec_port' incorporates three type-C parameters,
'ori_sw', 'retimer', and 'mux'.
These parameters in the struct 'typec_port' are being already
configured when 'typec_register_port' is being called.

The bigger picture - 'typec_register_port' can return an error and
the type-C parameters could go unconfigured. However, the callback
will return EPROBE_DEFER and the driver will again be getting probed
trying to configure them again.
However, currently, they are again tried to get fetched for the
'cros_typec_port' struct, which sometimes could result in an error
and these parameters could go unconfigured (no provision of deferring
the probe in this case, so we are left with unconfigured parameters).

Hence, assign the parameters to the corresponding ones in the struct
'typec_port' after they are fetched in 'typec_register_port'.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 58 ++++++++++---------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 001b0de95a46..0265c0d38bd6 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -24,6 +24,8 @@
 #include <linux/usb/typec_tbt.h>
 #include <linux/usb/role.h>
 
+#include "../../usb/typec/class.h"
+
 #define DRV_NAME "cros-ec-typec"
 
 #define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
@@ -141,47 +143,17 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 	return 0;
 }
 
-static int cros_typec_get_switch_handles(struct cros_typec_port *port,
-					 struct fwnode_handle *fwnode,
-					 struct device *dev)
+static int cros_typec_get_role_switch_handle(struct cros_typec_port *port,
+					     struct fwnode_handle *fwnode,
+					     struct device *dev)
 {
-	port->mux = fwnode_typec_mux_get(fwnode, NULL);
-	if (IS_ERR(port->mux)) {
-		dev_dbg(dev, "Mux handle not found.\n");
-		goto mux_err;
-	}
-
-	port->retimer = fwnode_typec_retimer_get(fwnode);
-	if (IS_ERR(port->retimer)) {
-		dev_dbg(dev, "Retimer handle not found.\n");
-		goto retimer_sw_err;
-	}
-
-	port->ori_sw = fwnode_typec_switch_get(fwnode);
-	if (IS_ERR(port->ori_sw)) {
-		dev_dbg(dev, "Orientation switch handle not found.\n");
-		goto ori_sw_err;
-	}
-
 	port->role_sw = fwnode_usb_role_switch_get(fwnode);
 	if (IS_ERR(port->role_sw)) {
 		dev_dbg(dev, "USB role switch handle not found.\n");
-		goto role_sw_err;
+		return -ENODEV;
 	}
 
 	return 0;
-
-role_sw_err:
-	typec_switch_put(port->ori_sw);
-	port->ori_sw = NULL;
-ori_sw_err:
-	typec_retimer_put(port->retimer);
-	port->retimer = NULL;
-retimer_sw_err:
-	typec_mux_put(port->mux);
-	port->mux = NULL;
-mux_err:
-	return -ENODEV;
 }
 
 static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
@@ -363,6 +335,18 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	return 0;
 }
 
+static void cros_typec_copy_port_params(struct cros_typec_port *cros_port)
+{
+	struct typec_port *port = cros_port->port;
+
+	if (IS_ERR_OR_NULL(port))
+		return;
+
+	cros_port->mux = port->mux;
+	cros_port->retimer = port->retimer;
+	cros_port->ori_sw = port->sw;
+}
+
 static int cros_typec_init_ports(struct cros_typec_data *typec)
 {
 	struct device *dev = typec->dev;
@@ -422,9 +406,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			goto unregister_ports;
 		}
 
-		ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
+		cros_typec_copy_port_params(cros_port);
+
+		ret = cros_typec_get_role_switch_handle(cros_port, fwnode, dev);
 		if (ret)
-			dev_dbg(dev, "No switch control for port %d\n",
+			dev_dbg(dev, "No role-switch control for port %d\n",
 				port_num);
 
 		ret = cros_typec_register_port_altmodes(typec, port_num);
-- 
2.34.1

