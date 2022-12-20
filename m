Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609B46523DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiLTPn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiLTPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:43:52 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C689E1838D;
        Tue, 20 Dec 2022 07:43:50 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id B098024000A;
        Tue, 20 Dec 2022 15:43:45 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH v2 1/3] Revert "HID: logitech-hidpp: add a module parameter to keep firmware gestures"
Date:   Tue, 20 Dec 2022 16:43:43 +0100
Message-Id: <20221220154345.474596-1-hadess@hadess.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we're in 2022, and the majority of desktop environments can and
should support touchpad gestures through libinput, remove the legacy
module parameter that made it possible to use gestures implemented in
firmware.

This will eventually allow simplifying the driver's initialisation code.

This reverts commit 9188dbaed68a4b23dc96eba165265c08caa7dc2a.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 08ad19097e9e..7f9187201913 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -32,11 +32,6 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
 MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
 
-static bool disable_raw_mode;
-module_param(disable_raw_mode, bool, 0644);
-MODULE_PARM_DESC(disable_raw_mode,
-	"Disable Raw mode reporting for touchpads and keep firmware gestures.");
-
 static bool disable_tap_to_click;
 module_param(disable_tap_to_click, bool, 0644);
 MODULE_PARM_DESC(disable_tap_to_click,
@@ -4355,11 +4350,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	    hidpp_application_equals(hdev, HID_GD_KEYBOARD))
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS;
 
-	if (disable_raw_mode) {
-		hidpp->quirks &= ~HIDPP_QUIRK_CLASS_WTP;
-		hidpp->quirks &= ~HIDPP_QUIRK_NO_HIDINPUT;
-	}
-
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP) {
 		ret = wtp_allocate(hdev, id);
 		if (ret)
-- 
2.38.1

