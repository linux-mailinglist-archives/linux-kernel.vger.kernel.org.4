Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD374AB63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 08:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGGGwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjGGGv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 02:51:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1161FE4;
        Thu,  6 Jul 2023 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688712715; x=1720248715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ayO+jeRCG7JzuDV4hkaToHHdQ4NayqOy1kTKwggV0GQ=;
  b=aBWW5dYdJ7L3iYnr8/4RvuK9IYCQgYaWwnu+dlsGkYOtmlnHqJHh4FuJ
   aAtVWGIsZMOb2xR9e2JGa9EhrJr3oCBrbKI/o7kAGgLt0F8srl0woCD7C
   B5T37jfq/Nt22c1B5YQZ4MgZ3fFhaCrVWIeof8OnNTekeCldihaQaOEAY
   FKHlLXtoXXCweuEIJUqlJlbZFMT+bZQ931Po6VSH58gbQTuSGQ78fWcku
   PvFU/D/SjRsr/+huz1rlk6Yio280PJx98sRy/7Y9GwXEKZiH0sbL2nJwx
   2EhKNypAzeTpF5aKzgUHcxWKSx4qIF4jFxrjSqBzgaGaqksVjz7lt0xRA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="394586943"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="394586943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 23:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749436228"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="749436228"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2023 23:51:42 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v3 1/2] platform/chrome: cros_ec_typec: Configure Retimer cable type
Date:   Thu,  6 Jul 2023 23:53:17 -0700
Message-Id: <20230707065318.18681-2-utkarsh.h.patel@intel.com>
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

Connector class driver only configure cable type active or passive.
Configure if the cable type is retimer or redriver with this change.
This detail will be provided as a part of cable discover mode VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
Changes in v2:
- Implemented use of cable discover mode vdo.
- Removed adittional changes to host command.

Changes in v3:
- Changed the return method in cros_typec_get_cable_vdo.
- Changed passed parameters in cros_typec_get_cable_vdo.
- Corrected definition for unsigned integers as kerenl standard.
- Assigning cable_vdo values directly in to cable_mode.
- Removed unncessary checks for Retimer cable type.
---
---
 drivers/platform/chrome/cros_ec_typec.c | 26 ++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 25f9767c28e8..0ea085fec55a 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -406,6 +406,20 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 	return ret;
 }
 
+static int cros_typec_get_cable_vdo(struct cros_typec_port *port, u16 svid)
+{
+	struct list_head *head = &port->plug_mode_list;
+	struct cros_typec_altmode_node *node;
+	int ret = 0;
+
+	list_for_each_entry(node, head, list) {
+		if (node->amode->svid == svid)
+			return node->amode->vdo;
+	}
+
+	return ret;
+}
+
 /*
  * Spoof the VDOs that were likely communicated by the partner for TBT alt
  * mode.
@@ -416,6 +430,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct typec_thunderbolt_data data;
+	u32 cable_vdo;
 	int ret;
 
 	if (typec->pd_ctrl_ver < 2) {
@@ -432,6 +447,10 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 
 	/* Cable Discover Mode VDO */
 	data.cable_mode = TBT_MODE;
+
+	cable_vdo = cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID);
+	data.cable_mode |= cable_vdo;
+
 	data.cable_mode |= TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
 
 	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
@@ -513,17 +532,22 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct enter_usb_data data;
+	u32 cable_vdo;
 
 	data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
 
+	cable_vdo = cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID);
+
 	/* Cable Speed */
 	data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
 
 	/* Cable Type */
 	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
-	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+	else if (cable_vdo & TBT_CABLE_RETIMER)
 		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
+	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+		data.eudo |= EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TYPE_SHIFT;
 
 	data.active_link_training = !!(pd_ctrl->control_flags &
 				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
-- 
2.25.1

