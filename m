Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE60668E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241051AbjAMG7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjAMG47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:56:59 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A454F81C26;
        Thu, 12 Jan 2023 22:42:28 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(2734:0:AUTH_RELAY)
        (envelope-from <prvs=1372DA5DC2=cy_huang@richtek.com>); Fri, 13 Jan 2023 14:23:39 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(16476:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 13 Jan 2023 14:17:48 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 13 Jan
 2023 14:17:47 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 13 Jan 2023 14:17:47 +0800
From:   <cy_huang@richtek.com>
To:     <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <alina_yu@richtek.com>, <cy_huang@richtek.com>,
        <u0084500@gmail.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v8 3/3] Documentation: power: rt9471: Document exported sysfs entries
Date:   Fri, 13 Jan 2023 14:17:46 +0800
Message-ID: <1673590666-24618-4-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673590666-24618-1-git-send-email-cy_huang@richtek.com>
References: <1673590666-24618-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Document the settings exported by rt9471 charger driver through sysfs entries:
- sysoff_enable
- port_detect_enable

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v6:
- Explain more details for sysoff_enable attribute.

Since v5:
- Recover all the change in sysfs-class-power.
- New a sysfs-class-power-rt9471 file.
- Remove 'charge_term_enable' sysfs entry, directly integrate it in
  'charge_term_current' power supply property control.

---
 Documentation/ABI/testing/sysfs-class-power-rt9471 | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471

diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
new file mode 100644
index 00000000..38227a8
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
@@ -0,0 +1,32 @@
+What:		/sys/class/power_supply/rt9471-*/sysoff_enable
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the sysoff mode of rt9471 charger devices.
+		If enabled and the input is removed, the internal battery FET is turned
+		off to reduce the leakage from the BAT pin. See device datasheet for details.
+		It's commonly used when the product enter shipping stage. After entering
+		shipping mode, only 'VBUS' or 'Power key" pressed can make it leave this
+		mode. 'Disable' also can help to leave it, but it's more like to abort
+		the action before the device really enter shipping mode.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
+What:		/sys/class/power_supply/rt9471-*/port_detect_enable
+Date:		Oct 2022
+KernelVersion:	6.1
+Contact:	ChiYuan Huang <cy_huang@richtek.com>
+Description:
+		This entry allows enabling the USB BC12 port detect function of rt9471 charger
+		devices. If enabled and VBUS is inserted, device will start to do the BC12
+		port detect and report the usb port type when port detect is done. See
+		datasheet for details. Normally controlled when TypeC/USBPD port integrated.
+
+		Access: Read, Write
+		Valid values:
+		- 1: enabled
+		- 0: disabled
-- 
2.7.4

