Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64C721B5F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 03:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjFEBAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 21:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjFEBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 21:00:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325A4D2;
        Sun,  4 Jun 2023 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685926850; x=1717462850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WdQN6aHQ/uLCaZbELfPcs6y7k1aw1TF+BKQ6RGRzRIk=;
  b=Dgd/k+NA5+FnXJR3FN0ayGR8HDwlm9f7viDSskxeIfay3WWKe8VOZ1z1
   P0ADswC4a4+Ae46VImucbdEBs87JpNKmKxDmgvvr5IozquM41c67HLi5w
   SDNVjUqLiQT7GeSUoDwcoUCQWi2c9OZuS1bQJiDahhQ0oRrA+U+zY5HHV
   bcZ8VYYl1LrZkszk7Fio221fvQXPPk+tUgybeUy9eogCzn2lrgy9AH46Y
   mkZfFUm/orPSIIoV/IgPrf5vnC9YrO1T3VkWrbNg8Jau9tgnZDZYW3xRe
   pZca7Qls9/YkBV/BOtcnbLFMU8g/pIRTtbTTA8LWPv6ISO5wELOl5p1UR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384545402"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384545402"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 18:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="852800022"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="852800022"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.157])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jun 2023 18:00:48 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        heikki.krogerus@linux.intel.com, pmalani@chromium.org,
        bleung@chromium.org
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Subject: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer cable type
Date:   Sun,  4 Jun 2023 18:01:16 -0700
Message-Id: <20230605010117.794691-2-utkarsh.h.patel@intel.com>
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

Connector class driver only configure cable type active or passive.
With this change it will also configure if the cable type is retimer or
redriver if required by AP. This details will be provided by Chrome EC
as a part of cable discover mode VDO.

This change also brings in corresponding EC header updates from the EC
code base [1].

[1]:
https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c        | 8 +++++++-
 include/linux/platform_data/cros_ec_commands.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index a673c3342470..9c18b1df64a7 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -448,6 +448,9 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
 	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
 		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
 
+	if (pd_ctrl->control_flags & USB_PD_CTRL_RETIMER_CABLE)
+		data.enter_vdo |= TBT_CABLE_RETIMER;
+
 	if (!port->state.alt) {
 		port->state.alt = port->port_altmode[CROS_EC_ALTMODE_TBT];
 		ret = cros_typec_usb_safe_state(port);
@@ -522,8 +525,11 @@ static int cros_typec_enable_usb4(struct cros_typec_data *typec,
 	/* Cable Type */
 	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
-	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+	else if (pd_ctrl->control_flags & USB_PD_CTRL_RETIMER_CABLE)
 		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
+	else if (!(pd_ctrl->control_flags & USB_PD_CTRL_RETIMER_CABLE) &&
+		  (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE))
+		data.eudo |= EUDO_CABLE_TYPE_RE_DRIVER << EUDO_CABLE_TYPE_SHIFT;
 
 	data.active_link_training = !!(pd_ctrl->control_flags &
 				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index ab721cf13a98..c9aa5495c666 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -4963,6 +4963,8 @@ struct ec_response_usb_pd_control_v1 {
 #define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
 /* Active Link Uni-Direction */
 #define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
+/* Retimer/Redriver cable */
+#define USB_PD_CTRL_RETIMER_CABLE BIT(4)
 
 struct ec_response_usb_pd_control_v2 {
 	uint8_t enabled;
-- 
2.25.1

