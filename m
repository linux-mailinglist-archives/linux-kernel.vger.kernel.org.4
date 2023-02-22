Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC6C69EC69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjBVBjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBVBjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:39:02 -0500
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7F199DF;
        Tue, 21 Feb 2023 17:39:00 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08688394|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00408143-0.000507876-0.995411;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047207;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.RTE644q_1677029937;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.RTE644q_1677029937)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 09:38:57 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: usbhid: enable remote wakeup for mice
Date:   Wed, 22 Feb 2023 09:39:44 +0800
Message-Id: <20230222013944.31095-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a problem that USB mouse can't wake up the device that
enters standby.

At present, the kernel only checks whether certain USB manufacturers
support wake-up, which will easily cause inconvenience to the
development work of other manufacturers and add unnecessary work to the
maintenance of kernel.

The USB protocol supports judging whether a usb supports the wake-up
function, so it should be more reasonable to add a wake-up source by
directly checking the settings from the USB protocol.

There was a similar issue on the keyboard before, which was fixed by
this patch (3d61510f4eca), but now the problem happened on the mouse.
This patch uses a similar idea to fix this problem.

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/hid/usbhid/hid-core.c | 8 ++++++++
 drivers/hid/usbhid/usbmouse.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index be4c731aaa65..d3a6755cca09 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
 		device_set_wakeup_enable(&dev->dev, 1);
 	}
 
+	/**
+	 * NOTE: enable remote wakeup by default for all mouse devices
+	 * supporting the boot protocol.
+	 */
+	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
+	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
+		device_set_wakeup_enable(&dev->dev, 1);
+
 	mutex_unlock(&usbhid->mutex);
 	return 0;
 
diff --git a/drivers/hid/usbhid/usbmouse.c b/drivers/hid/usbhid/usbmouse.c
index 3fd93c2e4f4a..2fbc3f49e420 100644
--- a/drivers/hid/usbhid/usbmouse.c
+++ b/drivers/hid/usbhid/usbmouse.c
@@ -188,6 +188,7 @@ static int usb_mouse_probe(struct usb_interface *intf, const struct usb_device_i
 		goto fail3;
 
 	usb_set_intfdata(intf, mouse);
+	device_set_wakeup_enable(&dev->dev, 1);
 	return 0;
 
 fail3:	
-- 
2.29.0

