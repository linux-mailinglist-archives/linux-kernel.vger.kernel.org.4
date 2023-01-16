Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C2B66BF49
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjAPNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjAPNNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:13:36 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B542D1E5E0;
        Mon, 16 Jan 2023 05:10:34 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 7BB62E0005;
        Mon, 16 Jan 2023 13:09:38 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH] HID: logitech-hidpp: Hard-code HID++ 1.0 fast scroll support
Date:   Mon, 16 Jan 2023 14:09:37 +0100
Message-Id: <20230116130937.391441-1-hadess@hadess.net>
X-Mailer: git-send-email 2.39.0
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

HID++ 1.0 devices only export whether Fast Scrolling is enabled, not
whether they are capable of it. Reinstate the original quirks for the 3
supported mice so fast scrolling works again on those devices.

Fixes: 908d325 ("HID: logitech-hidpp: Detect hi-res scrolling support")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216903
Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index abf2c95e4d0b..fa026e9107c5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -77,6 +77,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HIDPP_WHEELS		BIT(26)
 #define HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS	BIT(27)
 #define HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS	BIT(28)
+#define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(29)
 
 /* These are just aliases for now */
 #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
@@ -3472,14 +3473,8 @@ static int hidpp_initialize_hires_scroll(struct hidpp_device *hidpp)
 			hid_dbg(hidpp->hid_dev, "Detected HID++ 2.0 hi-res scrolling\n");
 		}
 	} else {
-		struct hidpp_report response;
-
-		ret = hidpp_send_rap_command_sync(hidpp,
-						  REPORT_ID_HIDPP_SHORT,
-						  HIDPP_GET_REGISTER,
-						  HIDPP_ENABLE_FAST_SCROLL,
-						  NULL, 0, &response);
-		if (!ret) {
+		/* We cannot detect fast scrolling support on HID++ 1.0 devices */
+		if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) {
 			hidpp->capabilities |= HIDPP_CAPABILITY_HIDPP10_FAST_SCROLL;
 			hid_dbg(hidpp->hid_dev, "Detected HID++ 1.0 fast scroll\n");
 		}
@@ -4296,9 +4291,15 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	{ /* Mouse Logitech Anywhere MX */
+	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Mouse logitech M560 */
 	  LDJ_DEVICE(0x402d),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
+	{ /* Mouse Logitech M705 (firmware RQM17) */
+	  LDJ_DEVICE(0x101b), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	{ /* Mouse Logitech Performance MX */
+	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
 	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
-- 
2.39.0

