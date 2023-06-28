Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167AE741752
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjF1RhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:37:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:11724 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbjF1RhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687973824; x=1719509824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vTxGJoHsoj8xuM7czgOyMiPJFjlrc09vF1YazUZeyMc=;
  b=mKaREc6vsCO5PKNgSQdo/hYTjIR5txjkWJx00skbfkJCc5OBOBtEF0gs
   74lotPEEsIgSopfHuJaxKx0adb6XuK99LsFgkLyyZE3lPP8F2CXYDOAPz
   hQ/tFzdYByaYzp03dh23MeY8BQ6rGpcg1JHTP+4WHV/8ees62thIVBpr7
   wzpE40J4cTBicOQdDUoN2oY6YYSF6oF1oxV5G2egdVCNjevI5YWaUOVby
   MSiuKPIrnIuF5ux+JKro1gZ74SuNY3rI14Tdih4vL7dCAWe5AVmxjyqET
   zkSa7FDazwz+a6BAPaQWURFl/SiQTy2MQOtLkhNosPj+He+sHp66YSXwP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="346679449"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="346679449"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 10:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047499368"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1047499368"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 10:37:01 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 2/2] usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type
Date:   Wed, 28 Jun 2023 10:37:27 -0700
Message-Id: <20230628173727.701140-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
References: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cable type such as active and retimer received as a part of Thunderbolt3
or Thunderbolt4 cable discover mode VDO needs to be configured in the
thunderbolt alternate mode.

Configuring the register bits for this cable type is changed with Intel
Meteor Lake platform. BIT2 for Retimer/Redriver cable and BIT22 for
Active/Passive cable.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v2:
 - No changes.
---
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index e049eadb591e..ac088e2e49bc 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -57,7 +57,7 @@ enum {
 };
 
 /* Common Mode Data bits */
-#define PMC_USB_ALTMODE_ACTIVE_CABLE	BIT(2)
+#define PMC_USB_ALTMODE_RETIMER_CABLE	BIT(2)
 
 #define PMC_USB_ALTMODE_ORI_SHIFT	1
 #define PMC_USB_ALTMODE_UFP_SHIFT	3
@@ -69,6 +69,7 @@ enum {
 #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
 #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
 #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
+#define PMC_USB_ALTMODE_ACTIVE_CABLE	BIT(22)
 #define PMC_USB_ALTMODE_FORCE_LSR	BIT(23)
 #define PMC_USB_ALTMODE_CABLE_SPD(_s_)	(((_s_) & GENMASK(2, 0)) << 25)
 #define   PMC_USB_ALTMODE_CABLE_USB31	1
@@ -313,8 +314,18 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 	if (data->cable_mode & TBT_CABLE_LINK_TRAINING)
 		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
 
-	if (data->enter_vdo & TBT_ENTER_MODE_ACTIVE_CABLE)
-		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+	if (acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1072", NULL) ||
+	    acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1079", NULL)) {
+		if ((data->enter_vdo & TBT_ENTER_MODE_ACTIVE_CABLE) ||
+		    (data->cable_mode & TBT_CABLE_RETIMER))
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+	} else {
+		if (data->enter_vdo & TBT_ENTER_MODE_ACTIVE_CABLE)
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+
+		if (data->cable_mode & TBT_CABLE_RETIMER)
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+	}
 
 	req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
 
@@ -353,8 +364,17 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 	case EUDO_CABLE_TYPE_OPTICAL:
 		req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
 		fallthrough;
+	case EUDO_CABLE_TYPE_RE_TIMER:
+		if (!acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1072", NULL) ||
+		    !acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1079", NULL))
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+		fallthrough;
 	default:
-		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+		if (acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1072", NULL) ||
+		    acpi_dev_hid_uid_match(port->pmc->iom_adev, "INTC1079", NULL))
+			req.mode_data |= PMC_USB_ALTMODE_RETIMER_CABLE;
+		else
+			req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
 
 		/* Configure data rate to rounded in the case of Active TBT3
 		 * and USB4 cables.
-- 
2.25.1

