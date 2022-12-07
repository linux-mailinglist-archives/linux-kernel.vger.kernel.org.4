Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692B7645AA5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiLGNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiLGNTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:19:47 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25894140BC;
        Wed,  7 Dec 2022 05:19:45 -0800 (PST)
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C29E8240004;
        Wed,  7 Dec 2022 13:19:42 +0000 (UTC)
From:   Quentin Schulz <foss+kernel@0leil.net>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 2/3] usb: dwc2: power on/off phy for peripheral mode in dual-role mode
Date:   Wed,  7 Dec 2022 14:19:17 +0100
Message-Id: <20221206-dwc2-gadget-dual-role-v1-2-36515e1092cd@theobroma-systems.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.1
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

The PHY power is handled for peripheral mode but only when the device is
forced into this peripheral mode. It is missing when the device is
operating in peripheral mode when dual-role mode is enabled, so let's
update the condition to match this scenario.

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/usb/dwc2/gadget.c   | 6 ++++--
 drivers/usb/dwc2/platform.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 8b15742d9e8aa..62fa6378d2d73 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -4549,7 +4549,8 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
 	hsotg->gadget.dev.of_node = hsotg->dev->of_node;
 	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
 
-	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL) {
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
+	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg))) {
 		ret = dwc2_lowlevel_hw_enable(hsotg);
 		if (ret)
 			goto err;
@@ -4611,7 +4612,8 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
 	if (!IS_ERR_OR_NULL(hsotg->uphy))
 		otg_set_peripheral(hsotg->uphy->otg, NULL);
 
-	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
+	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)))
 		dwc2_lowlevel_hw_disable(hsotg);
 
 	return 0;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ec4ace0107f5f..1d4f1ba22b92a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -576,7 +576,8 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	dwc2_debugfs_init(hsotg);
 
 	/* Gadget code manages lowlevel hw on its own */
-	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
+	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)))
 		dwc2_lowlevel_hw_disable(hsotg);
 
 #if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \

-- 
b4 0.10.1
