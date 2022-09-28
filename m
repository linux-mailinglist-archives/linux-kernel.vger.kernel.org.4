Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C181B5EC1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiI0LxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiI0LxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:53:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F236F193B;
        Tue, 27 Sep 2022 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664279588; x=1695815588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ODLmI427IsMzWM/AOdddr0PFtw8lwBYgEBUiC5uoEEc=;
  b=BavZdWQEuXg/mx13qz/pGqHJOk+Qi8hYwgROyNZ0O8MQdTpq3LMmPJLu
   cvvaGRvmK8B6K+3xj+NA6P0UYgMClJR4bYacMxSa9HxqSLNtne4vf6soM
   9NscoG+vkkohp5xAwk+GFlUNV/n6so7JCstKCaSW7I6wgiZQtWNaWxCi9
   H4N6MJjTym7qSRtftoiYle5KofXz0zTUAYLannWjP2C11EQC77+5UGhdB
   pwThtVXfHt7ZMh7CBzveYXH9bUY3praKajI+XzLHtkPe/T6EUSTcMUEm+
   LRpXOR05zthibmK9eQY4EzNE8eh0bxJOL04j8Ew+XDBEjmNlCOUeWgW4s
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="301273099"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="301273099"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:53:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="866542843"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="866542843"
Received: from unknown (HELO rajath-NUC10i7FNH..) ([10.223.165.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 04:53:05 -0700
From:   Rajat Khandelwal <rajat.khandelwal@intel.com>
To:     mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajat Khandelwal <rajat.khandelwal@intel.com>
Subject: [PATCH v4] thunderbolt: Add wake on connect/disconnect on USB4 ports
Date:   Wed, 28 Sep 2022 17:22:30 +0530
Message-Id: <20220928115230.2031934-1-rajat.khandelwal@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Fixes in v4:
1. I don't think device_init_wakeup(&usb4->dev, false) will suffice
our purpose since it doesn't set the device wakeup capable. We need
device wakeup capable but not wakeup enabled by default. However, I
have shortened the two lines by using only one.
2. Reverse christmas format - checked.
3. Reformatting comments which are not to be included in commit.
4. Multi-line comment terminated with full stop.

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

