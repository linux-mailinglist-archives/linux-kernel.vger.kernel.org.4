Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D4D5EC373
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiI0NAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiI0NAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:00:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597698FD55;
        Tue, 27 Sep 2022 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664283636; x=1695819636;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FoG9Qnq4FjYpPWfDqiK0gAHPQvYqA5DXrPRH7CfTzDc=;
  b=VhcxtoVb/YZN0850oy7eDZz2QtSEVfuAQ2KYhvFAsIOyuUmMQGsQwJop
   14cUD5kgTUm2zUcDRFw3g48FVjfvlv3stbBzORcpEpcn7vr15eJcUzUB3
   5AekfGu+W4l1iCZYqHPKhkoYORRpZFJ8Ozn0I6NV9LxdZsoqM1bpfuZBr
   DivdQrRlWYucvx5JFbj4AfIOXHIeG3WJMrnzlkjAfKUj5Wq1eD6d7ssCD
   idRduFcFzd9X2eMGD5Zcn59x7imKPADkypHalwQEjkjZEW+kB7HBAxkyS
   EI7Ta+Yqc9aU76do980L6XzQ18PhTd1IcxN35K82qEWdtyEe3CV8tO5Yw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="302788776"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="302788776"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 06:00:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="796758885"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="796758885"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 06:00:33 -0700
From:   Rajat Khandelwal <rajat.khandelwal@intel.com>
To:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@intel.com>
Subject: [PATCH] thunderbolt: Add wake on connect/disconnect on USB4 ports
Date:   Wed, 28 Sep 2022 18:30:05 +0530
Message-Id: <20220928130005.2048724-1-rajat.khandelwal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wake on connect/disconnect is only supported while runtime suspend
for now, which is obviously necessary. Its also not inherently
desired for the system to wakeup on thunderbolt hot events.
However, we can still make user in control of waking up the system
in the events of hot plug/unplug.
This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
attribute and only enables wakes on connect/disconnect to the
respective port when 'wakeup' is set to 'enabled'. The attribute
is set to 'disabled' by default.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
---

 drivers/thunderbolt/tb_regs.h   |  2 ++
 drivers/thunderbolt/usb4.c      | 33 +++++++++++++++++++++++++--------
 drivers/thunderbolt/usb4_port.c |  3 +++
 3 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 166054110388..04733fc1130c 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -358,6 +358,8 @@ struct tb_regs_port_header {
 #define PORT_CS_18_BE				BIT(8)
 #define PORT_CS_18_TCM				BIT(9)
 #define PORT_CS_18_CPS				BIT(10)
+#define PORT_CS_18_WOCS				BIT(16)
+#define PORT_CS_18_WODS				BIT(17)
 #define PORT_CS_18_WOU4S			BIT(18)
 #define PORT_CS_19				0x13
 #define PORT_CS_19_PC				BIT(3)
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 3a2e7126db9d..0d5ff086814b 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -155,6 +155,8 @@ static inline int usb4_switch_op_data(struct tb_switch *sw, u16 opcode,
 
 static void usb4_switch_check_wakes(struct tb_switch *sw)
 {
+	bool wakeup_usb4 = false;
+	struct usb4_port *usb4;
 	struct tb_port *port;
 	bool wakeup = false;
 	u32 val;
@@ -173,20 +175,31 @@ static void usb4_switch_check_wakes(struct tb_switch *sw)
 		wakeup = val & (ROUTER_CS_6_WOPS | ROUTER_CS_6_WOUS);
 	}
 
-	/* Check for any connected downstream ports for USB4 wake */
+	/*
+	 * Check for any downstream ports for USB4 wake,
+	 * connection wake and disconnection wake.
+	 */
 	tb_switch_for_each_port(sw, port) {
-		if (!tb_port_has_remote(port))
+		if (!port->cap_usb4)
 			continue;
 
 		if (tb_port_read(port, &val, TB_CFG_PORT,
 				 port->cap_usb4 + PORT_CS_18, 1))
 			break;
 
-		tb_port_dbg(port, "USB4 wake: %s\n",
-			    (val & PORT_CS_18_WOU4S) ? "yes" : "no");
+		tb_port_dbg(port, "USB4 wake: %s, connection wake: %s, disconnection wake: %s\n",
+			    (val & PORT_CS_18_WOU4S) ? "yes" : "no",
+			    (val & PORT_CS_18_WOCS) ? "yes" : "no",
+			    (val & PORT_CS_18_WODS) ? "yes" : "no");
+
+		wakeup_usb4 = val & (PORT_CS_18_WOU4S | PORT_CS_18_WOCS |
+				     PORT_CS_18_WODS);
+
+		usb4 = port->usb4;
+		if (device_may_wakeup(&usb4->dev) && wakeup_usb4)
+			pm_wakeup_event(&usb4->dev, 0);
 
-		if (val & PORT_CS_18_WOU4S)
-			wakeup = true;
+		wakeup |= wakeup_usb4;
 	}
 
 	if (wakeup)
@@ -366,6 +379,7 @@ bool usb4_switch_lane_bonding_possible(struct tb_switch *sw)
  */
 int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 {
+	struct usb4_port *usb4;
 	struct tb_port *port;
 	u64 route = tb_route(sw);
 	u32 val;
@@ -395,10 +409,13 @@ int usb4_switch_set_wake(struct tb_switch *sw, unsigned int flags)
 			val |= PORT_CS_19_WOU4;
 		} else {
 			bool configured = val & PORT_CS_19_PC;
+			usb4 = port->usb4;
 
-			if ((flags & TB_WAKE_ON_CONNECT) && !configured)
+			if (((flags & TB_WAKE_ON_CONNECT) |
+			      device_may_wakeup(&usb4->dev)) && !configured)
 				val |= PORT_CS_19_WOC;
-			if ((flags & TB_WAKE_ON_DISCONNECT) && configured)
+			if (((flags & TB_WAKE_ON_DISCONNECT) |
+			      device_may_wakeup(&usb4->dev)) && configured)
 				val |= PORT_CS_19_WOD;
 			if ((flags & TB_WAKE_ON_USB4) && configured)
 				val |= PORT_CS_19_WOU4;
diff --git a/drivers/thunderbolt/usb4_port.c b/drivers/thunderbolt/usb4_port.c
index 6b02945624ee..442ed1152e59 100644
--- a/drivers/thunderbolt/usb4_port.c
+++ b/drivers/thunderbolt/usb4_port.c
@@ -282,6 +282,9 @@ struct usb4_port *usb4_port_device_add(struct tb_port *port)
 		}
 	}
 
+	if (!tb_is_upstream_port(port))
+		device_set_wakeup_capable(&usb4->dev, true);
+
 	pm_runtime_no_callbacks(&usb4->dev);
 	pm_runtime_set_active(&usb4->dev);
 	pm_runtime_enable(&usb4->dev);
-- 
2.34.1

