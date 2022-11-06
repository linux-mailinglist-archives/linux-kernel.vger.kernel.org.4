Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD85B61E6C0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiKFV5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKFV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:57:43 -0500
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Nov 2022 13:57:41 PST
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2A111C
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 13:57:41 -0800 (PST)
Received: from robin.home.jannau.net (p54acc2ba.dip0.t-ipconnect.de [84.172.194.186])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 1CEBC26F2E4;
        Sun,  6 Nov 2022 22:48:05 +0100 (CET)
From:   Janne Grunau <j@jannau.net>
To:     linux-usb@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.de>, stable@kernel.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb: dwc3: Do not get extcon device when usb-role-switch is used
Date:   Sun,  6 Nov 2022 22:48:04 +0100
Message-Id: <20221106214804.2814-1-j@jannau.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change breaks device tree based platforms with PHY device and use
usb-role-switch instead of an extcon switch. extcon_find_edev_by_node()
will return EPROBE_DEFER if it can not find a device so probing without
an extcon device will be deferred indefinitely. Fix this by
explicitly checking for usb-role-switch.
At least the out-of-tree USB3 support on Apple silicon based platforms
using dwc3 with tipd USB Type-C and PD controller is affected by this
issue.

Fixes: d182c2e1bc92 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
Cc: stable@kernel.org
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/usb/dwc3/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c0e7c76dc5c8..1f348bc867c2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1710,6 +1710,16 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
 		return extcon_get_extcon_dev(name);
 
+	/*
+	 * Check explicitly if "usb-role-switch" is used since
+	 * extcon_find_edev_by_node() can not be used to check the absence of
+	 * an extcon device. In the absence of an device it will always return
+	 * EPROBE_DEFER.
+	 */
+	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
+	    device_property_read_bool(dev, "usb-role-switch"))
+		return NULL;
+
 	/*
 	 * Try to get an extcon device from the USB PHY controller's "port"
 	 * node. Check if it has the "port" node first, to avoid printing the
-- 
2.37.3

