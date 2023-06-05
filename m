Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059C2721B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjFEBBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjFEBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:00:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AAD3;
        Sun,  4 Jun 2023 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685926850; x=1717462850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ovbZBAqmg/9SHS0Es0S7plrUNXEjH3VCHLxaoAtSzFg=;
  b=anrzevuj5+iYb0UAyhyfUpro89DcA0xbMWLvjET4LVCPji4Y3WoH7FX+
   2lW6AD+8OMp6gB32ZtWkzSjG0ChdG0aF7+yYk1nThaEG6dktHYB5IhHVU
   mIHq5R6ElHURAb3byyYK7fkhlI78Z3pNiKVGtB3KSGgy0+2Buk1uXp8U6
   vlCqJiq6YlXuc2WBQr24VzwuF7k99YthnupQy2knxeD7LrvsBXfmJHaVe
   2PW53JQyhNdk348IV50i/fgbWUMsIbxWE/tJpAPlH1v+fxDtA67kqZJL1
   2uJTRNmnxGapylQKaM1eIiEtbgtFNPGEYXMCxfpn9CX4A0tabbSFe9Fyb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384545404"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384545404"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 18:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="852800029"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="852800029"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2023 18:00:48 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 2/2] usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type
Date:   Sun,  4 Jun 2023 18:01:17 -0700
Message-Id: <20230605010117.794691-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605010117.794691-1-utkarsh.h.patel@intel.com>
References: <20230605010117.794691-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/usb/typec/mux/intel_pmc_mux.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 34e4188a40ff..352988132075 100644
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

