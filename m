Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67986523E1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiLTPoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiLTPny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:43:54 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CF714D1E;
        Tue, 20 Dec 2022 07:43:51 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 601FE240009;
        Tue, 20 Dec 2022 15:43:48 +0000 (UTC)
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: [PATCH v2 2/3] HID: logitech-hidpp: Don't restart communication if not necessary
Date:   Tue, 20 Dec 2022 16:43:44 +0100
Message-Id: <20221220154345.474596-2-hadess@hadess.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221220154345.474596-1-hadess@hadess.net>
References: <20221220154345.474596-1-hadess@hadess.net>
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

Don't stop and restart communication with the device unless we need to
modify the connect flags used because of a device quirk.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-logitech-hidpp.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7f9187201913..b4e4a8c79c75 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4310,6 +4310,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	bool connected;
 	unsigned int connect_mask = HID_CONNECT_DEFAULT;
 	struct hidpp_ff_private_data data;
+	bool will_restart = false;
 
 	/* report_fixup needs drvdata to be set before we call hid_parse */
 	hidpp = devm_kzalloc(&hdev->dev, sizeof(*hidpp), GFP_KERNEL);
@@ -4360,6 +4361,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			return ret;
 	}
 
+	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
+		will_restart = true;
+
 	INIT_WORK(&hidpp->work, delayed_work_cb);
 	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
@@ -4374,7 +4378,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 * Plain USB connections need to actually call start and open
 	 * on the transport driver to allow incoming data.
 	 */
-	ret = hid_hw_start(hdev, 0);
+	ret = hid_hw_start(hdev, will_restart ? 0 : connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
 		goto hid_hw_start_fail;
@@ -4411,6 +4415,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			hidpp->wireless_feature_index = 0;
 		else if (ret)
 			goto hid_hw_init_fail;
+		ret = 0;
 	}
 
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
@@ -4425,19 +4430,21 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	hidpp_connect_event(hidpp);
 
-	/* Reset the HID node state */
-	hid_device_io_stop(hdev);
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
+	if (will_restart) {
+		/* Reset the HID node state */
+		hid_device_io_stop(hdev);
+		hid_hw_close(hdev);
+		hid_hw_stop(hdev);
 
-	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
-		connect_mask &= ~HID_CONNECT_HIDINPUT;
+		if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
+			connect_mask &= ~HID_CONNECT_HIDINPUT;
 
-	/* Now export the actual inputs and hidraw nodes to the world */
-	ret = hid_hw_start(hdev, connect_mask);
-	if (ret) {
-		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
-		goto hid_hw_start_fail;
+		/* Now export the actual inputs and hidraw nodes to the world */
+		ret = hid_hw_start(hdev, connect_mask);
+		if (ret) {
+			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
+			goto hid_hw_start_fail;
+		}
 	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-- 
2.38.1

