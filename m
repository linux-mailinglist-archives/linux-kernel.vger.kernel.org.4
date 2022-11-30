Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C580463D557
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiK3MQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3MQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:16:39 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC62B600;
        Wed, 30 Nov 2022 04:16:38 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id B84EDF5D85;
        Wed, 30 Nov 2022 04:16:07 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Nl2cF25mKZO5; Wed, 30 Nov 2022 04:16:06 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1669810566; bh=XfQt2gqNGwqTBmezWa2hrCNNLvlXxzmo4l3Y1L8uyqY=;
        h=From:To:Cc:Subject:Date:From;
        b=HZu8T6F6Wbj9H8NlWoGXQ2Znl+AA/k3uR+zDLGnWC4pwM9k15ignOq3mfPUoZh2f7
         Z1AnTIp09I203/ELknoEAAjrBGDLKjavWU9J8ED0pbKow44NklS8xwQuSd8w30fmWa
         mhUZgyRJi7R7YJAEJflIEYzsLP7of46CM8eOJXs4NFKulJJEYvmm1rnExI92Av/WTt
         XhCp1nZrHLAv6R6iC5leDKw/KxAYdUi44n5R6MJz0mC/xRV2NKL6Z+kig2Y3iRfM2x
         flENVdK4aQnzAx+FXGZayZPVJzXacRzYDt/CJv4NEkZ5LyZur2kVNq0F6bo+yNf/K/
         cPyveGWxpy3TA==
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [RFC v1] hack: suspend: usb: option: add reset_resume callback
Date:   Wed, 30 Nov 2022 13:15:52 +0100
Message-Id: <20221130121552.1560379-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently to be the same as resume(). This will just avoid re-enumeration
of the modem device on every system resume.

This exists only because the usb core will re-enumerate *any* device
whos' driver doesn't have reset_resume() implemented. A call trace:

Jun 23 11:15:43 pureos kernel:  usb_serial_disconnect+0x58/0x180 [usbserial]
Jun 23 11:15:43 pureos kernel:  usb_unbind_interface+0x84/0x290 [usbcore]
Jun 23 11:15:43 pureos kernel:  device_remove+0x78/0x90
Jun 23 11:15:43 pureos kernel:  device_release_driver_internal+0x1e4/0x250
Jun 23 11:15:43 pureos kernel:  device_release_driver+0x24/0x30
Jun 23 11:15:43 pureos kernel:  usb_forced_unbind_intf+0xac/0xd4 [usbcore]
Jun 23 11:15:43 pureos kernel:  unbind_marked_interfaces.isra.0+0x5c/0x80 [usbcore]
Jun 23 11:15:43 pureos kernel:  usb_resume+0x78/0x8c [usbcore]
Jun 23 11:15:43 pureos kernel:  usb_dev_resume+0x20/0x30 [usbcore]
Jun 23 11:15:43 pureos kernel:  dpm_run_callback+0x60/0x1f0
Jun 23 11:15:43 pureos kernel:  device_resume+0x9c/0x1f4

where usb_resume_inteface() sets needs_binding here
https://elixir.bootlin.com/linux/latest/source/drivers/usb/core/driver.c#L1353
because of no reset_resume() implementation.

This hack is even suggested in some modems' application notes as can
be found in discussion here
https://invent.kde.org/teams/plasma-mobile/issues/-/issues/3#note_218386

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/usb/serial/option.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index dee79c7d82d5..58526bf8684d 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -46,6 +46,7 @@ static int  option_probe(struct usb_serial *serial,
 static int option_attach(struct usb_serial *serial);
 static void option_release(struct usb_serial *serial);
 static void option_instat_callback(struct urb *urb);
+static int option_reset_resume(struct usb_serial *serial);
 
 /* Vendor and product IDs */
 #define OPTION_VENDOR_ID			0x0AF0
@@ -2227,6 +2228,7 @@ static struct usb_serial_driver option_1port_device = {
 #ifdef CONFIG_PM
 	.suspend           = usb_wwan_suspend,
 	.resume            = usb_wwan_resume,
+	.reset_resume      = option_reset_resume,
 #endif
 };
 
@@ -2373,6 +2375,18 @@ static void option_instat_callback(struct urb *urb)
 	}
 }
 
+static int option_reset_resume(struct usb_serial *serial)
+{
+	/*
+	 * We simply call resume() because this implementation only
+	 * exists because the USB core will un- and rebind any driver
+	 * during system resume that does *not* have a reset_resume()
+	 * implementation; see usb_resume_interface() in core/driver.c
+	 * We want to avoid that unconditional removal/addition.
+	 */
+	return usb_wwan_resume(serial);
+}
+
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL v2");
-- 
2.30.2

