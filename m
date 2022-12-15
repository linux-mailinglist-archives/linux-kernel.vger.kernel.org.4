Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D01764DDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLOPoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiLOPoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:44:21 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F300E01E;
        Thu, 15 Dec 2022 07:44:20 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D1C4E000C;
        Thu, 15 Dec 2022 15:44:16 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH] HID: logitech-hidpp: Guard FF init code against non-USB devices
Date:   Thu, 15 Dec 2022 16:44:16 +0100
Message-Id: <20221215154416.111704-1-hadess@hadess.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Force Feedback code assumes that all the devices passed to it will
be USB devices, but that might not be the case for emulated devices.
Guard against a crash by checking the device type before poking at USB
properties.

Reported-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7075c887ec50..08ad19097e9e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2746,12 +2746,17 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	struct hid_device *hid = hidpp->hid_dev;
 	struct hid_input *hidinput;
 	struct input_dev *dev;
-	const struct usb_device_descriptor *udesc = &(hid_to_usb_dev(hid)->descriptor);
-	const u16 bcdDevice = le16_to_cpu(udesc->bcdDevice);
+	struct usb_device_descriptor *udesc;
+	u16 bcdDevice;
 	struct ff_device *ff;
 	int error, j, num_slots = data->num_effects;
 	u8 version;
 
+	if (!hid_is_usb(hid)) {
+		hid_err(hid, "device is not USB\n");
+		return -ENODEV;
+	}
+
 	if (list_empty(&hid->inputs)) {
 		hid_err(hid, "no inputs found\n");
 		return -ENODEV;
@@ -2765,6 +2770,8 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	}
 
 	/* Get firmware release */
+	udesc = &(hid_to_usb_dev(hid)->descriptor);
+	bcdDevice = le16_to_cpu(udesc->bcdDevice);
 	version = bcdDevice & 255;
 
 	/* Set supported force feedback capabilities */
-- 
2.38.1

