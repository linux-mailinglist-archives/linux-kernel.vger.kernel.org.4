Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05831651D34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiLTJWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbiLTJWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:22:16 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E3F5F98;
        Tue, 20 Dec 2022 01:22:15 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 916B91C0005;
        Tue, 20 Dec 2022 09:22:12 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH 3/3] HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk
Date:   Tue, 20 Dec 2022 10:22:07 +0100
Message-Id: <20221220092207.428640-3-hadess@hadess.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220092207.428640-1-hadess@hadess.net>
References: <20221220092207.428640-1-hadess@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HIDPP_QUIRK_NO_HIDINPUT isn't used by any devices but still happens to
work as HIDPP_QUIRK_DELAYED_INIT is defined to the same value. Remove
HIDPP_QUIRK_NO_HIDINPUT and use HIDPP_QUIRK_DELAYED_INIT everywhere
instead.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b4e4a8c79c75..2092fb1be627 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -67,7 +67,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
-#define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
+#define HIDPP_QUIRK_DELAYED_INIT		BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
 #define HIDPP_QUIRK_HIDPP_WHEELS		BIT(26)
@@ -83,8 +83,6 @@ MODULE_PARM_DESC(disable_tap_to_click,
 					 HIDPP_CAPABILITY_HIDPP20_HI_RES_SCROLL | \
 					 HIDPP_CAPABILITY_HIDPP20_HI_RES_WHEEL)
 
-#define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
-
 #define HIDPP_CAPABILITY_HIDPP10_BATTERY	BIT(0)
 #define HIDPP_CAPABILITY_HIDPP20_BATTERY	BIT(1)
 #define HIDPP_CAPABILITY_BATTERY_MILEAGE	BIT(2)
@@ -4205,7 +4203,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->capabilities & HIDPP_CAPABILITY_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
+	if (!(hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
 
@@ -4436,7 +4434,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_hw_close(hdev);
 		hid_hw_stop(hdev);
 
-		if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
+		if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 			connect_mask &= ~HID_CONNECT_HIDINPUT;
 
 		/* Now export the actual inputs and hidraw nodes to the world */
-- 
2.38.1

