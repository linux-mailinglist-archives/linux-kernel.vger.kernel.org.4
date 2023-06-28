Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C48074174F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjF1RhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:37:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:11724 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231691AbjF1RhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687973828; x=1719509828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unQ9Ida9BK58eirKqqPGe4rswfOrgisjIAOxxzN5qHw=;
  b=MIkdC0bPqX6Qdda6i5vFl3+HucV8wNe2pQbdAwYWMPvOUp78oPAjtNpn
   BvaJPUYO8yx+SNGK6TnNdvVj2WlH1M1YGZRYwSf1A/38fxlLyXBzmuEkZ
   JASPEKr4y+9ZlvIVU/MoF6hEDKaf9ogOTI/ZC6NvWnHFkvlU3Nh1jkFlB
   3zYv/9SXOnvu3App1/u+MyKH2uoc0Ot4TAke5EwPCVa+HU6juxa4iUPm0
   VzFuNg4hByMcrpu1NcUZLjSONzNW8YJHh51nWJ5o8EHdgc8k6UX1rUj6G
   wA/xUXgeUnH2wFqO4VhBXmQW4xf6ec8mJDF3vB9vW8k3g9dHZD16DH9O1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="346679451"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="346679451"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 10:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047499363"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1047499363"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 10:37:01 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Configure Retimer cable type
Date:   Wed, 28 Jun 2023 10:37:26 -0700
Message-Id: <20230628173727.701140-2-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
References: <20230628173727.701140-1-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Connector class driver only configure cable type active or passive.
With this change it will also configure if the cable type is retimer or
redriver if required by AP. This detail will be provided as a part of
cable discover mode VDO.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

---
Changes in v2:
 - Implemented use of cable discover mode vdo.
 - Removed adittional changes to host command. 
---

---
 drivers/platform/chrome/cros_ec_typec.c | 33 ++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 25f9767c28e8..557f396d1c00 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -406,6 +406,25 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 	return ret;
 }
 
+static int cros_typec_get_cable_vdo(struct cros_typec_data *typec, int port_num,
+				    uint16_t svid)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct list_head *head = &port->plug_mode_list;
+	struct cros_typec_altmode_node *node;
+
+	list_for_each_entry(node, head, list) {
+		if (node->amode->svid == svid)
+			break;
+	}
+
+	if (node->amode->svid != svid)
+		return 0;
+
+	return node->amode->vdo;
+}
+
+
 /*
  * Spoof the VDOs that were likely communicated by the partner for TBT alt
  * mode.
@@ -416,6 +435,7 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct typec_thunderbolt_data data;
+	uint32_t cable_vdo;
 	int ret;
 
 	if (typec->pd_ctrl_ver < 2) {
@@ -442,6 +462,11 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 
 	data.cable_mode |= TBT_SET_CABLE_ROUNDED(pd_ctrl->cable_gen);
 
+	cable_vdo = cros_typec_get_cable_vdo(typec, port_num, USB_TYPEC_TBT_SID);
+
+	if (cable_vdo & TBT_CABLE_RETIMER)
+		data.cable_mode |= TBT_CABLE_RETIMER;
+
 	/* Enter Mode VDO */
 	data.enter_vdo = TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
 
@@ -513,17 +538,23 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct enter_usb_data data;
+	uint32_t cable_vdo;
 
 	data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
 
+	cable_vdo = cros_typec_get_cable_vdo(typec, port_num, USB_TYPEC_TBT_SID);
+
 	/* Cable Speed */
 	data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
 
 	/* Cable Type */
 	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
-	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+	else if (cable_vdo & TBT_CABLE_RETIMER)
 		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
+	else if (!(cable_vdo & TBT_CABLE_RETIMER) &&
+		 (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE))
+		data.eudo |= EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TYPE_SHIFT;
 
 	data.active_link_training = !!(pd_ctrl->control_flags &
 				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
-- 
2.25.1

