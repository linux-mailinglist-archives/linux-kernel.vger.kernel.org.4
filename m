Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0023074AB65
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjGGGwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGGGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:51:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E243A1FE5;
        Thu,  6 Jul 2023 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688712715; x=1720248715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0s3VvmQ7Mpf//Dpu0NAISFRua0FC701ilpRQVR252lU=;
  b=Gg4nMDhRfmAp9x+fVXabKgXgWuAcAJBQ4R7hqYXkIY0gGsbgFp95fbfh
   3iJ29CV8Ztda2WRvguOcCs0r/OVKgK5jyxLfUcdFiIdPeK+i2piJUPb8d
   FQoIgK/ZwO4eELCZZLzIRUIRmVi6ebkcfDsPgfel8WcH5fVgxMb9sOeKO
   3XJdeu7sysKR+ouIIE/O0wBeDurgMlsHh/d+FpthUR1anRe95QJ3xyCHP
   TOsW0D+up+5bU7MifJRQ+ViLRfJN2tVQwNhf27UR6/KXAHpsbjykb8PGl
   VIuH+hR1mQnies5mFFeDel+d+zp1LnEBWYr5IEnqXwR9vtbBWNxQ10bMl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="394586944"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="394586944"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 23:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749436231"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="749436231"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2023 23:51:42 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 2/2] usb: typec: intel_pmc_mux: Configure Active and Retimer Cable type
Date:   Thu,  6 Jul 2023 23:53:18 -0700
Message-Id: <20230707065318.18681-3-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230707065318.18681-1-utkarsh.h.patel@intel.com>
References: <20230707065318.18681-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v2:
 - No changes.

Changes in v3:
 - No changes.
---
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 28 +++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 5e8edf3881c0..888632847a74 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -59,7 +59,7 @@ enum {
 };
 
 /* Common Mode Data bits */
-#define PMC_USB_ALTMODE_ACTIVE_CABLE	BIT(2)
+#define PMC_USB_ALTMODE_RETIMER_CABLE	BIT(2)
 
 #define PMC_USB_ALTMODE_ORI_SHIFT	1
 #define PMC_USB_ALTMODE_UFP_SHIFT	3
@@ -71,6 +71,7 @@ enum {
 #define PMC_USB_ALTMODE_TBT_TYPE	BIT(17)
 #define PMC_USB_ALTMODE_CABLE_TYPE	BIT(18)
 #define PMC_USB_ALTMODE_ACTIVE_LINK	BIT(20)
+#define PMC_USB_ALTMODE_ACTIVE_CABLE	BIT(22)
 #define PMC_USB_ALTMODE_FORCE_LSR	BIT(23)
 #define PMC_USB_ALTMODE_CABLE_SPD(_s_)	(((_s_) & GENMASK(2, 0)) << 25)
 #define   PMC_USB_ALTMODE_CABLE_USB31	1
@@ -319,8 +320,18 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
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
 
@@ -359,8 +370,17 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
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

