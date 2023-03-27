Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6666CABC4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC0RUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjC0RUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:20:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AFB4494;
        Mon, 27 Mar 2023 10:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679937629; x=1711473629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9vfPHAhf77CU6X/CYXCEa6OblOK0wvYIlcDR/R0TO/M=;
  b=BOb7GUKuWv+hdaTMlyak+QanQc0/tFAPCaE5XCRsStVC5kELDlSpIRQc
   VCAreW4DrC5IKixOS1fkiPMGsZtPHnUV4anov2YVhjr/hRspiG9eMJbIU
   LH040aKKCwfngtPjyu0G3RMjKUHbhSnCVV9LJVuv3c3gFK6C7mGa1P4n2
   FzMvneP5iQEsXHmMei1QTHAgb0Z6lV7bdcosf6naLGYtvs5/r0OiryQET
   qtWOXCCH/MQt6eMV7zHFRWc5qUFH7gs8+vwxylHt9ppNgMKXLEpmca7Ue
   AqwU32NwSekBH+wOk6csa9oUal7nBCMrEB3ldz16RZoBNe3QO6UMpBPap
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="341910499"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="341910499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 10:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="807569019"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="807569019"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 27 Mar 2023 10:20:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 533EC79C; Mon, 27 Mar 2023 20:20:27 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v1 1/2] thunderbolt: Get rid of redundant 'else'
Date:   Mon, 27 Mar 2023 20:20:16 +0300
Message-Id: <20230327172017.20078-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/thunderbolt/acpi.c    |  2 +-
 drivers/thunderbolt/ctl.c     |  2 +-
 drivers/thunderbolt/nhi.c     |  3 ++-
 drivers/thunderbolt/switch.c  |  4 ++--
 drivers/thunderbolt/usb4.c    |  6 +++---
 drivers/thunderbolt/xdomain.c | 24 ++++++++++--------------
 6 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
index 628225deb8fe..3514bf65b7a4 100644
--- a/drivers/thunderbolt/acpi.c
+++ b/drivers/thunderbolt/acpi.c
@@ -341,7 +341,7 @@ static struct acpi_device *tb_acpi_find_companion(struct device *dev)
 	 */
 	if (tb_is_switch(dev))
 		return tb_acpi_switch_find_companion(tb_to_switch(dev));
-	else if (tb_is_usb4_port_device(dev))
+	if (tb_is_usb4_port_device(dev))
 		return acpi_find_child_by_adr(ACPI_COMPANION(dev->parent),
 					      tb_to_usb4_port_device(dev)->port->port);
 	return NULL;
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 6e7d28e8d81a..3a213322ec7a 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -1033,7 +1033,7 @@ static int tb_cfg_get_error(struct tb_ctl *ctl, enum tb_cfg_space space,
 
 	if (res->tb_error == TB_CFG_ERROR_LOCK)
 		return -EACCES;
-	else if (res->tb_error == TB_CFG_ERROR_PORT_NOT_CONNECTED)
+	if (res->tb_error == TB_CFG_ERROR_PORT_NOT_CONNECTED)
 		return -ENOTCONN;
 
 	return -EIO;
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index cfebec107f3f..d76e923fbc6a 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -526,7 +526,8 @@ static int nhi_alloc_hop(struct tb_nhi *nhi, struct tb_ring *ring)
 			 ring->hop);
 		ret = -EBUSY;
 		goto err_unlock;
-	} else if (!ring->is_tx && nhi->rx_rings[ring->hop]) {
+	}
+	if (!ring->is_tx && nhi->rx_rings[ring->hop]) {
 		dev_warn(&nhi->pdev->dev, "RX hop %d already allocated\n",
 			 ring->hop);
 		ret = -EBUSY;
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index da373ac38285..51e86b5171c7 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -271,9 +271,9 @@ static int nvm_authenticate(struct tb_switch *sw, bool auth_only)
 		}
 		sw->nvm->authenticating = true;
 		return usb4_switch_nvm_authenticate(sw);
-	} else if (auth_only) {
-		return -EOPNOTSUPP;
 	}
+	if (auth_only)
+		return -EOPNOTSUPP;
 
 	sw->nvm->authenticating = true;
 	if (!tb_route(sw)) {
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index a0996cb2893c..2d4b6f3e6141 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -851,7 +851,7 @@ bool usb4_switch_query_dp_resource(struct tb_switch *sw, struct tb_port *in)
 	 */
 	if (ret == -EOPNOTSUPP)
 		return true;
-	else if (ret)
+	if (ret)
 		return false;
 
 	return !status;
@@ -877,7 +877,7 @@ int usb4_switch_alloc_dp_resource(struct tb_switch *sw, struct tb_port *in)
 			     &status);
 	if (ret == -EOPNOTSUPP)
 		return 0;
-	else if (ret)
+	if (ret)
 		return ret;
 
 	return status ? -EBUSY : 0;
@@ -900,7 +900,7 @@ int usb4_switch_dealloc_dp_resource(struct tb_switch *sw, struct tb_port *in)
 			     &status);
 	if (ret == -EOPNOTSUPP)
 		return 0;
-	else if (ret)
+	if (ret)
 		return ret;
 
 	return status ? -EIO : 0;
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index a48335c95d39..e2b54887d331 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1178,9 +1178,8 @@ static int tb_xdomain_get_uuid(struct tb_xdomain *xd)
 		if (xd->state_retries-- > 0) {
 			dev_dbg(&xd->dev, "failed to request UUID, retrying\n");
 			return -EAGAIN;
-		} else {
-			dev_dbg(&xd->dev, "failed to read remote UUID\n");
 		}
+		dev_dbg(&xd->dev, "failed to read remote UUID\n");
 		return ret;
 	}
 
@@ -1367,12 +1366,10 @@ static int tb_xdomain_get_properties(struct tb_xdomain *xd)
 			dev_dbg(&xd->dev,
 				"failed to request remote properties, retrying\n");
 			return -EAGAIN;
-		} else {
-			/* Give up now */
-			dev_err(&xd->dev,
-				"failed read XDomain properties from %pUb\n",
-				xd->remote_uuid);
 		}
+		/* Give up now */
+		dev_err(&xd->dev, "failed read XDomain properties from %pUb\n",
+			xd->remote_uuid);
 
 		return ret;
 	}
@@ -2179,13 +2176,12 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 				if (xd->remote_uuid &&
 				    uuid_equal(xd->remote_uuid, lookup->uuid))
 					return xd;
-			} else if (lookup->link &&
-				   lookup->link == xd->link &&
-				   lookup->depth == xd->depth) {
-				return xd;
-			} else if (lookup->route &&
-				   lookup->route == xd->route) {
-				return xd;
+			} else {
+				if (lookup->link && lookup->link == xd->link &&
+				    lookup->depth == xd->depth)
+					return xd;
+				if (lookup->route && lookup->route == xd->route)
+					return xd;
 			}
 		} else if (tb_port_has_remote(port)) {
 			xd = switch_find_xdomain(port->remote->sw, lookup);
-- 
2.40.0.1.gaa8946217a0b

