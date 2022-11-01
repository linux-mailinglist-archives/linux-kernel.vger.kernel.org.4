Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A6C6134EE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJaLux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiJaLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:50:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77FAF01A;
        Mon, 31 Oct 2022 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667217048; x=1698753048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=07fgYSi+0DSE3i6JcgPfVEFUgaXPKTFDzgW38hGG66E=;
  b=JbafUmRgSyqVx19VvUQuRpBNIJPcYLPz0+BY5ZH9Oh23YqAdZcWGFaIc
   zkxHTJpWf4aiA0BSDM+tRIHdeLpltV5Ge5oSXot40521y7ZE1t7ezuqCQ
   CEQOQ07zC4kj/kVD7t8ArVUSZ13Wvc9S8gTdenqU110jRSlhJARsSrkDV
   EYYrBZAcDtWUZWyPIC7nAWFGzgfdMnG4kWyn4i7DspBwbFWjOCOQpNUL1
   i2YhNgVwjG762a/sGv5ad1nClUv4iLlOXOhm5P+KWzgmzDIaGpC+jxJ76
   4bRBoL4qESjMcCx/Hh09ycV5G0bbDJoXwq+h/br79CjldvTGSrw557w9T
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="395192557"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="395192557"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 04:50:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="758810961"
X-IronPort-AV: E=Sophos;i="5.95,227,1661842800"; 
   d="scan'208";a="758810961"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.88])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 04:50:45 -0700
From:   Rajat Khandelwal <rajat.khandelwal@intel.com>
To:     mika.westerberg@linux.intel.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, andreas.noever@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@intel.com>
Subject: [PATCH v2] thunderbolt: Add wake on connect/disconnect on USB4 ports
Date:   Tue,  1 Nov 2022 17:20:42 +0530
Message-Id: <20221101115042.248187-1-rajat.khandelwal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wake on connect/disconnect is only supported while runtime suspend
for now, which is obviously necessary. It is also not inherently
desired for the system to wakeup on thunderbolt/USB4 hot plug events.
However, we can still make user in control of waking up the system
in the events of hot plug/unplug.
This patch adds 'wakeup' attribute under 'usb4_portX/power' sysfs
attribute and only enables wakes on connect/disconnect to the
respective port when 'wakeup' is set to 'enabled'. The attribute
is set to 'disabled' by default.

Signed-off-by: Rajat Khandelwal <rajat.khandelwal@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---

Significant changes and reasons:
1. 'if (!port->cap_usb4)' is added under the loop in
'usb4_switch_check_wakes' function since the checks later are
explicitly targeted to the USB4 port configuration capability.
'if (!tb_port_has_remote(port))' is removed because events now can
be connection/disconnection along with USB4 events. Thus, a wake
on connection can be triggered by user on the USB4 port (initially
no remote).
2. Verified runtime wakeup. It works absolutely fine.
3. Wakeup count has to be increased in the 'wakeup_count' attribute
under usb4_port/power, thus requiring another pm_wakeup_event.

v2: Fixed version naming along with some minor grammatical fixes.

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

