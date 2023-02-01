Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2CD67B277
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbjAYMRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjAYMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:17:31 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B87715549;
        Wed, 25 Jan 2023 04:17:29 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id BEC9B2000A;
        Wed, 25 Jan 2023 12:17:26 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH v2 2/2] HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk
Date:   Wed, 25 Jan 2023 13:17:23 +0100
Message-Id: <20230125121723.3122-2-hadess@hadess.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125121723.3122-1-hadess@hadess.net>
References: <20230125121723.3122-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HIDPP_QUIRK_NO_HIDINPUT isn't used by any devices but still happens to
work as HIDPP_QUIRK_DELAYED_INIT is defined to the same value. Remove
HIDPP_QUIRK_NO_HIDINPUT and use HIDPP_QUIRK_DELAYED_INIT everywhere
instead.

Tested on a T650 which requires that quirk, and a number of unifying and
Bluetooth devices that don't.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 31d1fc23a435..ec388e436b6a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -71,7 +71,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
-#define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
+#define HIDPP_QUIRK_DELAYED_INIT		BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
 #define HIDPP_QUIRK_HIDPP_WHEELS		BIT(26)
@@ -87,8 +87,6 @@ MODULE_PARM_DESC(disable_tap_to_click,
 					 HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL | \
 					 HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL)
 
-#define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
-
 #define HIDPP_CAPABILITY_HIDPP10_BATTERY	BIT(0)
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
@@ -4001,7 +3999,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
+	if (!(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
 
@@ -4238,7 +4236,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_hw_close(hdev);
 		hid_hw_stop(hdev);
 
-		if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
+		if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 			connect_mask &= ~HID_CONNECT_HIDINPUT;
 
 		/* Now export the actual inputs and hidraw nodes to the world */
-- 
2.39.1

